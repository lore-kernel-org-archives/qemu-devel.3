Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46588CD6E6E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 03:29:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUcHz-0006ay-4O; Tue, 02 Jun 2026 23:29:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHx-0006YI-1u
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:05 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wUcHu-0003Zq-GN
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 23:29:04 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-84229481d44so1475882b3a.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 20:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780457341; x=1781062141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMKShQuAK58R/9FBdHpTIimQtn7JKRLF6OWG4SPVFxo=;
 b=nd6EHwYgj6PB91jgfGy8LjqxZjAloIlFVQv9iwuVrPVPUA0g83vN3+vbFwSsyOBDNf
 i/RKHw9cwPVD5Yv1gX8vqEbRD2Qs8XfpCDOiYi6MeKsjKMtQzWSOIvbbY2T29utsU6L9
 GDulvKhcjtaM/bqrQBlA97ExI+cJZTFZIhF5QBfidatE+wVtJnA/Ib9KO7NOxf5aAAYG
 7h+GfgAPOXTwHuYZ9XNpPaY8AvIOdgZ/S9QJ+J654bpI9y3WmxDgPi94/d2JRZYZsF72
 CDnjGtlgFQkfUCrquWNZJx7jc9X6h++9XalXcca+SIKn/GE1WMCnbwxU7Rou4rXQYtxb
 gtDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780457341; x=1781062141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mMKShQuAK58R/9FBdHpTIimQtn7JKRLF6OWG4SPVFxo=;
 b=C6taLkNwYy9LehEiqMrCxAKdmFIDNhB2zVfMJ/Nhnx1GeGm0MQM8GFW05Uai34fP32
 PRK7gZwVFQtpRkbv8nMA3uNiej/JqtQ0QNZz2vYCCgMs19gHckEz9frjWV4mQI9LIszo
 PxD3CJ0uTr2S7nKnw86yU2Rxjnc78lOZ5pquJt57M9NOq22y176hkY8xc3AEwBy5ZfDr
 286GwDe9KDZKAPFstMVUD7nI9DBs/dMwPV9SAkv77AasH0+lVKxhFdhFHzu7TBeC1uTA
 d83++kqfOsuKeRnPmCZortySe7sNFyoK4HlgPQqjfxTDG3haWD7huoC8j3qWzQi/vHJK
 P/Uw==
X-Gm-Message-State: AOJu0Yw27Pkqh+wQt3RO+j2NQcAPa+EYnXvfIIHfS3VPFYuX0ldSKXZm
 fNDD7mSa9B7lBV7OElxFdJRZ5j5KuCFTPFItLBFVxR1MV9a4bJ8I6v8upRY+CK1HXHQMYDETQt0
 Gh7U4VR0=
X-Gm-Gg: Acq92OE5xJZRKxTrRDcv/g9fTGU6QgO7aRs8YE5+bcu0WOD63myY4v0D6bKY6fP1TvW
 LAN2l75IJjVUqH5JcGSxYMFS2Les3Vd6gMvhZ9J2UIULBEHg/DTqGrm6FeZh94bSDzv2z+PSmp1
 iZWOUq+V5JR3mlSZ0SKMXguZON6Nh6omwKLZ3w6o1khuwmq1mncq2z/lmFthrdyAs5mE4bV+/Wj
 a+pfZFz6OcdqaT3OQIuhCe/ZvUJFVFhOGaYtcGeFJgy48wRMLXyJ4Xx5L1LETc/GIuNmqRnaaS7
 YmtbP4IU3LSuH1PPwV+n9FB8YCWpSYFflCStHLeU93grYm9zvqPt0M7ZF+M0+ZjtbfzBU/DNXU6
 dn4TQIMiQ5bZ6EvHDYIlCxSzttJykWNsdDL4lFgobGjWy9QmF7SEqFWj+5ACMTP7JfnIYIIEf4p
 OF/4YZ2MDphch0zv3a0wKlt+S52Tr4NXikmSFIqpg=
X-Received: by 2002:a05:6a00:32cb:b0:82f:559d:ece3 with SMTP id
 d2e1a72fcca58-84284e83f69mr1630073b3a.15.1780457340973; 
 Tue, 02 Jun 2026 20:29:00 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428222263dsm1477831b3a.2.2026.06.02.20.29.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:29:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v9 06/45] target/arm: Set e4m3_nan_is_snan
Date: Tue,  2 Jun 2026 20:28:15 -0700
Message-ID: <20260603032855.106930-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603032855.106930-1-richard.henderson@linaro.org>
References: <20260603032855.106930-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The unique e4m3 nan encoding is SNaN for Arm.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index b75c6a6622..77133b8b4a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -308,6 +308,7 @@ static void arm_init_fp_status(float_status *s)
 {
     memset(s, 0, sizeof(*s));
     arm_set_default_fp_behaviours(s);
+    set_float_e4m3_nan_is_snan(true, s);
     /* We want 0 for all other settings. */
 }
 
-- 
2.43.0


