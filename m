Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D01DC28B30
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 03:41:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvTFA-00033s-Vu; Thu, 20 Mar 2025 23:40:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tvTF2-0002zB-RW
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:40:16 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1tvTEy-0007zq-1h
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 23:40:16 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-223f4c06e9fso25560765ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 20:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1742528410; x=1743133210;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NfKOJTQOYbrs0vGr3dO1ve34x5rJ0Tkuk4SBJVbV9Z4=;
 b=YuFZzfPiVAuq3nypDmMn1tCo21Oz8ihyzFmbf/RxJoFPGdTshxazrYEmbHib6OFqbL
 S/eWiXDVkB50LbzxldGjfZDr1njc8vGtj5cMH0r+SKXcU9q3IHjWv9as4CKjHMghmtxY
 8Kp0Gbj5C8JIPW0vzsCgziURT6M+TrCdFSsCqGPPFne4GinfhR+IqilqYS3bbCsjTHBO
 YwjyvzBuOhrWwpSSKJl7kpgeK76QWkEVdsv0t2neWHVgTcFDVSjzHuYUH0w9FO3hib1w
 xkclTl7d68+6H8ZVavp/kaxhjQjiNusX/fap2WIaJXs1zybeRqCPEIlz9Bpg0QVTzpk1
 LBUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742528410; x=1743133210;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NfKOJTQOYbrs0vGr3dO1ve34x5rJ0Tkuk4SBJVbV9Z4=;
 b=t9XUE9AjKl4HQe7uCWd5ycSNIssdf1O4ecZvjSn5M3LCYhE84/N/jh/AMbRYWDcJhb
 +L8DdDtfXppIJP0FyRl+5Qw1Re30peHBz8Eb0xgunAWr+T8n7DD/2SkM0AAk0AT7f0qx
 /BImgYE/itGtg+4tdEICzp1pt5PcQaRdGzF7dSg54tNPvBPvi1isqKedlZYWNb7PY0Xv
 VhHHNGsBoRztfCfLSldO+zuapNtErQzv6/wX3nCT5hyjqCUC9qQiNMursOZ6aJ9t866k
 plG2b4Vz661hickzxGXW9c6noIEnw2ZuYsfMo07LGkQ9SE3xbO0IpjovPvAHIXUNtqpl
 juYw==
X-Gm-Message-State: AOJu0YylvOhSJmmLjYK8IR9oSXgAbbskkYNKraOo7Sdvq+ErueVcwmv1
 vBW31+IRMa8IDhRP3iglfkfiy+6ywpH9LjSiOy4Zk2Cfj1Tpfsaqlc79VwBVYPs57AeIJ6pA4H7
 PuWVYTaA6
X-Gm-Gg: ASbGncsGDUTItU45bmEVWJbJLfnfejfV5o7/0bXTJ+pvokax02Z7LADzx1OoT6S3pTA
 mkWjc33S4Lf8sXs0xnxG6s31i+NQA76ACGtGCFe77HEYgWvPQu6R2Pqt4OkV7N9pyp1mB+vWNhh
 L/uUTlqk0x4paK2Wm3k55BxWFmzOMlq/1SqsxpWy+fjQNj56DSbSuM6KXraA0Edm+nGqFyudsaG
 5RWEEbguHUsJF69S9nsGf16jNI9l+DPKXEhQuGYJ6wxeRiLJXYxc6KgOTTPqRE/g2i2SH0a9SOo
 rZEaiqs7njKBSfY1mZIc0uTqC70MffzFG9Algtug5DCebhXH6GMQnEzdCXTIAB+l0g==
X-Google-Smtp-Source: AGHT+IGytROYCv3EdDQ2BN/8KuwRYYXcSxc2zq96F8D0vDp4poV6FcDQanb7BetzxrUahZaLTWq2OQ==
X-Received: by 2002:a17:902:d9d0:b0:21f:6d63:6f4f with SMTP id
 d9443c01a7336-2265e67fa37mr76457265ad.2.1742528409762; 
 Thu, 20 Mar 2025 20:40:09 -0700 (PDT)
