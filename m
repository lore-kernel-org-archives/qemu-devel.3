Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD4DCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GB0-0002Ud-2w; Mon, 29 Sep 2025 11:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3GAo-0002Nf-J4
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:52:24 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v3GAb-0000zC-Tg
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:52:22 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e37d10f3eso35904925e9.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759161123; x=1759765923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hZBlXfCeyXtS1jVz8opDjUQaqopokHiC1gYyOB8GScE=;
 b=Dl8GjLb4QXW97PuUel5aVexTKg8Ajlgn6RRe7GPkDY17WZ9QZw9Ig9dsRIqFfn4hr3
 qfY95Lrn5R7sgRMNd1gZ31nkZZ/jbb1QwRQOT5fQRQP+ppIEUpGnbZII846mrP53YAr8
 tVpBmDbNXx8wvv1t3+Bi+AHvd4k59UlxhByS946Os3U6qgkHKkBm/6Dc2RGt7TK7zJoP
 045Pwco/sIab3fj40EvYDacr6LS0FKvdKmLKXQNKlGe33ORz0oY5rThXA8p617noTdiy
 NzU1urM9aQLSQQnMM89NpE64s0V491WCTJeQLrBedNuYfXsD1lj8xReohtwILDplo7Vd
 Rwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161123; x=1759765923;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hZBlXfCeyXtS1jVz8opDjUQaqopokHiC1gYyOB8GScE=;
 b=iYyWrD8FQEqjq9XfLNqX1YZeI06+ObYffpNuFB8P6uDhXkXmJTgiawND9LBf8L3b6o
 d5v5SZLZOaacAB2vNNt6SKCQlq3qttOljgS40vYW4FT91KmOvbZQ0FJb8RLaRw1qTjaA
 N+RQyWnb03U0dZmJnSkl3G/hI2a8MWWE9jluzMwAAs5Wt+RyvUP8vTNYp5rX5kg+ry0B
 EhIpFxFbhoEARwj7UU4QGyXbH6MVp0Al3ck1u8sgv/Py0MkXqXcvNEj5Zzfxiji9CkF9
 37bkgz9YBnbMUhrLuWMpkWTUAlTw6wYF8SeILyJi33HMqyMXX+aihmRbfQ3a8N8hzbpZ
 IJ1Q==
X-Gm-Message-State: AOJu0YxZKoTkG951/M84E51m2p9TRCmiQn4oA1Y/ddGKfR3D/IiU1kFw
 mTJenzUi2ZjpNkA6lvMMLykVFpMFLF8KoH7o5ZXOkTS2/acRESQ6DHCDuiw2Xu6k5Ao=
X-Gm-Gg: ASbGncvZIqefRCXUcQY/qFqAqcIjFuwWzDVGUZs1iOAolaS6XMoWbFuOrfLKhSQ0dAY
 gHnWdvey02HBAxzD8V/2nc+WJBBuU/07o6UL6aKKBdRR7GbdEO/C4aKzqwq9prSIXzTh5KcBUGu
 8TU8g6IkPqO4Q2dHclz/kNJz9yLepx4sh8lqv20z0DT+Y6HiHQn2+ml5XZTeGj7mEWzoScLmYaa
 +Lb2s5PxCZvF4KMgrLgAPQr8Kuomozqmc9CAcnbdqi9Yb40zNQ3qxfcpi/bsC8QZz1K1bMftzIS
 /FgpS/aG73/2s9pHvgqcXxqYZjeT35H1MuPxQhFfQlrPkaFv8Xl3Me9JquD3S3/bp6CMJSkmP3v
 f9Vo7LJ5S2lqvDDjlrAvOyf0=
X-Google-Smtp-Source: AGHT+IGUXcJ+wxKMq/E/5+FvwWCqP7nb8p0iGQLvc5+Yxo/Dg8+4kpUKOE1B2P2IAQa4gz1DI1JMCg==
X-Received: by 2002:a05:600c:3226:b0:45f:2922:2aef with SMTP id
 5b1f17b1804b1-46e32a0e227mr103864665e9.28.1759161123420; 
 Mon, 29 Sep 2025 08:52:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2ab4897bsm229807485e9.17.2025.09.29.08.52.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:52:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 046FA5F83A;
 Mon, 29 Sep 2025 16:52:02 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: u-boot@lists.denx.de
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] link principle license to COPYING
Date: Mon, 29 Sep 2025 16:51:42 +0100
Message-ID: <20250929155142.1647606-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Some license scanners are particularly dumb and when combined with
automatic license scanning for FLOSS accreditation on forges cause
problems on renewal. As GPL 2.0 applies to the core code link the main
licence text to COPYING to keep everything happy.

This caused issues for the QEMU project recently as we mirror (two!)
copies of u-boot in our project.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 COPYING | 1 +
 1 file changed, 1 insertion(+)
 create mode 120000 COPYING

diff --git a/COPYING b/COPYING
new file mode 120000
index 00000000000..1ed3ba6a13c
--- /dev/null
+++ b/COPYING
@@ -0,0 +1 @@
+Licenses/gpl-2.0.txt
\ No newline at end of file
-- 
2.47.3


