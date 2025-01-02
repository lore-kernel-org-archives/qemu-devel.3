Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813CAE77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 21:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTSaI-00044X-6d; Thu, 02 Jan 2025 16:18:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSa8-00040l-Ql
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:17 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTSa7-0001N1-9i
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 16:18:16 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-385de9f789cso8786960f8f.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 13:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735852693; x=1736457493; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFrtobX5dEs1+8eScAKkWEL068+5vqZlHD9HfY3Xigw=;
 b=qoFfRBOkUgjTk2l94gRw+R9DQ4aeyL16PZOxfIvJojzj+oq0Bc2KuwkN37aEbmE5dj
 O6GcLKp/OaB5roXIiSGQHGXopvv9l67M4XKgSyidAQR4lnL/vbPZ8RX7p7QRMhILYN9W
 XiBGq5HgoDhuD/CF3lKzrvWtYe9hVcqRgDb6gVYltxcItogBr1eEmHsKgOmmqIbv1PVJ
 QtiV6KrvEQuX71CQYBfcRT0RijjchdqthKdBw4NOoNQoejTSK1rxVrXXUoo1jbCBeu8K
 VAkmMw8OLtx8LMgjSRyHZnSeYvrdjA49ubqAQBdbyaRo944EZEqTqGk6LysepvcbWKtg
 TpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735852693; x=1736457493;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yFrtobX5dEs1+8eScAKkWEL068+5vqZlHD9HfY3Xigw=;
 b=YuF39WHRvO8yRBs4K2t5tpmuMaH8V+7veROzFFfUnqoS8TOt7fLHdFKz6/CChD9LdZ
 66B4as3JD136px6tyIaYTYwFgdHbghzDL9rrFnK7OHexNocSOU0gY2ZZTMTcB2kG7N2S
 efEr7Qhk6+xDr/Rlx+C7H27N8UvgejezJV7J99B8fp4wIANqRmaQDZcz0cUu4L6OrTrK
 0zZD01Uy31QtRd2kGdkf5ySAx+AAmD8D8tRfMOUjYx/z8ibJUroPTHFJbLdu2Dq9S0T9
 50ZAnakZ/Zg+Mq2syJXaGIahfBejaYaPJnLfA0pEff5+gq98rnH55d8yn1sPc19hHy4E
 PakA==
X-Gm-Message-State: AOJu0YzpkD/W0624dseD21+l07gRnytjon0VEEJmEYBfFdV93xhgkKD7
 xDee1Rb6cwqRoXDMCemF3/BaW2QvT0dIMzGDZE7Io5WlDo7s5TPSHogP73LoTB3894lFTV8vJys
 JinkBDA==
X-Gm-Gg: ASbGnctg24/2weYEiinQ9K77x4UuDHAq47P2XfXcXvL4VV5qpoJxVhKiwhsEtA/GRZy
 6oSDKrQ2t9cc78bJyDOoZMIOefJ8ixG7tVHrkhcwAthocyOsdSw4s3qT7eL+TXIbTIp3Us6WfUS
 364K0L0VRaBi2N92stUVwvT22k/AnxZXszdvBK57e4D36DA6j+gX9+E4idP8mDDC/ZOzmPzwjgB
 RGpeco1J2fFiC/ixHzRiOi3Dm3EK5gI3wE78xXzc5Bymz4Yosu317u+2jrUPZzRnlyh1Mwv1VWr
 st+yWhqvo/sBEF+S9A3jMr3/wvIib6U=
X-Google-Smtp-Source: AGHT+IGIXzLfZOWf7dhlRagncF8WRe4eO/6+e7WA7/thdiVR/TtjQ4FQR31nYplFbHHUuoWo9cTIHA==
X-Received: by 2002:a05:6000:4012:b0:385:f7d9:99f5 with SMTP id
 ffacd0b85a97d-38a224087b8mr37943617f8f.51.1735852692938; 
 Thu, 02 Jan 2025 13:18:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c89e4ebsm39336728f8f.85.2025.01.02.13.18.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Jan 2025 13:18:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH v4 2/8] qdev: Make qdev_get_machine() not use container_get()
Date: Thu,  2 Jan 2025 22:17:54 +0100
Message-ID: <20250102211800.79235-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102211800.79235-1-philmd@linaro.org>
References: <20250102211800.79235-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Peter Xu <peterx@redhat.com>

Currently, qdev_get_machine() has a slight misuse on container_get(), as
the helper says "get a container" but in reality the goal is to get the
machine object.  It is still a "container" but not strictly.

Note that it _may_ get a container (at "/machine") in our current unit test
of test-qdev-global-props.c before all these changes, but it's probably
unexpected and worked by accident.

Switch to an explicit object_resolve_path_component(), with a side benefit
that qdev_get_machine() can happen a lot, and we don't need to split the
string ("/machine") every time.  This also paves way for making the helper
container_get() never try to return a non-container at all.

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241121192202.4155849-9-peterx@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/qdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 57c1d9df3a7..bc5b60212a7 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -818,7 +818,12 @@ Object *qdev_get_machine(void)
     static Object *dev;
 
     if (dev == NULL) {
-        dev = container_get(object_get_root(), "/machine");
+        dev = object_resolve_path_component(object_get_root(), "machine");
+        /*
+         * Any call to this function before machine is created is treated
+         * as a programming error as of now.
+         */
+        assert(dev);
     }
 
     return dev;
-- 
2.47.1


