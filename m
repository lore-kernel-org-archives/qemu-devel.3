Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED41CCF9E0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 15:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCJuV-0008IY-Tb; Fri, 24 Oct 2025 11:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCJuT-0008Hq-Dt
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:40:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vCJuR-0003P1-L4
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 11:40:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761320455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4U13DS84vu8fdAZLnmbcdTQZOB+68oeOMig+2Pdendk=;
 b=YfeobRlIwnIQIR4Mvm5qhHQd4hm8yGCXROOl08yoQ4ZjZyhvHNgaYrTL9SLCZQ612cYwfk
 pGF1ObRxKTWFMcLxFEkkqJ22D9M2Nk39KxN6jkfnVGwq9qds9EF0wMfMSS8HdGQZwBTqTe
 DC+HyAxs4/MNvjZBA9LTOKpVZH4HA1o=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-374-fuftHBWDPWyNt-db7-FXZA-1; Fri,
 24 Oct 2025 11:40:52 -0400
X-MC-Unique: fuftHBWDPWyNt-db7-FXZA-1
X-Mimecast-MFC-AGG-ID: fuftHBWDPWyNt-db7-FXZA_1761320451
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79B9E180035D; Fri, 24 Oct 2025 15:40:51 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F79919540EB; Fri, 24 Oct 2025 15:40:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 09/13] crypto: validate an error is reported in test expected
 fails
Date: Fri, 24 Oct 2025 16:40:20 +0100
Message-ID: <20251024154024.227978-10-berrange@redhat.com>
In-Reply-To: <20251024154024.227978-1-berrange@redhat.com>
References: <20251024154024.227978-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

There was a bug where TLS x509 credentials validation failed
to fill out the Error object. Validate this in the failure
scenarios.

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/unit/test-crypto-tlscredsx509.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/unit/test-crypto-tlscredsx509.c b/tests/unit/test-crypto-tlscredsx509.c
index a7ea5f422d..85f51aee1b 100644
--- a/tests/unit/test-crypto-tlscredsx509.c
+++ b/tests/unit/test-crypto-tlscredsx509.c
@@ -73,6 +73,7 @@ static void test_tls_creds(const void *opaque)
     struct QCryptoTLSCredsTestData *data =
         (struct QCryptoTLSCredsTestData *)opaque;
     QCryptoTLSCreds *creds;
+    Error *err = NULL;
 
 #define CERT_DIR "tests/test-crypto-tlscredsx509-certs/"
     g_mkdir_with_parents(CERT_DIR, 0700);
@@ -111,10 +112,12 @@ static void test_tls_creds(const void *opaque)
          QCRYPTO_TLS_CREDS_ENDPOINT_SERVER :
          QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT),
         CERT_DIR,
-        data->expectFail ? NULL : &error_abort);
+        data->expectFail ? &err : &error_abort);
 
     if (data->expectFail) {
         g_assert(creds == NULL);
+        g_assert(err != NULL);
+        error_free(err);
     } else {
         g_assert(creds != NULL);
     }
-- 
2.50.1


