Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F4AC98328
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 06:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB4TB-0004OV-9K; Mon, 28 Sep 2026 02:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xB4Sz-0004Mg-KF
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:04:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xB4Sw-0003w4-11
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 02:03:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790575431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H6LrWEvTlqKW8tt7imdZdl+NzRhl2ovl7PXVR29UL5E=;
 b=clCBqtxt/1jaWHtRTy7r1/Yx/dVr4mKt0pnhN9SUOHvuqUIwXFQZYnObCi8+HB4aRLgLYo
 kqlcrW3gei71prmpLyMHd2d0Jk5B62XV9viwb40A6MqvscC1g4166F1NoyE9BbFtGy5EDp
 Y1KEieuo9Q4JIdDUVLvM98qHToQbAMw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-658-l049CIy-PsKX7xvLsEFu1w-1; Mon,
 28 Sep 2026 02:03:48 -0400
X-MC-Unique: l049CIy-PsKX7xvLsEFu1w-1
X-Mimecast-MFC-AGG-ID: l049CIy-PsKX7xvLsEFu1w_1790575426
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6957F1955F29; Mon, 28 Sep 2026 06:03:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 507D430001A2; Mon, 28 Sep 2026 06:03:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E112621E6A04; Mon, 28 Sep 2026 08:03:42 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Michael Roth <michael.roth@amd.com>
Cc: <qemu-devel@nongnu.org>,  <david@kernel.org>,  <pbonzini@redhat.com>,
 <peterx@redhat.com>,  <xiaoyao.li@intel.com>,  <berrange@redhat.com>,
 <pankaj.gupta@amd.com>,  <chao.p.peng@linux.intel.com>,  Fabiano Rosas
 <farosas@suse.de>
Subject: Re: [PATCH v6 10/12] hostmem: Support fully shared guest memfd to
 back a VM
In-Reply-To: <20260925015700.1260501-11-michael.roth@amd.com> (Michael Roth's
 message of "Thu, 24 Sep 2026 20:43:16 -0500")
References: <20260925015700.1260501-1-michael.roth@amd.com>
 <20260925015700.1260501-11-michael.roth@amd.com>
Date: Mon, 28 Sep 2026 08:03:42 +0200
Message-ID: <87fqytkj41.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Michael Roth <michael.roth@amd.com> writes:

> From: Peter Xu <peterx@redhat.com>
>
> Host backends supports guest-memfd now by detecting whether it's a
> confidential VM.  There's no way to choose it yet from the memory level to
> use it fully shared.  If we use guest-memfd, it so far always implies we
> need two layers of memory backends, while the guest-memfd only provides the
> private set of pages.
>
> This patch introduces a way so that QEMU can consume guest memfd as the
> only source of memory to back the object (aka, fully shared).
>
> To use the fully shared guest-memfd, one can add a memfd object with:
>
>   -object memory-backend-memfd,x-guest-memfd=on,share=on
>
> Note that share=on is required with fully shared guest_memfd.
>
> Since guest-memfd is not yet a drop-in replacement for memfd (e.g. lack
> of hugepage support), the option is tagged as experimental for now so
> that it can be made available for early enablement/testing without
> causing any surprises for other users.
>
> PS: there's a trivial touch-up on fd<0 check, because the stub to create
> guest-memfd may return negative but not -1.
>
> Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: David Hildenbrand <david@kernel.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [mdr: add accompanying guest-memfd doc, mark as experimental]
> Co-developed-by: Michael Roth <michael.roth@amd.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>

[...]

