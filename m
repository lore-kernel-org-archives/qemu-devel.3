Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60614D70E0E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Dec 2024 07:11:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tHe5l-0004P9-58; Sun, 01 Dec 2024 02:10:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tHe5j-0004Ok-Ff
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 02:10:03 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tHe5h-0002kh-RM
 for qemu-devel@nongnu.org; Sun, 01 Dec 2024 02:10:03 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-434a742481aso25979435e9.3
 for <qemu-devel@nongnu.org>; Sat, 30 Nov 2024 23:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733036999; x=1733641799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ePeffuJG9/5dP2kZWkvfYUqNR0HS2ATl+jN939SHhAk=;
 b=AJdokIpyOn91Xw7xJddO9KpBQN2kg+8Qq7upAT+PP1FLe2yAtoUootQA9pxwkd0rzx
 xkJ9gzgiJLTBXi6dL18PuMiN72siKxEWa1O/pngBiUNafzxwQPF040EKaKh70N2KlQJ+
 G0+Rw0XiGLp1H77ZjYeM3wqAhmz5aWGvE3GQ2t6qd4GdD7NwQ1p7pTIrFmupwxwWRfU8
 dNxYRZFqEuIJM+qbqHsOBD15ofdsQL7VWx/6g1ILOBbKpKWMpkhLztByJJjnXPaiEzAa
 k6G65P2dMAKZeMdpWMc2q39VxzTwxC/Ejs7THeuHmcxv39wtiCnb4eERJt/S8Qhtqtwf
 NvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733036999; x=1733641799;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ePeffuJG9/5dP2kZWkvfYUqNR0HS2ATl+jN939SHhAk=;
 b=O7rsJnVgYhL8McdiTStYxjt8EcNCv2WpZ/bZVvd8NKiSzhH3eaGCQRJ3znrznGICrJ
 /93EIcxze1LhSWWugg0StFlYTcjxa5BUZcQGTna6o42NGCf/SE7nUdqqw1uH29Rd2sVz
 fgNRDl20jKbHcxTwo2gD6+v1f+EjQtjz40QKX8GSRfRDBDCMFs46s+ncHQ+CTJSON2JI
 C/AVaMKQZt4oqT5GZ6UrYtSbD1D8guMDKV2G/RdTbS/tM3Uz78lkpUxuzL8CLXJEUWEW
 lRkh+oACtsjN1lewCwL7zBJyXQ4o6AznaTVbOHA+SorXNzO4lgSOlhX1EMa1BbH4DL30
 Mgbw==
X-Gm-Message-State: AOJu0YwAWqyQT1EjQ4NCV4vZFND7kjTiqwU/ia6VORFVnA7oEvefuZrg
 StrwkzwDSOmxiAo40SnpeWUnxQf/bw9XGQLRfELE9Ff86CVVwmgChxRnSA==
X-Gm-Gg: ASbGncvPV5MazeAa5X1OXVh+b292MZoNqo80ZBUy3t/P3d6SN/iy3twCX9JVqCmyY48
 44aFhaN22ijZ4NJzP3cBlKQiYwb6jAQ5IxUwOCW4lnEy18UObX3nXYhG2oKUNausafwdWEN1kaC
 aX1qtgFwgwpW0/gBHSf36wXvMmCeyUr8vU+Llx0a1jc5kDJjug1tAfB4UOi1C6IHoxwkHfijH85
 iJgIC1RSqSOVlgrDWJv2SZ8XA0f2sQjURFdiE145r6t7D2doLYJUHw7+buNmJ9Ykc3CWSjYPztK
 0zJwkQZQLq5r4Q==
X-Google-Smtp-Source: AGHT+IE//St520lmtnUzEh6bl8mfGDE/ZcHif9gryxzNwU9B9JX1q6lo7/usmstY4i0sI0JrjbyURA==
X-Received: by 2002:a05:600c:46c9:b0:434:a4a6:51ee with SMTP id
 5b1f17b1804b1-434a9dd0060mr180502515e9.16.1733036999099; 
 Sat, 30 Nov 2024 23:09:59 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0dbe3e5sm106816815e9.12.2024.11.30.23.09.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Nov 2024 23:09:57 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>
Subject: [PATCH v2 0/2] Misc OpenRISC fixes for 9.2.0
Date: Sun,  1 Dec 2024 07:09:52 +0000
Message-ID: <20241201070955.223360-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x329.google.com
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

This series has 2 fixes for OpenRISC that came in over that past few months.

Since v1:
 - Use DIVIDE_ROUND_UP instead of open coding as pointed out by Richard
 - Fix off-by-1 bug in TTCR patch pointed out by Richard
 - Fix commit message and reverse registration order as pointed out by Peter.

Ahmad Fatoum (1):
  hw/openrisc/openrisc_sim: keep serial@90000000 as default

Joel Holdsworth (1):
  hw/openrisc: Fixed undercounting of TTCR in continuous mode

 hw/openrisc/cputimer.c     | 26 +++++++++++++++-----------
 hw/openrisc/openrisc_sim.c | 26 ++++++++++++++++++++------
 2 files changed, 35 insertions(+), 17 deletions(-)

-- 
2.47.0


