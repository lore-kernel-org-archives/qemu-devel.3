Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12F9DC79F82
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Sep 2026 12:20:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2pM5-0004Ok-0Z; Sat, 05 Sep 2026 08:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x2pM0-0004Nx-Cf
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 08:18:40 -0400
Received: from mail-wm2-x10.google.com ([2a00:1450:4864:31::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielpaziyski@gmail.com>)
 id 1x2pLx-0001Ah-VO
 for qemu-devel@nongnu.org; Sat, 05 Sep 2026 08:18:40 -0400
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49d0726cdbcso43295e9.0
 for <qemu-devel@nongnu.org>; Sat, 05 Sep 2026 05:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788610716; x=1789215516; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=otgHVEO2QmH4s2/UdC4CuyIgpLvObEOab+8xyU8rtzk=;
 b=WHAj9HMNyK/V0JtvgHXYie1nsnolN5SjlC7PKO/w1yzxoH6b3NsKTt+pky6IiHB4H+
 n6pH8mfgt7t0FLizpDtGTOLmdyy3RlVsV9owMRKlR+LkhNkrEmv61SiNV5xv/Nef0EmC
 I/BPnhGE2ThQjBt1GW3VWuX7hwzx8T+TptoNZIFQYHLBjQ9TcueRP5DwtsR4di7LeoFJ
 45ahue7FVq0Tlwgrz/xR9Eo2VZ+V6+DfpLhPWKqnESYbLriG5pZty8Y6vtRwOVhWg84C
 gSZwhQEyD2wQX0Elxy6MqvakP/Dh3nDuXTmcGueIUWt4KIXZ2bOHTa28HoXITmWMAB2N
 o7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788610716; x=1789215516;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=otgHVEO2QmH4s2/UdC4CuyIgpLvObEOab+8xyU8rtzk=;
 b=IPZd4jZxrC6pHgW2I0huKwq9kUrqGHnLdr7uE/j/qYkJp3i9akXnjxm8pxHUh5Neex
 to9Keke8DV1fw0sfrEgDgmV5L9a1tpkUzcqOUvq7WwKB7M8hJvoqNLUNz8ShfXTA0/Au
 /IRb86atVqsiEzCrQiCRRQ1vBiVXpDt4eTyiBWP5Akub7XXX1VsCWMu1MC7RsmvdrYW4
 JCxWzYx4/GW7MSz/+pBsk8YAwSU/zz8TNNgNxZQrsFjBMsXLDjJe7f0WA02EM6sp9IB+
 kaika/MhZrLq1bJmnVZxlTS5DBAlxwWjOab+FPhIqZUbAFeV2yZkez+aVGGESdJ5dhO/
 gJ0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBzITKX87A20XznDqhWY4bvKQuYG44BuplMVOuzIbKaFzrteaFY1DzVOzBvhiyU6Y3bR/2vGeHYfhNwS@nongnu.org
X-Gm-Message-State: AFuF++lYLIB+nOYzFAGUUCnIzwJfmGQQPazkj53YLjbXXQHoK1I8REHp
 ajvwYt7hZli7zmz1kk9ryKVqltx7pqYrAsUQPL+t5ZD1H6D4tr+Rb8qJ
X-Gm-Gg: AYBFou0nN9vWlbYp8HDvL+uJOCzr59yqGycN93jBXqx1j1D7hbxQY8PAxTntPb/Xecz
 I6biqFc8QIAjVUZloz5r8Wf6lPEKe3Ra5pwIMKSSZ9i9rZmwHzMJR2pY0pX1QQE8GWm6jEDFuCZ
 XCu5JovHsfYKeedl049Ln0PlcscuXB4Q4ZEYaXCD3fEPChzjH39Bd8UTJFUytJc1BqVqkro1fzg
 zHhkRBJse7JjYGGB9R5F/ayb8DNZVY0fVJ1GXRiIYi6xEbepyvXer2S2UPa/xpzaDt10aWBmtch
 Iqh9BkBGAhSDOvVEiYvIRLrBDF33VO2pcPSSmBI3R7F9oB/RuyG7tlM59X+F4c5L5fiGENst2tU
 GDq3ojngTz+OOCxwF2pExAzptZ++BBDduchlVpEsWSYEyj8Efd7O/vbtpAEPszrYnCX7AA0qRs/
 KuX9/x510z12PAELjgxRmh7szeT7Vo5GRUhk29M00ac2wWcQ9qX7nlPvszww==
X-Received: by 2002:a05:600c:8485:b0:499:5b0f:72b with SMTP id
 5b1f17b1804b1-49d01dcc32cmr38381305e9.1.1788610716198; 
 Sat, 05 Sep 2026 05:18:36 -0700 (PDT)
Received: from AtiePC ([79.116.0.198]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm234546625e9.4.2026.09.05.05.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Sep 2026 05:18:35 -0700 (PDT)
From: Daniel Paziyski <danielpaziyski@gmail.com>
To: Keith Busch <kbusch@kernel.org>,
	Klaus Jensen <its@irrelevant.dk>
Cc: Daniel Paziyski <danielpaziyski@gmail.com>, qemu-stable@nongnu.org,
 Jesper Devantier <foss@defmacro.it>,
 qemu-block@nongnu.org (open list:nvme),
 qemu-devel@nongnu.org (open list:All patches CC here)
Subject: [PATCH 2/2] hw/nvme: fix memory leak on sr-iov capable nvme
 controller removal
Date: Sat,  5 Sep 2026 14:18:12 +0200
Message-ID: <20260905121812.47816-3-danielpaziyski@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260905121812.47816-1-danielpaziyski@gmail.com>
References: <20260905121812.47816-1-danielpaziyski@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::10;
 envelope-from=danielpaziyski@gmail.com; helo=mail-wm2-x10.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 3040cb1760..76ff92c9eb 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -9708,6 +9708,10 @@ static void nvme_exit(PCIDevice *pci_dev)
 
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


