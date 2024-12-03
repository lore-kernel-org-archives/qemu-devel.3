Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01736E64A80
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 11:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIQsP-000562-O7; Tue, 03 Dec 2024 06:15:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tIQsN-00055c-IS
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:15:31 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tIQsL-0006xr-UX
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 06:15:31 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-434a0fd9778so49661965e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 03:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733224527; x=1733829327; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V4vqBkxvlehTikjWkv1FAiP00ONPIsiSAWhTsn+6Jp4=;
 b=KLG2QOpAc3Zc/u+KmsoEuVoSoeVrmodH/HPaFCS96NLBxyooUz4rYRURmt/juMD8l0
 xprafKf3+D7VsGecZvdYELkmKGmJO76DkgQFNrGmFPJY3RCUAtnXnL65HaFU122ZWOOl
 ju5Vee9QfRxkNFOPsw0WXwHoTUrxgLuFnt3pU5YeyAe74MFuQUmXf19bEE9lUw5eOTGE
 Cy1tu2432/3ZSB+jBZxAWCkM1nJEyf/lHe+cbz3U/T1QIOWBNMpDey9CYnb2JEyCEuKG
 X4iXR8+g/00y3TJMVqBXx7Weun6RDXYsUf/l33G3TSjRC7JVdYg017X5b2ryp63GGseL
 BAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733224527; x=1733829327;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=V4vqBkxvlehTikjWkv1FAiP00ONPIsiSAWhTsn+6Jp4=;
 b=s/qWPw8fiqVJc1Axt36sRZpk5lK/SNs8UWVPRyPiYj6oAnSRcI5LkehUR23QYJ9RTC
 4uz3lwaisARblkXQj8D1CPl+2zmhluUW4J/BFPRUR6o3Wt1p9/Kqu4X3ch0Zn5cKfjI8
 N7uPGVdthLAD9Iy6PTW6iZqDHUJHR831Uoo0j8m00gMpFwrU4AL58SRt1c0v2kWRb+PU
 TAYzkGsFPLUZ2Ik6QefJbeb33Y2hCLwbHN4Xe77bjL8fQ+sRf8ovUbEm7T5WrV530NCF
 1XwCjCSvSFsJVrTjALKzDmwvrgoJFKrdrsmi4iSetzmfs9YSTbMu2WoV6m0G0DbI+DS7
 5WCg==
X-Gm-Message-State: AOJu0YyRoIEH3OXAWMn3pRc9Zk1pjjekw1EOAXKCvq7UGZVQF0/5pelQ
 e9KPkgSDmPFEAIeuzY/SVAcZx0yd5+Ym297MCf71XhcCYrvMJn28/DwaKw==
X-Gm-Gg: ASbGncspB0lbPzarLuUlO+HXDbfKapbhcg9SBTIPBxCOP9ihqhXVSqvBb4f/OctjMLO
 8ayg3ZeegjMDBF77TOIMnj2V6e8BVqbubzxdnO0TPfkwUuzRS8p8wELj/70drMoRQHX7jdjsrd9
 94rP3/0DOs2/dwZfiIuXLMJAj0uIVI+zpPuyAjsVCcMCOTxqwZtnGR5deDTGdBcWYjlZp1SA+UK
 KrDDhaSdLut3R2YXO6v59z4S9IUgSPEimD91EzZtVeCtH4zR3qOlYJ8DYivTYd/r4PTniN0Rtha
 0b4+dt8K17kssw==
X-Google-Smtp-Source: AGHT+IHypMspzRRbfD/U9Slfgeqb65D5HNGLu7JKT1G86aGl69jOYdLd624Pj4ReS44rsL5eFWoZZQ==
X-Received: by 2002:a05:600c:138a:b0:431:52da:9d67 with SMTP id
 5b1f17b1804b1-434d09b1831mr19891695e9.3.1733224526762; 
 Tue, 03 Dec 2024 03:15:26 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0d9bef8sm184920365e9.7.2024.12.03.03.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 03:15:24 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>
Subject: [PULL 0/2] OpenRISC updates for 9.2.0
Date: Tue,  3 Dec 2024 11:15:11 +0000
Message-ID: <20241203111513.402641-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x336.google.com
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

The following changes since commit f0a5a31c33a8109061c2493e475c8a2f4d022432:

  Update version for v9.2.0-rc0 release (2024-11-13 21:44:45 +0000)

are available in the Git repository at:

  https://github.com/stffrdhrn/qemu.git tags/pull-or1k-20241203

for you to fetch changes up to 3eb43aeb164f1f83c97ff693c7d464b49755110c:

  hw/openrisc: Fixed undercounting of TTCR in continuous mode (2024-12-03 10:59:25 +0000)

----------------------------------------------------------------
OpenRISC updates for 9.2.0

This series has 2 fixes:
 - Fix to keep serial@90000000 as default
 - Fixed undercounting of TTCR in continuous mode

----------------------------------------------------------------
Ahmad Fatoum (1):
      hw/openrisc/openrisc_sim: keep serial@90000000 as default

Joel Holdsworth (1):
      hw/openrisc: Fixed undercounting of TTCR in continuous mode

 hw/openrisc/cputimer.c     | 26 +++++++++++++++-----------
 hw/openrisc/openrisc_sim.c | 26 ++++++++++++++++++++------
 2 files changed, 35 insertions(+), 17 deletions(-)

