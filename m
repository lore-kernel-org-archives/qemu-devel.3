Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF17CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:42:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtxR-00056y-TZ; Fri, 31 Oct 2025 14:34:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtxN-00055o-O4
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:37 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwm-0006JD-8q
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:35 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-475d9de970eso17804305e9.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935628; x=1762540428; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ZyVNJQKy9POeDYbbmUmHKlgq0fZTUfxaWogyqjot+t8=;
 b=klPIbsqxaMcb7IwjcA1aNgysZTYzp4q6M9tZG1ejuiepvYIJbP9wWvDYw2UCNNqHFC
 upt43lvnLomz2fFDnPuFLIk9knMUXzvuZ1+v3zgcLzViNLly/COyAhWxBq3yh/EvpQcI
 50+WKCuIdV2FzbywacM7NSgy+ar6woH73ohmQnsWhg3Ze0PcaYreWqHELYfFijb98sAn
 wT1N8WNqPjEJM+5H61GXF2TMcdGIC2BCfudE9CCg7WbLbWxTZjUnPf2GCzK2GPRhCCwI
 YKZM6+LR1mkPqtfTCjGojqawvdPi0ZXtZMPZdiL98DxO3CCK1lLHDSf3cvZ5cPQy8U9d
 cTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935628; x=1762540428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZyVNJQKy9POeDYbbmUmHKlgq0fZTUfxaWogyqjot+t8=;
 b=L46RsqBh5XYYPvCFY4xNGijodpGFzuiFmlDLMLkI4fVzFd1rrF0NUmVMA84gYX0x2g
 ODsAmlPNsUkOMf9Sc4WGESUqTONwddDEnC5CY0XxcIjZj8h9tPZxiOZJzI9fr9j30zq0
 wPbw3rH4rRgpGDc33tcuj+VFzuMb5KBYNPw+jX8HRLkziJ7xW6wm4Oz0njjNleyyuGPj
 VyKwwhhmAUXCNcDE4r2cS/wvh8H6KdMKVhXy5EKySkWOv/ym8LQj438U6wjwpulooOdK
 TVwfirrdfkovDNH3d9GF53crN9Bo9yz9s9WUqNr0s9yzaQVy8hWiamH4yBpZXCYIqNav
 Mckw==
X-Gm-Message-State: AOJu0YwRzDoFBZc7d6epe/1A0cpwiqInMIpTdBOA4e4IF8UP3g8IQlUR
 nJ23UyYnOFOSXHmaQb0N7om+2dJzKULCl9QgfL8W8zXLn1tui9IuDaLNcIzv3yGuDanPnEd435j
 lZUR1
X-Gm-Gg: ASbGncvEZfmjYCzQ/5hYfN9es7pfWm9Oc7QGkca1JdzSYf/DKNziFir8xXIee6KgNiC
 X+E9y9tNnsaoMWzIlQshU2sBsnL7MKb+KP5oVLWkrOdL9MXwVZhadvbdD6yjSkkAEPbeUbpxyFy
 dRhcl1Xx3ULnb+8Ot2DSGHcngVGh8ELQuIlX4bHSGSQmsILv2v2cqb9vSAFrVIYKOa6TMB3lS3R
 DvxY4MXrVpTTs2WlTcof//aaPlvhzgFwcA1ixB5JLSDw4DZgNb/8+Q/lH41TdX6FGVA6RyM2rR8
 7PMveld2nm/qwGxjak7kYyH1wdewgvNHkL9vPQNxCU7IflXCev2p6po96gCDKwcGevNfkm4kene
 sxL4Ln2Q4x57kma5PnbGZnSWQ/+naQxOqxYFwq+0KuWQ3mOPMGKTxiORUY6bBJxx/fOL+fF8dh4
 kkE03HLlwkQPt5cKl6
X-Google-Smtp-Source: AGHT+IEnBPRE3skMkPy/gyqYFnKh9RjRNpf8aQn/dXP/oInjU6sS0p6rVqSawIkbK2ErpUSGFFTKog==
X-Received: by 2002:a05:600d:8348:b0:471:14b1:da13 with SMTP id
 5b1f17b1804b1-4773163820dmr26993155e9.14.1761935627786; 
 Fri, 31 Oct 2025 11:33:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.46
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:46 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/38] target/arm/hvf/hvf: Document $pc adjustment in HVF & SMC
Date: Fri, 31 Oct 2025 18:33:09 +0000
Message-ID: <20251031183310.3778349-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32c.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index f31b6e54ee7..805fe75e6b1 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1936,6 +1936,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     case EC_AA64_HVC:
         cpu_synchronize_state(cpu);
         if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
+            /* Do NOT advance $pc for HVC */
             if (!hvf_handle_psci_call(cpu)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
@@ -1949,6 +1950,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     case EC_AA64_SMC:
         cpu_synchronize_state(cpu);
         if (arm_is_psci_call(arm_cpu, EXCP_SMC)) {
+            /* Secure Monitor Call exception, we need to advance $pc */
             advance_pc = true;
 
             if (!hvf_handle_psci_call(cpu)) {
-- 
2.43.0


