Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07246C77B7C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 19:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uX2ha-0008Tc-FE; Wed, 02 Jul 2025 15:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2hW-0008Jx-Pv
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uX2hQ-0003cC-Tm
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 15:00:58 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-451d6ade159so34443685e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 12:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751482850; x=1752087650; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRx7/96Mso9UmfpnJ3Y/UVAgu4AkhnN2JiUpQ3Sf7Yc=;
 b=hVmTT5QWWv0OxukJ+egmzz6EcKRX/PDekckngl/yU1i6HQVhFrR0Yb3NXiHUwn4FHL
 nIlQ71ecqW+ZtKkem3a6x62k3E6E3VrGYPr71o9HFSK0fiPKqcCNAZWao5MxSk0YJlU2
 EIXZN0Mou8DSMwnv7UVyAlku8CuMCFu/OMUmVO/Cz2vvWOnM+S1fZI0nM44NXZdEhFH6
 rztnDzWDh/fx6nKPJ3GMsR4bnC/fZIVS+JT+x0noUpBXrifjin2dzbSWE9SaT+TFCxaq
 PguZOGH0vsR4HIEMxCNnWR0evLg1anJW+MxYh6SPyknimpiYppqdGFggWfLIl1jHW45H
 lNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751482850; x=1752087650;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRx7/96Mso9UmfpnJ3Y/UVAgu4AkhnN2JiUpQ3Sf7Yc=;
 b=FsQCqPTrUe4L+Vg7RdEfCX11Znaz6lo55Pq03dxMi7BoUxtBjGDHZ2FFUrDosh4qap
 xQqhnq52kfcQ3CXAPtdWV39RHTjDZHrwSS1XpO6Wd8omDErjUgZm+lUuG7wU7z3imPz9
 5DN/9AnDCFSKHYc51TgT1KghSTWMCdQH5+vzs1HU4DMxxkxG7CikfwF6nAzdgtLKhKX1
 t/Rkx77svDY2w2FGgW8JJsu6E0m68TFMCKf3NVwCuPLeJFeKaY3Ba2JQV9zxpT7I/Qsh
 TwNyG9Iiy2SgB2D8j9YewepbLiGDJjz83Gay2hx0Xn/zIM8O4QrgYCk9UpKTYcyClk7x
 qb0g==
X-Gm-Message-State: AOJu0Yzqh0U1a+Cx88hMHy5gxpA4XsQcCyps1b9vleBBZVxWYos57pJR
 Z7CPNSwLSToXnx8re+j/D+OBgDIVxS6r2af10YT+N86GmPeqOFGaJ1kb39o2jH01l0KvHy3y2hN
 qO6AS
X-Gm-Gg: ASbGncu04CZtj69xdAMa4SuEUyz+H1W0UBxEffCC+ynx1AjnQ1N1nTc/bWaOsYA5W1g
 MiW2oOi6/KkexFx84hxIbfSw473uUZvZEpiJUMBEHXWhf1P2BdarzRLZ5chH6fAk5ekzekz7vi+
 MpvDl0x4iVVZkBxnkzxzGMvWmP91EMKQS7aZoRQzy1pQLVcyVW7zmjO49ck9O9rhZURdBq8Hzx9
 HLOXLjUAywbazpHZBwhyJW3IIUzM+R4yI9DTI1LxVA6dmZZe5k1llvMBWJXAfbiBFDDfBpkDtg/
 WH+OunYn8IXnzxbYKSJC6k0/CDuds6mI/1j4TTkp+CwAfNoU2VSdqPs0T7RGPwLAXbz0T+6zAa7
 MfQPQgVg00c6pQt0+2wiJPVJ4KzPLmGG8wlVU
X-Google-Smtp-Source: AGHT+IG4DC4uuDFCymsJ+/FV+tDN8gNO9K9ncPSXurLKCaKPAh75YjQlMO3bhSQ06P+dyCOnMdMx2A==
X-Received: by 2002:a05:600c:3b15:b0:453:66f:b96e with SMTP id
 5b1f17b1804b1-454a36e59e5mr37171125e9.11.1751482849766; 
 Wed, 02 Jul 2025 12:00:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a99666c3sm5944585e9.2.2025.07.02.12.00.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Jul 2025 12:00:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 65/65] accel/tcg: Unregister the RCU before exiting RR
 thread
Date: Wed,  2 Jul 2025 20:53:27 +0200
Message-ID: <20250702185332.43650-66-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250702185332.43650-1-philmd@linaro.org>
References: <20250702185332.43650-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Although unreachable, still unregister the RCU before exiting
the thread, as documented in "qemu/rcu.h":

 /*
  * Important !
  *
  * Each thread containing read-side critical sections must be registered
  * with rcu_register_thread() before calling rcu_read_lock().
  * rcu_unregister_thread() should be called before the thread exits.
  */

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index d976daa7319..0aa4ba393a4 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -313,6 +313,8 @@ static void *rr_cpu_thread_fn(void *arg)
         rr_deal_with_unplugged_cpus();
     }
 
+    rcu_unregister_thread();
+
     g_assert_not_reached();
 }
 
-- 
2.49.0


