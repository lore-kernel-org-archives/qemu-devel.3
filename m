Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07CFE7717F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 18:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNFx8-0000tP-4W; Mon, 16 Dec 2024 13:36:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNFx0-0000t3-Mh
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:36:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNFwy-0005IL-8T
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 13:36:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734374170;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=umyYVBlkBafRDtFaAw/6Rh91VNwas1/AFyrRQATMRbQ=;
 b=iMhYy8EIVc/TTLzDJzlz+LZHVuVtmlFTGiaVIm/LePIdnFPxf8OX3OjLUx/i5NXlykhhMf
 kSA6nUryX9A78gS3CfeRu/TUVlNooR05yH0QO9m8Og9sRkMKThOFLnnyviclLLBD4GEoR2
 sccAbWnw3P0GkL4fG/3+q45FSj+OZQs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-WJ2XSpoAMny8jrWmncnotw-1; Mon,
 16 Dec 2024 13:36:07 -0500
X-MC-Unique: WJ2XSpoAMny8jrWmncnotw-1
X-Mimecast-MFC-AGG-ID: WJ2XSpoAMny8jrWmncnotw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF7F71955E7D; Mon, 16 Dec 2024 18:36:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.145])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0109919560A2; Mon, 16 Dec 2024 18:36:00 +0000 (UTC)
Date: Mon, 16 Dec 2024 18:35:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>,
 Fabiano Rosas <farosas@suse.de>, Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: Re: [PATCH 2/3] tests: Use qemu_mkdir_with_parents() for all test code
Message-ID: <Z2BzDSM74jFYOglT@redhat.com>
References: <20241216161413.1644171-1-peterx@redhat.com>
 <20241216161413.1644171-3-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241216161413.1644171-3-peterx@redhat.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Mon, Dec 16, 2024 at 11:14:12AM -0500, Peter Xu wrote:
