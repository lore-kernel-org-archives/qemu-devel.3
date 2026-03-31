Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A111109B468
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Yww-00067J-08; Tue, 31 Mar 2026 09:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Ywu-00064O-Fb
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:04 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7Yws-00049S-Us
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:16:04 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so67786745e9.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962961; x=1775567761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=23Lhs8kn7vYaYRccWIrPbcTZSCxSueDDCmQnurTSwZI=;
 b=JJixJ78cANrFcgTBxJafTNdirkWyashx3EJ6Tgm6e0J69K5nFn37JJbYOoTfBLJYLf
 KfeekSS7JbTcNtFHUTPp8aAcURkkcdkBclFO4bPJKfAFaaimwyXqCjw9uHD1Hjw5mVUv
 BBhqqSNUWeSsJkMheVYwyhJdIkldEMq6M9XGNkaEahDpUn2lKy7lO4JPNUJcW+UNVOBp
 Ct8P71lRnkokAXpZoG/+47ZzE8zfOB+/9ynqqTkztuPBgsFYskpXCWCzPI2BCpUMH2xn
 sylmRxF2ZeRe0BR2qcSGpkFQoZ88Use6648nKmR+4+WdLzypwdE1IPWOL3MFv+0qBBpL
 jLow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962961; x=1775567761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=23Lhs8kn7vYaYRccWIrPbcTZSCxSueDDCmQnurTSwZI=;
 b=Tg+6viuGGY0s3Ke/8ugltqIUBJZHqmOzBgmjxYUmEfq1JxTLPYotI1SRVEzuz+Y7li
 zT22YRU5IbS+GW9hGEIYmfTzCGUd1FYfxE0vifo8nWWedHT0D5Qb3R2SjZcHQARePuBX
 DxvOlsySZRC/UP/h11+sikVCuZGxt/0nVYyW+nIp3Qm+3c1GFbOt78Q8amlHNqrDhVcg
 EnI4vESRvb0f1X6xPMks8pN/vwjPrA12mx3ql6qjUx0CjuPUVSoV8I7aG5XsVLjNOBt6
 dV8lvDTWXCGRN57nQRSBSoRklM2up/KLad97N56evAaApixKbT7Cfa4PqPwVnozb74IH
 jVBw==
X-Gm-Message-State: AOJu0YwGYPxdjk/0Z1tWzJy+WOW8hLeahyTpEikPQPqV4OZ1YWDZd2rz
 v8vc+bX/nuJODKpcaLeAvqwAt63wKKu6zfSC9WECb2ry+fB/7XUGfcwkKQd4knZxca7JjglTXsi
 UJvA1VDY=
X-Gm-Gg: ATEYQzxQv3Qudfn/qGQ2vD09DHsSGQbRZ4LsQFPcHnEqPavBpEZQFjbrtVj4IMnpr9t
 VKl9Wjwm3/xmIWk6kWMvFQ8FifQBq4u/U2rP7cq+7YFc9SRU1pJaUQgUPn9CxWX01xVvw1NdpSY
 MUOlq1JL+l3gzVCH/n3UH77i+d3wig0D1l3T4+2aohHIl/e4vOENLAHB2wI2PI3MUWJha3fHMvj
 uwS+W8P0MPPIq6Pqz6T6WQ8utNnuftE4Nqe4/tAqS/8Ee+XIDZF9h2ezgsvOIdrOkWHmEMPG8pt
 o6rEV5qxJkKpv4kFRT/NcVqlxJTW34kr2zicZgV2Av1bvsIpDeawLIgyHd+L2dMyyh8kRaC87x4
 IfxQtp1BhXSCzUqDOe7hQBhNsjccsqlBWvtrIGw8RD8pblKr2/JnxT7QJ8vbyHkQmP4UeyWnSSb
 a1YWyW4plm3DhPExXcEiFa2ZMGiJoFDCVkR+CBIeIbzFIN5KyXHWK3Dz+KOAZo3008z2k=
X-Received: by 2002:a05:600c:a10a:b0:485:3f72:324d with SMTP id
 5b1f17b1804b1-48727e9ea73mr249520355e9.14.1774962960869; 
 Tue, 31 Mar 2026 06:16:00 -0700 (PDT)
Received: from localhost.localdomain (43.149.216.82.rev.sfr.net.
 [82.216.149.43]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e80140esm34573235e9.4.2026.03.31.06.15.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 31 Mar 2026 06:16:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/11] target/i386/cpu.c: Correct minor grammar error in warning
Date: Tue, 31 Mar 2026 15:15:07 +0200
Message-ID: <20260331131514.21152-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331131514.21152-1-philmd@linaro.org>
References: <20260331131514.21152-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Fix a minor error in the grammar of the warning messages
produced if both MPX and APX are enabled:

$ ./build/x86/qemu-system-x86_64   -cpu max -accel qtest -S
qemu-system-x86_64: warning: this feature conflicts with APX: CPUID[eax=07h,ecx=00h].EBX.mpx [bit 14]
qemu-system-x86_64: warning: this feature conflicts with MPX: CPUID[eax=07h,ecx=01h].EDX.apxf [bit 21]

Fixes: 91bc4d81078a ("i386/cpu: Add APX EGPRs into xsave area")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260330151309.1786787-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/i386/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d02f6f0653e..3b0a7c73632 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -9628,9 +9628,9 @@ void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     if ((env->features[FEAT_7_0_EBX] & CPUID_7_0_EBX_MPX) &&
         (env->features[FEAT_7_1_EDX] & CPUID_7_1_EDX_APXF)) {
         mark_unavailable_features(cpu, FEAT_7_0_EBX, CPUID_7_0_EBX_MPX,
-            "this feature is conflict with APX");
+            "this feature conflicts with APX");
         mark_unavailable_features(cpu, FEAT_7_1_EDX, CPUID_7_1_EDX_APXF,
-            "this feature is conflict with MPX");
+            "this feature conflicts with MPX");
     }
 
     x86_cpu_enable_xsave_components(cpu);
-- 
2.53.0


