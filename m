Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFC03CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 10:56:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHJ7k-0000dn-7i; Thu, 15 Oct 2026 06:55:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ71-0008Ur-Nx
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1xHJ6z-00083n-M7
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 06:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792061700;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kLwvsJo9MCLWiaGJavPp+AcGiwcOQ+rGY3GHPj3ANPI=;
 b=cobH1sfyc1Wsj4yoEfW2ZW6ywm2yZ6zhCQSc6FRdO8rqlxK4xh6ManbgUBVK6F5XqEqm4K
 sh0cKFaVklmkjY65Hph0ZTqCxug0mK7YfA92L9eGwOHK/dMcUKx6PpRcYn1OzYywbyit31
 k2aPrlk/vWJ3JeKi0usf4MAvA5Y+yac=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-PjmJHmWrNhuTM9Pe0NCm1Q-1; Thu, 15 Oct 2026 10:54:59 +0000
X-MC-Unique: PjmJHmWrNhuTM9Pe0NCm1Q-1
X-Mimecast-MFC-AGG-ID: PjmJHmWrNhuTM9Pe0NCm1Q_1792061698
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a027f2e364so35314035e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 03:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792061698; x=1792666498; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kLwvsJo9MCLWiaGJavPp+AcGiwcOQ+rGY3GHPj3ANPI=;
 b=KUnH72xsxMTQbznyfotSroEixnIMOvpg2nhr2qjQv6RN36pQD3w8pDKTsKTbcOPS9p
 s2v0EElWIKKDMZi1AaHMGETYJBZzW1gwtLeoOkWBrelSs1xZFL+w1abghOOaoB5eTex2
 jOGg8IZ6k1PeTvZqjSfAarKWlrRyGGhJC+9RK7BpdHqxpbG74K95dmvkq98Dh76OESpT
 5IKl2kCGiirDjvmymif2+76+9Oni7Zf9aHx8DIE8tFr9s9bI3jV6Bkl6nkFNx4qHEk2G
 ckAY2H+obmfNaIIJoDROAHiSTojh2aH6fyUot1ApbpVOoXKul/wvQr/OSzJqYCGAAs9V
 SNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792061698; x=1792666498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kLwvsJo9MCLWiaGJavPp+AcGiwcOQ+rGY3GHPj3ANPI=;
 b=ereqxJCWXFeKmCEaHDFJn0LOc0zbvFyMLm2Ut9gfRdguS6+i3WR0LRYAstYfrx7uoH
 kUObeKL0iH9Vx4td78dEF8ncZ/4lqln+GeKwCLuw5cNAG0pDbmUCq3ATNRJCjpaVt6+M
 atdNv+pkfAAKEry2DkAYgwvoEzJqR2XUKoCvNFLPRZc5Pl5ZIMv/Q2mIOUC200JfEjvc
 dGSHEbm23moGAtNxawoMH5RsHh1VM/PGKXjLhLx2Kx23KGm7z7Em6jLUQQ6FgxUmcT+H
 TDL0paUKch6RQ/HyclSDRM5Qz3TmfLK5hwuv4sM0VelnK3ys/+/SZi8fk6d606TZV6hp
 /7cw==
X-Gm-Message-State: AFq9FYJnNYiQ2KPRh5H5MMhDeYqbmzkE485DQhwzaft//Y3KHhooAB2v
 Ez8QV3zoELwS6SQE9iUk0C1cO0rGmEzqzlEcbSbcHSJBFRFAg2tYwG/SLX8aTf/K2J65fdi4xCl
 Q+Uddbocj27BNLBs1LUZiBlaHI6y05iGHg3xVzrtymIxbn/Kqy1ldxuincJsRKSA98oRYYfQt/n
 js2UiICxMnlc0NSFePFkuk8xwUAopq6/65mrndxr5F
X-Gm-Gg: AYBFou1nHWWVmHRU8YXwvnW0n12a4VvYqK2MMjRm5BUEMxTwjY+w19VKoeBKs8gt3yn
 fmASIr7fCqa/Msgytu/K26vXH/ej7A+uIU9357xViDPRIh+OpfmHhUzEESYKpmVeikevcp11eeS
 Mv0SzJ5I1Pj5jKTjpxFl8TDKwq6XH6oRXGYkdpqju0U14wn5xdnL4GESILLy+LN0s4HioZqyBFx
 uxj8/lJ5L5+LBg6k+FprELio5rYprxnHjnp+ouq2aJ1RH1V9iPrSvtDyiuUrYTWm1FlxJNBP1Y/
 SxeJcDCG+7WUXMr0krMox8Bea1QpoEi6KWRB4mGw+1pDQSPGQWvB/J2JUuujHtdXRv2/blkSoxu
 NMU35LimmUOLvnuwIIMx8UszdYFXQ1gIpOJPdgJU9l2VKy0ubBYBuPPFq+kyz15Iz79ovKAByUf
 4OqFaF
