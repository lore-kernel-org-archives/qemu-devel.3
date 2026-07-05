Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEA5C43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:40:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNw1-0005Cr-KD; Sun, 05 Jul 2026 10:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvz-0005CZ-Mq
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvy-000186-0l
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qqAS8b/Gv9NQ3zOBRAXok3JwSvk1ksPGJ1eMtlRChKY=;
 b=SaPd4dDedBKZSKR4ZH422//mogoUQMkpz6snuGWSIfnlLC/ALaFIcdT3s+KJ1OrhEbbDvY
 Aep5Dt5AD18DLjCsuQZTIiiVxbtLTZATvJjPXpva6YQQENFnGVSlycjoMzzl14Leypreic
 BaOpC/BdxMd+KdhIXuaX+UY9/YY225U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-vnyXjP6UMwqHwutPtEbgJg-1; Sun, 05 Jul 2026 10:35:00 -0400
X-MC-Unique: vnyXjP6UMwqHwutPtEbgJg-1
X-Mimecast-MFC-AGG-ID: vnyXjP6UMwqHwutPtEbgJg_1783262099
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-492488f8583so21515525e9.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262099; x=1783866899; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qqAS8b/Gv9NQ3zOBRAXok3JwSvk1ksPGJ1eMtlRChKY=;
 b=S4ozIl0O78/M6cPvgqpoYbF9sK+fMRz/Cy27CBoBITEp2Sr1Mpj51FiE9zyGBsCmD4
 2vw2yJQGuSw5uPIJGvtLV6xd6aNCPLU+xnSK+z2rj+G5P6uoXj7di6EQvsOf6+ka8Phh
 DuXNbVk9v5Z2UUIc+xhq2LyQNxoWEhbP4ACu3vZk1qO1+ZbYKyjx7M3ALh6LnwGeAC2I
 T488dh4X8Z/Fv8Y7elDvChefpz6UKBnTH/GoxrpUaJaCn0j1BYy+acAYFa/51VbQc/lI
 NOtc6Zps3tU3/0XFau9BmbAO750tPR1ySD7wystexJW2QBkrmPYKNHliROQw//cAJSDX
 KruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262099; x=1783866899;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qqAS8b/Gv9NQ3zOBRAXok3JwSvk1ksPGJ1eMtlRChKY=;
 b=Ab7+W9hH8/XXHtf7HmP4Uuy0WqTb2yZwd2rb/pwJ8zShBr7JEJM37QTTex3jvnQSrE
 HQVsHmtk9sfiZXSWziZXmOfVPs0G1n9dAZ34fr9BOYc6Fmxhu+spHSurx0Ez5ERWh3sz
 m/vslyaIY8rEEamA5WHbfHLTmYGb9HXSuFOdjnTxjujuKMophsn/nPBJ1RInfPRX2RZ3
 fz/ufnHGiHULK6Ay/Jjq0+ZoZz6i9PPHiarIE/VV2TXaPpqsIY5PAZLEux5eNOfC9V4L
 RxqwmLV27cu8P1F1Ptl2Ij0M9Vrp2vT+T6BVt8A07e4FbwVHZjW0+SfNJKd9KApQO446
 vrBQ==
X-Gm-Message-State: AOJu0Yzu7YLGJU0k0rVConQTxYdKQbu9cCynaEg1buGfr2EQhSvXB/xr
 QLiO0KGYjOuXM8buxQaaQxEFJRFrn1mkE9yfReQinjGjaHZ9hgTRXlfTDpskNgAuRiTsPaxlSxO
 IKg6xW2hM3qHpISjZPTsgBq8Eti7skAfabjm43XTnggQOrJRAvMSuPOwEF2BJPFnIT2jBH9XXZk
 il/S+KRUoW7cyG/6ksuVo6x66ezFP7SKB/1A==
X-Gm-Gg: AfdE7ckZ5Eo9NpjuaTvNUUukW0Qp2YK4oegL51cZsSQ8kNmZMmkeGoaJGrn9zbiZcjb
 Iwtlk16gpwKwlKCA3qivYMOaPadJu8KSFVU8MLG6u0+mdQJnD9K/kaELdpLBquS/dsiUHTvX1kG
 IYzvblG3+7bTLs5Hm5JYAC74lRYHCZaEM2uIZGvZeNb93QudHdlNt21GHbWCl7wvdNiaeBvzJbB
 0V6rTYi0BZbvA5P96JV/0nKVjJZTtGOUQqyIk9FreNAXlPKQa4uOwq2gNIHXh+ae8/mCQ4dVlMs
 gUNMocLT6YRFvjPPw1P8+pLx/Ypu4gsozGdJoP222TbDxZPMoQbRFWeJ2mHEfUO/ZXn5Q4IZjby
 /YSTvP1azdyBlghsnioNQYzgzuiyJPiee
X-Received: by 2002:a05:600c:b8d:b0:493:ad1b:b38d with SMTP id
 5b1f17b1804b1-493d5ff8f97mr33941445e9.37.1783262098763; 
 Sun, 05 Jul 2026 07:34:58 -0700 (PDT)
X-Received: by 2002:a05:600c:b8d:b0:493:ad1b:b38d with SMTP id
 5b1f17b1804b1-493d5ff8f97mr33941105e9.37.1783262098234; 
 Sun, 05 Jul 2026 07:34:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d905sm16767920f8f.2.2026.07.05.07.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:34:57 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:34:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 fanhuang <FangSheng.Huang@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 07/44] qapi, hmp: introspection for the sp-mem device
