Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42198C88E7D
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 16:06:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Vbn-0000F0-En; Tue, 15 Sep 2026 12:02:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Vbe-0008Oe-U6
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:02:04 -0400
Received: from mail-ej2-x10.google.com ([2a00:1450:4864:34::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1x6Vba-0003W6-4N
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 12:02:01 -0400
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c254f560398so89508666b.1
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2026 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789488106; x=1790092906; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nNXJeaqt2s8P6UfDSK6Y1FWRU8dNfhhOhkwokU9p+w0=;
 b=mWl2IyY4qzc10WA6G4EUrTB6L/V/+5T3WTMjmUP5ZomSzJl7zv8n9RhYQLT+dOWlY1
 BvlJ/TCVZLLNy6+OIxURerM8Wqv13sbOPDRddUpzxnZ9vPgHjkyWVj/YdZ5nFwpSpohz
 G8yA/SQ/P3wX7HT/dAn1/BcY0Wuifyu/LvhVXmWMalfpzJdUhWnGTlCJN2dlJAMtMKfH
 ZJhueyasEyxLnDwa3V5OQkViAg8TvveKqTjI5PB/8CXVr9Mq5emivg+1QDumqHxx4f7O
 6DR7tQxkvpY86tvDIc/wDkscyHFOLW5x9fPm4+btIv3qnCoIST5JCs9xI0UON4k4+JYE
 7yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789488106; x=1790092906;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nNXJeaqt2s8P6UfDSK6Y1FWRU8dNfhhOhkwokU9p+w0=;
 b=ptlLna8dCkSVefFCAPvZjv6SQQ1nE8EM7pUTC2ys/Utm7a1ZGoxe5b7RSns0uRyfZG
 KajfLcnTPbU1w3MvbUyi3oWvC1uQb12drRxLr/oSW3mlhn9H7hIjWJMmJ/H6Dx46T0ZC
 xBaoq5s8PsrC2fxKZ0Djw+/wkJIg3jVwdqyQYO15iRf8wSfcVmigZK/rie9mSrUzSsvq
 Hr5MKBh/dQyu1sRs+F0klF+V9jh9V5naxMR/WrXlv9L6KtmNW36yDitAqFSi3ot+2EJY
 P4fGSnBqmRMzGQ9Tq/Yxcl/HQTNTu2Y+UYJfl25c3pTtfDYEwaMZqAHU3HSX56u21hB5
 AcTw==
X-Gm-Message-State: AFuF++n9u/PNnUedldESI6GAwVjtXDovQruPB65tDKkvqzTQR0u1fwdC
 WqQFc+fTpqIpLH+kv5LPohaCvWByZVC1HubVDwPeB7RVPTaFjS5NmscqkhUxeg==
X-Gm-Gg: AYBFou1KKPhmOtUDkk7ppxJQOWE9GvrdXZ8L54xNHZ3FcuALDNSX6YI2lL4FtBW0qYz
 78xshCb798T8AcL0ZMulc/EG5jwYR2spYbdMt/PJej6SvC/MmsiQh1q1EM7LQb7YkT5uwySHbY2
 LHHQRbbx70Iof9TjioPvBSyBf9zqsaQHP4GwQsj8z7EDLOgIxOjagy62JLtV+K+aAWTEIBW0CoW
 WM3KNL8r6EbyXyOZoE7CmA5scPRj31XipFbEV4g0ywgiwIrPvSS84SxUWKNr4uH8oXgBxPnxepA
 yAg1qVNdoLH8HQeEBv1a1i/23lh3Nrv7ebXK3QAiqUpYGZ9Lv3GfPqUbHwsKaUxhslVM+5eOygr
 mZWhZ2gXwf2zaLv2HcQ1fzWRoZyr0en4juo76ShrAz7Iey2qI/Kbltt+pdRtkYdNlTpNJ7TUFdE
 g4aRuYlo3W2Cz3jW6uURERi0gfkM9OAgLtVrfXTXmqf6gZGyqahw6u89zOYr8iT+5RpZmLbL44r
 axZwEuuZYbbAmOw34yv4bsgkeN2MeoPv1LmVcByv+ibtQ==
X-Received: by 2002:a17:907:d8b:b0:c29:3821:ae6c with SMTP id
 a640c23a62f3a-c29d7930b3bmr139194866b.37.1789488106085; 
 Tue, 15 Sep 2026 09:01:46 -0700 (PDT)
Received: from thinkpad-t470s.. (83-131-196-251.adsl.net.t-com.hr.
 [83.131.196.251]) by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-c29ddd86344sm3235866b.0.2026.09.15.09.01.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 09:01:45 -0700 (PDT)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 peter.maydell@linaro.org, francisco.iglesias@amd.com,
 edgar.iglesias@gmail.com, berrange@redhat.com, eugene@nuvacore.ai,
 Ruslan_Ruslichenko@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v2 20/20] hw/core: Add FDT support to Remote Port memory master
Date: Tue, 15 Sep 2026 18:00:44 +0200
Message-ID: <20260915160044.345788-21-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915160044.345788-1-ruslichenko.r@gmail.com>
References: <20260915160044.345788-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:34::10;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ej2-x10.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Implement the FDTGenericMMap interface for the Remote Port
Memory Master.

This enables the device to dynamically parse memory ranges
defined in the Device Tree ('reg' property) and register
them as system bus MMIO regions.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/remote-port-memory-master.c | 34 +++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/hw/core/remote-port-memory-master.c b/hw/core/remote-port-memory-master.c
index 41ef1df518..4ef03c9599 100644
--- a/hw/core/remote-port-memory-master.c
+++ b/hw/core/remote-port-memory-master.c
@@ -23,6 +23,8 @@
 #include "hw/core/remote-port.h"
 #include "hw/core/remote-port-memory-master.h"
 
+#include "hw/core/fdt_generic_util.h"
+
 #define REMOTE_PORT_MEMORY_MASTER_PARENT_CLASS \
     object_class_get_parent( \
             object_class_by_name(TYPE_REMOTE_PORT_MEMORY_MASTER))
@@ -298,6 +300,35 @@ static void rp_memory_master_init(Object *obj)
                              OBJ_PROP_LINK_STRONG);
 }
 
