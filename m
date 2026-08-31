Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F5FEC61DE2
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 02:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0rZ8-0003Vs-VL; Sun, 30 Aug 2026 22:16:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rZ7-0003Rv-9U
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:16:05 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x0rZ5-0007ZO-Rd
 for qemu-devel@nongnu.org; Sun, 30 Aug 2026 22:16:05 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc1bcdb3c4cso2078655a12.2
 for <qemu-devel@nongnu.org>; Sun, 30 Aug 2026 19:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788142562; x=1788747362; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5s/MHm9pZEMHdIBltCKmL5mdgHKUgYmEicbJN9o3MIY=;
 b=r7Qlg8wr+aFMTtcUo8mlfFi2trs7E7HqEiMoi1pepaE8AIxqDSyVbudC8NJxcnr12m
 EhylFrYFaoppjy9I0rrpzaBpQ1E4U1xLwyxw6Ds0K+r6uwmRNL7dOx5NLaZLebfxQ+y4
 Zz8u0MZcH+f8kle06w+XOMe/BH+02GX0SWvhMaK2z7ImrnYFol0gznCfIDMvzgcqmuw6
 o2yuoxCrEBHvahiMzpM4Qht/2l5UOsCi2hpqrFTziEQrvc2ebaeDxSEKSI9GbKvOSgPW
 CK/fhhGw0a4rVYHzOutDcpi8GbpU/aMBlxW5VW5oLVI43uDBGCxd76XpL323g/nW7v/L
 PzZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788142562; x=1788747362;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5s/MHm9pZEMHdIBltCKmL5mdgHKUgYmEicbJN9o3MIY=;
 b=pj1S8Zc+YZmonCPRQKeRkQaZ1P2EO3ocKpyKExnVvNcVoRC+S3sgfNtVQUpG+rvYLn
 AT/PGnKMeV5BkumvKqanh4/qxoCUKNpRsHW2/RisBP/gtA8jRk1qQrSIwbRCHKLNWvQ/
 ddTpAHOClbuHTMJky4UgGwAs4jAXGLn/Lu1H7QPhG4Mra6jOWWsI4ar5vwOOBm+57eCR
 2vGsIR60gHcAJb5GvZfBS/h+vw9HknUlOpo9sCOQLBgpz9I2JbTpxjuEJ8DhguFyb/dL
 wFp+SHVoY2TOvcQhT1xL7mNteiWBYdSijyFHSMfzs0IhPg1Oen+UjnbPfyIlqw5My1Yc
 vbdg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwFrL2wAheY5Nu4JQxWmd7Tsq2hzLafzSiyg+bHihguEoI86Ey2oJY2mbUIFDGPwuJnaQJOZsnV6Dx7@nongnu.org
X-Gm-Message-State: AFuF++lPRjmcBeuUC1mZXwNTVgcQMI+94mRsQmkokA6jBseT+nfMO96i
 ZAPRtNjecL/MNxKLVW191bX6clIWxAiHnPdkH8dRtun3adFh/rOTXvqV
X-Gm-Gg: AYBFou0k2BOA5rxRG34oY2NfMjfTILh1IwHVM2NMdBm0HhkSuRZn0wxTv/lj0nwY0Zm
 WPjWc2vUYtUASj0600Cpj6cycOL4IzFNbbc/RMsliTkYSUgtoIr3qEGikpiIC4XFzhVOsywukmr
 Io8+7JLWUHs20GaVG5RV6EyNm8KNUhHJrMiaDiaHp2610DdQ+Z8x4cqaJmYW7ds3qBAslJIK1jE
 eXr/YmWvhalTQV4j1JQyxIQgPhffuehY1Zl1PLpoDuHYPXOUagoZi7UL8spyaiLw/MKqN25tCTQ
 lESyMghCxVXJn0S3euz0qIxbRPjhg49xt88xu9lXB4LtrjUpvc+3tPYHjDGhIfm1QgMSjLDg5oU
 kzAw19XdlHRS+AUExypUQMvRPpCWvpJ6TUyJRWn0odaFiN69zBlg3eieLJ6ASVwTY/DATQuqq/E
 ccQunjNUGHc8QzHScGAZ1f1u7a6aelaLK4PRZMpk8VkBSB09qLKEH/toXwBOhMWT739dAlKeJC1
 d7AmzT5DRPFX058N/oDDsftqJabT6tppDyZryhFieRfkwdlCm00RGwNY+moH+cMVUIU1r5IfUC3
 3gML220IHOCR+xXZaDA5ync79cMd8ew=
X-Received: by 2002:a17:90b:1a84:b0:37f:e326:6557 with SMTP id
 98e67ed59e1d1-398f826de4fmr327270a91.4.1788142562350; 
 Sun, 30 Aug 2026 19:16:02 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b186807bsm20071240a91.12.2026.08.30.19.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 19:16:01 -0700 (PDT)
From: Joel Stanley <joel@jms.id.au>
To: Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Michael Ellerman <mpe@kernel.org>,
 Portia Stephens <portias@oss.tenstorrent.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v2 06/16] hw/riscv/cps: Map interrupt controllers in SoC
 container
Date: Mon, 31 Aug 2026 11:44:47 +0930
Message-ID: <20260831021500.82565-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831021500.82565-1-joel@jms.id.au>
References: <20260831021500.82565-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=joel.stan@gmail.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The CPS device maps some devices into a container region, but the
ACLINT and APLIC were mapped directly to system_memory.

Pass the container memory region to the interrupt controller helpers so
all CPS devices live in the container. The location of devices in memory
for the boston-aia machine is unchanged.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 hw/riscv/cps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
index d2fd9638a08d..21daaf4943d8 100644
--- a/hw/riscv/cps.c
+++ b/hw/riscv/cps.c
@@ -135,7 +135,7 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
     for (i = 0; i < num_of_clusters; i++) {
         uint64_t cm_base = GLOBAL_CM_BASE + (CM_SIZE * i);
         uint32_t hartid_base = i << MHARTID_CLUSTER_SHIFT;
-        s->aplic = riscv_aplic_create(get_system_memory(),
+        s->aplic = riscv_aplic_create(&s->container,
                                       cm_base + AIA_PLIC_M_OFFSET,
                                       AIA_PLIC_M_SIZE,
                                       hartid_base, /* hartid_base */
@@ -143,7 +143,7 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
                                       APLIC_NUM_SOURCES,
                                       APLIC_NUM_PRIO_BITS,
                                       false, true, NULL);
-        riscv_aplic_create(get_system_memory(),
+        riscv_aplic_create(&s->container,
                            cm_base + AIA_PLIC_S_OFFSET,
                            AIA_PLIC_S_SIZE,
                            hartid_base, /* hartid_base */
@@ -153,10 +153,10 @@ static void riscv_cps_realize(DeviceState *dev, Error **errp)
                            false, false, s->aplic);
         /* PLIC changes msi_nonbroken to ture. We revert the change. */
         msi_nonbroken = false;
-        riscv_aclint_swi_create(get_system_memory(),
+        riscv_aclint_swi_create(&s->container,
                                 cm_base + AIA_CLINT_OFFSET,
                                 hartid_base, MAX_HARTS, false);
-        riscv_aclint_mtimer_create(get_system_memory(),
+        riscv_aclint_mtimer_create(&s->container,
                                    cm_base + AIA_CLINT_OFFSET +
                                    RISCV_ACLINT_SWI_SIZE,
                                    RISCV_ACLINT_DEFAULT_MTIMER_SIZE,
-- 
2.47.3


