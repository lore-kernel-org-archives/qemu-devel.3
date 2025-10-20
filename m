Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04742CCD1A7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmNh-0002eJ-JG; Mon, 20 Oct 2025 05:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmNW-0002d2-7X
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:40:34 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmNU-0000PT-2g
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:40:33 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-421851bca51so3365375f8f.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760953229; x=1761558029; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hf/fX2rpCUP9IbKU00LmPKijOrrmaaRZ3WsqBQoJa5I=;
 b=twDX+FP+S1RRleobWNuibuXMmH8Kq1gWE+8BZQhx9b6khetwnKp0n0wJqe73JE4+NA
 KYRBOEZvwpsa4pzPI0jiwggm58uHx7abpzUj03iwoKxB46wo42jjFP7k+PVGyXiTAj1d
 65vxTWX5vaOIOY6pVxUbBRNWtuO0YK5wxVkVo7ExKslSma/dfVCK/G3TfEULlBM3Vatc
 A+MFp11I3qMF5ofFPailqHsukuZXQBjPE1bJwaQg9j82GbKeVzT7k5fmioeD5XeWJY8V
 KH//uhDuaeqpV5miWKVybHaVPX6Nrrr1+5ZijDvGTzuNtrT8LeHSkh/WOXpmVjRDWlGR
 VExQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760953229; x=1761558029;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hf/fX2rpCUP9IbKU00LmPKijOrrmaaRZ3WsqBQoJa5I=;
 b=p/E2JOhMPX0gdQt2F+tzEpj4XrKXuRX0DPXQ2RiFtPdWvCWrrk92EvDYgNExhgmt08
 zp2MNnNQFCRKF/jxPKOtq3Q/GzfNXkwbWRiw+v3sctB2z5oyA+o3JIJmFaeb0NKjLzdY
 Qtsgqc//YL4mnSx2nr+rNo/OIv0LhrdgrfzvxUBh9fptJaMgLWETk9lkbya0d799cZgy
 phZgw5TadJYlI1CydU+livF4438Ecmm0E0YZtKiQUAPdG8Zqr4r5g+bfaPMixNsIwr+1
 rGqAA9lFnQ0VSyWIl1ln46+5hYS7a9tUCYJK8CR6d4bEW5nkmRJiPwEDfth3glHXAn4p
 AhPg==
X-Gm-Message-State: AOJu0YwYxcyQPbX+ZiX9jDSOdFpUKykAQ5JsciY8tApNCRaXFogqnsTM
 Cma5EJR4AMwb7bNiZw0du+wmwOic4KgkwwTcKUrXGMYQIXZqyUjecAGtHB6BN6cTfhoZRSbik6W
 MZrIlRg8=
X-Gm-Gg: ASbGnctpCrRS1VzwSph+q67HZCGBqtxZ82JPZkDh0574ehZC5g++kCI++NN2IHchhqP
 rY8wMtwhyFM9P84hGINC05rAngrcPLp4Y+sTxOPi4tqbaGTwSjvz0NsTvl2UZ7WChfRJPjjMHzF
 hokAIeENGr3GAhwHfVMOS1sRDeQEpKo9Fkw3ZvruOofmBNSxaD/gNNWHgUN0IPM87R/acVcBn2S
 Jo4Fus4HXYq8hv8fr+Q9c2YMyny2avWEprf4XQx2X78x6k1qFv67tIoL0L+rMLXY067qbq3VJbd
 RoMsh0x2TcDzoSd4ilpXszkl90qeEmjGN4VrGSvPHikldMGrFue4h2vfZjrq6MixRtfXOzQrrJZ
 jQwu5NwSnrlHs1gPUPQrDBVcxbgGoreUgiVFon7ocgy9fIa01Y5O1SR8/drdsRE5mllkOJ81WoZ
 eQGIqNznVxJ3g7q3maUYLZC6XgVn39AuBlPuVRXOnrjiP6mCZKO6iStGvX0GIR1O6tg26U4PU=
X-Google-Smtp-Source: AGHT+IGG/e4K5kl2g5qaGWXZhXDf1jjqecL3qs0J0rSxamDS+7bc/p6tPrBO75/RwJziW0P/3ywZVg==
X-Received: by 2002:a05:6000:420e:b0:3ec:db8b:cbf1 with SMTP id
 ffacd0b85a97d-42704d900a9mr8415811f8f.24.1760953229168; 
 Mon, 20 Oct 2025 02:40:29 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f009a6c5sm14610953f8f.28.2025.10.20.02.40.28
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 02:40:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/4] hw/arm/virt: Remove deprecated virt-4.1 machine
Date: Mon, 20 Oct 2025 11:40:18 +0200
Message-ID: <20251020094022.68768-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020094022.68768-1-philmd@linaro.org>
References: <20251020094022.68768-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 175023897a7..ed81f3fe8d8 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3701,14 +3701,3 @@ static void virt_machine_4_2_options(MachineClass *mc)
     vmc->kvm_no_adjvtime = true;
 }
 DEFINE_VIRT_MACHINE(4, 2)
-
-static void virt_machine_4_1_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_4_2_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_1, hw_compat_4_1_len);
-    vmc->no_ged = true;
-    mc->auto_enable_numa_with_memhp = false;
-}
-DEFINE_VIRT_MACHINE(4, 1)
-- 
2.51.0


