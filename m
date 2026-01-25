Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E99DE63C85
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 06:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjtqm-0003HT-O3; Sun, 25 Jan 2026 01:43:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjtqa-00035A-FT; Sun, 25 Jan 2026 01:43:45 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjtqX-0001OD-JF; Sun, 25 Jan 2026 01:43:44 -0500
Received: from h205.csg.ci.i.u-tokyo.ac.jp (h205.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.205]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60P6h74g079417
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 25 Jan 2026 15:43:18 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=V6Tcy99VmbiSxXOyzt3hsil73wVMmCmWdx3HXcW6znc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Date:Subject:Message-Id:To;
 s=rs20250326; t=1769323398; v=1;
 b=tXP0iVUau7d6jUrJm2mpd5UjB0NodHGa53u0HcORjJwnuOzWicEHYNszSTN8Z+z2
 tzYCtGTiPjSEirBtPV1QnjJc73Skt77lSmAEGaWXzL+9wcF61lz/qncHsbqPzdqm
 RjqfSnY/BUJS51ZfTWsRdDLQ+3IR8ymuDfzx7qbhjaWAfBl751RZmHgIHz4+GxS1
 c2yMBuu49YSmdfN61jHl4w0mdhSW305miOk4j4Dd9pjAjmadcvZV8dtwET9xdmNf
 Ln/EFt5KCZrAzPfvOdgC+JmjV9foFi6xQZL55hx06jNzYYTPSchmKqe07pcGu4Q6
 Oorqc39yUr46mR1sGiHO0Q==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 25 Jan 2026 15:42:47 +0900
Subject: [PATCH 5/5] hw/nvme: Fix bootindex suffix use-after-free
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260125-nvme-v1-5-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
To: qemu-devel@nongnu.org
Cc: Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.15-dev-179e8
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The bootindex suffix can be used as long as the property is alive.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/nvme/nvme.h | 1 +
 hw/nvme/ns.c   | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/nvme/nvme.h b/hw/nvme/nvme.h
index 8f8c78c85036..d66f7dc82d5c 100644
--- a/hw/nvme/nvme.h
+++ b/hw/nvme/nvme.h
@@ -239,6 +239,7 @@ typedef struct NvmeNamespace {
     DeviceState  parent_obj;
     BlockConf    blkconf;
     int32_t      bootindex;
+    char         bootindex_suffix[24];
     int64_t      size;
     int64_t      moff;
     NvmeIdNs     id_ns;
diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 58800b3414a3..38f86a17268f 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -944,12 +944,11 @@ static void nvme_ns_class_init(ObjectClass *oc, const void *data)
 static void nvme_ns_instance_init(Object *obj)
 {
     NvmeNamespace *ns = NVME_NS(obj);
-    char *bootindex = g_strdup_printf("/namespace@%d,0", ns->params.nsid);
 
-    device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
-                                  bootindex, DEVICE(obj));
+    sprintf(ns->bootindex_suffix, "/namespace@%" PRIu32 ",0", ns->params.nsid);
 
-    g_free(bootindex);
+    device_add_bootindex_property(obj, &ns->bootindex, "bootindex",
+                                  ns->bootindex_suffix, DEVICE(obj));
 }
 
 static const TypeInfo nvme_ns_info = {

-- 
2.52.0


