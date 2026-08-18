Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F4EC5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC7m-00059V-KK; Tue, 18 Aug 2026 01:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7k-00058P-Bg
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:32 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7i-0003jt-6A
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:31 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-84f77cc7302so1325487b3a.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029948; x=1787634748; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9dnSpwb0dn+bdk24pKhPvPsrY1aMYcRsQf+7mWHImvs=;
 b=tBGbsK3FZnmzLcUctHrjolg+INrQT+lEIbMS7rp3K18cI0vwxtdQduzvdbISbf2oz7
 ZcfEga+nSnLZ/QHdgseja/feh3o1FsXUCRh9hXtu9af84pHz6cTumsFm8wfoUO/VhX4z
 Y1qAJyVp3ltZSZH1er/Skrx/epn7Ou7wOCaZ0mzXdNfh/hIIhwMvN/egC5fyNBZqeoKl
 FjTSA44o9eZXSoZssn445Lgcxi0zGGxRezeOuXPHMdC2WEK6P7FD3S3LdPlHYw8bOKZU
 hpG4q2P+SGbsWahFE+BMx7jVodQ6XUCvaKbI+/7dArtJEEF4tJURXjbalBVBytIw/NNT
 XInw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029948; x=1787634748;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9dnSpwb0dn+bdk24pKhPvPsrY1aMYcRsQf+7mWHImvs=;
 b=VGThKr+slJArgsfIEGcKd3LqrIpb5FIgqZGFC6BUiU0CU1TWI4uUlynHNjSFPDvEYX
 3h7ZGZAXzWC4S4jyWzXpkctOB9GZmL/lnpjlNa/vyOWpGQ8fZhtTgnGiUouOpWPGpGEa
 S76XXrjUYmE2UtBhP+iW8yYEijtAVizg6oxBNWHvCKvzLP5N6iM7vJeyBN+tOXOzQiL6
 t9E48sgO8nXq3lXc7J5kv4cqSY7XvcGIsN5cuS21+yIJI9rCprg/5cQcZNONu0jpkf5K
 xfx9tohAR4IELp5/GEK/SStFrocTRfK/tsiAgEQMfmWVMA7j+7E6xC5SiVAbhSegwgLf
 1y2w==
X-Gm-Message-State: AOJu0YxGc/U7NMTTVMe59Wh8U8/YcJPozOhF5WCLLtomKHztdAQieN4J
 20hCNiwBXx1q2wJZjduC5NWAZmnABO2aoiGG4DcJmXl0Oh3d2qJ6TP0W
X-Gm-Gg: AR+sD11PFA+yz+heI7tgcSVk6/R14grAvtjwJz2Veq3ytiUWF+OqQn/Sfum6dqz8Y07
 DiEbeXy0O1M2LQ/U6myAOg7v8+q0bhSyHul69BcRHRXsO2IHfC4322vY+URlRWwnbbD4wyjHTM7
 Zcnd+UmzWE1O+UERa0sGQE/go4aTaK9A/imv8/MZwJ0XJj/UGW82BiexTmux7O1d5BQcA8nxDGS
 3nN+dlhaAybqdfHjp8aDckArn3d4kGGK3TpY0tIDvxpbfEAbYGW2QVKFHgZugTyIiWkw8MTHsxq
 O2lGQWL1YGoFp7xEX3zE6+i2unEuu7RUW9rhB3W5HCO0djgE6Kko2oea6xirVUUXr3ddTKiZ6ol
 T/0AUKsumqR+ZvAkkojiETaZRae3Zopamo27c9NyCpfXJifZAc4CYw08mUy09nsJ+aeVwLSdR+7
 J3cmroV3CsWQ2piUyBq2M7YLlaRDXcp596pc2vAY73X/aa5W64HR0AHJHJeW2NuMrtDw==
X-Received: by 2002:a05:6a00:808d:b0:847:e2c7:59b6 with SMTP id
 d2e1a72fcca58-84fde1ce5d1mr31913848b3a.11.1787029947566; 
 Mon, 17 Aug 2026 22:12:27 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:27 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:18 -0700
Subject: [PATCH RFC v2 03/13] hw/virtio: iova_tree_foreach wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-3-948aae960abb@gmail.com>
References: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
In-Reply-To: <20260817-vhost-user-isolated-memory-v2-0-948aae960abb@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org, 
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
 zhenwei pi <zhenwei.pi@linux.dev>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>, 
 Connor Kite <connorkite@gmail.com>, 
 20260817233147.2867623-1-connorkite@gmail.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=1780;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=vwbYBaMbgDk4wePAOZ4o3ZHnYy3c61j7iZi/xAaHWVE=;
 b=wt3JAdEQQY0WOd6NAZCMl2xoPft+pWYzPIfGFmmMVVjmM5AQRpS7XXXxcs7BsebWgzN8hEnWj
 rBA2T+mhFQfAhf0I2K0qofH4RWgVMouKexIY0LXa5EKULkDz7ZcLkhp
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=connorkite@gmail.com; helo=mail-pf1-x42d.google.com
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

Add a wrapper to vhost-iova-tree that calls iova_tree_foreach on the
underlying iova_map.  This provides a means to execute some function on
each node of the tree.

Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 hw/virtio/vhost-iova-tree.c | 15 +++++++++++++++
 hw/virtio/vhost-iova-tree.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/hw/virtio/vhost-iova-tree.c b/hw/virtio/vhost-iova-tree.c
index fa4147b773..0a9b38b6f3 100644
--- a/hw/virtio/vhost-iova-tree.c
+++ b/hw/virtio/vhost-iova-tree.c
@@ -189,3 +189,18 @@ void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map)
     iova_tree_remove(iova_tree->gpa_iova_map, map);
     iova_tree_remove(iova_tree->iova_map, map);
 }
+
+
+/**
+ * Traverse through the iova tree in sorted order
+ *
+ * @tree: The VhostIOVATree
+ * @func: Function called at every node.  A true return value ends traversal
+ * @data: An argument passed to func
+ */
+void vhost_iova_tree_foreach(VhostIOVATree *tree,
+                             GTraverseFunc func,
+                             gpointer data)
+{
+    iova_tree_foreach(tree->iova_map, func, data);
+}
diff --git a/hw/virtio/vhost-iova-tree.h b/hw/virtio/vhost-iova-tree.h
index 08f63b61cd..c84fd652bd 100644
--- a/hw/virtio/vhost-iova-tree.h
+++ b/hw/virtio/vhost-iova-tree.h
@@ -29,5 +29,7 @@ const DMAMap *vhost_iova_tree_find_gpa(const VhostIOVATree *iova_tree,
 int vhost_iova_tree_map_alloc_gpa(VhostIOVATree *iova_tree, DMAMap *map,
                                   hwaddr taddr);
 void vhost_iova_tree_remove_gpa(VhostIOVATree *iova_tree, DMAMap map);
+void vhost_iova_tree_foreach(VhostIOVATree *tree, GTraverseFunc func,
+                               gpointer data);
 
 #endif

-- 
2.43.0


