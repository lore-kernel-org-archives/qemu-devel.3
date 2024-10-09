Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C158CF042E
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:06:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCN-0004DN-PP; Tue, 08 Oct 2024 20:05:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCM-0004Cf-Jy
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:02 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCK-0002es-K2
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:02 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-7ae3d7222d4so5232425a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432299; x=1729037099; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hoQpjuwa20HwjACHrMlYHXe57YCg2K0w30eV5HVGvRc=;
 b=SYMsuIHGwC3Jq0/0Pvmcsj3PZYiJvofyiTMeXa6wy1V4+xxh0iiVUrT5x9nn/v0Ku4
 ppDaVI/KHL1NyHPEIDt6ohL4heMcs/GpggyciFeTocF59b4RGdaQTJlnmY82WW/UGx+X
 A2M6MYoWfFqKrrz1O0A11iliqbKEvQoHcIow3OulRB6qBzUt32zGwi2xCyJYrvxZniDG
 sSYoDastUSdctof8CANvFalV5LIAwKQNIcFB4aqFy+rPXkmMRoHVuKdDa8X6e9F1I544
 QY4d7OwaJgRw7ew9OjedISxQpI1CKhe0U5y48z/ZqdvhnEDBOwCQJleqBova2n6YTyo2
 btbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432299; x=1729037099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hoQpjuwa20HwjACHrMlYHXe57YCg2K0w30eV5HVGvRc=;
 b=T40pB3/0ggjazjzR1GSLLtdsigSXxuxtyxI5t8NXYrn9D1rjZ83NDvQmL969y0aIwg
 C1qjGXI6bLXpetmbFDVbfcB2lohoGn5nodXuHR1MhRw5IdfMTc78StHTfbmI30saGFmf
 WZN4unQKQHykON1AnsQma8M03nb+XzdlNMpaVA14LEXX4Nofqh8nOg563QbokGWsLbff
 Nmr3yq4XbWMMiYAnbv7uf9ypti2O2lFQ320/EZIjdAEBvXf3kGZgzb5Gf8pl8N002uE5
 8PU6cpMX/FnKTHm5B9coRYeXU9x3f1Qo7n5toU86IStEgkfxyRWc/TyHET1TrLSsPgoE
 ZPng==
X-Gm-Message-State: AOJu0YxtyoN4zlQ7oVC6M3uxHb8iUdyX3rIp7HZAN+JgybytIx8XgJUO
 uwApPIpevQUDOictMEP1M6Ym4XpNuWcdjTKHcuMfslp8YS8oYJckk9A7IFqu69oho3SNNo1yQql
 s
X-Google-Smtp-Source: AGHT+IEeu9+lnXWIBhz7pgvstBsOBX6KI79/ZD6KPp8fSOXLhjN4UEVyBQB1oHIG/Wwjwoi0un6x8Q==
X-Received: by 2002:a17:903:2b05:b0:20b:6d8c:463 with SMTP id
 d9443c01a7336-20c637557d0mr12308135ad.35.1728432299121; 
 Tue, 08 Oct 2024 17:04:59 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.04.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:04:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org,
 Helge Deller <deller@gmx.de>
Subject: [PATCH v3 04/20] include/exec/memop: Introduce memop_atomicity_bits
Date: Tue,  8 Oct 2024 17:04:37 -0700
Message-ID: <20241009000453.315652-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Split out of mmu_lookup.

Reviewed-by: Helge Deller <deller@gmx.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/memop.h | 24 ++++++++++++++++++++++++
 accel/tcg/cputlb.c   | 16 ++--------------
 2 files changed, 26 insertions(+), 14 deletions(-)

diff --git a/include/exec/memop.h b/include/exec/memop.h
index f53bf618c6..b699bf7688 100644
--- a/include/exec/memop.h
+++ b/include/exec/memop.h
@@ -193,4 +193,28 @@ static inline unsigned memop_alignment_bits(MemOp memop)
     return a;
 }
 
+/*
+ * memop_atomicity_bits:
+ * @memop: MemOp value
+ *
+ * Extract the atomicity size from the memop.
+ */
+static inline unsigned memop_atomicity_bits(MemOp memop)
+{
+    unsigned size = memop & MO_SIZE;
+
+    switch (memop & MO_ATOM_MASK) {
+    case MO_ATOM_NONE:
+        size = MO_8;
+        break;
+    case MO_ATOM_IFALIGN_PAIR:
+    case MO_ATOM_WITHIN16_PAIR:
+        size = size ? size - 1 : 0;
+        break;
+    default:
+        break;
+    }
+    return size;
+}
+
 #endif
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index a975fe5f89..35cda1e2b0 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -1767,20 +1767,8 @@ static bool mmu_lookup(CPUState *cpu, vaddr addr, MemOpIdx oi,
      * Device memory type require alignment.
      */
     if (unlikely(flags & TLB_CHECK_ALIGNED)) {
-        MemOp size = l->memop & MO_SIZE;
-
-        switch (l->memop & MO_ATOM_MASK) {
-        case MO_ATOM_NONE:
-            size = MO_8;
-            break;
-        case MO_ATOM_IFALIGN_PAIR:
-        case MO_ATOM_WITHIN16_PAIR:
-            size = size ? size - 1 : 0;
-            break;
-        default:
-            break;
-        }
-        if (addr & ((1 << size) - 1)) {
+        a_bits = memop_atomicity_bits(l->memop);
+        if (addr & ((1 << a_bits) - 1)) {
             cpu_unaligned_access(cpu, addr, type, l->mmu_idx, ra);
         }
     }
-- 
2.43.0


