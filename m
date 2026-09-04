Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2BEDC61DD3
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 05:22:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2MNC-00029b-At; Fri, 04 Sep 2026 01:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MN8-0001vB-Oq
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:55 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1x2MN7-0001U8-6B
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 01:21:54 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-cc1c8d4a959so560239a12.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 22:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788499312; x=1789104112; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5tiWF5M+xgQGQEOlJOgCrBXzJJyCedFASezE9PVn8qU=;
 b=c6aKATJwag/fVsKltcRJ+MI3frr8HLJ9X9/Iox/1qodoOHv98Hrq4Fsr9M6oVyDE27
 I2Qiy654T02Sfyk9viBY/FIU9DVNhfHB05uAX0UomVcUCsHC8QJrGycgJFxJB0OYbv2s
 aBGMZkcYK2yWMLwT95VRdcXtmAQd0Q6N+WS+k7wUGAab2T3eeXRVXVwNDXljRZ9XIMYB
 wvlriYjLZFZb+wwX8u121edl3c69uyyuXHDsrqqbfYaJH0bWhdnOo4sWs2J/MxUHvLot
 0gnJFuClGjrK0ZmhzM8T4qqVe9mnM2OQZyr49MRayzM1H9fPlteESp+xNQ+pb2U4Nxfp
 gEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788499312; x=1789104112;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5tiWF5M+xgQGQEOlJOgCrBXzJJyCedFASezE9PVn8qU=;
 b=mj4LFRrXy6XyJ2U5TLmD5+gvG9qybZsgnzeyHb1cRvH8fFeYAwQfA7amg4Mxn2yDEZ
 Eiaaa1NWw3STN0fSKxarc/VQ10xgIXp3iIEU9I/Zph2wi3ckzmRuoGrzzIgPCzPF/K/m
 bREYNOEEp4YkIfcsq6ca7PfsBHdtXYyPDyNiEI1NN8by1JhhmZiruln6z/VuEWoqZ1c8
 33LQOyI3bFdn7fAQR1EDNNBXGGjCDLw5N2E1X6kuqpWkGXMXNrE/G6HfSRGTv2vWtNJW
 w3s38ODLKDs5Yz/pmx0vtxgqxJzCK2ct9zHtkQGGUKymquPAkKKo8hDmjzjIIwjNkeUB
 UdkQ==
X-Gm-Message-State: AFuF++n9mPCRG46EPGrcPInTbe8vQNRhoMzYP1VbkhNRORlO8V0716mh
 Neas+WaXPx7zIrw2+xNRjsG/Uy6SRQWrwZ6LhTdUlH7JD7YWCC+Lz99EilAxkg==
X-Gm-Gg: AYBFou0CL2y10koeg0Qa/Fx8ryIaQGlegchjyIHC2NuLtMXIjR1AcWqIQw+SHnY6YND
 VzWbSSg+v+XU47THzZPAqepNR5Xh2tkwqJp7maE3XKqIQsv5wOgP+aCGXIbKB6F0JBn975EdiFy
 gJqsZJaRkw7J6nnR8q3f4mqB2r7WzJDvQQ/hOdelBz0Wv9SbRZBVfEn6CshE06NIaVOCfpEaFHj
 D8rkFAeZsLgePKVTP8e7uJmcc7ogQd6DU0cxq2yWKiUAJhVIMzyZ5F86GEHiXSw/DyjRI3Tc5Ht
 ENXnWJWMwfgDg8lwoSJ7Xg2dekVdZsZKtONjck816CY6W72+0+fOVWBvKXYMTVCQNzgvF/SYVM+
 ig1px3b/Hn2r3BaCqDkwsPlndw2bAphgVe5aMdr7VoDp3SoWR6gWWPnni3rQmD9C1VA649k43/L
 vWeXw6v3xkAKnD3RH/CgI2vmf1E+J2hICrX9bV+3ZZV2pBPbMuw8PVBtgsHkT6UJT8mhqMkoCpn
 9njxw==
X-Received: by 2002:a05:6a20:a108:b0:3cc:45cc:c401 with SMTP id
 adf61e73a8af0-3da39ff4c0amr4571711637.13.1788499311721; 
 Thu, 03 Sep 2026 22:21:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc455445e34sm402147a12.15.2026.09.03.22.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 22:21:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Joel Stanley <joel@jms.id.au>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 37/47] hw/riscv/cps: Map interrupt controllers in SoC container
Date: Fri,  4 Sep 2026 15:19:33 +1000
Message-ID: <20260904051943.799041-38-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904051943.799041-1-alistair.francis@wdc.com>
References: <20260904051943.799041-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x530.google.com
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

From: Joel Stanley <joel@jms.id.au>

The CPS device maps some devices into a container region, but the
ACLINT and APLIC were mapped directly to system_memory.

Pass the container memory region to the interrupt controller helpers so
all CPS devices live in the container. The location of devices in memory
for the boston-aia machine is unchanged.

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Joel Stanley <joel@jms.id.au>
Message-ID: <20260903055131.257903-7-joel@jms.id.au>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 hw/riscv/cps.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/riscv/cps.c b/hw/riscv/cps.c
index d2fd9638a0..21daaf4943 100644
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
2.55.0


