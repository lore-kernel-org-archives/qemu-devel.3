Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7904BC0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 22:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thc7Q-00029Z-LQ; Mon, 10 Feb 2025 17:19:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc7F-0001mp-Gq
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:18:58 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1thc7D-0002rb-CB
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 17:18:56 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-438a39e659cso33715255e9.2
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 14:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739225933; x=1739830733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JDxBZK6Uwmmy6x9bVQ84rL6dLFuW3LmWDIvF2j0Y5U8=;
 b=oztYU0VCeQXJ23Fhcy0Rm7sq5gGDJoSMFcjklO4kZZevAOqp88TecmvHIhMbs6eLCm
 85ZtDgSC9yIfyVau3CfQ8ms9rOCK+U4B77tybIjfA11sNN13kIkJ3l1sY8hnYZtTlmgK
 L/bWdyrq/CDRPBSRp4UtjFjfSQdr3bDF2HTg+5zsFHksfzlr4YsODbhzX3bAlM8AZ9jG
 04W+6Yk6t/blm+T6Z/qvnkkddbgNIh+emFMZcZyg1PZX14hYz5A+y0G60IVDaVz3gwWI
 w3hKOZ5WyWTUn+d+piu6E0qRLc2UZ61Pb7y5nfB4Unmr4bhkiLOR2ubwI6/1qct9M+Ug
 slKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739225933; x=1739830733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JDxBZK6Uwmmy6x9bVQ84rL6dLFuW3LmWDIvF2j0Y5U8=;
 b=WXUa4FGaI6i8MnsJHREt6TtULr3ogNrnzKO5tdXLy8WEWGTJyCXT4CNZrlqATRZMh8
 k5HbVN7qb2YNYWYm0e1OF/GNmEhCApK8+FareEBaEYPkQ8CjD8ao/Z5AiTfVKRIQnhMw
 CvN5BcvonPU3oclTsOs1UGJxJXzvXADVLAdWn83KlKnTlFL+J5gkMOZWd7TteSa87PHC
 XM2R2OWn+9p/eYf7IrwtvpRIosISMstXx/9LYxWgyw/0l6zdmf/fynioemStYDgWXdYO
 3HOh4tWqfTm+Ai31QddaApsLJASsgYW0WZ3PyuRrvGncuDSLClpZh8JP3nod2Uc47syL
 K4Ug==
X-Gm-Message-State: AOJu0YyK5eeQTzaMMebzKuZo6yQmMAeHI28RD0wOg5s8n3eo1cqi/km1
 th4gFUXl/TOL5cdz8qIoQZ3mKMpxlAHWCGakBLrUgCtu0AUgr0Gat5XstfRXeKonWNZowMe0F7O
 /O1s=
X-Gm-Gg: ASbGncvhmV5wqLMNWt3vW4UJ6eJVqhQQbSXpEExmvpDfyE0/CAPPU+8Dfr1C+yLI42A
 8BjDtIEg9fUgmyfj7VrIn2sS+YFD4aWYl9nTugR+TZNThaQQeKvTk0C0BmZzABVUrER8C3GVr82
 qF0NSH+nxg44INNLGBr931nfgnkCNZ9wwV+MHLU1cPt7js0U0V443f9KZkPRMoELKRJEVMTU+qs
 +lCuNZNTOrgq4xxFdi+JNbVM7dMz/6CzWyhE0iDoopC9KiKGujUV9DD1ruJwjU7jfuaP3qBBalZ
 1YAdV7v4iGKG5eoKtaP+fcExaVYTKbnw9uQJapygUDaU0k0lMyeGnfq0Qpn5uHxo9A==
X-Google-Smtp-Source: AGHT+IH5ET88NrGS9ZFdckpY4RLh0XpSsDMGaA4SG6tmjhJpaotFbz23Ov/xGAWgxe0/WaG9xuBhcg==
X-Received: by 2002:a05:6000:178c:b0:38d:dd8c:5199 with SMTP id
 ffacd0b85a97d-38ddd8c56c7mr5461989f8f.24.1739225933255; 
 Mon, 10 Feb 2025 14:18:53 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dd295200asm8134874f8f.44.2025.02.10.14.18.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Feb 2025 14:18:52 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-riscv@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 04/10] target/microblaze: Set disassemble_info::endian
 value in disas_set_info
Date: Mon, 10 Feb 2025 23:18:24 +0100
Message-ID: <20250210221830.69129-5-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250210221830.69129-1-philmd@linaro.org>
References: <20250210221830.69129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
index 13d194cef88..d5ee1244cad 100644
--- a/target/microblaze/cpu.c
+++ b/target/microblaze/cpu.c
@@ -224,6 +224,8 @@ static void mb_disas_set_info(CPUState *cpu, disassemble_info *info)
 {
     info->mach = bfd_arch_microblaze;
     info->print_insn = print_insn_microblaze;
+    info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
+                                     : BFD_ENDIAN_LITTLE;
 }
 
 static void mb_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.47.1


