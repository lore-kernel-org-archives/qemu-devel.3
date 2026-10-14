Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D90CC6B1A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvVU-0002c1-C4; Wed, 14 Oct 2026 05:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvVQ-0002bP-FF
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:42:40 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvVO-0001d1-RV
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:42:40 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-35829219da8so816218eec.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970957; x=1792575757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RHkB+WJYVJh5gtDdYFA2dnLLdePZ0o1/JLEQILf+BW8=;
 b=NeX9NaMP+jC0Dw2V23aHsNO8tqXROi2vqcPlKIUG2UvXo45y6UsckJ7UNBYwpsRBHq
 esJ8iswhwnp9LHwzjTyzOZz4B3x5ySiIfnkhAtuXcibeBvGdaCs4TAcfAbPpIOml6H0Y
 i1EmB4V+ANRDxGmquRY6QPM621b31Y9WB5kZrxBtsHfWhDo12XsaGg2f9qyrSI/pNw8o
 wEJG1/g9sA5Le4g59DXECHJ1BwA+MpTtGN00YC44PufRSCgpw6pmWEgYQMS1q1c1RlAK
 9TAXap/CdJ3b9VW5qtJowhRHqPsnkiDfk8IVMulY3WHG7nr5St7VXDlPf2E8Yq2woXtq
 l7yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970957; x=1792575757;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RHkB+WJYVJh5gtDdYFA2dnLLdePZ0o1/JLEQILf+BW8=;
 b=MdDgiRCzqpbmJ7ti7s57LeBunyo8iGBCmjWxflwEsliXlYLX7d5iq0Y6Oml77r9zXi
 4rLzAp2D/pu9NOudxzpM+g87U7JxsTkzNypAmRTLEFbgvHiXeygiGKZ8tvfliwcKDPjr
 MK1+4MjM/K6MJ7N8v2lB5BgKoIZsSLLRfxchx/LNof3FBnVm7lIGeIQaggY2DlYLPdf5
 yTmftMSjg5ll+H3rDW8zAlNF0adh29To+AxmsOVku1bIQcBO3RAVGkuz2m+/ats6auFs
 MTlCjNaUOX6Xv1tru2RI6S/tEujyq4Ny6M8PuLzmVqr5/aRa0F8R+LecpZL5yTSXvdP0
 NiJg==
X-Gm-Message-State: AFq9FYLy0bWLC0oZoAyzvIUP6heaYgrRtcYY0OOETGYfD3dCfoo+/RV7
 zbMvpQo4CIEqVEvvpNsjcX0F8wayOYOKXVObYWvfyf4ZypN50BVsHI1F21ctp7Yu2K4=
X-Gm-Gg: AYBFou3kho72xZevQCKXsIi9cIENffkteVOOW4tzSR4/g9StjBM2Sv2IsA8mS9Sr2yA
 aU0jQZXhM/JEEiIPnZsMh8tgPUtT55i0onEUD2UM8X50lLrMmiANpb7IpPt9qVn99sdopHez1+J
 UGVsc0xF5Cxo479M7J9DoKuuQb2skCM0L5O2waZoU4hjoNCDD5e7GF26ZYEzjy9RpYdK02W8JhV
 t0oX+PJe4XMIOkvd91QuKDsBUaXnKao1qI/A6Y0iU9aKxRuwnk7BJ3hDuIdu5yidD1YK2BbCIev
 yFPePFRP3c7610aKVt5+BWS/zZutyb28v5voRU91SZ9jfkkUFxCalhgM3/r6zmwsKJw6SmZVdok
 GpqAxO9aqGpxnl28rOScU7ttyISaV5vHwTnudRMnV1vyQh0+8k2KyDDGPotA6CzNDJPntPSDrEv
 k26hGB/KeIuyaTSdcXqX56bFlcyWeG/ue2TPuYqwhvP6zwxxc0cLQYBd/6cSTNbpZ0cScrbhT98
 ZiWmG4ySqDW4srzMw==
X-Received: by 2002:a05:7022:f51b:b0:15e:12b6:7365 with SMTP id
 a92af1059eb24-16a54fab7bemr18604751c88.2.1791970956468; 
 Wed, 14 Oct 2026 02:42:36 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.42.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:42:35 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, Eric Blake <eblake@redhat.com>,
 Eric Farman <farman@linux.ibm.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-s390x@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Bulekov <alxndr@bu.edu>, Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-arm@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-riscv@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Fabiano Rosas <farosas@suse.de>,
 Song Gao <17746591750@163.com>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Chao Liu <chao.liu@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stafford Horne <shorne@gmail.com>
Subject: [PATCH 16/34] hw/virtio/virtio-mem: Avoid call to target_info() in
 class_init
Date: Wed, 14 Oct 2026 17:41:31 +0800
Message-ID: <20261014094224.1976-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1336.google.com
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

Done by merge virtio_mem_legacy_guests_properties into virtio_mem_properties.
As we already have vmem->unplugged_inaccessible handle in virtio_mem_device_realize
So we can reject the wrong option in virtio_mem_device_realize, then the call
target_info() in class_init no need anymore.

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/virtio/virtio-mem.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/virtio-mem.c b/hw/virtio/virtio-mem.c
index a4110d61312..81e2192c2fb 100644
--- a/hw/virtio/virtio-mem.c
+++ b/hw/virtio/virtio-mem.c
@@ -879,7 +879,11 @@ static void virtio_mem_device_realize(DeviceState *dev, Error **errp)
             break;
         }
     } else {
-        vmem->unplugged_inaccessible = ON_OFF_AUTO_ON;
+        if (vmem->unplugged_inaccessible != ON_OFF_AUTO_ON) {
+            error_setg(errp, "'%s' must be 'on' on non-x86 targets",
+                       VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP);
+            return;
+        }
     }
 
     if (vmem->dynamic_memslots &&
@@ -1568,9 +1572,6 @@ static const Property virtio_mem_properties[] = {
                      early_migration, true),
     DEFINE_PROP_BOOL(VIRTIO_MEM_DYNAMIC_MEMSLOTS_PROP, VirtIOMEM,
                      dynamic_memslots, false),
-};
-
-static const Property virtio_mem_legacy_guests_properties[] = {
     DEFINE_PROP_ON_OFF_AUTO(VIRTIO_MEM_UNPLUGGED_INACCESSIBLE_PROP, VirtIOMEM,
                             unplugged_inaccessible, ON_OFF_AUTO_ON),
 };
@@ -1635,9 +1636,6 @@ static void virtio_mem_class_init(ObjectClass *klass, const void *data)
     RamDiscardSourceClass *rdsc = RAM_DISCARD_SOURCE_CLASS(klass);
 
     device_class_set_props(dc, virtio_mem_properties);
-    if (virtio_mem_has_legacy_guests()) {
-        device_class_set_props(dc, virtio_mem_legacy_guests_properties);
-    }
     dc->vmsd = &vmstate_virtio_mem;
 
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
-- 
2.55.0.windows.3


