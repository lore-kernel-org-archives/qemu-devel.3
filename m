Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5C8C83030
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 13:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWEGv-00061F-LZ; Mon, 30 Jun 2025 09:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGt-00060Y-EQ
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:10:07 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWEGq-00043Z-9k
 for qemu-devel@nongnu.org; Mon, 30 Jun 2025 09:10:05 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so3245519f8f.2
 for <qemu-devel@nongnu.org>; Mon, 30 Jun 2025 06:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751289002; x=1751893802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSFZQl2Y1B+z5K8w8pr70pd1f08StcXXxObqPQRr5Ms=;
 b=SfrclrN0pVo2Md7mHNxcid3JjDgNz8Lq+6DU3vyfkMf05siHwQUCXtgmyUE/ruGam+
 SAQaBE1HFfEJw+9EBzW9YxskE+hf6up6nNqoTEZijv5dMTIiYDRMnNHzbJe/kUWilpAV
 S3y/QH6m6WsSwnjH50pHGfrdOZtfm4QyNu2ss30RMB593IoQujDxnFRRnmYOMnfa/9k6
 tqGqNss/VwTAR9jJFRMQzwrGxQOIBGv+Ih94u1B1yOwELRTIxGLhi5FPD6jZEUy2mSwf
 DGYnH9PAUdqi8Y6phiUZqQdy4Ph0W2t5ujcRxpziUPM163sQQjrCfRBFoOjj1D8tpVnZ
 rqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751289002; x=1751893802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xSFZQl2Y1B+z5K8w8pr70pd1f08StcXXxObqPQRr5Ms=;
 b=F39Z95KGz27LF345bdN3hq7+vd3M6ms3unHz0ghVlB9L1bcG8jt1mVPLnq4o6kZiL2
 mdP/52OeV2eBtQINk+MVjyACEij4udVWibYoSpzMxTZM/bFzEDjx8g5jJWKD7UVct3TY
 mIJMzsI6IcKt0Q3b3fBt60wz2Ihpm07qHQHmFhm5es5sdBtn6Zuc2Mit/uM0i85uOnol
 IYtNEiTTttEofu40NJ06UE/kCQF3a/XLnirLzpB2rQTCoEaqzwK3lFm5YXzO+CmTByls
 7wLB57llpDOcsTGJhSEijg7PFMesuRYjTiwBp6RL/uHn4n8dDaCkBiRkQLpXCvyyI5Nw
 gBZA==
X-Gm-Message-State: AOJu0YwqZqlBdwQAwroAIgmwyFyNMCnIAyI+5Pc8JmLohg+Z56CVq5NX
 Kln6WPHCv/b5xpdVMjti2vRdaFzCRWoQhpEsGSXtTGbOkgXz+xizYsg0X81BXk//DRmwKBl9sJc
 ogtIU
X-Gm-Gg: ASbGncuvEEOGyyYHlkFRSmKsTb1W2pftKTEtxg4ms1ADTTPYk+0u+rvy/9sjbesydjK
 B47sUnqSAWxhKsekwjcnFJ/E1nma+6H/9O53ll+qvYHuaj7Iwn0SX5+MxdAJhReqk9mVXBHgFGp
 6vWIVzTPr75r9g4mWFxe/s4G+PbYSpO1fudAx+yFRhMdSHj9VuFRsnZDxhB235ISYg8oRL2ozqp
 J5N1WQAN7Fnz+Fm1OaExOdMI1TesLLfFjRuKNh6ozTPtkoUmrE6PehyBCVMpYE8IcKTT9YDuLF4
 tjQVD05e1S9z2OHPkYnpKOXbtHBgkNm3NDAPioA7vuNCPCzfmdyCMfs8DuqBpQNGjwoPzkZCdLL
 Wq8HDIL3YOK33JaAUKq39u18C30DRDcmHqbsz
X-Google-Smtp-Source: AGHT+IFAlJ80xOGBOyFxZo2NZIOHdxKYjm+1CdKBS1lraLFsm3S5uMTDv2XFll7zZDusbC+I3loMVQ==
X-Received: by 2002:a05:6000:402a:b0:3a5:300d:5e17 with SMTP id
 ffacd0b85a97d-3a917603734mr11874570f8f.29.1751289001928; 
 Mon, 30 Jun 2025 06:10:01 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e71dfsm10191580f8f.7.2025.06.30.06.10.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Jun 2025 06:10:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/6] target/arm: Re-use arm_is_psci_call() in HVF
Date: Mon, 30 Jun 2025 15:09:35 +0200
Message-ID: <20250630130937.3487-5-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630130937.3487-1-philmd@linaro.org>
References: <20250630130937.3487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Re-use arm_is_psci_call() instead of open-coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 52199c4ff9d..7a99118c8c2 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2084,7 +2084,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         break;
     case EC_AA64_HVC:
         cpu_synchronize_state(cpu);
-        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_HVC) {
+        if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
             if (!hvf_handle_psci_call(cpu)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
@@ -2097,7 +2097,7 @@ int hvf_vcpu_exec(CPUState *cpu)
         break;
     case EC_AA64_SMC:
         cpu_synchronize_state(cpu);
-        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_SMC) {
+        if (arm_is_psci_call(arm_cpu, EXCP_SMC)) {
             advance_pc = true;
 
             if (!hvf_handle_psci_call(cpu)) {
-- 
2.49.0


