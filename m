Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB7FC3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC570-0006G5-Uc; Mon, 05 May 2025 19:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56w-0006Bu-6I
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:34 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC56s-0003WU-FY
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:20:33 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224341bbc1dso65406355ad.3
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487228; x=1747092028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LuLpPX6X06+NE7HHzhZQmUoQgosCpwXTe/wCgu+rNqA=;
 b=k5esf1GaJACP/esYU7zk5AgQd/Kp0Sc2fxfe2ueTkEl6Kjnne1JOR2N1xZNQOC52r9
 n9ILqTCEI6kkGTp7s5eqmPnp6ZhJyPUQU3EeMmdioksQ8Tv0Wjm3ay3CwRARP2K9LRdo
 p1nxfiZxeVQU2xhkjdBPZAGq4jRXnc1Q0gynAJsLQXIfMM4DcxR1rhky5gk9lOkDNPlA
 /6Pp5cpD0p53p3vd1i1wmiOfdY5t5fKZ/yPJGeVp4DoK9YdAA+CqO1v5rdEL9NAgyYGc
 /y8rfHHTusrTpT0SxG5tYknESs7h+OGdLG7Vj7/RzGdTCCf3/MwR73NtC1g1HxFmGBB1
 8UVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487228; x=1747092028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuLpPX6X06+NE7HHzhZQmUoQgosCpwXTe/wCgu+rNqA=;
 b=gM9v0lmDKWO3GvAlwQBr3e482IoWSdBnVeyfoXpDAmj3tJH3yXvFcxTAtOBSmHfY6A
 Cnie2WY4GnT3MX26dDY26Ukxvj3V8UL69bSGEFjFgyDoKQ+qp6mO3d0qM4GtVpd9IZhR
 1Ub2KoJzrQ1NrS7wP0U4YY4xcQzcyMU1HG+zem8Ss0MwFMfDiW+KVWwROua8cM79YrRS
 QCWw2izHUP4vt5qYGc31FkxDl829FZNR8qs59JFAdO+BaAvzd96V71OdMe/Th74/l1lO
 CTDPm6lNpBY/oIFyQVL6j19sTEh4HacST0di7eaJ52uCC1L1NbqIcqPUje5n4lHNZgtj
 KOBg==
X-Gm-Message-State: AOJu0YwxwTHpseycpnWuUL4Yh5Bphgd/H/e/7d3Kzh5aXDNNeZwMSqoH
 PBCgoSOtFcevl6n35P+RVxiLQNzzAfdmoMrbwFKbjt0zWfjxmuWwaKXF9yFM4kuKEdUndqc1e6m
 ZjDs=
X-Gm-Gg: ASbGnctwQoWVlxANiKSGbb4xdLR9Rx1Zzj0y/HiYC8Lo84h+rhCyxOxlAjG4Rw6WlP1
 k3gScZ2rtsmSbAEbXUJrg49NvnYnFAxQb5+bCsAZg8fYlLUVNQg5p7buC0oxwr4pvkTgBjw34El
 iKrotnhn0pCLSYtOOfBBJeh7IBfy0Up2rO/vH9lw9mRyTDyY0fXAqjnviyXeYjm6gefmdphvSf1
 t1r4WZ7afqEBG5ucLrAkcxz1sBjfUk27dxn2ycc45lRS0VEelgQiXYfwQkctt1ibj2VlweQMkZN
 2W630hVeol+EeVj4YJ2BS3mmHpJhj5kKsN4dRYw8
X-Google-Smtp-Source: AGHT+IGSY/R02CKSQdqXb3iHAsgo600GkoW68E32m5EK8V2wo1QEuGkpp1ZSH6DODuTARwW1aFA+vg==
X-Received: by 2002:a17:903:2f4c:b0:223:5e76:637a with SMTP id
 d9443c01a7336-22e3620b14cmr11382035ad.23.1746487228533; 
 Mon, 05 May 2025 16:20:28 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e1522917asm60981715ad.201.2025.05.05.16.20.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:20:28 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 09/50] target/arm/cpu: remove TARGET_BIG_ENDIAN dependency
Date: Mon,  5 May 2025 16:19:34 -0700
Message-ID: <20250505232015.130990-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/cpu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 07f279fec8c..37b11e8866f 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -23,6 +23,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/page-vary.h"
+#include "exec/tswap.h"
 #include "target/arm/idau.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
@@ -1172,7 +1173,7 @@ static void arm_disas_set_info(CPUState *cpu, disassemble_info *info)
 
     info->endian = BFD_ENDIAN_LITTLE;
     if (bswap_code(sctlr_b)) {
-        info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
+        info->endian = target_big_endian() ? BFD_ENDIAN_LITTLE : BFD_ENDIAN_BIG;
     }
     info->flags &= ~INSN_ARM_BE32;
 #ifndef CONFIG_USER_ONLY
-- 
2.47.2


