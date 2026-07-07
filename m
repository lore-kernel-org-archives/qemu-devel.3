Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E91BBC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 17:54:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh9x7-0006bh-7U; Tue, 07 Jul 2026 13:51:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh9wP-0005qP-1d
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:50:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wh9wM-0001JK-58
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 13:50:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783446636;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9bInZlgd1XssUUbcYAeUaJBWtvw/+u7OAaptk4l1twQ=;
 b=CR03bGQZpt9tiliTypH+FlwSyrxf2Fmvuq0W1Hd15bUnV6oR8TyfAlbA4EAYp1UvoJxG7U
 8l9TMjJecBKDwb227U/tJvx92EOfT+lYg+zKLVmVie7DcJOEhpZnctn7zxFtqTYzTpvD44
 EKz8DhmVs09BySkjd0U7nINIlphZPTY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-j-vdmoGYN-WIBjoM27JT7w-1; Tue,
 07 Jul 2026 13:50:34 -0400
X-MC-Unique: j-vdmoGYN-WIBjoM27JT7w-1
X-Mimecast-MFC-AGG-ID: j-vdmoGYN-WIBjoM27JT7w_1783446633
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 048AB195411F; Tue,  7 Jul 2026 17:50:33 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.142])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 19F3236933; Tue,  7 Jul 2026 17:50:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 yujun <yujun@kylinos.cn>
Subject: [PULL 1/4] crypto/x509-utils: fix gnutls error code in crt_init
 failure path
Date: Tue,  7 Jul 2026 18:50:24 +0100
Message-ID: <20260707175027.3029620-2-berrange@redhat.com>
In-Reply-To: <20260707175027.3029620-1-berrange@redhat.com>
References: <20260707175027.3029620-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: yujun <yujun@kylinos.cn>

qcrypto_get_x509_cert_fingerprint() reports gnutls_strerror(ret) when
gnutls_x509_crt_init() fails, but ret is still the initial value -1.
Store the gnutls return code before formatting the error, matching
other gnutls call sites in the tree.

Fixes: 2183ab6251 ("crypto/x509-utils: Check for error from gnutls_x509_crt_init()")
Signed-off-by: yujun <yujun@kylinos.cn>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/x509-utils.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index 39bb6d4d8c..1843488bca 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -46,7 +46,8 @@ int qcrypto_get_x509_cert_fingerprint(uint8_t *cert, size_t size,
         return -1;
     }
 
-    if (gnutls_x509_crt_init(&crt) < 0) {
+    ret = gnutls_x509_crt_init(&crt);
+    if (ret < 0) {
         error_setg(errp, "Unable to initialize certificate: %s",
                    gnutls_strerror(ret));
         return -1;
-- 
2.55.0


