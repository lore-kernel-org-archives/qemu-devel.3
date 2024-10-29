Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F0A3D2AB37
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lP4-0002GY-Oi; Tue, 29 Oct 2024 08:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5lOz-0002G9-5W
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:32:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t5lOv-0001B3-D7
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730205163;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=HQOWDfw0w0sRNUpdq0NvfxM2F+WPo2kG+38sNBk8Xus=;
 b=IhjOkusoABVrvA9yP+ivRRkBnaWxY1Q5eqAXSa9zdbxUo/Jq5AHhaCTwoWBW4uhWdTxZJD
 pdxODTQgjJeQ4r8JBEyOE6r0W5OM3hycrzi4GnynnKDFPGyu95hB4jWDEDuoXmKMDpfHea
 Yr9JuC5v1kCbodr6kxBsMhfxlaX26Z4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-163-3eRFZXbHMFebDkTQou0G4Q-1; Tue,
 29 Oct 2024 08:32:37 -0400
X-MC-Unique: 3eRFZXbHMFebDkTQou0G4Q-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DDE681955F3C; Tue, 29 Oct 2024 12:32:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.142])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C0A719560A2; Tue, 29 Oct 2024 12:32:35 +0000 (UTC)
Date: Tue, 29 Oct 2024 12:32:32 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: liequan che <liequanche@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH V2] crypto: Introduce SM3 hash hmac pbkdf algorithm
Message-ID: <ZyDV4M5zOvdLx8CI@redhat.com>
References: <CAAsfc_qfHe8hgr06AjhhfhWkOvKxU-Wz-02EjFCpo6HNkRhzgg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAsfc_qfHe8hgr06AjhhfhWkOvKxU-Wz-02EjFCpo6HNkRhzgg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Oct 29, 2024 at 08:06:39PM +0800, liequan che wrote:
> Introduce the SM3 cryptographic hash algorithm (GB/T 32905-2016).
> 
> SM3 (GB/T 32905-2016) is a cryptographic standard issued by the
> Organization of State Commercial Cryptography Administration (OSCCA)
> as an authorized cryptographic algorithm for use within China.
> 
> Detect the SM3 cryptographic hash algorithm and enable the feature silently
> if it is available.
> 
> Signed-off-by: cheliequan <cheliequan@inspur.com>
> ---
>  crypto/hash-gcrypt.c           |  3 +++
>  crypto/hash-nettle.c           | 14 ++++++++++++
>  crypto/hash.c                  |  3 +++
>  crypto/hmac-gcrypt.c           |  3 +++
>  crypto/hmac-nettle.c           | 11 ++++++++++
>  crypto/pbkdf-gcrypt.c          |  6 ++++++
>  crypto/pbkdf-nettle.c          | 13 ++++++++++++
>  include/crypto/hash.h          |  1 +
>  meson.build                    | 39 ++++++++++++++++++++++++++++++++++
>  qapi/crypto.json               |  3 ++-
>  tests/unit/test-crypto-hash.c  | 16 ++++++++++++++
>  tests/unit/test-crypto-hmac.c  |  8 +++++++
>  tests/unit/test-crypto-pbkdf.c | 16 ++++++++++++++
>  13 files changed, 135 insertions(+), 1 deletion(-)
> 

> diff --git a/meson.build b/meson.build
> index 85594fd3f1..611c13d182 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1754,6 +1754,7 @@ gcrypt = not_found
>  nettle = not_found
>  hogweed = not_found
>  crypto_sm4 = not_found
> +crypto_sm3 = not_found
>  xts = 'none'
> 
>  if get_option('nettle').enabled() and get_option('gcrypt').enabled()
> @@ -1789,6 +1790,17 @@ if not gnutls_crypto.found()
>        }''', dependencies: gcrypt)
>        crypto_sm4 = not_found
>      endif
> +    crypto_sm3 = gcrypt
> +    # SM3 ALG is available in libgcrypt >= 1.8

The gcrypt NEWS says SM3 was added in 1.9, not 1.8

> +    if gcrypt.found() and not cc.links('''
> +      #include <gcrypt.h>
> +      int main(void) {
> +        gcry_md_hd_t handler;
> +        gcry_md_open(&handler, GCRY_MD_SM3, 0);
> +        return 0;
> +      }''', dependencies: gcrypt)
> +      crypto_sm3 = not_found
> +    endif
>    endif
>    if (not get_option('nettle').auto() or have_system) and not
> gcrypt.found()
>      nettle = dependency('nettle', version: '>=3.4',
> @@ -1809,6 +1821,31 @@ if not gnutls_crypto.found()
>        }''', dependencies: nettle)
>        crypto_sm4 = not_found
>      endif
> +    crypto_sm3 = nettle
> +    # SM3 ALG is available in nettle >= 3.4

The nettle NEWS says SM3 was added in 3.8, not 3.4

> +    if nettle.found() and not cc.links('''
> +      #include <nettle/sm3.h>
> +      #include <nettle/hmac.h>
> +      int main(void) {
> +      struct sm3_ctx ctx;
> +      struct hmac_sm3_ctx hmac_ctx;
> +      unsigned char data[64] = {0};
> +      unsigned char output[32];
> +
> +      // SM3 hash function test
> +      sm3_init(&ctx);
> +      sm3_update(&ctx, 64, data);
> +      sm3_digest(&ctx, 32, data);
> +
> +      // HMAC-SM3 test
> +      hmac_sm3_set_key(&hmac_ctx, 32, data);
> +      hmac_sm3_update(&hmac_ctx, 64, data);
> +      hmac_sm3_digest(&hmac_ctx, 32, output);
> +
> +      return 0;
> +      }''', dependencies: nettle)
> +      crypto_sm3 = not_found
> +    endif
>    endif
>  endif

> diff --git a/qapi/crypto.json b/qapi/crypto.json
> index 9431522768..3645a4649b 100644
> --- a/qapi/crypto.json
> +++ b/qapi/crypto.json
> @@ -55,11 +55,12 @@
>  # @sha512: SHA-512.  (since 2.7)
>  #
>  # @ripemd160: RIPEMD-160.  (since 2.7)
> +# @sm3: SM3. (since 8.2.0)

QEMU's current release is 9.1, so the next version this
can be added to is 9.2.0, not 8.2.0



With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


