Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C52CF9C6F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2024 13:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1st5Gk-0005tU-12; Tue, 24 Sep 2024 09:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1st5Fl-00013a-8h
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1st5Fh-0000WH-Rz
 for qemu-devel@nongnu.org; Tue, 24 Sep 2024 09:06:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727183208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T0MLcA6aNzv2RR1lKUo89sny5RQMOplmDT7BSRDnP8M=;
 b=jMaE/nD7q0ba3cD6eGCFYbf9wkv+fGZfMF0DoK1yBDxFVYIt7AjehfXy0veR8i3V5Mr7SZ
 ls3yOA3jcvr50Zwr4NHJFojaCMSeDoLbgi+n2kzbDRri2AtVeF9bLcDQVmuSzwK9OcQhUP
 4L4podrQLQ8Y/N7YwvGFktDcjC9Nj1E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-I4TH7hFOOxaQSTYEdX2Aag-1; Tue,
 24 Sep 2024 09:06:46 -0400
X-MC-Unique: I4TH7hFOOxaQSTYEdX2Aag-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF5BF1896E3D; Tue, 24 Sep 2024 13:06:36 +0000 (UTC)
Received: from localhost (unknown [10.39.208.3])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D7C3F30001A1; Tue, 24 Sep 2024 13:06:34 +0000 (UTC)
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
Subject: [PATCH v2 07/22] block/stream: fix -Werror=maybe-uninitialized
 false-positives
Date: Tue, 24 Sep 2024 17:05:38 +0400
Message-ID: <20240924130554.749278-8-marcandre.lureau@redhat.com>
In-Reply-To: <20240924130554.749278-1-marcandre.lureau@redhat.com>
References: <20240924130554.749278-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
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

../block/stream.c:193:19: error: ‘unfiltered_bs’ may be used uninitialized [-Werror=maybe-uninitialized]
../block/stream.c:176:5: error: ‘len’ may be used uninitialized [-Werror=maybe-uninitialized]
trace/trace-block.h:906:9: error: ‘ret’ may be used uninitialized [-Werror=maybe-uninitialized]

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/stream.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 7031eef12b..9076203193 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -155,8 +155,8 @@ static void stream_clean(Job *job)
 static int coroutine_fn stream_run(Job *job, Error **errp)
 {
     StreamBlockJob *s = container_of(job, StreamBlockJob, common.job);
-    BlockDriverState *unfiltered_bs;
-    int64_t len;
+    BlockDriverState *unfiltered_bs = NULL;
+    int64_t len = -1;
     int64_t offset = 0;
     int error = 0;
     int64_t n = 0; /* bytes */
@@ -177,7 +177,7 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
 
     for ( ; offset < len; offset += n) {
         bool copy;
-        int ret;
+        int ret = -1;
 
         /* Note that even when no rate limit is applied we need to yield
          * with no pending I/O here so that bdrv_drain_all() returns.
-- 
2.45.2.827.g557ae147e6


