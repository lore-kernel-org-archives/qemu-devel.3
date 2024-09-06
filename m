Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EAE4E6FE2F
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smbDP-0000et-DX; Fri, 06 Sep 2024 11:49:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbDO-0000ab-F8
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:38 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smbDM-0008BQ-TC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:49:38 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a83597ce5beso357632466b.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725637775; x=1726242575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W23TnfpgxAN9v1+Vm3iFNdPGKTZYWiFvO/O0vyDC8Bg=;
 b=UsljmePJI1FFjDPnTpGBhEryPUvuSMABjPpo10weX1g4fttZcxetTPcnUC44V+vE4k
 JRXDOnIVEp1yT++1PH1tj0M+nhy/AhnTpyGqKC9lS9zKNO86h7kdwX48Mpl2eLyVuYJx
 EqopL9mR2e8jwORf0gkd9AvS7CtanyfrfuF2jPuNrA9rXdXJZm5xJ1kb6axMf+GR696T
 TKBCM90JXkLMRlI37uAIVWwcj35MVVHlNZrb/bQ8qVA/U5yBbjT6E67hn8TOQ1gq9yQc
 E8Wz3DPcq9ScodMydewfdH2wSHrbeaTVFRNXikO3wmA2bTVctIyOOoxZnloLdkopJ6t5
 7+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725637775; x=1726242575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W23TnfpgxAN9v1+Vm3iFNdPGKTZYWiFvO/O0vyDC8Bg=;
 b=wmmPQvUqQLErnboD8G0Gl989wRvaFhP/eGMraMq+MdGFXblHrEmuz7rBq6j1qlCKap
 ZAJVLBZR8x7T/9I+2/DfxgVm5mmYED2z7QjOvUrTVDZaHYxFYdjqGjlFgqT28Exo4N6b
 3amFnD29+pqEawej8cM1/M/ft0vWfBHU8IikOwNrxV2k9O15lgiWLqOXCURrFzdWACPq
 hnAS6oanciv7fK9g7xIDAnKHCH9Nr48U+kJOM65CJiBliT6SNE4CbjcwAONf4vPKegXJ
 CO0U0qcw42BCII+m5ntVlemamXx/msCsbkVEgm7a1McqBu5ceTalpgg887VfwqufyGgq
 Z9RQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3bm50xLbkYimLySS09hR9SgTpTipbPXi6M8pHzPQrpzn6rEqn8cdscPE9ex74BqJlNgYWSECVgajn@nongnu.org
X-Gm-Message-State: AOJu0YwIK0Kzy/Tzk/r0og4MCGqWerP1Ot+X5ZzVw/rPbMDmH4ff4tMY
 F0/ASOiXj2xOR5K+6Cg9I3Du6dJ++9f2F1ca8NN2yfGf9Gg2ihq3H9qzP4Pv9fw=
X-Google-Smtp-Source: AGHT+IGLAPHe1BZaxJywiT5Ah8pICN7s2/dr3WOBJ5u440fGYM5yOTmvt1qVJ8dFdLWOsbqs2rgb6w==
X-Received: by 2002:a17:907:3ea0:b0:a86:b9c4:a439 with SMTP id
 a640c23a62f3a-a8a431c7209mr1128050366b.21.1725637775493; 
 Fri, 06 Sep 2024 08:49:35 -0700 (PDT)
Received: from localhost.localdomain (225.13.23.93.rev.sfr.net. [93.23.13.225])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d0e116feesm34907866b.10.2024.09.06.08.49.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Sep 2024 08:49:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 4/5] hw/sensor/tmp105: OS (one-shot) bit in config register
 always returns 0
Date: Fri,  6 Sep 2024 17:49:10 +0200
Message-ID: <20240906154911.86803-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240906154911.86803-1-philmd@linaro.org>
References: <20240906154911.86803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Per datasheet, "ONE-SHOT (OS)", the OS bit always returns 0 when reading
the configuration register.

Clear the ONE_SHOT bit in the WRITE path. Now than the READ path is
simpler, we can also simplify tmp105_alarm_update().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sensor/tmp105.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/hw/sensor/tmp105.c b/hw/sensor/tmp105.c
index 6740200aea..f5101af919 100644
--- a/hw/sensor/tmp105.c
+++ b/hw/sensor/tmp105.c
@@ -42,12 +42,8 @@ static void tmp105_interrupt_update(TMP105State *s)
 
 static void tmp105_alarm_update(TMP105State *s, bool one_shot)
 {
-    if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE)) {
-        if (one_shot) {
-            s->config = FIELD_DP8(s->config, CONFIG, ONE_SHOT, 0);
-        } else {
-            return;
-        }
+    if (FIELD_EX8(s->config, CONFIG, SHUTDOWN_MODE) && !one_shot) {
+        return;
     }
 
     if (FIELD_EX8(s->config, CONFIG, THERMOSTAT_MODE)) {
@@ -166,7 +162,7 @@ static void tmp105_write(TMP105State *s)
         if (FIELD_EX8(s->buf[0] & ~s->config, CONFIG, SHUTDOWN_MODE)) {
             printf("%s: TMP105 shutdown\n", __func__);
         }
-        s->config = s->buf[0];
+        s->config = FIELD_DP8(s->buf[0], CONFIG, ONE_SHOT, 0);
         s->faults = tmp105_faultq[FIELD_EX8(s->config, CONFIG, FAULT_QUEUE)];
         tmp105_alarm_update(s, FIELD_EX8(s->buf[0], CONFIG, ONE_SHOT));
         break;
-- 
2.45.2


