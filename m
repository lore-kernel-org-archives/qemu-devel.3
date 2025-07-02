Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8064CC83038
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2cB-0002zo-1L; Wed, 02 Jul 2025 14:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bt-0002OR-1g
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:12 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2bo-0001tu-0G
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:55:08 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3a4fb9c2436so4216436f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482501; x=1752087301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Etx308N3I1KijyhBGAM+HBbz94lNBN0h4vUS6IObI1U=;
 b=qreMn/7jUJ9TuaxEKCVfy530ELpMUL3dWHMHFPIG+iGNfpJxpzn06Qj2WgWckwf4ky
 91NS91SnPQTGC5fHGITtMWE9OZWI68G4eRN6DDFM44nfhhHj3BIBxnnp6ObHVifZs0zg
 CyjR8KVOEfZ/yQ3g+UziUT2J6hHPS8ICVy552Fz1igWeF7Tw/WVmJuwzfO3OrYY+Tu3l
 Y0gwsjmU/1TnOVERFFmzuG0cwbOcJN1ITyyldF+DSjEL80Denk5wQSkNAsw3rwSvByOF
 j6veQfHC2KnETEmQdHaq/m0VRj4Wc5SNWRJa3rgr34rV0D51AHh8R01A5wxNQ4PwXTDn
 g3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482501; x=1752087301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Etx308N3I1KijyhBGAM+HBbz94lNBN0h4vUS6IObI1U=;
 b=Zvsi6uPTOgMh1mkYNXbzGh43WXVqrsVSIA50KITTvwtPdOu4vWtGBmAMKlxHbL37C6
 ThTmf+FFNPp4sgjkGbTRyQdiPQMGlU/z283wMK5+JdjuwZJbfNMe74uSx1UVEMevdZdd
 mrVEJYGkVSBqvBCpRf4uxa1aYC3o/gwq/ztOQdkyYXN/ElPIpQqFIIQf5Jwh5fSJKWog
 /aCWDyo+DPAHHE4TV4972D2rmIFqyo5luQjuP+xvxzXwf3yV/5QM6yEeMqz6IPcEwftU
 5ZFZnWaM8z+AQdAbkGxH26XX86XeyNGH+VNPvceUq1D6+OYK0kBaFbRIwi1d3IGNAtg+
 UNDQ==
X-Gm-Message-State: AOJu0Yy2Dwdx9AosiVqfijuWybUAc899Ej6NqeovHor+kaMb8fG1rQ7/
 RCl5fPoet4z8YQu0S9dSgw+wmGjKqisdvBZeNPN7G3Wi8TuUgV7oVWOtKvmYsdcqFN4vF80I97T
 1wXTl
X-Gm-Gg: ASbGncsGliknSqeOHO/FzzZy/MHXZeVbRrKccXLKgCaJ3oYVjm4ijH/hMdsqFg55hhH
 825b8LZuHKCZUTJ726O996noKmZsqtqi5mv9J2dCZi0xy9pBK9ZXRYq3yEqHby4Dn9754e3ZZCV
 XW0Ope8dP+XGFE4Zb9oLnk5dsCi0tzyXRLH40VPMgLlUcQG1uMVfocbjC6RO1TttKsIzhq/Z4uX
 aDHaf1UieirdbsJ1TB763DM1J9Ka85Er5s3X+GNdvyEWkFCGgXjfD0RVhdbNumVAko6gplwiB1s
 yr3Al4B5lnEdo7N16rhAyvgs27wHZuhLh6joyfVSgiYjVZbjxcM4yDf1L84B5Pzi5jxE8iuUukD
 B0ks2v5m48q2ZktKVzch7ZtijFFbCENl8b35S
X-Google-Smtp-Source: AGHT+IG2rGK5f9Ph/LArDkdK1jqQJ+Q1JQBsKWr5JT1POzW+GOK/Cm1eSuCkWhz0sw4eCuQb71iojQ==
X-Received: by 2002:adf:9787:0:b0:3a4:dde7:ee12 with SMTP id
 ffacd0b85a97d-3b32fe1179emr177533f8f.53.1751482501392; 
 Wed, 02 Jul 2025 11:55:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5b2a7sm16819539f8f.69.2025.07.02.11.55.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:55:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 12/65] accel/tcg: Prefer local AccelState over global
 current_accel()
Date: Wed,  2 Jul 2025 20:52:34 +0200
Message-ID: <20250702185332.43650-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index d68fbb23773..c674d5bcf78 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -82,7 +82,7 @@ bool one_insn_per_tb;
 
 static int tcg_init_machine(AccelState *as, MachineState *ms)
 {
-    TCGState *s = TCG_STATE(current_accel());
+    TCGState *s = TCG_STATE(as);
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.49.0


