Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF76FC47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Feb 2024 12:33:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfJ75-0001u4-67; Wed, 28 Feb 2024 07:32:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfJ6t-0001rG-KX
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:32:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rfJ6o-0008Rh-Vo
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:32:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709123543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3phnP5v7W3Ds21SEGFmKyr0YeItnA0S46yr5ZB4aU9I=;
 b=Nqw+p8Hms8rW3oel1RD3llyG4whyecJxHEefVbaBISCYmDmSPE/17PlNGzHvSTzYOUYglE
 8xFrAPiqaAYC640VFa3T1+lbmcAbA3yOmTnQoAXH0Mq5MiQmTGdHN580z064WFAuYtt4Xt
 zV6mOG112X9rtOJ/WfhPb9kP+kQGcDc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-iQe1CziZPxOLKQpL3dJfDg-1; Wed, 28 Feb 2024 07:32:20 -0500
X-MC-Unique: iQe1CziZPxOLKQpL3dJfDg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C3FF2185A784;
 Wed, 28 Feb 2024 12:32:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D931C185C0;
 Wed, 28 Feb 2024 12:32:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 73D3721E66F4; Wed, 28 Feb 2024 13:32:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,  Jason
 Wang <jasowang@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,  Eric
 Blake <eblake@redhat.com>,  Coiby Xu <Coiby.Xu@gmail.com>,  slp@redhat.com,
 Eduardo Habkost <eduardo@habkost.net>,  Hanna Reitz <hreitz@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,  Raphael Norwitz
 <raphael@enfabrica.net>,  Kevin Wolf <kwolf@redhat.com>,  David
 Hildenbrand <david@redhat.com>,  stefanha@redhat.com, gmaglione@redhat.com
Subject: Re: [PATCH 9/9] hostmem-file: support POSIX shm_open()
In-Reply-To: <20240228114759.44758-10-sgarzare@redhat.com> (Stefano
 Garzarella's message of "Wed, 28 Feb 2024 12:47:59 +0100")
References: <20240228114759.44758-1-sgarzare@redhat.com>
 <20240228114759.44758-10-sgarzare@redhat.com>
Date: Wed, 28 Feb 2024 13:32:17 +0100
Message-ID: <874jdswyzy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
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

Stefano Garzarella <sgarzare@redhat.com> writes:

> Add a new `shm` bool option for `-object memory-backend-file`.
>
> When this option is set to true, the POSIX shm_open(3) is used instead
> of open(2).
>
> So a file will not be created in the filesystem, but a "POSIX shared
> memory object" will be instantiated. In Linux this turns into a file
> in /dev/shm, but in other OSes this may not happen (for example in
> macOS or FreeBSD nothing is shown in any filesystem).
>
> This new feature is useful when we need to share guest memory with
> another process (e.g. vhost-user backend), but we don't have
> memfd_create() or any special filesystems (e.g. /dev/shm) available
> as in macOS.
>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> I am not sure this is the best way to support shm_open() in QEMU.
>
> Other solutions I had in mind were:
>
> - create a new memory-backend-shm

How would that look like?  Would it involve duplicating code?

> - extend memory-backend-memfd to use shm_open() on systems where memfd is
> not available (problem: shm_open wants a name to assign to the object, but
> we can do a workaround by using a random name and do the unlink right away)

Hmm.  Too much magic?  I don't know...

> Any preference/suggestion?

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 2a6e49365a..bfb01b909f 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -682,6 +682,9 @@
   # @mem-path: the path to either a shared memory or huge page
   #     filesystem mount

Does this need adjustment?

[...]

>  #       writable RAM instead of ROM, and want to set this property to 'off'.
>  #       (default: auto, since 8.2)
>  #
> +# @shm: if true, shm_open(3) is used to create/open POSIX shared memory
> +#       object; if false, an open(2) is used. (default: false) (since 9.0)
> +#

Please format like this for consistency:

# @shm: if true, shm_open(3) is used to create/open POSIX shared memory
#     object; if false, an open(2) is used (default: false) (since 9.0)

>  # Since: 2.1
>  ##
>  { 'struct': 'MemoryBackendFileProperties',
> @@ -692,6 +695,7 @@
>              'mem-path': 'str',
>              '*pmem': { 'type': 'bool', 'if': 'CONFIG_LIBPMEM' },
>              '*readonly': 'bool',
> +            '*shm': 'bool',
>              '*rom': 'OnOffAuto' } }
>  
>  ##

[...]


