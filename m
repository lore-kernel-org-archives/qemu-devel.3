Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6210CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 22:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEED1-0004LG-A5; Wed, 29 Oct 2025 17:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEECx-0004JH-7V
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:59:55 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEECo-00005X-OA
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:59:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso3618545e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761775178; x=1762379978; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Om77k056XpbEIuSnFj8sNIzaZIBQ5Vhk3FyzV1fN32k=;
 b=yHd2VHFwgPg4GgFLhCusbsNGPMgvauRUyLu8J/TPCwcl7bQTiodPlUZ+ZHPsxBduQt
 XeYwcdZux3ombwhA5by0C3n4k4zy1Hfr55Ad977bfWDauBjbLFUxZy5GLNYf3Qe3136s
 H8jzIRNgDtiK3msckJfnAyMbwbKMVgI7AP7+T3L2t1Q6UAbTLeMPDweEYkxfVDLFuWgV
 8Ch/6wLx8Fc3azo/4QYcoi8EEhmKQpW9WafOcJP9aQd+NCiauirm+aMW8ZQj7acE6ff6
 rHqJlUChtDAnZWznpdSM3M220gLI18KBbjckrKSS0BbWBC3uUIIInrIb7g4JZ3bXV96z
 wcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761775178; x=1762379978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Om77k056XpbEIuSnFj8sNIzaZIBQ5Vhk3FyzV1fN32k=;
 b=Ftttk+tlq4LJxtaN3ueGbepK8SLjGWOnm8VVLfd/buIGkDG444bmm7cV4GuXvKZOzZ
 UZCcbTwT6W6XnQGz/Ioe1xKq7APdULnk9HpvMmnHHVksvdlJcAnnwrsEYo5J55OTy8z4
 SMzzurNfBA8TopS1dgqOXEVK7pxswL7QdrLhUisksHpe04Uy0uVNGl9KM/ebuhrhfFd+
 p/e2ERUFyPLol7OT0Wz1OfQD2gzwMb5/aRIiVo/s5YacorYjBlDdWlbZ8ZG6ujd9bwVW
 fSjPPWpmU9IwAvmTFAe8XwgHoSMvjmZTxberotpwLwXlANdb16RwU7EyhaWQSQOHPq7k
 3VAg==
X-Gm-Message-State: AOJu0YwKOPGjxzJDkYn3O0XiEhoY+C7fzPR3hUbhutpE4T1hrptFXebf
 YG3S7tdImJ5Cz38o6EQXGSJdu92XT4lMvDM95jbU650YcHDzjMQcx61j9IrZpjAKQFb8FHzWjg1
 acuGO4uo=
X-Gm-Gg: ASbGncv6eR3nXeocw0ngiSJKGwnsfeqraVtdYjxpkumTNFyBK3/zcQ/tEYv81eGHImn
 lNwMBFOD+f0kxCqEdxRw3WWmNvUxniUxUh1SOU8MeANJGz+seL666kXy9vE3YafncpgqTHouPEL
 1Aiw1SVhJiTo0Jo124XVoAzznNJ2czmRg0h3IE5I1akraAwNX5zKN/BbSYR5w1T/CEyv5kkId6Q
 N4S3aUo9INKylV4DiU5zZhFD+jlhBPW3X6gudml8EJudnT1y93/YawEuzJi0WnhhMo9cQ7PGR+4
 jk9GHZvyqGa78oBC4MgKBuOVXzAqBLXKyZOVOGXHPPxV9v1qiwPtOfvaluEZtlkpP4KJYT5klY1
 OK/bck5t/7jTf2vamyt6VJEp6XZWm5YXDYm/w0h6IOd8RrY3jJxK2PpQreGklS6zw3H8LRYwsvX
 6Ocind+BXNTvxUxXNxawYBaf/XGZDiCioeUc3y1rTBDT5Yi8Nt9A==
X-Google-Smtp-Source: AGHT+IEWk0+NwkbvYXS4vcOXkXrHkKtBCtQiFW790Ow8S2NcP7Quu/vxgFXw9rYjI/g4XqIi6rXaQw==
X-Received: by 2002:a05:600c:474f:b0:477:df3:1453 with SMTP id
 5b1f17b1804b1-4771e1ed170mr45259665e9.28.1761775178572; 
 Wed, 29 Oct 2025 14:59:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477289a5932sm4827725e9.6.2025.10.29.14.59.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Oct 2025 14:59:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PULL 19/23] hw/arm/meson: Move Xen files to arm_common_ss[]
Date: Wed, 29 Oct 2025 22:39:56 +0100
Message-ID: <20251029214001.99824-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029214001.99824-1-philmd@linaro.org>
References: <20251029214001.99824-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20251021210655.59278-1-philmd@linaro.org>
---
 hw/arm/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 9fbbbc9a6fe..61c66ee2d0b 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -65,7 +65,7 @@ arm_common_ss.add(when: 'CONFIG_FSL_IMX8MP_EVK', if_true: files('imx8mp-evk.c'))
 arm_common_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmuv3.c'))
 arm_common_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
 arm_common_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
-arm_ss.add(when: 'CONFIG_XEN', if_true: files(
+arm_common_ss.add(when: 'CONFIG_XEN', if_true: files(
   'xen-stubs.c',
   'xen-pvh.c',
 ))
-- 
2.51.0


