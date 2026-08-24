Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92FBDC5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNEH-0008L7-HM; Mon, 24 Aug 2026 01:28:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wyNEC-0008JJ-Q3
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:28:14 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wyNEB-0006eA-7O
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:28:12 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38e58034d05so2513462a91.2
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787549289; x=1788154089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sGjajCWfdF2x7qs7F7w0oRICZYPH98Ewuwa/scOuWT4=;
 b=MYVlyT60PLjcuxm0mGZfZf4DpSw5ZUAYbqVx1SFewjBullynKtTd2LcSPdaGTbvCQN
 5DlOtqUQcMkvHv7vL/FRz3BY4Tq48VVTLMUfRgmpuiTawctkxlg0MqHbHAvS7lCzXRWt
 f4Txtjvcs0eL3NqrFhCbE4rbxPQgdf8VdEDG26Hgysk22EJXMKPA2Z+UUup7wNVAJbgw
 pvg1pIuUhHb+hqE7c25HxzR0iHqpYHGcUGzlE01YYVAcdyTv1nUGco70Mbx1iGEr0FLR
 /GJ0TdHRrKipnw8dJM5UevOgMVJxTAA0hmnvObRCtXFyj+ltTuuvCLrFyUetNLLcgrOf
 GiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787549289; x=1788154089;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sGjajCWfdF2x7qs7F7w0oRICZYPH98Ewuwa/scOuWT4=;
 b=eRj4PKoqNdFRvDTTQZSvAQCEM/nm83Yo/3bKQx1FcmYpoqfiLu/tKaZ21deNWB+85D
 tKcRzK3mIznU8Xq+67tSwWAWhpoxouMPGK/T1xGJ0one4XbBFcP1NCEM25D+ipKYalGa
 8+iO3VSEMMHeeu7VZZB7MXjWDM1g0gLMUGbxGxIMQx8/WGuZY4basz+/2cqN3U4V7Wl6
 6WvQCW9RDQkNUzRTDIO3Ux6Q/WqRhp+ttXPQKkSh08//4jDrv54mBm3Fp0h5HwlD7FsP
 P6seLHQPyJ2/tnvQBWFafPDI/uJ754Ku9TFrqfj0s38qszM+QT4wdb6hWJDMLL3FztKQ
 TxsQ==
X-Gm-Message-State: AFuF++k7SzIskeOilF/0zk9pVDce82aeHxYYTB01oGwNfRuT3JqlB39e
 FPkD57GahxpwZsD6RHcrNZ43X7QpdXn5JchdAFdMVh9bAsLYhqEhmrvolXm09g==
X-Gm-Gg: AR+sD10eDiHcq7PByCtrdrRJVI+cXyI6ZU9KPpVB9uennhaHwKkxcnCFwd4fUdnCDZ5
 wsXuTmuHPKnodDlPlt2YotVQ7fZfm7G+oMoqMn7+BbRCqhw6PqVvaL+Yic5kfho+qpBC/7eH3Qv
 tYHo8n4NYWtosZcmZjR7PZ4nB16uxu9tq9h/AFoG5JG2lbp+LiJcn2Gt5ZGr1uLPYA2gVkV6N65
 7Mgu/BldsTVt6PMG/s8CkwUOO05jcDr16KNVCsIEQILOolppQmyAq2Jv7ZAxktUWRyE/qX9Wytv
 GFh/TkPqWW3Xuq1X4P/KH3AojvbWdCE4KPWVkWlvnP5amRA3te4Jchx0jJUNmpGMpzsLdZybIXg
 FLs/hxLTuejDN8VzcMUbsn6cLBg3/hU2BahMv6Q+RuIhV+DsUgvgFFrmpj/TEZ5i+OBgYq7H+pV
 b5ewWH7cCZMU2OOoZn1hBMn32A3qFQEVcszMkcNMXCjN+BzZs9R+6HakQdgpO2Ggl/qg==
X-Received: by 2002:a17:90b:57e5:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-395c35f0a79mr43391816a91.14.1787549288875; 
 Sun, 23 Aug 2026 22:28:08 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395e494f9fdsm8557346a91.3.2026.08.23.22.28.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:28:08 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, mikail.sadic@ibm.com,
 clg@kaod.org
Subject: [PULL 0/2] ufs queue
Date: Mon, 24 Aug 2026 14:27:54 +0900
Message-ID: <cover.1787548791.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit eea8fe61b8be8f3016e522e6af24924a0266ca95:

  Merge tag 'igvm-20260821-pull-request' of https://gitlab.com/kraxel/qemu into staging (2026-08-21 10:39:31 -0700)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260824

for you to fetch changes up to 6ed05d5e65208a5ee23a02667d5df0dc6491c156:

  hw/ufs: Add a generic SysBus frontend (2026-08-24 14:17:29 +0900)

----------------------------------------------------------------
ufs queue

- Separate the UFS controller core from the PCI frontend

----------------------------------------------------------------
Jeuk Kim (2):
      hw/ufs: Separate the controller core from the PCI frontend
      hw/ufs: Add a generic SysBus frontend

 hw/ufs/Kconfig      |   9 +++++
 hw/ufs/lu.c         |   2 +-
 hw/ufs/meson.build  |   4 +-
 hw/ufs/trace-events |   4 +-
 hw/ufs/ufs-pci.c    | 112 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs-sysbus.c |  80 +++++++++++++++++++++++++++++++++++++
 hw/ufs/ufs-sysbus.h |  22 +++++++++++
 hw/ufs/ufs.c        | 109 +++++++++++---------------------------------------
 hw/ufs/ufs.h        |  14 ++++---
 9 files changed, 260 insertions(+), 96 deletions(-)
 create mode 100644 hw/ufs/ufs-pci.c
 create mode 100644 hw/ufs/ufs-sysbus.c
 create mode 100644 hw/ufs/ufs-sysbus.h

