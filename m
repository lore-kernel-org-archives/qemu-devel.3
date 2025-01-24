Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81460C0218C
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 16:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbMYo-0004zP-U2; Fri, 24 Jan 2025 11:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYG-0003lv-IG
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:29:01 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tbMYB-0005OA-4S
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 11:28:58 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-43675b1155bso25526615e9.2
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 08:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737736128; x=1738340928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bk8UKy/5UtUVN5mexJL1A3Tm3jtSo3Xn1L8OQBTpPsg=;
 b=M1X7UkzjhmbvqqqHJUNt3OWJI789SnF2nCqj+jYz7tonNT9OgzONQHVibvZ/Z7dHOr
 KEFhVX1+NMRysusmCWIwIM9bR2huXtbN3HMFjpVIPzlwR31mP4symGWYlIg+S2/ErN/N
 taCaqWxvHuAFC+lgK8YARqT53n0no8MNqj+vLq5rc5sEwlgyd4AjPVLRc8zCIvF2WBjE
 ZV6hEjT2nKtv/UUH/faoQxAYA7PH/YQVSZLHluIhARJhS50hFZ/wWKT7jJKOgkNESZj2
 wPDpuovbxlWsXthiVAU3r6xdkb8Wz4W1JRyGy1fpqsEBvf8m0HgPp1P78vKuuTnmtj3/
 Ww0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737736128; x=1738340928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bk8UKy/5UtUVN5mexJL1A3Tm3jtSo3Xn1L8OQBTpPsg=;
 b=orC82laplUj67UX9N+rUZAwA/yKHxehVChZZ+Vkzho4EZW3+fRKgZ4FTTYKOLyaJVF
 ROuQrWN/C6a1GF5Y0T/Yc8SiNBNDcUgxqjlQ3YzSe2q3phum+iCrzKKcE9JTLAIlbPfC
 aHkbz/WE6h34z4qB3ZB+9ktUX3fg3qC1CsfL+tOVqI9pOLZ67kkbNBXKdt7rKkr/9Fnl
 qQjkWMqoShKieT7KkKhRUTz7ZHjg/irUBA1X5I2ITfft+ZodoWSE349w8cZuayJ9CIL3
 EJQTm3nBnwv84sV2Muu0pscfvXdamKFmuwuiYX7foK7z0AtyE695kVXs+1he+3HgXWTq
 1uZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAllmRpiUvVqL4EioetyocMlxTrB3idh76ZaeC/e/taySfvD1N9lldQTBuS7U76Hn8+eiD3zYanKxK@nongnu.org
X-Gm-Message-State: AOJu0Yxlj6tmhUsY5R29bYTXG/QcOGvOlK9Nn96Q/pNGMUhEaBoxLWTA
 PJz3vmJgeuAjnQz3aZs9wLuBG0Qexfhtk2UtMQMG9EB71PCDe9yiO6q9DPi/2geb6ozjJnFsupt
 s
X-Gm-Gg: ASbGnctrUX7Ka1WR8JCAW6AGLdpiyeNIjPseAxnCP9mWe/8BNE6ADHhQI4XHg9QynIr
 7ZdJXasPFCnNvGw71JVk75/RWrUQRGNDUSFWgsSQjh9K8MnGPFzZxj88bvM3CdRdVebAPY48cje
 Xqmuuje6OS+WE4N+nVqZ74MKMiuN+oa6VIVTbd3wz1RvTT4wmQb6nwFmmuX3VYUwvyMWi+Ev7mq
 OLBVGkQBiZIDxJH8WsNQBX15boSvRW72Fgm2ccoDp+N4oBvJO32MO3vvW5R6uKYmOn8G/jVhBsJ
 jvqU+3De6k0=
X-Google-Smtp-Source: AGHT+IG8l2S1clShI7sp8gv1QvE11uXrLVW4H9Jk+KwV/ZXdDefO8cmCGZBsXiWWPHzfqR28DQHdCw==
X-Received: by 2002:a05:600c:1da1:b0:434:a202:7a0d with SMTP id
 5b1f17b1804b1-4389141c227mr256881565e9.22.1737736128268; 
 Fri, 24 Jan 2025 08:28:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47eecasm31683025e9.6.2025.01.24.08.28.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 08:28:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 08/76] target/arm: Use fp_status_a32 in vjvct helper
Date: Fri, 24 Jan 2025 16:27:28 +0000
Message-Id: <20250124162836.2332150-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250124162836.2332150-1-peter.maydell@linaro.org>
References: <20250124162836.2332150-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Use fp_status_a32 in the vjcvt helper function; this is called only
from the A32/T32 decoder and is not used inside a
set_rmode/restore_rmode sequence.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/vfp_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 7475f97e0ce..0671ba3a88b 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -1144,7 +1144,7 @@ uint64_t HELPER(fjcvtzs)(float64 value, float_status *status)
 
 uint32_t HELPER(vjcvt)(float64 value, CPUARMState *env)
 {
-    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status);
+    uint64_t pair = HELPER(fjcvtzs)(value, &env->vfp.fp_status_a32);
     uint32_t result = pair;
     uint32_t z = (pair >> 32) == 0;
 
-- 
2.34.1


