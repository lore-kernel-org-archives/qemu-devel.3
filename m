Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA36CCF9EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:18:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLA0-0007AE-Kn; Mon, 27 Oct 2025 07:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9g-0006d3-Mg
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:53 -0400
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vDL9D-0007dk-EQ
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:12:52 -0400
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-63d6ee383bdso9783529a12.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 04:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761563537; x=1762168337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W/iOxgVLV7ayfoY5ug7v4UBSScUkrPrd3MmiVSvSTZ8=;
 b=wXcgQe5yVb/onyd75PQDNyyLH4zEYZlSDUVqTI7oNKbCeNdOuy47I/F4eh667zeYu2
 5PYUe0VEkSexE5toCZKjflzuWUl3JUUb4ivvBsNqLK9geNF1vwlQRhy3atN7NvcNSPtT
 WBdT3fDtoX6tG3unummcAepqtgroSclW4T8tCYn0rygKBVVASpzSCoYj9irbrDvWylBN
 aJgl4yg73VPIUKmquvv/t8CeFjUa/j3D+ZJsq4RwzvXPGRXvVTcfF/VB/hczZ7aZAh8W
 T+q/e7KhcYEC4N/q/9V/Qk04r61ABtCU4Qn+mG839MxzI7leS9LAuW0+EA5Ssycei0zg
 cjJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761563537; x=1762168337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W/iOxgVLV7ayfoY5ug7v4UBSScUkrPrd3MmiVSvSTZ8=;
 b=lMksADHTJZRFJM3EPnMnzWlOUUMZkcTgYH3xrYvyJ/5V+7LCNdkY4njS6MoNLLvMxF
 gHborwauUXu9bl8dj1DujCRenRqBa5WAuj5FPBAFWTYVTPBpJ2s9DhpFrc1wTLytpvSh
 CzNOR02HhHU2ElKnXTPJewvLyK+N6Ar6J/UhLhw3DTERU/Qr6tzyxjiEHqQ/+Ymas/Nj
 rrXa3Kyg1G12b+/5Kmt9LTJCz51icladJjVcpPcHHEAFJopL5krs5eUQDZfnkN09+TNU
 Sa51Oscge9KUYZRRZNa4w35d3qPlRL+2FGhWEabhk7MePetdlKWIEfOZZeDLozA6iZ/w
 irAw==
X-Gm-Message-State: AOJu0YxBOj2epC912+CL+Oyz80BNFCyAUKHt4Qa6vvVGxfOthNttS33F
 FreGpzgQdLc7C2o+H5snCmck9apHgKk5Qbi6ECDLjgNkKLvAlUlQiW1C5vDZoEb6dSI=
X-Gm-Gg: ASbGnctYeBETx7F/pB8dyBKMCdYGAfjZtORudKvoxJhw2CKsylmie86oLrJvKOAm9Sk
 Q6wL5NbPrSQgl6LDWJFCqZhlkAgVm9OKTocz/B9Szo/oqY2uoisI6uOeeqk5ahmwqYKLw8RWodS
 hceesLAy5eHmWHLtgeziFsxVE91Wy0sKYF2PDNozD1PZ29wiViIS+gO4OO6UWurvsyJ2RlJHAIa
 ZZscVITALwcTdTv/WlFA+LphLW0a5PCsVXOzKpBgYDGAEH6ZRnO+weiRIc313bJswpUA7L2sFnv
 PYzHv2obp1uMGjfIMY8tIaP4hTHI3tt8z33Ad2mVnVcpc6jiz0QYArif6RnkLx9T1ow4lAtA+yq
 Y2s4Z/S9CJkwBbswCa9IsyiKEgXy8MNN2yCM8C0YhGwWgOfs7GQ3JdrJkxyxmaqIWimrjxVlQpJ
 3RtDj/yYKv86k=
X-Google-Smtp-Source: AGHT+IGhsq9zSRESJBDIy2OiiKM1bVTFG6U4x3jHc5iycQNI9bx7qUJrdez6Sl0r++blgXVMg0SA3A==
X-Received: by 2002:a05:6402:268a:b0:62a:a4f0:7e4f with SMTP id
 4fb4d7f45d1cf-63c1f6c21e0mr33780942a12.29.1761563537074; 
 Mon, 27 Oct 2025 04:12:17 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef82b6esm6076455a12.11.2025.10.27.04.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 04:12:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D4DBB60D8F;
 Mon, 27 Oct 2025 11:03:45 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Chinmay Rath <rathc@linux.ibm.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Stafford Horne <shorne@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Laurent Vivier <laurent@vivier.eu>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Michael Rolnik <mrolnik@gmail.com>,
 Song Gao <gaosong@loongson.cn>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Julian Ganz <neither@nut.email>
Subject: [PATCH 19/35] target/mips: call plugin trap callbacks
Date: Mon, 27 Oct 2025 11:03:26 +0000
Message-ID: <20251027110344.2289945-20-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251027110344.2289945-1-alex.bennee@linaro.org>
References: <20251027110344.2289945-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Julian Ganz <neither@nut.email>

We recently introduced API for registering callbacks for trap related
events as well as the corresponding hook functions. Due to differences
between architectures, the latter need to be called from target specific
code.

This change places hooks for MIPS targets. We consider the exceptions
NMI and EXT_INTERRUPT to be asynchronous interrupts rather than
exceptions.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Julian Ganz <neither@nut.email>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/mips/tcg/system/tlb_helper.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/mips/tcg/system/tlb_helper.c b/target/mips/tcg/system/tlb_helper.c
index 1e8901556d6..566924b079e 100644
--- a/target/mips/tcg/system/tlb_helper.c
+++ b/target/mips/tcg/system/tlb_helper.c
@@ -18,6 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "qemu/bitops.h"
+#include "qemu/plugin.h"
 
 #include "cpu.h"
 #include "internal.h"
@@ -1034,6 +1035,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
     bool update_badinstr = 0;
     target_ulong offset;
     int cause = -1;
+    uint64_t last_pc = env->active_tc.PC;
 
     if (qemu_loglevel_mask(CPU_LOG_INT)
         && cs->exception_index != EXCP_EXT_INTERRUPT) {
@@ -1052,6 +1054,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
         cs->exception_index = EXCP_NONE;
         mips_semihosting(env);
         env->active_tc.PC += env->error_code;
+        qemu_plugin_vcpu_hostcall_cb(cs, last_pc);
         return;
     case EXCP_DSS:
         env->CP0_Debug |= 1 << CP0DB_DSS;
@@ -1336,6 +1339,14 @@ void mips_cpu_do_interrupt(CPUState *cs)
                  env->CP0_Status, env->CP0_Cause, env->CP0_BadVAddr,
                  env->CP0_DEPC);
     }
+    switch (cs->exception_index) {
+    case EXCP_NMI:
+    case EXCP_EXT_INTERRUPT:
+        qemu_plugin_vcpu_interrupt_cb(cs, last_pc);
+        break;
+    default:
+        qemu_plugin_vcpu_exception_cb(cs, last_pc);
+    }
     cs->exception_index = EXCP_NONE;
 }
 
-- 
2.47.3


