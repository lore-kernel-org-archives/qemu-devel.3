Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3A8D1D478
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 15:19:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdrmY-00026y-Tj; Thu, 08 Jan 2026 10:18:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrlf-00018Z-OG
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:45 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vdrld-0003gE-Hc
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 10:17:43 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7b8eff36e3bso3426641b3a.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 07:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1767885460; x=1768490260; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HFri5ZA09xRzAtu6L+gPED6chTkzb719Dd9fZBMyM3c=;
 b=cWoR2m+VRDFDgEp3aOwrVmnRAGJec5kc88IXrLU6adqA/ZSMv2cv3wGQM4fnNkYUmQ
 7e8RttQFGbheKQukKb3++3fLq6QpD1FmUUVbv80WBQXFJLoFHvsTbtSMxLTmSaNmiuVj
 IVeFYadkS9xCsun+6uBL6IS92inQTdoAqqlAYdXF8BBQ1MpBhGZdLajNUdJ06B5jc0LX
 +xiaesAomrLrfHmVL892jRv7U6rTjzl1zSRUkDU0Dx5cElhQFMXKR3IcpLQ8NE0xM5G7
 Ip63vTBI5v5Y5/gCNvaxVif2IMmM0zUQ0r6SsEsQed/CaLW5OsDtP1FyjPKkh1MvrB13
 hqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767885460; x=1768490260;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HFri5ZA09xRzAtu6L+gPED6chTkzb719Dd9fZBMyM3c=;
 b=Lb2ftpwqm1fUuu8Kmoaqa7mxbgj5HcQg0UKlSUTDvFvxd2mzdVK45AB8XENlToHrLb
 MGTzvQ4EJFrxDr4pq5as39i+jBMWRGPz0PppPUUZNhQbVTFea6OtgLOW7v90LXy9U6GZ
 kuou7gWeknopb5+/tlhgGHrU8bF4fsZJuk+7BWkEyWo5sjBks4A9eSLSnz9m2jZWDt7i
 dOnb7tV5VOFIff577mnd5ldrn5f6yUNdM9kGj31OLhNTHCXi2F5ZemcvjbEcGU9l/XE3
 qGtf5Qjv1cXF7tsCIdJTu9WsK/rPltVYwvwb0zHYV5+E6TS6ygta7KorSo87Ew/SkK+8
 KHJQ==
X-Gm-Message-State: AOJu0Yx05697GmKHiWn28Njb9lfEXBXfFyTD/A63rVw7HO9yXI9td/2m
 q9A20b3yX5UzG55uJhipn31ZAr2Oi165QO1mHxyfWuzOx5MPayJkDuBktiQAHNK1GK8jZti2KkW
 zh5kGbzfwrjGmCfht160+FfEP6OsrOmLJHoaaPTge86YDXVa3TI2Tz+udLen09zx2svwwW+1UgM
 B+ddf2EFLN3WVQ5MQmTdHwyTO1Zspp370qFyvLFs0=
X-Gm-Gg: AY/fxX4orACC9lp+lPZdcJcwH/BEZ1g9ckAgFzuiiEVNszk0R6FBkVIjMw21x9i3xdY
 zL6Nk/Hb/A5ZXnjCQ+C1vT2KaTSy0oRcMFdwQqcPbg+GK4TGBNtzKJM5Hr/INR2kJIsq3E09DtP
 tfrA2K9q6bYuyovXrTNrgihXDeHaZ0LqWltC0rzC47nfO8BgPrVIzYvBoDGB0wUHDH1z0jbiWLB
 7H9Z6bwwDYxMSMS+JAHjPhwIAC1ThkVxSVhwC8FG6thnjepJK3FjNz8SpV1xDWVsO64D8rRHb8s
 O3ZCOX284JYZ4gUZE1b3o22v7n+/XRtD9TaFh8wyaqJebRHNvDfZtOgLYLP/3j+DcLVInOFjzv8
 Oj+RFLrh9wmzDtVB8QeQ13VWQvG0dKQArq+4tMEpPY99EJjXx0YXjystsypnmuxDYlNO/ReSoNy
 jQqZ33XxjGWm/lH1b/iasJ40kz0fWc4A2lpM7IaNypS9OnAoMVwdxxijs=
X-Google-Smtp-Source: AGHT+IGCi2YNQzFt1tst0ktqMT44HaOaPIaDor3NEsGDB363eFrbnvaKbJjZ1cOnJ9rzv9C7sKNuZw==
X-Received: by 2002:a05:6a00:408e:b0:7e8:450c:61ae with SMTP id
 d2e1a72fcca58-81b7ffd758emr6072210b3a.69.1767885460018; 
 Thu, 08 Jan 2026 07:17:40 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81d87955bb6sm1060239b3a.50.2026.01.08.07.17.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 07:17:39 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 14/18] target/riscv: Add cfg properity for Zvfofp4min extension
Date: Thu,  8 Jan 2026 23:16:45 +0800
Message-ID: <20260108151650.16329-15-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108151650.16329-1-max.chou@sifive.com>
References: <20260108151650.16329-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=max.chou@sifive.com; helo=mail-pf1-x435.google.com
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

According to the ISA spec of Zvfofp4min extension,
"The Zvfofp4min extension requires on the Zve32f extension."

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c                |  1 +
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/tcg/tcg-cpu.c        | 10 ++++++++++
 3 files changed, 12 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 081891c97a..9d4fc3ab6b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -193,6 +193,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvfbfwma, PRIV_VERSION_1_12_0, ext_zvfbfwma),
     ISA_EXT_DATA_ENTRY(zvfh, PRIV_VERSION_1_12_0, ext_zvfh),
     ISA_EXT_DATA_ENTRY(zvfhmin, PRIV_VERSION_1_12_0, ext_zvfhmin),
+    ISA_EXT_DATA_ENTRY(zvfofp4min, PRIV_VERSION_1_12_0, ext_zvfofp4min),
     ISA_EXT_DATA_ENTRY(zvfofp8min, PRIV_VERSION_1_12_0, ext_zvfofp8min),
     ISA_EXT_DATA_ENTRY(zvkb, PRIV_VERSION_1_12_0, ext_zvkb),
     ISA_EXT_DATA_ENTRY(zvkg, PRIV_VERSION_1_12_0, ext_zvkg),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 59302894af..353a932c36 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -104,6 +104,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_zvfofp4min)
 BOOL_FIELD(ext_zvfofp8min)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index ba89436f13..c095bc9efd 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -715,6 +715,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         return;
     }
 
+    if (cpu->cfg.ext_zvfofp4min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp4min extension depends on Zve32f extension");
+        return;
+    }
+
     if (cpu->cfg.ext_zvfh && !cpu->cfg.ext_zfhmin) {
         error_setg(errp, "Zvfh extensions requires Zfhmin extension");
         return;
@@ -738,6 +743,11 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu, Error **errp)
         }
     }
 
+    if (cpu->cfg.ext_zvfofp4min && !cpu->cfg.ext_zve32f) {
+        error_setg(errp, "Zvfofp4min extension depends on Zve32f extension");
+        return;
+    }
+
     if ((cpu->cfg.ext_zdinx || cpu->cfg.ext_zhinxmin) && !cpu->cfg.ext_zfinx) {
         error_setg(errp, "Zdinx/Zhinx/Zhinxmin extensions require Zfinx");
         return;
-- 
2.43.7


