Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F75CF9C6B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5Hc-00027K-MY; Tue, 24 Sep 2024 09:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1st5H1-0007Rz-75
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:08:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1st5Gw-0000ti-Dw
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:08:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727183280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rirjT2vWchNWdq7Xp3Tgw1/mVLkdbrmL/S6S8SjDtyE=;
 b=L44vUK+R5Tpk8R8jdiMf3mrw6GyEbCosOaJlzMbOQeD2RWqjz7Fx6QVQHWxzIh/ePrlM6j
 CqV9NVLXdqbg7hjKl/WethMaVdmNbDqDo+SlhQKW6RpdHmTNqY1OkA1RVHYUPMgw1JrhpA
 pWT82EfuDqZGhKuIEX2sNPg9LzcTRxE=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-YKCXA9daPCiV4IobNeiP-g-1; Tue,
 24 Sep 2024 09:07:57 -0400
X-MC-Unique: YKCXA9daPCiV4IobNeiP-g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4085B18EBFB3; Tue, 24 Sep 2024 13:07:54 +0000 (UTC)
Received: from localhost (unknown [10.39.208.3])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B978195608A; Tue, 24 Sep 2024 13:07:52 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Hyman Huang <yong.huang@smartx.com>, Klaus Jensen <its@irrelevant.dk>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, Jesper Devantier <foss@defmacro.it>,
 Bin Meng <bin.meng@windriver.com>, Greg Kurz <groug@kaod.org>,
 =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Keith Busch <kbusch@kernel.org>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Gerd Hoffmann <kraxel@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefano Garzarella <sgarzare@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 21/22] fsdep/9p: fix -Werror=maybe-uninitialized
 false-positive
Date: Tue, 24 Sep 2024 17:05:52 +0400
Message-ID: <20240924130554.749278-22-marcandre.lureau@redhat.com>
In-Reply-To: <20240924130554.749278-1-marcandre.lureau@redhat.com>
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.09,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../fsdev/9p-iov-marshal.c:93:23: error: ‘val’ may be used uninitialized [-Werror=maybe-uninitialized]
and similar

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 fsdev/9p-iov-marshal.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fsdev/9p-iov-marshal.c b/fsdev/9p-iov-marshal.c
index a1c9beddd2..75fb87a490 100644
--- a/fsdev/9p-iov-marshal.c
+++ b/fsdev/9p-iov-marshal.c
@@ -84,7 +84,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int out_num, size_t offset,
             break;
         }
         case 'w': {
-            uint16_t val, *valp;
+            uint16_t val = 0, *valp;
             valp = va_arg(ap, uint16_t *);
             copied = v9fs_unpack(&val, out_sg, out_num, offset, sizeof(val));
             if (bswap) {
@@ -95,7 +95,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int out_num, size_t offset,
             break;
         }
         case 'd': {
-            uint32_t val, *valp;
+            uint32_t val = 0, *valp;
             valp = va_arg(ap, uint32_t *);
             copied = v9fs_unpack(&val, out_sg, out_num, offset, sizeof(val));
             if (bswap) {
@@ -106,7 +106,7 @@ ssize_t v9fs_iov_vunmarshal(struct iovec *out_sg, int out_num, size_t offset,
             break;
         }
         case 'q': {
-            uint64_t val, *valp;
+            uint64_t val = 0, *valp;
             valp = va_arg(ap, uint64_t *);
             copied = v9fs_unpack(&val, out_sg, out_num, offset, sizeof(val));
             if (bswap) {
-- 
2.45.2.827.g557ae147e6


