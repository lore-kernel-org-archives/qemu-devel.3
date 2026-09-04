Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D89BC79F80
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:08:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WRP-0003tu-PF; Fri, 04 Sep 2026 12:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2WRO-0003sQ-2K
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:06:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2WRM-0006dV-6c
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:06:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788538015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qI+mYyMyZ0x0hsc/90NJLML+6JXug8Wb8HHAvXkC5aQ=;
 b=UaTaLzSClQvqZ2ZjeEosd3sAY1fxYk4JRGYgzdVq4qY2Mm1VOaAlq8qTyeT42J2QejxfRW
 H655ryLDJcNK1vUGCG/Cs6V1VfWZP/QGpyXLrLMH7ISYd/MsoRGHUxdfXrTVpS2isdSiNx
 BODI8V3BYkpg9/bVu6yh9/oPNw7A/0A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553--0uarJx2MlCAmM5daV9wsw-1; Fri,
 04 Sep 2026 12:06:53 -0400
X-MC-Unique: -0uarJx2MlCAmM5daV9wsw-1
X-Mimecast-MFC-AGG-ID: -0uarJx2MlCAmM5daV9wsw_1788538012
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 524DE18CDD49; Fri,  4 Sep 2026 16:06:52 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6B3113001D37; Fri,  4 Sep 2026 16:06:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhuoying Cai <zycai@linux.ibm.com>
Subject: [PULL v2 02/13] crypto/x509-utils: don't double set errp
Date: Fri,  4 Sep 2026 17:06:32 +0100
Message-ID: <20260904160643.353833-3-berrange@redhat.com>
In-Reply-To: <20260904160643.353833-1-berrange@redhat.com>
References: <20260904160643.353833-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

qcrypto_x509_get_ecc_curve() already sets errp on failure.

Fixes: e8317c4c9f68 ("crypto/x509-utils: Add helper functions for DIAG 320 subcode 2")
Reviewed-by: Zhuoying Cai <zycai@linux.ibm.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 crypto/x509-utils.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/x509-utils.c b/crypto/x509-utils.c
index e4767f9838..34cbfca26b 100644
--- a/crypto/x509-utils.c
+++ b/crypto/x509-utils.c
@@ -325,7 +325,6 @@ int qcrypto_x509_check_ecc_curve_p521(uint8_t *cert, size_t size, Error **errp)
 
     curve_id = qcrypto_x509_get_ecc_curve(cert, size, errp);
     if (curve_id == -1) {
-        error_setg(errp, "Failed to get ECC curve");
         return -1;
     }
 
-- 
2.55.0