> diff --git a/docs/system/guest-memfd.rst b/docs/system/guest-memfd.rst
> new file mode 100644
> index 0000000000..f7cef19283
> --- /dev/null
> +++ b/docs/system/guest-memfd.rst
> @@ -0,0 +1,60 @@
> +.. _guest-memfd:
> +
> +guest-memfd support
> +===================
> +
> +Recent kernels allow for the creation of a guest-memfd file
> +descriptor, which can be used to back VMs in a similar manner as a
> +memfd file descriptor, but is intended specifically for this purpose
> +and allows for closer coordination between KVM and the management of
> +this memory to enable more advanced/VM-specific use-cases.
> +
> +Initially this additional functionality centered around providing a
> +common/centralized place for managing kernel-side memory handing
> +requirements for various Confidential Guest architectures. (For more
> +on Confidential Guests, see :ref:`confidential-guest-support`).
> +
> +guest_memfd has since evolved to become a more general-purpose way to
> +allocate/manage guest memory and potentially allow for things like
> +providing additional memory isolation within the kernel[1] and support
> +for persisting a guest's state across kexec to allow for live-updating
> +the host kernel with minimal guest downtime[2].
> +
> +Usage
> +-----
> +
> +For Confidential Guests, guest-memfd is currently utilized internally
> +by QEMU to handle private guest memory, independently of whatever
> +memory backend the user has configured for normal/non-private/shared
> +guest memory. To avoid doubling memory, QEMU discards memory in
> +response to the guest converting GPA ranges between shared/private.
> +(e.g. if GPA X is converted from private to shared, the guest-memfd FD
> +offset corresponding to GPA x will be truncated since the memory will
> +be provided by the memory backend the user configured for shared
> +memory, and vice-versa). This is handled automatically/internally for
> +Confidential Guests that rely on this handling and is not directly
> +exposed by QEMU command-line options.
> +
> +For non-Confidential guests, guest-memfd can be used in a manner that
> +is somewhat interchangeable with a normal memfd. Currently, this is
> +handled by using the same memory-backend implementation as memfd, but
> +with an additional 'x-guest-memfd=on' option. E.g.::
> +
> +    qemu ... \
> +      -object memory-backend-memfd,id=ID,size=SIZE,share=on,x-guest-memfd=on
> +
> +Note that the share=on option is required for guest-memfd, since it
> +does not support anonymous memory allocations or COW-like semantics.
> +
> +Also note that there are a couple of limitations in using guest_memfd
> +in this way compared to a normal memfd, which is why the option is
> +exposed as an experimental for the time being:
> +
> + * guest_memfd does not currently support the hugetlb=on option
> + * guest_memfd does not currently support Transparent Huge Pages
> +
> +References
> +----------
> +
> +- `[1] directmap removal <https://lore.kernel.org/kvm/20260317141031.514-1-kalyazin@amazon.com/>`__
> +- `[2] LUO <https://lore.kernel.org/kvm/20260728121138.1103610-1-tarunsahu@google.com/>`__

This is helpful, thanks.

> diff --git a/docs/system/index.rst b/docs/system/index.rst
> index 4509630fa4..060850a739 100644
> --- a/docs/system/index.rst
> +++ b/docs/system/index.rst
> @@ -44,3 +44,4 @@ or Hypervisor.Framework.
>     vm-templating
>     sriov
>     qemu-colo
> +   guest-memfd
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 5895c97750..602b17ad83 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -780,13 +780,18 @@
>  # @seal: if true, create a sealed-file, which will block further
>  #     resizing of the memory (default: true)
>  #
> +# @x-guest-memfd: if 'on', use guest-memfd to back the memory region.
> +#     See the "guest-memfd" QEMU documentation for more details.

Can you make this a link?  Try :doc:`/system/guest-memfd`.

> +#     (default: auto, since: 11.2)

What does 'auto' mean?

> +#
>  # Since: 2.12
>  ##
>  { 'struct': 'MemoryBackendMemfdProperties',
>    'base': 'MemoryBackendProperties',
>    'data': { '*hugetlb': 'bool',
>              '*hugetlbsize': 'size',
> -            '*seal': 'bool' },
> +            '*seal': 'bool',
> +            '*x-guest-memfd': 'OnOffAuto' },

You forgot to mark the member unstable.  Use
 
               { 'name': 'x-guest-memfd', 'features': [ 'unstable' ] }

This will make the generator demand documentation.  Add this

   # Features:
   #
   # @unstable: Member @x-guest-memfd is experimental.

between the member descriptions and "Since:".

The 'x-' name prefix is fine, but not required; the feature is the sole
source of truth.  The prefix can serve as an additional signal to human
users.  Drawback: you have to rename when the member becomes stable.  Up
to you.

>    'if': 'CONFIG_LINUX' }
>  
>  ##


