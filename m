Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3C4C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 05:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyNYZ-0001PO-Od; Mon, 24 Aug 2026 01:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYD-0001F6-81
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:55 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wyNYB-0001nH-QL
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 01:48:52 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-38dc69c74b8so3268330a91.0
 for <qemu-devel@nongnu.org>; Sun, 23 Aug 2026 22:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787550530; x=1788155330; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lfg+S33mxYhTkp+vJzcce1d3QWdWhesMvM16KE705Pg=;
 b=ME5JPmg6tW+hR831P9mi/1oSKDTS0f+Aw9sWP0yGTyU2HQ6a9BKiH0qUvXmfwo2Wiu
 ZwdplXtZy6p+rGFJ7BiXyuDYR79qcMFY2qm4iIb2QLYxVKPG5sFWoE9JXocS4IdPOnCb
 jtSCtO4yvbuiOGgfCOAZbsJVzVGm/Th8UogY+zqjLtYvNvhQrsH7MgTerwamOpJ2DXZJ
 3cSbU6d3GTbSdDld5lWawhRQMdIrwDJZyhyMpLF+1B4kyW7MRrH7DnII7dmu5MEH1wfr
 RmPBjA4FzXVtgo0IITvodY0TdvkfFvyxWq8RaX8u8ZUZiXzcDq594zff/Z929gsiA9jT
 UyGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787550530; x=1788155330;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lfg+S33mxYhTkp+vJzcce1d3QWdWhesMvM16KE705Pg=;
 b=W5qhegTGB8sSjMr6T4PpsXB3S8bOLslTvx6YgRcsvXcii2pOUIph6LGnkVhYZYHLUI
 FREuXCNhplzDuNcG5mTlzPp9EzSkxBKrZlvZNoyff2l8EYHaXsl/f07/jzOiCdtl4YBs
 9ugBiVlyl+DGynHyfq+Rud0fyqrE6kezz7hyEv/xKupSVtoX731pu7H65S1x3/ebpVby
 jPGR6k/Tnbrcb5PVXXsDepQuS1jm/tuMAXK8H++dabcf2LrwGawhaBsiYpbD7ikCCgmv
 Sdv9bQAFodaNl8bwVOqmKbLmAAlBLvO5O8gCn7TEMErMs4hOovWab+kyJ4V7JvT+i0cD
 xNlQ==
X-Gm-Message-State: AFuF++kdq/2bzDlKl8M86O8rYpUmGGFlY49BNYjJNUVQvu3txQuAsi3a
 Pus8EgeRC+l9r0yLb5YQSupHlwantnYvM75lLGf6980iM8w6Fg3p1ZlQR0wPEw==
X-Gm-Gg: AR+sD12FMP5LyWw8kNiDizehturP3Z7eXS40YhmrdiNk8Ta2++XI0MY+wM9efJg7/gR
 Xm9H1SOBC4fvIIQQpkLaZ1oMfotWLnK9cI0MbuNNWHm+ZSkMvIio8F58fIZw1EuYUBH5LwQfQxw
 tQTCq5/HsdawKPo9Tj1BDugeXSkAdNANX7hAlAAFcXpxPuqNKGv0ZOFv+hkzwieBd0r8YPWwREt
 4Hpyu5apJPKSupd3ImWIufEBcVElmVVJJ99kAfibTfGU9k3E/HAtqxqYVEriG/m7FortIhOxXtu
 RoCqOtztWGtI0EJMZC5I+sh3+5HJ1e3GCutJlRn9XagWF7+a/98/0QmbRadliHJ8Fb70QK9nnLC
 BGSagLiHTWi/XOai+la/Ef9z2venQZ42z31HY4cE+/pxFGADeINA+6u7lBliybB9AGxw8dBNGq5
 /eUNZz9xo8wQWS4aM5IfScjba0SqCDpGIzvt4lQZFuXEFiuGi6BsiurVfaA+JDt+vhn3eTd+KvG
 b1yVQ==
X-Received: by 2002:a17:90b:2808:b0:37d:f983:7b5 with SMTP id
 98e67ed59e1d1-395df289c4bmr29613567a91.9.1787550530340; 
 Sun, 23 Aug 2026 22:48:50 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-395c917d2f2sm4046005a91.3.2026.08.23.22.48.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 22:48:49 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Tao Ding <dingtao0430@163.com>, Junze Cao <caojunze424@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL v2 10/96] hw/riscv: k230: add a noc stub region in K230 board
Date: Mon, 24 Aug 2026 15:46:40 +1000
Message-ID: <20260824054806.2790041-11-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824054806.2790041-1-alistair.francis@wdc.com>
References: <20260824054806.2790041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=alistair23@gmail.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Tao Ding <dingtao0430@163.com>

The NOC address was accessed in the k230_unzip driver, but it is currently not in k230.
This commit uses create_unimplemented_device to preset the region.

Signed-off-by: Tao Ding <dingtao0430@163.com>
Reviewed-by: Junze Cao <caojunze424@gmail.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Message-ID: <20260808062227.66961-8-dingtao0430@163.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/k230.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/hw/riscv/k230.c b/hw/riscv/k230.c
index 5163eaa7ef..558f30b97e 100644
--- a/hw/riscv/k230.c
+++ b/hw/riscv/k230.c
@@ -250,6 +250,9 @@ static void k230_soc_realize(DeviceState *dev, Error **errp)
                               qdev_get_gpio_in(DEVICE(&s->decomp_gzip), i));
     }
 
+    /* Noc stub, the k230 decomp_gzip driver in uboot will access this region */
+    create_unimplemented_device("noc-stub", 0x91302000, 0x1000);
+
     /* unimplemented devices */
     create_unimplemented_device("kpu.l2-cache",
                                 memmap[K230_DEV_KPU_L2_CACHE].base,
-- 
2.54.0


