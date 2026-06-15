Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B7C0CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 14:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ83C-0008S1-Gi; Mon, 15 Jun 2026 10:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wZ834-0008QU-UB
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:12:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wZ832-0005Es-SJ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 10:12:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4908b92904fso41580015e9.0
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 07:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1781532739; x=1782137539; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4HpkrQTadd0SDUzrTv/9psVOFh7SOndt/bxm2wN5sIk=;
 b=YT+RF8hGpFwvv3Kx2n4LtbWuQm6R39d96svFDvdNVtP3LA9v3fF0UVYLSjpIh59SPU
 9+JyrgyOLVZFziQMPvsvmIDtJuz33PwQRvzRg7XeCUm3lHaCUAF5EkYDum0v3TFV5L6p
 BDdJrKQXLO1Jyp2apL50bdBSJZtR8FDHrH9MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781532739; x=1782137539;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4HpkrQTadd0SDUzrTv/9psVOFh7SOndt/bxm2wN5sIk=;
 b=gcv0F7gr4ShVEeKAPTGHnVl7kVB5tUn8vlIpuzmKHdyRtTlLLaaS9gAinLrfs6t8Bw
 TJudexMnwZX13sR9yytRT3QSnRqMMdkUk1YNLdMFnFIz4CbyC9C6h0GRh8eI2pxUGXJA
 f5zbNpag0QGRNG4en+D2SdYuyzk4vgNFtwxTCXVZZCOO+QbwlSnqRlIUWbdLGhSk6jBK
 ROB/I3fRZmhX0XuWlP75jnezPKh6uR/pYftA9kg6VwgNWSf2rf9Pi+fnnC6q1MtY9XYA
 vpDwoAS+uk9Z/A+ZxIQ6dC/5ZAz1ME9lPCIhNiBBN9JbVr43h/JS7ps1AMaDJW4PEnL5
 88NA==
X-Gm-Message-State: AOJu0Yz9vm/H/rHVGu4kE+5dZN5Ygj1kg8LdNXk/zWgbPnEhUuWw8u1i
 ffLmeHIWgNMaMr+JfYRSrWllaXZVL7lYq9RltwRidJ4P8sHmu3y+Tg2IwdLs4kTMWYzQB+1lDii
 I6B/SitU=
X-Gm-Gg: Acq92OEssoTefss9tdm3pIyXqhgQvEGYqrF8R6Wr2tQUIsde9al1XhMyhNBlfbHeQit
 aCvkJuyYS3Gm8buvyBZYcJ8HXSejqWaNV/sDXiAlLP3a98/1hgtuB/e0zTH+2NDwUmE6YqBzeai
 s6hANWkgLX+61Wj7AxjK5Y1iq+1q1D0xYBc67dI7NcMW3VLLvv6FKrdbQ/Rb78IPlRhCM4kSDMZ
 JhVJHVZVb4y1uNZeX4NED6qZ9z7gZ+g7Aa8bP5PdpeC03+6nuRK/TRQsrHqGOAIYn4idqIs//j+
 QWq4obqbbej+TxWYPiZPxovzJGUAGb5duIdrg7dfMPfgWsSJ0aemdjYmgmZloU5p8nhNzfe3806
 bVazLFLwLXINx0wEmvOvbEoE3uHw/tOIyMJqgzVVTdHCvtshJpKZzCLmt9yRoWn+W38NZb/QyD8
 InWSke/cpVV+xQmmXOjP8sPFLcQgF7m4G+izpu7qBx3B/TFcwwFSChXBRfkAG+MUbrHHreIKMOT
 c8=
X-Received: by 2002:a05:600c:3583:b0:490:5466:8591 with SMTP id
 5b1f17b1804b1-490ec4e74dbmr234350575e9.12.1781532738451; 
 Mon, 15 Jun 2026 07:12:18 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720000000000000009a8.dip0.t-ipconnect.de.
 [2003:cf:574a:7200::9a8]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea4b39e9sm213758215e9.0.2026.06.15.07.12.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 07:12:18 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Jesper Devantier <foss@defmacro.it>, Keith Busch <kbusch@kernel.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 0/2] hw/nvme: support online resize
Date: Mon, 15 Jun 2026 16:12:14 +0200
Message-ID: <20260615141216.162388-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32b.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Dear friends,

This patchset is aimed to support online resize for NVMe emulated
device. My approach is simple - I just implement (BlockDevOps *)->resize_cb()
callback and ensure that AER notification is fired to all controllers using
a namespace that is being resized.

Testing.

I manually validated this with Debian 13 VM (a resized disk was a root disk) and
Windows Server 2022 (a resized disk was a secondary one).

Git tree:
https://gitlab.com/mihalicyn/qemu/-/commits/nvme-resize

Changelog for version 2:
- checkpatch fixes
- rebased
- CI is green (https://gitlab.com/mihalicyn/qemu/-/pipelines/2602102750)

Kind regards,
Alex

Alexander Mikhalitsyn (2):
  hw/nvme: initialize ns->subsys for n->namespace
  hw/nvme: support online resize

 hw/nvme/ctrl.c | 10 ++++++++
 hw/nvme/ns.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/nvme/nvme.h |  2 ++
 3 files changed, 79 insertions(+), 1 deletion(-)

-- 
2.47.3


