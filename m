Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95301C28B20
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Mar 2025 17:56:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyDvb-0007J0-Pu; Fri, 28 Mar 2025 13:55:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyDva-0007Ia-6W
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 13:55:34 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tyDvX-0003KG-QA
 for qemu-devel@nongnu.org; Fri, 28 Mar 2025 13:55:33 -0400
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3fbaa18b810so660321b6e.2
 for <qemu-devel@nongnu.org>; Fri, 28 Mar 2025 10:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743184530; x=1743789330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EybSmwG1+RXjmkQtMMdAGfPYVQXdDRNwqAPKK7xa2Q8=;
 b=EmVlhyg8wA4bt9naE9DnU9LFT8UJTnzytSV9/4MPnEogCrvANdw5NIZbBwYvwk/Y9Y
 AhTa1KJ0nD18bj3EV098tsjz5auOreaO0iMxpGmp0NP/1GCZYjALc1DOjHMQejc/Nh9U
 1OYMfuWeVvASJtWX31ZZGloHAprMEvwdSSMkz6ty7wRQg0FBHstuDx2gwiEVACpvKJQx
 pXC2w3ZjERf+j71B9MBAsnz6AQIIx9VO6HZa6LqprVgIERbY0FTdQFAAy6SU1xUi/OVA
 +yG5+GRdzRA/P9SzZebMHoHXRp2FXOyb1Vl4vrQig0bezbI3OOBoTie86Zu+rZGCMnwp
 hkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743184530; x=1743789330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EybSmwG1+RXjmkQtMMdAGfPYVQXdDRNwqAPKK7xa2Q8=;
 b=P0lf1WYKCZF1ngQv4gmJvyrwEbgJxcr7y9cEObfclpTwOIKICGf5OtNWD3ltV5jVyF
 pMDkvbIywENG+rRyIIr5WnB4kNsh/6JjO6ctEdaRX0J1iKhwba7i+TqMYvsGeoMIhSeO
 KypcTAXhn2P/9nKcl3kjBeBLEmuT+WK7r3rnshT7QoviYtztzVz1JM6pGm0je3nNlTbh
 gra5g9imEBEipzPu7zI7k8UdXRLe2G3Q5IP0Nbr6AU423ZeeYzjyLt9UqSWm/Bn2FO6V
 UjWy73w3gdlSXQQ3K9LYenWYPcMnyiT3E1KOd1U+uAZVyLl2QqIQPC5jIPUgTenIAEmH
 gCEQ==
X-Gm-Message-State: AOJu0Yw7GLV7+SRFa0iTsyCOYmS3CAG/WQ4wFvBAGlqlUNkhkdmhCoPI
 BUDNuwEBYDxBSUaYhGrO5j2TCDdXL1Q+FrWskabCYVlFLXmkawvSfAuNJ4o5gWgpV4BFZZyhffY
 j
X-Gm-Gg: ASbGncsbkbu+bJ4B+xrSTfQEP+v1hT40KkFz+gsEMrzpDIYt4BNGIsoSo2n1G7D+QN/
 BW499zpV3/arrMWM9+gV0QdLSy0lEqbQsNN9GPbss+YMo7nU8jiI5yntciTp0p2UWQI0gyvFp3s
 G+98ZS5GKhfzkT11YJeQ7xuR6+jkgkzJg6paust2rtEnlZ4oXA1CE7PtS7fMSjYnSbK1XWxpJSd
 b1307FhHPYAnEZFLM3ODCVbUCTp4VvvOKM0BLbEDw4MQFGDaT9LU/t4C7Jfop/q6O5iQjfcX6T0
 9SJ3DxEeClehN+saLLl1rYN5ZOgzzVsmnjFKtigjuHwVnrFVchJFpG1TF7QLQg5rGH9ilMdRaRL
 jAjDq4oZxY28=
X-Google-Smtp-Source: AGHT+IG4N+7WiuvIDandEcPzovNkmXfgq/TcqRVrXpj11lDtQ7xhMGhes7x5ifiW0Ulg+e23iehBtQ==
X-Received: by 2002:a05:6808:120a:b0:3f8:3eeb:1192 with SMTP id
 5614622812f47-3ff0f60ffd6mr111322b6e.27.1743184530162; 
 Fri, 28 Mar 2025 10:55:30 -0700 (PDT)
Received: from stoup.. (syn-071-042-197-003.biz.spectrum.com. [71.42.197.3])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff0529511esm410338b6e.46.2025.03.28.10.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 10:55:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
 arikalo@gmail.com
