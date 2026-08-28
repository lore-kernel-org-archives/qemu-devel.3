Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA6EC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03P6-0004nO-7p; Fri, 28 Aug 2026 16:42:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03P4-0004ZK-0N
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03P2-0007zm-67
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5vRP+Aq6lVWE96YKHRw80RmYs6AY3X3ryNOwxTY68vI=;
 b=SE/To8ExZElZyncoftOXRmIJoyEZaIK7jpMue6YHXcOZB7hB2NGcaLPzv+Wt1jft20zd5s
 +iWi+OJxlsC9bCNbMdPJrfT1juStYZ1AiV2AjpydszX1SkTPD7DjLA9jTEF/N6tWnKGV+m
 6tq9LYWvyEvymTmksW/8YttSdPU75r4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-KZsWYxp1N4Oowm-kHbR08A-1; Fri,
 28 Aug 2026 16:42:17 -0400
X-MC-Unique: KZsWYxp1N4Oowm-kHbR08A-1
X-Mimecast-MFC-AGG-ID: KZsWYxp1N4Oowm-kHbR08A_1787949736
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 062D81953989; Fri, 28 Aug 2026 20:42:16 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1F38F7D9; Fri, 28 Aug 2026 20:42:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:43 +0400
Subject: [GIT PULL 04/50] hmp: fix snapshot_blkdev argument type
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-4-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, 
 "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=2401;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2Yl1qvF97VSURfIeX++TpwNxuBv2vtAIEWxtiY2E3oQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKT96N3HRDg8fe9LdoQQ0jk8yOldD5pArHgV
 G4Tt6sjt2OJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHykwAKCRDa6OEJdZac
 5UmOEACQZfefX7ADaMZeWXY2vQZooOdHf90gmctqzDJkRO5q/CiUnR/rCUmC/Y1wAWhgbZ6F0PE
 dOn0woLO8+GVj1WegS7ahdEfpLWu7bKR1v2u54LusxqlFwR9dDoxBVX222KOdKBSk5ahMSdpxid
 RdTH3IDpq64dWXzJOKTcoFEatHoAUNP3lPXwDnx4s+4hh/yFSt79MjteANoO2Dpnp/s5uZAA+Ja
 hGpZStl8soTVAnAt1PhOLUCKNkiceexYZuHrD47wtgPT3+T6AWBpCBayr6LLmg8XsvYbNFQ8TBN
 fTSMunOxNidqCvb2sFigD6fhDCM5LBQGh2y4UHQQ3s0zsXvabUfY+0RbpLvAQ9DP+uH2YP5VYYS
 D1AYKAT7u8ieIFkWIwVcpfe0pkdGcMx7pCFwRc8S+jLdJ7+CFlGdMypsb54lS2b0AroSbMyYJ5m
 oHdzL5dHQfB0XmiuyAYm1xYGB+dtVmvAJ2k4Vo/9hFd/SIbzqsQ/MczXg281c1PSSkieRPXunMk
 a4z61vICqZDnSGUAkWnxdLnQyPAVUizqvdaks1Eo77pkYDf9gN2HMmzuE9jmCAXnPZPRW+TdjNu
 IkR38GTUIQP+sy2mlLmrNbLhHktLuk9nI9oScd5b+x78kQzwawk6pAWwLpn1zo+By9XuP6uyNVp
 ZG6D/+kZw/KFefw==
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
Message-ID: <20260828-qemu-no-hmp-v5-4-9227de146347@redhat.com>
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


