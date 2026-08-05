Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47881C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 13:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrb0Q-0007qQ-Sj; Wed, 05 Aug 2026 08:45:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wrb05-0007nl-Kz
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:45:38 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1wrb00-0006dx-Mj
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 08:45:36 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-47f611b3af9so139457f8f.3
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 05:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785933931; x=1786538731; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8QybmKXsQqLSM3yBhrdsFkkm4/OY/6jMO66xFzPollQ=;
 b=hO6LfnTSiRVp+LZHX3BIyOMt5HP49q4VYjjvBmo3wBtaVQ/KGXEWjOcOq9McZjOPEr
 13cInFEpvlxE6uf5zk7MX/EIOW1dlJWQPFItEeqBTXw2rWZ8NIxlMZU72CrNhLQCLtLG
 aJmDcz9eZFQL3owBIYdmQpIHfAXtAQVMQGzO0gpzZZSA94CmMRyj98VkUaVjJmpJQ9zr
 D/b9LnaYAp5mewNK1B8aqwoyJJiN15UU+FBuHm0COtFdt+9MvLwmIxSldXPXi6PvGahp
 1VZlJImHN9uMAvSwQsPZbG1sJjD8MN1S4egsqc5QK++9jAj2eCQMQhaU1ebVud3Kb+Ub
 3xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785933931; x=1786538731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8QybmKXsQqLSM3yBhrdsFkkm4/OY/6jMO66xFzPollQ=;
 b=Qgx7yDzCCL9bjKPisFZ8MFBsvwjEnEFDrLPTYcGIpSZGmSpGpkRys5cWC3k/5ABTKS
 5ZsX9fiqUWchNDh5/3E41Gi/YlerQLdTT14w+WJV6ExQ7+5VKCBHFlUnTjvWPba1BHni
 Ea0NZbv/lkXr0EOddN3jHFi4Rnl/1THXGgfnbgr6ItbZNrOXPGiI9qaF7qMtoAoKIUB5
 Uet2wx//dXzlKjH7dZIUhuJLz93f76IsoDCX7DwOLfHIPRpklhVVjkMo+3DaRbMWwMBL
 Ex1Bskb9oR8u09ND3Avc8OHGnmryipKMhFwtTFJ1TAtJmRl6/KBouvNDmXXVcivTiiu/
 K99w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr11Bqvkp2SB9Br6RK6V+/p4dmXzbkfKQbEsqHoS5w88GT5j6KdNzMkr2srbAumKWEZOF7MBNQME3NW@nongnu.org
X-Gm-Message-State: AOJu0YwyLaIbk4vQSRbfL2GewXyjjTv98H+rIp+VVMnX+g2Gp7/LQ19E
 WcS/D4mf62OsGqYiuWm87x/LPgKeaEA0pGTH5d8zHM+Qz2X5ttPVBiFQ
X-Gm-Gg: AR+sD13OqrQ1z5lfoEWu1M//tFIhDjDMJIGKnFcXNSrGVECtjjpfCNLdlksK0sUTlhR
 GVyiCxvImSoUCpM6i+2Rr/Tg/xMIuZWWESwkjWBm1Y+sR/R2krB8pF6a1ZP3KRCtDXETk74gfpF
 L7ODlMjiv/hK1cZTMwvTkhZbPfSp5oz9c0Iyxp2zjB2QPHUPWLooxs8lPoAUfXpDomckUyscQ4z
 trMMvFeBB+byYdcABC+pfFJ2s3g5O0LNIOjw4YGTceMWB3EYaULQm9+OhKR/UUCeLylRPL4TpFD
 2oCvncC3ANA0kDIMkSFp2VOiGItKWmmPEbqTdmh9Mzm4jQB2Iz5TQlOh8C5s0R4GJmrTd1w9Rtx
 SkeY2iiik5Ez4mIWmamEKoSOX4TWbHswfi21HoMkbwaZv9aBiaSwgkI89avR8OWPrgy2ff5Ys4F
 Sd7lIFYAi/8osLPoAX4Aoo6+1zzvTBlPa7dBYY8LES6EUOjs7e/V8MiMMfTQw=
X-Received: by 2002:a05:600c:1393:b0:495:650b:4c61 with SMTP id
 5b1f17b1804b1-4994e7d0166mr45279285e9.3.1785933930865; 
 Wed, 05 Aug 2026 05:45:30 -0700 (PDT)
