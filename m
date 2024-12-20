Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B351EE7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 10:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOaUm-0000ny-0W; Fri, 20 Dec 2024 05:44:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUj-0000Yy-QV; Fri, 20 Dec 2024 05:44:34 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tOaUi-0005W6-8g; Fri, 20 Dec 2024 05:44:33 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-725ed193c9eso1568709b3a.1; 
 Fri, 20 Dec 2024 02:44:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734691470; x=1735296270; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UIpQG1unCOgp9RekffLvGrWxvtmfyUlRk2TzuIF/DCI=;
 b=W2yqO0z1KdfsIrogIbg85sy2qsr/xD+dtf/50wfnuEE1ShOelD7D8zDbvN0nhYDBtc
 5ERRp/JGwXSY3xPu1eoG3Pf0e1m/xifdG7RXAcZkIHlsvTEIiooNwJyViufkGg3AMhce
 Tt/j+EIGFue3gQIobUjXxyY15U3J0It2iuHqKnIHdzz8TyQvcUirbbUsYn0HnBGcTPLv
 eQnbFc41mi4N7vwH8yHt2h6Q2pOGF+RqPcV6RqZ7BWkfyG8fsLmqsYSqz1S9jrTpf2/l
 7Ys7L+HASbI78OKGQ2iV9+JPPvn3/pDOrOsqu4OhxwAma9cyhFNyDJDOBQ6N6dkZEfHK
 3lXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734691470; x=1735296270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UIpQG1unCOgp9RekffLvGrWxvtmfyUlRk2TzuIF/DCI=;
 b=OWvXWAPyPDBXP+aQTlUcIX2s8BvbLRY+SUJsReC5MzVnCSYjAO6ieT7mmsNsT/3qZe
 YLW8WDff1U4WaXvChGQ76dUzuUwY7uv6dg3wpuwKtP0LSZtz0u0L8StqDGIk08Gba8Nw
 5M678UnpeVljOOlStwzcn/E3apAulSXMNN3BS94bTZHkU1WiQq8uukjUIPY1rg227DJd
 ZqDuitrdr+O89qNB+lAgjCqAh0vcc12Ehq6GpItQ/wSGV0pZ3uI1Jskpu7QP31Y8ZuGA
 H+x7lSxcO8v0eW9qY+0UhX8zcSNgyH5P1xjIIj/N0JwCtWnYOsTjKqufErNesTiAADtt
 SqYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZIQGtoepyvvOxaXkdMr6sjQJouuuGCRI5TXqV59qPt/BS2qQOKrFUL2hIZI4AVdli2yyG9UP3CaY5@nongnu.org
X-Gm-Message-State: AOJu0YxHJvSLlJHUnX0wfsWWsn1HRlS1fpISXVnRT3zgzfroLVNd3Ul0
 bfQBkjbiqmEhJ66MWDnW5dSLdDcpy4kORBEvqnAm4sVeg122GAErg7S2IA==
X-Gm-Gg: ASbGncvNEcrsVJa7r/hnPd+L7TEkBlQRZRZYSqfNbMwXFgmoKGwSIn9eJDRswTzBM3s
 vzxWwHohcBe19sDIAOj+whfmw28f+xE+HC7v7E3xcXGcONnJtaVFi1x6kNS88EoFx2g0D+NYUQp
 0UmSsHqDmHHGLGemsb4Ijxh9l2l4A7B0tTWgO0t0Dhcri/MZFgVlRZ4hwIsUbCgkYRRwhIWnBCR
 4plKSdz3qCjQ8IizzjKHNGM+83kXbXnX9BPUk1+9hi01aNEVd691xgNLpwVgs6w2/QMeugAM1wg
 g50LFgmlGQ==
X-Google-Smtp-Source: AGHT+IF2BsaIb3W5qZ2YzV0qK1FqD4ZLAkP70GQ38x5iCnmMjifTFZUpstCNTZ7/Oky+j0U3pQIRDQ==
X-Received: by 2002:a17:90b:2f0b:b0:2ea:356f:51b4 with SMTP id
 98e67ed59e1d1-2f452e1b24fmr3790820a91.13.1734691470451; 
 Fri, 20 Dec 2024 02:44:30 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f2ee06dfd3sm5376942a91.32.2024.12.20.02.44.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 02:44:29 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 15/17] tests/avocado/replay_linux: Fix compile error
Date: Fri, 20 Dec 2024 20:42:17 +1000
Message-ID: <20241220104220.2007786-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241220104220.2007786-1-npiggin@gmail.com>
References: <20241220104220.2007786-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
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

The subprocess module was missing, the hunk got mismerged into a later
patch that is required to make replay_linux work, so the broken commit
was never tested in isolation.

Fixes: 4926b6e6444f ("tests/avocado: excercise scripts/replay-dump.py in replay tests")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/avocado/replay_linux.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/avocado/replay_linux.py b/tests/avocado/replay_linux.py
index 59169224353..38b6f8e6652 100644
--- a/tests/avocado/replay_linux.py
+++ b/tests/avocado/replay_linux.py
@@ -11,6 +11,7 @@
 import os
 import logging
 import time
+import subprocess
 
 from avocado import skipUnless
 from avocado_qemu import BUILD_DIR
-- 
2.45.2


