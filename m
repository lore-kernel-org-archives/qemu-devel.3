Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C523C5DF74
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 05:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwC7k-00058N-8f; Tue, 18 Aug 2026 01:12:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7i-00057u-DP
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:30 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <connorkite@gmail.com>)
 id 1wwC7e-0003j4-CT
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 01:12:29 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-84fa3b14ee1so3080129b3a.0
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 22:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787029945; x=1787634745; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GF0FtzLMWaPpijge2pYmINjU8s3/LYKiLpVZpt8RABo=;
 b=hvRFUd2uorLAIEJm9U+DnSe+8jChBs8OdAszu6zkd3Mo4dW4w8RoGOnSBnQn0rqMAY
 o5bQFkvKNwJzeZyIQGTJCWD/JzSg7Rmqpz5xUqIwVMoOuDyHRR3oTv0U2LKueQRyKZjc
 zvQQt8lg8BGXYeoA51GgobtGJVrrTBOugIGNYxPImE1x0ctH9SforNI/14vStlwRPFOH
 Nx3JkA9MWdMCwG35tqBQGDo1iz4O3EdBeirfxt5a8uwtFpCzAWmlNjCB2z2qRO4r+10v
 NElLxCcqDhY02gVq2hshcCbw/JlmkP3xLQD5XfPfm8IvjQHZR96fC8Mbk7bQ0pYRgKhm
 0IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787029945; x=1787634745;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GF0FtzLMWaPpijge2pYmINjU8s3/LYKiLpVZpt8RABo=;
 b=hs9dQtHhsGS+3Zudh/SIIm1CHSIq6kvweHOD6B/6fq/Qy3yziTZ/KCXeNhumX93qXp
 uvoM6wtVtJzSRAcTuYsBCdKoLdHbujvOuV26HNOmoEYkEIFDrdpwautxF8Cx1MOzyIiT
 8kpHUn9e2sU/RD9N44+Aapq94ey0qSEQjiBZyBr59wI+Ed+e/aLWde4PjVyCkuQdjSCa
 zeMfjkG/yWnw0U0BsQ80F1s5wnYJCbOo3aqxVIQ9rvhEten3CEyL9T8kmZCQQZ8C/o5m
 a6ck6R4fHRHxS+sIn4iBMb8F6ktJ/sVpT9Ciu71ih+Zl0QqhJEJXxCnVWqDWpgtzCwyk
 Wsdw==
X-Gm-Message-State: AOJu0YwMr3VxcbcEt8kSxAKAxaozXcrXodDuz9iACK8k+xAFCVrXjc5E
 UArcpv36mHfwcoQ9zn772M9drEjS44E4/3A3G+sJ9wrB97Mn1sujhtO6
X-Gm-Gg: AR+sD10KGXv7nEyfJxjNyfO2KkkkgqB1+j53OgmZq6tdhk2153YJgSwZ5WLZxDg4qXW
 97wCrzYgaRK3Z6bYuN2qo1wiGdZYn7KqN/dF6pUSnuV2db3gZZ3JiHgoFDhb0gPtVFXfjXvYE9+
 K0E3xUKt0DFqLnTETVPM4LUD0RNDOTLXO/QQRd0q5sC/B5HtOkDMfPi5F6QbJf7KxQ3O8V1SH9L
 nY/pHqLgpVTcW562QfWylULNRbaPlefXgE9cNDASsD/fLEA9WabEtg2qJP8OO2aJcdxT600W0B9
 6ZG7KCN2UbNN0Fov+jw/RXzvITnGcyk7TP2TkIDZ6snke9Qy2bTb+1QuNa6rYZJXvYjeLbjOG9V
 YVnjy93ig2RnuMPVCtfVktrIHkVb2eHsRuKmZZKfVCogf44F4jE2wvv5uyplG7lvbz34AFlgr4K
 mreTA7ikSEyhZsGE0M6jxc8we0Jcl8KH4wHy0rIDKCN0Y7MIFVHyUd8Z2yoY0tpFi+kg==