+static bool rp_parse_reg(FDTGenericMMap *obj, FDTGenericRegPropInfo reg,
+                         Error **errp)
+{
+    RemotePortMemoryMaster *s = REMOTE_PORT_MEMORY_MASTER(obj);
+    FDTGenericMMapClass *parent_fmc =
+        FDT_GENERIC_MMAP_CLASS(REMOTE_PORT_MEMORY_MASTER_PARENT_CLASS);
+    int i;
+
+    /* Initialize rp_ops from template.  */
+    s->rp_ops = g_malloc(sizeof *s->rp_ops);
+    memcpy(s->rp_ops, &rp_ops_template, sizeof *s->rp_ops);
+    s->rp_ops->valid.max_access_size = s->max_access_size;
+    s->rp_ops->impl.max_access_size = s->max_access_size;
+
+    s->mmaps = g_new0(typeof(*s->mmaps), reg.n);
+    for (i = 0; i < reg.n; ++i) {
+        char *name = g_strdup_printf("rp-%d", i);
+
+        s->mmaps[i].offset = reg.a[i];
+        memory_region_init_io(&s->mmaps[i].iomem, OBJECT(obj), s->rp_ops,
+                              &s->mmaps[i], name, reg.s[i]);
+        sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmaps[i].iomem);
+        s->mmaps[i].parent = s;
+        g_free(name);
+    }
+
+    return parent_fmc ? parent_fmc->parse_reg(obj, reg, errp) : false;
+}
+
 static Property rp_properties[] = {
     DEFINE_PROP_UINT32("map-num", RemotePortMemoryMaster, map_num, 0),
     DEFINE_PROP_UINT64("map-offset", RemotePortMemoryMaster, map_offset, 0),
@@ -310,9 +341,11 @@ static Property rp_properties[] = {
 
 static void rp_memory_master_class_init(ObjectClass *oc, const void *data)
 {
+    FDTGenericMMapClass *fmc = FDT_GENERIC_MMAP_CLASS(oc);
     DeviceClass *dc = DEVICE_CLASS(oc);
     device_class_set_props_n(dc, rp_properties, ARRAY_SIZE(rp_properties));
     dc->realize = rp_memory_master_realize;
+    fmc->parse_reg = rp_parse_reg;
 }
 
 static const TypeInfo rp_info = {
@@ -322,6 +355,7 @@ static const TypeInfo rp_info = {
     .instance_init = rp_memory_master_init,
     .class_init    = rp_memory_master_class_init,
     .interfaces    = (InterfaceInfo[]) {
+        { TYPE_FDT_GENERIC_MMAP },
         { TYPE_REMOTE_PORT_DEVICE },
         { },
     },
-- 
2.43.0


