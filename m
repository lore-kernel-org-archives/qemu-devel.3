Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 318F3CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5X5-00050l-Fo; Tue, 24 Sep 2024 09:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1st5X2-0004rM-Um
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:24:45 -0400
Received: from mail-qt1-x831.google.com ([2607:f8b0:4864:20::831])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1st5X0-0002w9-NL
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:24:44 -0400
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4585721f6edso38451861cf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727184281; x=1727789081; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSNd0/JPPPjcXwpO5/NZPIXa9E9Bx1jw+bd12m/BgOI=;
 b=R61YH3j0oYlmEdaZ6o4BgnqvTrw3EXkDn67+OJtd9a7vbXNtpJNP4PHTNqrYCF50za
 +LK2MnpwGEyWiNpTmlcRdAXMgJxcvKFz1QP7UUW/LrwmV6J2GKz1ZD9ksKUWe08jV7Gi
 oecX/IqPT0Qny17MMXdPAgGZXMAS+ezUR3OF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727184281; x=1727789081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSNd0/JPPPjcXwpO5/NZPIXa9E9Bx1jw+bd12m/BgOI=;
 b=qqXmJbP+1YDfcdsW+kEL9L25RWG7NFqBYZR1LvCM0mB3TriQj6uYK+kp/mhHTOP7ho
 4kUsdSxrTDHAACDn/V5FJzRKTUkhIo/GImwB40gBcIOcQJqUuuYZCz92ex3fAPEZ8yCD
 ffBJsv/ZEEiGWpkLHnNbN25y03M8zxcTmXLgcy+uOACnQz5gkaLzOoXlvom3d/9W+wWi
 BzxnHaa7E6nbb0TlbrGEY/vbHJ+c4NYGXalEeuG8kdL/898fdLxSWbeyx6/wT3YZx4GV
 TU7a6vr+SR30ogbzQDtyvVaj15Wz8K1eL7j+sMjq8ihygbP07fui58aLjs3TV9MJyDf6
 W7cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXABEgL0s1TVns0N0/OANvd/MECt3czYLnQgoZzj0E8Xyrk+m3BiHVOvaEbi28ElgRbB8GDzScYdSAa@nongnu.org
X-Gm-Message-State: AOJu0Ywz4/VL81DFNP+YcYJQsmKsAc8PFdWZJ9Sa+1gPuTGpIePP8sBQ
 SHifgXGhlWBa90BdTpg8NruusVwaoIbKPCbRoiKAhMy5oIxriKG5W6GLX4MKog==
X-Google-Smtp-Source: AGHT+IE2UkMb0rlEBqcydXSIPvWWJsw577t6jP1F4FykqNq7WXomogo8qqP63Jz/o8RtajMZO37jWQ==
X-Received: by 2002:a05:622a:4d1:b0:458:1957:b925 with SMTP id
 d75a77b69052e-45b204e0743mr303848071cf.8.1727184281348; 
 Tue, 24 Sep 2024 06:24:41 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b52579daesm6248411cf.25.2024.09.24.06.24.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 06:24:40 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 2/3] hw/i386/acpi-build: return a non-var package from
 _PRT()
Date: Tue, 24 Sep 2024 13:24:11 +0000
Message-ID: <20240924132417.739809-3-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240924132417.739809-1-ribalda@chromium.org>
References: <20240924132417.739809-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::831;
 envelope-from=ribalda@chromium.org; helo=mail-qt1-x831.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Windows XP seems to have issues when _PRT() returns a variable package.
We know in advance the size, so we can return a fixed package instead.
https://lore.kernel.org/qemu-devel/c82d9331-a8ce-4bb0-b51f-2ee789e27c86@ilande.co.uk/T/#m541190c942676bccf7a7f7fbcb450d94a4e2da53

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Fixes: 99cb2c6c7b ("hw/i386/acpi-build: Return a pre-computed _PRT table")
Closes: https://lore.kernel.org/all/eb11c984-ebe4-4a09-9d71-1e9db7fe7e6f@ilande.co.uk/
Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 hw/i386/acpi-build.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4967aa7459..d2be77199b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -741,7 +741,8 @@ static Aml *build_prt(bool is_pci0_prt)
     int pin;
 
     method = aml_method("_PRT", 0, AML_NOTSERIALIZED);
-    rt_pkg = aml_varpackage(nroutes);
+    assert(nroutes < 256);
+    rt_pkg = aml_package(nroutes);
 
     for (pin = 0; pin < nroutes; pin++) {
         Aml *pkg = aml_package(4);
-- 
2.46.0.792.g87dc391469-goog


