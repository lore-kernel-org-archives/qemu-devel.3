Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B206FF42100
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 17:39:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD4Cb-0000Bn-RE; Wed, 15 Apr 2026 13:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wD4CZ-0000AQ-7c
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 13:38:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <matthieu@minio.io>) id 1wD4CX-0002kn-FC
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 13:38:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a29e6110so75767855e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 10:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=minio.io; s=minio; t=1776274736; x=1776879536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=czMoe/c8/XX5KWWs2YbJoq4mu8G0tJQUrKnaro6zT2M=;
 b=SmyD8BSQ590BU28c9vs6K5UFLRcP9DSeHT1gG6z8Wsp7CYTBaOiOWucmfl3jsRnczd
 u+OtausaHc9ksIcSXN8Z7EBaNNISZGvMvlz8DgFgyht/wXXfjXtfV77R0XrL9Ne+QyBZ
 ZP4JB2iiwF6YdTrSxJdgXDG80zGgOYrKoG6rS9ZNH62jykzcMVfh15Dgu7j5CJWA41/r
 pRDQBisQAo5UX4jrxHLvvpt/HAfu122AANdtBEWHYdjFUp2Q5+EaDeR5NLSFjow8pEnS
 Wy9FH0GiIfGG/3wCYRmApcRUmt69aA2+y6g0McVb+RSUJhaW8eslQaKpp13sn1wqP4g5
 1+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776274736; x=1776879536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=czMoe/c8/XX5KWWs2YbJoq4mu8G0tJQUrKnaro6zT2M=;
 b=FeqXwlWyr/Zn5/wh5vJYYd/NhPjnkxmJcOzAHoKiMns30Ey54IVvxoELFUYXBfEHja
 IoXSb9IsEVpOSn7zEMH07lCvFSj+KWLzxbsk5eD2/EU9ltuK7lA/K3yeTFo2DarX8gKb
 gNyqYjldSLdC8jdMZBmUdWaw6kR8AAmF7QZj94ix9Ke+TQAUqj9Sq7uGEXxxr+CcMoP7
 fqXYLqfxL31UASUzi2PULY2NsjhMDTKM4lhUZllxn33f+CrHHaRcP5WGwf3s7Awp+Vri
 /mNC4VsBWGJq8PTnzVKKrHvO2c7VamzHyOdsx+9CbzHJmkFsGbmeiAjpeyYOkVDjVwx3
 EeXw==
X-Gm-Message-State: AOJu0YxQzR1yRjqBSCUTozJLjSvyMLDkoXqhxIxMmz31T6eaKmAwjzQY
 wE1uJcbqQ9d7mGH0L7z9/eKiM034zY03ScT91D34loXdavihnTTPANteE/GEMtnEeGdQFASMyow
 zVjAPPCPgtfkHfCZW+MvmCU0SNmFF6L7+ptfW09ebsSFS+ewtLJ91VctG1cY6AnWk16hRnRz3qk
 6CpeVACRTslq/4eilhl8skx1Z6rvq+CWLJNlN9WxQ=
X-Gm-Gg: AeBDievMbdFozrg1fBfXXwJFiXpu/FY1APfEvz3/y9rNrJQ+LLXxI1Vx1TELuWX8UCD
 KOJvZ+dOytOFIRDCHZPeLN/YSp13R2KrQpvGHSkv8VS3nX+GMXHb+3++fXbc4onSWJQLo2I2EdG
 FbqDyuPXlZGb00TQH9ImE9F9xu2SfTJJ1Ih1ZzIXcEEjsHvGGpyOxgYiaJwLXylyEC0Kx51kYhs
 MLA8hTJuVg2DZDeuBoccaP89IHV1EGWcNZ+Wrtw291au+mhlK9yG0q8NDvECuiCSXsJhdLaMgP6
 lx47J07HnMQfiF2DwbDt+N0KagbBeL4bTJiG/oxRATwEB1DBTaaXfK/I41peCRJaV6PUkV/aDKl
 z4LlVdQmzjzn9HM8tFCSc75/zbt+XEsL7fgyr2jGLocA8sOPGEcZ8wPzgW2aOVmOzKcUafvjKSM
 TbN80ecC+cWZCyBtPtqvOKnW/TcwQucUegEWGD8j8xrZiBkflVwKSdA2KVffLGIbOlNoa0bruyh
 ChGN0I6tSTmdN9fOYrN43KXhlDK/M7xoGnfZP6Vx6/ebqJKJIaTY0skpPklqGLu7IoKfEhH6RGX
 ZkdZTQ==
