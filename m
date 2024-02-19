Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B7AC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 12:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc39F-0001Ms-Mb; Mon, 19 Feb 2024 07:53:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc39F-0001Mj-6k
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:53:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc39D-0008Fw-Gw
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 07:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708347206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rwp3K/tyco+S6GkYgXqIwUdNod+B1L1KCDzaUWv/qBs=;
 b=VBkxTBkCSWxtPD9xv808zBkVQgGPcW4XmuzY+Ev8o1Uab05eq+exlGzUmV1cZ0kxBQRE6z
 lc0XoDeKqTCgJXfSfxfP+oi6KzraEY0pSNnYHH75dy/yxm0lN/s0y9SoBXWbjniQeIFNBq
 8Ofcbj7d1NKJgk1DBeaTeQVCgL/JQxQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-qI0YPT1hMNmUgpg2-n1b2w-1; Mon, 19 Feb 2024 07:53:21 -0500
X-MC-Unique: qI0YPT1hMNmUgpg2-n1b2w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B017185A780;
 Mon, 19 Feb 2024 12:53:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D6B0B8077;
 Mon, 19 Feb 2024 12:53:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C84F221E66D0; Mon, 19 Feb 2024 13:53:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  David Hildenbrand
 <david@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  "Michael S .
 Tsirkin" <mst@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Marcelo Tosatti
 <mtosatti@redhat.com>,  qemu-devel@nongnu.org,  kvm@vger.kernel.org,
 Michael Roth <michael.roth@amd.com>,  Sean Christopherson
 <seanjc@google.com>,  Claudio Fontana <cfontana@suse.de>,  Gerd Hoffmann
 <kraxel@redhat.com>,  Isaku Yamahata <isaku.yamahata@gmail.com>,  Chenyi
 Qiang <chenyi.qiang@intel.com>
Subject: Re: [PATCH v4 53/66] i386/tdx: Wire TDX_REPORT_FATAL_ERROR with
 GuestPanic facility
In-Reply-To: <20240125032328.2522472-54-xiaoyao.li@intel.com> (Xiaoyao Li's
 message of "Wed, 24 Jan 2024 22:23:15 -0500")
References: <20240125032328.2522472-1-xiaoyao.li@intel.com>
 <20240125032328.2522472-54-xiaoyao.li@intel.com>
Date: Mon, 19 Feb 2024 13:53:19 +0100
Message-ID: <87v86kehts.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> Integrate TDX's TDX_REPORT_FATAL_ERROR into QEMU GuestPanic facility
>
> Originated-from: Isaku Yamahata <isaku.yamahata@intel.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
> Changes in v4:
> - refine the documentation; (Markus)
>
> Changes in v3:
> - Add docmentation of new type and struct; (Daniel)
> - refine the error message handling; (Daniel)
> ---
>  qapi/run-state.json   | 28 ++++++++++++++++++++--
>  system/runstate.c     | 54 +++++++++++++++++++++++++++++++++++++++++++
>  target/i386/kvm/tdx.c | 24 ++++++++++++++++++-
>  3 files changed, 103 insertions(+), 3 deletions(-)
>
> diff --git a/qapi/run-state.json b/qapi/run-state.json
> index 08bc99cb8561..5429116679e3 100644
> --- a/qapi/run-state.json
> +++ b/qapi/run-state.json
> @@ -485,10 +485,12 @@
>  #
>  # @s390: s390 guest panic information type (Since: 2.12)
>  #
> +# @tdx: tdx guest panic information type (Since: 8.2)
> +#
>  # Since: 2.9
>  ##
>  { 'enum': 'GuestPanicInformationType',
> -  'data': [ 'hyper-v', 's390' ] }
> +  'data': [ 'hyper-v', 's390', 'tdx' ] }
>  
>  ##
>  # @GuestPanicInformation:
> @@ -503,7 +505,8 @@
>   'base': {'type': 'GuestPanicInformationType'},
>   'discriminator': 'type',
>   'data': {'hyper-v': 'GuestPanicInformationHyperV',
> -          's390': 'GuestPanicInformationS390'}}
> +          's390': 'GuestPanicInformationS390',
> +          'tdx' : 'GuestPanicInformationTdx'}}
>  
>  ##
>  # @GuestPanicInformationHyperV:
> @@ -566,6 +569,27 @@
>            'psw-addr': 'uint64',
>            'reason': 'S390CrashReason'}}
>  
> +##
> +# @GuestPanicInformationTdx:
> +#
> +# TDX Guest panic information specific to TDX GCHI
> +# TDG.VP.VMCALL<ReportFatalError>.
> +#
> +# @error-code: TD-specific error code

Where could a user find information on these error codes?

> +#
> +# @gpa: guest-physical address of a page that contains additional
> +#     error data, in forms of zero-terminated string.

"in the form of a zero-terminated string"

> +#
> +# @message: Human-readable error message provided by the guest. Not
> +#     to be trusted.

How is this message related to the one pointed to by @gpa?

> +#
> +# Since: 9.0
> +##
> +{'struct': 'GuestPanicInformationTdx',
> + 'data': {'error-code': 'uint64',
> +          'gpa': 'uint64',
> +          'message': 'str'}}
> +
>  ##
>  # @MEMORY_FAILURE:
>  #

[...]


