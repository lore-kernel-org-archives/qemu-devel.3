Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23F15C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 16:48:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaB1-0002ta-IN; Thu, 01 Feb 2024 11:44:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAr-0002r6-OX
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:25 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAm-0002T1-AB
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=l9x9HGNJH5fBiIeKzePXsIuGh5SQlI6/4CQcfviByuY=; b=NvcRHT+ld+VhyS11El94WCGBx5
 nbwVR47WJ+pc2NZLPlvSXq/l4ksOMpjabHce4ztOAlq30lsjPiKRd/gIRS7GExLQ6VZF5/bCufo5r
 tmXk+G2cg5h8taCaPuKAiQb9JED68/8zEDmHD6y4cHo6wYeO2SSj0v4vw8l9n1U6MtGPlJPscKaDR
 6iSCINgfiACRVpP+8qDbRRMwn1M5nEvx3v2FL8Tx8V6+bDIXjQY07lz/QfpU90R2CiqmmP/vwIEVA
 9SyJf+DuslB5xkRgVcecr+5McJZKF6tkm2afDjWZFZcVKJV4UiMbLiFCBhaKvuXp6ipaXpl/OPpOz
 Q+n3A01g==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAg-00000009cLx-0lVS for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAf-00000003ILq-093v for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:13 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/47] net: add qemu_{configure, create}_nic_device(),
 qemu_find_nic_info()
Date: Thu,  1 Feb 2024 16:43:26 +0000
Message-ID: <20240201164412.785520-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201164412.785520-1-dwmw2@infradead.org>
References: <20240201164412.785520-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: David Woodhouse <dwmw@amazon.co.uk>

Most code which directly accesses nd_table[] and nb_nics uses them for
one of two things. Either "I have created a NIC device and I'd like a
configuration for it", or "I will create a NIC device *if* there is a
configuration for it".  With some variants on the theme around whether
they actually *check* if the model specified in the configuration is
the right one.

Provide functions which perform both of those, allowing platforms to
be a little more consistent and as a step towards making nd_table[]
and nb_nics private to the net code.

One might argue that platforms ought to be consistent about whether
they create the unconfigured devices or not, but making significant
user-visible changes is explicitly *not* the intent right now.

The new functions leave the 'model' field of the NICInfo as NULL after
using it for the default NIC model, unlike the qemu_check_nic_model()
function which does set nd->model to match default_model explicitly.
This is acceptable because there is no code which consumes nd->model
except this NIC-matching code in net/net.c, and no reasonable excuse
for any code wanting to use nd->model in future.

Also export the qemu_find_nic_info() helper, as some platforms have
special cases they need to handle.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Paul Durrant <paul@xen.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 include/net/net.h | 40 +++++++++++++++++++++++++++++++++++++
 net/net.c         | 51 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index ffbd2c8d56..dff1872b4d 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -207,7 +207,47 @@ int qemu_show_nic_models(const char *arg, const char *const *models);
 void qemu_check_nic_model(NICInfo *nd, const char *model);
 int qemu_find_nic_model(NICInfo *nd, const char * const *models,
                         const char *default_model);
+/**
+ * qemu_find_nic_info: Obtain NIC configuration information
+ * @typename: Name of device object type
+ * @match_default: Match NIC configurations with no model specified
+ * @alias: Additional model string to match (for user convenience and
+ *         backward compatibility).
+ *
+ * Search for a NIC configuration matching the NIC model constraints.
+ */
+NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
+                            const char *alias);
+/**
+ * qemu_configure_nic_device: Apply NIC configuration to a given device
+ * @dev: Network device to be configured
+ * @match_default: Match NIC configurations with no model specified
+ * @alias: Additional model string to match
+ *
+ * Search for a NIC configuration for the provided device, using the
+ * additionally specified matching constraints. If found, apply the
+ * configuration using qdev_set_nic_properties() and return %true.
+ *
+ * This is used by platform code which creates the device anyway,
+ * regardless of whether there is a configuration for it. This tends
+ * to be platforms which ignore `--nodefaults` and create net devices
+ * anyway, for example because the Ethernet device on that board is
+ * always physically present.
+ */
+bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
+                               const char *alias);
 
+/**
+ * qemu_create_nic_device: Create a NIC device if a configuration exists for it
+ * @typename: Object typename of network device
+ * @match_default: Match NIC configurations with no model specified
+ * @alias: Additional model string to match
+ *
+ * Search for a NIC configuration for the provided device type. If found,
+ * create an object of the corresponding type and return it.
+ */
+DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
+                                    const char *alias);
 void print_net_client(Monitor *mon, NetClientState *nc);
 void net_socket_rs_init(SocketReadState *rs,
                         SocketReadStateFinalize *finalize,
diff --git a/net/net.c b/net/net.c
index 0520bc1681..aeb7f573fc 100644
--- a/net/net.c
+++ b/net/net.c
@@ -1087,6 +1087,57 @@ static int net_init_nic(const Netdev *netdev, const char *name,
     return idx;
 }
 
+NICInfo *qemu_find_nic_info(const char *typename, bool match_default,
+                            const char *alias)
+{
+    NICInfo *nd;
+    int i;
+
+    for (i = 0; i < nb_nics; i++) {
+        nd = &nd_table[i];
+
+        if (!nd->used || nd->instantiated) {
+            continue;
+        }
+
+        if ((match_default && !nd->model) || !g_strcmp0(nd->model, typename)
+            || (alias && !g_strcmp0(nd->model, alias))) {
+            return nd;
+        }
+    }
+    return NULL;
+}
+
+
+/* "I have created a device. Please configure it if you can" */
+bool qemu_configure_nic_device(DeviceState *dev, bool match_default,
+                               const char *alias)
+{
+    NICInfo *nd = qemu_find_nic_info(object_get_typename(OBJECT(dev)),
+                                     match_default, alias);
+
+    if (nd) {
+        qdev_set_nic_properties(dev, nd);
+        return true;
+    }
+    return false;
+}
+
+/* "Please create a device, if you have a configuration for it" */
+DeviceState *qemu_create_nic_device(const char *typename, bool match_default,
+                                    const char *alias)
+{
+    NICInfo *nd = qemu_find_nic_info(typename, match_default, alias);
+    DeviceState *dev;
+
+    if (!nd) {
+        return NULL;
+    }
+
+    dev = qdev_new(typename);
+    qdev_set_nic_properties(dev, nd);
+    return dev;
+}
 
 static int (* const net_client_init_fun[NET_CLIENT_DRIVER__MAX])(
     const Netdev *netdev,
-- 
2.43.0


