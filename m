Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB44C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 13:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdrkl-0003Co-Mz; Tue, 13 Aug 2024 09:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sdrkj-0003Bp-9e
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:39:57 -0400
Received: from mail-qt1-x832.google.com ([2607:f8b0:4864:20::832])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ribalda@chromium.org>)
 id 1sdrkh-0005IL-NQ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 09:39:57 -0400
Received: by mail-qt1-x832.google.com with SMTP id
 d75a77b69052e-44ff7bdb5a6so29289421cf.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1723556393; x=1724161193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XS/4eu0i7qnpPSrFXWbFUJUfVGkHkmY+q/9pM4o5Aow=;
 b=DscEG02CT8C7EdOVPUKLnxJUpLr4erSduWapWXDu41Dkak6FnESTFSEM5rwNGrNnCT
 T4ADT1TU8y6WJDrsM9eAGHRpEVh/njLRWe71Y/MnlBHoohaVi+mVJ+5/gucCCU50K7io
 BGVpFr/ptGJQmzc38g4KVp4L/2pWnaYUOkyLE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723556393; x=1724161193;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XS/4eu0i7qnpPSrFXWbFUJUfVGkHkmY+q/9pM4o5Aow=;
 b=IUmNbx7kUKd7wwRoCTiJyej1hjstBj1M5V2DXPmL+wznovrzYwhBeOHpPEBXSBQRbV
 lxc/YQyKRFdReJ6tg+NI976lbX85mkNrIy/GlmfwuAEHGYWhhO7F6HxoxHFRrCb5+lJU
 1h3DcDIGzOGRFg2qatftaI3bIl0z3+VieyEQs/F06EGgaxb/u8ClC0Tw5WBBs6P+tjlB
 ikxei7SIt5KQM85WmXW1SrO6bvCaxKYlxfeANGO0zlN3YGPr2/OCwZTdmLv7CgoScBSN
 rIxnVLUhrvScnel0nLM0LYrMHJ94FjJsyxN4tSJXDnX76DKhBLyHWW+3zYW0BXvLIn6V
 0XsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlaQwhXYuKg/n13iFeI7q+gs9xzfhvVCYiPgsvqJfCUY/WnJ64z//frDRrMtWbicpdbPCLA1QTPzoxZOg8DHNgadTqdbQ=
X-Gm-Message-State: AOJu0YxbYMGPJwg8MTy/7MbM2mN64ljHKe24FrWkRvsh6An6a9gd7nYD
 93Euc6yXRSiOXFnAli7dzywynDwJGA60gFPcoxLvDfHNYFlyl0ZEKXZ0nREIrQ==
X-Google-Smtp-Source: AGHT+IFUW3UAmPoG960SZ5N7VJNAUHo+tLL1rC1lovhhg3esGnMq2tjCYJKIq3pQqg1dlwUZSzxiHg==
X-Received: by 2002:a05:622a:1f07:b0:447:e3a5:27a7 with SMTP id
 d75a77b69052e-45349b17a9dmr45800341cf.49.1723556392819; 
 Tue, 13 Aug 2024 06:39:52 -0700 (PDT)
Received: from denia.c.googlers.com.com
 (123.178.145.34.bc.googleusercontent.com. [34.145.178.123])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4531c28fdcfsm32182061cf.90.2024.08.13.06.39.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 06:39:52 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 Andrea Righi <andrea.righi@canonical.com>
Cc: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH v4 1/3] tests/acpi: pc: allow DSDT acpi table changes
Date: Tue, 13 Aug 2024 13:39:12 +0000
Message-ID: <20240813133936.1175467-2-ribalda@chromium.org>
X-Mailer: git-send-email 2.46.0.76.ge559c4bf1a-goog
In-Reply-To: <20240813133936.1175467-1-ribalda@chromium.org>
References: <20240813133936.1175467-1-ribalda@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::832;
 envelope-from=ribalda@chromium.org; helo=mail-qt1-x832.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
2.46.0.76.ge559c4bf1a-goog


