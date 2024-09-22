Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B264CF9C6E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 14:33:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssNdT-0005g7-4J; Sun, 22 Sep 2024 10:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1ssNdR-0005c9-Lk
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 10:32:25 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1ssNdQ-0008U4-6H
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 10:32:25 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6c34fb4f65eso33858566d6.0
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 07:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1727015543; x=1727620343; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZjTA1FcwiRqQ/YYlZO/lsysD2HXG7PCXuxP+u0+bvI=;
 b=NyFnQ+0+4IiL0lLG+IeelmXpgmXbHwlvr2XpytjkAB9RGvg0Qax0LrlhAulk8dIWQy
 DEUyr8fi0FNomZnlU3M3mw3ZdGXfQRja4luH01O8Z4BpibG5tZCSUGnFnvywrP3Q46SN
 UkqVmQJv8XRKgMA5pZgh/XHTK19p3Pih8nP6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727015543; x=1727620343;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZjTA1FcwiRqQ/YYlZO/lsysD2HXG7PCXuxP+u0+bvI=;
 b=ltIWhJD1IstzISMZb82VBmpPEzV9DPfyGf8Ncq72CdN3d5USSh1AJ8LrMuNG8Amvwd
 vNFA5pOeDklKNHJKLXIEdu0fLELMmqqFS1qw1lhJa6JglZJHqQ1t7MB8vJLmGYxuex3y
 MhqNI0tqL1Z2g8P1V0+ejXzijy1gRLN/HUpXba9klzKAIvdFFyd3nn4UIdndDCChrJwL
 uqE7p0O1vPYgT1EoQCXV2uhBiupOMGSA3ECbhUkswiCppf3/y8QNtBwtDWWAM75p8PD0
 /k7K1//lNDNCgRqYWecUaWCMctO/hleVTw+HhEN867XuXJFqRJmKLFOnZhjUFmxikdb8
 Phlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/Uv2ukfS7NzwhlVCue5F8H2XDSwnfyUT1TkDYK7ksh2LX7t5ERz4Y7wHtCuYI8J4OZlTmltjgE/Es@nongnu.org
X-Gm-Message-State: AOJu0YxWtPk0iZyeZihfZ2Ihln/jiMsm4rXW60MHVxzwygQ++q+t8Kkf
 sn5jt376ENyWIUKz4cUdIDv2TWAg6F6Zot0JQ5RCS+Rp5DRKPLmBbZYg7oih5w==
X-Google-Smtp-Source: AGHT+IGt4H5B4WtzsJPk87MCxfzPsBYBWk4GseS6CIunvXwQj4bO1MOGvVlOpsXnmw5A0MHxHYtTig==
X-Received: by 2002:a05:6214:3c87:b0:6c5:f93d:4b0a with SMTP id
 6a1803df08f44-6c7bc6ce52bmr143295176d6.5.1727015542900; 
 Sun, 22 Sep 2024 07:32:22 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (122.213.145.34.bc.googleusercontent.com. [34.145.213.122])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e557d6csm37956366d6.98.2024.09.22.07.32.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 07:32:21 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 1/3] tests/acpi: pc: allow DSDT acpi table changes
Date: Sun, 22 Sep 2024 14:31:09 +0000
Message-ID: <20240922143216.662873-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.792.g87dc391469-goog
In-Reply-To: <20240922143216.662873-1-ribalda@chromium.org>
References: <20240922143216.662873-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=ribalda@chromium.org; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.129,
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


