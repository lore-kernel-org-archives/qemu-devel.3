Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5CE2C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 17:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmc2h-0006tm-MC; Mon, 24 Feb 2025 12:14:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2f-0006tW-QG
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:53 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tmc2e-0005XX-7O
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 12:14:53 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-220e83d65e5so89267985ad.1
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2025 09:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740417290; x=1741022090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jknw50nLFxGT+sVPBNznLaWnIUl2IMWVe2NVNucuTpE=;
 b=whXCHXiKA2zGcvmkaD2c8O9XoHTANlrtyOzIy9R4ZbndhwQHLXsN+KAr1RUQ+IGplp
 mngjXb1AevOWbvtL+HRyWiM5ybbwMoEVLYkYypM1c71vJTatdsHIJlXr2ukBIf2CB5HQ
 y6KraUcW7pJvu3zldh0CE7dGguDXlJ7jsMrGLtabfKGFelRnkFy7NVOTC4bHHebOSZpR
 GrutRxVwStonEwGhohjTLO/Z19jqSSFlamfZFsL3qwT5+4AwQyCoEutvgPevTC8kOfAg
 MCqyxdECnzn3v27+DPumOTXI2GD24SWocTZVyznVShj2MbG4H4Oxlq+3Y40FdA8GcLja
 bR0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740417290; x=1741022090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Jknw50nLFxGT+sVPBNznLaWnIUl2IMWVe2NVNucuTpE=;
 b=OLfSZd8rI0F9iDBNm+UQG+FIWAKhrOPi3I5diM/DDDqgahshOgKTYFbDctF4c/VXMZ
 lMZ4aqih8zihhkf9Re+KqxSUtv5pJaQ7Naw3AdkbL1oNYwvU0Uo6QPigTBzchYIRXtXo
 sWwroqRgsC1IlHMn4DyWzTI/3gGXNJEOxe2NnOjfg68CjtB5oWOxDLuhMVB7Q+lCivO5
 mL7bhFx04duuuBtW71fp6rIItuleMqNg1Bv5kUbtgC6O2WGrNFcGLy6CxxPZUFeZ5Rl5
 TFomNf0tbtwxh4x3uSia4dIRu2PL7qZF50VH7soCqroKYuF62Vm+zBFLt1sKGKbAQQ/c
 6gyQ==
X-Gm-Message-State: AOJu0YxowVTCKF0U651nv6iJ9W5n5OF5R/BDJWHxNa7FGArx5G4wsNca
 xvj11yvbEzJoHmWHwh/aXyUerp3FmNOgEaJyv5ZOc55PAEHLwXcADqHB4VXELG5St1ELC4fTPpn
 n
X-Gm-Gg: ASbGncuiZs30HZWlXB0Q97JPmFET1u5vOKge6RBBtZ3Fb0oHGPojEMrjd3mErG4KVtz
 bOWu9NZvt3E1bGyXHQa8qAh93MMJIX91HWh/itGfL6JL4ZiqzH7uKZrsF96sOYWzn6JOIuhyWjC
 5or5S5aP5oF241e1zW7faH9jQZ585lu+2/c08YoHVM6pRbw1K68jiK7hW8cuxcgP0ioMEhlHQmK
 4Giqtrelq73AgzS9Q1JDLOgU0qyny/b9vRrNkfgy52J23bQrsou2zKzt/yd2hTAK8TeEUsmSu74
 ZFD90VN/QYqwIrUPDhULczaU8hzvpxsWBFY=
X-Google-Smtp-Source: AGHT+IH95IJvcmvekRtWhHaTY9DiZKZDgCQwoGckxu/x+vZXeNc/of/Dp+ALh7Zj3x0kZBdIzkydpQ==
X-Received: by 2002:a05:6a21:501:b0:1d9:c615:d1e6 with SMTP id
 adf61e73a8af0-1eef3b1aa6dmr25586570637.0.1740417290600; 
 Mon, 24 Feb 2025 09:14:50 -0800 (PST)
Received: from stoup.. ([2607:fb90:c9e2:d7e3:c85c:d4f0:c8b8:8fa7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-732425466besm20580780b3a.9.2025.02.24.09.14.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 09:14:50 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 02/24] target/m68k: Restore fp rounding mode on vm load
Date: Mon, 24 Feb 2025 09:14:22 -0800
Message-ID: <20250224171444.440135-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250224171444.440135-1-richard.henderson@linaro.org>
References: <20250224171444.440135-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

Call cpu_m68k_set_fpcr to make sure softfloat internals
are up-to-date with the restored FPCR.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/m68k/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
index 41dfdf5804..76f8dfca2b 100644
--- a/target/m68k/cpu.c
+++ b/target/m68k/cpu.c
@@ -422,6 +422,7 @@ static int fpu_post_load(void *opaque, int version)
 {
     M68kCPU *s = opaque;
 
+    cpu_m68k_set_fpcr(&s->env, s->env.fpcr);
     cpu_m68k_set_fpsr(&s->env, s->env.fpsr);
     return 0;
 }
-- 
2.43.0


