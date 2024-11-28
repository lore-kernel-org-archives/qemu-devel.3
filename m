Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76747D70DEB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 21:39:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGmDt-00085G-5z; Thu, 28 Nov 2024 16:38:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGmDr-00084q-Po
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 16:38:51 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tGmDq-0001Aq-8H
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 16:38:51 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso1155535b3a.1
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 13:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732829929; x=1733434729; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xXXQwrbvgY9SrfkpFjpcfAWTIlYv5Ij04FfSfNgrax8=;
 b=pc5nNqfrCVmGIh0EitV7c4nWBdWLlzHPrqmLxY+1VtvBj+QlSJFXBR593TNzHm/Ozm
 OZx34+T9fxr7zqlxwS/KWSYRH2GYo7dSddupf3Lsq4L/QNJ7HZMEPcp8ui10pURDAqbL
 xUOQn9xl/fzHKBGyEmB2htJciBobxOeGEpW+sqPj06UG7ycvRWmRt95OTSlGQYuJNvEc
 8qE6fauCWom3cwTd24zPxhkeTXxySj63kotts2gb5WYSZHm7xk88EePQ6Q/BotITBEF4
 8Hqr5G45cQIBBmoBBd0vrORJNJjC21IJOAhRkzQ/9ph0d0eLSQ6pdjDbpM787Fo31y6f
 +qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732829929; x=1733434729;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xXXQwrbvgY9SrfkpFjpcfAWTIlYv5Ij04FfSfNgrax8=;
 b=jX1FQJ3M7zI5og9TxF2Bvm/yZueb6Epcd0ujLGgfYFD9XNXD+ABmUHSFZV880Ukn5o
 s3cvzRGOX6t8qrOCg6KdkUo116rqyXX4xBN2UD2a27bScQu602s81jTX2yz14foQRisx
 /OguBK4je0Sa6+Toch92ww1l5Hc6zeH/EWyq+OjxO+mP2ShUwCZs5s6Zze9gp0NwkQzc
 4zrDNzao/dqxXhN5i1pvcZwSGZQh2HiemnG20coChpfT5ipbhNcYJaDv5zBFBZijUce8
 KNBta/Jw/GCfZbRkA9a/r86kdGzQOgSlqKwtUm+OnTmc8KSJubtkHGFznPcHxJPrtgXr
 LWCg==
X-Gm-Message-State: AOJu0YyrWqumcTvZUbyX7SBhhsa9Wmx7Fj7X66nB6VanauZYnd/VG6LU
 vaHMPN0u4MzZrv4BHXVH2KhBiMVHY3pgJUUd1Sd0o1r69s7unkvnXXbB9PBmutLbIm9dVUfistc
 c3+0=
X-Gm-Gg: ASbGncs8J3TebgUBRtXPjJKWevAZdO+s4IysQ+p3YjT+7JsekcxZ0BRSOZYdpTXrIIw
 e1dVR2kJ64EUhsTaVdXIskI1L4ZbiYgBlGlhSaWimVod01RypF3Wkk2pQs28XZhisBS4F+PHhZT
 L4OiSdTFQuJSF5w8TO8aQLfo6VHswZpAxvkbBO66Ch97RuURJCWCMysAwGYF1fLgSdUg20g5tWv
 dWvMSuqyoG5heXfENHlfoR09NDzRqkEFQnNrdP8wOjEm+wMQmMinUTeaTF+1IDwYarEzJ2JYLuL
 l5GEs1/ZrQHtsw==
X-Google-Smtp-Source: AGHT+IGprSvxq01xwUMLowYfhfxjjmAYmq2sSnJQwlmk27T1Qa4DbQHVqxPcgmV0pw9f9GVglX3txw==
X-Received: by 2002:a17:90b:380c:b0:2ea:5dcf:6f74 with SMTP id
 98e67ed59e1d1-2ee08e9d449mr10556447a91.3.1732829928933; 
 Thu, 28 Nov 2024 13:38:48 -0800 (PST)
Received: from linaro.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ee0fad03c7sm3944850a91.39.2024.11.28.13.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Nov 2024 13:38:47 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2] plugins: optimize cpu_index code generation
Date: Thu, 28 Nov 2024 13:38:43 -0800
Message-Id: <20241128213843.1023080-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

When running with a single vcpu, we can return a constant instead of a
load when accessing cpu_index.
A side effect is that all tcg operations using it are optimized, most
notably scoreboard access.
When running a simple loop in user-mode, the speedup is around 20%.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

---

v2:
- no need to do a flush, as user-mode already does it when spawning a
  second cpu (to honor CF_PARALLEL flags).
- change condition detection to use CF_PARALLEL instead
---
 accel/tcg/plugin-gen.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 0f47bfbb489..961d9305913 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -102,6 +102,15 @@ static void gen_disable_mem_helper(void)
 
 static TCGv_i32 gen_cpu_index(void)
 {
+    /*
+     * Optimize when we run with a single vcpu. All values using cpu_index,
+     * including scoreboard index, will be optimized out.
+     * User-mode calls tb_flush when setting this flag. In system-mode, all
+     * vcpus are created before generating code.
+     */
+    if (!tcg_cflags_has(current_cpu, CF_PARALLEL)) {
+        return tcg_constant_i32(current_cpu->cpu_index);
+    }
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-- 
2.39.5


