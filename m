Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF59C71131
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 16:46:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uP26k-0001oM-0k; Tue, 10 Jun 2025 12:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYV-0007q9-Mm
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:24 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyYT-0002iQ-Su
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:58:19 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so3661082f8f.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560296; x=1750165096; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A3Oij2wAJHxFSCwJ/UgKqeI+OINtKkC72w/X63N9vJw=;
 b=eu+4GTOtHQndnee6G9Yq9tJ6iolOFHTQfp9OI9PwwFaPXmAojmjjpeP+EZt6kYalBu
 L4eBSu7cEWQs5VrWRYRbUkQRpbIdQab4HWQW3mPtHXpjxpHZ5v0gwZJGHrMYbDdpCCc4
 lpPHtLSxTpHNKoX4Jn/WygVPMgRyER3TFu7TO+mT82yHi1ZthSlkeaZN8Ek3QuW67Kdu
 4ewzZoFagmWNbivDhjdihlIRRgicMgsEGALGZNyKTF9lPUJBWOWAFIxJEgIcdk46Np3b
 D3/10RJFPbzQBaUhh7zdZmACnb5Hn35W6t485hhhfsOa4ahxiS7TwoLj9TBTqYsBc6tP
 7MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560296; x=1750165096;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A3Oij2wAJHxFSCwJ/UgKqeI+OINtKkC72w/X63N9vJw=;
 b=IYuZm6YJ7JH+BfG4TQbD+UKH24Le+wwJ9mEspFDF6apvK6td9NaEd4qIt6/6mLQtP6
 hA/Hs4FcnMRoNECN+6XHB1zh58wB3XXSJEB3Uszgw9UFWzCxqDU9Of3IKgcqf3xGLGEk
 g36xbLQ9LNsOJGGDW1G2/xJSWYONx5eh5l/ViTW4RsIuFkZ93zKiusYMI96tnp70kKPb
 vDlWlixyUewBuazDsDZNfpbYKHnX4etDT/WL4vxTD90EkYoCH86ALMR8IgqECV7STXrF
 9ioeRPECV18uVM0EteK8yV2f/fik3jmqUvi8g8uXSY/2g/FKhfdmyjVGI1YtKjSdqiE+
 CghA==
X-Gm-Message-State: AOJu0YwWpf22xRHZIoblAqs529F1PkBKU4LhoP6tlOgLe3PFWElQ78/h
 9CG/R4HiHYiMOlP/7HsOKAgj6NtrH6yN3LD/rvByxz9I7bFCyWxvSvK5a1ByzJQt/JFgaDpQ2Fr
 yJxbnRqw=
X-Gm-Gg: ASbGncvOfvuaxh256Q4K4xJ49UYR3Jx5mHtoaGutF8EF9TO8fzGThfG1qvQsXlbTtWC
 V6vDoyy1nJaGKNzvcubN42xLGR/oJ9n+MiM8DxREnZ174A4pf8Vs7GOwYLCWvtsoqb3imQ0cd+l
 KgNVRupzx08q0SFoaiNy7CTcmGkfQQTAZud0gQqDUjACBjMiY0R7Fm6COWZtVq9dtjH33kesDJU
 E4L/wkT0jVm9e80Wuxpq5VUe6KJS1zj12ODel5OpepPtrJYWI0lLYXecx4DnYMCyuCsnBFeAN7M
 1cuV3zZDaUqY/RF1oPoiKrAUsf03g/q9FmGh2QE6Nxt1ce7BMaz7po5062d1IADGo0xMhMICyMc
 f3GvRuTTyhMSfkCS68NJRksjjl+vbg4QGxBA9Thh/fg==
X-Google-Smtp-Source: AGHT+IG6Llm5e+xhsmpxlmVTg7DJnFCKRu7sKeL4oYKS68CqW2q0aZbeCBBN5YGAoyMj2/iOKdN0xA==
X-Received: by 2002:a05:6000:40c7:b0:3a4:f70d:8673 with SMTP id
 ffacd0b85a97d-3a5318855efmr14340134f8f.25.1749560295834; 
 Tue, 10 Jun 2025 05:58:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229de7csm12417949f8f.14.2025.06.10.05.58.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:58:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Philippe Michaud-Boudreault <philmb3487@proton.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/24] hw/misc/stm32_rcc: Fix stm32_rcc_write() arguments order
Date: Tue, 10 Jun 2025 14:56:31 +0200
Message-ID: <20250610125633.24411-23-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: Philippe Michaud-Boudreault <philmb3487@proton.me>

The tracing function for the write case incorrectly has
parameters switched around. So order them in the correct way.

Signed-off-by: Philippe Michaud-Boudreault <philmb3487@proton.me>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <HnyjTNqwrfGusE44bnM7kuLuj13Di1VgXN-dXVHMOSnfgCUhoipOVIoVS1WQaKrJxmEDy9XJGdlQj6zVTIdJE0QVlfBhfbcckFFWRRP56uY=@proton.me>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/misc/stm32_rcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/stm32_rcc.c b/hw/misc/stm32_rcc.c
index 94e8dae441c..5815b3efa54 100644
--- a/hw/misc/stm32_rcc.c
+++ b/hw/misc/stm32_rcc.c
@@ -60,7 +60,7 @@ static void stm32_rcc_write(void *opaque, hwaddr addr,
     uint32_t value = val64;
     uint32_t prev_value, new_value, irq_offset;
 
-    trace_stm32_rcc_write(value, addr);
+    trace_stm32_rcc_write(addr, value);
 
     if (addr > STM32_RCC_DCKCFGR2) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%"HWADDR_PRIx"\n",
-- 
2.49.0


