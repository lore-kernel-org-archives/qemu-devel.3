Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190A3E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 03:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKqYz-00007s-Md; Mon, 09 Dec 2024 22:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYx-00006X-8E; Mon, 09 Dec 2024 22:05:27 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tKqYv-0003GX-I6; Mon, 09 Dec 2024 22:05:26 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2165cb60719so11470935ad.0; 
 Mon, 09 Dec 2024 19:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733799923; x=1734404723; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JE6gi1e3jrRqP6eAPvMmiiVnw5XrKK0H22R6GNUrJ94=;
 b=PYabYiu1V9GpSf/BXhMq0Ix6rtZs2ZhN3lDiC35p/0R+7oJ9V6y3w9Rllsoor2Eww8
 OkrpPwPZZrywDjWdVkHHeaxtVIOw9t13lCf9BB4tyXx2z4qx60hYey5HK3V/y7fLa8LC
 vyrxdJVPutANgA9+luBnqO4O5+hnotrW7cXqvFW5rg130hAIND7zHS3L6owNsrdSosSi
 +yyxktudJBWBhKwepsjaJkieLFUjRqUDHPYdqohVCtQh0HMtWRKRWeXHfwpFONWIYWe9
 PrYFxuo/tPftcXC0mNM4iBZNoQMbq4g8TBRbiPeDro+XpnO0AeUU/B8n9eCrLX7vhdjO
 j65Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733799923; x=1734404723;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JE6gi1e3jrRqP6eAPvMmiiVnw5XrKK0H22R6GNUrJ94=;
 b=jwTMfLojMxXBT2Sbt4ktGQ6SWvO6BjOWsDa/qQfwt32UJtKEhW/fmVw0Oi534XO8G0
 cqMOhZI2Fbc9eVFC9w0GM6jFC5SyYS+F/x+hrjvMPoddzBUZDLnHXkd0TTn8G91kqpPy
 QJrknyZXqh4Dc2h9Rwu7Rw0+iXl5u0IywXIFGvZ42IkRIYfixWNnxvEf63AdCxP6aLnP
 361Gam3Etrc+EEm8EAjNYU2Ck0pLoYrvWD9lTBdHtvWs37mnQAVSPaAI6d9jHQvoHabh
 eDqxeIqoYGKBz/33kaMKQY/5kf4+e9AKP7DYZiCQoGG2ff/74GmifPMpKY2IH8TD6Q0L
 2Wxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhVTzwTiGtZTtSs4CKvbwqVpzthCJvHsWaIt5V/BY1+E8pgM4LUK1M6GB+GIcWvBfKnZrzHaUH4n50@nongnu.org
X-Gm-Message-State: AOJu0YwXWM0v7rMv/PpeAmKxoLAq3yBpx0qQe0YuzDjoCK+k28auKOUF
 PocDnVGA0s2/QhCPVRX3p7jm3O+L4/AzHEHRqDar1/d9zT/rzSBAh9qZFQ==
X-Gm-Gg: ASbGnctOv54cOoeU9dka358x4pv49ozcWJ9hctu29XjcfUDQOfMm0i2pLx2XLPDnGXH
 F0HOJRyO4hYDdgeNuFx8O5T7Bzs8b0QxFcoJb6OXlX7Q1fVEdZ3I9y09CyBk8q15CkMaLpRcJTr
 ac5uprNwwoIXXt4pxbIA9BScIqdxK1n+KmVFeTXeqQRpCZXvsZF1OTjnB64zMVkgOcAb7OaVSdd
 QgajzBMJ+D88gD8sMkExODA6zDRTtkHpJzU9No7rtRgdYmPY/vxV+dXPVOf
X-Google-Smtp-Source: AGHT+IG5BaZD9fGDiC5EEHW/84z+kWAH+PdjsfIqUv4mn0YKzvhj4pgPl1tKmA1tVBA+YHaPVCtOWw==
X-Received: by 2002:a17:902:da89:b0:215:19ae:77bf with SMTP id
 d9443c01a7336-21669fe13e4mr37475065ad.19.1733799923527; 
 Mon, 09 Dec 2024 19:05:23 -0800 (PST)
