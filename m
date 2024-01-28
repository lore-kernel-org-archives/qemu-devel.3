Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0768C47258
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Jan 2024 07:16:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTzOM-00039G-Bz; Sun, 28 Jan 2024 02:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rTzOJ-00037b-Kz
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 02:15:43 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rTzOG-0004BN-OO
 for qemu-devel@nongnu.org; Sun, 28 Jan 2024 02:15:41 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5d81b08d6f2so1680918a12.0
 for <qemu-devel@nongnu.org>; Sat, 27 Jan 2024 23:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706426139; x=1707030939;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aLm9YsebySTPKhyLwpQObdZvcROKL7J1ig92T/Jq260=;
 b=FQ0J096ho7hu3k4flT1E5jzaBkfR2BJam02B+SSkFfV586bFe4tPVP+v/hEDil5WSe
 gtGmrM3cj8FpGUCtpRFi1Gmvph1M8osrFWAFrgr1x9L5kSs98nW+XXptYz8eCrQugFIY
 WI0RPGQr5rwOA2ZZ1FxihDWf3w4jTKaLIJV26iO78MbAZs1/KLlZvBsbq3aZjdMl8Jje
 Akn9Tw0+qwrOcPQblO89Dn1kDjkmALQyjFD+IfRWp54JhOZfo1gd/wIBEewsVfqnXVju
 1eI1nxjoYICmC2RsEAMM6Q90mD5vk209hnnTySutdkJ4IxH2fW+7Ud5kdHbgooJ8p0Ju
 8wfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706426139; x=1707030939;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aLm9YsebySTPKhyLwpQObdZvcROKL7J1ig92T/Jq260=;
 b=eDh1+Xhsg/fVcbAfdAu9RRuti3EZ+beqEGbxnsjw3Ba6RJN3XPoUljKN3IrNVdVGqu
 Na43XG4lX1JDK5c2S8ivH4MVjzwTqH0Ginmwt6VydaGZa2GlXN9gM49+fCWC0mXLcPNC
 cAYnruNr63yxaygLXBKnFHW0w9Z+BIl4xUaimUhzqzIM89+HCjxH+qE9rssCa5zw7Khy
 bVnKMZz6edODr6ZhLT6RC79uM3yR9IDjZc7xVvJGFie/AQQWD7jDQhaoRxUf3yQ3XNo1
 lU8TAWwt32aP+/AgrGzV8R6dE+TVpFCffR4xX5KJ0Jis9EkHIeyU13dtI4skryGb3fT6
 PJqA==
X-Gm-Message-State: AOJu0YxKP8m73z8Kr+cbNrUn+BD7UBTg8Z/6LzyDo3jI0ooAayYEcKOs
 ubOmIxR08OmnxdmhNcqb5867CLdya6tro+Mb80RDT8EaxIoPvE6oiQx4b0DerZY=
X-Google-Smtp-Source: AGHT+IGe56P6vnPEph9BavikVLhnaZvkmHWEHJD1iYt0IGE9c8TFmcu3lLPppBV4pLjawQK78SbdBA==
X-Received: by 2002:a05:6a20:9f8c:b0:19c:5734:b725 with SMTP id
 mm12-20020a056a209f8c00b0019c5734b725mr2819858pzb.35.1706426139309; 
 Sat, 27 Jan 2024 23:15:39 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 v189-20020a6261c6000000b006ddc77dc4fasm3997916pfb.11.2024.01.27.23.15.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jan 2024 23:15:39 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 28 Jan 2024 16:15:29 +0900
Subject: [PATCH 2/2] hw/smbios: Fix port connector option validation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240128-smbios-v1-2-c3a50499baea@daynix.com>
References: <20240128-smbios-v1-0-c3a50499baea@daynix.com>
In-Reply-To: <20240128-smbios-v1-0-c3a50499baea@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

qemu_smbios_type8_opts did not the list terminator and that resulted in
out-of-bound memory access. qemu_smbios_type8_opts also needs to have
an element for the type option.

Fixes: fd8caa253c56 ("hw/smbios: support for type 8 (port connector)")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/smbios/smbios.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
index 522ed1ed9fe3..8a44d3f271de 100644
--- a/hw/smbios/smbios.c
+++ b/hw/smbios/smbios.c
@@ -346,6 +346,11 @@ static const QemuOptDesc qemu_smbios_type4_opts[] = {
 };
 
 static const QemuOptDesc qemu_smbios_type8_opts[] = {
+    {
+        .name = "type",
+        .type = QEMU_OPT_NUMBER,
+        .help = "SMBIOS element type",
+    },
     {
         .name = "internal_reference",
         .type = QEMU_OPT_STRING,
@@ -366,6 +371,7 @@ static const QemuOptDesc qemu_smbios_type8_opts[] = {
         .type = QEMU_OPT_NUMBER,
         .help = "port type",
     },
+    { /* end of list */ }
 };
 
 static const QemuOptDesc qemu_smbios_type11_opts[] = {

-- 
2.43.0


