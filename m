Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FFD8D15DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:14:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2u5f-0007Ed-Hl; Mon, 21 Oct 2024 11:13:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2u5d-0007EA-M1
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:13:01 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2u5c-0004FK-1L
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:13:01 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5ebbfcab9f4so650614eaf.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729523578; x=1730128378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C0HdwaAyMbLAnxeqWSFg1qQPtzawRcKFfuED+8dejwo=;
 b=YbudDpc9c06pYlp/zmxmEqUOtMIdOJAX3X7HUQ65S7R+IWkx/RzlH3seekXLNiI0an
 dCEM/FhY+DMQgPXX8c2zn1LJmFxokbBa/0NCtvTt3gbGM2Eswcl+YOIBzu3VzGoFga7p
 2hhqO9KgwB2WH/pZSHhCd/SWlH92wB1ACq6bYGkPZ0gnTWrbqkjETK9wj7d8A3iLDyUc
 HdV70zwJmBZm7nIk8GHkZ3/3dIyCSFxT7jH5aDNm+j88HlV/LopO34DOkxhQ1suYBj+d
 Tk0lL95boN6wnx6NlUvkynwQdyt8d8bPIsSdBhCXAeh3YZyoTIJ8Fg3Tb0IcAGMsSmm5
 5HhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729523578; x=1730128378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C0HdwaAyMbLAnxeqWSFg1qQPtzawRcKFfuED+8dejwo=;
 b=E2mhZkeUzxhgIFplnlDkJhSpsfrFCjJfvA7MAJ5GSYNm5bFKFsZnXS5hUSws/7d/ZG
 XXpThEG0j8dsJ/kA4UIdF3FMi5k5TZiVcGeBqggVKr1cestXTHySe3dc5rE8XRGQtAMu
 XrfPRmciMwEXq6fiqHaPZDSMhK4ukqwU3iWi9k7QBhXLPYLSxJIM1xWum42NOtGNS0BU
 bbxIW6q+TmDlhvPmzZdBAzc/saQU+v3QTTv6w9NGPItniBe+DFIMnnPuYW03s1+WSBl4
 b2C16WYtymYCjzfBZDtLO+8F0leXj23xgIQHV1tIchg1wnaT/Gy0+miJh+hDhGuTFmpR
 0SLg==
X-Gm-Message-State: AOJu0Yy1jkEAtnVvo6Z4s0dQrZKIHQeDMZ6ym1ZLAmNCRu3ycmf+ZUTl
 Zu8CwfYbQFev5f/ZXREaNXXINqMnhSLZj+bw1ZmCIiOhD/K92ID+S9/v4L7uK+frGb7kURhorU6
 J
X-Google-Smtp-Source: AGHT+IFncFk3fpmnHQyP/YrWv+fDN0vViTVx6ZRCYtlj8n98tKWG/h24xGShfkWIlLDl7LFTqRXt7A==
X-Received: by 2002:a05:6870:9a23:b0:277:f9d5:e85 with SMTP id
 586e51a60fabf-2892c3422b3mr8889645fac.22.1729523578088; 
 Mon, 21 Oct 2024 08:12:58 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7eaeabda178sm2752879a12.87.2024.10.21.08.12.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 21 Oct 2024 08:12:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH] target/mips: Remove unused CPUMIPSState::current_fpu field
Date: Mon, 21 Oct 2024 12:12:53 -0300
Message-ID: <20241021151253.36443-1-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=philmd@linaro.org; helo=mail-oo1-xc30.google.com
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

The 'current_fpu' field is unused since commit f01be154589
("Move the active FPU registers into env again, and use more
TCG registers to access them").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/cpu.h            | 1 -
 target/mips/sysemu/machine.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/mips/cpu.h b/target/mips/cpu.h
index 6a4c4ea683a..3c235f39ffc 100644
--- a/target/mips/cpu.h
+++ b/target/mips/cpu.h
@@ -530,7 +530,6 @@ typedef struct CPUArchState {
     CPUMIPSFPUContext active_fpu;
 
     uint32_t current_tc;
-    uint32_t current_fpu;
 
     uint32_t SEGBITS;
     uint32_t PABITS;
diff --git a/target/mips/sysemu/machine.c b/target/mips/sysemu/machine.c
index 91cd9f19002..8af11fd896b 100644
--- a/target/mips/sysemu/machine.c
+++ b/target/mips/sysemu/machine.c
@@ -242,7 +242,7 @@ const VMStateDescription vmstate_mips_cpu = {
 
         /* CPU metastate */
         VMSTATE_UINT32(env.current_tc, MIPSCPU),
-        VMSTATE_UINT32(env.current_fpu, MIPSCPU),
+        VMSTATE_UNUSED(sizeof(uint32_t)), /* was current_fpu */
         VMSTATE_INT32(env.error_code, MIPSCPU),
         VMSTATE_UINTTL(env.btarget, MIPSCPU),
         VMSTATE_UINTTL(env.bcond, MIPSCPU),
-- 
2.45.2


