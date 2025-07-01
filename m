Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E418C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:11:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSj-0005m3-5n; Tue, 01 Jul 2025 13:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSg-0005jS-86
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:02 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSe-0003gS-4j
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:08:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-453398e90e9so29243035e9.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389676; x=1751994476; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Mdqrq8TNiJgbQe6RUl9ahMIeb4dG8atTY9r/8PfJiic=;
 b=nFL0irx/Q0EYB+QdkjHr8NKcTgVyV/281mC9Oc9mvH87ZaNb8n6sISXuwODrEhLxgO
 Uf+P1KhhYizeRvq/bELKsemCW3T0x8bPx7mdhvjoru89LbUTERpqVHGpl9Umuwmqq/7+
 sFuCaiQoCBDtMfih9cQNtro1ZbIrYTxVqib+Mevc7seOYbm3tJFCor/ijsGq5xdbExgx
 maDzN8RLxH0xlCvnBeovsF5yQR44BOlEG6lt+G2OGqzazKXj3PqzOzwFEPV+rPuyhiYW
 ZS+F1IKTHJLIkkukQSQPDBhAQgDqZkVXO89JU2tzPvsy7oQjxRtjodynjZQa5gey765k
 7fgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389676; x=1751994476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mdqrq8TNiJgbQe6RUl9ahMIeb4dG8atTY9r/8PfJiic=;
 b=mqW4HRh62NQ7Sd+b2VXQwt4c9FAJkcpFL6ksmAaYWQaE4rjO2a+ajN9ewl+l4hm66G
 dxeX4hUBdCukFaOriwCGVoyV98l1a4EImjFVfM7STMEf37BKnZ+jJQRsXz1vEfd5dfNY
 LasMDO4AMN3mSWgo2ShoHHeLpPkpkIr0zka7KRFfIh8xgs8KAe5vuTv66VIgZ9UG4yRq
 eNxfb/9u5ykX0wdi3nXRRkRiJWADu2gYSf5BIuxu7bv5bU3DmtVDuKi2OT0jQiZdyFjv
 Cyqpps9/QH9bQUTNH/UE3S9SBQen16hzHvWEj7fwaUnSOJfWFlVOIqDzYD0S1gSvZlAg
 Nesw==
X-Gm-Message-State: AOJu0Yxcv8FYGNLOntQZZQrYDR5r64/RySyhu4oY1mfegka+zGKsP/l5
 68OORTwLSuyzKZv1U7JNgP5BKoCMZZojn204w4v4fnTk7GKn2n1wlV5vhW7gaO5os86K1t5gN91
 YIpjG
X-Gm-Gg: ASbGncvgeVUgg0FXAv9God8min6+jilOrBj0Pzna7vaeu97/vubivXjC0g3CusmU8CL
 90F7Xrqv/C6wx1RiZYo1mWER6xV45g7KD0YDEOgIA9uNJNdd9WlBgt8oZu4mnY5LhsaOFHDMsHQ
 wV/OxJdZH5VH+5fvOwUOU8RM9QN4tXqtjohdRgwr6SGggfO/sIyF7Rodt/TM3gF+W7IqdXhuQwN
 06cq99ejAP3QVf6cM+9jhMDGR2PPVuAH4VCHpaH1R4HQpYTX3diaQnc1DJr+DQhTv1aMX8TjsX8
 PStWleBU9kp//dxWGRDBPy9jgDXKvMYXWlUatm5ItKzZeEgxeQ1dN/oM+lv6SdlN3QSy
X-Google-Smtp-Source: AGHT+IEJYqH6c0HsuFnihQ9hVW9cXskyC2oGb+7s+AJtCfFffBtElBF8jVJaqM8r1R8AnxRK6X+FPg==
X-Received: by 2002:a05:6000:248a:b0:3a4:c9d4:2fb2 with SMTP id
 ffacd0b85a97d-3a8ff149554mr14492102f8f.46.1751389676134; 
 Tue, 01 Jul 2025 10:07:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/43] hw/arm/virt: Make EL3-guest accel check an accept-list
Date: Tue,  1 Jul 2025 18:07:10 +0100
Message-ID: <20250701170720.4072660-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

Currently only the TCG and qtest accelerators can handle an EL3
guest.  Instead of making the condition check be "fail if KVM or HVF"
(an exclude-list), make it a be "allow if TCG or qtest" (an
accept-list).

This is better for if/when we add new accelerators, as it makes the
default be that we forbid an EL3 guest.  This is the most likely to
be correct and also "fails safe"; if the new accelerator really can
support EL3 guests then the implementor will see that they need to
add it to the accept-list.

Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250623121845.7214-19-philmd@linaro.org
[PMM: rewrote commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index ae419e86712..b3b1c6df7fa 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2200,7 +2200,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->secure && (kvm_enabled() || hvf_enabled())) {
+    if (vms->secure && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Security extensions (TrustZone) to the guest CPU",
                      current_accel_name());
-- 
2.43.0


