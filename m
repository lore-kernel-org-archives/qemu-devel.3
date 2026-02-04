Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE04E8B39C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVHx-0007o8-CJ; Wed, 04 Feb 2026 00:18:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHr-0007ci-Pl
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:48 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVHq-00083g-Dn
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:18:47 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-352e2156450so3078958a91.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182324; x=1770787124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKFOVd1x1tdBqkVfLTFpz+52PeGKZ9TXVu5yfqKIdwY=;
 b=jQwb6yGGno8zZ+IeuxXUNO76kQ+osuLfLn9FpHgwUw+edkWmxJVxbSQGngBc3RN54N
 Q9Q/vOhN9PK8um73I3mL55ODPXATghw5Xb+x47r8kO5f4dT8z2sCj2P8tGxWvcHH4wbC
 Zwm6r2KHGMBlZ+7VKicCVljwY3F245G17iuA6lJYl6i2uRboq66HsRf+puwZzNa1Slzo
 jD00hVTqJCIlz9BKAE33ofs3PKo51NwACL7jTkcCkBdxparvQa4F4DCa1EyQyPyBy21s
 QPPeeOzRuMVI8tSsuN3wgUyaYwrkJzOii7TC5Z5jZfa/Mhy06GhQ/o3fdvQDvic6KpQM
 16LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182324; x=1770787124;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NKFOVd1x1tdBqkVfLTFpz+52PeGKZ9TXVu5yfqKIdwY=;
 b=HWIX5/BpD1Vz7y8bNNahkU4arfXmQ0z2ZD6RqERK+psUsH0msSYEf3Gsgjd2GkMjJ5
 kq4FIHHHKcWxtyoK5kUNFGmByCF/drvCSOY/8HJQ+4DSivS7Oep6WjY/9Hm4LaNvByse
 4gS+x3RkX5B8HSEQ15JLgKi1P5vYtNub+BQHPTZCeQTSjQTaYNcfVIdAc+N9FYLgUbAW
 8FBH+fcv1Voopf0oO3L1PP4hyNEHp/cPYX4qv1cwHg8tuGoLhY9pO5KPUxIU8tZAXuse
 NixKjUSEqg6A37rDuZHorPNpj6H/qU7McRxvri8rHn/bgbeFCpy0fp/T9lzJkjHhm6nl
 ZXvg==
X-Gm-Message-State: AOJu0YxA018fzXw/QXPT0Ai0Szw6X+CQI+Mwn2ZHR0NlOmdyEEcHDLfe
 CYlvHZqhQ1ljgke3Bf1XIkPaf/Y1Dx+WfOrcNA2Z4xFYHfDncsQveF/RYbZEz9iqXnT9eXYgcM6
 qZ6euY7ec3qyyZ9bxUl3O8Y5WPj/QH3DbMzGEOrQuO+KwoQZZZOQv7ODxtunW4q2xtgI3snzC1y
 AD+zOAkSZg9gVpS1ewQ6IdXA1XV2DhyWEIqLyxLC9nEOFh
X-Gm-Gg: AZuq6aKoHbYtXO6S5+1a82NXSJvAcsUQyjXGpRIhsnjwN+e0X+s0tq0rYE/0VAWQhmf
 Oe5QPwexHlyZHHgLRFuB/OTiqvRuswxlCftHJ153o3oAxUPOrCNSgJapGaoUPOzyulp2sx+YYHC
 cAqx8lElCjikjL92ClbSbmYPr3j3G7JMvYWxFk+ustTlrLWyL3f/C+X1tOeiDff2ZY1RYpFYOia
 1WdU2sOC9L27gZWrcm9aT+JnSI7fFDJQC0ES2HfoVAoMCNMebAGRsYKER1ssO1OMtozrVr8gO0g
 TzHq9mgHSTlAlSScWjFVp+Qljm/7jGNlMgdsuXVSyQfNzD4wz78XkCZzQK91G4hqCAooFbUJcHK
 wibIdWSqtNMuX1YV4wgUKDBhD3zw0PuFPkB+xVnwpyyPLvn5wJBrKyVgQhe7VdymBVM6Alcw/d9
 qmP2qw/z+28eM16JxlvFJRxOfQWcVH2GWqSofyiaUzz3wwyX3XKTs9g2Fprp3tRsrztROL6Fl+5
 ykFEIn5MTqPqRQ=
X-Received: by 2002:a17:90b:2f47:b0:343:6108:1712 with SMTP id
 98e67ed59e1d1-354871bec2dmr1603628a91.18.1770182323912; 
 Tue, 03 Feb 2026 21:18:43 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:43 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 13/19] target/riscv: Expose Zvfofp8min properity
Date: Wed,  4 Feb 2026 13:17:49 +0800
Message-ID: <20260204051756.667397-14-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=max.chou@sifive.com; helo=mail-pj1-x1031.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 36fddce5bf..c8cb3d021d 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1381,6 +1381,9 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
     MULTI_EXT_CFG_BOOL("x-svukte", ext_svukte, false),
     MULTI_EXT_CFG_BOOL("x-zvfbfa", ext_zvfbfa, false),
 
+    /* Zvfofp8min extension for OFP8 conversion */
+    MULTI_EXT_CFG_BOOL("x-zvfofp8min", ext_zvfofp8min, false),
+
     { },
 };
 
-- 
2.52.0


