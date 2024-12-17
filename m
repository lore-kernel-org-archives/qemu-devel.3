Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66FA1E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 06:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNR1Q-000371-2x; Tue, 17 Dec 2024 01:25:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR1J-00033Q-IZ
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:26 -0500
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <frank.chang@sifive.com>)
 id 1tNR1F-00055e-Rc
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 01:25:24 -0500
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-728f1525565so5815167b3a.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 22:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1734416719; x=1735021519; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tl/PDO9SOOn4SJKgZz+HudXPKCnTCdotF3cwk73STA0=;
 b=MzDCMtkYWA01WKyxuu8tH0hxi0dWYmK3bZHoofdWCi2P82euhsUfMGfZ40BquCTE+Q
 8NKVtWl+sVJ5sAvWoN/p4S9A1cA4XvkJrpUY/cW46v2KB0vo1tRuhgjziGFQdo41fk8J
 H2DPv8z88BxE0CyQwgdVJW3TMwvGWRgWwghJyCOrLwOKTsGCWJLDRMxExpzMwP1iv5ns
 mzKfMVXHmi+03qPKdopte6R+UBEXcccZIvxz/26N6kUPXkFkKeDJAQGesR6YQC5Yw2py
 1ZiKjZL9z3S/rrfJ6+CfU2I3GyaK0CYNbsZHpFgDe7lzElZlAKHf+99SmyRv7BSXztzL
 wTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734416719; x=1735021519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tl/PDO9SOOn4SJKgZz+HudXPKCnTCdotF3cwk73STA0=;
 b=eoq8KMcU7/JrLrHgpXNodkw/KnJ6SLWa1bJliQ0t1wN2z7vhlSqPNnRv0CWZsCg/DW
 1ZLLf7k/rKpCuCIk9rfYcpjRQtEEhRQPcs8pKAkvs5GeIWTKwn+J9HsrVyA+tAQgH8+o
 UI2kDPTRpLHXHfzuY+FEj6gtEHdimdExbLKJxRHA4GlzWFOvVMaUuE/78TRaG+hdtRW5
 a4zdDt1ex8vCOeB6oWgg9y2YLZ6VAWv8JsYYvAiOp2hCmlnf5SXkJwJw+x8fHYGZJbIL
 pBVCIlbyT04s9ZHSVVULAnRDhiBvf5mQr86cZAy5+gYY9CnfuHiL/4HAcGd2pZagawxI
 iDlg==
X-Gm-Message-State: AOJu0Yyjvg9d0i6kddQGAk/yCtt3aSDp0Kqkcd54X8FWtYk6r78Zb+8v
 WxqT9DKte5SbBhANJJ8VCIXlO3njBP3C54qMtD9DuSAVGZYV4hfXFF4cG9yaAGNhBAB5apDD58x
 gUq+6twUg/gjZK6X1YXcwC3NE5vkTysCDzuMDd9D4A2MAZxBOaKbpS7jwAqhGJchohno/aPeFgx
 uvhSuaM3wsy14ul/FygdJUMUMGibuRFkgEKxDhrczgxw==
X-Gm-Gg: ASbGnctCE+PlkRsUF1b7VeREZ6iLy024fHJbHANZm1HF+ZYV9YMalW6ze73LcB8DTSe
 io1mhoL0zuTWzv9W90c+86D4fry15r0Hd1lzUlp3ZtOIQlMDgP8dMoqlT+KD1raMusO5fyWVsCv
 7+2N36vSCovPHtfmSnfdH10f4SR2PhxilRoyUQKesC3QTziBZE3PnNGlcHTL4SebIlXUwx16tOA
 aVBaXRIVNrvJaf7BMIbhzDd8tiHxPHsXYCqUxks+UuNSQbh/XH2Xe+A2lXmu8yyphPfGM+qVk9x
 rL8XFMEZtLo=
X-Google-Smtp-Source: AGHT+IGEzxKvdwsW3/o8+hACJ64Q7X4/KJM+RPkNXJ2J2uih2Ep2XnbA9al+Pcu1PUrUCbHwnJ2kmg==
X-Received: by 2002:a05:6a00:ac02:b0:725:ebab:bb32 with SMTP id
 d2e1a72fcca58-7290c27c888mr22537423b3a.26.1734416718898; 
 Mon, 16 Dec 2024 22:25:18 -0800 (PST)
Received: from fchang-1826.internal.sifive.com ([210.176.154.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72925e6e8b1sm4354301b3a.139.2024.12.16.22.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 22:25:18 -0800 (PST)
From: frank.chang@sifive.com
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>
Subject: [PATCH v10 7/7] target/riscv: Disable Smrnmi for the 'max' type CPU
Date: Tue, 17 Dec 2024 14:24:40 +0800
Message-Id: <20241217062440.884261-8-frank.chang@sifive.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241217062440.884261-1-frank.chang@sifive.com>
References: <20241217062440.884261-1-frank.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=frank.chang@sifive.com; helo=mail-pf1-x432.google.com
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

From: Frank Chang <frank.chang@sifive.com>

When Smrnmi is present, the firmware (e.g., OpenSBI) must set
mnstatus.NMIE to 1 before enabling any interrupts. Otherwise, all
interrupts will be disabled. Since our current OpenSBI does not
support Smrnmi yet, let's disable Smrnmi for the 'max' type CPU for
now. We can re-enable it once OpenSBI includes proper support for it.

Signed-off-by: Frank Chang <frank.chang@sifive.com>
Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
---
 target/riscv/tcg/tcg-cpu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 3480767b35..f3fb1c432b 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -1429,6 +1429,12 @@ static void riscv_init_max_cpu_extensions(Object *obj)
     if (env->misa_mxl != MXL_RV32) {
         isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_zcf), false);
     }
+
+    /*
+     * ext_smrnmi requires OpenSBI changes that our current
+     * image does not have. Disable it for now.
+     */
+    isa_ext_update_enabled(cpu, CPU_CFG_OFFSET(ext_smrnmi), false);
 }
 
 static bool riscv_cpu_has_max_extensions(Object *cpu_obj)
-- 
2.34.1


