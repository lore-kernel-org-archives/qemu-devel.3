Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11731CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0d0b-0003S0-Fe; Mon, 22 Sep 2025 05:38:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0czQ-0002Gy-Dr
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:45 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cz6-0000dg-1I
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:44 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46c889b310dso10739095e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533839; x=1759138639; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zR6vtj5zFWpC3fy91sWeOSp7fMJNhRDmtEpW8GYt8DQ=;
 b=GZLFsd5q2hzwMjYeo7a5zxhZsrVKTp864ytAEUBIKusigWiVay7X72iliE09KuKQkc
 Td+hxfuhZM60yccXNCpNecxlq/KB23CL6OJnPGgp0h72wo1WFLcMrcBzdrjd19u4vnAG
 2XO6uQ0YoO9Ms4ILfvQp3ConFf6qf/Kw5BYHZIqri1/XEFfQ4VwIBN3gh2QXptr3BddD
 HqZv9xnvJTHoM83HcfjLKGuOuF8go/RmsibPHqTJ2eUzuegW/ZK2zppVvOCueFez+l1K
 8bmtzDfG03DRc8887V8Vl90RceIuKq2IKVmLJT3kFYWgc3Cq8v2K7pidzjXg5jE4zAkf
 E/fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533839; x=1759138639;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zR6vtj5zFWpC3fy91sWeOSp7fMJNhRDmtEpW8GYt8DQ=;
 b=e1chgzU61eWCSGmxaELK/zDA4shXBZJHKr15s4rRQB09QVy02dPk3f7t8OS/r3vbE+
 TVF9FM0VnCJAd35l3qtiIVWm8pjzfsuAE7u2L1u4z9OrQIVSfpV0rQHQcbQ/EXkE4WEh
 zJ+GyoqMQnR8CpuYSzFfv7JPa0eCj6N277fQ+/mKf3ylx5L3xqkChcWFhvU/4xsoH3jf
 EDuZW0ReKECy79AyJUs3CRUkY3Qz5nBWvaF7QwvenIeFD+erFJva8BVHUA36WdTb6mo0
 ScTcfDb8H3WPq0YggbaM6P7xHFe8VRslPnl+SYKsRStVe9mE81lSgoyxg9iNNwQMUbin
 jzPw==
X-Gm-Message-State: AOJu0YyutDWBHGPfEzw7BeU+3G3lI+3krFXReCyaxJMYer+MsnyoaNEZ
 lI+NWEPCek4/pjGFF8l++SNAXvI4lvG2BHFvVKkVzap/8XncE/yldS0D4ryrJrku2AU=
X-Gm-Gg: ASbGnctbzI0LYQo9dgFxzGr3KQF2MZUkhrvQLt07U6b2zZKWPPiGU1YRXOb5u/tOIy5
 5WsE/IUQWYWciEGkxfcVOyDXlWO09UpgctrAD+WvPXtHGeHrjaAluLkBG21eQJf/OU8s//QQKt3
 MuZ3r1WZ1Ex2NVB+7zf9Q6/Bv1P0XmFtWKm7EbpojniZi0EUVAlPvvmadsWzjAC2KAiAFrftTha
 thPxEM9Lp5HW3Du6MhUWUj8+XjEVv6SXzfJT9oWdrFjst3eapoldf0jwNy25qJwHaPTongwWVnI
 CKK/ENWmtWMcrkJ+MmbrmPC5X6Jfj/A0qwFwY+MhsVEjlQSgPsxOFwHKp8pGwtYMznTSCS+LrX+
 V052oS6AFL+OPfWI4WSDkM/E=
X-Google-Smtp-Source: AGHT+IEJT7U7eTozaOeVqApP8mTlpbGFsV3G/6F0gpdjxUhOb9NmKsPTJDmEH9mCywmoMo5fm4DQJQ==
X-Received: by 2002:a05:600c:5246:b0:45d:98be:eea6 with SMTP id
 5b1f17b1804b1-467a72a66b4mr113831185e9.3.1758533838693; 
 Mon, 22 Sep 2025 02:37:18 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46dd9a69466sm16427965e9.1.2025.09.22.02.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:37:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4F8405F9F9;
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
Subject: [PATCH 08/25] target/riscv/common-semi-target: remove
 sizeof(target_ulong)
Date: Mon, 22 Sep 2025 10:36:53 +0100
Message-ID: <20250922093711.2768983-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Only riscv64 extends SYS_EXIT, similar to aarch64.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250822150058.18692-6-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/riscv/common-semi-target.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/riscv/common-semi-target.h b/target/riscv/common-semi-target.h
index ba40e794dcc..7e6ea8da02c 100644
--- a/target/riscv/common-semi-target.h
+++ b/target/riscv/common-semi-target.h
@@ -25,14 +25,14 @@ static inline void common_semi_set_ret(CPUState *cs, target_ulong ret)
     env->gpr[xA0] = ret;
 }
 
-static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
+static inline bool is_64bit_semihosting(CPUArchState *env)
 {
-    return sizeof(target_ulong) == 8;
+    return riscv_cpu_mxl(env) != MXL_RV32;
 }
 
-static inline bool is_64bit_semihosting(CPUArchState *env)
+static inline bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
-    return riscv_cpu_mxl(env) != MXL_RV32;
+    return is_64bit_semihosting(cpu_env(cs));
 }
 
 static inline target_ulong common_semi_stack_bottom(CPUState *cs)
-- 
2.47.3


