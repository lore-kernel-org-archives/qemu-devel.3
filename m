Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F7DC52D6F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 12:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbfvK-00034c-3f; Wed, 07 Aug 2024 08:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfvH-0002zT-6n
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:37:47 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbfvF-0004ic-MC
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 08:37:46 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-368584f9e36so919001f8f.2
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 05:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723034264; x=1723639064; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LV7ui2s92iWKf/QhDHe8ag1xXqJV4XRcoiSJcQR2FJ4=;
 b=cJRl/lVUHSUnSSTm3RCCU75/dxNNeI9w2S3WL2JsFO0Owya1ctHXBbvbtgpx5r++V7
 TZ8Y76qSvYkw1yes03E9X6BbwAbXgpcZmeGFDPI7iHzicC8RS7GeVBisLMjK2WpxJJge
 bF3OzQ84OEj4ZGbjsPleS/CSNGSEYUKSM3dUwFhtsV/0UlyBeC72+nl8tnXg8V+vjOPN
 J70aObZMxAPYoZyZgHrj89Ikvqken2L2V6hmfKMHI/lKns6enGA/YAZuw56yFf1YbO6n
 YggfZHBXLLBlQeN1/LGQFRq9W/4eRqQ+e2MYz/OL3dNHw3IpPrIH5fCTiN14ln/Uml7j
 Bnqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723034264; x=1723639064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LV7ui2s92iWKf/QhDHe8ag1xXqJV4XRcoiSJcQR2FJ4=;
 b=A7EoiXkwTEyaUrzfHUspD6kBmi0yTKqZJfRE/zXYhaQ072i3+HlRrpzhVkCyJjyGdo
 pJSQKLw/am2R8bPY4iry9bgqHsaPq+lxe4CtajHXPxagYCtDutT6SaADQe53aG0EI6yg
 unub5lIOkB3kza9osp7MagTEqQR/lBX6rHYplbeufWHPXbcsOtueEloEZD70iLQckEgE
 aIc7LhV0dLcdZ0cDon4ft1/NljKKOAN3IQUcI/Jw2JwIILjj5/EDkr71Xu4UsBr03j8c
 I15GZdWXfzOW7oheUxkHNce5ANH945Hhysw8R21QbcTz/RHXkDISKC5n8UV3/VVFoYHy
 9iFA==
X-Gm-Message-State: AOJu0YznoHHnciAcqtxlU+Lc2w6n2SoN1EVwIChdGBx8ArzRZFwIQIN1
 c6jaxlwZBeb24qXuigBaZuVAq12TgA8UnKssiP7c6Tnl/gfK+gZQgWKVBm3sd8UjrCrYM5k6Pah
 O
X-Google-Smtp-Source: AGHT+IEy0cz40CYXDlX7Ts4ZbeotYcR3pKnJpBxkdqMc5BpcCpU2QtSnXGIhF1VTVF0eCb6UnujW4g==
X-Received: by 2002:adf:f792:0:b0:360:9bf5:1eab with SMTP id
 ffacd0b85a97d-36bbc0ecfeamr11358681f8f.36.1723034263586; 
 Wed, 07 Aug 2024 05:37:43 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf1e0bcsm15820183f8f.30.2024.08.07.05.37.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 05:37:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v2 1/4] linux-user: Display sockaddr buffer as pointer
Date: Wed,  7 Aug 2024 14:37:31 +0200
Message-ID: <20240807123734.52501-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807123734.52501-1-philmd@linaro.org>
References: <20240807123734.52501-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Rather than 'raw param', display as pointer to get
"NULL" instead of "0x00000000". Remove spurious space.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/strace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b4d1098170..80f64ff40c 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -434,9 +434,9 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
         }
         unlock_user(sa, addr, 0);
     } else {
-        print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
+        print_pointer(addr, 1);
     }
-    qemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
+    qemu_log(","TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
 }
 
 static void
-- 
2.45.2


