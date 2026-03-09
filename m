Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF61EF36E4
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 06:45:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzUM9-0007u4-7i; Mon, 09 Mar 2026 02:44:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUM7-0007tq-N8
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:43 -0400
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1vzUM6-00026f-9g
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 02:44:43 -0400
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-56adf76631cso2441449e0c.1
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 23:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773038680; x=1773643480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JhBJGCljjR2vWP5NBGBE3Ox/OrYcaC529yay0waARyQ=;
 b=I+74fDAvxlffDD3oKWLOMO6bAUVF1MTQg2LDOCseUUnRjUitOND5lernzV19pB4sXG
 9L4CQdnrsIt1AITEvzI1VpIq5v4ALBnnG96Bsq33axCrLic6brrhm5LvjcnY+DPMier6
 J64uiNSzA/J3qEyEWAqCptknLTxbISvyQjC6ZaQNWlkw7njNlYG5tzgcEy61NUQ3RB7v
 diM3f+O1O5aWqc4XAKCDAak+Yb6Y8g48VfuOYJQ3q6dm3QEnAEaPj9EN1my0FQ2xWZ2X
 +3LMtLh0qYxNRnHTOvnU0hFa7CXzjv+rC76nWI6BinjeWM2K67RX3h6sDWuVUXImLNEK
 F9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773038680; x=1773643480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JhBJGCljjR2vWP5NBGBE3Ox/OrYcaC529yay0waARyQ=;
 b=wwIhcMfu/ewbhnSPll1eDc4QleQNyMUxvRyR3dBvJIi4snHydi/B1tqWxnF4axDFUB
 0UCzutLEtVAf/E/N0LBl9PKlmpWzBH4NcPmrX2GoKVE25QxtNHzNZDla+64gugN9e9Q5
 A4Lq92gWDVeTuoCZe0FLstx2pJu4sWQhp5oWna/1/fiZx6WEcoyQy0ch5AFs2hHQsRwV
 BRx+dbWsz/PTBFLyXVCWALjY5Wh2Tx+3IbaVJksOl462YdZMXIzOz2U6VLIaEUjFiqVc
 0kK9Z/xxnaBSGtwutQ2Ndygo4hkb8yKKBdGlMBpGN5sM+txvfFqeUpullHc2ZoyUl63V
 lmPQ==
X-Gm-Message-State: AOJu0YxtRirOrVl1+qwc8DUC/SNEBYrf5sT1tKH9xCSsxXBZN/vmH2ss
 Y8cixG2pBIhCq8v6gzpDZAPxWMvnkdS9pbb1gVWds+k0qRWZWOKTJcRkYO7tKuDu
X-Gm-Gg: ATEYQzzJK9iZZOmYoGHHXrsgvTGeXI+B/SQ0CCQ1R+2JP7x29lemdBv8Spp8mxjBTZw
 MUPBCny86plPVcupn+lQiKuVpgFlN0+NqjO0GLABB0MX68O5a+xkwf0LRj0jpZ5FyHPA220Qn+c
 YPpCEYMxu5PcfqdZabR3thuX1h1iYg177AS+eOFvjObq9WXUTRB3+IJRnpYaO3zSwICVQvIq64d
 p0eFtokyWq6ZyBVUacJ0eCvWN2gtmD6oz0jizykE1iYZezsmuklsfcGWE3mqSNn6H9zsLY2pSuD
 0jQZ6oCYFGSoDJyANEStDy2S8SjxyqqRdpdrHldtN2Gp8vFPBFGKyK7p8Buwha66su3CHixGapk
 DbrGdjGcMSXBmY99dSLyAdNy+BWW3asRJ340rLynPHInh7eg56s0Gtdsj9jYRa0twdvEcI3gmie
 s0lEKeEBPXzPoncxh3nDIcwHauG1hDWkLOwZhLe+WSVDngX1fZPNcvEy2GtA==
X-Received: by 2002:a05:6123:4b:b0:55b:16ba:2854 with SMTP id
 71dfb90a1353d-56b07d15b1dmr3664236e0c.5.1773038680128; 
 Sun, 08 Mar 2026 23:44:40 -0700 (PDT)
Received: from gmail.com (ip190-5-140-138.intercom.com.sv. [190.5.140.138])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56b09a0881asm9247726e0c.4.2026.03.08.23.44.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Mar 2026 23:44:38 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PULL v1 0/5] xen: pvh: Add machine option to disable the mapcache
Date: Mon,  9 Mar 2026 07:44:30 +0100
Message-ID: <20260309064436.51860-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-vk1-xa29.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

  Merge tag 'pull-11.0-virtio-gpu-updates-060326-1' of https://gitlab.com/stsquad/qemu into staging (2026-03-07 11:22:16 +0000)

are available in the Git repository at:

  https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/edgars-xen-queue-2026-02-09

for you to fetch changes up to 83d1d9a49e8eb970f87508ae4ce0f222084df365:

  hw/xen: xenpvh: Add prop to enable/disable the mapcache (2026-03-09 03:24:02 +0100)

----------------------------------------------------------------
Edgars Xen queue

----------------------------------------------------------------

Edgar E. Iglesias (5):
  xen: mapcache: Assert mapcache existance
  xen: mapcache: Add function to check if the mapcache is enabled
  physmem: xen: Conditionalize use of the mapcache
  hw/xen-hvm: Add a mapcache arg to xen_register_ioreq()
  hw/xen: xenpvh: Add prop to enable/disable the mapcache

 hw/i386/xen/xen-hvm.c           |   2 +-
 hw/xen/xen-hvm-common.c         |  18 +++--
 hw/xen/xen-mapcache.c           |  16 ++++
 hw/xen/xen-pvh-common.c         | 134 +++++++++++++++++++++++++++++---
 hw/xen/xen_stubs.c              |   5 ++
 include/hw/xen/xen-hvm-common.h |   3 +-
 include/hw/xen/xen-pvh-common.h |   2 +
 include/system/xen-mapcache.h   |   1 +
 system/physmem.c                |  14 ++--
 9 files changed, 170 insertions(+), 25 deletions(-)

-- 
2.43.0


