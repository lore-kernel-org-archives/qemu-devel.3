Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC5BCC6B1D
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvW2-0002vQ-K1; Wed, 14 Oct 2026 05:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvVv-0002sA-SM
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:43:13 -0400
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvVs-0001lL-Fz
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:43:11 -0400
Received: by mail-dl1-x122e.google.com with SMTP id
 a92af1059eb24-141395927feso7383076c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791970987; x=1792575787; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fjiM80axOxqiAuHJTGKwrnxOnG54YnafPzxwfp9Kqi0=;
 b=gTF8mgwzGfzLBkqbuXKSGVaEg74oTwQg19/2kvzDcSsyrz9Vb6/I//lf0e30+XxjTy
 BEmkuWnoR5cyJwWbE4e+ENkf89sr0W40YDA4iIUwreiO8gHFjTIBVR9K99t+ZigA7ESr
 H9lQvIU60DRqDkLJp9Ensu1OhoQXs5woZAUSmi1xn3dvF4n6jeO9IZrVW3dOJ+R3+i4Q
 J2BAFfhB32mfoX1Vg+9V7LDqZLGXS4EXFAI17Ii8CDEBzP62ZMLCeVphpG/lw6NymT/2
 qgn4+z+nj2jxT1aUVMVeqQOoe81JtQiZusbKRi10ZZ6SQpui8ljUSliWVLi4S1yHg2+b
 JYAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791970987; x=1792575787;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fjiM80axOxqiAuHJTGKwrnxOnG54YnafPzxwfp9Kqi0=;
 b=RDuA7VdxRdFPIaPvTEd0AgHwZbogQIOiLSoKP1y5WSXQhW8aevyb3z4/0SYGhMBsi8
 EbZAId06OsWvzDU/kFE1z04rEX+vScfFNpSMoX4kg+92HnhIpgzSlMmjjxQu6c/ynTre
 8w/Dwu+xgThv5lMc8l/xOswXI1T1F/oMvGeYDBqWQFNlZIizVY0AC17v1n9CNunlirqo
 /cwJzuEC0DqoiMgxtm+wEKp2d/32nfFZo7f+yXNkxKJ/8BhtbhcS+N+zPPrPIhDDDxEv
 ttgZrSnm5woORtZONXEC9fxLUIXmOAGlf1q8+d6k61I2mKzzvHND9++46W5SVVOyE0G2
 sUsg==
X-Gm-Message-State: AFq9FYIRPtNCXNow+W4LifiGafhy5V4zTQB31KUOcS+q2z5iwTein9/g
 oa4fBGxHvMpvcufwIIKzMW/oX6Z4MxhvTLj/lwIF3cd54foBFpCGGsEh00QuBkBxujw=
X-Gm-Gg: AYBFou2hKzf/1tBFipgKgqYvRUfPPB+a9aWl4DUwt1emcIkuotmZwbwQX7EVRwOIkLh
 xmrR2UZ8E+rlPZJMqoyigFgH/rA7rHjgE0nv49pSxl8522cGyKR+GXYquptcad6a5AlZXbIdrcc
 FmFEwzuTwolUNIP0MjRbeqoSPMzO7jASjN4EPrmHdZ5c7st7QwdM+OrsdGGk71MNhBpepgAEDtM
 85GBxpC/QACyDpWO+QIvyddnkJp0ue81eqzWwh12mvpVIBfKBu/NcHyjaMvTdOQIKpKLfM73n/S
 9ZfboolW28V6WxTuWrmJcTb08TVoW2tZ+yqMFXzaQoohbyOsMlhpBatsN+fhCjfg1UYP8jeaQD0
 nImcdAkKZ62lFCusBZeHMaBvhMnIPtapMxaiKE+zRgE+qFD9b/PYX72Iz5kB2TXmB2OmciBAo5Q
 jeuj524UPdNlk8zQnBAOpriNp47DzddXLxyN7+ysKApm3suQ8eFfmCP9N3HpD5gkP3BaZsBmjPT
 800tx3MHyLPoQAYUFvNa+MTRean
