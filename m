Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9AFC3600C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 20:44:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0RMs-0000SD-2v; Thu, 03 Apr 2025 16:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMq-0000R1-1y
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:40:52 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0RMo-00052s-Cs
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 16:40:51 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39c14016868so1184009f8f.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743712848; x=1744317648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SuT3rRChRQlFqOt9wOfD9dqVNsRbmscUvrlQveNmeCQ=;
 b=uOUHGa3nAzLCCBRWwun+Yrye/hWW/2ZHX8limWayTJqOttULKcl83zIrSX2WtZKTu+
 8eUOiABT9JBx5SCUMNLKBPX+UVmL/rcW3+2vqkN5HMHf+9qM1LjeDZqRk4gquqUcd2eR
 CWdGUQo7CpepaBzxqslGAwIuJhwILeo+xVrJDDwHHLVSfjXRgZSXUgB+1d/vn63m7hnI
 fmqLPRYnf6p+i+ylmz41mWq1MBNQOSbLbsCN3sBKEejM1fBjhx6ftrAnB/Zn9IbwgpnI
 8Wh0Qup97CxyPmtZX3hsAHIAWxgTGpG2V7c7Qd9IvXb54zJTtSh5gkbNoozsfMyEkOhe
 Fp/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743712848; x=1744317648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SuT3rRChRQlFqOt9wOfD9dqVNsRbmscUvrlQveNmeCQ=;
 b=YqkL2IBfZHVqqPWaRMcDJBNLmGBUblenH18VYbq9//i3ST1DVae+cHUgKR9Wt80GXE
 R96k509sdLopxjYOCbJFLEnTYHFVTasajZySkbh5TXbgC7UByGCB6KygrwII+LllIqXz
 esh3pe/pRATBYlEcrykNpR6yGpqIC2vZx45ipq0PGjG/XuvEqbx+yztP8MilNytz085C
 BsF/dGWcoCsz4AV4wVAU94zjfgXASSJ+nLquaDk81A8vxPJB8wv+QoHBrL1zLHIqmI+U
 5Fh90CEFlz302bB7S9GWuEc1PwsjMhn8udRTm49+mbflUBVOUtJAcoBPbd/o1GX9myiD
 FhSw==
X-Gm-Message-State: AOJu0YxTS46MajFjOPM/fapfK/zgerJk9YncCZm+1ZevY7sV3GYxf8KI
 ZmMQEJ5AxNp1iJZJM0MX5Wkokbr7TAl9vDu61g4HtJMzguijp6K/ddaLlDnDSCNwyWvqoljAUqM
 w
X-Gm-Gg: ASbGnctWp//zV/uUIVDRv3jF52xBzJgMKKP0ts1qAjAiFlDeosY+EWu8n5ZiD/a4hRA
 2SRZ/xrqgn8zPYi/H7pCuHcX3kgn8ijIQz+QjhR+skjOPITtm9uqYSc0+r/byaYQCDRYCwkbm7d
 i/3gUvv77onzad1jw7iOO9VxPGkzQUIvmJ4Nm7PZoc+m3tKf4wAEdQo7q24UUTFvOS/gf2BBiQ9
 Uego/VoUWBZ1OQjzPizZ2H1Rnhe/x0GpltMp1EBCgGKX4UwN/kHmMzVxoB8u6mM6Gij3x7i0MF7
 qdRAR2eiJWnnAvBjHCQpWL1wZjnCI5IMvOHnVpJ7pmMFrXkwFHIO+rNz3ZP+ry/m/SuAEHdXbPG
 8HrYNzQraX9PWOrg2la5kfVvt
X-Google-Smtp-Source: AGHT+IF2VMf4EDjDDN59fjDN+tbSx4iQ6z95AwQIjihuuUbgWCnpzmAUquWXDrOlNBosmQV55armwQ==
X-Received: by 2002:a05:6000:4402:b0:39c:1257:cd3f with SMTP id
 ffacd0b85a97d-39d14663264mr123060f8f.57.1743712848318; 
 Thu, 03 Apr 2025 13:40:48 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec34a8d67sm27667955e9.12.2025.04.03.13.40.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 13:40:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Udo Steinberg <udo@hypervisor.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH-for-10.1 v3 3/9] hw/arm/virt: Simplify create_its()
Date: Thu,  3 Apr 2025 22:40:23 +0200
Message-ID: <20250403204029.47958-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403204029.47958-1-philmd@linaro.org>
References: <20250403204029.47958-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

No need to strstr() check the class name when we can
use kvm_irqchip_in_kernel().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/arm/virt.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 177e9e0eadb..326986deb16 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -711,21 +711,15 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 static void create_its(VirtMachineState *vms)
 {
     VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
-    const char *itsclass = its_class_name();
     DeviceState *dev;
 
-    if (!strcmp(itsclass, "arm-gicv3-its")) {
-        if (vmc->no_tcg_its) {
-            itsclass = NULL;
-        }
-    }
-
-    if (!itsclass) {
+    assert(!vmc->no_its);
+    if (!kvm_irqchip_in_kernel() && vmc->no_tcg_its) {
         /* Do nothing if not supported */
         return;
     }
 
-    dev = qdev_new(itsclass);
+    dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
                              &error_abort);
-- 
2.47.1


