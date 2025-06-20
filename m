Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 590C5C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4c-00010N-Ri; Fri, 20 Jun 2025 18:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXr-00077v-G9
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:55 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfXp-0005vI-Nh
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:28:55 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so15172785e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440532; x=1751045332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhMH7I4EkPrP5/EW0FTSVB4vH3vmUoQNCpdq2eeMnPc=;
 b=D+6JN+Jn3pDTWGyJpBA6YZKUAVQWLZi5Q8MD/3HkfXtGxhpR8qDp9W04ONrFRkiEo1
 LOjdkLbBfqiTI+I2MRQ0PEelemwEl4nG6y24y6bpX/7qn84EN0I7kGyMVmoitqZULAAy
 Lk1HB7f/NnmY2DdfgQuhyqrVB+Jzhr8+DaS+/9d2DNF9nfYfQWct/QE/PUsEMmMgoz1d
 3Jkpl3Pmo4H+X6GcjMPQvP9EAZWk7inB45G0mAaRv7iV4WBY/2o0s3K8lGty4On+Zgl1
 KXsNRpEgUWU0vUVPi7qukCc29vxN5kuD6aUH+riimHJpnyKRTrDHcnv5SvzHs6WuUVy9
 W6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440532; x=1751045332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhMH7I4EkPrP5/EW0FTSVB4vH3vmUoQNCpdq2eeMnPc=;
 b=SbqRKmw5u+S0BRj7LzkWZtCm6hZRmY6l4049iP1wBj0FtU9TjXeEqjLHZ4GTzXoOaH
 A+J2rNnMRlJA4WcEvqwWeRmsA7oc0xEywhUDr0sKiabYTdM1nUZMm5u7Fg8zwl99hUe+
 3zJqKoMgHcBxiz/A9dcAVLH1JcsxR4K2Csjh96bUyjY65g1s9O5DdvXnrz/ElPT2TDOk
 7xcXxLIxWOwEMPEgiuU6BZ/DjRvQraqzwHGasOQMOKN1yTHe4dX7UNQrjJCcJ8FduCaD
 F63Tu0XKBxZt58F7jFkskaGJ18Kyq8/B6aQEDfCqh/2IRc11Iu9JZUm8Up5Cy7aW5yQ5
 Egxg==
X-Gm-Message-State: AOJu0YwNk5q2bUwBwBvC2HDSDVtALksbrZ7IG0DA3EjXv7L1wo0OCnG3
 RZKnSLmhXVQKxMHEx4fo6qwUjUnAgpZDTA1DHLmf08jNS3CYQBQJxzxaukHfo+2fP60TJINGiad
 xGO4lD/xMGA==
X-Gm-Gg: ASbGnctLgsVyn7A/XxojoezAxx0MK68w5J7f5iA/ikFzmVuulaqIs6eu3GtyCBHGxmI
 gMjOk+Yq3QB5pvl11GnBvoefrfvUGW1Bm24q68CUQgABmHPV8zsvkJjTGJ5OxMD8gK88I0mNcfO
 xQHBUfQua0pu417ew5HDgwyrNW+P5UfQq4YH71+cDGqcDqB3k6+XP36Ft8cU8NLr40Ljn+wwVAO
 Bn/OSNXWf+51wEfS3wvOz9Ma1TYnaWqh0ixx1hWVrT2wCkcPopNEA6/dmmoeIQBx8r3f4WvgrCy
 b69feIQ7iIf5J78K8O1NStssIBWWdzHXFbEY1JSPmC/UqpKD7VkwJ0ywpOIF+FI6bEUctB0xpms
 ychQbOaNVBCjtadDKr4eVx8tL0B7A6m/MvD+meP2xi50YCmvpfAcGRQNl
X-Google-Smtp-Source: AGHT+IEu0bG3HJkCHO6x1K+YcDPFCVrJXuZhu0GPbkUVJxaRAjeIn8chK/v6drtAFlf1pnPQMjiBpg==
X-Received: by 2002:a05:600c:1c8b:b0:442:f4a3:a2c0 with SMTP id
 5b1f17b1804b1-45367037b8cmr30972315e9.13.1750440531693; 
 Fri, 20 Jun 2025 10:28:51 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f18215sm2570775f8f.29.2025.06.20.10.28.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:28:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 07/42] accel/split: Implement supports_guest_debug()
Date: Fri, 20 Jun 2025 19:27:15 +0200
Message-ID: <20250620172751.94231-8-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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
---
 accel/split/split-all.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-all.c b/accel/split/split-all.c
index 8b9f8ff77a4..cb910300931 100644
--- a/accel/split/split-all.c
+++ b/accel/split/split-all.c
@@ -61,7 +61,18 @@ static bool split_cpus_are_resettable(AccelState *as)
 
 static bool split_supports_guest_debug(AccelState *as)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(as);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+    bool supported = false;
+
+    if (hwc->supports_guest_debug) {
+        supported |= hwc->supports_guest_debug(sas->hw);
+    }
+    if (swc->supports_guest_debug) {
+        supported |= swc->supports_guest_debug(sas->sw);
+    }
+    return supported;
 }
 
 static int split_gdbstub_supported_sstep_flags(AccelState *as)
-- 
2.49.0


