Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21E3606B0D4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T38GUNXn
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNuvT-0006Jt-Dd; Mon, 02 Nov 2026 11:30:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvM-0006Cy-2H
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xNuvE-00023J-85
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 11:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793637011;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R9FvHmefOXeZQUSSt14EWF8vlTKwrYJ0csuo+kKlpUs=;
 b=T38GUNXn+lj2VZks9poqBvxf2XSRngJdXiWOtPnQmLQZ43UYPOvI5bOx6w8qHklHP1ALMP
 1VL79SFsFYWQz7oAZ0QuTj40R0iaArqwF7hjUZ1u2nYVcsAajiyK2mDkxW4EsZ049NMWPV
 dk7v09pEuOKsQwf4znaPLwhGV4Nadr0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-Mz6WF70FPFyZlVNlJOhTCA-1; Mon,
 02 Nov 2026 11:30:08 -0500
X-MC-Unique: Mz6WF70FPFyZlVNlJOhTCA-1
X-Mimecast-MFC-AGG-ID: Mz6WF70FPFyZlVNlJOhTCA_1793637007
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 408C41800591; Mon,  2 Nov 2026 16:30:07 +0000 (UTC)
Received: from merkur.fritz.box (unknown [10.44.32.164])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E20A61956087; Mon,  2 Nov 2026 16:30:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 02/17] block: Print simple help text when calling "-blockdev
 help"
Date: Mon,  2 Nov 2026 17:29:40 +0100
Message-ID: <20261102162955.268763-3-kwolf@redhat.com>
In-Reply-To: <20261102162955.268763-1-kwolf@redhat.com>
References: <20261102162955.268763-1-kwolf@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Thomas Huth <thuth@redhat.com>

Other command line options like "-chardev", "-netdev" or "-device"
already present the user with a list of available parameters, but
when running "-blockdev help", there is currently only an error
message. There is already the possibility to run "-drive format=help",
but it does not seem to be documented, so this is not very useful
for the average user. Thus let's improve this situation by providing
a proper list of available drivers when running QEMU with
"-blockdev help".

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260914090036.125300-1-thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block-common.h |  1 +
 block.c                      | 15 +++++++++++++++
 system/vl.c                  |  7 +++++--
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/include/block/block-common.h b/include/block/block-common.h
index 3932ff86156..1667fe5b625 100644
--- a/include/block/block-common.h
+++ b/include/block/block-common.h
@@ -583,5 +583,6 @@ char *path_combine(const char *base_path, const char *filename);
 char *bdrv_get_full_backing_filename_from_filename(const char *backed,
                                                    const char *backing,
                                                    Error **errp);
+void bdrv_show_help(void);
 
 #endif /* BLOCK_COMMON_H */
diff --git a/block.c b/block.c
index e72268db8d9..609763b635e 100644
--- a/block.c
+++ b/block.c
@@ -524,6 +524,21 @@ bool bdrv_uses_whitelist(void)
     return use_bdrv_whitelist;
 }
 
+static void bdrv_help_format_print(void *opaque, const char *name)
+{
+    if (bdrv_format_is_whitelisted(name, false)) {
+        printf("%s\n", name);
+    } else {
+        printf("%s (read-only)\n", name);
+    }
+}
+
+void bdrv_show_help(void)
+{
+      printf("Available blockdev drivers:\n");
+      bdrv_iterate_format(bdrv_help_format_print, NULL, true);
+}
+
 typedef struct CreateCo {
     BlockDriver *drv;
     char *filename;
diff --git a/system/vl.c b/system/vl.c
index fbe580746d3..7ae6a8298fc 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -2975,7 +2975,10 @@ void qemu_init(int argc, char **argv)
                           HD_OPTS);
                 break;
             case QEMU_OPTION_blockdev:
-                {
+                if (is_help_option(optarg)) {
+                    bdrv_show_help();
+                    exit(EXIT_SUCCESS);
+                } else {
                     Visitor *v;
                     BlockdevOptionsQueueEntry *bdo;
 
@@ -2988,8 +2991,8 @@ void qemu_init(int argc, char **argv)
                     visit_free(v);
                     loc_save(&bdo->loc);
                     QSIMPLEQ_INSERT_TAIL(&bdo_queue, bdo, entry);
-                    break;
                 }
+                break;
             case QEMU_OPTION_drive:
                 if (!qemu_opts_parse_noisily(qemu_find_opts("drive"),
                                              optarg, false)) {
-- 
2.56.0


