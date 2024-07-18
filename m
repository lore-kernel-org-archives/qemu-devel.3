Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73962C3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 09:46:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUNhq-0004I8-VM; Thu, 18 Jul 2024 05:45:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhn-0003wU-1n
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:43 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sUNhg-0007fn-K8
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 05:45:42 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-52e97e5a84bso163593e87.2
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 02:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721295935; x=1721900735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvJgiNwmcThWcFCTBkYzV1Mv+ko91ZQ+foVJXf+2J8s=;
 b=yKZ7xzVVA3zz+w0bz3Kq6b6nvV7swgD/M7uETtYxSRWz5maB8D4tN9R9AuOGeTa8Gh
 EksKpUKOJKFWVUx1HYfd6yh19KFG2M8X27bbl7gSBeRd9PlKouWcrsnSc7GoS/DGdBZn
 KD1ppXsfTkalRGclOwX0NFdpZIJLJOIQptML4S5mUrhdh9fLPk+0HK/vI2Fx5CJPnRvR
 FQfO88e8f096mxrurl7jLYMgCDRG4m3aTlmy+1hljc4Xy4VFJcbriAAn8hLCCUmOj069
 kRaQ/mlXI0OiBKb2WoyEjU8rrhXoxRHj+qHgIOzQaOfzw4Z6jB9HEtGfCXsQ2mhZ+mu4
 7eMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721295935; x=1721900735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvJgiNwmcThWcFCTBkYzV1Mv+ko91ZQ+foVJXf+2J8s=;
 b=AlD27aZhAwt302L7mowj4RtUydQvqhZ7Vh4xH1T0zWfWQAhQSMn4s7FJaV+ogbextM
 +h8HRdUk2RUzv6zMjSBG9ixREjXVUypnGuZU1nqDtxJblV5YggdntCeefFvhXL2j8f8w
 AtSVpz/LjpO7Txoe3U15xfJNsb5Fc+L/L4/ihOA38ISfEoC9m3+VyfwUtGVAxYCtPXbb
 kqkFdGtqSELlpPpR1PIWGrFK1ej8OHKk9WvAlkBbLuRBm83o+7KNsz1KjOhgFWUXru4j
 maufS13K+8aLy7H0hnw+CmVlC7yMVTimMjHn8KaWCfVLejAXDEl4P43vxNjIbBieyUKS
 nR8A==
X-Gm-Message-State: AOJu0YyXfDCODQuv0iUjbaAZbDnex8LSuF6IfN/oKN/APefWkjdVR397
 K9BlGgyCX1187wo4aLxv93MSg/bgnRvi1SnfV0ryzjZc14c/y3TbzlwP+Pf/fos=
X-Google-Smtp-Source: AGHT+IGkDnpofRCqEyh9TQ1ep1d6k+xGyj6O5wmjWpiYgxWieKAmCW2Ju6zOzJf897q1BkALLYh68w==
X-Received: by 2002:ac2:4e0b:0:b0:52e:d0f8:2d43 with SMTP id
 2adb3069b0e04-52ee53b6f01mr3409785e87.17.1721295934626; 
 Thu, 18 Jul 2024 02:45:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a79bc5a38d9sm541521566b.25.2024.07.18.02.45.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jul 2024 02:45:28 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2DF765FC6F;
 Thu, 18 Jul 2024 10:45:25 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Bin Meng <bmeng.cn@gmail.com>, qemu-riscv@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Beraldo Leal <bleal@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>, Ed Maste <emaste@freebsd.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Anton Johansson <anjo@rev.ng>
Subject: [PATCH 12/15] target/mips: Restrict semihosting to TCG
Date: Thu, 18 Jul 2024 10:45:20 +0100
Message-Id: <20240718094523.1198645-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240718094523.1198645-1-alex.bennee@linaro.org>
References: <20240718094523.1198645-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x136.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Semihosting currently uses the TCG probe_access API. To prepare for
encoding the TCG dependency in Kconfig, do not enable it unless TCG
is available.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20240717105723.58965-6-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/Kconfig b/target/mips/Kconfig
index eb19c94c7d..876048b150 100644
--- a/target/mips/Kconfig
+++ b/target/mips/Kconfig
@@ -1,6 +1,6 @@
 config MIPS
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
 
 config MIPS64
     bool
-- 
2.39.2


