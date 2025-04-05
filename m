Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6217BC36010
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Apr 2025 16:15:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u169R-0000WA-2m; Sat, 05 Apr 2025 12:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169M-0000Vd-W8
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:41 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u169J-0005DO-Vs
 for qemu-devel@nongnu.org; Sat, 05 Apr 2025 12:13:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso15783715e9.3
 for <qemu-devel@nongnu.org>; Sat, 05 Apr 2025 09:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743869616; x=1744474416; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jYI5KVOJ91EMhs4quXZdyucnDtf2JupiLUWOmCJhAlc=;
 b=bFdMIK3UUfdXPaKRG04HSP4nBi1t4F0/ZEqBikTGD1BUj6lzmXLOa/Y8fF0Lxvwp6+
 PlWBHYjXx8PfX7Ao2prxB10gxOV0I6F+D0Jgm8uLmI0X/c18FVMBFnAzjbV39HHQjLvD
 xo5Eg/ArH6bptUvfpWULOy4vA6CQsq+jUS5shpNvn0TR8iiNiYaMrlbG/cUj4H7mIMUE
 WOFWhWm9eJ0YXZIRXe+Wvcd4WZlK+P51sXYU044e2PzEJykQ+bv1McYAtAm5/KFfKcSC
 dSPuwRsGY77qhYeeETid4yTAcIJ9mlFCizA7+oRQm6s5R0V+2aMGpmX37JBQzprPHPub
 t2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743869616; x=1744474416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jYI5KVOJ91EMhs4quXZdyucnDtf2JupiLUWOmCJhAlc=;
 b=PKuTyuanMxBtPgu/8s7DtE2oRoBOoPfhWupLSm5GGA46VhNu24q2XY531XXTNj5Lep
 eZbw0ZJjLS+fIapYDS1dCX/N44Cr2fL0BiCCtPtzZR0T6iiB752sXA82rL+o0N+3w2ga
 ItqCR4gY/paC6prmlBGOQciXxWLn6N8wyUq7cO9iyhiZ8vj5M++hv25uz2qTlxegio6K
 ed5SW8I8z0+l7lqN8eFAXOxSmfGowcAyzYe0XMjzTwSWawO50NoMR7v21uTPMhR1PJgE
 FpvzErobUv8cS6ettdnC3x4CxLKPQgOwzt/d7LCUJDOhH0YcCblT+Jxh7gcbCqBWOACn
 RnjA==
X-Gm-Message-State: AOJu0YxnrV8KjGtuQms3tPX1J4iH7J+KpNMggmNUCsVjDaEb0SZYcqpJ
 rmV6QRNi5SI/fJ8W8WWXUy2HVTnERbcjaub2CLFFf9pw+rw+NSzLj36H/Jik5jKtnAmEhcYJtwr
 t
X-Gm-Gg: ASbGncvy+PWwIpsfytE3u29vpRFN8LS181bY8Ph55pc1j5GH74W6Zc7yaLEpeIDeCML
 /Djw+y7XoWbZ1cw0LKaVgJtrRsiqn/oVFVEgG1NuH5HS4DJJESKfyPT6ycGLRRrofnfPDCrcNNu
 2kSU8cFa7ujfI+cwpQTlqyfIo1bPYkSWkHL9PxYCJzcyBmSIoidFO9qqbfy8XRcRaa9v2uDs04Z
 2eNBiM1XfViWqb0T3KRY1kYcBFbbCB3KgrCeVRPciOKS4khNfvsF9D3qHrTDqHx6YlEFN40Ejrp
 PD+/2+6GtMM3d13ybADotwdd3ZSzs7JLR0BbRbLHlHY0cBOVtNnXpcPbIFSSoTC1GKP1lTWV7L9
 o4ukIaHYfXY3XYN1mOA52tbPb
X-Google-Smtp-Source: AGHT+IElsJlVaC+jd087/9sNA6LmdWiMBlnLtgCDaxk/LRDV+GSWzKozYeuJ95OIvOjEh3e8a4DgJA==
X-Received: by 2002:a05:600c:3ba9:b0:43c:f16a:641e with SMTP id
 5b1f17b1804b1-43ee0616ff9mr26293835e9.6.1743869616040; 
 Sat, 05 Apr 2025 09:13:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1794e94sm81620965e9.31.2025.04.05.09.13.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 05 Apr 2025 09:13:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 v4 03/16] accel: Remove
 AccelCPUClass::cpu_class_init() callback
Date: Sat,  5 Apr 2025 18:13:07 +0200
Message-ID: <20250405161320.76854-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250405161320.76854-1-philmd@linaro.org>
References: <20250405161320.76854-1-philmd@linaro.org>
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

No more target defines the AccelCPUClass::cpu_class_init()
callback anymore, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/accel/accel-cpu-target.h | 1 -
 accel/accel-target.c             | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
index 37dde7fae3e..e983fa1dac3 100644
--- a/include/accel/accel-cpu-target.h
+++ b/include/accel/accel-cpu-target.h
@@ -33,7 +33,6 @@ typedef struct AccelCPUClass {
     ObjectClass parent_class;
     /*< public >*/
 
-    void (*cpu_class_init)(CPUClass *cc);
     void (*cpu_instance_init)(CPUState *cpu);
     bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
 } AccelCPUClass;
diff --git a/accel/accel-target.c b/accel/accel-target.c
index 33a539b4cbb..a45a7317758 100644
--- a/accel/accel-target.c
+++ b/accel/accel-target.c
@@ -74,9 +74,6 @@ static void accel_init_cpu_int_aux(ObjectClass *klass, void *opaque)
      * TCGCPUOps depending on the CPU type.
      */
     cc->accel_cpu = accel_cpu;
-    if (accel_cpu->cpu_class_init) {
-        accel_cpu->cpu_class_init(cc);
-    }
     if (cc->init_accel_cpu) {
         cc->init_accel_cpu(accel_cpu, cc);
     }
-- 
2.47.1


