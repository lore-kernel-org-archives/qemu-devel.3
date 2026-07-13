Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B26C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 16:18:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjJME-0002Ly-C1; Mon, 13 Jul 2026 12:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLt-0001y3-Ej
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:54 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wjJLq-0008Vj-7a
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 12:17:53 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-47dec32798aso3443069f8f.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 09:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783959469; x=1784564269; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=N7uGcJeREMWLTkeTLdpRAqEh/loC4iEhaX1xc+4Q7oY=;
 b=v4Vgpz0jBAEZ5T8/xs8g3csBjTd3mzoWl2VvQbTDt8IBWWfY3DdZiVNv7FU7KZtNCM
 wfFeWcpCueinDBv7buAJ4Aco7ZRMy8Mq38rlEaWcyawWZ5usy0czd9bVGAlhUEi+xmFa
 K5Rkkec5ms+pUeY375vlWcYZXQkB4tLg/BjQSOrH7QNhG6ix64P+YWluLz/8Xicgg/2K
 QEKV/+cI2l5BEZPCqtKfebAI6ecCSLn4dU+VbRfShqGaBiSX5iUsfVZZJ82cjxd9vU0W
 P3ZKoUaTJP3noJEQ4SasQzPuVsEZfMcVrfqz2pRKZzGz/Iw+sKsS4swmgoaKBWZ9Sgrf
 Vs5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783959469; x=1784564269;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=N7uGcJeREMWLTkeTLdpRAqEh/loC4iEhaX1xc+4Q7oY=;
 b=HuHZImGCX/YoBLdES93rsoGehDnKn4M8+UL7sSW2lcwHKwHwsHKsDC5ZBpHgN6WzKq
 kIV7M3hw5SWSWEcxBRSOfzCxN3R/tqnEbZ/2CtO3c/Zx9u1F+4RDaFCpeKioE192X4i2
 4NpzPeaubLKzVjcv1SVNkQzktFhIvMZdhp3Sl3wHvbYSAGQ5n/L4pZIXmUM9ZZNao7yu
 HmWLkfw88qXNT/mGDrN7qmTvJRky2vvWu8jC24xxtb08dU/wOxgv4ddzK0RZqA7aOruv
 BQIF1ph+HkC6IOXAKkmjUooNtZB+EbhDUEEnrtp+a9wzYnvt2fJahtObnGTA3i3FxlXf
 VMag==
X-Gm-Message-State: AOJu0YxIQMqk73SfjHu7pqo7B2hcbdJHaoycXyFAUQkWGJkPy1I+xrW+
 14WMib3aef+hvPXdXxzDgmDmec/LcvWWn8/euuOsRmzwXg4a4pen9hzRhJVewnpt4n5JvvyMBox
 gOH9U3yQ=
X-Gm-Gg: AfdE7cn4qqVd93oPPJg3IZ2o4RjpNzqwwl4brfeMrZ4Rkz20uO38Lc8VEOzkDJXUBdM
 4Vuel6/qXWaTfxeRnENdWA+HIWqfjHEqVyu8YcxMc2V1Oz7Fx4anGVUjCgnCsAdIG1jVlkBIdMC
 mKLyGpC6Id7Wb6u3BTomYsonPQj7Y5Rx/aostP+vetDbikHZtsGi6fZxSQeikJvmzlg8EKQhD4C
 ZXGShv3dsf6GHUYLKl3ECJ5EHJypji54mDzgtwMPTOPpfT0f/bmT56M0m/tC20hGutaZbBAiT+8
 LUB9iv0A3YG/nAgfRx3SgliDkO+Cy4L/JzDAAlWDVOovPCGxpYW3QFdEHQ+HxVClDVoMsxNYHUR
 jfBt3zUcGY42BiRT8wvSbuA6rnTTIbnmkirha3TkCNjFDe0MdOmUsFHUnoefh4golHx9+O/jZae
 mmLYb+RoMoSuBH
X-Received: by 2002:a05:6000:2f86:b0:475:c578:b619 with SMTP id
 ffacd0b85a97d-47f2dcd71ccmr10639121f8f.30.1783959468692; 
 Mon, 13 Jul 2026 09:17:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4634e5c3sm483561f8f.1.2026.07.13.09.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 09:17:47 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8814B5F80F;
 Mon, 13 Jul 2026 17:17:45 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 0/7] gitdm metadata updates
Date: Mon, 13 Jul 2026 17:17:38 +0100
Message-ID: <20260713161745.53889-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42d.google.com
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

