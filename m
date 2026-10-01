Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AABCA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 23:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCQHR-0003Oq-Nr; Thu, 01 Oct 2026 19:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xCQHQ-0003Nh-4Q
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:33:36 -0400
Received: from mail-pj2-x2b.google.com ([2607:f8b0:4864:39::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <portias@tenstorrent.com>)
 id 1xCQHO-0002BT-FT
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 19:33:35 -0400
Received: by mail-pj2-x2b.google.com with SMTP id
 98e67ed59e1d1-3a49b3e7bc3so585721a91.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1790897613; x=1791502413; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DUwciZrhb35dWobbDbyl9C2LkylNosQiGSNTw0bMY5A=;
 b=f79O3Xxm8vpbMKqorWWyZlx9HA4bxBAQo6AJ8vuy9sTL5KqwJgDCxQC/i9qH0skC9c
 PWHqttpw4puYDdt+oo42pXxHbe1ze86SKlIDD+fOUgzuSBGr63+QqdSk7IOn7GJyzWa4
 AYcPMPx8xkY4RuzVoqlTCQy8ML7FIYvpxeppaYl2hiVPYRuue7mxf1Agcve+I4Qhytp/
 Rc4BAOaIX34Zkc0BMm8yH2zd1YAj3O9wTWBE4Tga9fjFIx76UC4gpsGi4L2rchquv4Vj
 roI6TwyF1iR0peyzwWATvt7/SAbyqW3/mtYFWSs5pid+I1MjGPGiPGilw4iCfkX37mtW
 Nrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790897613; x=1791502413;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=DUwciZrhb35dWobbDbyl9C2LkylNosQiGSNTw0bMY5A=;
 b=iD5NGM/SXODcFo/FVXBywLIUbpkfVrDp/WQlWhBorvm2w7B3S9eZ6hKQmTolJ5OYuI
 ojFPRpkkQxMFt7MOy5oHeQsN++p8tBfHvonxYTwd5PFURMicy+sDCPtIQVdC8sCQYSyG
 za0EO736AIrdOooTV1QFR6OcAeGxO0IV0Vv20Nzo7FycYLe3+duxvR0td21fqWbFqgsk
 Xrr/tF7o3aYB3ngS2uSiq6p7dxNUKDEqfa8qZO7q3Bh4bIWt1afX91cCzWge8zURsAG3
 wwdreLy/9MztlCsgUbqAcR3YPPrRBxraYMNgmyUgAz9nxA2T5406jGFMIF8W6TqtyVC/
 1Kjg==
X-Gm-Message-State: AFq9FYIsj/jcRhg7Ai7B9+iNbnUi11jn/SqgQJrHHT2HduE+dNcrLkhJ
 +ZRMaraA4ssslyShbAfsj2YTKdYNT6J+6fKBzgk6rVBpL0YfI2OX7G4saHuanNrYli9rSG/keRb
 LGkdBFRs=
X-Gm-Gg: AYBFou1xPRK9zp+mjC3oJmaLeXGsEy1PcVw4WSZMBrBAiP7hbUy9U5zHzs2vbf6/Bm2
 E0mErB8ZlDVnpvN1uUVMiW1gX6nAsTfdxkQW7uQPy6F1fO17cRlj6OUT63l2sTBgAATPsPvn27J
 BuI8OO2MOx+GKbMoDgwIvlMwS7xWLRD+t/gymYundeW2fKVHS4cEeBbvBoNMUTDvolwH2YcTUaL
 M2Lz8Wlwmht9pSloIsMXzwoXhpHO/Yr2Wtf7TeOeSclbaKXp9IgP7ag6NjLWcxNpdzw0SX/i2b8
 GU8L59w9iULAfCGz0VOypJxV4xBLqWr3uhO7DbvyzE9VQe69oZkMmBU854wCV+K7O1DOGH2w/iH
 tv9TVWGO9ci8W9AwimEPLlF8Af7ozK343yeuzisTcUXymt47KHyq019Vv26pU+AKlrm/AZdXus7
 ro02QQS1LPzPvj7GjRO33QGuu2iVC+DWriEEa7lonfg70pPMApDJysXohwMaWGNUO4OWfHqUrq7
 xDBkAaUGNXHCtg2yO+RNiJbu/k2oBVdnrSlSDz7w8r6/10=
X-Received: by 2002:a17:902:da85:b0:2df:8ab7:fe3a with SMTP id
 d9443c01a7336-2e49b66ee56mr12239775ad.4.1790897612691; 
 Thu, 01 Oct 2026 16:33:32 -0700 (PDT)
Received: from lima-default.tail89d63.ts.net ([159.196.41.205])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e49f6aea97sm1851855ad.45.2026.10.01.16.33.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 16:33:32 -0700 (PDT)
From: Portia Stephens <portias@oss.tenstorrent.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH v3 0/4] Improve modeling of the Atlantis UART
Date: Fri,  2 Oct 2026 09:33:20 +1000
Message-ID: <20261001233324.2636629-1-portias@oss.tenstorrent.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::2b;
 envelope-from=portias@tenstorrent.com; helo=mail-pj2-x2b.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The Atlantis SoC has a DesignWare UART compatible with DW8250. Previously
the Atlantis machine had used the ns16550 UART with an unimplemented memory
region backing the DesignWare specific register space. This updates the Atlantis
model to use the now modeled DW8250.

It also adds the remaining 4 UARTs that were not originally included in the
machine along with a machine property, console. console allows the user to
which uart is being used at the console and will be mapped to the first
serial interface.

Changes from v2:
- Fix typo in documentation
- Fix white spacing issue in machine help text

Changes from v1:
- Drop DW8250 fix, to be squashed into original patch which is not applied yet.
- Use qemu_fdt_setprop_string_array for creating compatible string
- Change machine property,console, from string to uint32 and set default value.
- Documentation fixes

Portia Stephens (4):
  hw/riscv/atlantis: Use dw8250 UART model
  hw/riscv/atlantis: Add all UARTs for Atlantis SoC
  hw/riscv/atlantis: Add machine property to select default uart
  docs/atlantis: Update Atlantis UART documentation

 docs/system/riscv/tt_atlantis.rst |  19 ++++-
 hw/riscv/Kconfig                  |   2 +-
 hw/riscv/tt_atlantis.c            | 134 ++++++++++++++++++++++--------
 include/hw/riscv/tt_atlantis.h    |  14 +++-
 4 files changed, 129 insertions(+), 40 deletions(-)

-- 
2.43.0


