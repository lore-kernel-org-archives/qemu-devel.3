Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D20C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 12:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD0zf-0004MZ-QQ; Fri, 31 May 2024 08:04:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zZ-0004Jb-Te
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:18 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sD0zU-0003Ov-8u
 for qemu-devel@nongnu.org; Fri, 31 May 2024 08:04:17 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-420180b5897so9302855e9.3
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 05:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717157045; x=1717761845; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TcOfflgoyOmWmiWxXWkhwrBW0OpKGct+Toga2henGuw=;
 b=aWIovk+s7waKl38oHjciQYCUQu7ISZRiRSpY2OcQ+nRUILQjQYk1pRJAswSx2ptvG+
 cmTJJEAZHFNw/JO19Wpm72cAxwFWiblwhQHrR8AGzMXm+44leqYylCQOXBwQsOIIRkaO
 HVjJNptaYqvA453eF6vyQoXdcMWQjGbJ3XRObC8iZJvCJN6O1QwUv6GEIeuVJb+THnue
 a19XkurBW0kqBMTtGVyJouR8XfUEzJSIqxgDk0p/thxJqTq3LRM3WnmWTg0hxfZjk7nE
 3KEQWquBV5ASpeGqL1QY3SDm7aEoXf8WmSh+RZGUotRHSxvqRs0JlNI9gW4KEaygo/Ec
 lxWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717157045; x=1717761845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TcOfflgoyOmWmiWxXWkhwrBW0OpKGct+Toga2henGuw=;
 b=fOu+KtDtLncW1/atTIDdbYw1MsFMjTLrOl66IanDdWFpFomH3LEG40EI5b01wk0gMN
 0QPcQ2zijCzVrX05qOKvE+T4VnNFlSLGCIuDmxlAhPmHDcZA87rGUxnK6tz8EYcst30J
 nyBp2KN9pKo2z8f9pAWerZ/EnaEQZYnlMfbzO4Eo9EpWk/bAUHqbs3Megvkurlv5Wpsn
 SFceIqhf4YVFNoLalBvsy1+MXAWlNyQkSqIYKg4iVMU+s5twmGX2JcC77xU7wadJ6zQH
 cgr3BU7E+QTrhQhkGrOk/lJGX4lPLWFIfeVt1Zq6Fdj+o6KtfCcijpRW87Ev7quJn25Q
 R2og==
X-Gm-Message-State: AOJu0Yyjd7S+3gs5DoYnEOnZnH68AVcPHTvCP+JXo6018obnzjRMtwDw
 eVoqrn9HgH8acS1T8F5sx8fnU57Urcs/93I0zXVTac3CbpaTadVBkamN6GWPqVmx6s9W4vU7/6s
 O
X-Google-Smtp-Source: AGHT+IHdvdzt+7bcA9709fYWkQeeE5E1mLe7Bcqmyfczk8vw5/6mMIfSMtejYmmMrJaYY54Y3jHMYw==
X-Received: by 2002:a05:600c:4706:b0:41f:e7e6:7f4d with SMTP id
 5b1f17b1804b1-4212e0ae73bmr13969385e9.27.1717157045352; 
 Fri, 31 May 2024 05:04:05 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42129de0cf9sm37027685e9.13.2024.05.31.05.04.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 May 2024 05:04:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/43] hw/intc/arm_gic: Fix writes to GICD_ITARGETSRn
Date: Fri, 31 May 2024 13:03:20 +0100
Message-Id: <20240531120401.394550-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531120401.394550-1-peter.maydell@linaro.org>
References: <20240531120401.394550-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Sebastian Huber <sebastian.huber@embedded-brains.de>

According to the GICv2 specification section 4.3.12, "Interrupt Processor
Targets Registers, GICD_ITARGETSRn":

"Any change to a CPU targets field value:
[...]
* Has an effect on any pending interrupts. This means:
  - adding a CPU interface to the target list of a pending interrupt makes that
    interrupt pending on that CPU interface
  - removing a CPU interface from the target list of a pending interrupt
    removes the pending state of that interrupt on that CPU interface."

Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
Message-id: 20240524113256.8102-3-sebastian.huber@embedded-brains.de
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index 04e5a11660c..806832439b4 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -1410,6 +1410,13 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
                 value = ALL_CPU_MASK;
             }
             s->irq_target[irq] = value & ALL_CPU_MASK;
+            if (irq >= GIC_INTERNAL && s->irq_state[irq].pending) {
+                /*
+                 * Changing the target of an interrupt that is currently
+                 * pending updates the set of CPUs it is pending on.
+                 */
+                s->irq_state[irq].pending = value & ALL_CPU_MASK;
+            }
         }
     } else if (offset < 0xf00) {
         /* Interrupt Configuration.  */
-- 
2.34.1


