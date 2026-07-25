Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97C7DC531F9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 09:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnZ0s-00012V-IQ; Sat, 25 Jul 2026 05:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0f-0000pM-2Q
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wnZ0d-0004Wt-14
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 05:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784972969;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FeeTjvkJM1Dn0dYWSzp90bDCUYiw8gK9AfELQQw1ddI=;
 b=EveOzLbMkIWOdUJjv8yLdp0mFjQFcH2mULekWJFaH61BfDETkQYZn4zsjiS6h4qdA+m0bK
 8k0qG6Irehdh8aSGdHH+NKyFFTE/M+ZrLJ1YK+qCQXkesNlIKHI0z5wda7mwPDQuvtTKcN
 CXxCrEBa++MvB5WwcalEew0c/20wyR4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-ZXGvEzuzOxOY2iHx5gqxvg-1; Sat,
 25 Jul 2026 05:49:25 -0400
X-MC-Unique: ZXGvEzuzOxOY2iHx5gqxvg-1
X-Mimecast-MFC-AGG-ID: ZXGvEzuzOxOY2iHx5gqxvg_1784972964
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 996C91800BE7; Sat, 25 Jul 2026 09:49:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7BA0180049F; Sat, 25 Jul 2026 09:49:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 25 Jul 2026 13:48:38 +0400
Subject: [PATCH v2 7/8] hw/9pfs: annotate V9fsTransport callbacks as
 coroutine_fn
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260725-co-v2-7-d3552ddb3931@redhat.com>
References: <20260725-co-v2-0-d3552ddb3931@redhat.com>
In-Reply-To: <20260725-co-v2-0-d3552ddb3931@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12210;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=PrexPNQ2Ihat15GzNcjy38+9DFqHdHllyp7j3xM3SIY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZIZzZri2wovVvyg7luKomC/Qdjut5fZZ5+87C
 79GJVT7CSGJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamSGcwAKCRDa6OEJdZac
 5XiOD/9aCgiO9aaqzCpvDR48Jb/zWImmfzQx94/n+ljKr4R+DQf+O3nZZ/6gdv4/RxaSLenH3Ga
 M2B/LuEEdmc7RVFNmlUl3moLCUAywULmWtpYD7XBoeVGzpvL4eSH/AKvilzeIwExOaARGMxhXT2
 Z+B9A0AcJYKYyFA4yjOoW5ySF8qstvsJA7IrlGtPkQO891p3E0+90nq6JM8s59qMEGvCn+FgMCc
 tUce96pSStLHQbHiz/U3XiA4/dQd1SX8JslkP7OsFrGBIa3mXBZfW3wZvRlkB7h7XryTb3cuXkw
 FsM7VavuzFjfsE10aLCSb1wezR5T1LKFfl3skjm/T5veROPHdYtTpOV4I8S7UptVMW+SEhiWihU
 M+CQbJDWMjOhSwAsn9hPyuFM5GVYOBbcjZBEXnucc/O1jlZOjEYax3ZEXjCBr6xzVKPkBd9wj86
 rF3+fFODFaExWYdEJvk/3CdzWyJECQvJBE9SeMJYQZMR4R2osTi0EKthegNzigSdUspHfwEEEzg
 4abdXwsQvV07gvH3ih5ww8YMPyxSKV+mUBOAcPpYjtD92DJOx4jZPZfWHi/GitMq5ZbTJYcZSO5
 Kpa77VBFATVHGF8WHBKnXQuNxmwxqR9kc0u6Mr+K8aoAW/bPvBNV5LIKOhBqelq2x2fu1pdALdG
 vAJffkll9ZgV52Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

All V9fsTransport callbacks are invoked exclusively from coroutine
context (the v9fs_* PDU handlers). Annotate the function pointer
types in V9fsTransport and all implementations (virtio and xen
backends), as well as intermediate callers in 9p.c (pdu_marshal,
pdu_unmarshal, v9fs_init_qiov_from_pdu, etc.).

Acked-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 hw/9pfs/9p.h               | 26 +++++++++++++++-----------
 hw/9pfs/9p.c               | 31 +++++++++++++++++++------------
 hw/9pfs/virtio-9p-device.c | 24 +++++++++++++-----------
 hw/9pfs/xen-9p-backend.c   | 34 +++++++++++++++++-----------------
 4 files changed, 64 insertions(+), 51 deletions(-)

diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
index 1a309664f6e3..0e52ffbdf38b 100644
--- a/hw/9pfs/9p.h
+++ b/hw/9pfs/9p.h
@@ -472,17 +472,21 @@ void pdu_submit(V9fsPDU *pdu, P9MsgHeader *hdr);
 void v9fs_reset(V9fsState *s);
 
 struct V9fsTransport {
-    ssize_t     (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset, const char *fmt,
-                                va_list ap);
-    ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const char *fmt,
-                                  va_list ap);
-    void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
-                                        unsigned int *pniov, size_t size);
-    void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
-                                         unsigned int *pniov, size_t size);
-    void        (*push_and_notify)(V9fsPDU *pdu);
-    size_t      (*msize_limit)(V9fsState *s);
-    size_t      (*response_buffer_size)(V9fsPDU *pdu);
+    ssize_t     coroutine_fn (*pdu_vmarshal)(V9fsPDU *pdu, size_t offset,
+                                             const char *fmt, va_list ap);
+    ssize_t     coroutine_fn (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset,
+                                               const char *fmt, va_list ap);
+    void        coroutine_fn (*init_in_iov_from_pdu)(V9fsPDU *pdu,
+                                                     struct iovec **piov,
+                                                     unsigned int *pniov,
+                                                     size_t size);
+    void        coroutine_fn (*init_out_iov_from_pdu)(V9fsPDU *pdu,
+                                                      struct iovec **piov,
+                                                      unsigned int *pniov,
+                                                      size_t size);
+    void        coroutine_fn (*push_and_notify)(V9fsPDU *pdu);
+    size_t      coroutine_fn (*msize_limit)(V9fsState *s);
+    size_t      coroutine_fn (*response_buffer_size)(V9fsPDU *pdu);
 };
 
 #endif
diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 3119f011173d..00cfbae6dd5b 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -55,7 +55,8 @@ enum {
 
 P9ARRAY_DEFINE_TYPE(V9fsPath, v9fs_path_free);
 
-static ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
+static ssize_t coroutine_fn
+pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
 {
     ssize_t ret;
     va_list ap;
@@ -67,7 +68,8 @@ static ssize_t pdu_marshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
     return ret;
 }
 
-static ssize_t pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
+static ssize_t coroutine_fn
+pdu_unmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, ...)
 {
     ssize_t ret;
     va_list ap;
@@ -1841,7 +1843,8 @@ out_nofid:
     pdu_complete(pdu, err);
 }
 
-static int v9fs_walk_marshal(V9fsPDU *pdu, uint16_t nwnames, V9fsQID *qids)
+static int coroutine_fn
+v9fs_walk_marshal(V9fsPDU *pdu, uint16_t nwnames, V9fsQID *qids)
 {
     int i;
     ssize_t err;
@@ -2363,9 +2366,10 @@ out_nofid:
  * The resulting QEMUIOVector has heap-allocated iovecs and must be cleaned up
  * with qemu_iovec_destroy().
  */
-static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
-                                    size_t skip, size_t size,
-                                    bool is_write)
+static void coroutine_fn
+v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
+                        size_t skip, size_t size,
+                        bool is_write)
 {
     QEMUIOVector elem;
     struct iovec *iov;
@@ -2382,8 +2386,9 @@ static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
     qemu_iovec_concat(qiov, &elem, skip, size);
 }
 
-static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
-                           uint64_t off, uint32_t max_count)
+static int coroutine_fn
+v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
+                uint64_t off, uint32_t max_count)
 {
     ssize_t err;
     size_t offset = 7;
@@ -2793,9 +2798,10 @@ out_nofid:
     pdu_complete(pdu, retval);
 }
 
-static int v9fs_xattr_write(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
-                            uint64_t off, uint32_t count,
-                            struct iovec *sg, int cnt)
+static int coroutine_fn
+v9fs_xattr_write(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
+                 uint64_t off, uint32_t count,
+                 struct iovec *sg, int cnt)
 {
     int i, to_copy;
     ssize_t err = 0;
@@ -3729,7 +3735,8 @@ out_nofid:
     pdu_complete(pdu, err);
 }
 