X-Received: by 2002:a05:600c:4747:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4a18e49d65dmr369435435e9.5.1792061698157; 
 Thu, 15 Oct 2026 03:54:58 -0700 (PDT)
X-Received: by 2002:a05:600c:4747:b0:4a1:88de:9e8b with SMTP id
 5b1f17b1804b1-4a18e49d65dmr369434955e9.5.1792061697582; 
 Thu, 15 Oct 2026 03:54:57 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.82.153])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd993caesm124255405e9.12.2026.10.15.03.54.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 03:54:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Eric Blake <eblake@redhat.com>
Subject: [PULL 09/13] pr-manager-helper: add PR_HELPER_CLEANUP command support
Date: Thu, 15 Oct 2026 12:53:43 +0200
Message-ID: <20261015105347.827029-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015105347.827029-1-pbonzini@redhat.com>
References: <20261015105347.827029-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

qemu-pr-helper now supports the vendor-specific PR_HELPER_CLEANUP SCSI
command. Add support to the client side.

pr_manager_helper_run() uses scsi_cdb_xfer() to determine the number of
bytes to transfer. Extend scsi_cdb_xfer() to know that this
vendor-specific command does not transfer any bytes.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Link: https://lore.kernel.org/r/20261013181752.1299456-6-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scsi/pr-manager-helper.c | 20 +++++++++++++++++---
 scsi/utils.c             |  3 +++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 26ef3876f0e..e7162e21ff0 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -38,6 +38,8 @@ struct PRManagerHelper {
 
     QemuMutex lock;
     QIOChannel *ioc;
+
+    uint32_t proto_flags; /* flags negotiated with pr-helper */
 };
 
 static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
@@ -129,7 +131,9 @@ static int pr_manager_helper_initialize(PRManagerHelper *pr_mgr,
         goto out_close;
     }
 
-    flags = 0;
+    pr_mgr->proto_flags = be32_to_cpu(flags) & PR_HELPER_FEATURE_CLEANUP;
+
+    flags = cpu_to_be32(pr_mgr->proto_flags);
     r = pr_manager_helper_write(pr_mgr, -1, &flags, sizeof(flags), errp);
     if (r < 0) {
         goto out_close;
@@ -161,9 +165,19 @@ static int pr_manager_helper_run(PRManager *p,
     }
 
     memcpy(cdb, io_hdr->cmdp, io_hdr->cmd_len);
-    assert(cdb[0] == PERSISTENT_RESERVE_OUT || cdb[0] == PERSISTENT_RESERVE_IN);
+    assert(cdb[0] == PERSISTENT_RESERVE_OUT ||
+           cdb[0] == PERSISTENT_RESERVE_IN ||
+           cdb[0] == PR_HELPER_CLEANUP);
+
+    /* The command is only available when pr-helper supports it */
+    if (cdb[0] == PR_HELPER_CLEANUP &&
+        !(pr_mgr->proto_flags & PR_HELPER_FEATURE_CLEANUP)) {
+        return -ENOTSUP;
+    }
+
     expected_dir =
-        (cdb[0] == PERSISTENT_RESERVE_OUT ? SG_DXFER_TO_DEV : SG_DXFER_FROM_DEV);
+        (cdb[0] == PERSISTENT_RESERVE_IN ?
+         SG_DXFER_FROM_DEV : SG_DXFER_TO_DEV);
     if (io_hdr->dxfer_direction != expected_dir) {
         return -EINVAL;
     }
diff --git a/scsi/utils.c b/scsi/utils.c
index daee90ecf0e..1ee68e68221 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -29,6 +29,9 @@ uint32_t scsi_data_cdb_xfer(uint8_t *buf)
 
 uint32_t scsi_cdb_xfer(uint8_t *buf)
 {
+    if (buf[0] == PR_HELPER_CLEANUP) {
+        return 0;
+    }
     switch (buf[0] >> 5) {
     case 0:
         return buf[4];
-- 
2.56.0


