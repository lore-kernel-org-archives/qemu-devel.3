Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A2EAC3600C
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 23:05:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzOBd-0006kt-91; Mon, 31 Mar 2025 19:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzOBb-0006kb-IQ
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:04:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzOBZ-0005lK-Qy
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 19:04:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43cfe63c592so50200995e9.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 16:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743462292; x=1744067092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BIwoF+GPbpxMD6AIqgIwHFGJjyw7iyBvkQD2QC7CyfI=;
 b=hbFLxMK6yVuDK7+IhMqnG9IjMNLMGb47o/7nkjnlBOnOsfjA0ZVHjZIzJ1fMP0n7Tx
 JygYtJpEFcIevNcfhjyIcVZyQ1WAz0EEue80Id3lHXLshKqyhpa+g5KVybZg3m+K7ln/
 3TGjEvxA2oynSNsUxObv93+w84WpGBiD8yxbY9dsT9GRSapRPD0iWdILBAV0hfGFTSZ1
 DAlqLTjZTDzO0VfPQt9BWc4/SloBNoI+PUVxUNx1wvI4sxF9XOGHOxcvBewJRz+P5S8B
 QHzB9NOz4Z5v5bSuTExLq4eySGF8aOsLYkrjtpGIqAwcUSeCJuZWNCOwUr2uW3mcczIs
 i7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743462292; x=1744067092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BIwoF+GPbpxMD6AIqgIwHFGJjyw7iyBvkQD2QC7CyfI=;
 b=u499BnaywMFBjK558OuX0e8equKjWRkPEZfQCoDASyDp0YIZgTN9fbJRsoHoUflw3l
 4Buw8N62Ko1+oCA8ES9k3VcsF27n6vKP4HHfGALJqD0aFSbVo4MXtbhI6a19e+CWfqfk
 rJL+YuOrI7AaSVMgYEg6XaSTaa+PEo0uPUKTOtYh6IquKOPCU1rRVURB6GnHd7SLScd6
 PR4ix985Q2bbUapLnOKQNlWG6kaV9rXeKs/gfFfoDZeXJUQEbiG7ElPxVXNhmCRlhNGG
 ukgCT5IQGvxgUa8Fd8sV9gVkAv7J58P8LFUtZmFyyiIhA1koEddoik7letp9xAGr4k4L
 FlwA==
X-Gm-Message-State: AOJu0YyreJd3EBgaxzXKVgeA/YqJXrk71y/tSRjNtCfZay1PE1nI35Jy
 hetBiwHT0GoEVW6Yi9LpZgxbejg+BSgANMv1Uqz1YqbMaS0SUHp3GnAZ9pwCgeTOVkgImJSGFEg
 v
X-Gm-Gg: ASbGncuhdI3J8Cp3lLtDQ6bbeRuV2lepczz302xTPxBJhZaiUdvGYTEGmuu0nI5pELp
 O7zsRE+eDWsMzrDOTNmt6CYJllua2S5mZ5ARqRq1XgOv7aBVTrRDBZwlzsJQCHz9viCtA5xR7N4
 YO+PRCCT0BU48tEwio6AvoK8FmWmYvSW2UQYU55qF6MP1+SDTE1IzTxIKKWFqLXNcbRxu7+FyuW
 KXOkOr1TklFQOdwMlJ9oNbpjVbcTEIIKAOxe3Qg2Sm9bqdaDJVKTKP3uDa3GNvCVX2wYXEWmVOG
 ku9AAUVA1oS2AQtEnKAyhdWw9YBIUDMc/Y5zwLX84fldbqoQXucp+1elt0tsIV3hQZiy8X/gnme
 DAKoqCMGWHgqoM2sPNWg=
X-Google-Smtp-Source: AGHT+IGUilWhJMwZyv1V/AuW/cHPS9rG+VU64t83RM44b28se6lJCnS81qadmgoX7hhrC4ZW+uluSQ==
X-Received: by 2002:a05:600c:3b9d:b0:43c:fe15:41c9 with SMTP id
 5b1f17b1804b1-43db6227a09mr87300745e9.9.1743462291971; 
 Mon, 31 Mar 2025 16:04:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede2csm178484285e9.5.2025.03.31.16.04.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 16:04:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-arm@nongnu.org,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.0 1/2] hw/misc/aspeed_scu: Set
 MemoryRegionOps::impl::access_size to 32-bit
Date: Tue,  1 Apr 2025 01:04:43 +0200
Message-ID: <20250331230444.88295-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331230444.88295-1-philmd@linaro.org>
References: <20250331230444.88295-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

All MemoryRegionOps::read/write() handlers switch over a 32-bit
aligned value, because converted using TO_REG(), which is defined
as:

  #define TO_REG(offset) ((offset) >> 2)

So all implementations are 32-bit.
Set min/max access_size accordingly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/aspeed_scu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 76cfd916716..6703f3f9691 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -427,6 +427,10 @@ static const MemoryRegionOps aspeed_ast2400_scu_ops = {
     .read = aspeed_scu_read,
     .write = aspeed_ast2400_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
@@ -437,6 +441,8 @@ static const MemoryRegionOps aspeed_ast2500_scu_ops = {
     .read = aspeed_scu_read,
     .write = aspeed_ast2500_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
@@ -779,6 +785,8 @@ static const MemoryRegionOps aspeed_ast2600_scu_ops = {
     .read = aspeed_ast2600_scu_read,
     .write = aspeed_ast2600_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
     .valid.unaligned = false,
@@ -906,6 +914,8 @@ static const MemoryRegionOps aspeed_ast2700_scu_ops = {
     .read = aspeed_ast2700_scu_read,
     .write = aspeed_ast2700_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .valid.min_access_size = 1,
     .valid.max_access_size = 8,
     .valid.unaligned = false,
@@ -1028,6 +1038,8 @@ static const MemoryRegionOps aspeed_ast2700_scuio_ops = {
     .read = aspeed_ast2700_scuio_read,
     .write = aspeed_ast2700_scuio_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
+    .impl.min_access_size = 4,
+    .impl.max_access_size = 4,
     .valid.min_access_size = 1,
     .valid.max_access_size = 8,
     .valid.unaligned = false,
-- 
2.47.1