The following changes since commit 499039798cdad7d86b787fec0eaf1da4151c0f05:

  Merge tag 'pull-request-2026-07-12' of https://gitlab.com/huth/qemu into staging (2026-07-12 21:49:04 +0200)

are available in the Git repository at:

  https://gitlab.com/stsquad/qemu.git tags/pull-11.1-gitdm-updates-130726-1

for you to fetch changes up to 651c451c8e576989e3086a2915c50a9a72356cb4:

  scripts/gitdm: migrate from contrib (2026-07-13 17:13:11 +0100)

----------------------------------------------------------------
gitdm updates

  - various mailmap fixes
  - update IBM gitdm map
  - add more individual contributors to gitdm
  - update Qualcomm entries
  - migrate gitdm to scripts/

----------------------------------------------------------------
Alex Bennée (3):
      mailmap: add fix for Zhongyao Chen
      contrib/gitdm: add more individual contributors
      scripts/gitdm: migrate from contrib

Alexander Mikhalitsyn (1):
      mailmap: add email mapping for Alexander Mikhalitsyn

Joel Stanley (1):
      contrib/gitdm: Update IBM map

Philippe Mathieu-Daudé (2):
      mailmap: Fix Ryan Zhang email address
      contrib/gitdm: Update Qualcomm entries

 MAINTAINERS                                      |  2 +-
 .mailmap                                         |  3 ++
 contrib/gitdm/group-map-ibm                      | 15 ----------
 gitdm.config                                     | 38 ++++++++++++------------
 {contrib => scripts}/gitdm/aliases               |  1 +
 {contrib => scripts}/gitdm/domain-map            |  3 +-
 {contrib => scripts}/gitdm/filetypes.txt         |  0
 {contrib => scripts}/gitdm/group-map-academics   |  0
 {contrib => scripts}/gitdm/group-map-alibaba     |  0
 {contrib => scripts}/gitdm/group-map-amd         |  0
 {contrib => scripts}/gitdm/group-map-cadence     |  0
 {contrib => scripts}/gitdm/group-map-codeweavers |  0
 {contrib => scripts}/gitdm/group-map-facebook    |  0
 {contrib => scripts}/gitdm/group-map-huawei      |  0
 scripts/gitdm/group-map-ibm                      |  7 +++++
 {contrib => scripts}/gitdm/group-map-individuals |  2 ++
 {contrib => scripts}/gitdm/group-map-interns     |  0
 {contrib => scripts}/gitdm/group-map-janustech   |  0
 {contrib => scripts}/gitdm/group-map-microsoft   |  0
 {contrib => scripts}/gitdm/group-map-netflix     |  0
 {contrib => scripts}/gitdm/group-map-redhat      |  0
 {contrib => scripts}/gitdm/group-map-robots      |  0
 {contrib => scripts}/gitdm/group-map-wavecomp    |  0
 23 files changed, 35 insertions(+), 36 deletions(-)
 delete mode 100644 contrib/gitdm/group-map-ibm
 rename {contrib => scripts}/gitdm/aliases (97%)
 rename {contrib => scripts}/gitdm/domain-map (94%)
 rename {contrib => scripts}/gitdm/filetypes.txt (100%)
 rename {contrib => scripts}/gitdm/group-map-academics (100%)
 rename {contrib => scripts}/gitdm/group-map-alibaba (100%)
 rename {contrib => scripts}/gitdm/group-map-amd (100%)
 rename {contrib => scripts}/gitdm/group-map-cadence (100%)
 rename {contrib => scripts}/gitdm/group-map-codeweavers (100%)
 rename {contrib => scripts}/gitdm/group-map-facebook (100%)
 rename {contrib => scripts}/gitdm/group-map-huawei (100%)
 create mode 100644 scripts/gitdm/group-map-ibm
 rename {contrib => scripts}/gitdm/group-map-individuals (96%)
 rename {contrib => scripts}/gitdm/group-map-interns (100%)
 rename {contrib => scripts}/gitdm/group-map-janustech (100%)
 rename {contrib => scripts}/gitdm/group-map-microsoft (100%)
 rename {contrib => scripts}/gitdm/group-map-netflix (100%)
 rename {contrib => scripts}/gitdm/group-map-redhat (100%)
 rename {contrib => scripts}/gitdm/group-map-robots (100%)
 rename {contrib => scripts}/gitdm/group-map-wavecomp (100%)

-- 
2.47.3


