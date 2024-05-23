Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B07CCC25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 15:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAATe-00081O-Sp; Thu, 23 May 2024 11:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATU-0007pz-HK
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sAATJ-0002Sg-3h
 for qemu-devel@nongnu.org; Thu, 23 May 2024 11:35:14 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-351da5838fcso6034264f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 08:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716478511; x=1717083311; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yISSHG5pyQA29zkBCoQV4o7C+tL/0qrYSueTe3e1ZIE=;
 b=YWl+jgwKNAJM4I7mZrybC75c+bXaA+ZvGA4W8Qh/IahKXTq4tGS9oaj2zDhWiHOjPG
 jEt3cpOyLiQ8ZXQPVofg5EwCvhWMgwaBRnhl0R/aRKX2G2lYR2zqo9anunFslfJB4RQH
 atJVIlPqPo27x//CmkFLzmp45a9Bey1faGt8tL/G3FpLPE12PBEtZbIBguvKJivNp7LC
 Guxiu677kdLymZsiVKymu/16jaA7OLej59ckvvQGB1mPNmklJFZIlZV7gIamhIvcDUcf
 Hg+Un9TF/CkKPy94Qyoq+CfpCUHhwbiKeea9oLWXZGnXOhJhL9prmiQA24efxi17Z1jt
 zpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716478511; x=1717083311;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yISSHG5pyQA29zkBCoQV4o7C+tL/0qrYSueTe3e1ZIE=;
 b=AUmiW9VKs0R77GjbSLqrnKeUn/xpuLZ2iVqJtzooWjoia9a0Y+7A6F4YMB/eXrmE7M
 JkDw5beVvESuFwpvaw6YcRjZenGIg7YWN0utjPv7wk87ZB0Lj6EF1k0tunOhJhJJgM42
 3O6skweNpKZQ+kWO1d9xMnGbHCaL4Y4ODbY+W1VL8qNYf2EqxlT4frTyfRgNTR2j7B9H
 j8xmeYps9vBcYU5OQM7y3SqHYYbonsDbMry1kNW34yH1KwPGBgYfrEOlCkKOM7dpQ5Ix
 1Q/TRkjrlSWAgnVD5zmVXILV0tFY57H2SGuuWTd3cDRmbeLXWwgvfFEJbSkj4Nt8In4B
 2kNw==
X-Gm-Message-State: AOJu0Yzvbo0rQsC2qhKChmBljqddVYbFEL/seMbQwO/p1NdtcR92i3Q0
 K0hR+7TPDJnzvW+IBNmjtWySdHvMFuQvLPYDtNCzbgEgBuSB4wV39gL2712gVG10yUTLo4gh7P5
 n
X-Google-Smtp-Source: AGHT+IE1L6UMy5UbzS2d/S8PreYslIaKT2C7Mjz8FSKVe8Sfts4VCh1CkA3iu0JekInbaw1OhwgMdA==
X-Received: by 2002:a05:6000:4011:b0:354:e0e8:e8bd with SMTP id
 ffacd0b85a97d-354e0e8e9a1mr4251692f8f.49.1716478511073; 
 Thu, 23 May 2024 08:35:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-354df9b51f7sm3888255f8f.59.2024.05.23.08.35.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 May 2024 08:35:10 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/37] docs/system: Remove ADC from raspi documentation
Date: Thu, 23 May 2024 16:34:36 +0100
Message-Id: <20240523153505.2900433-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240523153505.2900433-1-peter.maydell@linaro.org>
References: <20240523153505.2900433-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Rayhan Faizel <rayhan.faizel@gmail.com>

None of the RPi boards have ADC on-board. In real life, an external ADC chip
is required to operate on analog signals.

Signed-off-by: Rayhan Faizel <rayhan.faizel@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240512085716.222326-1-rayhan.faizel@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/raspi.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/docs/system/arm/raspi.rst b/docs/system/arm/raspi.rst
index fbec1da6a1e..44eec3f1c33 100644
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


