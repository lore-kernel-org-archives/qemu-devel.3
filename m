Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D4AC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 12:00:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4fxX-0002hF-SG; Wed, 08 May 2024 07:59:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s4fxV-0002gY-LR
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:59:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s4fxT-0008Qs-Nr
 for qemu-devel@nongnu.org; Wed, 08 May 2024 07:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715169578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RmJxN7uLNMspGXWgcrcYl/7ykcJCV/ASwoMUP1mv0MM=;
 b=NoI7vjyYwD/HtJkpSUlK4Lc4Hg5yAmcxcug70gkQb++KeEtyIe2xj1ACHq14W5YzrmNAx+
 37GTWqMRr8p19L6WiIEoQ9X/Ss1eFZtfJkqSHSRsSP8zZP9Ntzmr0O+ptdjr4hlEpVrUKE
 7eGghDBW9ITI6hzJX4u83QNFV4TVOBw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-2mQfZmnRML6SYryWWwQOaQ-1; Wed,
 08 May 2024 07:59:35 -0400
X-MC-Unique: 2mQfZmnRML6SYryWWwQOaQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EF0029ABA12;
 Wed,  8 May 2024 11:59:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1E1301000DB9;
 Wed,  8 May 2024 11:59:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 222E521E6811; Wed,  8 May 2024 13:59:33 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,  Jason Wang <jasowang@redhat.com>,  Coiby Xu
 <Coiby.Xu@gmail.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Gerd
 Hoffmann <kraxel@redhat.com>,  slp@redhat.com,  Philippe =?utf-8?Q?Mathie?=
 =?utf-8?Q?u-Daud=C3=A9?=
 <philmd@linaro.org>,  Brad Smith <brad@comstyle.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Thomas Huth <thuth@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Kevin Wolf <kwolf@redhat.com>,  Raphael Norwitz
 <raphael@enfabrica.net>,  gmaglione@redhat.com,  Laurent Vivier
 <lvivier@redhat.com>,  stefanha@redhat.com,  David Hildenbrand
 <david@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  "Michael S.
 Tsirkin" <mst@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v4 10/12] hostmem: add a new memory backend based on
 POSIX shm_open()
In-Reply-To: <20240508074457.12367-11-sgarzare@redhat.com> (Stefano
 Garzarella's message of "Wed, 8 May 2024 09:44:54 +0200")
References: <20240508074457.12367-1-sgarzare@redhat.com>
 <20240508074457.12367-11-sgarzare@redhat.com>
Date: Wed, 08 May 2024 13:59:33 +0200
Message-ID: <87y18kcy56.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.582,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Stefano Garzarella <sgarzare@redhat.com> writes:

> shm_open() creates and opens a new POSIX shared memory object.
> A POSIX shared memory object allows creating memory backend with an
> associated file descriptor that can be shared with external processes
> (e.g. vhost-user).
>
> The new `memory-backend-shm` can be used as an alternative when
> `memory-backend-memfd` is not available (Linux only), since shm_open()
> should be provided by any POSIX-compliant operating system.
>
> This backend mimics memfd, allocating memory that is practically
> anonymous. In theory shm_open() requires a name, but this is allocated
> for a short time interval and shm_unlink() is called right after
> shm_open(). After that, only fd is shared with external processes
> (e.g., vhost-user) as if it were associated with anonymous memory.
>
> In the future we may also allow the user to specify the name to be
> passed to shm_open(), but for now we keep the backend simple, mimicking
> anonymous memory such as memfd.
>
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> v4
> - fail if we find "share=off" in shm_backend_memory_alloc() [David]
> v3
> - enriched commit message and documentation to highlight that we
>   want to mimic memfd (David)
> ---
>  docs/system/devices/vhost-user.rst |   5 +-
>  qapi/qom.json                      |  17 ++++
>  backends/hostmem-shm.c             | 123 +++++++++++++++++++++++++++++
>  backends/meson.build               |   1 +
>  qemu-options.hx                    |  13 +++
>  5 files changed, 157 insertions(+), 2 deletions(-)
>  create mode 100644 backends/hostmem-shm.c
>
> diff --git a/docs/system/devices/vhost-user.rst b/docs/system/devices/vhost-user.rst
> index 9b2da106ce..35259d8ec7 100644
> --- a/docs/system/devices/vhost-user.rst
> +++ b/docs/system/devices/vhost-user.rst
> @@ -98,8 +98,9 @@ Shared memory object
>  
>  In order for the daemon to access the VirtIO queues to process the
>  requests it needs access to the guest's address space. This is
> -achieved via the ``memory-backend-file`` or ``memory-backend-memfd``
> -objects. A reference to a file-descriptor which can access this object
> +achieved via the ``memory-backend-file``, ``memory-backend-memfd``, or
> +``memory-backend-shm`` objects.
> +A reference to a file-descriptor which can access this object
>  will be passed via the socket as part of the protocol negotiation.
>  
>  Currently the shared memory object needs to match the size of the main
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 38dde6d785..52df052df8 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -721,6 +721,19 @@
>              '*hugetlbsize': 'size',
>              '*seal': 'bool' } }
>  
> +##
> +# @MemoryBackendShmProperties:
> +#
> +# Properties for memory-backend-shm objects.
> +#
> +# The @share boolean option is true by default with shm.

