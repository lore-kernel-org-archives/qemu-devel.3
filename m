Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBBBEE6442
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 05:31:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1socPR-0000VR-2P; Thu, 12 Sep 2024 01:30:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPO-0000PI-UI
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:22 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1socPM-0002za-QQ
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 01:30:22 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-7d4fbe62bf5so422666a12.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 22:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726119019; x=1726723819; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEqcrjvASUkXL9sGfBA1/Ox7MJPQ1GfLBPBXbleYroY=;
 b=O/X9HS44ngc0554KfFV/w5QodR31pKanRatBhKhEq20f7FEjQ2/NG9UQPNEbspge8g
 6r7ZuwK6zyf7edv4m8ATflpJLhb2ywZx/rn3fwzceIdrwIEQPdoZ7n20KSFY9APJiCF3
 PQ+OsvR4OY8eaSnlU/StP5vRf+ToGMFw0mccMwJibogHkrUFfoxp4RFsBJXT6tIVYwOT
 /f7ub8ZsDNzI2eAeblbom/3cHvVg/hu2xw590Cd1n64TpYVTuS7MFWLxsKUqeoBK8aFR
 3zwe/gLRdwdG727z35iowz+8UlXqf90PD3zxZXywSw4ailZwChwwjKOjwNx62D9xbQD4
 ah+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726119019; x=1726723819;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nEqcrjvASUkXL9sGfBA1/Ox7MJPQ1GfLBPBXbleYroY=;
 b=X89HwoldmkT4VELPJD+ngi1J77x5ViMm2KK9jQ78aI70S74UNR5QFjXsgvLm2VMCFy
 TzVrv/zujGZFy060CFIE00w+a0SjykxjN8aY3qmQovPhUBcxcJPYdyOYBroCK6nlDNA+
 xqfEeN1VyODntYbzxneKdp7QW9CCdpEvblG2/ElbpVmOLNNxFyC1cm/qSIcIW7KoiPS8
 DDpDuM3J7Mjqi6D2/gXMDh3R6CQc/1fTyqk73+Q7JxUA6/jX+PRCExBUlIBHgPli/zTU
 yEFLasytMro0N9qC7rFNAG+xWHPVu0CsXZ3R9BOHD8Jng4jGCXtQYDStWvEq1hgDdQ3y
 p6jw==
X-Gm-Message-State: AOJu0Yz9guz5M2vUBQpUA2TeKtATUxlnN4xCDSdIW2LEBtdFzlCXB/Ns
 ovYp0Te1Q/EpssR9a0pCdzhNl/KmxTVYyoc9wNrRTeV7wt2qsoMgTEnlTw==
X-Google-Smtp-Source: AGHT+IGRPKx+qBHm3vsMn4jtwC5gZkT3VqRqiW3oCN+c6LTe2XLKYjgK0GXly0VbxS8YyX20O5nRpA==
X-Received: by 2002:a05:6a20:2d09:b0:1cf:6d68:5654 with SMTP id
 adf61e73a8af0-1cf75f10dd0mr2078779637.25.1726119018657; 
 Wed, 11 Sep 2024 22:30:18 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71908fc8fdesm3833034b3a.1.2024.09.11.22.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 22:30:17 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Vladimir Isaev <vladimir.isaev@syntacore.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: [PULL 06/47] target/riscv: fix za64rs enabling
Date: Thu, 12 Sep 2024 15:29:11 +1000
Message-ID: <20240912052953.2552501-7-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240912052953.2552501-1-alistair.francis@wdc.com>
References: <20240912052953.2552501-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Vladimir Isaev <vladimir.isaev@syntacore.com>

za64rs requires priv 1.12 when enabled by priv 1.11.

This fixes annoying warning:
warning: disabling za64rs extension for hart 0x00000000 because privilege spec version does not match

on priv 1.11 CPUs.

Fixes: 68c9e54beae8 ("target/riscv: do not enable all named features by default")
Signed-off-by: Vladimir Isaev <vladimir.isaev@syntacore.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Message-ID: <20240823063431.17474-1-vladimir.isaev@syntacore.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 8f21171ffa..f93bf9c221 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -115,7 +115,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zihpm, PRIV_VERSION_1_12_0, ext_zihpm),
     ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
     ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
-    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_11),
+    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
     ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
     ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
-- 
2.46.0


