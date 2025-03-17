Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A131C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:22:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCHO-0000Vu-R4; Mon, 17 Mar 2025 11:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuCHK-0000Ue-91
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:21:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tuCHH-0002bO-VL
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:21:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742224878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FrM1yGcdPBxGotEaB8in1nzGMu9ufRO6SSao+aFwRPA=;
 b=OHk+dv/QBQkWKOcbmAAl5pIcnHLP1iUM+yUWmGea0FF6hPqvdi2WAmthZW60/2NJKq530u
 g7lwtlQXBNjfNqfzb7A6pWSdRzSSMTJnQilWUwhWJ1pdhZ3qwEwbsElorvxHvG7XMYb9Su
 roBv2cMoxD9zJ+MjB7B8YygZq3rnKDg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-367-UtBuDhInORCqjzvPd1tG5Q-1; Mon, 17 Mar 2025 11:21:17 -0400
X-MC-Unique: UtBuDhInORCqjzvPd1tG5Q-1
X-Mimecast-MFC-AGG-ID: UtBuDhInORCqjzvPd1tG5Q_1742224876
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-39141ffa913so2746394f8f.2
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:21:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742224875; x=1742829675;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrM1yGcdPBxGotEaB8in1nzGMu9ufRO6SSao+aFwRPA=;
 b=peTT62ztkTbQ800YpEp4JH/O0FHfM4vo/EB60pfnr3N2ACAWtRLnYUJj9kqSlXVoEj
 iAlqSdVFaSH7cGpZ2EY8ww1y2SdMgDf3TJIosF+dcmuSlmN4wSZG16A75AeEmmKkSqJz
 oqu2Xf2fFoY4P0Z2EKG7TX9DU/wTdJmJEfdtWTltieIcsaDUrzbLeDlCL2Oi77tMzPNY
 zZnqhrXDS4AkqbWQgmWJKNtPnmimvZ6+KG7slIavHzfTM1rBgoNZv3tydJ2Kes9WNMBl
 UVAEvunktDnmTdeEtcGyVfTlcjZAgWQSP6j8A030pdj1XAsGkcHwD8g91oNeR6A9Yk15
 dnMw==
X-Gm-Message-State: AOJu0YzfX0eqezn+kn7Mp6jeWchkjuo4Lwi14JV1u3UwwDU6OEb9oV2F
 ocJ+AZEduQmFVWjuCbT7g8hCLl/9/j+2tYneIPu7l2mATdiHZeOJqLa7nNqQav5daA06AWWHuLS
 23QV5hnPbABqRneNSTgQu6zkx0588hOLfUaWlrl7DyPEkyDgVZroi2YH/DcyJuAMymJS5VZCWG/
 GQbs3SA4zwsvy0ylIg4vsQ4+yQbnupp3tFvgIc
X-Gm-Gg: ASbGncv1BVbZ8aLblyIT/WP/zqV8MYFyQT+RzD07evHtHUmKQfk6cokNWXgVKalJx9a
 uSPls/fEGoGwoInwp5mhZUehWBkTJIFi7bNPR13RKXX5RRqUoszOGrECBACSdJbJYR6tVnsz8Pu
 3G9AMRbS27wfjcEPlKY6jJ0aqpsLc9oNPEjtDD/In/AZBF6hkFXH4GlhqCoem9mNZYl3ELlwIud
 Su3GpdfZxVwJhz+V/QJ4RrC7rHq2IMRSqwuk5MYTbVIz5/lonSZLnPm2v/hgIuX9wjDXJAI2lYP
 Tm9wpsRy31gQQmRl4wr3
X-Received: by 2002:a5d:6d88:0:b0:391:2a9a:47a3 with SMTP id
 ffacd0b85a97d-3971a873726mr16774014f8f.0.1742224875159; 
 Mon, 17 Mar 2025 08:21:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENGTwWIxiV9SgD23AgGGcyTx6enDHf8vpM/+zFghby0t0QzoVpM0XIUIqGErqjD7AcHw6tDA==
X-Received: by 2002:a5d:6d88:0:b0:391:2a9a:47a3 with SMTP id
 ffacd0b85a97d-3971a873726mr16773982f8f.0.1742224874733; 
 Mon, 17 Mar 2025 08:21:14 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.194.153])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395cb7ec14bsm15213620f8f.100.2025.03.17.08.21.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Mar 2025 08:21:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tigran Sogomonian <tsogomonian@astralinux.ru>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 1/2] hw/misc: use extract64 instead of 1 << i
Date: Mon, 17 Mar 2025 16:21:10 +0100
Message-ID: <20250317152111.316627-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250317152111.316627-1-pbonzini@redhat.com>
References: <20250317152111.316627-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.335,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Tigran Sogomonian <tsogomonian@astralinux.ru>

1 << i is casted to uint64_t while bitwise and with val.
So this value may become 0xffffffff80000000 but only
31th "start" bit is required.
Use the bitfield extract() API instead.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Tigran Sogomonian <tsogomonian@astralinux.ru>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Link: https://lore.kernel.org/r/20241227104618.2526-1-tsogomonian@astralinux.ru
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/mps2-fpgaio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/misc/mps2-fpgaio.c b/hw/misc/mps2-fpgaio.c
index d07568248d6..04a3da5db05 100644
--- a/hw/misc/mps2-fpgaio.c
+++ b/hw/misc/mps2-fpgaio.c
@@ -198,7 +198,7 @@ static void mps2_fpgaio_write(void *opaque, hwaddr offset, uint64_t value,
 
             s->led0 = value & MAKE_64BIT_MASK(0, s->num_leds);
             for (i = 0; i < s->num_leds; i++) {
-                led_set_state(s->led[i], value & (1 << i));
+                led_set_state(s->led[i], extract64(value, i, 1));
             }
         }
         break;
-- 
2.48.1


