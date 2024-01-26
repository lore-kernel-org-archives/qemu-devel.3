Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97A8BC47DDF
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 14:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTNHG-0002JP-QW; Fri, 26 Jan 2024 09:33:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHC-0002F3-S9
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:50 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTNHA-0007sr-QI
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 09:33:50 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-337cf4ac600so482313f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 06:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706279627; x=1706884427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fI0vqBKhfwteSfpqeytU8U01fv4ToN4htezLoldNdvs=;
 b=sNl3UFpT7Hf7+MNWSqplgSGAit1vVweNpPau2JOFP+e0u+Ji8qJX601wob+qPQPat+
 fe5FjMU2RTAAA5F4VsPh5QjUGAVd5nqFEKH89YnJJwfBF7IlHVejuHqe2VBXQhgqnxP1
 yj/gl4ajRwx19Pysv5zaFgOO/+TLL71/6A5V5K1NmoLU/UKXHdpJ/8YcDayD5+begkGk
 y2UzHH4VK/4CzfkQWdkICGLTf8ODJ+sjbSRl+JqA75w8dxULX0nm9aKwT8kICCBtJQu+
 GyjbKJJ8RKB5s7gJsCg0nyqCQc319xd8mz3TlFneH2dGbO3E+oGsC78kP+1FE3KOQeqD
 g1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706279627; x=1706884427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fI0vqBKhfwteSfpqeytU8U01fv4ToN4htezLoldNdvs=;
 b=lapP21BIl3CQ6BCIc8Px9IqrRcGPsbCZf3PtXYE7EWnKHQo/4zauGurEM3ReCx1RTM
 d0qyeyM8xBh5d9ILkZeSb/rboGu9Bjr8cvpdp+20Q1SbmNMMjTPI+22/DgksDwfenTsW
 m6dHtLBJiFv3OYOF4vYjjLiNcAI21SdwcXHh5ze9Ie3uXe3zF0UYV6fRigAv2MQQkuAv
 FJslFXDFFYb2aTheC1WZiQs/pkvdh0ABFVI2dYkcASwxLcmt4tAMAceF6kpVCtlAzlXE
 rQASCzrktdPfSaurpvuDukYscCCAZ5US/VfNFM/l/w1joewR3493FtwpCeueezVDYIIy
 wSuA==
X-Gm-Message-State: AOJu0YxD5RKwi5xrcnlxsDDwOSdwCPZ/xfN9ZYpRbNf6NwNj+W6FzSp4
 j06levVTNMVcH7tpYGWrog/E18xbGMSXLgzreVxo4Kl1wk9eXgENWP9xNGVk4ar1K9G+dCGWVp/
 g
X-Google-Smtp-Source: AGHT+IGKMXqE4/LQMu87xBGIIHTlmQBVHx0bcptNPN7l4/BMpSzyxPN81AGiXxFmJeQKcEk9O2nsmQ==
X-Received: by 2002:adf:f54c:0:b0:337:bf75:1a3e with SMTP id
 j12-20020adff54c000000b00337bf751a3emr1124667wrp.37.1706279627552; 
 Fri, 26 Jan 2024 06:33:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 n5-20020a5d4845000000b00337f722e5ccsm1396207wrs.65.2024.01.26.06.33.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jan 2024 06:33:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/36] hw/arm/smmuv3: Include missing 'hw/registerfields.h'
 header
Date: Fri, 26 Jan 2024 14:33:17 +0000
Message-Id: <20240126143341.2101237-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240126143341.2101237-1-peter.maydell@linaro.org>
References: <20240126143341.2101237-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42f.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

hw/arm/smmuv3-internal.h uses the REG32() and FIELD()
macros defined in "hw/registerfields.h". Include it in
order to avoid when refactoring unrelated headers:

  In file included from ../../hw/arm/smmuv3.c:34:
  hw/arm/smmuv3-internal.h:36:28: error: expected identifier
  REG32(IDR0,                0x0)
                             ^
  hw/arm/smmuv3-internal.h:37:5: error: expected function body after function declarator
      FIELD(IDR0, S2P,         0 , 1)
      ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20240118200643.29037-4-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 6076025ad6a..e987bc4686b 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -21,6 +21,7 @@
 #ifndef HW_ARM_SMMUV3_INTERNAL_H
 #define HW_ARM_SMMUV3_INTERNAL_H
 
+#include "hw/registerfields.h"
 #include "hw/arm/smmu-common.h"
 
 typedef enum SMMUTranslationStatus {
-- 
2.34.1