X-Received: by 2002:a05:701b:231b:b0:14f:5549:c1ea with SMTP id
 a92af1059eb24-16a57a16d44mr22952355c88.1.1791970986472; 
 Wed, 14 Oct 2026 02:43:06 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:43:05 -0700 (PDT)
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
Subject: [PATCH 19/34] hw/riscv/virt: use unique QOM name
Date: Wed, 14 Oct 2026 17:41:34 +0800
Message-ID: <20261014094224.1976-4-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::122e;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x122e.google.com
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

Use TYPE_RISCV_VIRT_MACHINE so the RISC-V virt QOM type does not
collide with ARM virt in a combined qemu-system binary. Keep the
-M / help / migration name as virt via machine_class_set_name().

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/riscv/virt.c         | 26 +++++++++++++-------------
 include/hw/riscv/virt.h |  5 ++++-
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index d4b501802f6..d8a2fd7d468 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -1134,6 +1134,7 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
 
     mc->desc = "RISC-V VirtIO board";
+    machine_class_set_name(mc, "virt");
     mc->init = virt_machine_init;
     mc->max_cpus = VIRT_CPUS_MAX;
     mc->default_cpu_type = TYPE_RISCV_CPU_BASE;
@@ -1196,21 +1197,20 @@ static void virt_machine_class_init(ObjectClass *oc, const void *data)
                                           "Enable IOMMU platform device");
 }
 
-static const TypeInfo virt_machine_typeinfo = {
-    .name       = MACHINE_TYPE_NAME("virt"),
-    .parent     = TYPE_MACHINE,
-    .class_init = virt_machine_class_init,
-    .instance_init = virt_machine_instance_init,
-    .instance_finalize = virt_machine_instance_finalize,
-    .instance_size = sizeof(RISCVVirtState),
-    .interfaces = (const InterfaceInfo[]) {
-         { TYPE_HOTPLUG_HANDLER },
-         { }
-    },
-};
-
 static void virt_machine_init_register_types(void)
 {
+    const TypeInfo virt_machine_typeinfo = {
+        .name = TYPE_RISCV_VIRT_MACHINE,
+        .parent = TYPE_MACHINE,
+        .class_init = virt_machine_class_init,
+        .instance_init = virt_machine_instance_init,
+        .instance_finalize = virt_machine_instance_finalize,
+        .instance_size = sizeof(RISCVVirtState),
+        .interfaces = (const InterfaceInfo[]) {
+            { TYPE_HOTPLUG_HANDLER },
+            { }
+        },
+    };
     type_register_static(&virt_machine_typeinfo);
 }
 
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index e516898f9ad..0f03e2546da 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -24,13 +24,16 @@
 #include "hw/core/sysbus.h"
 #include "hw/block/flash.h"
 #include "hw/intc/riscv_imsic.h"
+#include "qemu/target-info.h"
 
 #define VIRT_CPUS_MAX_BITS             9
 #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
 #define VIRT_SOCKETS_MAX_BITS          2
 #define VIRT_SOCKETS_MAX               (1 << VIRT_SOCKETS_MAX_BITS)
 
-#define TYPE_RISCV_VIRT_MACHINE MACHINE_TYPE_NAME("virt")
+#define TYPE_RISCV_VIRT_MACHINE \
+    (target_combined_binary() ? MACHINE_TYPE_NAME("riscv-virt") : \
+                                MACHINE_TYPE_NAME("virt"))
 typedef struct RISCVVirtState RISCVVirtState;
 DECLARE_INSTANCE_CHECKER(RISCVVirtState, RISCV_VIRT_MACHINE,
                          TYPE_RISCV_VIRT_MACHINE)
-- 
2.55.0.windows.3


