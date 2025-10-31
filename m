Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF01CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEeeu-0005DH-2O; Thu, 30 Oct 2025 22:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vEeeq-0005Cc-42
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:14:28 -0400
Received: from mail-il1-x12a.google.com ([2607:f8b0:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vEeek-0005ul-6o
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:14:27 -0400
Received: by mail-il1-x12a.google.com with SMTP id
 e9e14a558f8ab-4330e3080bfso1743145ab.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761876854; x=1762481654; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kXNVUCby48RH6VRSv17/ZXkaNdRIUQN3t7HvRQt3jUQ=;
 b=lCoaDNAPO3/3FlkG/uhh9X9/zxPJEmfoZJEF4/oZS8yov3pHwyBc6gC6U9g/xeVplp
 KxXwfXo36KalQkVVErgm4P1MM1kHLig6pCS++tHHBDh4k3cC/t4hkmYZg2LF6xR+IqDp
 h55ylGUVw7670aS3UjKeWvQOjm4WGCRga1WOGDcNASmgRElljFg39Al7RXze39A2Mp/P
 xTgEfRzSHZiolj50Sp3UWa4O1UGrR52RehUCc9SUglpqyWllIYmun/I/sNOqzvpS5TW6
 vTAh+BWHoMoLUTDVjxGmsvF0JWfq3eUdBnxHkgFjGsA6XaxKvoI34V3pKMU8khHg4tJA
 wKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761876854; x=1762481654;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kXNVUCby48RH6VRSv17/ZXkaNdRIUQN3t7HvRQt3jUQ=;
 b=u1LVcRgsAN0udq4kTdHRvva0nQ+w4d7cMn8b3yNcOvCA5PMn3TC1LViV9l2rdAHUMh
 Sa1iDg9c1nL5iwRmYSLIf5RGd2hSaQQX6RdlcfJajKzvDR7DEvYEqCqLdh/vw2WJwF4+
 TXwSS6xKAW0vqLbav7n17bgSrTue5D2H1e9LlyVoekJiQ6j8NgkgqWBXZ550KjOzfuk7
 ESson1oKSxp1s027U6vXPBMqulpgkte8FRB+qWPumU8yv9wP5Z4UZ8eP6SKMA7bptAgo
 LxV1jJj6xCs2yPWk+W4b5ISP7LY39kA1vQrOUegaUg6ncBO8n7TMvlpXug1a5Jjxk6GU
 2wVQ==
X-Gm-Message-State: AOJu0YztycJlm3+hRkOH5XMoY7rphvwd3cHfe/2bwIe3yOtnfZ+J424o
 REy77BxZrCIZpxkOH5zKvkb8lg7W0+QiDAiz/64fqinIB/DLOf70RV1y/3JhxaHUZHI=
X-Gm-Gg: ASbGncsQmQN9KFCfhAuD69fcSznf2q8w+ST7iiff2HOG7NTwT0kqcAoyAUGvMfOeUD8
 tIbG3d1+W6oI/IFOOFUbSUCdbPo/TMbUGSgTNeaOEIyzl+55oLdTHjsE4S09usA4srZV7KrGRZb
 L3lSaeWty9zkrg+I7LCJNoLpXWgzwXzYjai/Pw/DrWeF4GFbLP0zXxUFTBCp1LRrc9rJnP5XFPi
 XAJQyFLTMZvNoP/5a15rtDoGTj9hj0vBt1duHrFq/XhRntVos/7Kn+BYoOf4qEdXajvRc2ev2Oo
 LiPI/1GrKyrR0zKiUaiAMmUWGoTZGvTh798DHFo406wPyKwb2/aHmcVq3XhwqO+0BjYapJfPOvp
 H0D47xEo8G6WeBJVD5In7e6e7HAIWlK346yzlNzymiw/9NuxCCirPRt0FcQCE19pNsXvuYwsQuA
 TyMZyrvEZL05RDrgHFFy7RFnk1y5dO6YfhcwzMUAFViHgRCo8GMmoMw+1/CHcDsZZdQg==
X-Google-Smtp-Source: AGHT+IFC4DIXMhRwNpRKVKUzEEo2DpJkV+ym9nSdOaJyWT80L269ry7iINiMci9R1VsLTniykWOtyg==
X-Received: by 2002:a05:6e02:97:b0:430:d21d:7b24 with SMTP id
 e9e14a558f8ab-4330d235d0emr34301305ab.32.1761876854442; 
 Thu, 30 Oct 2025 19:14:14 -0700 (PDT)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-43310274e21sm1631055ab.9.2025.10.30.19.14.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Oct 2025 19:14:13 -0700 (PDT)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 0/2] Improve USR handling
Date: Thu, 30 Oct 2025 20:14:09 -0600
Message-ID: <20251031021411.111365-1-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12a;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-il1-x12a.google.com
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

Currently, any instruction that writes USR disables short-circuiting a
packet.  When the write is implicit, we can allow the short-circuit.

Taylor Simpson (2):
  Hexagon (target/hexagon) Add pkt_need_commit argument to arch_fpop_end
  Hexagon (target/hexagon) Implicit writes to USR don't force packet
    commit

 target/hexagon/arch.h              |   2 +-
 target/hexagon/gen_tcg.h           | 114 ++++++------
 target/hexagon/helper.h            | 114 ++++++------
 target/hexagon/arch.c              |   3 +-
 target/hexagon/op_helper.c         | 287 +++++++++++++++++------------
 target/hexagon/translate.c         |  14 +-
 target/hexagon/gen_helper_funcs.py |   8 +-
 target/hexagon/gen_tcg_funcs.py    |   4 +
 8 files changed, 295 insertions(+), 251 deletions(-)

-- 
2.43.0


