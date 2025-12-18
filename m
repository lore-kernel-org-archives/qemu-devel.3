Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D4F2D6E2CC
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 18:21:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWIb0-0006WL-Fb; Thu, 18 Dec 2025 13:19:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIaP-0006P1-J6
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:19:01 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vWIaJ-00030E-OQ
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 13:18:46 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so6014575e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 10:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766081916; x=1766686716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ek0ZqoV7lcVrfafX0nJ7A9JZOJmPGubRBeO+HIeHC5Q=;
 b=ptCwowZOyQLojZP2vZ8h6hKy4P6jhHsp35Q1ANQ2V113B7Oi9cSPjBoD15rYSy0V6q
 DfyZIq7G9QC5F1SmxE0NE5pV8sP5JWstpHABig1ltMSfrkzaHOC48shSgQxtmGFSeWVs
 FIhTKFU6HHPDqoj2+eKqTsEna2EJGdw4VI9hE1cUB+U/SYC8x1g8GN5Mnqx3G5xGYV8j
 CTFwjAeK6rDVhhkBaU9AtDgWoh0rpXA8CTk1tNWWgETeCkwxHjRlm2MEwK35fIjebsWv
 7RNczGAQFHFOEhttB3UP9TVjZXiwIQP7BQHKEScIsXFO8jrVwRX1WN4PAiUxHjS/S/2R
 VMfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766081916; x=1766686716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ek0ZqoV7lcVrfafX0nJ7A9JZOJmPGubRBeO+HIeHC5Q=;
 b=pjmWey81CJC+fGjf978eSl9sK3wP2iYPaWH8leXSQku+lauCYHvric3mdeYCth+QRv
 9n8PPm5UAQ8ulYezra+hcz2wsrjQxaH+NLCg2U63EupxqFOTAqLSpOkLYqMX2/ZfhGWk
 CDtRRzVZp3+b7vpLAr+sHvXGH45igCSydkQRI+UoqMddfID+4y6JfDqezfazWe0jnjda
 CKFT25b4sO3rLzpKRHbUP2yExBlGVeAbvrqB3m+A3j6LoXdtOIATtY51BBUMBn8qc7vU
 kszQ2T0fAxJsNXmAdLpJleeEVcn3PnHkfCRlQdGhzZRaInfcqRhcjAYy5ejghXmIj6S2
 Rz9g==
X-Gm-Message-State: AOJu0YxvLKYi/jNiv5UfAMkRKqgJeHsu7GhoVkkYQjwAu1VaGdZd52uM
 HxUiZZWj23yV87XrVIEkXbLCz7CDGPb9iTTII0/WhA0TnYmpa2PUHX9/XsY2U97zkkIv5X0FzO2
 8lbrV1js=
X-Gm-Gg: AY/fxX5v6qBR2kxWRyA18df0VeqZh9koiq/8C3pYq0tzqIqsOM7kZ4P+2qfbE6Wu9D8
 PQ2N8ctVOG5hPOXMXI0jUV0FhP5RLax3EPF+Lgk6S5iEx7L9KARnl/wnG5sAaCyk0EXAaTJUIVW
 +JnKjw5QO6Ly0FkATa5A77VzEXu+/13Wh1dl00ry+MDt3SjQtYbfA9kdPaVulJktB04xxvrnlj3
 kyrXdy1NhLoUF/ZNdRAWPk6nPddB9INHIERw5K3np9yBDnwnKeT7IDGBJtZFYaOH2uiJSDm02yM
 CyCg86/lHxM8xBpcwf00hX9RW3qk4EI9xE1YyqalAiymY6mOx7Z08uNVSBoYpoMVvc9mRLZ3AIr
 kTTdGSo9C5Xc1j7MjvC6IBYvtloxO6iXxlMeODH1GhUAf+nBJPidyGdw/XDyee+8JpeHohxuFG5
 0dDDzjL/HWBkv7hwPxccaTZHSLFASAwlcjIU/4rht6lifmyXgXzcUc9OvBahZY
X-Google-Smtp-Source: AGHT+IG3rBj8MLgy5ArgGS6tuUNGiYQve0lqqiTO86Ek4KJMvYwdpNN/K3yJIGq4tWTBYEXioVJH2g==
X-Received: by 2002:a05:600c:8208:b0:46e:33b2:c8da with SMTP id
 5b1f17b1804b1-47d1958d960mr769485e9.32.1766081916568; 
 Thu, 18 Dec 2025 10:18:36 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be279c5f8sm52622545e9.9.2025.12.18.10.18.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 18 Dec 2025 10:18:35 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/6] hw/display/ati: Access host memory as little-endian
Date: Thu, 18 Dec 2025 19:18:08 +0100
Message-ID: <20251218181812.58363-4-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251218181812.58363-1-philmd@linaro.org>
References: <20251218181812.58363-1-philmd@linaro.org>
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

ati_2d.c is part of the ATI_VGA component, being built with
the hw/display/ati.c file. Commit 339534d4025 ("ati-vga: Fix
indexed access to video memory") made access to host memory
using little-endian order. Assume the same order is used for
the 2D component.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/display/ati_2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 309bb5ccb6c..72fde6b8008 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -221,7 +221,7 @@ void ati_2d_blt(ATIVGAState *s)
             for (y = 0; y < s->regs.dst_height; y++) {
                 i = dst_x * bypp + (dst_y + y) * dst_pitch;
                 for (x = 0; x < s->regs.dst_width; x++, i += bypp) {
-                    stn_he_p(&dst_bits[i], bypp, filler);
+                    stn_le_p(&dst_bits[i], bypp, filler);
                 }
             }
         }
-- 
2.52.0


