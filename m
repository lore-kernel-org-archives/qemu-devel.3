Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 077A6C77B7C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:24:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk5Y-0002uu-Mv; Fri, 20 Jun 2025 18:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbI-0007yl-9v
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfbG-0006bV-Rm
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:32:28 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3a4f379662cso1866781f8f.0
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440745; x=1751045545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JKORQuvhUvK+XmMmn897LK3o1+aSIDxeoUHZSeHsuJQ=;
 b=w96gcg5XumYFoJiebiAzIAzdxAfTqNmMx3BfRkpFr5ScjRrrMaEUWkS0KM0Gpi2Cc1
 u6cKT4No8CZqFOdtuYv4AdoNFmpBJKSRfhSGrsGf+hh7vuEdr0Psh4PrnzXaDVdT+vDw
 5U2Wh8/+zWTP6++IZOvyhUi26YdNPMS5S1lXBqGoUmKQJNqDLnTo1W4VxJCf5MTr2l3h
 FfDs79XfbQsLE1fD/hGOjw3/tQ8ZRcNEl64rNak5HuJlGgpxP3oHWM8GwVJs0W7NBSQt
 74EbXT362WWY7UP0+rzY/9pZoFDi2YdvWtpzTvggpbNCT5dFr3W0okE5jg1WKrzvWRGG
 Ynaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440745; x=1751045545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKORQuvhUvK+XmMmn897LK3o1+aSIDxeoUHZSeHsuJQ=;
 b=bRjymoqUQ+PPc9f/+2QfI26ZptEr2RQ/IK7pEijMhc34JTX+AGDxUGDE4CFNjwIl42
 YmiHl8D0rThdyPCqkphl/tMUTlX441NwEWj9biTLQFVHcdUC0esKZX9mkjK6qsKQKjTc
 3J48Qw9fLUO4nsGLdy9Btx56mcJl4FTEHwzHaG27aTjPmb2OV8jO/25rLuRVsG+srI6F
 HVzDADIxxTeM9/dEN/7RnQVcKp08zMtzng6VGU5T4hM6gLOgWQoFjifJT9lgmpm3+nuu
 xQVV/fibHyd2dzbDb2R0R5/IZKNWtATqMMFsMo/NTycfoA6A6LvN+ANXPxMCazsPxdbc
 Lxig==
X-Gm-Message-State: AOJu0YwOoYdojO4VYca1fFICwogzRcWkvI+UZHce7uea6xL43mB8ftoO
 YdYC1KUgtEn8Y2pwJjU9RrKqNTaWaB/nbcq0Xh42gTjzLbOaKtUxPqAeDV2NXfXCJVEIhKFXJPy
 PiLX31qrfDQ==
X-Gm-Gg: ASbGncubKCVaKc5bHIxuBmCd/PvwfCcgtlIW51Pv27/950ZKsV5cSprJI3W63c7kOKP
 vn4bbXDjsI05hbDe8w4LW9Q2lQcHZhf8FyrYAy2vZjGg5DMifbjSgL1vt8Q/PbIAdm1/tRr1LD0
 Mfu8WnexOhF7BSYwDtYpTlAF6xdWw+SXS4rSkjndTFnmAyxDS+RaD7H6+mQf5u9+BF8f8lD8XCE
 hbuqQS8yX1bHRcpmLBGiACfaEYHYHqNjkV8HPul1vofq1EO6+ldgAbOQQArZCsxt95bspCv3/uy
 5Pm1kXG8bztW03KgMrx6AZf+BX+qH00lm0KN/w++i+6pRcB/7bcayFufzFmsd7NCDZebF9+tVJP
 qb42zF+nvdbc/uJ7i3eCxr0jb3tzHFo+LNI5ekTj6mPv2geyS1FdbmzqF
X-Google-Smtp-Source: AGHT+IFBxtJOWcKacsDpwyZhWm6XE9NRkO0/Bz1PwJMIYCtQIfvmvNb0WCBq7quoCke4UIHbbQb0MA==
X-Received: by 2002:a05:6000:4a02:b0:3a5:3bdd:6cfe with SMTP id
 ffacd0b85a97d-3a6d12b128dmr3425346f8f.26.1750440745086; 
 Fri, 20 Jun 2025 10:32:25 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f1057esm2648611f8f.10.2025.06.20.10.32.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:32:24 -0700 (PDT)
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
Subject: [RFC PATCH RESEND 31/42] accel/split: Implement remove_breakpoint()
Date: Fri, 20 Jun 2025 19:27:39 +0200
Message-ID: <20250620172751.94231-32-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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
 accel/split/split-accel-ops.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index 0f3d48fc68d..40cd39aea5c 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -264,7 +264,18 @@ static int split_insert_breakpoint(CPUState *cpu, int type,
 static int split_remove_breakpoint(CPUState *cpu, int type,
                                    vaddr addr, vaddr len)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+    int err = 0;
+
+    if (hwc->ops->remove_breakpoint) {
+        err |= hwc->ops->remove_breakpoint(cpu, type, addr, len);
+    }
+    if (swc->ops->remove_breakpoint) {
+        err |= swc->ops->remove_breakpoint(cpu, type, addr, len);
+    }
+    return err;
 }
 
 static void split_remove_all_breakpoints(CPUState *cpu)
-- 
2.49.0


