Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26C24C531C9
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jul 2026 20:45:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wo5iM-00080m-QR; Sun, 26 Jul 2026 16:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5iK-00080V-L6
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wo5iI-00049t-U4
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 16:44:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785098686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3BDR4lCetSgPYsi2iCxOJ+ghjRU3eO1cdueUfdeq7eM=;
 b=cZhhUT48zslaBlFhPMsCD+CTKiPhEqpXua2IhtZQYywPBczYmYH+Z7Y+r/61ouX8oRN4cv
 /QG073yby1TIEOWquHWXosht121buhd/zs7bEw5No8BvibYvVK+wsGMiQ50rXxS6AR2klW
 sEb9AwUEXt6Mji+BrCQuGTpWKudm3zw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-272-JWdTkM33PvexWva_5tj5CA-1; Sun,
 26 Jul 2026 16:44:42 -0400
X-MC-Unique: JWdTkM33PvexWva_5tj5CA-1
X-Mimecast-MFC-AGG-ID: JWdTkM33PvexWva_5tj5CA_1785098680
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B4C2F1956071; Sun, 26 Jul 2026 20:44:39 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 509E142C; Sun, 26 Jul 2026 20:44:36 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 00:44:02 +0400
Subject: [PATCH v2 03/12] block/blkio: fix compiler false-positive warning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260727-fix2-v2-3-d0c4831ed7ea@redhat.com>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
In-Reply-To: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Jonathan Cameron <jic23@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>, 
 Phil Dennis-Jordan <phil@philjordan.eu>, Wei Liu <wei.liu@kernel.org>, 
 linux-cxl@vger.kernel.org, Brian Cain <brian.cain@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1098;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=FrHzIsDpkWChX+K7JOQIlcwNZG9jTUeVV/tUOTaHIVo=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZnGXxYBcWQtZJhWSeAtprOzrLPhE7ldi+fXY8
 bstbq2PYW2JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamZxlwAKCRDa6OEJdZac
 5VzmD/wJ+Uf764IPoo1uhCLJ7gOmtO25e/GAV+QqhufUlYTMiECisWjhidpfOa7aokUrKKXr1Up
 WzQsXFw+8kJdgrbUVqHrSzKDoUgEpTFdosi6kLaSbbcG6dVd6EBh3p3MUOX54O33sZm0edSGnO2
 fEXAVXRFfjAD//rpc74YP0JscqafPDjhFFyxm4/ASjChpZBuksPo38e/f91fIZVHqd0Vog6qNIs
 kg3LD3HjXOqBqNM6BbmiJezvp0Kx3n3S5zp+i52WCjy3QSxv8Wqp9AsVRqPzoa5bkQ5MSMDR4Et
 kqQAH6qc33bkRK/AuzOBJHAmNrTRhRsUQegYKB8yR69pxEgCL8qbOWud2bdCJq+P1MhVK0Wj3aB
 aFiMPe3u0lBqXa5GMLZIXhw0b3hwPO/5t03104aD/G7H+ZTRSS5H+iOWay8jk/EOPr4gwpNYQj9
 p0Cm7X2792+1rdVlgHs0IhpFRpVPi3zt7zHhek2Td0zxf7CTQB413Sm/Md9brIx/B2qrdEJpW5R
 COQ3F9kj341+pZ5q1DBnyto91kQPFq4wNT8bL8rndWBo6+hdtqJycurWc7v7LlOXpBWgP7/FKsh
 YCBdiubkWaGfLEWbcF/dsp8x7fr+PF6L3l6jwv75Y8L7gRh/HFJSKZ6u9b099kpBVR/hvgSIG/N
 dXNcRGr1QTjhD4w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -2
X-Spam_score: -0.3
X-Spam_bar: /
X-Spam_report: (-0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

Under some optimization, gcc produces a false-positive:
    ../block/blkio.c: In function ‘blkio_co_getlength’:
    ../block/blkio.c:943:8: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]
      943 |     if (ret < 0) {
          |        ^

Replace WITH_QEMU_LOCK_GUARD with the simpler QEMU_LOCK_GUARD.

Suggested-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/blkio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blkio.c b/block/blkio.c
index 52a8be220d1c..4801339f98b2 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -937,9 +937,8 @@ static int64_t coroutine_fn blkio_co_getlength(BlockDriverState *bs)
     uint64_t capacity;
     int ret;
 
-    WITH_QEMU_LOCK_GUARD(&s->blkio_lock) {
-        ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
-    }
+    QEMU_LOCK_GUARD(&s->blkio_lock);
+    ret = blkio_get_uint64(s->blkio, "capacity", &capacity);
     if (ret < 0) {
         return ret;
     }

-- 
2.55.0


