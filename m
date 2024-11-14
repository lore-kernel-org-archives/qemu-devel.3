Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2660D65C61
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 09:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBVvz-0000Mu-Po; Thu, 14 Nov 2024 04:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvG-0008JP-Nv
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:55 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cleger@rivosinc.com>)
 id 1tBVvE-0007hD-E3
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 04:13:53 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4315e62afe0so3885835e9.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 01:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731575629; x=1732180429;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pPcEE6kBtAUoaXinJQfR30MxYrRluNtCFG7wXxXLjDk=;
 b=iumQSKIUlFI7KpghndbmJBvsF96tpNdzqIcMumJqD51j4lLna5+2GGmRJEgCzbDf+3
 txaCJDVzZIhAhGpB01pr0P4YeMAaURT+YwLFDtAIKes1Akvg68SyHOXHef2k0BsLuLqK
 wP0ltV1deJaht0Bg7Vdxa4070nRfTpqmGTworXewauanqHRxdJ4mhgn98e0EdMgB1N0i
 80DNtGhwSLLtGFuRayxj3EOnLGB2OWTyyHWle6H6OGPwoFf4rCVOTlh4o0rCW7rrXLAP
 CGmKS5W+yBmCzExdMu9PQ0rJT6Si01OlYxJ9RNLbgMA2kpJxSZjjh+0vr+B42EZmAXA+
 5K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731575629; x=1732180429;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pPcEE6kBtAUoaXinJQfR30MxYrRluNtCFG7wXxXLjDk=;
 b=KlDmkpewK7uDLXFhnjj58HLDVBKWHL43y8R0yupHtuCiuobOST7BHXgUtxq6Ld/DaJ
 50YVevFUMQz+pG9j/YAkak+WrSAcqd3UW+jxIM3XRQA0jqsqXbYY9JICC63vp8Herwty
 kRjGUUDzSj7IC5/4HyRLPJZ6DlkrwOI3AOMscKdPrj8EwTiJHeYxrNu0RvRI9nX8vGW1
 gOA++gj4vCVrCCYPVSEBZKKEr1LYi9dhOZuZYqV7Ocr5ctICORkzAVRohzLp0nGrPkmu
 4YEaFXsYU+02ru+VSUKWvYaL4wv7ApqyycXlg7Fsj9kktg0hY9xa4PpVeCRy+WxiKi/Z
 9SFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh97HQg+zSMUzK5PiNqnpyjO8t5AkU61Id+BygTjDvxw8+nwJsGkexkeH/Bxr8vCgyC2Uqk9LVThVz@nongnu.org
X-Gm-Message-State: AOJu0YxhIyx5wO2ql1lRvxpo/M4bqrOatlmblOXTxTlcKCsvBzgYm080
 vQ3ZiWIgj4z+FGV9/X0UTwv7iYFp58wZiu0QURzEyeonVnaI06cqxB+ovWi1wcM=
X-Google-Smtp-Source: AGHT+IHiNA+yclBvxbnb+D0si2ylXsdA8SsvFd/ZyaQm6rcDe0u/O8IeCwLuWhkX/ctTPpJAoUSb0g==
X-Received: by 2002:a5d:6da8:0:b0:37c:d2ac:dd7d with SMTP id
 ffacd0b85a97d-381f1872f17mr18581747f8f.30.1731575629107; 
 Thu, 14 Nov 2024 01:13:49 -0800 (PST)
Received: from carbon-x1.. ([2a01:e0a:e17:9700:16d2:7456:6634:9626])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3821ae313e3sm899050f8f.94.2024.11.14.01.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 01:13:48 -0800 (PST)
From: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>
To: qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Ved Shanbhogue <ved@rivosinc.com>, Atish Patra <atishp@rivosinc.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v5 5/9] target/riscv: Add Ssdbltrp ISA extension enable switch
Date: Thu, 14 Nov 2024 10:13:26 +0100
Message-ID: <20241114091332.108811-6-cleger@rivosinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241114091332.108811-1-cleger@rivosinc.com>
References: <20241114091332.108811-1-cleger@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=cleger@rivosinc.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Add the switch to enable the Ssdbltrp ISA extension.

Signed-off-by: Clément Léger <cleger@rivosinc.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5224eb356d..39555364bf 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -190,6 +190,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
     ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
     ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
     ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
     ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
@@ -1506,6 +1507,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("smrnmi", ext_smrnmi, false),
     MULTI_EXT_CFG_BOOL("smstateen", ext_smstateen, false),
     MULTI_EXT_CFG_BOOL("ssaia", ext_ssaia, false),
+    MULTI_EXT_CFG_BOOL("ssdbltrp", ext_ssdbltrp, false),
     MULTI_EXT_CFG_BOOL("svade", ext_svade, false),
     MULTI_EXT_CFG_BOOL("svadu", ext_svadu, true),
     MULTI_EXT_CFG_BOOL("svinval", ext_svinval, false),
-- 
2.45.2