Subject: [PATCH 1/3] target/mips: Revert TARGET_PAGE_BITS_VARY
Date: Fri, 28 Mar 2025 12:55:24 -0500
Message-ID: <20250328175526.368121-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328175526.368121-1-richard.henderson@linaro.org>
References: <20250328175526.368121-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x232.google.com
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

Revert ee3863b9d41 and a08d60bc6c2b.  The logic behind changing
the system page size because of what the Loongson kernel "prefers"
is flawed.

In the Loongson-2E manual, section 5.5, it is clear that the cpu
supports a 4k page size (along with many others).  Therefore we
must continue to support a 4k page size.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/mips/cpu-param.h             | 5 -----
 hw/mips/fuloong2e.c                 | 1 -
 hw/mips/loongson3_virt.c            | 1 -
 target/mips/tcg/system/cp0_helper.c | 7 +------
 target/mips/tcg/system/tlb_helper.c | 2 +-
 5 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/target/mips/cpu-param.h b/target/mips/cpu-param.h
index 11b3ac0ac6..8fcb1b4f5f 100644
--- a/target/mips/cpu-param.h
+++ b/target/mips/cpu-param.h
@@ -18,12 +18,7 @@
 #  define TARGET_VIRT_ADDR_SPACE_BITS 32
 #endif
 #endif
-#ifdef CONFIG_USER_ONLY
 #define TARGET_PAGE_BITS 12
-#else
-#define TARGET_PAGE_BITS_VARY
-#define TARGET_PAGE_BITS_MIN 12
-#endif
 
 #define TCG_GUEST_DEFAULT_MO (0)
 
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index 646044e274..2a8507b8b0 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -334,7 +334,6 @@ static void mips_fuloong2e_machine_init(MachineClass *mc)
     mc->default_cpu_type = MIPS_CPU_TYPE_NAME("Loongson-2E");
     mc->default_ram_size = 256 * MiB;
     mc->default_ram_id = "fuloong2e.ram";
-    mc->minimum_page_bits = 14;
     machine_add_audiodev_property(mc);
 }
 
diff --git a/hw/mips/loongson3_virt.c b/hw/mips/loongson3_virt.c
index db1cc51314..1da20dccec 100644
--- a/hw/mips/loongson3_virt.c
+++ b/hw/mips/loongson3_virt.c
@@ -677,7 +677,6 @@ static void loongson3v_machine_class_init(ObjectClass *oc, void *data)
     mc->max_cpus = LOONGSON_MAX_VCPUS;
     mc->default_ram_id = "loongson3.highram";
     mc->default_ram_size = 1600 * MiB;
-    mc->minimum_page_bits = 14;
     mc->default_nic = "virtio-net-pci";
 }
 
diff --git a/target/mips/tcg/system/cp0_helper.c b/target/mips/tcg/system/cp0_helper.c
index 01a07a169f..8c2114c58a 100644
--- a/target/mips/tcg/system/cp0_helper.c
+++ b/target/mips/tcg/system/cp0_helper.c
@@ -877,18 +877,13 @@ void update_pagemask(CPUMIPSState *env, target_ulong arg1, int32_t *pagemask)
     if ((mask >> maskbits) != 0) {
         goto invalid;
     }
-    /* We don't support VTLB entry smaller than target page */
-    if ((maskbits + TARGET_PAGE_BITS_MIN) < TARGET_PAGE_BITS) {
-        goto invalid;
-    }
     env->CP0_PageMask = mask << CP0PM_MASK;
 
     return;
 
 invalid:
     /* When invalid, set to default target page size. */
-    mask = (~TARGET_PAGE_MASK >> TARGET_PAGE_BITS_MIN);
-    env->CP0_PageMask = mask << CP0PM_MASK;
+    env->CP0_PageMask = 0;
 }
 
 void helper_mtc0_pagemask(CPUMIPSState *env, target_ulong arg1)
diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index ca4d6b27bc..123639fa18 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -875,7 +875,7 @@ refill:
             break;
         }
     }
-    pw_pagemask = m >> TARGET_PAGE_BITS_MIN;
+    pw_pagemask = m >> TARGET_PAGE_BITS;
     update_pagemask(env, pw_pagemask << CP0PM_MASK, &pw_pagemask);
     pw_entryhi = (address & ~0x1fff) | (env->CP0_EntryHi & 0xFF);
     {
-- 
2.43.0