Received: from AtiePC ([79.116.13.250]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4994a100e14sm166453775e9.14.2026.08.05.05.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 05:45:30 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org (open list:nvme),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 2/3] hw/nvme: fix memory leak on sr-iov capable nvme
 controller removal
Date: Wed,  5 Aug 2026 14:45:17 +0200
Message-ID: <20260805124519.30054-3-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260805124519.30054-1-danielpaziyski@gmail.com>
References: <20260805124519.30054-1-danielpaziyski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

If a nvme controller is SR-IOV capable, its list of secondary controllers
(virtual functions) is stored in the sec_ctrl_list dynamically allocated
array, located in the NvmeCtrl struct.

Free the secondary controller list after destroying the virtual functions and
freeing their controller IDs.

QEMU command line (boot with a hotunplug-aware OS, such as Linux):

    qemu-system-x86_64 -M q35 -device pcie-root-port,id=rp -monitor stdio \
    -device nvme-subsys,id=subsys0 \
    -device nvme,subsys=subsys0,serial=ctrl0,sriov_max_vfs=1,\
sriov_vq_flexible=2,sriov_vi_flexible=1,max_ioqpairs=4,msix_qsize=2,bus=rp,id=ctrl0

In the QEMU monitor:

    device_del ctrl0
    quit

ASAN splat:

==78982==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 32 byte(s) in 1 object(s) allocated from:
    #0 0x7fcbab32bea9 in calloc (/usr/lib/libasan.so.8+0x12bea9) (BuildId: 7f2845989b820f536270e19ec47df085ae89a675)
    #1 0x7fcbaa2a34b2 in g_malloc0 (/usr/lib/libglib-2.0.so.0+0x694b2) (BuildId: cb17d184459352a7985a010f1cd3acef4a4f90d8)
    #2 0x559c531fff4b in nvme_subsys_register_ctrl ../hw/nvme/subsys.c:65
    #3 0x559c531d715e in nvme_init_subsys ../hw/nvme/ctrl.c:9582
    #4 0x559c531d7a7d in nvme_realize ../hw/nvme/ctrl.c:9637
    #5 0x559c5323c0da in pci_qdev_realize ../hw/pci/pci.c:2316
    #6 0x559c54001e88 in device_set_realized ../hw/core/qdev.c:514
    #7 0x559c5402462e in property_set_bool ../qom/object.c:2484
    #8 0x559c5401dbd2 in object_property_set ../qom/object.c:1548
    #9 0x559c5402b76c in object_property_set_qobject ../qom/qom-qobject.c:28
    #10 0x559c5401e24c in object_property_set_bool ../qom/object.c:1618
    #11 0x559c53fffd77 in qdev_realize ../hw/core/qdev.c:277
    #12 0x559c53934166 in qdev_device_add_from_qdict ../system/qdev-monitor.c:740
    #13 0x559c53934272 in qdev_device_add ../system/qdev-monitor.c:758
    #14 0x559c538867c8 in device_init_func ../system/vl.c:1217
    #15 0x559c5487236a in qemu_opts_foreach ../util/qemu-option.c:1148
    #16 0x559c53891205 in qemu_create_cli_devices ../system/vl.c:2762
    #17 0x559c53891968 in qmp_x_exit_preconfig ../system/vl.c:2822
    #18 0x559c53898108 in qemu_init ../system/vl.c:3862
    #19 0x559c545efabf in main ../system/main.c:71
    #20 0x7fcba7627780  (/usr/lib/libc.so.6+0x27780) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #21 0x7fcba76278b8 in __libc_start_main (/usr/lib/libc.so.6+0x278b8) (BuildId: 1fa174a830cef40a5b2388add4318ee2795f573e)
    #22 0x559c524df1f4 in _start (BuildId: 35402cb4fc46114b7a4102258726bbdec82cd9bc)

Cc: qemu-stable@nongnu.org
Fixes: c6159d0e384f ("hw/nvme: Allocate sec-ctrl-list as a dynamic array")
Signed-off-by: Daniel Paziyski <danielpaziyski@gmail.com>
---
 hw/nvme/ctrl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index b726c13a56..284f3964e3 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9682,6 +9682,10 @@ static void nvme_exit(PCIDevice *pci_dev)
 
     nvme_subsys_unregister_ctrl(n->subsys, n);
 
+    if (!pci_is_vf(pci_dev) && n->params.sriov_max_vfs) {
+        g_free(n->sec_ctrl_list);
+    }
+
     g_free(n->cq);
     g_free(n->sq);
     g_free(n->aer_reqs);
-- 
2.55.0


