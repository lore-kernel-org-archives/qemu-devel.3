Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5827DC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 13:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHNuO-0007w2-1O; Wed, 12 Jun 2024 09:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHNuL-0007pw-Qn
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHNuK-0003qK-5G
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 09:20:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718198455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dUYG9QxIMIQ5uhr++x6WgjmKQdaajBC/IgrrKluYzDs=;
 b=d9xz4gtMtpmYZ8sMgEITshwGIPfZnlgTXLbEj8ovAPXeuOVhTyVGvY44BD3XChCVlwPvQf
 7/OBFgCt7BfTfYWz2R5txEvdrT7/iT198NptdgdT3KK2FgQeNRYmtUyChcYn+gIwCK2JvM
 hdbtDrEnKabDa7U/NOKYyP5nfNTgreI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-LvY2leuXMDSTmD8JM9HH8g-1; Wed,
 12 Jun 2024 09:20:52 -0400
X-MC-Unique: LvY2leuXMDSTmD8JM9HH8g-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 21DD81955D9E; Wed, 12 Jun 2024 13:20:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DADA1956059; Wed, 12 Jun 2024 13:20:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4FB9521E66E5; Wed, 12 Jun 2024 15:20:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: mst@redhat.com,  qemu-devel@nongnu.org,  qemu-block@nongnu.org,  Hanna
 Reitz <hreitz@redhat.com>,  Brad Smith <brad@comstyle.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 gmaglione@redhat.com,  stefanha@redhat.com,  Coiby Xu
 <Coiby.Xu@gmail.com>,  Gerd Hoffmann <kraxel@redhat.com>,  slp@redhat.com,
 Igor Mammedov <imammedo@redhat.com>,  Raphael Norwitz
 <raphael@enfabrica.net>,  Thomas Huth <thuth@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  David Hildenbrand <david@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Jason Wang
 <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH RESEND v7 10/12] hostmem: add a new memory backend based
 on POSIX shm_open()
In-Reply-To: <20240612130140.63004-11-sgarzare@redhat.com> (Stefano
 Garzarella's message of "Wed, 12 Jun 2024 15:01:38 +0200")
References: <20240612130140.63004-1-sgarzare@redhat.com>
 <20240612130140.63004-11-sgarzare@redhat.com>
Date: Wed, 12 Jun 2024 15:20:48 +0200
Message-ID: <87frtifgb3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>

[...]

> diff --git a/qapi/qom.json b/qapi/qom.json
> index 9b8f6a7ab5..94e4458288 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -601,8 +601,8 @@
>  #
>  # @share: if false, the memory is private to QEMU; if true, it is
>  #     shared (default false for backends memory-backend-file and
> -#     memory-backend-ram, true for backends memory-backend-epc and
> -#     memory-backend-memfd)
> +#     memory-backend-ram, true for backends memory-backend-epc,
> +#     memory-backend-memfd, and memory-backend-shm)
>  #
>  # @reserve: if true, reserve swap space (or huge pages) if applicable
>  #     (default: true) (since 6.1)
> @@ -721,6 +721,22 @@
>              '*hugetlbsize': 'size',
>              '*seal': 'bool' } }
>  
> +##
> +# @MemoryBackendShmProperties:
> +#
> +# Properties for memory-backend-shm objects.
> +#
> +# Setting @share boolean option (defined in the base type) to false
> +# will cause a failure during allocation because it is not
> +# supported by this backend.

This is QMP reference documentation.  "Failure during allocation" feels
like unnecessary detail there.  Maybe "This memory backend support only
shared memory, which is the default."

> +#
> +# Since: 9.1
> +##
> +{ 'struct': 'MemoryBackendShmProperties',
> +  'base': 'MemoryBackendProperties',
> +  'data': { },
> +  'if': 'CONFIG_POSIX' }
> +
>  ##
>  # @MemoryBackendEpcProperties:
>  #
> @@ -1049,6 +1065,8 @@
>      { 'name': 'memory-backend-memfd',
>        'if': 'CONFIG_LINUX' },
>      'memory-backend-ram',
> +    { 'name': 'memory-backend-shm',
> +      'if': 'CONFIG_POSIX' },
>      'pef-guest',
>      { 'name': 'pr-manager-helper',
>        'if': 'CONFIG_LINUX' },
> @@ -1121,6 +1139,8 @@
>        'memory-backend-memfd':       { 'type': 'MemoryBackendMemfdProperties',
>                                        'if': 'CONFIG_LINUX' },
>        'memory-backend-ram':         'MemoryBackendProperties',
> +      'memory-backend-shm':         { 'type': 'MemoryBackendShmProperties',
> +                                      'if': 'CONFIG_POSIX' },
>        'pr-manager-helper':          { 'type': 'PrManagerHelperProperties',
>                                        'if': 'CONFIG_LINUX' },
>        'qtest':                      'QtestProperties',

[...]

Other than that, QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


