Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2094DE8383F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 22:53:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs7Sr-0002Ci-6d; Mon, 16 Feb 2026 17:53:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7Sp-0002AN-Qk
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:11 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vs7So-0006UY-Ey
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 17:53:11 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so33854015e9.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 14:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771282389; x=1771887189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6HXlrNLQEJo12y7bAqBOXsab5CEiSRP5NzEAPS/keIM=;
 b=uDJk3MWiPlko7yglMLFNePbk/nMXasXOWpMWanehdCnZS/xH+1yDIfisjfWYLNNYDU
 AX0XXs68xdwhEpYpJSZGDK1ipuis7yJ3xngrSLKjNiBdsHDpI9J0diepmX4jSO7XvLad
 VfCCG+Cg5hpoEi3Xaq9cVRrcX50OBoKQkDCsYugYeZmRpOG4rvriMYOGRs6LcGHLdA2f
 miv4rbnL4qiKnOv90FnLGVfnvJn4J1sjnf5TSbXV/p98HefTHraA3uSlHo5rtoAZYR3H
 vJdXmjboB0M0rF4ImH82MDcXQcn56N/NzOuwNL431HZZwUyfXe04r18KdHlqfvkZXzuY
 nOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771282389; x=1771887189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6HXlrNLQEJo12y7bAqBOXsab5CEiSRP5NzEAPS/keIM=;
 b=ESQGrwDK04SOJSnCnms6hlPIi/RUHnEM3GXruEMfsBPnH5GgDw+oXUv8dTAAR7o1rG
 CDb6X9Gcz4wyERS5AxQIXZZMinVWiUvmXysQ0eH9EkxMcyKn549DOIhTqF8nbY/XHxd+
 tEdtsVyynxW2nnGX8GKYOdGZjCZNhpjLODKKKAqaaWwEKEARFbylUdX5naYVyYyzarPz
 i0CUfDOd10iZY8ddwFMeIdYDd3bUp5NuNte0hsHb7ubZ5QESJjdP6HmHteSRDLoHuHlb
 2bDJ6aRe6tVjxmqCRlmk/DUX0DkQgJ519TWRhE8iLe8MNMC2avq/drEfgE6PN9hYnC6T
 b4JQ==
X-Gm-Message-State: AOJu0YzVA0fjDHXhZFuPzdxtrvO7kZRcbJcOAxUBYLhl+H+FhCyMxM7l
 UbuhEYXE9V4kH6jMAo0h/USCflpzYIy8VVxD73Ko8Xv6vrth5gIANzZGwcr4TCVAIaSi/wZiSUK
 /rmw7mLE=
X-Gm-Gg: AZuq6aKb/iiOUBYrGvWUhQDhhhPzB1gCpYKgYbe2Burr4q1MlnVzc2/y7G3mroEA9qe
 H2/yadyPpo7N1MCQ4mxvHL+BIAC26cSFk99IXKDTsWveGYsOpMRL5tedHzmRlAIROZwbpTod3pz
 xzJdOhs+pADHCs6RtLBmDoDJ6TP3Y6TFVvrB1n/Izaia3esgG8UCCNGXNsh7++28z2eWWZ3qtya
 SFgXBPfYkgkBQZMELO2tBmMfP7d0y8X6FeqooskDfqNE6mDYDXKMyq/6RVK3AtCBny2x8vj7wkl
 jv5ceC4/VL/W14DNewqN6Kf4bZo7oFcip714RQzUvp+4B3ygl5tLsmX0tWB1ZB2r7+UCsCk2vOG
 bz2PiAfKnzFyy0PbPyiTrvwfMKrObxGc2+Tt8eK/0P/weVZcqpPXAKUduWXTS3zpXgIfDYjxtsh
 BJHLICSctxcJjGEPkxNkQPVqBKRRRDRzomIAEXUVU4OyEt4lEEXzFcib8JDS/kc8Yrcn17/WiH
X-Received: by 2002:a05:600c:1908:b0:479:1b0f:dfff with SMTP id
 5b1f17b1804b1-48373a1bbb9mr218891065e9.10.1771282388609; 
 Mon, 16 Feb 2026 14:53:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4834d5d77b3sm523999605e9.2.2026.02.16.14.53.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 16 Feb 2026 14:53:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Nicholas Piggin <npiggin@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, unisono@quyllur.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org
Subject: [PATCH 05/11] target/sparc: Expose gdbstub registers to sparc32plus
 target
Date: Mon, 16 Feb 2026 23:52:21 +0100
Message-ID: <20260216225228.53959-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260216225228.53959-1-philmd@linaro.org>
References: <20260216225228.53959-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 configs/targets/sparc32plus-linux-user.mak | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configs/targets/sparc32plus-linux-user.mak b/configs/targets/sparc32plus-linux-user.mak
index 3e6c72e793e..cf49c53ce44 100644
--- a/configs/targets/sparc32plus-linux-user.mak
+++ b/configs/targets/sparc32plus-linux-user.mak
@@ -5,5 +5,6 @@ TARGET_ABI_DIR=sparc
 TARGET_SYSTBL_ABI=common,32
 TARGET_SYSTBL=syscall.tbl
 TARGET_BIG_ENDIAN=y
+TARGET_XML_FILES=gdb-xml/sparc64-cpu.xml gdb-xml/sparc64-fpu.xml gdb-xml/sparc64-cp0.xml
 TARGET_LONG_BITS=64
 TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


