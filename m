Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87DFBCCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtsm-0005cJ-SB; Thu, 23 Oct 2025 07:53:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtsl-0005bb-4z
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:27 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBtsj-0002be-EL
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:53:26 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-427091cd4fdso451253f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 04:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761220403; x=1761825203; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ey61OrLvwLgnrKRgCqt5Z0UyJzU3RSf7zDcJOKSwrWY=;
 b=HizzWmxyd8zVg1kBGL7aF3Udm5DJ2VOKPVC5hDdQu+N5rp/gaedVxBeZtQSR7DXwG4
 4rt7qZ2cEzICskbkVOP4JaY3shtW27R2UScmQcQjMJgr1yxewpLUIGD34KCEZDxpIOq6
 LqmaRzRb5e6ftN+DgPJSLhT+OL03JFof934N6uRKkiPUpQTzC1HWDZY0SXrf0xr6YhoZ
 Fgzeow0HsWB1q3yREMpUtSzz8/4HuHgzwgrE0dJE5CeS3mHwS/iL6UMyIOuQI8SDM1D3
 I4NYf0GLYKYig2A698ohKQG4zEV1e8r9toUHrGXJ6uUvaMxiUM4KkE/IEiAo0LYDQRcX
 XgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761220403; x=1761825203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ey61OrLvwLgnrKRgCqt5Z0UyJzU3RSf7zDcJOKSwrWY=;
 b=jIbTBC12LUuCV2y1NKCKEevI5GwmLn8glPY01I5euw5USy41N9LT8TIhHh1pElJq9M
 7pmrfPy4Nv/reiikdW3u8lrXQQSscE9JABE/KUlwAW8lJW6P1LMHFpzbHClHB/PZMppm
 7Itz71CRyk049s5RFL0iPiFeU4vi8tFQegCC5zgYRoyY5CtrflUNG1A4KTlc6+f0qiZK
 XD6UA7BDM6QCLsukSU0w24wCjzMIayR9b23QUPfaPmnGzBiRvI58jgI66MTNAzUEm/ky
 0gtNxrymvr02ITSEdnZhhWkheBF/c8xWQjccueKen3q09g6vnXvej7LQvb3HVLpyz4lG
 d4Kg==
X-Gm-Message-State: AOJu0Yw18o6UIIjVO3ZbOjq8cIeYRxwLAOKT0XU+pN1R+6av8HQYmHBe
 AJseLm10vFSNKyV00f0JrpvcZVcuy8s5+6ZDzCN7FJ6ttgSp721eXUtB76IeUQyLrlj1EK6Qwnf
 maCyqjkY=
X-Gm-Gg: ASbGncvdjMaZbuqQeDsbYaMuAzEBvWRXXMjRhPhbGB+8/LgXr3iwp3cYcSUpHMTv4NL
 DGK/lWObe5ivFnrDwGiDU2TSDeqmsoMGSYP00qgQaUpJv+ImlhmHOil/hcjJTXV8w7iTupv2U6z
 8pxE2zbcKu5L+j8Rer4Kln+TiqVboXxvVWV5HR3e01jMnuDIuc2KqIWHp+TyGOqvSVfg6wFgJ1u
 5hfu0oyYW5Jy4jIT1LFRZZEAFkGCJQbu1yOPou/1fc3QkYR2k7ifyYTkKCl6OMhth80D9Jl4mSy
 fLWWFelJaqVntIeWuhESwJh+O+0xmwdjBrJ6daNgK0+BrxkB3rHDCribvFRSPPbUu2FmQxQTxZI
 nAEHAPVKa8GmVAGEPHrLVxsoyEYZCP1OdntB84vMRPwqdye9HE5KH0fKhQAu1e2nC1YW3dC+3yb
 rbChUVHhR3g+Fdjo+4cWpdDugc89pEmgU24yTxh5XwOHeDG6OF4LZ8jFF83UOf
X-Google-Smtp-Source: AGHT+IGepPyahdwiLXa+hTChQvpqNqdtLaWlsgrnW2kLoUmHQ1ZOt/OezF+sVZ8Hdx9fv3fKFLxugw==
X-Received: by 2002:a05:6000:2407:b0:428:5659:8205 with SMTP id
 ffacd0b85a97d-428565a7124mr3721719f8f.56.1761220402904; 
 Thu, 23 Oct 2025 04:53:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429897e77dasm3714229f8f.2.2025.10.23.04.53.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 23 Oct 2025 04:53:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Peter Collingbourne <pcc@google.com>, Mads Ynddal <mads@ynddal.dk>,
 Roman Bolshakov <rbolshakov@ddn.com>, Alexander Graf <agraf@csgraf.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 32/58] target/arm/hvf/hvf: Document $pc adjustment in HVF &
 SMC
Date: Thu, 23 Oct 2025 13:52:43 +0200
Message-ID: <20251023115311.6944-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251023114638.5667-1-philmd@linaro.org>
References: <20251023114638.5667-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/hvf/hvf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b5fdd86837e..a045f83c9e2 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1947,6 +1947,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     case EC_AA64_HVC:
         cpu_synchronize_state(cpu);
         if (arm_is_psci_call(arm_cpu, EXCP_HVC)) {
+            /* Do NOT advance $pc for HVC */
             if (!hvf_handle_psci_call(cpu)) {
                 trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
@@ -1960,6 +1961,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
     case EC_AA64_SMC:
         cpu_synchronize_state(cpu);
         if (arm_is_psci_call(arm_cpu, EXCP_SMC)) {
+            /* Secure Monitor Call exception, we need to advance $pc */
             advance_pc = true;
 
             if (!hvf_handle_psci_call(cpu)) {
-- 
2.51.0