> Coverity isn't happy on the QEMU test cases where g_mkdir_with_parents() is
> used without checking retvals.  Use qemu_mkdir_with_parents() to fix them.
> 
> Resolves: Coverity CID 1568381
> Resolves: Coverity CID 1568378
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  tests/qtest/migration/tls-tests.c     | 6 +++---
>  tests/unit/test-crypto-tlscredsx509.c | 4 ++--
>  tests/unit/test-crypto-tlssession.c   | 6 +++---
>  tests/unit/test-io-channel-tls.c      | 6 +++---
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/qtest/migration/tls-tests.c b/tests/qtest/migration/tls-tests.c
> index 5704a1f992..c78daff998 100644
> --- a/tests/qtest/migration/tls-tests.c
> +++ b/tests/qtest/migration/tls-tests.c
> @@ -43,14 +43,14 @@ migrate_hook_start_tls_psk_common(QTestState *from,
>      data->workdir = g_strdup_printf("%s/tlscredspsk0", tmpfs);
>      data->pskfile = g_strdup_printf("%s/%s", data->workdir,
>                                      QCRYPTO_TLS_CREDS_PSKFILE);
> -    g_mkdir_with_parents(data->workdir, 0700);
> +    qemu_mkdir_with_parents(data->workdir, 0700);

I dislike this as a solution as it is not obvious that qemu_mkdir_with_parents
is any different. IMHO the right solution for tests is to assert inline

  g_asset(g_mkdir_with_parents(...) == 0);

>      test_tls_psk_init(data->pskfile);
>  
>      if (mismatch) {
>          data->workdiralt = g_strdup_printf("%s/tlscredspskalt0", tmpfs);
>          data->pskfilealt = g_strdup_printf("%s/%s", data->workdiralt,
>                                             QCRYPTO_TLS_CREDS_PSKFILE);
> -        g_mkdir_with_parents(data->workdiralt, 0700);
> +        qemu_mkdir_with_parents(data->workdiralt, 0700);
>          test_tls_psk_init_alt(data->pskfilealt);
>      }
>  
> @@ -152,7 +152,7 @@ migrate_hook_start_tls_x509_common(QTestState *from,
>          data->clientcert = g_strdup_printf("%s/client-cert.pem", data->workdir);
>      }
>  
> -    g_mkdir_with_parents(data->workdir, 0700);
> +    qemu_mkdir_with_parents(data->workdir, 0700);
>  
>      test_tls_init(data->keyfile);
>  #ifndef _WIN32
> diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
> index 3c25d75ca1..57ce0134df 100644
> --- a/tests/unit/test-crypto-tlscredsx509.c
> +++ b/tests/unit/test-crypto-tlscredsx509.c
> @@ -75,7 +75,7 @@ static void test_tls_creds(const void *opaque)
>      QCryptoTLSCreds *creds;
>  
>  #define CERT_DIR "tests/test-crypto-tlscredsx509-certs/"
> -    g_mkdir_with_parents(CERT_DIR, 0700);
> +    qemu_mkdir_with_parents(CERT_DIR, 0700);
>  
>      unlink(CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
>      if (data->isServer) {
> @@ -141,7 +141,7 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>      g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
>  
> -    g_mkdir_with_parents(WORKDIR, 0700);
> +    qemu_mkdir_with_parents(WORKDIR, 0700);
>  
>      test_tls_init(KEYFILE);
>  
> diff --git a/tests/unit/test-crypto-tlssession.c b/tests/unit/test-crypto-tlssession.c
> index 3395f73560..db97cbefe7 100644
> --- a/tests/unit/test-crypto-tlssession.c
> +++ b/tests/unit/test-crypto-tlssession.c
> @@ -271,8 +271,8 @@ static void test_crypto_tls_session_x509(const void *opaque)
>  
>  #define CLIENT_CERT_DIR "tests/test-crypto-tlssession-client/"
>  #define SERVER_CERT_DIR "tests/test-crypto-tlssession-server/"
> -    g_mkdir_with_parents(CLIENT_CERT_DIR, 0700);
> -    g_mkdir_with_parents(SERVER_CERT_DIR, 0700);
> +    qemu_mkdir_with_parents(CLIENT_CERT_DIR, 0700);
> +    qemu_mkdir_with_parents(SERVER_CERT_DIR, 0700);
>  
>      unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
>      unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
> @@ -420,7 +420,7 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>      g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
>  
> -    g_mkdir_with_parents(WORKDIR, 0700);
> +    qemu_mkdir_with_parents(WORKDIR, 0700);
>  
>      test_tls_init(KEYFILE);
>      test_tls_psk_init(PSKFILE);
> diff --git a/tests/unit/test-io-channel-tls.c b/tests/unit/test-io-channel-tls.c
> index e036ac5df4..6cb83e891a 100644
> --- a/tests/unit/test-io-channel-tls.c
> +++ b/tests/unit/test-io-channel-tls.c
> @@ -125,8 +125,8 @@ static void test_io_channel_tls(const void *opaque)
>  
>  #define CLIENT_CERT_DIR "tests/test-io-channel-tls-client/"
>  #define SERVER_CERT_DIR "tests/test-io-channel-tls-server/"
> -    g_mkdir_with_parents(CLIENT_CERT_DIR, 0700);
> -    g_mkdir_with_parents(SERVER_CERT_DIR, 0700);
> +    qemu_mkdir_with_parents(CLIENT_CERT_DIR, 0700);
> +    qemu_mkdir_with_parents(SERVER_CERT_DIR, 0700);
>  
>      unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_CA_CERT);
>      unlink(SERVER_CERT_DIR QCRYPTO_TLS_CREDS_X509_SERVER_CERT);
> @@ -273,7 +273,7 @@ int main(int argc, char **argv)
>      g_test_init(&argc, &argv, NULL);
>      g_setenv("GNUTLS_FORCE_FIPS_MODE", "2", 1);
>  
> -    g_mkdir_with_parents(WORKDIR, 0700);
> +    qemu_mkdir_with_parents(WORKDIR, 0700);
>  
>      test_tls_init(KEYFILE);
>  
> -- 
> 2.47.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


