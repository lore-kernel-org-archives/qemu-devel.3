Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50FFFC982D0
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 00:08:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7M9p-0001AL-OH; Thu, 17 Sep 2026 20:08:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x7M9j-0000sr-3X
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:08:44 -0400
Received: from mail-pz2-x0c.google.com ([2607:f8b0:4864:3b::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1x7M9h-00052y-97
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 20:08:42 -0400
Received: by mail-pz2-x0c.google.com with SMTP id
 41be03b00d2f7-cc52bd91929so60409a12.2
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 17:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789690119; x=1790294919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D8t/7DvLZKNcUgRcgHRPuupd3/mjNHm3EDr0GaXiQkE=;
 b=qZk0/5hRmRVb9hz/hHYcOA6viU98+H6Rx9g9ssKrjbPw1LZz1jFtg+NB+s/0zhimLP
 gA5nt+AB4642P7B/ZFr4aXHMSzRKYbg5/xBmsqkh9IRED41DiJE3KNdm75z0HjyVtHNQ
 pfDvx29VS7xiV+bk8wgiPZjyYfZF85VXSGQGoQYXJD4NijitL1pPTavpzBhFIA0yMJ6v
 NvL5+0ni9GsTENQZhhr4PJRJsm8VnBM8Ez6uyd8uzZHl/W+ZbMJwd3w/QMwaytRgctge
 dxwiIDNaxVmX0Ns+jF0evYjm25FQSvKaLfeI5WlucqKdiyHXjCNgYqqTqr9vXUqCxi0V
 zQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789690119; x=1790294919;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D8t/7DvLZKNcUgRcgHRPuupd3/mjNHm3EDr0GaXiQkE=;
 b=dULiSh5EKLtpF1VzhBu7c4WqWiWAgz3E0/dPoOfijQ83lUFDi7T5Fm3el23mz2PC5U
 FMgh3q2ih46HD/uXT+uy+D18tqp2ArDytSi/lqhZ+1wku+/Z3XnXuBqzLqobgnKPx1hH
 t+pvEYk5FBc38K421oL8rlR1LW6pSTULj/Grt/TRzdiIaNO3iKV9Ecfmg1CUD4VNpmUE
 96S9Qa6J3bIpS1/OKdmA2/hRGIt9nUuABL11jfLRCaJj9vuCFYHecn3PLk8H00p5uwDf
 jHVM+hOhDE13crrnxfUdS6NQ2TOGo5Da7QCrKBGCkvpm7BhkyaPSH6ugSWUueuNEgyc1
 zGmA==
X-Gm-Message-State: AFuF++lnyrfYSAusnPJZoFDEi5o/4fUnPhlnJi3W0J9U2QqAKvuWnars
 vfjKKTBgYwGFaJVfEOwPe2/Tjqp9SzEGijBQBPkiiFw/alGrDrlVurxaCzYOxw==
X-Gm-Gg: AYBFou06tkyPIMgO5AwL3C5aknX/SV+xeDF4ywST8ZdHZIQZ2OJHeUlY9BWEgYlZkIc
 QUGSMFPDlnUoXliKgtU/XSKDdLjR9f8JgFKHpOCM3c8jaW0pwMuoQwLCgbEMmLgnRgC65zYbxdP
 Btq0WGBeCv8yMgKOm0PIWEnaarg38db+7axoV6NfXpvm5ucXMsjidxOkt2e/LEWOlck8QXPBj6R
 WdLQC8G30qPqyLrE6+6sWRuHMOMjw0HaGSIqvSh1pxhM4AbzUWV4RVCpF11NJtQNQ69zDofQBts
 YSafhjue50vcAZNXkk/HIfmjQd0oLXELpWmpzyTFOdFjyDMYq/VR9fbmCoVEtwmxWVai5JFmmKn
 5Fx0leMT+gIWqRhitbYy84pPKQ1DXUlvZziIvophsfiCC03a4v6EAhvx6Mk1mfQtyFOviokH4Qh
 E9I/GCRPkNbsiTB7i+ou/yhcjB5B44bprAGNjUNZ2wrDD08yl+Njf69J8QEW4gBqiKGQlOB9q33
 sJn
X-Received: by 2002:a17:90b:4484:b0:39d:f97c:bb2f with SMTP id
 98e67ed59e1d1-39e54b66cf5mr1681081a91.3.1789690119101; 
 Thu, 17 Sep 2026 17:08:39 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e5a5993bbsm33827a91.17.2026.09.17.17.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 17:08:38 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jeuk20.kim@samsung.com, j-young.choi@samsung.com,
 stanleyjhu@google.com, richard.henderson@linaro.org, stefanha@redhat.com
Subject: [PULL 0/1] ufs queue
Date: Fri, 18 Sep 2026 09:08:16 +0900
Message-ID: <cover.1789689763.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::c;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pz2-x0c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit c66824ffb01931be0ddfe49a1642a78570abf44b:

  Merge tag 'misc-fixes-pull-request' of https://gitlab.com/berrange/qemu into staging (2026-09-17 10:21:06 -1000)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260918

for you to fetch changes up to cc1d72231c925a632f360937d9eb48ea12bd539c:

  hw/ufs: Reset controller and MCQ state on HCE transition to 0 (2026-09-18 08:59:52 +0900)

----------------------------------------------------------------
ufs queue

----------------------------------------------------------------
Stanley Jhu (1):
      hw/ufs: Reset controller and MCQ state on HCE transition to 0

 hw/ufs/lu.c         |  7 ++++
 hw/ufs/trace-events |  1 +
 hw/ufs/ufs.c        | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/ufs/ufs.h        |  2 ++
 4 files changed, 105 insertions(+), 1 deletion(-)

