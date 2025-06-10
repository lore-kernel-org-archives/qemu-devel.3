Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36FCAC5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 13:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyZ0-00084p-IR; Tue, 10 Jun 2025 08:58:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyY0-00075d-0J
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:48 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXy-0002fM-79
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:47 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so4539480f8f.3
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560264; x=1750165064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DoWnKErT6L5M/XOHBo7kM8xkl21t85uZpmhKzYCdWBM=;
 b=LkDQRj9WyLDWzUf0/H1x+b6tGRESsXKqeBzM6mcCYO6bc/aB8AYnT9KhtXL0Za1idO
 8HawYPbL7w7at+gnZhMg/EoNd1zyLWyA/CPKrpmU+kFRH3lSbKlH71sERpS5Nq7JX0fd
 bMvwmhfFCIJS9KiFProkz7ya+hCpFRvQDO0a6DEMOkS9Gj7fBaBSuvUKCHz7AXEpEYzd
 +mjuTNuvMJ/OMKKWVLmRbwgXtA5XlaX2x8YEjpzjyPHd4t51wd1THnL1CH91MYTwErut
 LPS5PIgUfE2vDo2wY+PNXWgfAnViTFaKS8/Wecc0QmQNPJg9oVwle5RGxvtaykDg9yoX
 CH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560264; x=1750165064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DoWnKErT6L5M/XOHBo7kM8xkl21t85uZpmhKzYCdWBM=;
 b=qtTaLMPHJApbotHE4++SGsxY6orXF+8yN2nbFX9MUl9ilKB1wbtJQ4XmzT+7D7FsET
 LkSnY9n4b/9Jap2VqMmpJhredRdfeSN1iuL5p0ENDJODNJCMB6LF/ISwjnzqFT63XUcS
 hac7USZhnQ36furFm4g2Jr2EKMTVqx0M3oLqqJkhU0VawM2CLpE7tjwpTDBscjSWXeXr
 I5DaZEmR/oJvwVcKuQUuO5kqkNMOlwrz4Nh/ipq7Ogf1awnXo5+OSMPtoVvPxWD5SZJ2
 f2IHOYwzk63R9TgHfeEOMyOYHAiTbI+r+g113B3VABDvJYV+kzpuI61d4IPdUulCOXNr
 uIAg==
X-Gm-Message-State: AOJu0YxkGOYUJ6rFQ2FYdXtlueilmXb0gBfPOHk3jOC9DVt+cotD388g
 xS98jiqJUtoRh2D5cCcyUS3vag9pfv+lTx7z7OisncWH9IKoqVKW5/+e+o2PfTHVJyzRGUNwNKs
 GDvL17KY=
X-Gm-Gg: ASbGncs1CS01XaqHnFbKKXDkiQTqRufEBhgKU9+Ob01hCxYF++Op52waIsslEtbIe0I
 vWE6WHteNu1d3wqIg/Cwaienu+Ag5N15PwdXwzQ2Ct7Z3WCKzU3+8TVq56zP0Ue8ZTFjexwV2t/
 +LbJbqco75Q3wQk4so7LAGfBlZbX25NNqDxuFUL5YmN3ZPN2nG+FbzeKlYOYoJLnelII5FAyXnW
 jl4TBcM/nDRwoyPJOVr8znc/0IOStxGn060nSMTF/46CTnXDJOBRE8+/rU200eljel27ogZe95/
 l34F+6+0V3LgTD6nSo4LSUnuHzWFsEQ0/w9Klh1YqgIWnE3mOoS3ZlxXHcjYVP/GSqWeTP89dCv
 liILJ6aI6LZFY5EnYpfzYTGey2YJnpK1CA0ON6DKWCA==
X-Google-Smtp-Source: AGHT+IE8BeYS6UuWieiSlLOgWOB1or8T9lzwDOsWAsX6e84yX7OH7NfWpGgPXmW0HTr6Xo6G0vXNIw==
X-Received: by 2002:a05:6000:4313:b0:3a5:25e4:264f with SMTP id
 ffacd0b85a97d-3a531cb01acmr14320750f8f.31.1749560264048; 
 Tue, 10 Jun 2025 05:57:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a532436863sm12477526f8f.52.2025.06.10.05.57.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Glenn Miles <milesg@linux.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 15/24] hw/gpio/pca9552: Avoid using g_newa()
Date: Tue, 10 Jun 2025 14:56:24 +0200
Message-ID: <20250610125633.24411-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

We have pin_count <= PCA955X_PIN_COUNT_MAX. Having
PCA955X_PIN_COUNT_MAX = 16, it is safe to explicitly
allocate the char buffer on the stack, without g_newa().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20250605193540.59874-2-philmd@linaro.org>
---
 hw/gpio/pca9552.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
index d65c0a2e90f..1e10238b2e0 100644
--- a/hw/gpio/pca9552.c
+++ b/hw/gpio/pca9552.c
@@ -76,7 +76,7 @@ static void pca955x_display_pins_status(PCA955xState *s,
         return;
     }
     if (trace_event_get_state_backends(TRACE_PCA955X_GPIO_STATUS)) {
-        char *buf = g_newa(char, k->pin_count + 1);
+        char buf[PCA955X_PIN_COUNT_MAX + 1];
 
         for (i = 0; i < k->pin_count; i++) {
             if (extract32(pins_status, i, 1)) {
-- 
2.49.0


