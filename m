Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10FAECD4857
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 16:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slsgF-0003Ed-FO; Wed, 04 Sep 2024 12:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfs-0001MW-CP
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:16:05 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1slsfo-0002Iu-Ux
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 12:16:03 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2f6514f23b6so19840701fa.1
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2024 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725466556; x=1726071356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nn/Mzsj0J8g/Mphb+PXQ5WHUtYUEk9GjObY40SBe48s=;
 b=gs/+D+kn1rSN1TpO8g9irT931b5VT2m8X9ycKtMXeFUJhWsYqd+J9LLj+e6otwT6Zv
 NBkPCH6GJgYbhKDISzf7ZUlWBow5NoUpcm2/7Y6W40HOQMSy0YschLesljt+M0C+8dZp
 UsNL4vm9LjZ9cLnS3o4PPoL0uutuoJBsLCCajzlDmH5bml5PbKOliVpzvSrUyASJNzpI
 TJhuspCEMci4vdf/px69PYQtGiWM/tXA1snL/fK8HZMLt2XqbQALmtXtBURxOZTpcEZB
 TYCnTUQAtSCjPYEx4UNcEkAZpb1KG6Iupxq/01Xk19SgWswrBrQe92MdpBm8nSxqWhyK
 S+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725466556; x=1726071356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nn/Mzsj0J8g/Mphb+PXQ5WHUtYUEk9GjObY40SBe48s=;
 b=dO+O0rs1+k4eH9GHGP2Gc8f0FwKr79A+A9dKU2HGEJBanBrxI2uJKCXNo/XH4aM+Wk
 FNUoeH/pgHlSvHuddxMvXx4oqEGOJ81/DTPgQP9mKvGuukC0mklRjbPRnVd2EbQThK6X
 GfUgCgOborOM+mgZIChQAxct0PaOp5KF8WsCR06FeakKo0vtRaDxS+wzTFFgfc/hGvxD
 JByM+j0uMW7NnApOKvbjUU9VBfhnwsXVN1sJZuNYKw0/a6v1Aw1lhPwgSwTVFPRLKSG5
 23IAM/G+ur3CwgxfX/qNjkTozw/yoLvx31vHOb8d+shjziuRUirLYQ/RXXAp0rsCbCbD
 P9sg==
X-Gm-Message-State: AOJu0YxbcstGQL/3jsRchnAk7PxgYrdg4JwUWyeENj5F1MZBVqSgGDrq
 4MstrHPi7oggGnBPl8CEko7FK3lOVA2P5W126tnJQDPVFxCunynNoL6931C7
X-Google-Smtp-Source: AGHT+IF6S1OoJeZCF42GJKo/qiy2ZeZ6a9HHHlUxboixNuGEbZq+dI0mGFAzSTpOvJ4LlUMQwdzjQw==
X-Received: by 2002:a2e:bc19:0:b0:2f5:966:c22e with SMTP id
 38308e7fff4ca-2f6105d74e3mr207636241fa.11.1725466555495; 
 Wed, 04 Sep 2024 09:15:55 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2f6151881dcsm26217611fa.124.2024.09.04.09.15.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2024 09:15:54 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL v1 09/12] hw/arm: xenpvh: Reverse virtio-mmio creation order
Date: Wed,  4 Sep 2024 18:15:33 +0200
Message-ID: <20240904161537.664189-10-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240904161537.664189-1-edgar.iglesias@gmail.com>
References: <20240904161537.664189-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x235.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We've been creating the virtio-mmio devices in forwards order
but since the qbus lists prepend (rather than append) entries,
the virtio busses end up with decreasing base address order.

Xen enables virtio-mmio nodes in forwards order so there's been
a missmatch. So far, we've been working around this with an
out-of-tree patch to Xen.

This reverses the order making sure the virtio busses end up
ordered with increasing base addresses avoiding the need to
patch Xen.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen-pvh-common.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 880e8143d7..295f920442 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -75,7 +75,18 @@ static void xen_create_virtio_mmio_devices(XenPVHMachineState *s)
 {
     int i;
 
-    for (i = 0; i < s->cfg.virtio_mmio_num; i++) {
+    /*
+     * We create the transports in reverse order. Since qbus_realize()
+     * prepends (not appends) new child buses, the decrementing loop below will
+     * create a list of virtio-mmio buses with increasing base addresses.
+     *
+     * When a -device option is processed from the command line,
+     * qbus_find_recursive() picks the next free virtio-mmio bus in forwards
+     * order.
+     *
+     * This is what the Xen tools expect.
+     */
+    for (i = s->cfg.virtio_mmio_num - 1; i >= 0; i--) {
         hwaddr base = s->cfg.virtio_mmio.base + i * s->cfg.virtio_mmio.size;
         qemu_irq irq = qemu_allocate_irq(xen_set_irq, NULL,
                                          s->cfg.virtio_mmio_irq_base + i);
-- 
2.43.0


