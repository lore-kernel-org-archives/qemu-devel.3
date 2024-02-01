Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78F33C4828D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 17:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVaDR-0006P4-B8; Thu, 01 Feb 2024 11:47:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaB7-0002xi-44
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:41 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+1220c4869a9b484313cc+7466+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1rVaAv-0002Ud-2B
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 11:44:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
 Cc:Content-Type:Content-ID:Content-Description;
 bh=OcUPxqWmRn2W/vBLc1vAUxfRYXil4peX6g1xYhANngU=; b=YB5FdLaVXMAp71+NowjXjAty7x
 b6NT5HuscTzgh6sC6DXXw8sbcCagEDEeRsn8RybNb4+bOFlPLgXXA5J+hcXaSrQ+uIfwb9c9+PpnY
 /JNnFnd4pLNbEbzxW66YYFdDj5oxwauR1pd/jDHGi+VWHCWNra7696keIaXbJm9clVlXhoPweHHAf
 dR4x1FC9MbDl0vMn8yxODNTF7gfq8TQI87CImZw/XrCz1mcZQ54wu4CpZ9ip4taJ8RBSMMlDQHFuk
 twvdeNIXWQ7VsooW2oEMiS10m/mvr8C6xivP+M/hyUY9BiSMLZpDQZ8mP3YiZ+ueAk2RnhlbbPGsq
 /UVEF6Bw==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
 id 1rVaAh-00000009cMN-1pv8 for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.97.1 #2 (Red
 Hat Linux)) id 1rVaAg-00000003IOg-3GaH for qemu-devel@nongnu.org;
 Thu, 01 Feb 2024 16:44:14 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/47] hw/s390x/s390-virtio-ccw: use qemu_create_nic_device()
Date: Thu,  1 Feb 2024 16:44:06 +0000
Message-ID: <20240201164412.785520-42-dwmw2@infradead.org>
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

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Acked-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c99682b07d..62804cc228 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -229,16 +229,9 @@ static void s390_init_ipl_dev(const char *kernel_filename,
 
 static void s390_create_virtio_net(BusState *bus, const char *name)
 {
-    int i;
-
-    for (i = 0; i < nb_nics; i++) {
-        NICInfo *nd = &nd_table[i];
-        DeviceState *dev;
-
-        qemu_check_nic_model(nd, "virtio");
+    DeviceState *dev;
 
-        dev = qdev_new(name);
-        qdev_set_nic_properties(dev, nd);
+    while ((dev = qemu_create_nic_device(name, true, "virtio"))) {
         qdev_realize_and_unref(dev, bus, &error_fatal);
     }
 }
-- 
2.43.0


