Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5D2C02180
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 19:58:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXQYh-00088h-Dw; Mon, 13 Jan 2025 14:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYd-0007he-4C
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:57:07 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tXQYb-0007Xj-IN
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 14:57:06 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43622267b2eso50008235e9.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 11:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736798223; x=1737403023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhUm8v193I9EdTSFs2V5uFdqWMCeU2Ex/j1HBHwMUik=;
 b=uobbNsxIy1JMT+WHeQEk53rpwxCFw0dvPfdzMj1eVrzt2bHXU8N75+lEAUaGJ3PsYL
 dYK2on7ZFHlwRIXFCTGfWpA5OAaH9JHWBAmkzmi4uBPnXR9xTGGICT9m5+GbnRnfg1qG
 Qxx1Jwohe0sIgs3MJo7fqa5yMCGqrl57b4dsjZeskYip6X98oJx72LZDqg98eEhr5hQP
 2HsPfxxUTPYmmBH19LxOYOhPt2cNDcwJ46kgvXBvaTV5TYx48ZwdRp/cC5qK5xhSKdIC
 k13BqyHH0dVSyKTHkM0mpVV/cb47Cphh6YrIngsf1NW92zkG/s2pAGOpkTg2FBtC55rn
 ECKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736798223; x=1737403023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhUm8v193I9EdTSFs2V5uFdqWMCeU2Ex/j1HBHwMUik=;
 b=TrCI/r1D3rROU4ip8+oGn2FoptxC+ng2AbEWEDstWcm489pQ0OjRchKLRhnfeVS8gv
 mocObZuotSPXqj3oTYAYmZAaO971lRGAbBl0y29xkBQ0suJc9yc+50Yj3xYIm+yWsCjH
 C7nqgC9QBdGz5Ktr8LFyCKCcBYzVblk5Pq+AR/9xN4frSsMElL68rmI100uPtR2tA5Ic
 q4XGN/wftx17g70tkI+xtCN4k4yVImAE3gHLJqoIuA6/VNz8s7dBAPGNGPIeFsqz56ZT
 aDaVnh9ksDFJE8y32JYkpdCgkff7T83I/3rP25xWT+jAS9jTL0mFWOgcqZRRmyV0Nepw
 CKEA==
X-Gm-Message-State: AOJu0YzSocPlo50reW8aEw+wLPpuTYr/fB7szlPGZSVEY8QOsE4vMvxW
 H0O+5fCla+BsdpIY3h0x54AhN8s4S2v0KBFOBqZspXUEQnr7iOLd7w02HEBe8X+k+AUF7evTfW7
 OLNQ=
X-Gm-Gg: ASbGnctneSNL2+zc+vP5k3BRS12hBxJNFvYJaCt8hn9fRs8nbHT/wBDS6RXZE0A3Qr3
 Sc9S7XS9OPrNCCB8ctHzlkYLrKY4z/j7I9ALGW9COryfyAm/vNDVX6VaU2fHSWMT1UnWyylxwBu
 AJNi1a2x8IO0V8U/9WPE7PbCcFkBNdRb0Tl6JtN5U6SMmDt0kdbwZP7zeniPDVMIqph9SkmFHKM
 hHe4OJxcbL+AVX8qx9nm128AWOJMx96YklJFI2ypdQ/r/AtSTCXn66D3xEjudd7LGclWw1J8tKu
 HXJKfqfzO/pnAGS249diu8CcbDeJ/bU=
X-Google-Smtp-Source: AGHT+IGrh47OtEmSb0ykifqjEXrQTeVM1v7RtPwYWiK/EGgL/1X0s1JU9yxLm07ALoPePBTO00o9/Q==
X-Received: by 2002:a7b:c4c9:0:b0:436:f960:3428 with SMTP id
 5b1f17b1804b1-436f96034b3mr65720775e9.29.1736798223570; 
 Mon, 13 Jan 2025 11:57:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436e2da66fcsm189336025e9.6.2025.01.13.11.57.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 13 Jan 2025 11:57:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Huacai Chen <chenhuacai@kernel.org>
Subject: [PATCH v2 19/19] hw/mips/bootloader: Remove use of &first_cpu in
 bootcpu_supports_isa()
Date: Mon, 13 Jan 2025 20:55:25 +0100
Message-ID: <20250113195525.57150-20-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250113195525.57150-1-philmd@linaro.org>
References: <20250113195525.57150-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/bootloader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/mips/bootloader.c b/hw/mips/bootloader.c
index f02e5aabe48..1969610224d 100644
--- a/hw/mips/bootloader.c
+++ b/hw/mips/bootloader.c
@@ -51,7 +51,7 @@ typedef enum bl_reg {
 
 static bool bootcpu_supports_isa(const CPUMIPSState *env, uint64_t isa_mask)
 {
-    return cpu_supports_isa(&MIPS_CPU(first_cpu)->env, isa_mask);
+    return cpu_supports_isa(env, isa_mask);
 }
 
 static void st_nm32_p(void **ptr, uint32_t insn)
-- 
2.47.1


