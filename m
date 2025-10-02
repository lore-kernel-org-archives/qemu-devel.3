Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C173CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 09:14:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4FMP-0005oi-Ho; Thu, 02 Oct 2025 05:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FMG-0005mp-3j
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:16 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4FLv-0002S5-N1
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 05:12:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e42deffa8so7969675e9.0
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759396304; x=1760001104; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CQ2rCnIwrmK/IRH54N+833E/dWEkz+wW5RLLkGk+ncY=;
 b=BoM+0BIINjOPC1NCDxDLMPJtn1INMIZoWZMtH9es2qf/pnf1lB3WX3MN9ifl189UXU
 JIyhVPSIsK2HV29/IE1szQxzssP/GUGkPHZmWMpNPvE2W4FmFRNQEaQyjjTmMkoM5bwZ
 eaBlsZwRBX/nBxpo6gbKgs02fVCV/3pBziYgAoOEZQmGgJDbZw3RGavxVXp9uhrwgF1L
 yRVomCiLwYqIwcPl+TTfDg7xOQ2kSWEimN0hWbMScBUnDmqfpBX6DxKPndUj2+x4npeg
 SZ4Qcu3oOmdh2rktTYclpIysiajDCG/XzDMK1SIliTakz2T8K8YctC2nKdKjsXkDsN//
 a+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759396304; x=1760001104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CQ2rCnIwrmK/IRH54N+833E/dWEkz+wW5RLLkGk+ncY=;
 b=QGiPRUbywe8bmqFPr2Ci09/ZoOAEeX7tG0+vn+QUXRfrIxeRzZMh5TQ2vS31WOoaG4
 ubXvrd8o6b3ndpqkfocgbHJhPxEPhruxGG4Ar+/KPYhp337WrU9de8eLY+bCSj9I43YA
 wKQroGuaFXz4hGlEEJYemA/hNDruMM+ViV+N3HFj5CbvycYXZI16aT+BZBaDjj13p/xL
 /impWVIuz5QlvszeTF30wEpGd/b10Gdng2vU/kgUq2UXSsK04GhyCHHrzCzQLkuOGMTk
 Tql8FBo6Snw6bFLXOsZFOka6XgUWYl+2i27nvgJ53Ndv5L5BBXZwlk9e72f0v/Lz/DXU
 PhtA==
X-Gm-Message-State: AOJu0YyInpKSDXxUTSN08ZICBTmxXQoLsEgihgOypTsAFehgNSGoK5uO
 Yogps89QiKF79JnXx0nQz/5bqtw1pPVZSXAHll1nYv47tAMq0nCDjB5+h0q+XX8OLqOUibJ+tSw
 F7tg0Y94zPg==
X-Gm-Gg: ASbGncs974YZAKUS5rWFaSUWt+j7Nz/46AYvtQaXIaIBOTotnJHJ+N404JeuKiNaBGx
 Qelue4QBZg9QkLTQunkZs2nVtwvVf6qSzykMw7AwC27Jqg8YfoJVVbMXfwPUNXMfEZZS9QWQEFj
 mctytK1TFCDjKuToHEG6Iq00ACm1MB4Iz4e6w4mnSycuqIATVngKF3Lfm5sH1ks5vnqV9rebrjg
 QU/VFAZJRYepO4m4xNUoX1CpaTAJJFsbwsbLloOeOtJDm3nMuO3K1NE16xGl563CNmx5sf1yluO
 5RC5Qob26Was3LjEnMpivhLuPGPFKMbuQiLg82WTSgRUHC4TPbHOr6c/runx/CydoQ2LNK/EaXO
 5NZpo6SzeUn5wNweI8NdhbHLWDiEhWlACHyPd7xrRqG7Ddnv3JNJvY/MviXdfeWaf29G48xS4H9
 DoVf/wY5bfQxuouGSuiDTUrNzmkTe6zQ==
X-Google-Smtp-Source: AGHT+IHKyGUFPb0EXyDX1plut2vO1MLBa9dzXlEhiI4ZTeHa9WfKWyGpEBK28lBZOXWHPHtXS86j6Q==
X-Received: by 2002:a05:6000:25c4:b0:3e2:c41c:bfe3 with SMTP id
 ffacd0b85a97d-4255780b8f6mr5293138f8f.38.1759396304167; 
 Thu, 02 Oct 2025 02:11:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8e97f0sm2768064f8f.27.2025.10.02.02.11.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 02:11:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/9] target/s390x: Factor diag_iplb_read() out
Date: Thu,  2 Oct 2025 11:11:25 +0200
Message-ID: <20251002091132.65703-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002091132.65703-1-philmd@linaro.org>
References: <20251002091132.65703-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/diag.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/target/s390x/diag.c b/target/s390x/diag.c
index ed320fc0c1f..c2fedc55213 100644
--- a/target/s390x/diag.c
+++ b/target/s390x/diag.c
@@ -73,6 +73,24 @@ static int diag308_parm_check(CPUS390XState *env, uint64_t r1, uint64_t addr,
     return 0;
 }
 
+static bool diag_iplb_read(IplParameterBlock *iplb, S390CPU *cpu, uint64_t addr)
+{
+    if (s390_is_pv()) {
+        s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
+        if (!iplb_valid_len(iplb)) {
+            return false;
+        }
+        s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
+    } else {
+        cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
+        if (!iplb_valid_len(iplb)) {
+            return false;
+        }
+        cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
+    }
+    return true;
+}
+
 static void diag_iplb_write(IplParameterBlock *iplb, S390CPU *cpu, uint64_t addr)
 {
     const size_t iplb_len = be32_to_cpu(iplb->len);
@@ -125,23 +143,12 @@ void handle_diag_308(CPUS390XState *env, uint64_t r1, uint64_t r3, uintptr_t ra)
             return;
         }
         iplb = g_new0(IplParameterBlock, 1);
-        if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, sizeof(iplb->len));
-        } else {
-            s390_cpu_pv_mem_read(cpu, 0, iplb, sizeof(iplb->len));
-        }
 
-        if (!iplb_valid_len(iplb)) {
+        if (!diag_iplb_read(iplb, cpu, addr)) {
             env->regs[r1 + 1] = DIAG_308_RC_INVALID;
             goto out;
         }
 
-        if (!s390_is_pv()) {
-            cpu_physical_memory_read(addr, iplb, be32_to_cpu(iplb->len));
-        } else {
-            s390_cpu_pv_mem_read(cpu, 0, iplb, be32_to_cpu(iplb->len));
-        }
-
         valid = subcode == DIAG308_PV_SET ? iplb_valid_pv(iplb) : iplb_valid(iplb);
         if (!valid) {
             if (subcode == DIAG308_SET && iplb->pbt == S390_IPL_TYPE_QEMU_SCSI) {
-- 
2.51.0


