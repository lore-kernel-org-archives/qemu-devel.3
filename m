Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC25FE7719D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:03:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWHTh-0007VS-14; Fri, 10 Jan 2025 11:03:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHSl-0007EV-Cx
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:19 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWHSg-0004BC-9C
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:02:16 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436202dd730so16584775e9.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736524931; x=1737129731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8OLaY6F/9sCWhpY75SuT5qJrpcYslGi6JHoV5OFmEC4=;
 b=T+FAA+nyOKwyshWmmtkrvFF1xwpqpnkjsmAHRpOoq/Aoj5rTl+VhR7dbtBW1nlzejQ
 s8CCyxsYIeVC7dZyr/YQEaVvW5sm5uCDIaRkNcLpzdfXytToRPNj2FVEvxyl8JqGMQ6O
 Pc9E/fMQZtLrtoUpzgxJQk0aSOefNktYJCzmeoEOMzLpFy893NOhTOCJrLfkMRap1VDM
 geRTJyqH822K/H5tkeXr7lbQJ7Lg0lWBiiQs62Cc4jZ55kZIm27YmZ4RqZK5DOfWtf7Z
 hACn6F2L61UvW6eMmG98XpFKxvjPsNDB5/jYNUNSc/4wP2Sbk6Q8r2KbhrxAxJZ49tEB
 H1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736524931; x=1737129731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8OLaY6F/9sCWhpY75SuT5qJrpcYslGi6JHoV5OFmEC4=;
 b=wFh3mEEgVTEy3VO4hBsEV5H0dJQNidEsSHBTCo4/Msu4E7xavUGd1480u7pip0BZfk
 Kon8YAqy+wAFc1v504eXOhjP2CqA0N29CNHM+9MzV/K6pAHiW+ZEuaVgYHpY/j2ycPb3
 N7It5Nruz5PbxP72COGs/aw0NJx0qzjmkABoEEkDpV8vRYpPWkVn8yIAfg0if7QzKEWZ
 u4HP7rSzarB2w+JcLH3TILUO0eWNfX5/FAfIh6JAWRjVF5Zpfm1dx7xkHky7uF8I6aiv
 PbKZo5SY1xDs6547rbg4dDWnMrNjUAJMfa9A0sDzQ63G61AI+uXKerWrdKP0QQU69T0a
 b/rw==
X-Gm-Message-State: AOJu0YxgbNFaeHjGH+pkXxdd1uo9EiCtcp39j9KmLOOSRGKfA6vN5XB7
 sicJ0Dj79T6JHewwmXhzEejCXX/Ytqu0muEoAukQjsroP2F6DQ9ETnmsrma+fenjiagFH1cr7m+
 uflg=
X-Gm-Gg: ASbGncvnPI2KpSf2/fh52A1516JUemlMu+yYLwVWqlFG9ET36pGYIknHJATKksab07L
 jVWV4uFYuwtadU71jv+5qWshXyQhgUQj5g7Rrx8yV2/mVzMPc5lI5tsRfkGmd9evAIjNQPo5Vju
 sVNFxQTL8v4Cu+Oy12RfYPZrB5SUV3MvpM0qNGCXPdxzzaCnsoZ0oi8mV/SyblhehLaJQ2GFNiC
 pcescMrWXJp13lZRhXOFcehyKEZ4e44ujUUANW2aQBn/lsY94ABpEXhDLVzbYtV9tDvXSWGz4Wu
 Sj4J+gXhN9h+ML5xepYQ6hlcvpih410=
X-Google-Smtp-Source: AGHT+IGDQh7sqLDkc2QLaZ0GSwPbM0V08EB2udL67Ehux0mXvEuS6DmOnnY6wm0MAWiBtqfeO1riuA==
X-Received: by 2002:a05:600c:45c3:b0:436:aaf:7eb9 with SMTP id
 5b1f17b1804b1-436e26f4ae1mr102177955e9.20.1736524930526; 
 Fri, 10 Jan 2025 08:02:10 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e384054sm4880929f8f.36.2025.01.10.08.02.09
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 10 Jan 2025 08:02:10 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/9] hw/arm/stellaris: Link each board schematic
Date: Fri, 10 Jan 2025 17:01:56 +0100
Message-ID: <20250110160204.74997-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110160204.74997-1-philmd@linaro.org>
References: <20250110160204.74997-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

Board schematic is useful to corroborate GPIOs/IRQs wiring.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/stellaris.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 1bba96df14e..9b414ff9069 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1379,6 +1379,10 @@ static void lm3s6965evb_init(MachineState *machine)
     stellaris_init(machine, &stellaris_boards[1]);
 }
 
+/*
+ * Stellaris LM3S811 Evaluation Board Schematics:
+ * http://www.ti.com/lit/ug/symlink/spmu030.pdf
+ */
 static void lm3s811evb_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -1395,6 +1399,10 @@ static const TypeInfo lm3s811evb_type = {
     .class_init = lm3s811evb_class_init,
 };
 
+/*
+ * Stellaris: LM3S6965 Evaluation Board Schematics:
+ * http://www.ti.com/lit/ug/symlink/spmu029.pdf
+ */
 static void lm3s6965evb_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
-- 
2.47.1


