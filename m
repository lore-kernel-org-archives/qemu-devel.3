Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42F17C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:43:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjef-0002bi-S3; Mon, 11 Mar 2024 13:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjee-0002Zc-B9
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:40 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjec-0007Nc-PZ
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:40 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3bd4e6a7cb0so3004484b6e.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178896; x=1710783696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ypjlmGRHzY0uruaNOcG3LohKyREVxpMddX9iaQbvl0I=;
 b=Sm/MyGhYAs5i2hfbYnbqYbsyYTP1xMjoaYA3ayweCX4BsscU+g3cUVr+wP7ck6NZ+z
 LQ9LpCC/cNyXAPBKYXMN6K1C22KxuzbtMQnRjwuUapRpjz6SF1IY+OgT+xpjhiiiNUw4
 ldSra8493YjnIbRvv2vTWhX9U2POfOdleNk6rVMM2Vmt+44OjwyzNYx32tsvy+t6BX6F
 Wn5DgHzYTWEgXVTpw1fnMI4eYLNsN82FXsnvzEw+ESjhcqy8mvmmEQtSCsi12wplEIOX
 UTf04zUblu6QplheGKgIkG200iKLFxiv4JvSUmns/dKXL9wZXbxOQZij6PrI7mGghRGq
 jFdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178896; x=1710783696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ypjlmGRHzY0uruaNOcG3LohKyREVxpMddX9iaQbvl0I=;
 b=gWUgYZWHacAcJNthbgQW1Q8R76ZOtUr+won9bIF6S+wRtB/a25bHWXOPohoC4cra/+
 jFqUhcey8i4NG6H2C0+Bn18phhxOMIVXnwYrm8xgHWc86Z6Azm0oUjCQ5bEnmFI/mHoP
 WyVe3mbKajwAcvEFlGu3FR0kd1VP+JIiydoIOwJtFQCwNi2VDiL+Z8y81EjP1JSUMiG2
 8ccFqp9fC7DSxwXxf7/GRj57bin2QNMbEtIHor4txa2Hig0jYAes/ph8rENbwGJQmxwA
 8DjtpeixBlQZkToK2q1QBw4xUaRdRxE00lHcA1rCgl4ohnwDQcweHGDDwUaCqZclFFmS
 Lwwg==
X-Gm-Message-State: AOJu0YyoJmWqLhmHqU9VMsRqC0WT0zk0pKSr0fMThOiqEVZJ5oqZRAOq
 eI3iyUZDMJy4hqWTLWeEnfPoxJxgjzvXlgkZaKI7XZOGzny50HBF/3F8adDd9aU=
X-Google-Smtp-Source: AGHT+IEc5s2/zyTKI8pG6Ai5VuVN1ci5ub1RvUw+Ry01K4ZqbVzzZFBLE9rQ65EOas04vid1hk18Zw==
X-Received: by 2002:a05:6808:384d:b0:3c2:3fc6:a05a with SMTP id
 ej13-20020a056808384d00b003c23fc6a05amr1804850oib.33.1710178896206; 
 Mon, 11 Mar 2024 10:41:36 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:35 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v4 11/24] net: Use virtual time for net announce
Date: Tue, 12 Mar 2024 03:40:13 +1000
Message-ID: <20240311174026.2177152-12-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Using virtual time for announce ensures that guest visible effects
are deterministic and don't break replay.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 net/announce.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/announce.c b/net/announce.c
index 9e99044422..70b5d5e822 100644
--- a/net/announce.c
+++ b/net/announce.c
@@ -187,7 +187,7 @@ static void qemu_announce_self_once(void *opaque)
 
 void qemu_announce_self(AnnounceTimer *timer, AnnounceParameters *params)
 {
-    qemu_announce_timer_reset(timer, params, QEMU_CLOCK_REALTIME,
+    qemu_announce_timer_reset(timer, params, QEMU_CLOCK_VIRTUAL,
                               qemu_announce_self_once, timer);
     if (params->rounds) {
         qemu_announce_self_once(timer);
-- 
2.42.0