X-Received: by 2002:a05:6a00:3763:b0:851:ba04:ca02 with SMTP id
 d2e1a72fcca58-851ba04da9amr4656750b3a.16.1787029944848; 
 Mon, 17 Aug 2026 22:12:24 -0700 (PDT)
Received: from [127.0.1.1] ([2600:1700:e140:14d0:d043:a40d:25c1:432c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-851b6fc0e84sm1031160b3a.43.2026.08.17.22.12.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 22:12:24 -0700 (PDT)
From: Connor Kite <connorkite@gmail.com>
Date: Mon, 17 Aug 2026 22:12:17 -0700
Subject: [PATCH RFC v2 02/13] util/iova-tree: g_tree_foreach wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-vhost-user-isolated-memory-v2-2-948aae960abb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787029936; l=1906;
 i=connorkite@gmail.com; s=20260723; h=from:subject:message-id;
 bh=o7eLAZfdtjRRWSqHEojyG/bzxtWRaxaRR5MzJJtbNk8=;
 b=Z3tFhfEr1Omnp83Zy3bXpXXEiQIMkob68NNERZBNgm5EjVu9Ykqidco7cjuQ4gnEqs7pgUwhM
 ELFXw7D56GGCzrXpmI7r68dyx5q3Ot2OBTpnrqhYAOCg7lgJmRrB5TA
X-Developer-Key: i=connorkite@gmail.com; a=ed25519;
 pk=xg/3N8AntFCYogaIgN5NC/KkT7UlZB6ktPIRliJ3hv4=
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=connorkite@gmail.com; helo=mail-pf1-x435.google.com
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

Add a wrapper to iova-tree to call g_tree_foreach.  Provides a means
to execute some function on each node of the iova-tree.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Connor Kite <connorkite@gmail.com>
---
 include/qemu/iova-tree.h | 21 +++++++++++++++++++++
 util/iova-tree.c         |  5 +++++
 2 files changed, 26 insertions(+)

diff --git a/include/qemu/iova-tree.h b/include/qemu/iova-tree.h
index 14e82a22d5..a1938e36a1 100644
--- a/include/qemu/iova-tree.h
+++ b/include/qemu/iova-tree.h
@@ -161,4 +161,25 @@ int iova_tree_alloc_map(IOVATree *tree, DMAMap *map, hwaddr iova_begin,
  */
 void iova_tree_destroy(IOVATree *tree);
 
+/**
+ * iova_tree_foreach:
+ *
+ * @tree: the iova tree to traverse
+ * @func: the function called at every node. A true return value ends traversal.
+ *        Arguments:
+ *            gpointer key:   key of current node
+ *            gpointer value: value of current node
+ *            gpointer data:  data passed in at g_tree_foreach call
+ *        Return: gboolean
+ * @data: an argument passed to func
+ *
+ * Wrapper to call g_tree_foreach on the underlying g_tree. g_tree_foreach will
+ * traverse through every node of the tree, barring an early return. At each
+ * node, g_tree_foreach calls func with pointers to the node key, node value,
+ * and a pointer to data passed in by the caller.
+ *
+ * Return: None
+ */
+void iova_tree_foreach(IOVATree *tree, GTraverseFunc func, gpointer data);
+
 #endif
diff --git a/util/iova-tree.c b/util/iova-tree.c
index 5b0c95ff15..2239bb6ae1 100644
--- a/util/iova-tree.c
+++ b/util/iova-tree.c
@@ -303,3 +303,8 @@ int gpa_tree_insert(IOVATree *tree, const DMAMap *map)
 
     return IOVA_OK;
 }
+
+void iova_tree_foreach(IOVATree *tree, GTraverseFunc func, gpointer data)
+{
+    g_tree_foreach(tree->tree, func, data);
+}

-- 
2.43.0


