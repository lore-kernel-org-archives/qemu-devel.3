Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FB1C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDXB-00074J-G9; Thu, 06 Mar 2025 10:53:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDV2-0004TZ-6B
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:23 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUj-0006ic-Hz
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:50:50 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3910e101d0fso523641f8f.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276242; x=1741881042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=45WEuwbwgt8FZLHCG0k1p7D7jWUaWTBOxeb41hpB4VI=;
 b=oySksB7qSCvT+M1dv+wZopHnpooulBKjFZAAvzNrEJKkpGRzkyAjZa0w/xWBlNwBWp
 2Q7luN321bugJrKnPoAyglrv2JVhyvfZkuStnRA5BJLlxf1O8L4RiLE6WiKhJIUAYPEF
 ZQSI5xM3IDTkQwhwacCpXsWWdq/B1d4EBhcmuKH/B84SBwmHIloLDLvVDTBhleAYv6ae
 YiUhYJDIuVdIkchaM6jbMUl6CjjdrPrPmx2N6lkWbKh6ZQor99fPyTzOQqNehrVZzvvn
 r5IxYqZJsthJbeXoKYFpuuX43astKbZDz+LVGfv8/Bife2LRkC8b0H7qVYy8fAUbj8P/
 /J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276242; x=1741881042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=45WEuwbwgt8FZLHCG0k1p7D7jWUaWTBOxeb41hpB4VI=;
 b=pxuXSt4xyx/zwRcHUEqXH0jMt1sGU73mfd1E+V59MRPhLvF/37xrRX2p/RgfXq0Eeu
 N7OsB2olmbjv0bLYkRPbdUGLvylxvH51L+Hobd8vANF6F37adkgRFj/Dcd11HN0giXK/
 k4ZKRbp0BWrSPbWN6DTyjWDgjleVPsGra3LavtYLOetI1bSoY1Pxe88o5P0nzfqr9QjV
 DqPI0ojtHMZFQbBDG4TeFrE9ecUbNlET66Whnf/6ui434VZw300RKs6P4GJcry3LqgPu
 DWCxc06lN367WEh8/qIRzc/J9wJej1+3PoZQpIYD7Rn+vHorsimCDam11QMQgmlZye11
 KNdg==
X-Gm-Message-State: AOJu0YxmTXgulP+ITlWjOH0t22fbflxujai3kfrAYP/uF6RuXKYvjkF4
 bIadfHfviu/931fLI/7hkkWHUA1gNKJbNyHOQySRKFvqjAM6F0VTOPquOqpkLaLhu7qWvJL/rUs
 VfKE=
X-Gm-Gg: ASbGncv6g3i36VSY85J7MeKZ0iF8ZGOw0ix/8jDpHshPxhulMHYl5RTN4tPDF+Wetj5
 TaiV0+FtJu2PHUjK9BRZaPgrmVN+5BgrRxrBNeDkBkJVL/QTlPsG+XeaeDYSKWYfrtL7u0UD6IU
 q3EoAWXPbYzQHEwxQYoJoCpmXRIkVXkX3CwAJGH5tHAxD7PJlNIM+MrhZHoKUX1D65zHYRiqCv+
 nP/PShy5ffsENm/lGEChmJLjuY/sSp57nBsfWJrb8akzR6W5TEAhikAu+XUFCf+nRAI9zMdJJbO
 dkrhjixgD50gI399MLEFcRAZWFh5A7Oyi+LFB7AvmIE4S6k0bWX4sHklpuVqbGV0c0ZIorgNZLB
 mMfH6qMAz+vmVKSb0bwk=
X-Google-Smtp-Source: AGHT+IEc9ovYLf9+5GJyVW44VeL4Ma+Wa2f2jZnVHnj8lRgsC9Tbgmq2tZggq2bXMhlnLPrfJ0LXaQ==
X-Received: by 2002:a5d:598e:0:b0:391:2f71:bbb3 with SMTP id
 ffacd0b85a97d-3912f71bc9cmr1365016f8f.46.1741276242522; 
 Thu, 06 Mar 2025 07:50:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103f41sm2369718f8f.85.2025.03.06.07.50.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/54] target/ppc: Set disassemble_info::endian value in
 disas_set_info()
Date: Thu,  6 Mar 2025 16:47:23 +0100
Message-ID: <20250306154737.70886-42-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Have the CPUClass::disas_set_info() callback always set\
the disassemble_info::endian field.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210212931.62401-7-philmd@linaro.org>
---
 target/ppc/cpu_init.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
index 425049ab093..b9772c53ecc 100644
--- a/target/ppc/cpu_init.c
+++ b/target/ppc/cpu_init.c
@@ -7401,6 +7401,8 @@ static void ppc_disas_set_info(CPUState *cs, disassemble_info *info)
 
     if ((env->hflags >> MSR_LE) & 1) {
         info->endian = BFD_ENDIAN_LITTLE;
+    } else {
+        info->endian = BFD_ENDIAN_BIG;
     }
     info->mach = env->bfd_mach;
     if (!env->bfd_mach) {
-- 
2.47.1