-static int v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
+static int coroutine_fn
+v9fs_fill_statfs(V9fsState *s, V9fsPDU *pdu, struct statfs *stbuf)
 {
     uint32_t f_type;
     uint32_t f_bsize;
diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
index 50dc93091d33..b2dd859fb560 100644
--- a/hw/9pfs/virtio-9p-device.c
+++ b/hw/9pfs/virtio-9p-device.c
@@ -28,7 +28,7 @@
 #include "qemu/module.h"
 #include "system/qtest.h"
 
-static void virtio_9p_push_and_notify(V9fsPDU *pdu)
+static void coroutine_fn virtio_9p_push_and_notify(V9fsPDU *pdu)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
@@ -117,8 +117,8 @@ static void virtio_9p_reset(VirtIODevice *vdev)
     v9fs_reset(&v->state);
 }
 
-static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
-                                   const char *fmt, va_list ap)
+static ssize_t coroutine_fn
+virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, va_list ap)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
@@ -135,8 +135,8 @@ static ssize_t virtio_pdu_vmarshal(V9fsPDU *pdu, size_t offset,
     return ret;
 }
 
-static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
-                                     const char *fmt, va_list ap)
+static ssize_t coroutine_fn
+virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset, const char *fmt, va_list ap)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
@@ -152,8 +152,9 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu, size_t offset,
     return ret;
 }
 
-static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
-                                        unsigned int *pniov, size_t size)
+static void coroutine_fn
+virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
+                            unsigned int *pniov, size_t size)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
@@ -172,8 +173,9 @@ static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
     *pniov = elem->in_num;
 }
 
-static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
-                                         unsigned int *pniov, size_t size)
+static void coroutine_fn
+virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
+                             unsigned int *pniov, size_t size)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
@@ -192,13 +194,13 @@ static void virtio_init_out_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
     *pniov = elem->out_num;
 }
 
-static size_t virtio_9p_msize_limit(V9fsState *s)
+static size_t coroutine_fn virtio_9p_msize_limit(V9fsState *s)
 {
     const size_t guestPageSize = 4096;
     return (VIRTQUEUE_MAX_SIZE - 2) * guestPageSize;
 }
 
-static size_t virtio_9p_response_buffer_size(V9fsPDU *pdu)
+static size_t coroutine_fn virtio_9p_response_buffer_size(V9fsPDU *pdu)
 {
     V9fsState *s = pdu->s;
     V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 24c90d97ec94..7f674f846426 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -131,10 +131,10 @@ static void xen_9pfs_out_sg(Xen9pfsRing *ring,
     }
 }
 
-static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
-                                     size_t offset,
-                                     const char *fmt,
-                                     va_list ap)
+static ssize_t coroutine_fn xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
+                                                  size_t offset,
+                                                  const char *fmt,
+                                                  va_list ap)
 {
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     struct iovec in_sg[2];
@@ -155,10 +155,10 @@ static ssize_t xen_9pfs_pdu_vmarshal(V9fsPDU *pdu,
     return ret;
 }
 
-static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
-                                       size_t offset,
-                                       const char *fmt,
-                                       va_list ap)
+static ssize_t coroutine_fn xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
+                                                    size_t offset,
+                                                    const char *fmt,
+                                                    va_list ap)
 {
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     struct iovec out_sg[2];
@@ -178,10 +178,10 @@ static ssize_t xen_9pfs_pdu_vunmarshal(V9fsPDU *pdu,
     return ret;
 }
 
-static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
-                                           struct iovec **piov,
-                                           unsigned int *pniov,
-                                           size_t size)
+static void coroutine_fn xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
+                                                        struct iovec **piov,
+                                                        unsigned int *pniov,
+                                                        size_t size)
 {
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
@@ -195,10 +195,10 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
     *pniov = num;
 }
 
-static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
-                                          struct iovec **piov,
-                                          unsigned int *pniov,
-                                          size_t size)
+static void coroutine_fn xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
+                                                       struct iovec **piov,
+                                                       unsigned int *pniov,
+                                                       size_t size)
 {
     Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
     Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
@@ -227,7 +227,7 @@ again:
     *pniov = num;
 }
 
-static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
+static void coroutine_fn xen_9pfs_push_and_notify(V9fsPDU *pdu)
 {
     RING_IDX prod;
     Xen9pfsDev *priv = container_of(pdu->s, Xen9pfsDev, state);

-- 
2.55.0


