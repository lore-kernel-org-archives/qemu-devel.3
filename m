Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 563AFC25B5F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 May 2024 09:01:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6548-0004cp-TS; Sun, 12 May 2024 05:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s6546-0004cF-Sh; Sun, 12 May 2024 05:00:18 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rayhan.faizel@gmail.com>)
 id 1s6545-0000pz-AW; Sun, 12 May 2024 05:00:18 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a5a5cce2ce6so69198966b.3; 
 Sun, 12 May 2024 02:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715504414; x=1716109214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=s2HUUSV/R8kHZKSr121aPfLsWX8/+1NKAhwK3cedQig=;
 b=CnSae8VyhVRHxPbnvqPS6aYSGk5WL8H9EQMiX7YhegCcAvk7crL/JmfjLxmWXUsuQW
 zEp+i5/N8Mq4CsSO0dKt9oGIOq5SE7xgl1HaKYixaDqIfobMMjo0y9HZ1pXg6t50MD3x
 ryFB3Dx4lKjYyahOAYE7nfqY/5SrzntY5ibfCxqHIfry2OZ9R1seTKBCDFjvsR0V6XoU
 0cKE1gu3paasdceMA4Y15td+kB+4LLi1Wua8uv81OdZcd58Qhrj5lXOmu/zf35mxZ63H
 4FBZMqIZYkuuxUmdoYZZ2+uyeteqk7J0YMGzmscXvYP50eUPTwth4RIE2liNtFmQAx0A
 DDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715504414; x=1716109214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s2HUUSV/R8kHZKSr121aPfLsWX8/+1NKAhwK3cedQig=;
 b=ZQIn9J80SgWPwSzv8NSOY0pqeHGKdiz8ZPh83Zce/6PZtTAC3VkIRxluw8el2jOTr2
 TUX73tBiCwmCPqDE6LfSugKKQjWzqb1Eply820B8Gjy+WKu6XVZJKY8KkHxrSULuADUg
 gP0qzfY53Mhi6y9I0fVJSGX8GtKrqcZ3nQ+YdTldIXswGq1BnS7S6RZveFufQH5N1unT
 44DjWmldNirn/54MpWFWVcR8qSDIL43yUSlHSCEIwpwE6EQyc9TKOS4GcunQnYUX63xP
 LAYFXv0NjLbNp55WravYH2R6EM3YkEqTu56GPu+E4MAEDb34FfJjNfUPxvgM3QYz49uB
 apDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuPx01AfotSquAmMuIJXr8wnARAD6/2SJFI/L09AeA7kEXYUEOh0z/zIiIaYpo0hsDPhX8BSa0t7NWT0gDUOFqvsO6
X-Gm-Message-State: AOJu0YwPEenOnNTt/IeUlqmPFi5bETdFX4uFMq0o9cWQ90ekPqRlVdx7
 SsVflGG8Q8L30vpV8CX71Qc74YJ1u4Gx03B7zb9CIFsNzwfmsIJc+9spGw==
X-Google-Smtp-Source: AGHT+IF0TbT2N6rFBEBx9taO0of0xFoGS8TLGmiKYBj3TU6h0qZ8S8KIq2QNQQlclcsJ8lwvb4BdBQ==
X-Received: by 2002:a17:906:17c5:b0:a59:c9ad:bd26 with SMTP id
 a640c23a62f3a-a5a2d54c601mr431144566b.12.1715504413771; 
 Sun, 12 May 2024 02:00:13 -0700 (PDT)
Received: from localhost.localdomain ([212.70.119.223])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a1781cf9csm432214366b.7.2024.05.12.02.00.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 May 2024 02:00:13 -0700 (PDT)
From: Rayhan Faizel <rayhan.faizel@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Rayhan Faizel <rayhan.faizel@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org (open list:Raspberry Pi)
Subject: [PATCH] docs/system: Remove ADC from raspi documentation
Date: Sun, 12 May 2024 14:27:16 +0530
Message-Id: <20240512085716.222326-1-rayhan.faizel@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=rayhan.faizel@gmail.com; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

None of the RPi boards have ADC on-board. In real life, an external ADC chip
is required to operate on analog signals.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
---
 docs/system/arm/raspi.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index fbec1da6a1..44eec3f1c3 100644
--- a/docs/system/arm/raspi.rst
+++ b/docs/system/arm/raspi.rst
@@ -40,7 +40,6 @@ Implemented devices
 Missing devices
 ---------------
 
- * Analog to Digital Converter (ADC)
  * Pulse Width Modulation (PWM)
  * PCIE Root Port (raspi4b)
  * GENET Ethernet Controller (raspi4b)
-- 
2.34.1


