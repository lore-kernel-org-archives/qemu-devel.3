Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A43DFED9F0
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:22:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y6L-0002nm-4H; Tue, 17 Mar 2026 13:21:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y5y-0002Qo-CI
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y5m-0005c5-A2
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:20:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773768029;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hVzOsw3MIOOt+Jv9iKjr4crwzYrAKdjgklNI5FGLsLk=;
 b=V0sHPS0Qp0IMpUEmnAkMM2bk68/A1l5vM5JgwKUzsN2q6tq+hvPLmwuRbuU7Lj3TYnukPm
 SR35agb8H3ssXwOoVykrxpYt2W3gWfUftoNoffnH1H7SqZMWXOMUD4puYmemd4eloBV4Vu
 L3rWC0oEUGIdPi1+9XKhppGf69Jj/rQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-504-TahFKnq_P2uFQFlh5I6e-g-1; Tue,
 17 Mar 2026 13:20:25 -0400
X-MC-Unique: TahFKnq_P2uFQFlh5I6e-g-1
X-Mimecast-MFC-AGG-ID: TahFKnq_P2uFQFlh5I6e-g_1773768023
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 48E0D1956094; Tue, 17 Mar 2026 17:20:23 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 639E730001A1; Tue, 17 Mar 2026 17:20:20 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Subject: [PULL 09/16] dump: enhance dump_state_prepare fd initialization
Date: Tue, 17 Mar 2026 21:19:09 +0400
Message-ID: <20260317171916.438575-10-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Nikolai Barybin <nikolai.barybin@virtuozzo.com>

Initializing descriptor with zero is unsafe: during cleanup we risk to
unconditional close of fd == 0 in case dump state wasn't fully
initialized. Thus, let's init fd with -1 value and check its value
before closing it.

Signed-off-by: Nikolai Barybin <nikolai.barybin@virtuozzo.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20250911123656.413160-2-nikolai.barybin@virtuozzo.com>
---
 dump/dump.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index 80ed6c8d219..1f216e74f5f 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -104,7 +104,10 @@ static int dump_cleanup(DumpState *s)
 
     guest_phys_blocks_free(&s->guest_phys_blocks);
     memory_mapping_list_free(&s->list);
-    close(s->fd);
+    if (s->fd != -1) {
+        close(s->fd);
+    }
+    s->fd = -1;
     g_free(s->guest_note);
     g_clear_pointer(&s->string_table_buf, g_array_unref);
     s->guest_note = NULL;
@@ -1709,8 +1712,8 @@ static DumpState dump_state_global = { .status = DUMP_STATUS_NONE };
 
 static void dump_state_prepare(DumpState *s)
 {
-    /* zero the struct, setting status to active */
-    *s = (DumpState) { .status = DUMP_STATUS_ACTIVE };
+    /* zero the struct, setting status to active and fd to -1 */
+    *s = (DumpState) { .fd = -1, .status = DUMP_STATUS_ACTIVE };
 }
 
 bool qemu_system_dump_in_progress(void)
-- 
2.53.0


