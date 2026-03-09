Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19ADFF41808
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 15:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzcEh-0000r9-NP; Mon, 09 Mar 2026 11:09:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEh-0000qh-16
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vzcEf-0008Mo-Ie
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 11:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773068972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H/8FdOawT4l+d49GakUVhtVVYAdyZ+VALEhrmRAkR5g=;
 b=cnpG1wtwNDrCw7JHSNFCbtJEwb36bS8IjH64cVMmCFaYq1YM/zWZTvi3+nhJfkCwnofsdA
 TqlpxfCybyaXCbe0Pb5RpmCmeMFlPenV05PR0o5YtFmYiPTf+u7C/A4bgjVNDNIesQox7F
 I/j/9rtv25n2kE52OBHlfZP8caOlWzU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-sJbow0PMMvOnqmY1VYgIaA-1; Mon, 09 Mar 2026 11:09:31 -0400
X-MC-Unique: sJbow0PMMvOnqmY1VYgIaA-1
X-Mimecast-MFC-AGG-ID: sJbow0PMMvOnqmY1VYgIaA_1773068970
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4852ccff333so26570265e9.2
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 08:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773068970; x=1773673770; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/8FdOawT4l+d49GakUVhtVVYAdyZ+VALEhrmRAkR5g=;
 b=ncJvgHV/DrYKH5orgzJa2aeQ8YQti+NEZqW+7N0MXSYNrOr/W17Oz13Sl7/qZV0OIW
 kCmCnQT1M4Y4IjdfWEx1hvZJP6Zoi5G0pkdKCR+zk/OLBZ4ts8ZzHhYJfJ4whaJN1dFa
 m/IvacTOEULKHyRKOjrOrvyQ7w+SrcmHiqUB21YfxCwUPQllTHR/zlSoHR4KXV535Oc0
 zH3efZPGZEiR5b1vP/cskaJ/vPAFM30CeZsiAnctOreOl46Sok93FVcmb5+yDohXexDl
 BCJf1rN6FaNtexdR87gs+dzKSrszJ6mrm3spvH2n8CYv6AIl+UGvG+2JiREniXLfkyXe
 z0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773068970; x=1773673770;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H/8FdOawT4l+d49GakUVhtVVYAdyZ+VALEhrmRAkR5g=;
 b=NOPJIWW0qBn6Sj2xWCuvDJRhx0KCp+feNhbIHll6zsb10ZJhV1h6+aFf7LwE7+fbuq
 C6WIFdqtz2ipYsaVClUTVtdkVMl3bCqw6MqRsHw3GnFzyG5RZ5iORvG9nKdTp1J7w5Le
 Rj1lxZZwDUeKf4sWTTw4CWAQkwhF/faBE7KGN9RT0erJluRDSZCB0+e7e/jaD3LXZ8FI
 sUcScwqTz2lvUrc8Wr95a1WmAE1I320TdjfEjHWKLyzQew3arwa3u7jPutlSEMNawAvr
 aOxKj2DhCbvG7SW82OO6H5MMJtSwri9pypCTi7DgRarZiCJ6Sq66UQZRL31jD+yugoup
 yRRg==
X-Gm-Message-State: AOJu0Ywb4P2v63JDpSmbv0ipXPfJTjS5xpdiFa9ges4UX2hLr6BYee9s
 2Supe/3bZJgo2GiXBFTP+BnG4szCxQiFuccifexPldeLjOJ++V5b3e5Z/udhPxQ6HyGXUs/0uCj
 SJuqmuOFBTX3newovHrU1u2ruZSAz/P4k9uEdB8w3PH9tBeUpXwxy0t0N
X-Gm-Gg: ATEYQzzaDTtdxzl75zCxxrDytk3DY78dit2R7zMH/vTXa+KJUnoluyNU+nMpN7zuPYA
 CFvNol/NPCFeeZBXcSJDhx8Bzqu09ZJMeeAXnfUA6yuzfVeHnnemjtp2s6m5ejpqBHXA91YLVPu
 JlvmPUIK61xsf8yh37+D0+V/hVAfhoJPPJeOPwnhFQQ8uK0mJWO+AsCzW6+/+4E00OXFO//2og0
 NU10x0tdyXmzfAd/EjwvITZtQJvGFq2eud1hvKZCB6HgRvffzHgLjEOm3hXc7nhnBV6Xqm3Lpfu
 Ek8cQSwDhmZLoF8F6Czf3IB/3+T+q2zrqlBBo0fksD/EU7xpG4qDlqJK8hxPGG8HTWqV/NgZTSE
 zRptwKVyO4N5fB6MDrmJeMQH2FpIAOUtxXp2TG0tisJo+peUuoH3rxIb1UWxG1kBZM/m2YABqV7
 6bd3P6
X-Received: by 2002:a05:600c:1e2a:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-485269582efmr185943445e9.16.1773068970327; 
 Mon, 09 Mar 2026 08:09:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1e2a:b0:47e:e57d:404 with SMTP id
 5b1f17b1804b1-485269582efmr185942935e9.16.1773068969819; 
 Mon, 09 Mar 2026 08:09:29 -0700 (PDT)
Received: from localhost
 (p200300cfd737d0cf29d515fbd6051d53.dip0.t-ipconnect.de.
 [2003:cf:d737:d0cf:29d5:15fb:d605:1d53])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485237dd017sm92455125e9.2.2026.03.09.08.09.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 08:09:28 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v5 10/25] fuse: Introduce fuse_{inc,dec}_in_flight()
Date: Mon,  9 Mar 2026 16:08:41 +0100
Message-ID: <20260309150856.26800-11-hreitz@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309150856.26800-1-hreitz@redhat.com>
References: <20260309150856.26800-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is how vduse-blk.c does it, and it does seem better to have
dedicated functions for it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 5953407f20..fc75a5e74d 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -78,6 +78,25 @@ static void read_from_fuse_export(void *opaque);
 static bool is_regular_file(const char *path, Error **errp);
 
 
+static void fuse_inc_in_flight(FuseExport *exp)
+{
+    if (qatomic_fetch_inc(&exp->in_flight) == 0) {
+        /* Prevent export from being deleted */
+        blk_exp_ref(&exp->common);
+    }
+}
+
+static void fuse_dec_in_flight(FuseExport *exp)
+{
+    if (qatomic_fetch_dec(&exp->in_flight) == 1) {
+        /* Wake AIO_WAIT_WHILE() */
+        aio_wait_kick();
+
+        /* Now the export can be deleted */
+        blk_exp_unref(&exp->common);
+    }
+}
+
 static void fuse_attach_handlers(FuseExport *exp)
 {
     aio_set_fd_handler(exp->common.ctx,
@@ -303,9 +322,7 @@ static void read_from_fuse_export(void *opaque)
     FuseExport *exp = opaque;
     int ret;
 
-    blk_exp_ref(&exp->common);
-
-    qatomic_inc(&exp->in_flight);
+    fuse_inc_in_flight(exp);
 
     do {
         ret = fuse_session_receive_buf(exp->fuse_session, &exp->fuse_buf);
@@ -323,11 +340,7 @@ static void read_from_fuse_export(void *opaque)
     fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
 
 out:
-    if (qatomic_fetch_dec(&exp->in_flight) == 1) {
-        aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
-    }
-
-    blk_exp_unref(&exp->common);
+    fuse_dec_in_flight(exp);
 }
 
 static void fuse_export_shutdown(BlockExport *blk_exp)
-- 
2.53.0


