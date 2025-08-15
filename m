Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D64A5CA0EE6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJi-0003jf-37; Fri, 15 Aug 2025 05:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJY-0003fQ-8R; Fri, 15 Aug 2025 05:01:33 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJU-0005sH-Ta; Fri, 15 Aug 2025 05:01:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-45a1b05d252so11571845e9.1; 
 Fri, 15 Aug 2025 02:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248486; x=1755853286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fA3ZKHNVPuqOj4lzHOhYgKjjrfguGgf30UjQHR6LMd0=;
 b=lgb7WZxqG8xxlplsC8IlvBlL9S2L1Ff5jt42uXAGoXya2PxcgA74WU6XxHdCQMYXah
 OkKYpgPHNw1s56vibBalVVdx7ou5F/8k7tWlJalC6bdZHtjJ/MLjTgpgP6H+9aCd6arc
 E5r73fsY2dgrLzvRtcvUDpbhAVBVuvtcGTtxA5d9Va7QK8nuVh0u7GF3XR4ELKvtE/WE
 0XUardhCh5co4RRUIhqnIvw+LLiP4D9f+E1MFkNt7fJoBj/ls1hNdk6hEfvmRd7nAnM7
 xBf7CI9rzIpKhdqfUXz/w3v+HOZ4raschlUXaNJzHaHYBuU3KgbbNBBz+tjuoAZzfsXt
 K43w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248486; x=1755853286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fA3ZKHNVPuqOj4lzHOhYgKjjrfguGgf30UjQHR6LMd0=;
 b=s8hXdaHOo51o/xw/JsQsCZwQb6LygSHbX29mE0yNurBRkKB1g1JccDOfTZCWr59vLa
 hwjMHsG+egCKK0da7zdzgtWinW7o/qG9qvf/m9+EJHlnCY1XCYD4cVZi3zgpDWiDZfz4
 D6SyO2+A+PN63m/VHYe8f6vEBTfYjvMW/0ubehc7fHBncruHxxXoaFjgqA9tW4REJYPP
 LLmmfr2t1Hs/4a3L+CY23o3OUe909+lf5Fp6uSEDfhrPAoIqr47tMypQXSCCYyBC8/+0
 DMYRWudUsl829i3HklOAURq4+XrqOCRO8GdZAKpVh/amo0fcizos9+FUJLDXnKI8/nrr
 DHgw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSb0BA/ruKhMcVa4SjdOm5siavg8W5s3tedTuaH1NXEJUlsq6ZoMwdC4DhOHxWoF1ijmzcLqbMag==@nongnu.org,
 AJvYcCX6NS+a9T8QpF4pY4967SB6/tCyDZqeL29i/OyGZnrsekIlcZlbmz2T5dyDGGNblndgCIK2FM6zRv/6SQ==@nongnu.org
X-Gm-Message-State: AOJu0Yzsis+FbwPJpeTElyXiWILXwZ7YV1LJ0ZK3Dz/WUlcx199JP8+M
 TvZsQdHtyJJxYUqnmvvviYcytmFlkszxrnzgN9q4W2opbOexopSxaeyIzqKHoLfL
X-Gm-Gg: ASbGncse6WVnabNJJ1yhJCkzzHUG+eGCeQnGOCI4+5uTUwJDxiHHMblYA1FqmmAu8Vc
 9gqDGp0jMuZrYbJljXKcEL93s0FTx4KlIZRVxjkMv1ILuxJ8QJyKkFJg2cSJhEu3D24Qfc42Mh0
 wkB6izFvQ2aBGxEZTTvLTTQtMA1JiF+DMg0QmsJa2izYW9pBsw2rBDot+KlzINixyZDZEZJaL16
 8WJY8Ann8VV0uJtRdUhHGqyLHK6URnhQCABo5Dkb2x/tSxnnmHQjGW6tiqsp2l6DKhQl6f2hsy5
 CUeoRlCthOqAB2EP8QYtW+WttOryhY8AjkC4JtnxVyf7i7M7MsXh8cCNbxz/MPQsl6+oR0EQukX
 kQWo53Kgee40WDt+5HPmo6z/YUB8u9i6fpzP9HCq0G6yUzw==
X-Google-Smtp-Source: AGHT+IG0rfA9kCf8rmKcn7IU+1ebJmJbfuM+aTKEwcyQgBTWEggBMVkdntOxaIAVYxdHR23p96IN8A==
X-Received: by 2002:a05:600c:1c20:b0:456:1c4a:82b2 with SMTP id
 5b1f17b1804b1-45a21803dcemr15371895e9.10.1755248485848; 
 Fri, 15 Aug 2025 02:01:25 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:25 -0700 (PDT)
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
Subject: [PATCH v2 12/14] hw/block/m25p80: Add HAS_SR_TB flag for is25lp016d
Date: Fri, 15 Aug 2025 11:01:10 +0200
Message-ID: <20250815090113.141641-13-corvin.koehne@gmail.com>
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

The is25lp016d has 4 Block Write Protect Bits. BP3 specifies
whether the upper or lower range should be protected. Therefore,
we add the HAS_SR_TB flag to the is25lp016d flags.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/block/m25p80.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
index b84c6afb32..4c9d79ec44 100644
--- a/hw/block/m25p80.c
+++ b/hw/block/m25p80.c
@@ -217,7 +217,8 @@ static const FlashPartInfo known_devices[] = {
     /* ISSI */
     { INFO("is25lq040b",  0x9d4013,      0,  64 << 10,   8, ER_4K) },
     { INFO("is25lp080d",  0x9d6014,      0,  64 << 10,  16, ER_4K) },
-    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32, ER_4K) },
+    { INFO("is25lp016d",  0x9d6015,      0,  64 << 10,  32,
+           ER_4K | HAS_SR_TB) },
     { INFO("is25lp032",   0x9d6016,      0,  64 << 10,  64, ER_4K) },
     { INFO("is25lp064",   0x9d6017,      0,  64 << 10, 128, ER_4K) },
     { INFO("is25lp128",   0x9d6018,      0,  64 << 10, 256, ER_4K) },
-- 
2.50.1


