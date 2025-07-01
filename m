Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63502C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 11:47:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWZQQ-0005N9-OT; Tue, 01 Jul 2025 07:45:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQL-0005I9-Um
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1uWZQI-0003Va-TN
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 07:45:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751370313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/2MYp3UhabT2qS0mTPTCo+T0B/SM6NTgMC1jdFmgg9Q=;
 b=UqZkmcfk2vq7Z/JU2eZaukbC4IvBmcw/Yi6epvIl1b4If6GVW/WSnEhZDY716Xw/OCIQ/u
 8iOrncP9JIgVPL33wTNq2wFiyNXl0oVo4DYD9aunihDJyln/RrOiEGi514Xm09Rfyu4B17
 gP/9Z+N9KNwDo5U6uabNRqrYjlz1QfQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-IVc0rBHpOAythf3167p9kw-1; Tue, 01 Jul 2025 07:45:12 -0400
X-MC-Unique: IVc0rBHpOAythf3167p9kw-1
X-Mimecast-MFC-AGG-ID: IVc0rBHpOAythf3167p9kw_1751370311
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a4fac7fa27so1111755f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 04:45:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751370311; x=1751975111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2MYp3UhabT2qS0mTPTCo+T0B/SM6NTgMC1jdFmgg9Q=;
 b=GoAW/ZSQ2cepE8P/IV2ca7WvyjiORkDU3fIer+Y6np6y6ZyGPvMtn6DaBngWb4SP8v
 DInZJ6uk6sKx5cIUbuiQEY6v+8JJ66RwgQK1xH8HhQyGYi+wuNsm67k0e4XAPUhrcONg
 5YQkiHyGiOw9kmRKdNbrpBN0eNCXUe1YSH5HMoz3NnYZcrk+TMobSk+bdf0GEAkYyOE0
 CI8KP10AcuiWOyGB+q80rSnHEqKctWMJJTvezoQa4vaQeUBRWv1YU4+rJpwYGEp3MnN3
 i4en3YJUoiGTCv9mhlDvNkWut/TVB9LpJWWmPj1lB5KaQj3hssRpw/s+cqqXsG576XwU
 tWpA==
X-Gm-Message-State: AOJu0YzWcnhjUnV9HlN4DQE3e5fTd3Uha0tHFxKyS4uy/1bIXYTmKGPN
 yzogXAsz/0WbptGWxmWFSia3SV+0dkN55ZcHxRd+ALxjyWdJN00C03WIuYmMnl5E/yq5UCY5/nD
 ZF/SEMSMgszQK9a1c15e4LJoizYr8T320WhHYX7AXO0X9sLST7vAXS6g7
X-Gm-Gg: ASbGnctJ5DZuhGA1xrqnbHC2BBW2+SAV1XO4eyu/i1ZvsOnpwTTgQWfQddII/QTe4kh
 eruK3wn1YJw4VcQ9EVQSYWHtwU/4DrZYughJ6RwNyOXy2vpE/35EYzHOWKUnWY9blzEs/BAwl0z
 ASkszI1IIiY1nuC3xAZbrPNB7qnp5hRwYVulx586Zl8pPXqz1VHGCkjIz/F3x2yqImB0rHQ9VZ1
 VK2vrtE2oUmMNnRC0DBD+tXYK9QEjlKjkOg0G8q1+HeSVBFnYZqji1A5AttXKWhm/QhXRx06DYy
 r/GLPFeckod3Z50IF1JOWogesbGcfMbP0nZfWkjd99yM6FcgDojg54Dr7lPMMZ0u4V1dJazc8rz
 lF46F
X-Received: by 2002:a05:6000:2307:b0:3a4:d02e:84af with SMTP id
 ffacd0b85a97d-3a9038fb216mr13616466f8f.58.1751370311177; 
 Tue, 01 Jul 2025 04:45:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEMGJU1ndauWgPN5Lbp8PmBB30xXxuL+JLwUB6hHOqq8E3n/IK/rxWkZ/GABI/k+vpT1CpwJw==
X-Received: by 2002:a05:6000:2307:b0:3a4:d02e:84af with SMTP id
 ffacd0b85a97d-3a9038fb216mr13616447f8f.58.1751370310764; 
 Tue, 01 Jul 2025 04:45:10 -0700 (PDT)
Received: from localhost
 (p200300cfd700f38d3df6a1ca7d40fe1f.dip0.t-ipconnect.de.
 [2003:cf:d700:f38d:3df6:a1ca:7d40:fe1f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e529c5sm13290493f8f.63.2025.07.01.04.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 04:45:09 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Brian Song <hibriansong@gmail.com>
Subject: [PATCH v3 09/21] fuse: Introduce fuse_{inc,dec}_in_flight()
Date: Tue,  1 Jul 2025 13:44:25 +0200
Message-ID: <20250701114437.207419-10-hreitz@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701114437.207419-1-hreitz@redhat.com>
References: <20250701114437.207419-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is how vduse-blk.c does it, and it does seem better to have
dedicated functions for it.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index 15ec7a5c05..bcbeaf92f4 100644
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
@@ -297,9 +316,7 @@ static void read_from_fuse_export(void *opaque)
     FuseExport *exp = opaque;
     int ret;
 
-    blk_exp_ref(&exp->common);
-
-    qatomic_inc(&exp->in_flight);
+    fuse_inc_in_flight(exp);
 
     do {
         ret = fuse_session_receive_buf(exp->fuse_session, &exp->fuse_buf);
@@ -317,11 +334,7 @@ static void read_from_fuse_export(void *opaque)
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
2.49.0


