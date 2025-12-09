Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5437CD1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 09:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSty1-0006n0-4Q; Tue, 09 Dec 2025 04:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vStxy-0006km-Rm
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:25:06 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vStxw-0002Jr-Ii
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:25:06 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47a80d4a065so1421525e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 01:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765272303; x=1765877103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rMYHo9CKGWoLVCQcgyGnKo7wkmT6Z8PYd+ym/Y4GtS8=;
 b=KCHPqWXGU/2dZJ1IH8ktlwgZVyNeNE6zSZ+oJ/vl21wVwI1Th1BLVbvpzJ3qHXJIwn
 xZHlRI+PUdM+1chcnFXT3dIPfWJvNgiRaPvFRE98CkQtsKMYU5iMZoee9Cu7sKMoiW2Q
 0kQl1QnsLFcknqtrg42f27ipQ45/nCSkdAB0Xa4MNPA9V7mFPXy8dPKxMi0fMQmLTJhw
 YywdjlGOE9Y4Cds6fqJKMqXXkCTEg7dys6uZB82lBPJH1JZPSvIN8j5qzKgwU3wJSw30
 JnainY6OkIOtXlVIdk3AExV+JH5d/B1xIG6y7MFSiVAH8+G/o4rDyzDhBRl4cvLWAQAw
 mgLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765272303; x=1765877103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rMYHo9CKGWoLVCQcgyGnKo7wkmT6Z8PYd+ym/Y4GtS8=;
 b=GBmhgGvx4Y6esL9p/mDSu8/1kgLZZRwah3K1iMKw6C4wI2vKsfe5V1ildDfsgV5I3E
 3jlTWfNrkB7QcBTI1aEh6gbetgBGzEUsyJ+yVWe0j7HlWK5x4rZdLkDhx4cQYbRq4MLp
 hk9agIl1cU76Grn5UHRKYhL0ZDVmbb2lL75nDjT0g/xzTIAaVP+VWGR7Kgzxgy+lQv3T
 aJ9/tWvqS4jrEzI91bvEbUwxirEAxQ3u1uoR394E3hARK8UftY1UPI98oLM5VMTpHWOC
 dhBPYsHX9Xn6tFr9ZDgeY9FymRqws9rbpGA7JUnAAFQmtvKp976oiVLlPTIfXhLekhSu
 CsCQ==
X-Gm-Message-State: AOJu0YyEh7EdRB6utikwOYCEGo4SpaGrA0kOIu2kQ1tp/zdXDyntoud4
 dKxS3GAEzm+XDFdZh4/VkbYbvIAWIWNvskBFkbnBZVAsthKLMoI72JSYeVUrXnjnDYE=
X-Gm-Gg: ASbGncsCAXipwaGnq0qTUP+fG12wMrU0TlF30FBNb2R0EKWsIeSdvRR8G32E+PWK7kI
 O2C5fxPCIBZTVr1SldEh1xSBIgfwluN6JvrfiszpUzjVPN5fSDur2oW5curjOmJRDP5BCrL+Fcc
 Jd3Fov1RgKsPNmD/+VIy4bJUMBKgjohRxTBLopfV38NnIKVtRiEqlEoXeWpXeZFlVjcknaFUyZ+
 Jd+k39EI2WdCUkY5efIjbQadcHc2MPN3c9FGiAaTGZcUzLvQAKoyEKsSwrI7Qeei6/lPu8UpXky
 lsvkza7Kt7TqkjhaCPOwIoZPUKPbgf7SH78MROuX4dEdhWgiPHjjaecmnsftv9obpEag+OZkWwd
 ym8HV5V/qUDZDCFJsVPXlqTjWWICEmYhquZoSMB1SfL5YCM69vD+nu/uwvkYV+lihGmDWIZHKJT
 fxxPK08x3XyBc=
X-Google-Smtp-Source: AGHT+IEUcYKtImaN+MB6jR+ErxfH9ywEYeN+y7kh/5b8IZ7mKK/9NEqXOrD/m2uKJEz/Nb9gGR63iQ==
X-Received: by 2002:a05:600c:529b:b0:479:3a88:de5d with SMTP id
 5b1f17b1804b1-4793a88deb1mr102905335e9.36.1765272302827; 
 Tue, 09 Dec 2025 01:25:02 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a7d6fa121sm28672735e9.5.2025.12.09.01.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 01:25:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8CBB35F747;
 Tue, 09 Dec 2025 09:24:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Stussak <christian.stussak@imaginary.org>
Subject: [PATCH 1/4] Revert "target/arm: Re-use arm_is_psci_call() in HVF"
Date: Tue,  9 Dec 2025 09:24:56 +0000
Message-ID: <20251209092459.1058313-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209092459.1058313-1-alex.bennee@linaro.org>
References: <20251209092459.1058313-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

This breaks a pure HVF (--disable-tcg) build because the fallback stub
will always report false.

This reverts commit 4695daacc068cd0aa9a91c0063c4f2a9ec9b7ba1.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Christian Stussak <christian.stussak@imaginary.org>
---
 target/arm/hvf/hvf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index de1e8fb8a05..70d34063df8 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1935,7 +1935,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     case EC_AA64_HVC:
         cpu_synchronize_state(cpu);
-        if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
+        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_HVC) {
             /* Do NOT advance $pc for HVC */
             if (!hvf_handle_psci_call(cpu)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
@@ -1949,7 +1949,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         break;
     case EC_AA64_SMC:
         cpu_synchronize_state(cpu);
-        if (arm_is_psci_call(arm_cpu, EXCP_SMC)) {
+        if (arm_cpu->psci_conduit == QEMU_PSCI_CONDUIT_SMC) {
             /* Secure Monitor Call exception, we need to advance $pc */
             advance_pc = true;
 
-- 
2.47.3


