Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001E5C5DF87
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:44:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zC-0000WA-Bo; Thu, 20 Aug 2026 10:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zA-0000Vp-Mb
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3z8-00058y-Pu
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:16 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-493b966dd74so15648365e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787236992; x=1787841792; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=rqrcX+w3ODt714ovAIrNXwoV9XbEiB7vP29/TtziXnA=;
 b=jXsBXcX+8RTqAN9sg47LI2EZt+WNKxfWRxlNQv3JssAiGsPmN9h13ZNKTusNrVeVmK
 nariULTH1JGPLV8BKP9xaalByVYIf05ORJJV+S17h3nKZmANn1ponI0jW7l4E0WU5MUC
 9XbAvQW/jTdMmLbxoaC1EmzrKXIbDG/Sej/xChw0Bsqryu9NfHXik7Z0LF7AsfaFagV5
 tAso2ZTcFfvHKZy1cdA64hieFF1U+ceNJTHHP7VVuHHRz5L0xLTObDUjg+3VdmdLPDBP
 djOPAXfU9hcsXqyFjK2Y4sPaDmB9TfE25A/KkNsWultEb4QMaBXf/lL7V1K0AlhuBLJo
 5Waw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787236992; x=1787841792;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rqrcX+w3ODt714ovAIrNXwoV9XbEiB7vP29/TtziXnA=;
 b=WoAlWI8DbJHOmXKrH8uP4aOtELiYeZCPSVI78O6+sbpcWopnMLLDBaOugnbUaY8JjQ
 C+s3onyzlYRxSRl3PauDPxnCDQFin0Wmkfb9israf8FEkhqqZO40VfrfVy/8114EcJJq
 X5OQyrOFwfv5S235JkvsBosYElevBXrfBHNRuKJslYI1zGginGwn870ShPR70R+zDaqa
 hQ3taBreAaDq3lD0YCDBa+WkZZkoGNPjTgPj7d+C1wq3pnuixpt9HX9DaJcLy4ArwULJ
 VpBBN7c/nKYARpW5CftePsqn0sGd+qPuOTYhwhDr5bSuBb07xHeIPlRkLI7+AbOe1Lk9
 qccw==
X-Gm-Message-State: AOJu0Yx63d44ly47uuca94T+IvhCZO0n90LisKuHArlcY0Eo7cAdfL4M
 MvTVuTogKx9s8LWA0tFz9gY7y8QJtWd/o8u4W/ane5qaIvr3DZ5x70MjME4WbmxDqEYj+5ZHrlj
 fG1zt
X-Gm-Gg: AR+sD109TI7W3YLxP+/U4vfV2cKrf7aTNNCdU1IONQvn/KT058OZDyASFroTxb0VAs3
 TPXtkitd5LGIyPskJV3YZPa5WmZcsep00fTctSMObBl8MpFnx6w3xSO4bd86+Hq1mZ4gW+5tTEs
 TlW5Eta6JEQNDW6Kf7s0JSdjUEtHdidxWfJpk+ayOaR8ODtr+nWLaWv5PgA6igYbvRCICKhqxFd
 FliV52bR2xS1vG3kmSNS32BD+d3TdaqTa1J/KJvqnbnRDTUrcciv2g4qTveSb1/i7vHgM4f/ad+
 0Iy1y4HOwyYD9SWIKTB/x4cJVKU90e5vchH3DsyTqq7WgUnpbnx7O2gHf5f2RugROPiEPnyySXt
 YhC4WnyisXMhjMT5s6UjFT9sJoh+2wwmEfP75MjjQ3Ws8hx891Nm7jorhr7ZjCfqwMOidq6Gvo/
 d20qbv3Yya7vzOWbwz2rOyBTR7SIAwMJUkdZ8ikCaIeBlCT0yCvvLuViPkLQ==
X-Received: by 2002:a05:600c:1387:b0:493:f5bf:4dc6 with SMTP id
 5b1f17b1804b1-499aa1a47cfmr191095615e9.7.1787236992429; 
 Thu, 20 Aug 2026 07:43:12 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:11 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 00/11] hw/ide: pending IDE fixes
Date: Thu, 20 Aug 2026 16:42:58 +0200
Message-ID: <20260820144309.835173-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=den@openvz.org; helo=mail-wm1-x331.google.com
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

Pending IDE fixes for various issues reported on GitLab.

Based on:
[PATCH v2 00/17] hw/ide: fix the logical CHS translation a guest selects
https://lore.kernel.org/qemu-devel/20260820100844.411717-1-den@openvz.org/

Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

Denis V. Lunev (11):
  hw/ide: reject an out-of-range PIO transfer window on load
  tests/qtest/ide-test: cover the migrated PIO transfer window
  hw/ide/ahci: refuse a PIO transfer with no command header
  hw/ide/ahci: clear cur_cmd when the command list is unmapped
  tests/qtest/ahci: regression test for a PIO write vs. engine stop
  hw/ide/ahci: treat a failed PRDT walk as a PIO transfer failure
  hw/ide/ahci: reject a command header with an invalid FIS length
  hw/ide/ahci: drain the ports on teardown
  tests/qtest/ahci: regression test for a request outliving an unplug
  hw/ide: report ATAPI UDMA5 with a matching standard and cable
  tests/qtest/ide-test: cover the UDMA5 identify words

 hw/ide/ahci.c            | 136 ++++++++++++++++++++++++++---------
 hw/ide/core.c            |  23 +++++-
 hw/ide/trace-events      |   3 +
 include/hw/ide/ide-dma.h |   3 +-
 tests/qtest/ahci-test.c  | 147 ++++++++++++++++++++++++++++++++++++++
 tests/qtest/ide-test.c   | 148 +++++++++++++++++++++++++++++++++++++++
 6 files changed, 423 insertions(+), 37 deletions(-)


base-commit: 7f1fc6c9b9d2859577fb8837e05ca6eaa5a8a0ba
-- 
2.53.0


