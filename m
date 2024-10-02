Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C41CF3195
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 05:57:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svsIZ-0000zC-Ff; Wed, 02 Oct 2024 01:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsIG-00006q-8G
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:53:02 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1svsIA-0004xN-1b
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 01:53:00 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20b5affde14so29363775ad.3
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 22:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727848369; x=1728453169; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GgHJFHRErVXv8iC/NtA98MYttf4gmQ2c6OzCMYUuB3I=;
 b=RmyPm50zeQ9XTFY/hw7YyJwY4h0fapOMS1WOkvZ7vs7lQjCvKuUfPhA6y4ztpwrbtt
 Ora1lW35YafBIbJsf+La3GnVAMqs82Avk00ny/m3VWOjzxvX3pspyf4VtwWK1snp2sV9
 5pUVjqVTikDZFgQ9yxti1oJDc7AXmPGE9ObllaXGHI/e9Hq2HOzz6yra0YM9idAY23yE
 MMdn74cGScTilkJ0kcGI8vcuGD457VLfcosDTlAEZ6c4AUFP0tTyw+W1lwo2zi1wVzcV
 9KFwRBQqNBd04sDC0zhAaOt49zodcc+HsvjOkZ+OoOeNsrhIPRgwyo3lOWJRNqyK1QQR
 Ve9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727848369; x=1728453169;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GgHJFHRErVXv8iC/NtA98MYttf4gmQ2c6OzCMYUuB3I=;
 b=NDuR+O88Ec64TqZf+o2m+sOoaLh3gMB+/YiuqyzUkBd7o0bqFTMf40MUufBxcSSBuk
 f7/fI2jTF/crQ1kVqc7sPLodG5T42eGJPAkbd1W2f6WVgaoyU7RRdf4C87GZHF8+RFzy
 P+eKj38B9qFFhlOJykkEIHTuKgNdtfIJ1SP2wbA+EjNBDPacu2gA4s47+5x6mQ6FFrvK
 HGl5sjddSIUf4yPBV/OaDwCAfYGgYIzLbjjD6X13M18G81uLxxuaBkiHbAa1xfqBAHS+
 tMQt8VULtFXrsJWU4FnYukWEka27+tod2V9w8vOMO6A+omrpscp4LECDXcx/o8a/PqqJ
 hFyQ==
X-Gm-Message-State: AOJu0Yy3Jaw+S000JPVxZa4a2gBQMuetk6eEgrrKnBltEjnuwFR3dv9S
 R8AHq5EkGYRaMm/4iPKM+f9gZtLTDawXYYHljpzW4Lbsw7G5UGPhllXF4fRZ
X-Google-Smtp-Source: AGHT+IF6TjlUeb+rAwzXkOND+C79GlUefC0c2fsBDvkhdJfLaL34MixMKemsHJ3yPgM9I9nnuENevg==
X-Received: by 2002:a17:902:e743:b0:203:a0ea:63c5 with SMTP id
 d9443c01a7336-20bc54c0e90mr30111935ad.0.1727848369381; 
 Tue, 01 Oct 2024 22:52:49 -0700 (PDT)
Received: from toolbox.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20b37e60c76sm78324235ad.269.2024.10.01.22.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 22:52:48 -0700 (PDT)
From: Alistair Francis <alistair23@gmail.com>
X-Google-Original-From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Warner Losh <imp@bsdimp.com>,
 Ajeet Singh <itachis@FreeBSD.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v3 35/35] bsd-user: Add RISC-V 64-bit Target Configuration and
 Debug XML Files
Date: Wed,  2 Oct 2024 15:50:48 +1000
Message-ID: <20241002055048.556083-36-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002055048.556083-1-alistair.francis@wdc.com>
References: <20241002055048.556083-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x629.google.com
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

From: Warner Losh <imp@bsdimp.com>

Added configuration for RISC-V 64-bit target to the build system.

Signed-off-by: Warner Losh <imp@bsdimp.com>
Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20240916155119.14610-18-itachis@FreeBSD.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 configs/targets/riscv64-bsd-user.mak | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 configs/targets/riscv64-bsd-user.mak

diff --git a/configs/targets/riscv64-bsd-user.mak b/configs/targets/riscv64-bsd-user.mak
new file mode 100644
index 0000000000..191c2c483f
--- /dev/null
+++ b/configs/targets/riscv64-bsd-user.mak
@@ -0,0 +1,4 @@
+TARGET_ARCH=riscv64
+TARGET_BASE_ARCH=riscv
+TARGET_ABI_DIR=riscv
+TARGET_XML_FILES= gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
-- 
2.46.2