Message-ID: <839c0a2bd8132cdef2faab952d7c3f49b9fa984c.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: fanhuang <FangSheng.Huang@amd.com>

Add a SpMemDeviceInfo variant to MemoryDeviceInfo so `query-memory-devices`
reports each sp-mem instance (id, addr, size, node, memdev), and print it
from HMP `info memory-devices`.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260623075051.3797975-3-FangSheng.Huang@amd.com>
---
 qapi/machine.json          | 43 ++++++++++++++++++++++++++++++++++++--
 hw/core/machine-hmp-cmds.c | 11 ++++++++++
 hw/mem/sp-mem.c            | 19 +++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b8..9b2248038f 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1413,6 +1413,32 @@
           }
 }
 
+##
+# @SpMemDeviceInfo:
+#
+# sp-mem device state information
+#
+# @id: device's ID
+#
+# @addr: physical address, where device is mapped
+#
+# @size: size of memory that the device provides, in bytes
+#
+# @node: NUMA proximity domain to which the device is assigned
+#
+# @memdev: memory backend linked with device
+#
+# Since: 11.1
+##
+{ 'struct': 'SpMemDeviceInfo',
+  'data': { '*id': 'str',
+            'addr': 'size',
+            'size': 'size',
+            'node': 'int',
+            'memdev': 'str'
+          }
+}
+
 ##
 # @MemoryDeviceInfoKind:
 #
@@ -1426,11 +1452,13 @@
 #
 # @hv-balloon: since 8.2.
 #
+# @sp-mem: since 11.1.
+#
 # Since: 2.1
 ##
 { 'enum': 'MemoryDeviceInfoKind',
   'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
-            'hv-balloon' ] }
+            'hv-balloon', 'sp-mem' ] }
 
 ##
 # @PCDIMMDeviceInfoWrapper:
@@ -1482,6 +1510,16 @@
 { 'struct': 'HvBalloonDeviceInfoWrapper',
   'data': { 'data': 'HvBalloonDeviceInfo' } }
 
+##
+# @SpMemDeviceInfoWrapper:
+#
+# @data: sp-mem device state information
+#
+# Since: 11.1
+##
+{ 'struct': 'SpMemDeviceInfoWrapper',
+  'data': { 'data': 'SpMemDeviceInfo' } }
+
 ##
 # @MemoryDeviceInfo:
 #
@@ -1499,7 +1537,8 @@
             'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
             'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
             'sgx-epc': 'SgxEPCDeviceInfoWrapper',
-            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
+            'hv-balloon': 'HvBalloonDeviceInfoWrapper',
+            'sp-mem': 'SpMemDeviceInfoWrapper'
           }
 }
 
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 46846f741a..686304bafa 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -279,6 +279,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     PCDIMMDeviceInfo *di;
     SgxEPCDeviceInfo *se;
     HvBalloonDeviceInfo *hi;
+    SpMemDeviceInfo *spmi;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
@@ -350,6 +351,16 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                     monitor_printf(mon, "  memdev: %s\n", hi->memdev);
                 }
                 break;
+            case MEMORY_DEVICE_INFO_KIND_SP_MEM:
+                spmi = value->u.sp_mem.data;
+                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
+                               MemoryDeviceInfoKind_str(value->type),
+                               spmi->id ? spmi->id : "");
+                monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", spmi->addr);
+                monitor_printf(mon, "  node: %" PRId64 "\n", spmi->node);
+                monitor_printf(mon, "  size: %" PRIu64 "\n", spmi->size);
+                monitor_printf(mon, "  memdev: %s\n", spmi->memdev);
+                break;
             default:
                 g_assert_not_reached();
             }
diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
index d088222f54..962d0f937e 100644
--- a/hw/mem/sp-mem.c
+++ b/hw/mem/sp-mem.c
@@ -53,6 +53,24 @@ static MemoryRegion *sp_mem_get_memory_region(MemoryDeviceState *md,
     return host_memory_backend_get_memory(spm->hostmem);
 }
 
+static void sp_mem_fill_device_info(const MemoryDeviceState *md,
+                                    MemoryDeviceInfo *info)
+{
+    SpMemDeviceInfo *di = g_new0(SpMemDeviceInfo, 1);
+    SpMemDevice *spm = SP_MEM(md);
+    DeviceState *dev = DEVICE(md);
+
+    di->id = dev->id ? g_strdup(dev->id) : NULL;
+    di->addr = spm->addr;
+    di->size = memory_region_size(
+                   host_memory_backend_get_memory(spm->hostmem));
+    di->node = spm->node;
+    di->memdev = object_get_canonical_path(OBJECT(spm->hostmem));
+
+    info->u.sp_mem.data = di;
+    info->type = MEMORY_DEVICE_INFO_KIND_SP_MEM;
+}
+
 static void sp_mem_realize(DeviceState *dev, Error **errp)
 {
     SpMemDevice *spm = SP_MEM(dev);
@@ -91,6 +109,7 @@ static void sp_mem_class_init(ObjectClass *oc, const void *data)
     mdc->set_addr            = sp_mem_set_addr;
     mdc->get_memory_region   = sp_mem_get_memory_region;
     mdc->get_plugged_size    = memory_device_get_region_size;
+    mdc->fill_device_info    = sp_mem_fill_device_info;
 }
 
 static const TypeInfo sp_mem_types[] = {
-- 
MST


