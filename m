Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AFFC02185
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jan 2025 01:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZJsD-0001Ag-1C; Sat, 18 Jan 2025 20:13:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJsB-00017m-8C
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:07 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tZJs9-0003Aj-PN
 for qemu-devel@nongnu.org; Sat, 18 Jan 2025 20:13:06 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ef760a1001so5877643a91.0
 for <qemu-devel@nongnu.org>; Sat, 18 Jan 2025 17:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737249184; x=1737853984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8DOhQ+RXBVevo1zbAu7m7gJRKhDeUWa02zeKmgIvRqw=;
 b=bo6cmvci3CnaxMiCmXjcV4VEgVi4XKqCH02tstfNZXZT3zey/gDEuayVBZuR+0AZzk
 OcrCeG2R+InOKucne1d1VTn4CNyrfp/NV44dS6r2/jlzMuPzRxkqME0QdfiJok5si46u
 1eO7qP0w4uI4ggicyeu8tOoZDSg8Nu53rQ6UdajOcNVzaRb9vhB07di5QJy2QoYTZxkA
 SHEZstQ9KwBEcM+ZWu2JMZ6EeYPdf7NxlOSohsXvCDiqXhdMLzURx052PbRrzJqFrh8M
 FF5Av5kfPqA69bKtXLSDqsH4glJGaZpiBYPXkXjWsy7OIrXrcjYtQ5X230do1ejL35sx
 jthw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737249184; x=1737853984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8DOhQ+RXBVevo1zbAu7m7gJRKhDeUWa02zeKmgIvRqw=;
 b=oOuheACqvcpZfqf1r/B2CuIBP2oS9n1gvoMM9Q3x/8RPXdGXGNh3oyiMgCbzZN2/l9
 8cUIogNrDwd2RQEdHFS1AbIISQdkeaWh4L+Bzficnhnjfn58Tc2uznN6p+XZRwqplYf7
 ttwmF2ImC52d6TkQ1Z65L6SacNc83Bbu8H0ytAWR9SKcE6nfBkAKgYsaXeqThktI9z18
 zU4dO1e3ECV+trulFgck9Mx4oCqc2LxcwSzI70Hj5ak/srC53lv7sgD4ECE29pcjdRrr
 pKod/gwe7a8Az8j5oUNpcMmAk/uvm2p8+fZinNvMWcJCmGHY437IbLGagOTRaxujr4nN
 iWDw==
X-Gm-Message-State: AOJu0YwQ6poSHFYW6DpX8KfR4F0MDd0BnrwSyCOZtG6eUSpNI6+YheMS
 I3g8H9m6gjqkA6P+eYVm5GuxhHU4V49I8Cy1xwclx9RVxs8rW6DrgiLJjB7f
X-Gm-Gg: ASbGncsLSYYp2ehy2Y1ULXZb432/1215OoItYzOWPPmBo5/lYm+KKzrOWbDDzpIBmZu
 S3AXimk1B+bJCm2GfaQJb5/4D+Bksm+z+6sRZr27w4T4m2yQTw9Arqc7oIgdX76GINTsYJ7es8g
 uJ/0Xz7xQAlUpJzTPNH9EuZ2tN5aCrGcBgZ8+RrxOPcFStp8CBbmnPg8oLJJdapNqUIhIK5GNTd
 9jPIab45Nm5EtBk8Xgdn21OxrQrnh3wfpzFBZBWVPor18070f2Ev4NywxqmdqUVS8GWaIPddXaa
 mJN78+lRyDPap3pF+MlKSGYYo6R60S7RGYJWygFn5MqHveQCa9udsknk71KLtwuIazTfbxyeHQ=
 =
X-Google-Smtp-Source: AGHT+IGuuT+yyZhp4Nv6LSb8zXuUepsck96krlomKMIUv5JWG1CuvEkCAMHIdPl86b5/kMswyaCdGw==
X-Received: by 2002:a17:90b:1f8f:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2f782c71e64mr13880188a91.12.1737249184173; 
 Sat, 18 Jan 2025 17:13:04 -0800 (PST)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-321-6fb2-58f1-a1b1.ip6.aussiebb.net.
 [2403:580b:97e8:0:321:6fb2:58f1:a1b1])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f776185b02sm4760314a91.21.2025.01.18.17.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 17:13:03 -0800 (PST)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 08/50] target/riscv: add shvsatpa
Date: Sun, 19 Jan 2025 11:11:43 +1000
Message-ID: <20250119011225.11452-9-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119011225.11452-1-alistair.francis@wdc.com>
References: <20250119011225.11452-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x102c.google.com
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

From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

shvsatpa is defined in RVA22 as:

"All translation modes supported in satp must be supported in vsatp."

This is always true in TCG so let's claim support for it.

Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20241218114026.1652352-8-dbarboza@ventanamicro.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 target/riscv/cpu.c                |   1 +
 tests/data/acpi/riscv64/virt/RHCT | Bin 374 -> 382 bytes
 2 files changed, 1 insertion(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 20cbb6b2f4..2f58eeb689 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -185,6 +185,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
     ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
+    ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
     ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
diff --git a/tests/data/acpi/riscv64/virt/RHCT b/tests/data/acpi/riscv64/virt/RHCT
index 2c7dc6c9ab..fcd9c95a6a 100644
Binary files a/tests/data/acpi/riscv64/virt/RHCT and b/tests/data/acpi/riscv64/virt/RHCT differ
-- 
2.48.1


