Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FBACAC583
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 02:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvRyw-0004mt-Kd; Sun, 07 Sep 2025 22:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uvRys-0004ac-Hm
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 22:51:46 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1uvRyf-0003jh-7y
 for qemu-devel@nongnu.org; Sun, 07 Sep 2025 22:51:43 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7723cf6e4b6so2942260b3a.3
 for <qemu-devel@nongnu.org>; Sun, 07 Sep 2025 19:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1757299887; x=1757904687; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LUMGEGv/qDfvCpbeAiUIIu2AO0GY+0XHtQjRlY6FQa8=;
 b=U9rcs6BzhTtWJ5trGUzc7CgiRJW0F/11wanP2HeEf6XsctgZfWHPd8LLLCylcLrbQx
 I2/wYJhQHzyNv2/S4wOyK9SpFVTETW17iRJVEV6QMD/r8rQYqgOES7+UBvRD4xZXsMPt
 6jyqSd0a4RfFdJfG7+eFQFjoJr3NkcsaSmXp54nZjqNbpXVMAgZ1VCNV7tDj3xIoPeRU
 IGDWb4vBQugNNc+gGa6l2z6ZLctTxofHfXYMHeNstx6iB+WAl0amAEDP0zQKaa1yYU2L
 1VPgRaTXAoZdGO5d4zfD/Gxktd6keLvoMUAn1ZRRGBAag4XwxvFm8TJsutDbyKkxGo7L
 3PGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757299887; x=1757904687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LUMGEGv/qDfvCpbeAiUIIu2AO0GY+0XHtQjRlY6FQa8=;
 b=xMkonSV1xqOjmA0JcwzqvpvvFJGJKFOL6n3wqN0OG2E5m8zHhAiBMzBDNTHcbWoPLX
 BdKxRaZ9lhwLGzT6fCMmNLSHeEB94GPm/yRl9Oo2asLM8d6EmSH/hNQX11Vi1ZMeQ/vn
 xyHijRUphy7jjXaFbTZahhJRQ1RxK9Jwk6Twp0JFfquAhDOPbFDMjLDxM5x9pI2JX1om
 3X8vauhc9Aq1ijSjl7DxrF9nj2TbrOLbFh/Gt9eNCIaDSeFpiBxJje6s9R4TpfgAERvw
 17NqMAnoQ88ISAedKXFLEctcgtjFsfx0j5Kf9Ss+YH5sxQqH3Y0E+ZvO68Pn4qrTHW/j
 zjNw==
X-Gm-Message-State: AOJu0YzYYC15YS4bpAKXIQ9uEXTAJThgApUlQOzJ7zaAPRuEr+Ma1vRt
 jUG6ySLUD7gdc44TC+d1WmC/hW17aF9FGLpKulM6hDc3fXgHl0mFD9eaXkK++czqeukRFC+uMEA
 hqynD3628mDieAEsxZbYBgTMXTR8h9jWTd3WvcGSq0ZPJITf6OgCc+lEqUkVBTKSmCa97ozXlNs
 20tzjsRIiMgFsBxOnQU31XdiU062wlig7QdwcdOKHbZA==
X-Gm-Gg: ASbGncttlggR08r6o5h5VSem7vrbxZK/J1WUw0ME3ykTy+03wgnfPJ0Cc2zj10szNRR
 JF2/QbKFxcBog+bDoenRI4w+T0eYEQn/HBLcjnifMj5GZ98ElN9WKLfF7jcIl3NFswmFR0AuHnU
 ZJkD5L8FXQ1BkZp7I3WxbqtxIxJApm7asyg9mNX2dRI0+mx0Gf6hSdcan0nDeyQK6UPJR4gVU+S
 w3RVHgV73Z/2HltRKGti2vDgVdJoLdGUsBTc9u1L04Vi9ql4yQmZ6FXvnJYD/vFS/DlIH7mSzjH
 xN8QjX44eEl0ntxj4JhmQVAfO+aKKYFCUrRKawEcMuCjjO8pkmVrEhGXWboCZ7qgeT4coi9nwZg
 Qg08ZXIBSRrMAwttfsZMssOnNmSDkVFmZLRx3XD8sgz/ZHE8RXplyTA2AVXaUUEllYjU+ajHKHF
 /35Q==
X-Google-Smtp-Source: AGHT+IH1n4+dL6pP75sZRfhkie6KaRuywQban2JGYjEn6GTWIj4OBEJuvBdqsekxd7+IxtqbVHH5CQ==
X-Received: by 2002:a05:6a00:3e14:b0:772:67f4:57 with SMTP id
 d2e1a72fcca58-7742dc9931bmr7102775b3a.7.1757299887085; 
 Sun, 07 Sep 2025 19:51:27 -0700 (PDT)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-772306a1870sm26823834b3a.75.2025.09.07.19.51.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Sep 2025 19:51:26 -0700 (PDT)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, richard.henderson@linaro.org,
 Max Chou <max.chou@sifive.com>
Subject: [RFC PATCH v4 1/3] target/riscv: Add Zvqdotq cfg property
Date: Mon,  8 Sep 2025 10:51:15 +0800
Message-ID: <20250908025117.1728895-2-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250908025117.1728895-1-max.chou@sifive.com>
References: <20250908025117.1728895-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

The Zvqdotq extension is the vector dot-product extension of RISC-V.

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                | 1 +
 target/riscv/cpu_cfg_fields.h.inc | 1 +
 target/riscv/tcg/tcg-cpu.c        | 5 +++++
 3 files changed, 7 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d055ddf462..d0909f7beb 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -187,6 +187,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvksg, PRIV_VERSION_1_12_0, ext_zvksg),
     ISA_EXT_DATA_ENTRY(zvksh, PRIV_VERSION_1_12_0, ext_zvksh),
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
+    ISA_EXT_DATA_ENTRY(zvqdotq, PRIV_VERSION_1_13_0, ext_zvqdotq),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index e2d116f0df..5da59c22d6 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -100,6 +100,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvqdotq)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 78fb279184..7015370ab0 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -767,6 +767,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvqdotq && !cpu->cfg.ext_zve32x) {
+        error_setg(errp, "Zvqdotq extension requires V or Zve* extensions");
+        return;
+    }
+
     if ((cpu->cfg.ext_zvbc || cpu->cfg.ext_zvknhb) && !cpu->cfg.ext_zve64x) {
         error_setg(
             errp,
-- 
2.39.3


