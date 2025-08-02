Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A381C87FD3
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLO0-0002CZ-Bk; Sat, 02 Aug 2025 19:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNr-0001Vv-Gu
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:23 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLNm-0001iK-5Y
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:11:23 -0400
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-433f43f0012so260888b6e.2
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754176277; x=1754781077; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=6/P8S3z9ZtRQvTdRa4XHyEKuIF/OmLErI9kwQBRqBww=;
 b=R9oqF/ZB7cgQkD+Lj6E2+cGBQ626G3NMtwKXUKVIEWhPAA/rHHiigt4GTdTXEyqm2v
 6hHcWIbKqu8lL3UTcIO0U8G/xFWak7hDq4mF5xyOEDI2yiBuFU49+UJlHi16Cz/HQI2e
 Frx8AwZNzHzChafxTuqB0/cB02EDEtilm4yO/90I7l9KoKmiE/FA3tArBpZN2ifcmtJa
 tpUHSnBjXkbmAaU7croE8y+NdYEdPJLfCA4MDxe4wSk6xU0+2vAgv+yRRUzGO22CORT/
 R+8/xOUJvwDee2HB4U2s5Q7qS0jpWCTrMssD+xuJk1ycBjD3Mob56bRShe+BGBd0Un/Y
 CqbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754176277; x=1754781077;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6/P8S3z9ZtRQvTdRa4XHyEKuIF/OmLErI9kwQBRqBww=;
 b=f6vIaJF1iCcXexWulGY5BZ1jjWdTgS2TCOwP9tiiJYRyxJazgNcRzZ46unEGr2ZSWB
 KmOUyfcw/JbHG2mAWN8IqNIDGOgrBsWto4jAbh4SEwikrVeBS8++k/fUVN81+CYk/i8q
 oostmGdFCUF1ATpCnOzHZvBx4xxUtAI8cb4DH3S0gj3wzjxOqFa+HnNb0zcw/T/NA0oc
 vSvyQxp2gRjoLuZA6T3Mcv+fDdmzMtX5AEZ6KCDYbldRuFlS8ZpcWyzU94KmMj3HthnL
 J3B+1ogWm3P8XnZBlxT8quN0pkvYWHaHkOg8xbISg5ATqkCGo9a+OeiWVzsalRfEAWuk
 Q92g==
X-Gm-Message-State: AOJu0YzSHmkmzsNkYLXTFbphTpngzc1ybBPIF7Kh1MoYjYDjsl6Lv8uC
 ES/e/RCb3p4oGo5XjKGpgwQtD7AfR6LeqiapJOT34Dv2Rsdsb8kmG3b2MFDaz1ZwimXgnsHrBQw
 IXj88Kaw=
X-Gm-Gg: ASbGncuaB2vArJL73qIp4l7Fr4SQ9hkuorF7yG2yg5UyKBnMtaAgvXP3zk3fgsWDcKv
 Y/nm/DB0uhVtTZQ7P/FBLNRLPB2EnyDubtnCiGdQDVmOIwhfmtrenHhIpS2mbiZodPuWr5NX1eZ
 mmuY4FSn5gImE0/d6Zj4npUKXF9/eokJB3TLJ2u3l5WUtH1xMuSoTPPI6F+TjjgHxI6cuP1ZJ/h
 iAn6zIdJkGqD/nxEmhArvjq2w1ZqCV81scRV/LkiSZXbytFfilMCrGN6vv7xyyAaEVw8+9116r6
 RjVVAnRUF3hlZABHTcqWBeHK5jrgvVdI9G1hC1VkhaneRSL/kdIw1yydNohhH86aZTmIkqRhnX7
 IHBik5sbTsfYOtxiDJSvBufu/QViRxepvDT/1nVnIhATO7txva7ovuIdCM/Ph/oQ=
X-Google-Smtp-Source: AGHT+IFwDjFX7RPFd4TtJALQ0an/X98pxrTmbiUIBiYWK93c6WGLCEH/s36iC8Fcq1KYX8sDa0+oSw==
X-Received: by 2002:a05:6808:1a02:b0:41f:79f9:1b4a with SMTP id
 5614622812f47-433f0239f0dmr2969473b6e.12.1754176276589; 
 Sat, 02 Aug 2025 16:11:16 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-61970693ed9sm1084454eaf.20.2025.08.02.16.11.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:11:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 51/95] linux-user: Move elf_core_copy_regs to arm/elfload.c
Date: Sun,  3 Aug 2025 09:04:15 +1000
Message-ID: <20250802230459.412251-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802230459.412251-1-richard.henderson@linaro.org>
References: <20250802230459.412251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x231.google.com
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

Move elf_core_copy_regs to elfload.c.
Move ELF_NREG to target_elf.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/target_elf.h |  2 ++
 linux-user/arm/elfload.c    |  9 +++++++++
 linux-user/elfload.c        | 11 -----------
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/linux-user/arm/target_elf.h b/linux-user/arm/target_elf.h
index 856ca41b16..84c7950ace 100644
--- a/linux-user/arm/target_elf.h
+++ b/linux-user/arm/target_elf.h
@@ -12,4 +12,6 @@
 #define HAVE_ELF_HWCAP2         1
 #define HAVE_ELF_PLATFORM       1
 
+#define ELF_NREG                18
+
 #endif
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
index 7de1f13f4b..b0d4dea591 100644
--- a/linux-user/arm/elfload.c
+++ b/linux-user/arm/elfload.c
@@ -199,3 +199,12 @@ const char *get_elf_platform(CPUState *cs)
 
 #undef END
 }
+
+void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
+{
+    for (int i = 0; i < 16; i++) {
+        regs[i] = tswapl(env->regs[i]);
+    }
+    regs[16] = tswapl(cpsr_read((CPUARMState *)env));
+    regs[17] = tswapl(env->regs[0]); /* XXX */
+}
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 177741522c..3fb8106858 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -210,17 +210,6 @@ static bool init_guest_commpage(void)
 #define ELF_CLASS       ELFCLASS32
 #define EXSTACK_DEFAULT true
 
-#define ELF_NREG    18
-
-void elf_core_copy_regs(target_ulong *regs, const CPUARMState *env)
-{
-    for (int i = 0; i < 16; i++) {
-        regs[i] = tswapl(env->regs[i]);
-    }
-    regs[16] = tswapl(cpsr_read((CPUARMState *)env));
-    regs[17] = tswapl(env->regs[0]); /* XXX */
-}
-
 #define ELF_EXEC_PAGESIZE       4096
 
 /* The commpage only exists for 32 bit kernels */
-- 
2.43.0


