Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE90C02188
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJrs-00012E-Nn; Sat, 18 Jan 2025 20:12:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJrq-00011v-KZ
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:46 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJrp-00038D-5s
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:12:46 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2f42992f608so4731189a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249163; x=1737853963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bewvRjNkwqzDyxfwcvQhUAmA2KHQQaF3sWX+p2yTLCo=;
 b=dbFe24Syp1R7KP8zqq1V8vkiT7lzM1mSfQAS4pbAEpnIT4IMOKJxDnx7DbNHs257nX
 jibf/F5FEudEbFIqqJtT6nWRTzwNQANtByCxX0hIZU1l16lqCcUAiJe9uLH44XpYW/MO
 oD20t/L0YnyDpowPSNcSqzGODFLFUXz5VHgdUGurha63xxpbFZBmEPve6xQ4zpSZiWLt
 fnHW3CtvR/4uU9e4CWEYiJFnkRVMg0twQ7PREEvgY0R7qQRx9S5H2gyMHPEfrKrQK0hn
 Yz5m2P8+EDGyTCAvJU+/jDqqB/0CDN/YpD6rp4UO+KUIcL489pHD5B/pY0gBzUMcFRpS
 8p1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249163; x=1737853963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bewvRjNkwqzDyxfwcvQhUAmA2KHQQaF3sWX+p2yTLCo=;
 b=FBmbjq2LDJZuSSaAB1aXlqT5PSqPVHpVCt0fsb/EColk2ravctq/kb/EkgDqzijN+U
 Z4Y+KvGMxDGKISGlNJ7l5akRB9MhVKOD19TjLf0SZTKsOGkKlJ5t5jUclNBMLb3zteV6
 SvlObZezOdd51lgKT5X7KYjCB5x0KQbluxw2NBEj5aOjjFp1Sbx09jZ8Oo6RZzYZMm2Y
 1EugfIXP/o4o/Ht0XpmT8ofse4OSE2vXdmiTH5JOK+7tUqBXskpn+wi6PNmyWo2ZSoA3
 H8JKz7ANOjECr7lGkxzqhhyrFlhraBd00/1hCSrFnMP7bdEeLRzCxoiLnAiBD0ji936y
 ry3A==
X-Gm-Message-State: AOJu0YzBj/DlJsP0i8C4DyEvX33TzoOCVIYFu9MT6sK8J7BIfjvMzvEj
 BC5cgDlamfDs5Sig9s5leJI+1KGSwfCdgi3bIb7YFXNqeVju/7igNuRodqBY
X-Gm-Gg: ASbGnctqdXYszQP8lHwb/DRgqMfOEw8sPIyHkpO3XN8dRydTHs3DKqZmIyTzJIJPSSa
 H7PYhv8ROCIbti3aWOU9up/r5hwKb58lVQoGWiGvoNmqob5KJRRX4q4rnSF8fIU0K7DL8GvlcqY
 Mh8Si0wjaCXdacuquIH0o3y5oKFX7kNkhI+B225Y4k/NzWqMz001wFClezet+Dy/gJZvbtebVmh
 Av1dzTbkPnAgRAEJ1+Ht9Ln39PdCpAVAXXQvX2DhhL/IkQtmwBMtgm5AI63eCvvdAEkVbTGQQDi
 Vp9ZDh2vy2m/SV62vUCISOAL20tWy2GdHm71qzBOYWfyPhOb6DSL420QfPyYEV7tvaVTgEC+sQ=
 =
X-Google-Smtp-Source: AGHT+IFFy3+z0tgjnmFOQBfg1TY0JCGMpscuRtaPkj9a7FnI10ItfzFckEshdejKn7dVB7K7RsrS/Q==
X-Received: by 2002:a17:90b:2e41:b0:2ee:f19b:86e5 with SMTP id
 98e67ed59e1d1-2f782c71ec7mr13084516a91.14.1737249163587; 
 Sat, 18 Jan 2025 17:12:43 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:12:43 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Craig Blackmore <craig.blackmore@embecosm.com>,
 Helene CHELIN <helene.chelin@embecosm.com>,
 Paolo Savini <paolo.savini@embecosm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 02/50] target/riscv: rvv: speed up small unit-stride loads
 and stores
Date: Sun, 19 Jan 2025 11:11:37 +1000
Message-ID: <20250119011225.11452-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Craig Blackmore <craig.blackmore@embecosm.com>

Calling `vext_continuous_ldst_tlb` for load/stores up to 6 bytes
significantly improves performance.

Co-authored-by: Helene CHELIN <helene.chelin@embecosm.com>
Co-authored-by: Paolo Savini <paolo.savini@embecosm.com>
Co-authored-by: Craig Blackmore <craig.blackmore@embecosm.com>

Signed-off-by: Helene CHELIN <helene.chelin@embecosm.com>
Signed-off-by: Paolo Savini <paolo.savini@embecosm.com>
Signed-off-by: Craig Blackmore <craig.blackmore@embecosm.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241218142353.1027938-3-craig.blackmore@embecosm.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/vector_helper.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 0f57e48cc5..ead3ec5194 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -393,6 +393,22 @@ vext_ldst_us(void *vd, target_ulong base, CPURISCVState *env, uint32_t desc,
         return;
     }
 
+#if defined(CONFIG_USER_ONLY)
+    /*
+     * For data sizes <= 6 bytes we get better performance by simply calling
+     * vext_continuous_ldst_tlb
+     */
+    if (nf == 1 && (evl << log2_esz) <= 6) {
+        addr = base + (env->vstart << log2_esz);
+        vext_continuous_ldst_tlb(env, ldst_tlb, vd, evl, addr, env->vstart, ra,
+                                 esz, is_load);
+
+        env->vstart = 0;
+        vext_set_tail_elems_1s(evl, vd, desc, nf, esz, max_elems);
+        return;
+    }
+#endif
+
     /* Calculate the page range of first page */
     addr = base + ((env->vstart * nf) << log2_esz);
     page_split = -(addr | TARGET_PAGE_MASK);
-- 
2.48.1


