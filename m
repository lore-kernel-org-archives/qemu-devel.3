Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929B9CC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 09:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGvYI-0007Xm-4j; Wed, 14 Oct 2026 05:45:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvXp-0006nL-4B
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:45:12 -0400
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xGvXm-0002SL-U4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 05:45:08 -0400
Received: by mail-dl1-x1232.google.com with SMTP id
 a92af1059eb24-1419d3416ceso1195622c88.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 02:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791971105; x=1792575905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lWFJW68tgkxCtQcIzjppGsjAMqUe5y9plX0JR/pSP1U=;
 b=VTAVvL6KU0XOuI3pP6jBqQUB8Jisj6pZI04Fej6g+8gCBN/QlTlo7xS32PwZPwRYTH
 BqFlO/F2hu32XT5xz0zgEWPneBPa6II665y3ThZOFLflUtARIYD5Vcgk7NNIl287baVM
 q0g8RmAxy/JjYEehQw4kAGP9U6v27hM/6G0vJfumhrig3i+uQOZQQ2jN/FbLYClpyVG3
 p/AvesMJsjBVUxElYNEsKgSqrhzcpgXOz3fXlSAJZGEM9lREAYK1qO4pp9J9gO43Nhzl
 Jn5+n3kV8kqCu2gv+XQQ2JAsh2rN/29TqZ9xKh/4IwXYxiPb+tpVwIDwngx0o241jLLB
 PeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791971105; x=1792575905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lWFJW68tgkxCtQcIzjppGsjAMqUe5y9plX0JR/pSP1U=;
 b=pXU8EcGabtyDBfiJZTB9zJh17/zhaBBtyOEbCU1ysbAOTWNz3xZ5Mb5JZLG9ajG+1d
 9qDPkTMsSDp2yx8Cy3b5/HexwYzKGAdtqTiZF3J8cQkJkaD6NrTAKwyoG898D2GhvRXq
 AciJHFL4fU3fkit9aJkFjcXtOvjbmqktRNPwxV2T99XG12pwrNqkVdmVi+N7U8sRwiPi
 OXAp80ZMS0Ubm1Wo28Y3xA5NyCbHGnr4ocgVeFbRNQxNBy8EOCEUYubSwzT05usj5G8e
 AtfA9jboOJu0HIbdCvbz/lOaaQ6/J0W31iDknUwnyXC5opNQpWK06rQoYZ3vz6AraFjs
 8m3A==
X-Gm-Message-State: AFq9FYJiqGEwGSNO1o269iej/9tGPfKByPWUHNjHj+Uv2fVNZKNeXlRW
 MkWAOQl2fUFcYmN9j3bE0/4Fq+G+YPHmobvqP2Hhun5LaYcqUsxb7gsjDxgNA9G9o50=
X-Gm-Gg: AYBFou1rH15CI6mbv02o7hVJXXuE2IatJVJcPoilvqfZLgXwFvSxnkBbN0MOcqSdijb
 dNmOVBl3hO9DahzHC/S+ab49TYtTJYJN0fAx1uTqXZo24bECOcmneOska0DW5C8FJqQr6z1E3t+
 /WBcOpz4fkAEUvJrvrAHuq4IOEb9rt0kBHlCIMmrg+P1WTyRneKDcozCNlDym9TzCLTm+NhFM4h
 rWTbUQ3RIc23/kWZcJRLU/ldxyDS9bvzAWITMcwhQQsFVEn6MKkIm1fHG+1PZbE3LzBdrlIPAO4
 74b8Msl2kt+wjmVgoE0715MmldL2nJItP+T1COyB4y5pYgBiSU3WdqAGuPo/Prj3d0O60y1cFQf
 D0xu9sle87UXxALkrHU/Zu5GbQ1SxmljiPy/Uk/mkIjFWmfjmTckKo5kefpeoesOVdNbLZyFk+S
 nnadokVBExOpfym328G8j8mUu/yUGGDF0F/H97dOTR0vhSQ82JAlN7XZJMMtj5Krt6Hac6F9zJq
 qGzlJ0PJy2KQjKlSA==
X-Received: by 2002:a05:7022:ea8b:b0:14a:8df8:56c5 with SMTP id
 a92af1059eb24-16a61789ffcmr19374590c88.26.1791971105293; 
 Wed, 14 Oct 2026 02:45:05 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-169a31f6f5csm44348380c88.11.2026.10.14.02.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 02:45:03 -0700 (PDT)
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
Subject: [PATCH 31/34] qmp: Expose supported targets in query-machines
Date: Wed, 14 Oct 2026 17:41:46 +0800
Message-ID: <20261014094224.1976-16-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261014094224.1976-1-luoyonggang@gmail.com>
References: <20261014094224.1976-1-luoyonggang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1232;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1232.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
---
 hw/core/machine-qmp-cmds.c | 16 ++++++++++++++++
 qapi/machine.json          |  5 ++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 59818764dad..620d64585e5 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -21,8 +21,10 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
 #include "qemu/uuid.h"
+#include "qemu/base-arch-defs.h"
 #include "qemu/target-info.h"
 #include "qemu/target-info-qapi.h"
+#include "qemu/target-info-qom.h"
 #include "qom/qom-qobject.h"
 #include "system/hostmem.h"
 #include "system/hw_accel.h"
@@ -104,6 +106,8 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         MachineClass *mc = el->data;
         const char *default_cpu_type = machine_class_default_cpu_type(mc);
         MachineInfo *info;
+        QemuTargetInfoList **target_tail;
+        GSList *tel;
 
         info = g_malloc0(sizeof(*info));
         if (mc->is_default) {
@@ -130,6 +134,18 @@ MachineInfoList *qmp_query_machines(bool has_compat_props, bool compat_props,
         }
         info->secure = object_class_is_secure(OBJECT_CLASS(mc));
 
+        target_tail = &info->targets;
+        for (tel = target_info_qom_get_targets(); tel; tel = tel->next) {
+            const TargetInfo *ti = TARGET_INFO_CLASS(tel->data)->target_info;
+
+            if (mc->targets & QEMU_ARCH_BIT(ti->target_arch)) {
+                QemuTargetInfo *target = g_new0(QemuTargetInfo, 1);
+
+                target->arch = ti->target_arch;
+                QAPI_LIST_APPEND(target_tail, target);
+            }
+        }
+
         if (compat_props && mc->compat_props) {
             int i;
             info->compat_props = NULL;
diff --git a/qapi/machine.json b/qapi/machine.json
index 47fbc422ec5..ee089ff8c68 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -189,6 +189,9 @@
 #
 # @acpi: machine type supports ACPI (since 8.0)
 #
+# @targets: targets supported by this machine
+#     (since 11.2)
+#
 # @compat-props: The machine type's compatibility properties.  Only
 #     present when `query-machines` argument @compat-props is true.
 #     (since 9.1)
@@ -212,7 +215,7 @@
             '*default-ram-id': 'str', 'acpi': 'bool',
             '*compat-props': { 'type': ['CompatProperty'],
                                'features': ['unstable'] },
-            'secure': 'bool' } }
+            'secure': 'bool', 'targets': ['QemuTargetInfo'] } }
 
 ##
 # @query-machines:
-- 
2.55.0.windows.3


