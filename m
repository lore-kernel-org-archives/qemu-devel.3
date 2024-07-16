Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F132BC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:44:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTn8r-0005Ay-Ji; Tue, 16 Jul 2024 14:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn8T-0003rR-Hz
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:52 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTn8Q-0007Oe-TM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:42:48 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4266ed6c691so37843755e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721155365; x=1721760165; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/mR/0QMhMqGZbfZ0QJaQ5Uy2ur+BzQmeQAtYeietrZc=;
 b=Xl0yDCI47WdKQjLZfal5vCKzXyj273IR+slxK2DAs9dd7VNYlT1SyJkBgmB4IbFfMy
 Xxn1PeKQOM4rd8p+//+kG2caS4GVwxpBDwEHxF3at2ldunhhqRY6zuZKxHYynDshm4B+
 mD8zUUM22TDZBQwAetQJjN7d0AXpqIra1Y8TNkwBMcnmWyA9qg4d1rPNQ42v5hsrMT1j
 SJ3QQm6XwvoZK9dW3vGHm8nN5g05aCV1SIvQ9z9jlmMHNYYVMWg7JBZqjdky3TLQEvET
 LZio7d2etyHMEEtqGqm2Ows2wMeKkhbrDUv1qzNXyhDIrZPsBdXqoKtTLMf2Yw79tsgZ
 CwWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721155365; x=1721760165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/mR/0QMhMqGZbfZ0QJaQ5Uy2ur+BzQmeQAtYeietrZc=;
 b=u6+2OvL9bVbI80pD9MUhbbHDYPIycKEW2/V7MtIT+VFkRScTWrokrlxTsxpL0AnO75
 nc5MTkuVdLjEdh3RjO/OhmzKGM0mr9tWZzt1wOghZKuW0l06gGn3DB2M62y/784x5PWT
 cumsj0ldfB0O4VYcc4VXRVs6DBhXnNzMOAWbtnFg7NOdEFsW/uhLAiGaRSKGr5oq9uXa
 Nud5khvK5tvhmAsEbVQsIxwhyCwBjfpGPj34yJ0IAC4AnVarpy8ufJpYkhYyIwsSvnDs
 gMJPtNouofFuZo/1XPAE9rB72xS82fMF3+Rz/J7azzsM5do+vlU4TnNYXGb9dsgmIFgN
 r+hw==
X-Gm-Message-State: AOJu0Yx8NWDJgvoTmx+fMiSRrbpfmAwbUbl7QrPDXVcJrUFywNEJegee
 LouDc3OmDIEGy0QlwUaqXWP5DCry85G0o6gfKffYwABmDngSlWOK5GY9uPVJ9a2nNk8Y5QHIVZz
 FRJVp9w==
X-Google-Smtp-Source: AGHT+IHQqTK24LvRN8P6pEQ+RXj96SblCeXP2Nr8EIRjMl0GHDFR20YMAqmyNLZxZwXT/YE/T0dq6w==
X-Received: by 2002:a05:600c:4f53:b0:426:6617:ae4a with SMTP id
 5b1f17b1804b1-427ba69a73emr20039755e9.22.1721155365258; 
 Tue, 16 Jul 2024 11:42:45 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f239883sm174550245e9.10.2024.07.16.11.42.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:42:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 09/11] hw/sd/sdcard: Add eMMC 'boot-partition-size' property
Date: Tue, 16 Jul 2024 20:41:42 +0200
Message-ID: <20240716184144.42463-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716184144.42463-1-philmd@linaro.org>
References: <20240716184144.42463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Avoid hardcoding 1MiB boot size in EXT_CSD_BOOT_MULT,
expose it as 'boot-partition-size' QOM property.

By default, do not use any size. The board is responsible
to set the boot partition size property.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240712162719.88165-10-philmd@linaro.org>
---
 hw/sd/sd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 2246213b31..d49b144214 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -135,6 +135,7 @@ struct SDState {
     /* Static properties */
 
     uint8_t spec_version;
+    uint64_t boot_part_size;
     BlockBackend *blk;
 
     const SDProto *proto;
@@ -492,7 +493,8 @@ static void emmc_set_ext_csd(SDState *sd, uint64_t size)
     /* Properties segment (RO) */
     sd->ext_csd[EXT_CSD_S_CMD_SET] = 0b1; /* supported command sets */
     sd->ext_csd[EXT_CSD_BOOT_INFO] = 0x0; /* Boot information */
-    sd->ext_csd[EXT_CSD_BOOT_MULT] = 0x8; /* Boot partition size. 128KB unit */
+                                     /* Boot partition size. 128KB unit */
+    sd->ext_csd[EXT_CSD_BOOT_MULT] = sd->boot_part_size / (128 * KiB);
     sd->ext_csd[EXT_CSD_ACC_SIZE] = 0x1; /* Access size */
     sd->ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE] = 0x01; /* HC Erase unit size */
     sd->ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT] = 0x01; /* HC erase timeout */
@@ -2704,6 +2706,7 @@ static Property sd_properties[] = {
 };
 
 static Property emmc_properties[] = {
+    DEFINE_PROP_UINT64("boot-partition-size", SDState, boot_part_size, 0),
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.41.0


