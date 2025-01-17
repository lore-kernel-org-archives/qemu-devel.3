Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1BEC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:05:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYm1v-000610-8x; Fri, 17 Jan 2025 08:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYm1s-00060S-Fd
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:04:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tYm1q-0003uX-11
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737119088;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=Qh+TGGR/CXJFIP5OzhjtU9p46CrPUdLyLp9wXRjqs6g=;
 b=AuPAm2+WXwgxf9kr/Kvg+jrzmXRon16XkW72s6in2qzy01j2W/V/L8Bzmke/G7J5iAUgh4
 mLdlUX94qa9SvaX3tahqKp3jUmAgxQHb+g9+z5Yl7EqicSKhtIPu3n1tVufh5hfc8ovYYA
 OzT1VTtgaD0hmkvVzkGuzmry9LsOP6w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-PDcL3KYUNZe02C7-P--xew-1; Fri,
 17 Jan 2025 08:04:46 -0500
X-MC-Unique: PDcL3KYUNZe02C7-P--xew-1
X-Mimecast-MFC-AGG-ID: PDcL3KYUNZe02C7-P--xew
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 284F51953957; Fri, 17 Jan 2025 13:04:44 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.60])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84A2B195608A; Fri, 17 Jan 2025 13:04:40 +0000 (UTC)
Date: Fri, 17 Jan 2025 13:04:37 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: tugy@chinatelecom.cn
Cc: eblake@redhat.com, armbru@redhat.com, kwolf@redhat.com,
 hreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/2] qapi/crypto: support enable encryption/decryption in
 parallel
Message-ID: <Z4pVZa0qjPQ67Nr1@redhat.com>
References: <cover.1732789721.git.tugy@chinatelecom.cn>
 <608e6ae38d080acdcd1f28d0700b9e0b919ee2db.1732789721.git.tugy@chinatelecom.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <608e6ae38d080acdcd1f28d0700b9e0b919ee2db.1732789721.git.tugy@chinatelecom.cn>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.132,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.79,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Nov 28, 2024 at 06:51:22PM +0800, tugy@chinatelecom.cn wrote:
> From: Guoyi Tu <tugy@chinatelecom.cn>
> 
> add encrypt-in-parallel option to enable encryption/decryption
> in parallel
> 
> Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> ---
>  block/crypto.c       | 8 ++++++++
>  block/crypto.h       | 9 +++++++++
>  qapi/block-core.json | 6 +++++-
>  qapi/crypto.json     | 6 +++++-
>  4 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index c085f331ce..b02400fb26 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -212,6 +212,7 @@ static QemuOptsList block_crypto_runtime_opts_luks = {
>      .head = QTAILQ_HEAD_INITIALIZER(block_crypto_runtime_opts_luks.head),
>      .desc = {
>          BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(""),
> +        BLOCK_CRYPTO_OPT_DEF_LUKS_ENCRYPT_IN_PARALLEL(""),
>          { /* end of list */ }
>      },
>  };
> @@ -347,6 +348,13 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
>      }
>  
>      cryptoopts = qemu_opts_to_qdict(opts, NULL);
> +
> +    if (!g_strcmp0(qdict_get_try_str(cryptoopts,
> +                   BLOCK_CRYPTO_OPT_LUKS_ENCRYPT_IN_PARALLEL), "on") ||
> +        qdict_get_try_bool(cryptoopts,
> +                           BLOCK_CRYPTO_OPT_LUKS_ENCRYPT_IN_PARALLEL, false)) {
> +        crypto->encrypt_in_parallel = true;
> +    }
>      qdict_put_str(cryptoopts, "format", QCryptoBlockFormat_str(format));
>  
>      open_opts = block_crypto_open_opts_init(cryptoopts, errp);
> diff --git a/block/crypto.h b/block/crypto.h
> index dc3d2d5ed9..6729420941 100644
> --- a/block/crypto.h
> +++ b/block/crypto.h
> @@ -46,6 +46,7 @@
>  #define BLOCK_CRYPTO_OPT_LUKS_STATE "state"
>  #define BLOCK_CRYPTO_OPT_LUKS_OLD_SECRET "old-secret"
>  #define BLOCK_CRYPTO_OPT_LUKS_NEW_SECRET "new-secret"
> +#define BLOCK_CRYPTO_OPT_LUKS_ENCRYPT_IN_PARALLEL "encrypt-in-parallel"
>  
>  
>  #define BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET(prefix)                    \
> @@ -130,6 +131,14 @@
>                  "Empty string to erase",                        \
>      }
>  
> +#define BLOCK_CRYPTO_OPT_DEF_LUKS_ENCRYPT_IN_PARALLEL(prefix)     \
> +    {                                                             \
> +        .name = prefix BLOCK_CRYPTO_OPT_LUKS_ENCRYPT_IN_PARALLEL, \
> +        .type = QEMU_OPT_BOOL,                                    \
> +        .help = "perform encryption and decryption through "      \
> +                "thread pool",                                    \
> +    }
> +
>  QCryptoBlockCreateOptions *
>  block_crypto_create_opts_init(QDict *opts, Error **errp);
>  
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index fd3bcc1c17..1e47b6ea80 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3365,12 +3365,16 @@
>  #
>  # @header: block device holding a detached LUKS header.  (since 9.0)
>  #
> +# @encrypt-in-parallel: perform encryption and decryption through
> +#   thread pool
> +#
>  # Since: 2.9
>  ##
>  { 'struct': 'BlockdevOptionsLUKS',
>    'base': 'BlockdevOptionsGenericFormat',
>    'data': { '*key-secret': 'str',
> -            '*header': 'BlockdevRef'} }
> +            '*header': 'BlockdevRef',
> +            '*encrypt-in-parallel': 'bool'} }
>  
>  ##
>  # @BlockdevOptionsGenericCOWFormat:
> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index c9d967d782..91963c693f 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -192,10 +192,14 @@
>  #     decryption key.  Mandatory except when probing image for
>  #     metadata only.
>  #
> +# @encrypt-in-parallel: perform encryption and decryption through
> +#   thread pool
> +#
>  # Since: 2.6
>  ##
>  { 'struct': 'QCryptoBlockOptionsLUKS',
> -  'data': { '*key-secret': 'str' }}
> +  'data': { '*key-secret': 'str',
> +            '*encrypt-in-parallel': 'bool' }}

Perhaps better named as    'use-thread-pool': 'bool', not least because
this applies to decrypt too, not just encrypt .


NB, both the qapi changes need a "(since 10.0.0)" annotation too

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


