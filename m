Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F29C44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlita-0006hg-Np; Mon, 20 Jul 2026 03:58:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlit1-0006Yy-Vm
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:58:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlisz-0006xO-Rb
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784534281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ALldkh8seNA+CMYH3lEA3G+/dS0/SJeW8CIYrG9pcqg=;
 b=Aawk29inXdAnEsgrSEK/3PJKJZbhhN4FpbJCNZu09nTp4ySSsjGI6AvoNdXlIct3Y8BsFx
 uP91iVsmyJaZbuR/626FDO4iWjrzsCCwl76cDlm3kVy2z6l/PMsuLWb03jzC1xI1DEH2w7
 Zwk5iP2/2IWufebfxpfxGKyvr7kiYlA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-jdj5FvwpPZimA4mMbZqh9A-1; Mon,
 20 Jul 2026 03:56:27 -0400
X-MC-Unique: jdj5FvwpPZimA4mMbZqh9A-1
X-Mimecast-MFC-AGG-ID: jdj5FvwpPZimA4mMbZqh9A_1784534186
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2731F1956095; Mon, 20 Jul 2026 07:56:25 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 96DF31955F73; Mon, 20 Jul 2026 07:56:23 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 20 Jul 2026 11:55:33 +0400
Subject: [PATCH 4/8] block: add missing coroutine annotation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-co-v1-4-fabb4db3c204@redhat.com>
References: <20260720-co-v1-0-fabb4db3c204@redhat.com>
In-Reply-To: <20260720-co-v1-0-fabb4db3c204@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=861;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=WmyEwYMEsZBPe16QwpjcWihXuT8+mm7P1L0OltCg6FI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqXdSJA2EiDfjrLe0AmLG5DHsASaHz6NBI5jV4Q
 MGQdc/B9EmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCal3UiQAKCRDa6OEJdZac
 5cKFD/9P2uRbNUYrYGtaBq2O66ze0WyGYtu7Jf8KB/SPvKvaQ9PDNhMzEUwX+kb+2gUVqMYdFy4
 noa0RtH8Yjg3PrTX4HrT2rAoJe79Iro7gUKYrbrlqm+E0CCIDbNzwcQ2usPXGrXswZerkH7T+5c
 bpKsaRmkKrzTIQw1Sj8RQHchphAgo8Xsz04wt151GrNd76Tkdu4JcySLtxb6WJnrDYTPS+HLOAt
 RwgvB/9AnknYNnCwg2FoyCvf9rqsSZuEbAllihNkd+wcAa6b5JPEj5tfJijtCyq/V1ZS0v7IkTC
 pvvuKKH6+zgARuwnplV5l2tOP5jtxPfHfgZS7W6H6ZjLDxf29aObVcGVKOTau8KLNWRj+F1L6zS
 ccpIwmZSf8x+pesappkS2YxmhaN/mmU9F+YadIxSfArGlsclY8lGRmBUIkhHo/+WxfnUx4P3YAL
 VHv0okqVOEka0w+7liQOelrhh5PQP0+Wzz8CqHqDMJzhDsJThU2VcDplF4pFgpvvR/ME8AL9fe6
 8KeakmrcRBIaY6njZDrIgv/OhPQa/NpKFiYQJMPBlP8FDuOgP0EJl8eiH/WPZ76ebiutGujSb8s
 NnH3ftmtYGjbgb7EYd6nzo2JGxBM0DZnEkMcORwRfbya8vl0Ul+LxZ2Ylj8QiP4Py4pMe1xCIYx
 Y2WkjmpXIm6wH/g==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

The function was extracted without carrying the annotation.

Fixes: 23743ab282af ("block: move commit_run loop to separate function")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/commit.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index c5e3ef03a21..2d52c39594c 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -128,8 +128,9 @@ static void commit_clean(Job *job)
     blk_unref(s->top);
 }
 
-static int commit_iteration(CommitBlockJob *s, int64_t offset,
-                            int64_t *requested_bytes, void *buf)
+static int coroutine_fn
+commit_iteration(CommitBlockJob *s, int64_t offset,
+                 int64_t *requested_bytes, void *buf)
 {
     BlockErrorAction action;
     int64_t bytes = *requested_bytes;

-- 
2.55.0


