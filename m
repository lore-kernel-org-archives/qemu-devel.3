Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB8EE7718A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 18:18:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNyb7-0001e8-4h; Wed, 18 Dec 2024 13:16:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNya2-0001B7-26
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:30 -0500
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tNyZw-0007Uj-6o
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 13:15:26 -0500
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-aabbb507998so694098366b.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 10:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734545713; x=1735150513; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=azFqJlxIjTGm0wEZy+3M3fkeckUkOp2SpgqHMWP2R3I=;
 b=p4QWyqyWnIUyusVO1/lBUV6Mr+/BBh/6AHw0zgc58rqo80vfldYhU/KlxsnNDLTJjA
 f9dzSnJ/slsHbsdZRAe/Rcj+0StHRdb1oC9fIMPxinC7UvdUDVfaxO7ckOB1iAb5F8so
 lxmBThCPjfqu5AewK7KIgrSUGhKtYUqhkquM4tXoT3bhafltzQ9k1lel8CGw6P/cyJxa
 oHuGree0wyKsN2Zv7ANy9J/LyaDXE4U1afXtzgTi4oLbeT8bGod47LuqkppkDKJ+UJel
 ZmMpT5gAUyywp5dfnDZHf8VmamNhEfe4LTSM4zIEPe3OMaiJ4LxcW3ylVNclb7DglmkB
 tRyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734545713; x=1735150513;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=azFqJlxIjTGm0wEZy+3M3fkeckUkOp2SpgqHMWP2R3I=;
 b=QyVRL11ZS1kvIWPRRivXr2rUG7AeuoiT6xqCioyQqJ8uD0MEYrQt5MD4CBv0u9SRM5
 1oQyvjDGg4xVlNmBwPqcFjizXKZA4KkRisEuw/BR/aeNTqAkFWV89kXLa5AZRZZ9l3TB
 hFiNgU+oOYaG/14zU52fqkNtOPYYwHfhVQhbHIAMIlCOvKgonMK9O3FRw0cbN8/KkBdT
 yMaSCW62yb3BrDAueATGr+wVNFRidOx66zOFVAGvna4/fFgJdIc89D+KFOkG5IvteU6l
 Agk6oVroHGT6xlMhjyQB74qZupE3/sj9oR2Y3zQBWXEWE30MCdRzyaAzd/AyOwxCsYDL
 otTw==
X-Gm-Message-State: AOJu0Yx1SL9VY9dK9zRMXjNt4Cun/NdCX3ushTYK9hBsmNvY37TJITjV
 eJhc7Z2e8sC5+ayzctKi9Jmv/qBguezFMOUpuVhVaYb+7sGURL1qLgxTAkP5NXM=
X-Gm-Gg: ASbGncsbrsdTg48+ZvQM62QqY53ObI4Cem06cwH2MkBfcpChBzjW94hwlOOV9c2CdiZ
 psWJr3dFhvW5MQUH46Rt2D8AOy2YjMGIqCRcb8er+rheQa+B+YkTehjPru35lWZfOsctMEuCETe
 2J4eZSTSzwHJ4W9lp7j6Qn+52J1YuE9oZ0GEi48AA8e66ca4CkF/wUwH8w60xfl2wLykDQcxVwg
 bDl6s0qR4OhmSK+4jWRmzrqxK2KyvEtztt+Y5STBgVLzPd/9UC1Kk0=
X-Google-Smtp-Source: AGHT+IG5mhXRuBBm5tMf3SGw/Pj8C8HnOnbm3m5jWm5L+ObcI1uhDlS35AUwlpka62avbmamy+YZ5w==
X-Received: by 2002:a17:907:9410:b0:aa6:6e02:e885 with SMTP id
 a640c23a62f3a-aabf490cf1cmr333794466b.47.1734545712936; 
 Wed, 18 Dec 2024 10:15:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aab963ce2f2sm580246466b.201.2024.12.18.10.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 10:15:12 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 77E245F796;
 Wed, 18 Dec 2024 18:15:11 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <quic_llindhol@quicinc.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 0/5] target/arm: implement SEL2 physical and virtual timers
Date: Wed, 18 Dec 2024 18:15:06 +0000
Message-Id: <20241218181511.3575613-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62b.google.com
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

Follow Peter's review I've split this into a several patches as there
are some other fixes that should be made to other EL2 times that
shouldn't be rolled together.

v2
  - split machine enabling into patches
  - rename IRQ
  - use CP_ACCESS_TRAP_UNCATEGORIZED for UNDEF cases

v1
  - improve GTIMER docs
  - fix gt_recalc bug
  - address review comments for the main patch
  - cc qemu-stable (no rush for 9.2.0)

The following still need review:

  hw/arm: enable secure EL2 timers for sbsa machine
  hw/arm: enable secure EL2 timers for virt machine
  target/arm: implement SEL2 physical and virtual timers
  target/arm: ensure cntvoff_el2 also used for EL2 virt timer

Alex.

Alex Bennée (5):
  target/arm: document the architectural names of our GTIMERs
  target/arm: ensure cntvoff_el2 also used for EL2 virt timer
  target/arm: implement SEL2 physical and virtual timers
  hw/arm: enable secure EL2 timers for virt machine
  hw/arm: enable secure EL2 timers for sbsa machine

 include/hw/arm/bsa.h |   2 +
 target/arm/cpu.h     |   2 +
 target/arm/gtimer.h  |  14 ++--
 hw/arm/sbsa-ref.c    |   2 +
 hw/arm/virt.c        |   2 +
 target/arm/cpu.c     |   4 +
 target/arm/helper.c  | 179 +++++++++++++++++++++++++++++++++++++++++--
 7 files changed, 194 insertions(+), 11 deletions(-)

-- 
2.39.5