X-Received: by 2002:a05:600c:a305:b0:488:ab37:b442 with SMTP id
 5b1f17b1804b1-488d68c7f92mr216679995e9.28.1776274735540; 
 Wed, 15 Apr 2026 10:38:55 -0700 (PDT)
Received: from localhost (2a01cb001411480010f92e9cd3b40a22.ipv6.abo.wanadoo.fr.
 [2a01:cb00:1411:4800:10f9:2e9c:d3b4:a22])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-488f0edaf47sm24184345e9.35.2026.04.15.10.38.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Apr 2026 10:38:55 -0700 (PDT)
From: mr-083 <matthieu@minio.io>
X-Google-Original-From: mr-083 <matthieu@min.io>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: its@irrelevant.dk, kbusch@kernel.org, stefanha@redhat.com,
 berrange@redhat.com, mr-083 <matthieu@min.io>
Subject: [PATCH] block: add blockdev-attach QMP command
Date: Wed, 15 Apr 2026 19:39:05 +0200
Message-ID: <20260415173905.71224-1-matthieu@min.io>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=matthieu@minio.io; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HK_NAME_MR_MRS=0.998,
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

Add a blockdev-attach QMP command that attaches a block driver state
tree to a device's block backend.  Unlike blockdev-insert-medium, this
works for non-removable devices such as NVMe namespaces.

After drive_del removes a device's backing store, the BlockBackend
remains attached to the guest device but has no BlockDriverState.
blockdev-attach reconnects a block node (previously created with
blockdev-add) to the device's BlockBackend via blk_insert_bs().

This separates the two concerns as recommended: blockdev-add creates
the block node, blockdev-attach associates it with the device.

Example usage with NVMe namespace hot-swap:
  drive_del drv0
  blockdev-add node-name=node0 driver=qcow2 file.driver=file \
               file.filename=disk.qcow2
  blockdev-attach id=ns0 node-name=node0

An HMP wrapper is included for convenience.

Signed-off-by: Matthieu <matthieu@min.io>
---
 block/monitor/block-hmp-cmds.c | 10 ++++++++++
 block/qapi-system.c            | 36 ++++++++++++++++++++++++++++++++++
 hmp-commands.hx                | 16 +++++++++++++++
 include/block/block-hmp-cmds.h |  1 +
 qapi/block.json                | 33 +++++++++++++++++++++++++++++++
 5 files changed, 96 insertions(+)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 1fd28d59eb..8a3d821e01 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -195,6 +195,16 @@ unlock:
     hmp_handle_error(mon, err);
 }
 