This contradicts the doc comment for @share:

   # @share: if false, the memory is private to QEMU; if true, it is
   #     shared (default: false)

Your intention is to override that text.  But that's less than clear.
Moreover, the documentation of @share is pretty far from this override.
John Snow is working on patches that'll pull it closer.

Hmm, MemoryBackendMemfdProperties has the same override.

I think we should change the doc comment for @share to something like

   # @share: if false, the memory is private to QEMU; if true, it is
   #     shared (default depends on the backend type)

and then document the actual default with each backend type.

> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'MemoryBackendShmProperties',
> +  'base': 'MemoryBackendProperties',
> +  'data': { } }

Let's add 'if': 'CONFIG_POSIX' here.

> +
>  ##
>  # @MemoryBackendEpcProperties:
>  #
> @@ -985,6 +998,8 @@
>      { 'name': 'memory-backend-memfd',
>        'if': 'CONFIG_LINUX' },
>      'memory-backend-ram',
> +    { 'name': 'memory-backend-shm',
> +      'if': 'CONFIG_POSIX' },
>      'pef-guest',
>      { 'name': 'pr-manager-helper',
>        'if': 'CONFIG_LINUX' },
> @@ -1056,6 +1071,8 @@
>        'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
>                                        'if': 'CONFIG_LINUX' },
>        'memory-backend-ram':         'MemoryBackendProperties',
> +      'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
> +                                      'if': 'CONFIG_POSIX' },
>        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
>                                        'if': 'CONFIG_LINUX' },
>        'qtest':                      'QtestProperties',

[...]

> diff --git a/qemu-options.hx b/qemu-options.hx
> index cf61f6b863..2226172fb0 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -5227,6 +5227,19 @@ SRST
>  
>          The ``share`` boolean option is on by default with memfd.
>  
> +    ``-object memory-backend-shm,id=id,merge=on|off,dump=on|off,share=on|off,prealloc=on|off,size=size,host-nodes=host-nodes,policy=default|preferred|bind|interleave``
> +        Creates a POSIX shared memory backend object, which allows
> +        QEMU to share the memory with an external process (e.g. when
> +        using vhost-user). This backend mimics memfd, allocating memory that is
> +        practically anonymous. This is useful when memfd is not available.

This actually explains the purpose, unlike the doc comment in qom.json.
Same for the existing memory backends; can't fault you for doing your
new one the same way.  We ought to fix them all.  I'm not demanding you
do it.

The text could perhaps a bit clearer.  What does "practically anonymous"
mean?  As far as I understand, memory-backend-shm is a more portable and
less featureful version of memory-backend-memfd.  Say that?

> +
> +        Please refer to ``memory-backend-file`` for a description of the
> +        options.
> +
> +        The ``share`` boolean option is on by default with shm. Setting it to
> +        off will cause a failure during allocation because it is not supported
> +        by this backend.
> +

The "will case a failure" part is documented only here, and not in
qom.json.

Not this patch's fault: documentation for -object memory-backend-epc is
missing.

>      ``-object iommufd,id=id[,fd=fd]``
>          Creates an iommufd backend which allows control of DMA mapping
>          through the ``/dev/iommu`` device.


