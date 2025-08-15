Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C04CA0EE4
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:02:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJS-0003aM-Rw; Fri, 15 Aug 2025 05:01:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJO-0003Y9-SO; Fri, 15 Aug 2025 05:01:23 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJM-0005bz-WD; Fri, 15 Aug 2025 05:01:22 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45a23def5f2so566665e9.0; 
 Fri, 15 Aug 2025 02:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248478; x=1755853278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IhEYTkw9kQ7NyHSTO//2vzqheMEFMkjFgww9i9v8pPg=;
 b=iY04MioIrtrgDK0KlSkYfaIS5g23pZVKDZswoP6B4CQf5GJ1vLsAwKi3wXBOuVLvng
 kryk/H+Z30MACK9EujxhBzCtdGnW1TfNk4hEmidvMH+KDLK8QgtL5ADil1/xXzlMT6kU
 7VJ5rcdoro2X5sXJEY6SeMwfekJCKet3MM8N1521YekKlnm+Yyqe56a0jW9YUFKZUi5v
 z90z03AhxYLfnTCQsSKdsMN+UFCq81KfGmkLSfw3uP9kBHQcdoySmsHjVJLBw/LTctLK
 OB4OsfzbnvmlWc8uRQBn6q3j21gVSKenDSaXLCFNXXDLf0ILFFaCCiZdQEKyy70vHeJi
 bk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248479; x=1755853279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IhEYTkw9kQ7NyHSTO//2vzqheMEFMkjFgww9i9v8pPg=;
 b=IvLCYFRzX7Q/QDNNF36+9bDaYUwTaOCzHrpbWBkC5D2cgGpXV6Ja51PI0Jer+1WpDa
 hjNXwMBzyv7FHCQhNYGluSsgqFoVToH8oeQdmMwm4sUijMDnZiHG+9BwUYTjYBvwxZLX
 PBs4Kk+B6oZUhSXcepRYWlfQ27Q4+miMO30MwGejN4IYFTZKCdJf5gVZSLStxY5OOWW8
 GJf9M46OkuM9Ek3S61R1096TLbaFdElscFx1866Dp6lPDHW9TkRBizESXphXn2rnbfCw
 bvGNhU86R2XNO7poNAwV+WYovdd42cvDKFQTVYNUj6KfVjAnhOb+avUr1xeDkFignfI3
 rCUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdcZYDhzo9wOJkHw3D72z1CvyN4gxSVU7J3B0BSpR7sI8U1g7MC0vJPPoztAfLgFblaIzCl4ju3g==@nongnu.org,
 AJvYcCXKg5q/uLG4cZUHRcfEAyA9zjskk0He/3oTYIx6C4xCQhFGrjbrGaT4RHNs3WR/6K223fogdiIU4yNyyA==@nongnu.org
X-Gm-Message-State: AOJu0Yyu84yrRWF8rY2UVULpauGYBMXqdLVsN0Pald7JydqSX8ZgHBA2
 KZ/8wmlVIqtr6lVLbFXWiV6MdYk77m0A5CMi4uym4/TSN9bzoBL95BQ7QWOLM4Ex
X-Gm-Gg: ASbGncth32VaZHX/VY2vVxtPbRiwLqqjg675gUxXp6h8mKQpPoeWpGf76rt5mGJ9tVR
 LFOBYrKSgbFd59TkSEVwZeFz4FuVz3dQjP1L5kLgvs1HZiqEhHoJ/sFrlpAoYOm+4A9Zzl+vzhC
 UMzWbqwewK6h1th4IGiBxkfQ/tLXer+bJWYlt9Yf2nepUJ20rLbfAZOH0WWpaI2aawj6F+plPxH
 f/otGB8Uz/gWJ5RsKgHPCWUwtu3sZHHAaYFsNyWUCzpd21JB3rsInnK/5n1rgA5yPbGFtTd8ADR
 RoHMkuwunRvvsoze6fVRUtmGQrav4624VDAggcHamOK+1EKRv7agIgN7cO+qGlccVQlsaPn09db
 sDJ7l4qL8tNBN+v7X8QaGt4AWB7+2RXBaAmPeAWC39mtCVbgHkPNxwF+9
X-Google-Smtp-Source: AGHT+IE9i+SKH69ORcy9a4Uc1F3lEUI3YK5lZDD787F83RYQZtWsJ3gcvXakg0jjneOrm0tbuHURkw==
X-Received: by 2002:a05:600c:c8c:b0:456:fdd:6030 with SMTP id
 5b1f17b1804b1-45a21839acemr13029895e9.19.1755248478515; 
 Fri, 15 Aug 2025 02:01:18 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:18 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v2 04/14] hw/arm/zynq-devcfg: Prevent unintended unlock during
 initialization
Date: Fri, 15 Aug 2025 11:01:02 +0200
Message-ID: <20250815090113.141641-5-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

During the emulation startup, all registers are reset, which triggers the
`r_unlock_post_write` function with a value of 0. This led to an
unintended memory access disable, making the devcfg unusable.

During startup, the memory space no longer gets locked.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index b838c1c0d0..f28d0015e6 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -221,7 +221,9 @@ static void r_unlock_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
     const char *device_prefix = object_get_typename(OBJECT(s));
-
+    if (device_is_in_reset(DEVICE(s))) {
+        return;
+    }
     if (val == R_UNLOCK_MAGIC) {
         DB_PRINT("successful unlock\n");
         s->regs[R_CTRL] |= R_CTRL_PCAP_PR_MASK;
-- 
2.50.1


