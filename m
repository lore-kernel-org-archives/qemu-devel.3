Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6860C8303C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 18:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2ap-000142-RI; Wed, 02 Jul 2025 14:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2an-00013a-4L
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:01 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2al-0001Wm-Gz
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 14:54:00 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3a4f72cba73so138701f8f.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 11:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482437; x=1752087237; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eMVCQTvVGe/Hz2DEmM07zNOYeNDGY8/7Dwwnom0rM8Q=;
 b=rbgta40o5f61tDDcoChDBJv4NYnd7u+mL8m0OLwSLOnm/PlFTIWM6autUD/TM+kTMU
 TgahXqL6wlxbhzY6n1KcYa99sC05VYhJDLAAyoH6Oxy804OqiQ4jZRh1DB2M3fa2WA04
 cAylDF8xu9YCkdG+k6fWkEK1TLm9n1v68AQCa8lOKuvvbo26Mjn8DIE14kVB4ql7tKWI
 NsmpyGJ7A6MiQTnDR4kBJMKa0kEerQ2zUGEg5oyA1Omhmy7PikmDn/pAQuE86gnQBZIj
 jun9gTqDv+B0q8pg+0uqTJc/ZQm0eBIe2/+DekjyUspDp9doO0iwiQNOSLUI+Uistzes
 vVkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482437; x=1752087237;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eMVCQTvVGe/Hz2DEmM07zNOYeNDGY8/7Dwwnom0rM8Q=;
 b=wNkyd0Rf1+8EgCEslU0R0pg0+wQE5oFZfQuFi6VZg7mC8ne+DMhSJSdaE5+Y4lsTEc
 oDNl485f6am0qoG/LQwGi9DacAuEjsiGrF6Y7WPiiAr+9nvPbpXhRQLUvTAvxnCeWRd5
 iv2tHM94l7ZWvJ6urCmdPA97m7QcvfBAdcdJLnx2QMD3SRxAFTQHCN4MMGGJ+yULCzoQ
 V/Udr0vfHKsWbveGREpLPITYHILXEH99p/nbuDl2wGSvBCDl7bc5zzCTyq6bDppuAml5
 bRagMnlQN9eFFmuOTKKh30nC0qnCJ4KMvFrhZb5unY3hDd9Yd2DxZFG3NOmTe0IZ22Xw
 aW5A==
X-Gm-Message-State: AOJu0YxPLrJu8327pMX+7+XgysbCpPN+xFdUSQ+FTIOFpvPMVsde3C28
 /0cKAq5rALjIlkQdDqG4YpSwbAbQ+sxcfHwbEjeZrwEAVBvIRdaxpX3MNqiyUckg1Qs3lv4ckre
 qPjZE
X-Gm-Gg: ASbGncshQQ5yvv6jJXszxhaZry9xn5i4FWg8YUYWyvH58DFZVWjqaKIOgnBRxzyfpyC
 wC3MJbqKi8QS+G/QHM0/KkPJy0B23FwEGcB+17GPnEYaFihsW31V158rm93iaTsHNA1JrG+SWub
 +wu3CeRso3OeFsYL+AKRr5Y2G+482dP3lfvac2oJdOhhvV07GjXpbfsDmDhkcHfE/gYGRrLRbBB
 vPR/rLwOyCQ8MursJEdf25kADbFrEHEiFtQeYOp/AOVtn64WxJXQpVMTonDN9AFSHaxMiwfn252
 kttZhXoDphxu3Ono5nHhy+h+KB2fXkQZo6ptHRVVrDlz4Tbv0tUzqp4bCEUcfwcJXtZE524boak
 LvJxCojubx9ejtdJqEKIfZXI1bn5O5uRrqTaE
X-Google-Smtp-Source: AGHT+IGFkRYuVazGmtog98UdI2jtI/8GllToY3yZ++32QEyddoGIzSeazbRQ6LhP4vW0Xnt4TE60jw==
X-Received: by 2002:a05:6000:988:b0:3a6:d95e:f37c with SMTP id
 ffacd0b85a97d-3b34281bd45mr26127f8f.2.1751482437342; 
 Wed, 02 Jul 2025 11:53:57 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7ec6aesm16677975f8f.5.2025.07.02.11.53.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 11:53:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 03/65] system/cpus: Assert interrupt handling is done with
 BQL locked
Date: Wed,  2 Jul 2025 20:52:25 +0200
Message-ID: <20250702185332.43650-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops.c | 2 --
 system/cpus.c             | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops.c b/accel/tcg/tcg-accel-ops.c
index b24d6a75625..6116644d1c0 100644
--- a/accel/tcg/tcg-accel-ops.c
+++ b/accel/tcg/tcg-accel-ops.c
@@ -93,8 +93,6 @@ static void tcg_cpu_reset_hold(CPUState *cpu)
 /* mask must never be zero, except for A20 change call */
 void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
-    g_assert(bql_locked());
-
     cpu->interrupt_request |= mask;
 
     /*
diff --git a/system/cpus.c b/system/cpus.c
index d16b0dff989..a43e0e4e796 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -265,6 +265,8 @@ static void generic_handle_interrupt(CPUState *cpu, int mask)
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
+    g_assert(bql_locked());
+
     if (cpus_accel->handle_interrupt) {
         cpus_accel->handle_interrupt(cpu, mask);
     } else {
-- 
2.49.0


