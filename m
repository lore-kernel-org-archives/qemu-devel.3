Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F981C5AC67
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wssQG-0000Mu-Hf; Sat, 08 Aug 2026 21:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQE-0000Lc-Tj
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:54 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wssQD-0002Lh-7l
 for qemu-devel@nongnu.org; Sat, 08 Aug 2026 21:33:54 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-38e88b60121so644531a91.3
 for <qemu-devel@nongnu.org>; Sat, 08 Aug 2026 18:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786239232; x=1786844032; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4jhjL0sYTcEwoMlXIeDPnxkRkvt5ThgU+Lk3I6u8abI=;
 b=PuL86wKbOZC8u14jEO2eNJ0m4SAW3TyFyF5L1LjyJIz7X7TrGUB+T5zzCi1D8b7Gcu
 H1abtRjcpzTsqiYYlmkxJH/Nep9JubWx1ZdwIxKdHpuVSOZrQJBh2/st+c/IurWOjMBB
 MUxlggBeJAJSIFhZ4Jm1fNp4QNR7rwTvyf75eIRYw3bXccobw93YFrt2ixhohlsrs4VJ
 q+oH0nRU40hf6K9eUOf/N9eyJK8x6+bm2mKChRuP1HZ2n4AN9AAXsI8ZauHH65vbtiYp
 K+W7yAbGay/yvIAXlJpzWeXri/F1Nz8eXqqU1ICLDrypNwgOQ24ugQkBXSXPRseefVNX
 aaEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786239232; x=1786844032;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4jhjL0sYTcEwoMlXIeDPnxkRkvt5ThgU+Lk3I6u8abI=;
 b=QakikvHEnOvUuDu8T8sZTIlDZ/zxGi5VbItFvVmGWlPOKgPaETgIu5Tk1GVAzK9iy5
 x2kb4TI0ntB3LL00W+Pn62WXtDhM4+mQ+o5W4hz4hBSN7K6VRjTz6u1XPSnLYKfJopWk
 k7elBD5+wcLg7BhDl8OGG875y6m4uwOwrp2alChEQu6LT7Ye8Ph6G2UCkpNT8T7F94Bw
 1owZIk8JXFVrH4VRih31Uxp4zhgF6u4qQ+1ReJSU7ZphnPfL//lbvin5bXgndQIbjDZv
 b3hl311lL8dkhK4f1ESsfsldfjO9QiSVkaR69U9V75/a4SX9RgEmpQBrFZ5zym7xzgzZ
 TMNA==
X-Gm-Message-State: AOJu0YwY2kcNEsuk/e+BNcTFGN+jqvCviGv3l+C/RtmOlFMHlKlpVGJ5
 FkxTPa1mPNvdvytIaQj4vX9CruAcxR6vKnRcQIj7MOzmnEht03luERSQypOI9eot/qrgOSDNIwM
 BmNzY
X-Gm-Gg: AR+sD12N3/as+16t8TWY28vXGsQ3EwKVnsmPqgjqLV5Doek/KiFEalJ8BWge63TBpvc
 5CjDFIE4YN7UqHb4qGOdoiXfDXCevXeuxf5gGg7a8YYMd8XhltD1xIUSlQcXJAKmJu/ON40u9lb
 LT0iElr31Bl1rcuCBjj7xDjgu+kyy55uvsu8pBZ8rGRk3Zku7HI6tkZT5qmpjQfBUMlECzSufWi
 VYrxcocJhnj44Nb+z14CPHHb8wZ+N1fsW8NuB9S6DBpJ8hUyurt/vFpFmK33gDzWSrhxAa+LbQT
 Uj8TBZ7c2Dcj+twxce27dbdqB8ZZi8NWw/a8zoS+F5Xi0ZsJL12A0S1r4O0wK+WckTaIbvFAEHA
 AAdaNPm2yLcKK0oecwL+ovViI5MMEMt+fyUl2pAuuI3ppBofZI1NXoVPrIl8gG250WghXtYFY48
 z8FpabsP6d/nU4CFjdv2YbvtJ2OPr6hPfX17ZaU+OpodkFBsgBH4JShOnPdHD+cRzfVeFDlhn05
 KI3C6Jzw+2cE5NZlPUw
X-Received: by 2002:a17:90b:4c84:b0:381:c500:b0d1 with SMTP id
 98e67ed59e1d1-39282554a40mr9570798a91.20.1786239231660; 
 Sat, 08 Aug 2026 18:33:51 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085de8ddcsm10067927a91.6.2026.08.08.18.33.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 18:33:51 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: 17746591750@163.com, laurent@vivier.eu, philmd@mailo.com,
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Subject: [PATCH 6/9] target/loongarch: Enable disassembly via capstone
Date: Sat,  8 Aug 2026 18:33:40 -0700
Message-ID: <20260809013343.664966-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260809013343.664966-1-richard.henderson@linaro.org>
References: <20260809013343.664966-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/disas/capstone.h | 6 ++++++
 target/loongarch/cpu.c   | 8 ++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/disas/capstone.h b/include/disas/capstone.h
index db1abe7f70..a922f7627f 100644
--- a/include/disas/capstone.h
+++ b/include/disas/capstone.h
@@ -40,6 +40,12 @@
 
 #endif /* CONFIG_CAPSTONE */
 
+#if CS_API_MAJOR < 6
+#define CS_ARCH_LOONGARCH       -1
+#define CS_MODE_LOONGARCH32      0
+#define CS_MODE_LOONGARCH64      0
+#endif
+
 #if CS_API_MAJOR < 5
 #define CS_ARCH_RISCV           -1
 #define CS_MODE_RISCV32          0
diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index fb03424ffa..7007622630 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -29,6 +29,7 @@
 #include <linux/kvm.h>
 #endif
 #include "tcg/tcg_loongarch.h"
+#include "disas/capstone.h"
 
 const char * const regnames[32] = {
     "r0", "r1", "r2", "r3", "r4", "r5", "r6", "r7",
@@ -694,8 +695,15 @@ static void loongarch_cpu_reset_hold(Object *obj, ResetType type)
 static void loongarch_cpu_disas_set_info(const CPUState *cs,
                                          disassemble_info *info)
 {
+    CPULoongArchState *env = cpu_env((CPUState *)cs);
+
     info->endian = BFD_ENDIAN_LITTLE;
     info->print_insn = print_insn_loongarch;
+
+    info->cap_arch = CS_ARCH_LOONGARCH;
+    info->cap_insn_unit = 4;
+    info->cap_insn_split = 4;
+    info->cap_mode = is_la64(env) ? CS_MODE_LOONGARCH64 : CS_MODE_LOONGARCH32;
 }
 
 static void loongarch_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.43.0


