Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AE8CF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5X5-0004yf-1h; Tue, 24 Sep 2024 09:24:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1st5X1-0004nI-PI
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:24:44 -0400
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1st5Wz-0002w0-6o
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:24:43 -0400
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-45aeef3ce92so36543811cf.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2024 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727184280; x=1727789080; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZjTA1FcwiRqQ/YYlZO/lsysD2HXG7PCXuxP+u0+bvI=;
 b=XDyFQ7ZJ5gJ8ml1aH8QACWXv0VXijMPGobfD9aVWRO/73JzRDoaWPDfmngCPYLfuzD
 hFmsmMBZgitH6BQNs8k9as08HYg/T/JnkdRVT31G8bsnVgVBlOlVijYHuobxl3SRJiMU
 sAO4Ad8gfb2lqdAKYiNHw9Ge5LUZiubbo9JOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727184280; x=1727789080;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZjTA1FcwiRqQ/YYlZO/lsysD2HXG7PCXuxP+u0+bvI=;
 b=DiurNN5Tr0756euPTPY5FTHNNQcbzm/Xszrxoqt7qMD9tN7WQln0Mcd9wKh2U1DfUd
 eMxIUtr4+xKmCp0EuO4DNttkRNVoAOP1p5zt/pj9ZVJyYn1AMKY6MExJX83DPYkOzbLu
 9DyXgeh9S60jRZw1qWdxuVxtgRiLr7fJBaV1KD+zqP4S/qFHXGoaSKeGPxtRj/rmZUhz
 TovSf+GWg9Z/O1j1vBYPCwOJSwy7cyQxJnhVso+0nMdOqlbJPceBDbSoTfoj/D1V++Q+
 7vuaO3Ty0torxm6oTWfmnJYCAoZ0iHqvvv3GtqnIWD9ABJTSAKKaiFYJAXsRSLuSi6Bs
 +T4A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWspD2c1KOrCsMUfv5D4BatybQNf/1hCjRdkxI0SSOAMqKlAT9rwwoiDGvxC0D0CnF+YnUbd+WkUfXS@nongnu.org
X-Gm-Message-State: AOJu0Ywjuy1vYVaEwB7Ucw4UvxHPEwVpdKfpOO4Zv716CwdXqgZVnQY3
 w+wWPPlkC+IY+ZLLc6rNoEsqwUb/K/Urh7foqPwlOD+4UDDFJO2A50kpXtcwaw==
X-Google-Smtp-Source: AGHT+IEPQsn14Z6FB2dUvoGkmKcNUlyro2uhShWzAzoe3Ax77S40wQPN6V+Ot+lQeEdqIm2a7AHs4w==
X-Received: by 2002:a05:622a:14ce:b0:453:7533:a64f with SMTP id
 d75a77b69052e-45b204f37f0mr216684791cf.21.1727184279946; 
 Tue, 24 Sep 2024 06:24:39 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (76.224.245.35.bc.googleusercontent.com. [35.245.224.76])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45b52579daesm6248411cf.25.2024.09.24.06.24.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2024 06:24:39 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v2 1/3] tests/acpi: pc: allow DSDT acpi table changes
Date: Tue, 24 Sep 2024 13:24:10 +0000
Message-ID: <20240924132417.739809-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240924132417.739809-1-ribalda@chromium.org>
References: <20240924132417.739809-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::835;
 envelope-from=ribalda@chromium.org; helo=mail-qt1-x835.google.com
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

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8b..f81f4e2469 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,16 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/x86/pc/DSDT",
+"tests/data/acpi/x86/pc/DSDT.acpierst",
+"tests/data/acpi/x86/pc/DSDT.acpihmat",
+"tests/data/acpi/x86/pc/DSDT.bridge",
+"tests/data/acpi/x86/pc/DSDT.cphp",
+"tests/data/acpi/x86/pc/DSDT.dimmpxm",
+"tests/data/acpi/x86/pc/DSDT.hpbridge",
+"tests/data/acpi/x86/pc/DSDT.hpbrroot",
+"tests/data/acpi/x86/pc/DSDT.ipmikcs",
+"tests/data/acpi/x86/pc/DSDT.memhp",
+"tests/data/acpi/x86/pc/DSDT.nohpet",
+"tests/data/acpi/x86/pc/DSDT.numamem",
+"tests/data/acpi/x86/pc/DSDT.roothp",
+"tests/data/acpi/x86/q35/DSDT.cxl",
+"tests/data/acpi/x86/q35/DSDT.viot",
-- 
2.46.0.792.g87dc391469-goog


