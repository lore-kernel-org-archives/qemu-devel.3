Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02011C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 15:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDW3-0005KK-Hh; Thu, 06 Mar 2025 10:52:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDVR-0004U9-4e
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:29 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDUx-0006jt-DP
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:51:02 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43bc31227ecso5128725e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:50:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276257; x=1741881057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lKugq75HE07Sek8o1SwKPDXjZVVfUgEZ9Ix7S0gd/w4=;
 b=WZDed1dcLET6QeyM1988PWCqQ+8rETWRX15WxIHHo5a9eu6hmqmCzv3J5K9SvFdEjc
 lrvQQqtpmd57ymprtP27mNMkI+qOtwV40HHmAg+kM/TEstoUDwyEpRnNeQfCDA5kwCqJ
 xOd/V6fFco5xemIeO6QMA7ew1Af8RKVeev0wEHai8shfTPUM4WxQqHuynANqDChVeXmp
 fzzZsKV3zjCnUOYt6e3oXjEL0XSsyB+vRg2UOimMR4HfsD9W5NByoV8BCF9QGF1/kBD/
 cZYfUrispQlj5qPSEtotLNqicMf+i5UVAtCUSYZKZ988jYxyajVw6YX10brTsZh1/tTY
 k0oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276257; x=1741881057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lKugq75HE07Sek8o1SwKPDXjZVVfUgEZ9Ix7S0gd/w4=;
 b=mIUeakLXmk1nIbTCVMsPkdkNtUCJ4ykvFypWPETC6KhJs35u/9niXj4dV6rmS9EKLY
 Wh8dHGrtJQ7oVMcep1Dw4SPdMeqmliWmptpoyURE7agfX2Mk7/2arlm0YJvYK+gHJa2g
 IoQ1I17tkx0JJVRU957aRFMnUpVeNKH1Gp7utjoBU1L5BfggnFxj2HAzaIIbz0chTNqn
 UWJr1v8BKz80p0mG2cVmoF/TLdW+19gJuvAk/GFXukVVrHYI7uGeIFxCFR1WZNijQcVW
 dijoWVDoby/CbpCqcstMU8hCSVt37qIiZC7LzBzFz5IABkRXfOGgdO4Ikti5BVRNn7Eb
 AS+g==
X-Gm-Message-State: AOJu0YzG1jF4n9gejoh7yOEclx4jObjBtzJJ20ECBCqDyqS+RlXc3b3y
 Nsp3mGuX4hBGX+CVqfmECM6iCOj8JLBoNC0jNNqo0Z0fjL2rPfseehpboSA6bWRC79/zZRag24Z
 A1ao=
X-Gm-Gg: ASbGncuh3qFJ1Pcf1YLPlltyiIX4DBz553y1KWwMVHqBLeCcDGNn/esjjUPyzoVS4ZU
 uH8o2FRSGB4oJe/0m2hmdo5n6bfB7/K5PWjkK2W61Zqw+RcMwRjU4PE8/y5Ieo/D9bL4H7Cwrnf
 yn8gz6M2Jgidy0XepwmnX3+65FNVFEHkfaeBkjjrfYMoaira5yAnnY95JzJB3t7POgpS7wDg9kv
 5nBq9GTuV/QLoJTNamLUGygFyFoNINcRmEVhAX73oruzXYaaNqgfLtkdjcPfgrUnsUbUp5mmBi/
 bDmoU/tEQMkVSwQk/q6X/6mDcL0BqZhgopEvpMcIUMq21Re4unIgQvGpKmQNTTW92mWF2sSZKhA
 jvqOexMBWQ/kQkv6xqxk=
X-Google-Smtp-Source: AGHT+IHxyCkuHNvad8cGNmRH2x0y8vFPk03d7g5RwpEvG/lCkS3KJSWKocFtRTOXx2BF2etRgK+LbQ==
X-Received: by 2002:a05:600c:4f86:b0:439:96b2:e8f with SMTP id
 5b1f17b1804b1-43bd29d040dmr56969785e9.28.1741276257473; 
 Thu, 06 Mar 2025 07:50:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8da473sm23321635e9.18.2025.03.06.07.50.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:50:56 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 44/54] target/xtensa: Set disassemble_info::endian value in
 disas_set_info()
Date: Thu,  6 Mar 2025 16:47:26 +0100
Message-ID: <20250306154737.70886-45-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Have the CPUClass::disas_set_info() callback set the
disassemble_info::endian field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250210212931.62401-10-philmd@linaro.org>
---
 target/xtensa/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
index efbfe73fcfb..f9e298ace45 100644
--- a/target/xtensa/cpu.c
+++ b/target/xtensa/cpu.c
@@ -159,6 +159,8 @@ static void xtensa_cpu_disas_set_info(CPUState *cs, disassemble_info *info)
 
     info->private_data = cpu->env.config->isa;
     info->print_insn = print_insn_xtensa;
+    info->endian = TARGET_BIG_ENDIAN ? BFD_ENDIAN_BIG
+                                     : BFD_ENDIAN_LITTLE;
 }
 
 static void xtensa_cpu_realizefn(DeviceState *dev, Error **errp)
-- 
2.47.1


