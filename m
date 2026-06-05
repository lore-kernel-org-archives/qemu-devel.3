Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B4CFCD6E7D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 15:46:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVWjP-0004vR-05; Fri, 05 Jun 2026 11:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjN-0004lw-1s
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wVWjL-000647-MR
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 11:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780674307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fAwFkj/6xMxLjs4eWHPsU8ZO9MF0yW+Kp2IWPAaAtK4=;
 b=VxQrSfIKkPZ1K58c+CLYSCjfeiTG0NhQqueO+rAt7QSVAYhdoWAWd526YdIbaUuRt2T8Iy
 woz55/PHMrVkXO1eKsAEaOURhLMw+wQ95LGB/xQ7L7hmaXjzdyjEbwd4DRpyyh0dkQ0D7B
 lexLYIiNv0o17IOfCb0OcG17Vu1AwEk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-5eErVoFAMNak2OtehVWU7A-1; Fri,
 05 Jun 2026 11:45:05 -0400
X-MC-Unique: 5eErVoFAMNak2OtehVWU7A-1
X-Mimecast-MFC-AGG-ID: 5eErVoFAMNak2OtehVWU7A_1780674304
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A6DE1800366
 for <qemu-devel@nongnu.org>; Fri,  5 Jun 2026 15:45:04 +0000 (UTC)
Received: from localhost (unknown [10.44.24.6])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 746B927A; Fri,  5 Jun 2026 15:45:02 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 05 Jun 2026 19:44:27 +0400
Subject: [GIT PULL 07/23] hw/xlnx_dp: reject NULL 'dpdma' property rather
 than crash
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260605-qom-tests-v1-7-3f184f382c2b@redhat.com>
References: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
In-Reply-To: <20260605-qom-tests-v1-0-3f184f382c2b@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=806;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=kJdZho7KPoZAyRTuY6SsmAMLdZDbGBB9QFQKogVkqy8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqIu7U6Syq9mbRxfzMubguX3Eom1y2y/Nc2vMqc
 SM1pu6nS/uJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaiLu1AAKCRDa6OEJdZac
 5RKmEACVAPF4hf5tzIy9gvPgvaK8f8jfmL3SNWNORxKm7i7pRabIi50rRQmaz0lwSkSsvFhUu2m
 sNZYS1lIiTSCW3vWh4+NUOwREW6Pk/yxjhjcKm0WIuDRDHIMbOPAm6nZAB7Tx1pV5S9H5YqkWE4
 5VXDVELSIxQSWCDkfm25cxKVoPWXcJ9R7L9c3GZI6bzLfMBgswiDRneKjgBhTxOrZRadaCzyjH9
 BWQtKKcntZlA+71ZbDzdmozwXkrtzorlpuqes1uGtHp8kGKaNWNGYE8oQR+0aeXaM5hBRhGz+sP
 gsemhktO0MMP7qkrjzMrG/CHtKM9Ko+kuqWDaVw4UcUNCumABRCpcSaVbt5omG2x5jFN3pGWmGZ
 FX+G65d01ijMAry9HTxGgWW3NtGwPKTekkHrujqkHQI/ev2CYo2gtEOg6fs/JPq/FqdhgWaQeYr
 UmL3nDlQBoPkiYJTZDhCaGMO3I66VYEZ0sgqKrkFmlTJtouK2p5vu9DUuwL7zYvXqX9jKrQyCxe
 u0ujpHmS9xAypH7gaVI36pbFhfLaU9DnvgTBP/KNt/ulVCiMG3K0FU5dZa8iHe4lFZsda8Gir3y
 OzC4DtCpn7J0gklrQIp3huc1zVODowuDbBrtJmH7xr+G0Drwd+vojsLX8oN2qXovqO2UC4HuhLB
 wrH60pLLfrb4w3g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/display/xlnx_dp.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 2486d9e5825..98126ef320d 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -570,6 +570,12 @@ static void xlnx_dp_set_dpdma(const Object *obj, const char *name, Object *val,
                               Error **errp)
 {
     XlnxDPState *s = XLNX_DP(obj);
+
+    if (!s) {
+        error_setg(errp, "%s cannot be set to NULL", name);
+        return;
+    }
+
     if (s->console) {
         DisplaySurface *surface = qemu_console_surface(s->console);
         XlnxDPDMAState *dma = XLNX_DPDMA(val);

-- 
2.54.0


