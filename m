Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC58C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:00:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzD4-0003c9-BZ; Tue, 11 Mar 2025 08:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCd-0001rU-Fr; Tue, 11 Mar 2025 08:59:23 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzCa-0007w2-CJ; Tue, 11 Mar 2025 08:59:23 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so8655680a91.0; 
 Tue, 11 Mar 2025 05:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741697955; x=1742302755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VqfCGsNGemWHWOkA7UQFNXiZp9CJgWEykoLLRmbbzrQ=;
 b=Ib5L4qjHqCxonO6i/DOK9BRUS9kf4WALF4m5DGlcXyT2n726aAyVLr1VXqJp+wHmYq
 /ls3ma9/n8dGKaAx1fPsmYwJpGdqkB5oaECWCs1f1GIzgZus5CXd7FS4KhMrUvlqlhFn
 wpRJ9P9KfJrrBW7kb6QSRp/ywGRCSEcgUxdW0s/Dyocmvw7AsBzgMgoH3BGG6C9pUP26
 fUhSOsMguxpvzSNoF2IIOtTj4BnM8c/tVewubj0lxQmtfAUMg3auczTILVIW5hvWitG4
 K+lJG9wLCwF2rJoJ0IWQFqhWxzO4X7FPP/0jkthw4FG5bU2S4H4JtR9KbL5acyS+X/L7
 3mlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741697955; x=1742302755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VqfCGsNGemWHWOkA7UQFNXiZp9CJgWEykoLLRmbbzrQ=;
 b=aC2TI/GBjXQ6++3BIOJG3R3pQLvsECPlYJtzfopCP4QIISubpICRH1VuX9j/7ziap5
 VpHgzj5LOVMTqQBUAAKdMzhM90ZVJCsVLMuj2JzBYn72OGQo7OjMsZ+5O/ROO+Ge+WgO
 UR0Wg8LFcmL+/fEiqtxqv7SO38Ozx6QI2DjleBGIzIM/h62KBT2AZejALa7BeAJOPGcY
 qfEczqfEoB+tNbutuopz3oviIVr5RLuGAaDisnJa5csd4AHRZ9nujsH39B+cBhy2mrET
 W/mNqPi/9QvbCPi0v3T9kSXQiUdX6PRgwEtIdMSHisbUOa4UtuG90Gu9ZScuAYpq+L7l
 hYnw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlKr+82Wi4HjCg/wn07nXog8xW897eQdQev15PHeq5rCm3YuYDujGhBPpeo8GLmHa9oqBPTsG2/w==@nongnu.org
X-Gm-Message-State: AOJu0Yxo50kY+mWoL1t2C2dJXHPy2B4mT3lL5b0iZc8VQjxM8hTyf0FZ
 MmJi1Ta5LDqQ5dn1ZuC6aUSQtYueOPtLObWrjNCTA4sXXxT1ZRPMJrgdZw==
X-Gm-Gg: ASbGncv4m/x/SOkbsj2FvQ6we3QJOkaFKD7tAeHt2gNW73SYe1MMw3K9a3zyB90qY5c
 /SK2nOt9x0phfNsar2xfvrWgqD3DKEdnyr6RAqWRB0d4+SYqRtH/OsE14xuKJew5PreLDpP4UB4
 WvQwp0ehRl/ElDHen7Zpdhfs5Vob02TWIRRD5EIfJBZTVRMiMcYKMm1rkqwKOZW9TMRRNgG+LXh
 +UxD2xlOf26VUhPTQ65J5/OCnE5Fzn0H1qyb0DVdl4il5/Y1i7Vqryjkl7xpPJnZnBdmWC/5J0V
 dupk/W/inY0W/JEiLRBIaBVxyECVwZaX++mPGPhzUFbc9oaHe14=
X-Google-Smtp-Source: AGHT+IHrvtF1tUwWVcOgMKICqjT5Ligq+yRnaV19JNLa4UiyGXeozI95dqmEq4ApzVgdnX9pbcmOmw==
X-Received: by 2002:a17:90b:1b0b:b0:2fc:c262:ef4b with SMTP id
 98e67ed59e1d1-2ff7cea9a99mr30654512a91.18.1741697955298; 
 Tue, 11 Mar 2025 05:59:15 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.05.59.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 05:59:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 14/72] ppc/pnv/occ: Add POWER10 OCC-OPAL data format
Date: Tue, 11 Mar 2025 22:57:08 +1000
Message-ID: <20250311125815.903177-15-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
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
index 19ccfe1bbf..34decb1700 100644
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
 
@@ -711,6 +717,37 @@ static bool occ_init_homer_memory(PnvOCC *occ, Error **errp)
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
+        static_data.v10.pstate_ultra_turbo = 0;
+        static_data.v10.pstate_fmax = 1;
+        static_data.v10.minor = 0x01;
+        static_data.v10.pstates[0].valid = 1;
+        static_data.v10.pstates[0].id = 0;
+        static_data.v10.pstates[0].freq_khz = cpu_to_be32(4200000);
+        static_data.v10.pstates[1].valid = 1;
+        static_data.v10.pstates[1].id = 1;
+        static_data.v10.pstates[1].freq_khz = cpu_to_be32(4000000);
+        static_data.v10.pstates[2].valid = 1;
+        static_data.v10.pstates[2].id = 2;
+        static_data.v10.pstates[2].freq_khz = cpu_to_be32(3800000);
+        static_data.v10.pstates[3].valid = 1;
+        static_data.v10.pstates[3].id = 3;
+        static_data.v10.pstates[3].freq_khz = cpu_to_be32(3000000);
+        static_data.v10.pstates[4].valid = 1;
+        static_data.v10.pstates[4].id = 4;
+        static_data.v10.pstates[4].freq_khz = cpu_to_be32(2000000);
+        for (i = 0; i < chip->nr_cores; i++) {
+            static_data.v10.core_max[i] = 1;
+        }
+        break;
     default:
         g_assert_not_reached();
     }
@@ -726,6 +763,10 @@ static bool occ_init_homer_memory(PnvOCC *occ, Error **errp)
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
2.47.1


