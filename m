Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D817C624D4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 05:54:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x20Nt-0006hC-RB; Thu, 03 Sep 2026 01:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20Nk-0006aB-1w
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:04 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <joel.stan@gmail.com>)
 id 1x20Ni-0006QE-Fl
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 01:53:03 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-38759bcd877so2374282a91.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 22:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788414777; x=1789019577; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Y8EVb0wo7FJ2wKANnrIolOje3sbSNMFNHjbGc+3Puiw=;
 b=mM58JECN5DGv9o7aa+6so17F7nbSWqRMRyTapcCmwvMXn7i4FTreJDByGXGUfpBXpb
 K684cUe55ymysnAqylbF9UUNVunANrwAqgxQokLAfCooekJ2bGM1l9NBLmLOk2EJAREd
 QEa+UuXmBiUeWr1qD39QTlvbqI+/fkYU31W/5jKTBLgRRIP7qhudsYP22LuH2l7RWipk
 59aaz7PPNE/9S9S6V66clQ83zKTK+abpWemqoptspGdZgJe0ir7qYVnW0/35WoRflWNc
 GbhphvCNpxvNbVPuxhWdIPXz9BW50icP+fl3evOJ+2MVefI4ezGAUtXQ5VCLZQGmBH2p
 buXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788414777; x=1789019577;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:sender:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Y8EVb0wo7FJ2wKANnrIolOje3sbSNMFNHjbGc+3Puiw=;
 b=Gn0VN1ptgWFnavTYcIW6CYH3JblcRbI1qhT2UKOIqE/drUqBzP9Xp1iIJzX2t3PYuY
 XxBLKW5NdVXozrb1DDzygGNOM9xqQnDaxB0hBW2uSDRxBBH2yyK4hTM33RiWju4S2GEs
 CAa0xNdFa/pvbK9VqBhsntiX2j7t946zk48KcKBPAIxDzhWX0eCBnbiXox6Poi7sH04d
 67VLDyEBiWjj4UfsrqSmPCpSrO4LBeh3/NWBbQUCL0jmVntfi5JXhIasJy+Y899RZH+e
 xVD/SMFCWU8EM+mKK9+MLjft6stRSiDL+YDWFOKHviwwYokSRsL6anuowvoym08T3F6g
 DM+A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwH+YqZE+0vVSnJq3FXdt7NJ1pMRiKpIHuK9nzyHD/QnGwLhEdqOcyOSIyuOyyaZ9OTcTvPVNICGd+y@nongnu.org
X-Gm-Message-State: AFuF++l7XhIsDBV3tjo++NqbyySAZ/stSC0903zj9oGAv28uZseYqYeb
 +CKbumk77rg8IHupHaqHGuCRORcZiODlluLw2bZoCodbMwjh7N6fn6CX
X-Gm-Gg: AYBFou2SvsYVzES3LNgmhm79kV6KC+uQhdDMoMjEt6Rzo5K5tS+6xv3iq//2ripxMfr
 9y+ixf7QOEnSwlRWnsnfSk51h1bYkjwKW1Kh/fWSAkKbdm+uRVwdAmc/GDwN/1qSh6FnsK4Y/cZ
 UTNAGMDYjVb1MByt9lwp++mjg+D+PJ1nik/3gh20zGpy7mXHc5+9RV3mYOaVk1z0tRBy3XMTP1h
 z0bgcrQD5nXTf6bFgt8zW5YIwQ+8fOVdKRkmCG3463+pCgMZgxxw6YkiSlEl/SoRNiaj/QBVNfV
 MV3bokOhfi9AYVs0mPrOn0xyS08QPqNZGVYJKbTTuVC2uXa4AfpZrREvdCuhJSVjfJE8RE8yam4
 prhVqptV1jN1OX3XKNkHDweDZhEObsDoBnYSwuYY8c7bYEWfujTtIXgMixkMqQEnnz6GOEJRE8I
 j3Y5ZTy0nE4+1dyLVYueIp12cjfQnfp/3o1LT7P/iX0SrZlqdc/g+qpfdB7qTqPNx/dMm7bf4y4
 FiOAqTg13jkvmeEsDcBXD9Wzz02Va0sfwV1RX9vCezj6vmFnK/frUbAagc0NtP6JYURsnZppZC1
 vjKWay4+WAlYP4/6S2C4
X-Received: by 2002:a17:90b:4a07:b0:38e:97f0:aa4b with SMTP id
 98e67ed59e1d1-39aee0e5ca1mr12945331a91.13.1788414777074; 
 Wed, 02 Sep 2026 22:52:57 -0700 (PDT)
Received: from donnager-debian.. ([180.150.112.50])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1431990a39bsm2770619c88.3.2026.09.02.22.52.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 22:52:56 -0700 (PDT)
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
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 06/16] hw/riscv/cps: Map interrupt controllers in SoC
 container
Date: Thu,  3 Sep 2026 15:21:20 +0930
Message-ID: <20260903055131.257903-7-joel@jms.id.au>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260903055131.257903-1-joel@jms.id.au>
References: <20260903055131.257903-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=joel.stan@gmail.com; helo=mail-pj1-x1035.google.com
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

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


