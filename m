Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE9BFCA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:12:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXeh-0004Td-Ju; Thu, 14 Aug 2025 09:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdk-0003DF-ET
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:09 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXdd-0005MT-J5
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:05:08 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76e2ea6ccb7so688793b3a.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176696; x=1755781496; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XPFrNGF25aedFkFai4tvzmqvnXD7XuO5UqpCg3WnHEs=;
 b=TfULhRTxuvo6icmsc/AVGew7D5BIbEaNyg7xLApfu97A4fxfDdsDqto42kaivmq3Fo
 sFGiJZTt5mPtyWpNj0ftpCJj39l5tHktvIN+p0N5N3wejjAEysE+geAQAcRjRRLYw0HI
 iXOZqr72VClHeGcaEi6NBGvGGOhzHYCM2WI3qIEp7zhA9TGt4q+GsRfTyDC+1kVkVc0K
 mreTlCTsZr4ZMtJlge4ld/SkHBIUTaCUdPwq1+SatmJCMU/4uNy+U2g5MWBUY5UYD55s
 VIO1l6bqWtaRE5qLQRr8SYDj7jkJqoG/g/GHSguw2k/ZYbstaQpp0uw/7MzcHF1u06D3
 FZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176696; x=1755781496;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XPFrNGF25aedFkFai4tvzmqvnXD7XuO5UqpCg3WnHEs=;
 b=STiWQuMlu4E5TvzCufP992dFzRRNqIjqWLubIGv77j5gHqeefP1W3DQEH2WWz5zdLC
 UbB7kNA+bpQYrSShkzvswq/rjWQKiWHAXC13JfKrbefSt6sUd3jr+ZKHHjhuatz9MXzH
 WkhuiulbWp3vCCUDSAa8Wgi4fdbl4UPmwS3g255AhvMi0Uoindih7ZBXjnAVXtAfjjDM
 0kVCM+VwAA4wKp1kKaV+Ra8WzG8PtemtAxNt8JAuScqHmXOh17D3QU6Ozj4ozrGeFuU5
 nTDa7SfevhsQcbZEmN2x4UJLMMYd2GRZJpz1ytgalnty0/7Hoo2ifEKHFONr/3JXWq+X
 wO1g==
X-Gm-Message-State: AOJu0Yy1+QsoEIkK7/D+WMaRz39Hii6TahtzbQwTL6cOrlLn0J6UC2P4
 gXWs6UXQKwtwBHnkgqV1RgEZ9PjzViBRbxs17s2GTDEocqIEWqM9Cgpokwlp4VExE3xgy+bFm8E
 QqC0vuWE=
X-Gm-Gg: ASbGncv+prstJqrxv/Rx/WDgKQzeZK5nCRxgEj9UNiMuvWYR7W5DBBp0lpfHYIRqAZZ
 CcjKwNHdRMkFcKk+ClQkukMuYzAYMPpaoUuYySzGnA6m6MqmPJTPhOmagm5uw0xDB4ST7TSzTIe
 zRNr3vpqSdQN7+sKixlNvuXP72WmKuvPXzb/JrRCK6cphUyxXocoqDOZvKGS5Xmlq0NcOtRFYZ0
 rHzihh2DKozaDIVRtIgY8s0tj2+rCekh37qHCk48H5ALb6VgB7r04ibJBJ3jqvU131fj8cjS0bc
 DPSohl84sZ11VKm1s0A19YHws5mgcaKqy0hvjZwzYfm/Asc26rUDFUHaPJJXs6eOHmEl33iL1jd
 Gq3Ls6Qu05xEHTfXyRRAcPQTLwwXYQYw5ufVqlCuAKIosl7M=
X-Google-Smtp-Source: AGHT+IHXu7kVwvsiHCESWKp89UykVuKTFb0m49VMRflGl73F2VVq7uyMikzGvuzQi85isQ13z/hovA==
X-Received: by 2002:a05:6a00:398b:b0:76b:e805:30e4 with SMTP id
 d2e1a72fcca58-76e3200f33dmr4540446b3a.24.1755176695933; 
 Thu, 14 Aug 2025 06:04:55 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce6f6fesm34480631b3a.26.2025.08.14.06.04.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 06:04:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 71/85] target/arm: Copy EXLOCKEn to EXLOCK on exception to
 the same EL
Date: Thu, 14 Aug 2025 22:57:38 +1000
Message-ID: <20250814125752.164107-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

Per R_WTXBY, PSTATE.EXLOCK is 0 on an exception to a higher EL,
and copied from EXLOCKEn otherwise.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 4495433ce4..b2754b1678 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9300,8 +9300,13 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *cs)
         } else {
             addr += 0x600;
         }
-    } else if (pstate_read(env) & PSTATE_SP) {
-        addr += 0x200;
+    } else {
+        if (pstate_read(env) & PSTATE_SP) {
+            addr += 0x200;
+        }
+        if (is_a64(env) && (env->cp15.gcscr_el[new_el] & GCSCR_EXLOCKEN)) {
+            new_mode |= PSTATE_EXLOCK;
+        }
     }
 
     switch (cs->exception_index) {
-- 
2.43.0