+void hmp_blockdev_attach(Monitor *mon, const QDict *qdict)
+{
+    const char *id = qdict_get_str(qdict, "id");
+    const char *node_name = qdict_get_str(qdict, "node-name");
+    Error *err = NULL;
+
+    qmp_blockdev_attach(id, node_name, &err);
+    hmp_handle_error(mon, err);
+}
+
 void hmp_commit(Monitor *mon, const QDict *qdict)
 {
     const char *device = qdict_get_str(qdict, "device");
diff --git a/block/qapi-system.c b/block/qapi-system.c
index 54b7409b2b..ec89645bc1 100644
--- a/block/qapi-system.c
+++ b/block/qapi-system.c
@@ -304,6 +304,42 @@ void qmp_blockdev_insert_medium(const char *id, const char *node_name,
     blockdev_insert_medium(NULL, id, node_name, errp);
 }
 
+void qmp_blockdev_attach(const char *id, const char *node_name,
+                         Error **errp)
+{
+    BlockBackend *blk;
+    BlockDriverState *bs;
+    int ret;
+
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    blk = qmp_get_blk(NULL, id, errp);
+    if (!blk) {
+        return;
+    }
+
+    if (blk_bs(blk)) {
+        error_setg(errp, "Device already has a medium inserted");
+        return;
+    }
+
+    bs = bdrv_find_node(node_name);
+    if (!bs) {
+        error_setg(errp, "Node '%s' not found", node_name);
+        return;
+    }
+
+    if (bdrv_has_blk(bs)) {
+        error_setg(errp, "Node '%s' is already in use", node_name);
+        return;
+    }
+
+    ret = blk_insert_bs(blk, bs, errp);
+    if (ret < 0) {
+        return;
+    }
+}
+
 void qmp_blockdev_change_medium(const char *device,
                                 const char *id,
                                 const char *filename,
diff --git a/hmp-commands.hx b/hmp-commands.hx
index 5cc4788f12..ce32ed33ab 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -207,6 +207,22 @@ SRST
   actions (drive options rerror, werror).
 ERST
 
+    {
+        .name       = "blockdev-attach",
+        .args_type  = "id:s,node-name:s",
+        .params     = "id node-name",
+        .help       = "attach a block node to a device (non-removable)",
+        .cmd        = hmp_blockdev_attach,
+    },
+
+SRST
+``blockdev-attach`` *id* *node-name*
+  Attach a block driver state tree (created with ``blockdev-add``) to a
+  device's block backend. Unlike ``blockdev-insert-medium``, this works
+  for non-removable devices such as NVMe namespaces. The device must
+  have no medium inserted (e.g. after ``drive_del``).
+ERST
+
     {
         .name       = "change",
         .args_type  = "device:B,force:-f,target:F,arg:s?,read-only-mode:s?",
diff --git a/include/block/block-hmp-cmds.h b/include/block/block-hmp-cmds.h
index 71113cd7ef..34d30915fc 100644
--- a/include/block/block-hmp-cmds.h
+++ b/include/block/block-hmp-cmds.h
@@ -21,6 +21,7 @@ void hmp_drive_add(Monitor *mon, const QDict *qdict);
 
 void hmp_commit(Monitor *mon, const QDict *qdict);
 void hmp_drive_del(Monitor *mon, const QDict *qdict);
+void hmp_blockdev_attach(Monitor *mon, const QDict *qdict);
 
 void hmp_drive_mirror(Monitor *mon, const QDict *qdict);
 void hmp_drive_backup(Monitor *mon, const QDict *qdict);
diff --git a/qapi/block.json b/qapi/block.json
index 46955bbb3e..c05d3b5ac1 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -295,6 +295,39 @@
   'data': { 'id': 'str',
             'node-name': 'str'} }
 
+##
+# @blockdev-attach:
+#
+# Attach a block driver state tree to a device's block backend.
+# Unlike blockdev-insert-medium, this works for non-removable
+# devices such as NVMe namespaces.  The device must currently have
+# no medium inserted (e.g. after drive_del removed the backing).
+#
+# @id: The name or QOM path of the guest device
+#
+# @node-name: name of a node in the block driver state graph
+#
+# Since: 11.1
+#
+# .. qmp-example::
+#
+#     -> { "execute": "blockdev-add",
+#          "arguments": {
+#              "node-name": "node0",
+#              "driver": "qcow2",
+#              "file": { "driver": "file",
+#                        "filename": "disk.qcow2" } } }
+#     <- { "return": {} }
+#
+#     -> { "execute": "blockdev-attach",
+#          "arguments": { "id": "ns0",
+#                         "node-name": "node0" } }
+#     <- { "return": {} }
+##
+{ 'command': 'blockdev-attach',
+  'data': { 'id': 'str',
+            'node-name': 'str'} }
+
 ##
 # @BlockdevChangeReadOnlyMode:
 #
-- 
2.53.0


