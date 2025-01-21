Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E70EBC02182
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2025 11:43:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taCdy-0006C1-BA; Tue, 21 Jan 2025 06:42:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCdo-0005mI-4I
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:56 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taCde-0003SE-4q
 for qemu-devel@nongnu.org; Tue, 21 Jan 2025 06:41:55 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4363ae65100so60368435e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 03:41:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737459704; x=1738064504; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yh+UbdQGf2CtgAWqdvcoJx6GX/6Sn3uz5UbIP9DkSEk=;
 b=iVXMX4Afse8Ls9EleNrGaQi6H1jLrCe8oY+qSVfz5FxobB61/BJPq3+vCmd9tOFnJZ
 HruneO/E+hQymS7KdnfC3pzkiYmrX/ULB3LjFprmwFuYJ2SjBf/epyGAMIF35I5zc1qk
 UzCsy6+K2gPLitu6U2WWlI3g7gbw8BRSrU17khVl2CXOObLXJyIv88aziLM/k/amzNp5
 52Y//zBSCPm+vcUNMgNiz8usjKBPVFGcNN/caazty6qDl7k7T5pqmdNLhqU978AgvrsI
 Gfo8wX3D8AiIpYx0FiSwVKLpbr+AO8rXar0dshP1Ni8WSBv9xzjI7ijUQLivBIM0DmfE
 w9Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737459704; x=1738064504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yh+UbdQGf2CtgAWqdvcoJx6GX/6Sn3uz5UbIP9DkSEk=;
 b=Ra2Phdul7BjfIgGl0I24aW6aR9qK1VnbifT8yKSU+M6oA0HlK9tYLYSTTcUfF21KN2
 ySRZ+HG8jHqYbT1JSNw+D1G5Jo6uzZz6yMi8ueL7RMGcpfvc1g4QqoUskj0ALeFp+mL9
 VbJwIaAHKhWVGq7N8LGG1SFtstSduoAhYGEnsxkRmIrxOZMHPQ0D0AbUfUEl/AnUNbei
 IopH27vmtUg6F7rNITqg0Oo0PhrcY40xEUdHQM9pNwAl9aYtF91DlALsZsQzmxjdtcf4
 vLvuDAkySrfMLt90ynwzIxXD6n0c1Di5U7VGh7rDtx9ntCoV2cgw6mRBCnsfUGfA3dQ9
 K59w==
X-Gm-Message-State: AOJu0YxdrV24AhiO6GoAk0+XvsCPKhUSbJHJjsYWuHQ7vhZz55THExMV
 zMGrNAs44D2kOEoga7rguNj5v1PsSandDc0d2HDm9dne1WpRdh4wED5z9b5skTCiCx2UqH67fF9
 OVJo=
X-Gm-Gg: ASbGncsMzJe78P88Zrt3UZF2VwaHoCnPCWzQJWjtN9cp+Jh068knsZi/Oy5sExXm/Om
 HRbC5roJKXlpGejA8LtKkGzXbjfWlBJYDDdFyc+F4kqMPSJ7N8XoX4FbDhhBHOe66WVC0l/wDDL
 ZqAmI/nouE5+xp3OsIn1Tt3PkNzVkwBrsOWw4IHjnpOLfzReRh5bb98EqqaTDD/9Vb7ndKuEQxv
 PofcHaf5mg/Yi0RVXRdyUqLPRIvYwwgGCOeWKUpeQ3gEaI1Xp0HUwrH/arCbZUU2FRQVwbjjgdI
 GI+bQH3vNSJAONqi9avXd/pAHy5CVkaCMQqm9y0ZBK1t
X-Google-Smtp-Source: AGHT+IFpB2rYVUvGYR5mMClkISZgoJI9xiLPY4vVTM3qUpJkrxr1utH7Jel7yEGJjtEsgQDQLXYGqg==
X-Received: by 2002:a5d:6da1:0:b0:385:dc45:ea22 with SMTP id
 ffacd0b85a97d-38bf57a7746mr18709934f8f.39.1737459704005; 
 Tue, 21 Jan 2025 03:41:44 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf322ad74sm13306034f8f.56.2025.01.21.03.41.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Jan 2025 03:41:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 10/11] target/microblaze: Prefer cached CpuClass over
 CPU_GET_CLASS() macro
Date: Tue, 21 Jan 2025 12:40:55 +0100
Message-ID: <20250121114056.53949-11-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250121114056.53949-1-philmd@linaro.org>
References: <20250121114056.53949-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

CpuState caches its CPUClass since commit 6fbdff87062
("cpu: cache CPUClass in CPUState for hot code paths"),
use it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/microblaze/gdbstub.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/microblaze/gdbstub.c b/target/microblaze/gdbstub.c
index 09d74e164d0..8b08ed5cb49 100644
--- a/target/microblaze/gdbstub.c
+++ b/target/microblaze/gdbstub.c
@@ -110,11 +110,10 @@ int mb_cpu_gdb_read_stack_protect(CPUState *cs, GByteArray *mem_buf, int n)
 
 int mb_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
 {
-    CPUClass *cc = CPU_GET_CLASS(cs);
     CPUMBState *env = cpu_env(cs);
     uint32_t tmp;
 
-    if (n > cc->gdb_num_core_regs) {
+    if (n > cs->cc->gdb_num_core_regs) {
         return 0;
     }
 
-- 
2.47.1


