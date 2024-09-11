Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AE7EE49A0
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMKK-0005Vp-AD; Wed, 11 Sep 2024 08:20:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKI-0005QN-D0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:02 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKG-0007jp-Lu
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:02 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-374c8cef906so4598120f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057199; x=1726661999; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6lvY3blw8taGOv8uMXjSI2k81UcYL/RQBV/M9VGn4cw=;
 b=e1bQHUD1ApJ1QYEpee2yJW81zW+yuze7N1hebfppSraE4fuMiBSiGQIfKcmoMH+xY/
 ugSrpETbWUf5AbZHBqq/bI1eDhR/2pJvYdOHvnIF7w+iMJczZnps6JgF9kpJZbj5ntvL
 b0r5c/Ttp5jtaGLHbDd36L4kY6o2nR2q23V6EggoI/+qd2ByHq6LtJEwc5QFO9zb3K7m
 6k8x+D0RGCEfB5TpZktEGKTKNHWPVGlvruY0eHmjfja7KHDUBcewmqBKXrc6MpHmbPPU
 xc0lQe0Y0q7yQjjSSw/DI854HdMKByqs5Ug+nUyqZlLlGQ+ERZAIG67OBL/GEZlumbb8
 jP8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057199; x=1726661999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6lvY3blw8taGOv8uMXjSI2k81UcYL/RQBV/M9VGn4cw=;
 b=ApdA+Bal80qdl3ZI7dEOO94GQOhIibXNawH+OaMJfbC/8HHp/9swuZkZhe1Z7I5JRy
 NdEiEyQsRv3mEN3SlMTDbSorcmcKtdgHxWDLlBBViJq4jsO0mZWhFyKil0pS1LoLxMBy
 0h140D4OqFaqRXsdpshMcF57/87MddtEiCb4yJrqPnLMLlY1OKxn48luC3uvfxdDHJpR
 AzPnxUCunC1r8n5C51dDLOqJnOumVoizmxXi7nJR2x+obIbYqa7cWgdDh0+q+gNsZnFe
 i+f2ZIkjuOJbvgSzeHFxfHAgFJUrDd9znLpH+6cyUGTn4+QSzx9AtuwLh2btPdIqVDuK
 UKMw==
X-Gm-Message-State: AOJu0YzGX9NdY53Dz5Y70rWly5Q1eQLCVF1bl39JJy5XDP0eliYS6BcK
 YYCBrhGY6zCWeflRVZyD4M22wn3so7Ou7akbASIbVMBibJ4xlcw91XJEVyqHW7FRhQ2MIOgXXhe
 I
X-Google-Smtp-Source: AGHT+IHGeh7hJVNgGrE6vpjuk7nfiC4s22NEBVfXqfiyneSaO0T2dLkzC6zrCkEsm53UDpqwYcA40g==
X-Received: by 2002:adf:f089:0:b0:374:be28:d808 with SMTP id
 ffacd0b85a97d-378895cafdamr10872025f8f.20.1726057198776; 
 Wed, 11 Sep 2024 05:19:58 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37895649701sm11371421f8f.14.2024.09.11.05.19.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 49/56] hw/gpio: remove break after g_assert_not_reached()
Date: Wed, 11 Sep 2024 14:14:14 +0200
Message-ID: <20240911121422.52585-50-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-28-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/nrf51_gpio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/gpio/nrf51_gpio.c b/hw/gpio/nrf51_gpio.c
index ffc7dff796..f259be651e 100644
--- a/hw/gpio/nrf51_gpio.c
+++ b/hw/gpio/nrf51_gpio.c
@@ -40,7 +40,6 @@ static bool is_connected(uint32_t config, uint32_t level)
         break;
     default:
         g_assert_not_reached();
-        break;
     }
 
     return state;
-- 
2.45.2