Received: from Hyman-Dev-Euler.zelin.local ([103.85.74.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-227811b8075sm6079725ad.128.2025.03.20.20.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 20:40:09 -0700 (PDT)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>, dengpc12@chinatelecom.cn
Subject: [RFC 2/3] vdagent: Set up mouse and clipboard after live migration
Date: Fri, 21 Mar 2025 11:38:12 +0800
Message-Id: <3c9498ef25fd8c5f705a4c6ee2dc46666c322ada.1742527956.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1742527956.git.yong.huang@smartx.com>
References: <cover.1742527956.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Hyman Huang <yong.huang@smartx.com>

The struct VDAgentChardev's caps, last_serial, and cbpending
fields need to be migrated in order to allow live migration
for vdagent. And the clipboard and mouse should be configured
to correspond with the previously negotiated caps on the
destination.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 ui/vdagent.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/ui/vdagent.c b/ui/vdagent.c
index 7a1cf674d0..4635e8fa56 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -7,6 +7,7 @@
 #include "qemu/units.h"
 #include "hw/qdev-core.h"
 #include "migration/blocker.h"
+#include "migration/vmstate.h"
 #include "ui/clipboard.h"
 #include "ui/console.h"
 #include "ui/input.h"
@@ -912,6 +913,72 @@ static void vdagent_chr_parse(QemuOpts *opts, ChardevBackend *backend,
     cfg->clipboard = qemu_opt_get_bool(opts, "clipboard", VDAGENT_CLIPBOARD_DEFAULT);
 }
 
+static void vdagent_release_clipboard_all_types(VDAgentChardev *vd,
+                                                QemuClipboardSelection s)
+{
+    uint32_t type;
+
+    for (type = 0; type < QEMU_CLIPBOARD_TYPE__COUNT; type++) {
+        if (vd->cbpending[s] & (1 << type)) {
+            vd->cbpending[s] &= ~(1 << type);
+            g_autofree VDAgentMessage *msg =
+                g_malloc0(sizeof(VDAgentMessage) + sizeof(uint32_t));
+
+            uint8_t *selection = msg->data;
+            *selection = s;
+            msg->size += sizeof(uint32_t);
+            msg->type = VD_AGENT_CLIPBOARD_RELEASE;
+
+            vdagent_send_msg(vd, msg);
+        }
+    }
+}
+
+static int vdagent_post_load(void *opaque, int version_id)
+{
+    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(opaque);
+    QemuClipboardSelection s = QEMU_CLIPBOARD_SELECTION_CLIPBOARD;
+
+    if (vd->caps) {
+        if (have_mouse(vd)) {
+            vd->mouse_hs =
+                qemu_input_handler_register(&vd->mouse_dev,
+                                            &vdagent_mouse_handler);
+            if (vd->mouse_hs) {
+                qemu_input_handler_activate(vd->mouse_hs);
+            }
+        }
+
+        if (have_clipboard(vd)) {
+            vdagent_register_to_qemu_clipboard(vd);
+            if (have_selection(vd)) {
+                for (; s < QEMU_CLIPBOARD_SELECTION__COUNT; s++) {
+                    vdagent_release_clipboard_all_types(vd, s);
+                }
+            } else {
+                vdagent_release_clipboard_all_types(vd, s);
+            }
+        }
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_vdagent = {
+    .name = "vdagent",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = vdagent_post_load,
+    .fields = (VMStateField[]){
+        VMSTATE_UINT32(caps, VDAgentChardev),
+        VMSTATE_UINT32_ARRAY(last_serial, VDAgentChardev,
+                QEMU_CLIPBOARD_SELECTION__COUNT),
+        VMSTATE_UINT32_ARRAY(cbpending, VDAgentChardev,
+                QEMU_CLIPBOARD_SELECTION__COUNT),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 /* ------------------------------------------------------------------ */
 
 static void vdagent_chr_class_init(ObjectClass *oc, void *data)
@@ -930,6 +997,7 @@ static void vdagent_chr_init(Object *obj)
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
 
     buffer_init(&vd->outbuf, "vdagent-outbuf");
+    vmstate_register(NULL, 0, &vmstate_vdagent, vd);
     error_setg(&vd->migration_blocker,
                "The vdagent chardev doesn't yet support migration");
 }
-- 
2.27.0


