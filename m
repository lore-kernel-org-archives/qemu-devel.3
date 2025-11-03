Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23825CCFA04
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFrZT-0005eE-U3; Mon, 03 Nov 2025 05:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrZR-0005dX-UX
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:13:53 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFrZM-0002zQ-Re
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:13:53 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-471b80b994bso54840955e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:13:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762164824; x=1762769624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZhaKZtIHcKQyEzCs44RThvX4QVJ1Sgd9Tp4DxoQS0nM=;
 b=elQ3XncFJ1cC0c7CLhV+9zkS56AkVxbfDtfvlc1Fd8fvMFfYnPav+8wxvYDCTWfl59
 86RNoRzEPypDZFeVv8PmSdTRV6NTblAO/0A9dSOKLvA3agM2ppuEQOoO1UxwOdtjbtPJ
 s41VZbG4NuAT0kzW4WMQOgkyGPmdNvu+Ml7ImgOHH13/U4g2dwgyvADxUtxEb9XITJmo
 5EMi2JiFnY0J4HAgDTPgRhUasp0hXcLT2+Tu5CU/wyO+PLpoLHH2cl7zXo8fHvzAIDa5
 +NhXcJ4VYhl4Njh3NdSFFhxHygQKFXEdmfBAdcUa+n2Rp7ytDfQ6fsCDAxg2rzWjkExW
 GjhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762164824; x=1762769624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZhaKZtIHcKQyEzCs44RThvX4QVJ1Sgd9Tp4DxoQS0nM=;
 b=p+nIjlSkAqH0/DL2j8zVGCTg9GLtT0dozNugpMvmO0dDZ6XB13nwRaHk/QtmL0wH1k
 h/EKT+4ycUMVwfg7mgNJFWnCQ9rp/IRoCBqQGw7H0KyE6+dX/88v3a0OQvXr0qLZON3p
 gKMQWBfU73xziA+C7Q16pM02u3th1YXcBfUma8JzwcodElWXLGcbKnYNXmPKBZGnF1iw
 x8SPMfvD6lwwRVXMuYwdCnIjHNbXkmVaEeQtcshhwmkbn0hBh9l0wLRJjkTo5m9fyZr7
 vtcbARy03/2YG5bVwWjsFieQHyc5X0v5u9y4VmxNR1askE5mViv/YG/G9EUnpyUCXR06
 FkPw==
X-Gm-Message-State: AOJu0Yz4x54Ai3KliA17/PYz7xhoQcKrDiXmYqjP+wtbcuy6eNs9qcpt
 mhEtIqzZSlJbiyhbkh2yWRQcL3tqDGPFyDq3gV4O3FQGHo4aFDu75TYLF4d6LcBimDVfH07vzSK
 6HlqYhQ0=
X-Gm-Gg: ASbGnctw4Od3zgDGlBiTCRXbVg6JOt7r8/pwbrIgEcFn70+SlF5VSm86thYyFgkaZPS
 G+Pe6sMIO/aAZhOVeZMsmQauKlZgemcmx4ZH6WHxSOfJKeFYr1DcjGiVpqkug76X+dRxj5f81er
 F4rLmG/KaT3lfcYSzwoReiVmVXFA1SYCQ6Gxsr6+OK260hVGA3RM3cnrx4kOYEBvyoegXRo4LYc
 yjUzwRwZEBg1k9QEWowGpIB5CvoNXd/0ukHuWxWFDTuo2pzNJWMd3o8tLC3aCYvyQjrqiY9lcoj
 IbXesa3g4MdiLIO0dggRIoLl/bj9+kRVqO08LNMU+qN9PlUBnsOB3T8/SP6kd9HhrVac+dEfdnv
 zCFyP3Hlj55o+drzmbkRy1D8FUUfJ2nAjZTWJC4riU15c+siav/mfaszpj9zDLPgUfsHbQNRaEE
 jSR8RLmPZzpO7aCLwdAsEbhZYXr1foWKzjY56AX905XNx053JtAYoBiGnUuPg=
X-Google-Smtp-Source: AGHT+IEOGKIgKnlbDQiyqHsOaaJCd31NLapA+qxZRnHzn1WG4l/u8lZPmyrB01DywGkze+48j6mTTQ==
X-Received: by 2002:a05:600c:3e8f:b0:475:dac3:699f with SMTP id
 5b1f17b1804b1-477307c1470mr105999275e9.9.1762164824081; 
 Mon, 03 Nov 2025 02:13:44 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c3a77b1sm148140115e9.17.2025.11.03.02.13.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:13:43 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 Mads Ynddal <mads@ynddal.dk>, Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v4 07/23] accel/hvf: Move hvf_log_sync to hvf_log_clear
Date: Mon,  3 Nov 2025 11:10:16 +0100
Message-ID: <20251103101034.59039-8-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103101034.59039-1-philmd@linaro.org>
References: <20251103101034.59039-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Richard Henderson <richard.henderson@linaro.org>

Right idea, wrong hook.  log_sync is called before using
dirty bit data (which for hvf is already up-to-date),
whereas log_clear is called before cleaning the range.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/hvf/hvf-all.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
index 601e63c7f9a..f203a6251f0 100644
--- a/accel/hvf/hvf-all.c
+++ b/accel/hvf/hvf-all.c
@@ -224,12 +224,13 @@ static void hvf_log_stop(MemoryListener *listener,
     }
 }
 
-static void hvf_log_sync(MemoryListener *listener,
-                         MemoryRegionSection *section)
+static void hvf_log_clear(MemoryListener *listener,
+                          MemoryRegionSection *section)
 {
     /*
-     * sync of dirty pages is handled elsewhere; just make sure we keep
-     * tracking the region.
+     * The dirty page bits within section are being cleared.
+     * Some number of those pages may have been dirtied and
+     * the write permission enabled.  Reset the range read-only.
      */
     hvf_protect_clean_range(section->offset_within_address_space,
                             int128_get64(section->size));
@@ -254,7 +255,7 @@ static MemoryListener hvf_memory_listener = {
     .region_del = hvf_region_del,
     .log_start = hvf_log_start,
     .log_stop = hvf_log_stop,
-    .log_sync = hvf_log_sync,
+    .log_clear = hvf_log_clear,
 };
 
 static int hvf_accel_init(AccelState *as, MachineState *ms)
-- 
2.51.0


