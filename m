Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3089CC5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgIV-0008NL-Cz; Sun, 16 Aug 2026 15:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIO-0008Kj-F9
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgII-0007GV-Qh
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xwqJgBYcOrqzsn6Uz+zENbJ1dQ1zJzkv1tuTOfCGPRI=;
 b=MEhCX9VVA+c5wENfOXEy3haC52ZBDqg3PtcORBShjcui86B5DWWpUMbzQxx+NQ2W09OusI
 868spDL3PCNZHCS53hfRZTDQTBAJx0u3JfTYtKSzfPtx/B5K4SEmWcHn/qDQQKol8FUzF+
 C4vAGzu8TmqU+x709e6R7kWnT67ylGs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172-h3M1YAErNkKbH5dqVFvgRw-1; Sun,
 16 Aug 2026 15:13:10 -0400
X-MC-Unique: h3M1YAErNkKbH5dqVFvgRw-1
X-Mimecast-MFC-AGG-ID: h3M1YAErNkKbH5dqVFvgRw_1786907589
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD6731800366; Sun, 16 Aug 2026 19:13:08 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C3FC423; Sun, 16 Aug 2026 19:13:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:30 +0400
Subject: [PATCH v3 03/49] hmp: fix snapshot_blkdev argument type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-3-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2272;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2agSZFonX9AReo2U/44kc7VY3Ymspa6PTHpu0NPMtnE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguw3d4F2iYCXZDV9q3UE4CMospkPv2f2CATQ
 aIVl5HzSwOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsAAKCRDa6OEJdZac
 5Rw3EACPuy3PH1G7tRtCGh37AX3Z3xT62uqT08cjvt+6ZK7ln/fbQ3mWr7HkoxbfskEJCAdQ+NF
 6t8uyLjCVNgyEz7rys/7DeosJbgtMkIlfFf23lQihn+F4UD9t/ap2GumCxx+ySa3B3XFrN0ZfiK
 ZShQSXBp+LbTs37useOAzgfddzKKRbSFsMNuiLWVWZEy1HG4v761NsOIfy0VEF4MD0b9WoA6bzf
 ogQ51A3Ylq0+HSP0gnVe/DxqPpH/rBXkQL4dYPZZzSnM2qQsDvGNQZQcXap6PxkVn2DH1kexXEQ
 PP08/KY2k4Y4aQ87ZLOlr5UVG1EPDbsv352fECXq7rwa18deH/Hvbwn0Gx6sxIdf78qUfsbkPoC
 DvZEFAvfbh4JxWQHdZEHodyDQX2hpsmVH1zCk7SdEWPql61An/K/xNlDvnTMW/oM1JOhmV4BvcO
 QBbWWWpK+JAmTWBoUOmLBxDSNQBhLZSbfDGqBJr86q7U8OzCS7j79aBD3kMP4A3GFbSxBBYCGvj
 pWRiNCwLvPAl90yQatfE4H2JmzFja9B5cFOh/qomAL9u8oy+dMipYqBNNyBN9iEWPoHJt+lx8qp
 02Dre4CjXhmxtTqvJfppNladzkwuR0lfEm4RrpgJXVxZ4uF9TvnWZANC4TSwvc6skDEOoXtknM/
 usL2SVagSFnFGag==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The `snapshot-file` argument for `snapshot_blkdev` is mandatory. Correct
the `args_type` definition to reflect this.

Fixes: 6106e2492fe ("qapi: Convert blockdev_snapshot_sync")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 block/monitor/block-hmp-cmds.c | 12 +-----------
 hmp-commands.hx                |  2 +-
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 69ade0534f1c..39b82e8ef501 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -344,25 +344,15 @@ void hmp_block_job_complete(Monitor *mon, const QDict *qdict)
 void hmp_snapshot_blkdev(Monitor *mon, const QDict *qdict)
 {
     const char *device = qdict_get_str(qdict, "device");
-    const char *filename = qdict_get_try_str(qdict, "snapshot-file");
+    const char *filename = qdict_get_str(qdict, "snapshot-file");
     const char *format = qdict_get_try_str(qdict, "format");
     bool reuse = qdict_get_try_bool(qdict, "reuse", false);
     enum NewImageMode mode;
     Error *err = NULL;
 
-    if (!filename) {
-        /*
-         * In the future, if 'snapshot-file' is not specified, the snapshot
-         * will be taken internally. Today it's actually required.
-         */
-        error_setg(&err, QERR_MISSING_PARAMETER, "snapshot-file");
-        goto end;
-    }
-
     mode = reuse ? NEW_IMAGE_MODE_EXISTING : NEW_IMAGE_MODE_ABSOLUTE_PATHS;
     qmp_blockdev_snapshot_sync(device, NULL, filename, NULL, format,
                                true, mode, &err);
-end:
     hmp_handle_error(mon, err);
 }
 
diff --git a/hmp-commands.hx b/hmp-commands.hx
index ea4a1db78f18..f0b8d8914c98 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1173,7 +1173,7 @@ ERST
 
     {
         .name       = "snapshot_blkdev",
-        .args_type  = "reuse:-n,device:B,snapshot-file:s?,format:s?",
+        .args_type  = "reuse:-n,device:B,snapshot-file:s,format:s?",
         .params     = "[-n] device [new-image-file] [format]",
         .help       = "initiates a live snapshot\n\t\t\t"
                       "of device. If a new image file is specified, the\n\t\t\t"

-- 
2.55.0.543.g5ebe2ebe4ea8