Received: from wheely.local0.net ([220.253.106.119])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21631118cedsm44813865ad.150.2024.12.09.19.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Dec 2024 19:05:23 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>
Subject: [PATCH 8/9] ppc/pnv/occ: Add POWER10 OCC-OPAL data format
Date: Tue, 10 Dec 2024 13:04:48 +1000
Message-ID: <20241210030451.1306608-9-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241210030451.1306608-1-npiggin@gmail.com>
References: <20241210030451.1306608-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add POWER10 OCC-OPAL data format. POWER10 changes major version and
adds a few fields.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/pnv_occ.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 5567fbf008e..aa46e118e93 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -263,14 +263,20 @@ static const TypeInfo pnv_occ_power9_type_info = {
 
 static void pnv_occ_power10_class_init(ObjectClass *klass, void *data)
 {
+    PnvOCCClass *poc = PNV_OCC_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->desc = "PowerNV OCC Controller (POWER10)";
+    poc->opal_shared_memory_offset = P9_HOMER_OPAL_DATA_OFFSET;
+    poc->opal_shared_memory_version = 0xA0;
+    poc->xscom_size = PNV9_XSCOM_OCC_SIZE;
+    poc->xscom_ops = &pnv_occ_power9_xscom_ops;
+    assert(!dc->user_creatable);
 }
 
 static const TypeInfo pnv_occ_power10_type_info = {
     .name          = TYPE_PNV10_OCC,
-    .parent        = TYPE_PNV9_OCC,
+    .parent        = TYPE_PNV_OCC,
     .class_init    = pnv_occ_power10_class_init,
 };
 
@@ -710,6 +716,37 @@ static bool occ_init_homer_memory(PnvOCC *occ, Error **errp)
             static_data.v9.core_max[i] = 1;
         }
         break;
+    case 0xA0:
+        if (chip->chip_id == 0) {
+            static_data.v10.occ_role = OCC_ROLE_MASTER;
+        } else {
+            static_data.v10.occ_role = OCC_ROLE_SLAVE;
+        }
+        static_data.v10.pstate_min = 4;
+        static_data.v10.pstate_fixed_freq = 3;
+        static_data.v10.pstate_base = 2;
+        static_data.v10.pstate_ultra_turbo = 1;
+        static_data.v10.pstate_fmax = 0;
+        static_data.v10.minor = 0x01;
+        static_data.v10.pstates[0].valid = 1;
+        static_data.v10.pstates[0].id = 0;
+        static_data.v10.pstates[0].freq_khz = cpu_to_be32(4200);
+        static_data.v10.pstates[1].valid = 1;
+        static_data.v10.pstates[1].id = 1;
+        static_data.v10.pstates[1].freq_khz = cpu_to_be32(4000);
+        static_data.v10.pstates[2].valid = 1;
+        static_data.v10.pstates[2].id = 2;
+        static_data.v10.pstates[2].freq_khz = cpu_to_be32(3800);
+        static_data.v10.pstates[3].valid = 1;
+        static_data.v10.pstates[3].id = 3;
+        static_data.v10.pstates[3].freq_khz = cpu_to_be32(3000);
+        static_data.v10.pstates[4].valid = 1;
+        static_data.v10.pstates[4].id = 4;
+        static_data.v10.pstates[4].freq_khz = cpu_to_be32(2000);
+        for (i = 0; i < chip->nr_cores; i++) {
+            static_data.v10.core_max[i] = 1;
+        }
+        break;
     default:
         g_assert_not_reached();
     }
@@ -725,6 +762,10 @@ static bool occ_init_homer_memory(PnvOCC *occ, Error **errp)
     dynamic_data.cur_pwr_cap = cpu_to_be16(PCAP_MAX_POWER_W);
     dynamic_data.soft_min_pwr_cap = cpu_to_be16(PCAP_SOFT_MIN_POWER_W);
     switch (poc->opal_shared_memory_version) {
+    case 0xA0:
+        dynamic_data.minor_version = 0x1;
+        dynamic_data.v10.wof_enabled = 0x1;
+        break;
     case 0x90:
         dynamic_data.minor_version = 0x1;
         break;
-- 
2.45.2


