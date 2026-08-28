Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE06C61DB9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:05:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvKE-0005PB-TP; Fri, 28 Aug 2026 08:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKD-0005OK-F7
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKB-0001iZ-Ul
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rr+vVFND/Cvbzh7dc8WpGZvEOcDRXY0Xin80A/b/SA0=;
 b=elX33+n7aF2yjFSotZBC1ZGR7JlsOMvYpwVo4zF85T0eBH81M0SrnhHMk5yC9+ntJ+RkWD
 mN9xyKNeHwYoqw7rIcxNYzFHhA26W10WJj0thSTTOJ0rrbzAtrqyceyJX7KXXhlB1212ih
 3Dr9a2B8g28SgwpfvmtzF/n0fNSsjGc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-w3dtQ-j0OcOpxzLpPIGkdA-1; Fri,
 28 Aug 2026 08:04:45 -0400
X-MC-Unique: w3dtQ-j0OcOpxzLpPIGkdA-1
X-Mimecast-MFC-AGG-ID: w3dtQ-j0OcOpxzLpPIGkdA_1787918684
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58E4D19540D2; Fri, 28 Aug 2026 12:04:44 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 532BB26C; Fri, 28 Aug 2026 12:04:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:01 +0400
Subject: [PATCH v5 04/50] hmp: fix snapshot_blkdev argument type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-4-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=V/ypuJVU2ZRrXgnpXuFivZH47izZr2kXRQXZ5sUhcL8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk4N6AoEAWwFCBMXXd/PBbFq9mPn4rSzqYZN
 zUSkXIh152JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5fJ7EACW9WfHtmvc7r5VKnhHmSfiT2fTa9kdqrJlDlMtVe1Try7huz7F6m7vwbjF3WZKwNbNBZ+
 2SkERDpmmFHj531m0xXFIShTSYG6llE6ltBATND1s5Ikg4Q9byVlnKhE7dInw3oP/WJn/oMOr3V
 q9hIpboHDmNBVEMynvfBox0D48IzJmLz8y2Dg4krV/hqk3qNybmAxoD4VgbvQ0ATgoU92noCB7w
 xPi2jgvsaQPXMiYntuhBGQgwbqglDJlsi7FpF6XQhBcWCCn4Jw3vQJFITrxCEHwNuJff3KU5fy7
 8mbgb6O8NFiBr1Ye20ZYeypHD3cZo3yd9fKkPgbuGgj0iSCtosV9HOL+o9OEK6Ia6FY+GmQLlLf
 Dt+1HL2b87NlsLb7Z1ZYaq7Nrnb3nRBqIhnHL4zpFehUoMBf1LabmoiJWTOWGfKlWXINk+/GIkB
 QMteQBXeTfEMPxath5cjwdGCY4vPqdmNaVOgdB+L1VZxbxm3r5k8GvdaR4+PS10EA6P5I4ggY8U
 R9NkCaZ3cNJjSPBPU3iL9gt9n1hYHbY08heZ/+rpAHPc8Hjeny4+qE+rm8+tuiarmCsriaiJnfr
 hyzbuQpl45PcG4u+raXlZjnjAHA0XFRwAO/F6pHYjj/6mbXTGFyUqWxh9fOgEcYXZwE8TTBGafF
 SIf0Rfd+o6AabMA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The `snapshot-file` argument for `snapshot_blkdev` is mandatory. Correct
the `args_type` definition to reflect this.

Fixes: 6106e2492fe ("qapi: Convert blockdev_snapshot_sync")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
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


