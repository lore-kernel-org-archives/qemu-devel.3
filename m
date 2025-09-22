Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F7ACAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d0n-0004W2-Fi; Mon, 22 Sep 2025 05:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czq-0002VA-0Z
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:38:14 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czD-0000fx-Bv
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:38:06 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45de56a042dso26099475e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533845; x=1759138645; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FpyzDIWQ5ZoXKAzqSyc2elMY1EE9GCHDwM8UA7OBlS8=;
 b=f06tm7k3NwPN0zO9Gi1LFZpDdHj2DeuJr5L8ry/USP25GeLiQC1e9+SOGQemQoc2U3
 qAm37dwy4tkjEhwPfJ5A83SBx+YX10yC+Iby1OcwNsfddnDyqyq5g6Ql2tPZh8L8h2z4
 OccjcjoL+blmj83PdxCsOfzSQ2f65imjibvOr/d5s1czkeV0THVMCghwUQBa6kewCoIc
 5n5gxbrpfvdmAGh+sliuVcTJELsaiLgNGLE557eh+xEsE01PoYKlXVH7nbq5cfXxlDTC
 hO85x/LcrSjbZM4VHWCRRJyOs0qFMkuWG9V/QcRALkC9mvkaNuY7n2RxO7PC32hizND7
 oxHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533845; x=1759138645;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FpyzDIWQ5ZoXKAzqSyc2elMY1EE9GCHDwM8UA7OBlS8=;
 b=fvVLBsSMxafgCp5MpY8tQJDXr5EP5B3cJJM3ySVoHPDajt5riOdhMzxNSk7Y4D1VVT
 rS232tCNS8vNRKdcItNNzKMjVfC75J8XZ05XzLofnndbNF1bOpO9BSO/OFynO+3UFyUu
 fpf08epQymSDXEOOjbjLXQQtsVYfvMtQ1NiUGXpLB2cJe6JN48aeKPKSr3o1XZzWyu/m
 KFdRb8A2DqzqGoT9l+Yj2Mrep2i+kfcpZLoOvn0V/DB1pVsbfGIRc3CeN7VRR5mRifeY
 rHNX/hHwn3B8LXLa/j1nhM05KnzE0JFlOA3YZoIIgQJMnE1beSY6fSnskNl/TbI1zCLT
 FVyA==
X-Gm-Message-State: AOJu0YxhHOOBTxeFbCZVXPSrG6s+XaCG3ifJoOk2wi36q7oogxKYGc8E
 0WOZCdUnscTocdTudMSnYtiCT843XoD2Tima4mVPHgXjs98VxQ9oweBfYmB0g2l+LLo=
X-Gm-Gg: ASbGnctZ5wFyGwdIILxFfAfzlPcWpzXJgwJIsOF1ZsVjTnnFreYir3Dq6xJru6gCPvN
 zFwoZkBZgdJbvXeZTc03lnuhLhukPQVou5Wrr+quxDZy70LQfIH4WiQ/xpQ5LOcYH3EyVZlcq+P
 ynAsVAWNER+NfqEJgVKODUesOgrXqS1JINvm5SblktQt0R6iEoHY98Ot19cWkixXMQtpGvcfePo
 Tp+e6N1nS5uehVk2P/jsTxyj58Hf4xumkrzpjtBW/5CBRoo3RNLVmtbjEtDltuxKwFalxmFuiCd
 zSlIbpVY2fWjVt3+h6pwAaBx5gFTeysjYHByhll5luoRnLIIrdhLyM1OGVPBxN/C/BTU0w1wwgB
 zGQ6MnAlR5WZADXJ2WhjE+fPorHRBP6tOgA==
X-Google-Smtp-Source: AGHT+IETT8Vq/rVcS+uTMt32M+EaHEz3SHHsDUWgNHeMwBTMpLOGts4+upLnLj8sq+C7fMc28zMlxA==
X-Received: by 2002:a05:600c:198b:b0:46d:996b:826d with SMTP id
 5b1f17b1804b1-46d996b8a43mr12581515e9.34.1758533845258; 
 Mon, 22 Sep 2025 02:37:25 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613dccb5e2sm233400715e9.17.2025.09.22.02.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:37:24 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F23A45FA18;
 Mon, 22 Sep 2025 10:37:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH 15/25] semihosting/arm-compat-semi: compile once in system and
 per target for user mode
Date: Mon, 22 Sep 2025 10:37:00 +0100
Message-ID: <20250922093711.2768983-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

We don't have any target dependency left in system mode, so we can
compile once.

User mode depends on qemu.h, which is duplicated between linux and bsd,
so we can't easily compile it once.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-13-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index bb0db323937..99f10e2e2bb 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -12,9 +12,10 @@ system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'stubs-system.c',
 ))
 system_ss.add(when: 'CONFIG_ARM_COMPATIBLE_SEMIHOSTING',
+  if_true: files('arm-compat-semi.c'),
   if_false: files('arm-compat-semi-stub.c'))
 
 specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_USER_ONLY'],
                 if_true: files('syscalls.c'))
-specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING'],
+specific_ss.add(when: ['CONFIG_ARM_COMPATIBLE_SEMIHOSTING', 'CONFIG_USER_ONLY'],
 		if_true: files('arm-compat-semi.c'))
-- 
2.47.3


