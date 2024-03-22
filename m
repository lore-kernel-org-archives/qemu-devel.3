Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8537CC47DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 13:06:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rneZm-0001fL-4s; Fri, 22 Mar 2024 09:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.poetzsch@kernkonzept.com>)
 id 1rnc5V-0008Ni-DF
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:25:27 -0400
Received: from serv1.kernkonzept.com ([2a01:4f8:1c1c:b490::2]
 helo=mx.kernkonzept.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christian.poetzsch@kernkonzept.com>)
 id 1rnc5S-0000Bh-CP
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 06:25:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kernkonzept.com; s=mx1; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:References:In-Reply-To:
 Reply-To:Content-ID:Content-Description;
 bh=uddgZXDiTzQQfpiNSJyLx5dFmvoi3NpsRnqm37BqGtk=; b=DtaDmNE8XeL/FuE43g8/HyOglQ
 ZD2B/44nck15qzEX/gACG8/ZOApjHs5LfcMDoKDViGV9+ZoARopmscgIUNmgRASXiEMRuyu5FoG2I
 dgs6rDmOZYHIWkW4aCalA5j2pDYDuxHgVyuSjLB67IFTiePu2Q/DifyRi5WbeZAGTqNp6YdnxV/9J
 rO3Qs8Y++JqciL6k8WYXuSoJFxF68w9enuwpWjT9fViGh9saEZUZA9WguW8DMODmUW+9Y/vqMljhd
 SP78aKjzebAfHDwbE+tQQgUP1s4COKCWsLrR7ZXAQoPhp5rqZIDor1r5K0x0k3VTD1bMPe2m/sXqL
 u5LpXEqA==;
Received: from ip92349c68.dynamic.kabel-deutschland.de ([146.52.156.104]
 helo=iris.dd1.int.kernkonzept.com) by mx.kernkonzept.com with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim 4.96)
 id 1rnc5J-007ZAZ-0I; Fri, 22 Mar 2024 11:25:13 +0100
From: =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Christian=20P=C3=B6tzsch?= <christian.poetzsch@kernkonzept.com>
Subject: [PATCH] Add support for abs info in vhost-user-input
Date: Fri, 22 Mar 2024 11:24:21 +0100
Message-Id: <20240322102421.2158139-1-christian.poetzsch@kernkonzept.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:1c1c:b490::2;
 envelope-from=christian.poetzsch@kernkonzept.com; helo=mx.kernkonzept.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 22 Mar 2024 09:04:47 -0400
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

Absolute input device did not work, cause VIRTIO_INPUT_CFG_ABS_INFO is
missing. Fetch this info when available and provide it to any virtio
client.

This is basically the same code as in hw/input/virtio-input-host.c, just
modified to work here.

Signed-off-by: Christian Pötzsch <christian.poetzsch@kernkonzept.com>
---
 contrib/vhost-user-input/main.c | 46 +++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/contrib/vhost-user-input/main.c b/contrib/vhost-user-input/main.c
index 081230da54..9506e34d04 100644
--- a/contrib/vhost-user-input/main.c
+++ b/contrib/vhost-user-input/main.c
@@ -272,6 +272,32 @@ vi_bits_config(VuInput *vi, int type, int count)
     g_array_append_val(vi->config, bits);
 }
 
+static void
+vi_input_abs_config(VuInput *vi, int axis)
+{
+    virtio_input_config config;
+    struct input_absinfo absinfo;
+    int rc;
+
+    rc = ioctl(vi->evdevfd, EVIOCGABS(axis), &absinfo);
+    if (rc < 0) {
+        return;
+    }
+
+    memset(&config, 0, sizeof(config));
+    config.select = VIRTIO_INPUT_CFG_ABS_INFO;
+    config.subsel = axis;
+    config.size   = sizeof(struct input_absinfo);
+
+    config.u.abs.min  = cpu_to_le32(absinfo.minimum);
+    config.u.abs.max  = cpu_to_le32(absinfo.maximum);
+    config.u.abs.fuzz = cpu_to_le32(absinfo.fuzz);
+    config.u.abs.flat = cpu_to_le32(absinfo.flat);
+    config.u.abs.res  = cpu_to_le32(absinfo.resolution);
+
+    g_array_append_val(vi->config, config);
+}
+
 static char *opt_evdev;
 static int opt_fdnum = -1;
 static char *opt_socket_path;
@@ -297,11 +323,12 @@ main(int argc, char *argv[])
 {
     GMainLoop *loop = NULL;
     VuInput vi = { 0, };
-    int rc, ver, fd;
-    virtio_input_config id;
+    int rc, ver, fd, i, axis;
+    virtio_input_config id, *abs;
     struct input_id ids;
     GError *error = NULL;
     GOptionContext *context;
+    uint8_t byte;
 
     context = g_option_context_new(NULL);
     g_option_context_add_main_entries(context, entries, NULL);
@@ -375,6 +402,21 @@ main(int argc, char *argv[])
     vi_bits_config(&vi, EV_ABS, ABS_CNT);
     vi_bits_config(&vi, EV_MSC, MSC_CNT);
     vi_bits_config(&vi, EV_SW,  SW_CNT);
+
+    abs = vi_find_config(&vi, VIRTIO_INPUT_CFG_EV_BITS, EV_ABS);
+    if (abs) {
+        for (i = 0; i < abs->size; i++) {
+            byte = abs->u.bitmap[i];
+            axis = 8 * i;
+            while (byte) {
+                if (byte & 1) {
+                    vi_input_abs_config(&vi, axis);
+                }
+                axis++;
+                byte >>= 1;
+            }
+        }
+    }
     g_debug("config length: %u", vi.config->len);
 
     if (opt_socket_path) {
-- 
2.39.2


