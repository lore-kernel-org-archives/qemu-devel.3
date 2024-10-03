Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451C5CF34BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swR0e-0000kR-HW; Thu, 03 Oct 2024 14:57:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swR0d-0000kI-3g
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:57:07 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swR0b-0003I6-Gb
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:57:06 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2fac3f1287bso16286801fa.1
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727981823; x=1728586623; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cdaNDaEOcn6vuQNjiuMDjzYnUO3vmcmh1n8TpB8KZRA=;
 b=W43hLgmmjSip2tlVA+ffn11EfzXt8flBfzFP1Ot/2KH2vxmg1MUBkSHJQN2DwW43Pk
 j51/T6rD1k3LJZISfkNdMgiM/F/1Ag+EMqdP9eVERseUw6EBjxbShE18bt5IXUk9CQzb
 pbtvhsLwQcZN21wzC6prgioure/KYd4QMTh724aMACU+uGnsjpFTZJz0E3KF72i03Nwh
 x1vgpw+UG+D5nyfxY1mQV7oLrAnQlEumA3v+13VWsWwuEf7PMC7AhVTcC0PLRwrRX86t
 lY0InOQt6FA9H+cHxQobmCeIOzrvFtiFfXiviJYD/7h0dl17ywPE1LQaB0Mf1dqw5hj0
 1Z/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727981823; x=1728586623;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cdaNDaEOcn6vuQNjiuMDjzYnUO3vmcmh1n8TpB8KZRA=;
 b=RtakYjIHb05MmZa9fTXpqQq4uA5uL7bpQYNF4Fc0YPv/e3Urv3po0BEeKDhniS/o6f
 EOwFq5jI7XTULAeb2YYGMftHJL5iDEnl8R1IpFhFyPtCTrFgNF0m/haP537Srejz3Gw9
 NTZMP/59iUa8fg0w5jzXJHnKxzO72/+XVKnr8qSDC2jZLhaL9CH2faEpyY8L5uL8YSE8
 jRrtNwhswkyqmUdDcecihqyeGx2CKDJlfgD95tC17n2neYG8b0xszIYXtrEItVKdSqB1
 SAzjjRo4DNv4Ld+oiiKbxWO+wwKU0NwzFezgmrF6KZcgeYGk2bc36xgo9kvAkvC1t3Yd
 5POA==
X-Gm-Message-State: AOJu0YxmaYygmBJm4UpXqiVehTR72/wovL1ZvtZXOAn3mSum4TinR6fq
 32sr7AYN1k8We+Pv1htYRodA+cCQb3dHOv0ZFuCchnfWXlrjky6XKQOnvRE3
X-Google-Smtp-Source: AGHT+IFdeBkkNKz7zU2CTecNYILP4aX1U9f8WPyScxz91qp4ENEdsSBhsUSyvViSiJmd41SQ99VMWA==
X-Received: by 2002:a2e:b8c3:0:b0:2ec:55b5:ed45 with SMTP id
 38308e7fff4ca-2faf3c420b2mr190871fa.24.1727981822607; 
 Thu, 03 Oct 2024 11:57:02 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faecbf6feesm2796571fa.18.2024.10.03.11.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:57:01 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PULL v2 0/5] Xen Queue
Date: Thu,  3 Oct 2024 20:56:49 +0200
Message-ID: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

The following changes since commit 423be09ab9492735924e73a2d36069784441ebc6:

  Merge tag 'warn-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2024-10-03 10:32:54 +0100)

are available in the Git repository at:

  https://gitlab.com/edgar.iglesias/qemu.git tags/edgar/xen-queue-2024-10-03-v2.for-upstream

for you to fetch changes up to ca9275a4b11aced3074219d1712e29fce5036f72:

  hw/arm: xenpvh: Enable PCI for ARM PVH (2024-10-03 19:37:35 +0200)

----------------------------------------------------------------
Edgars Xen Queue.

----------------------------------------------------------------

ChangeLog:

v1 -> v2:
* Removed left over trace call

----------------------------------------------------------------

Dr. David Alan Gilbert (1):
      hw/xen: Remove deadcode

Edgar E. Iglesias (4):
      hw/xen: Expose handle_bufioreq in xen_register_ioreq
      hw/xen: xenpvh: Disable buffered IOREQs for ARM
      hw/xen: xenpvh: Add pci-intx-irq-base property
      hw/arm: xenpvh: Enable PCI for ARM PVH

 hw/arm/xen-pvh.c                    |  17 ++++++
 hw/i386/xen/xen-hvm.c               |   4 +-
 hw/i386/xen/xen-pvh.c               |   3 ++
 hw/xen/xen-hvm-common.c             | 100 ++++++++++++++++++++++--------------
 hw/xen/xen-legacy-backend.c         |  18 -------
 hw/xen/xen-pvh-common.c             |  40 ++++++++++++++-
 hw/xen/xen_devconfig.c              |   8 ---
 include/hw/xen/xen-hvm-common.h     |   3 ++
 include/hw/xen/xen-legacy-backend.h |   5 --
 include/hw/xen/xen-pvh-common.h     |   3 ++
 include/hw/xen/xen_native.h         |   3 +-
 11 files changed, 132 insertions(+), 72 deletions(-)
-- 
2.43.0


