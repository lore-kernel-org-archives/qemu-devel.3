Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FDB2CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:35:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZS-0002QU-Jm; Wed, 20 May 2026 17:35:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZK-0002DS-MG
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZI-0007de-GC
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xF9Gk/nAuXQzYr5I0F5ONytQ6ebnHoMyIC4gn7lM5Q=;
 b=f05UGjBOeTbg2aFh80VvZCtLLGZ/fKmuwYI+4P/nUt01neDwIjBYZ2GPemTx+w9SdGs8+l
 a9yREO1wfyAF8DZ9yvBc5k8N0olcxbDEEBCsZj74/WQ6wMNhI2Z7D9XGmAaxHVr7eRflEw
 hPe/U+no/8Tx5HhqbL1nMSfQgU4l/O8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-e-SYvXDGO8G_xpJ8qfeeGQ-1; Wed, 20 May 2026 17:35:05 -0400
X-MC-Unique: e-SYvXDGO8G_xpJ8qfeeGQ-1
X-Mimecast-MFC-AGG-ID: e-SYvXDGO8G_xpJ8qfeeGQ_1779312905
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8b459fa5f76so73805066d6.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312905; x=1779917705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xF9Gk/nAuXQzYr5I0F5ONytQ6ebnHoMyIC4gn7lM5Q=;
 b=oNl3knxNinslOFzIGJx6CY1FOeRyfToL5jo4dT3//YsXifK/XAcYkA6Qi2A4bnVFhM
 QCsNZXriPDrOsVp7OKpPvTeEa77AFJa6GCkGIegzrQmAL0MOS6SI8JChCRNNBhezjyK5
 Jft9V9unTVraGTOjwLwz9mrmtT2mjnOQpufb8v/leXAUOnR5ESXeH3VgHb9FdJW7ZbdE
 kpUY9Cfh47ntIXXarr0bvnGyQjBrGsRhO6sTaPnlhjQWknSicLtVQpnc4ZciAQfRQXuI
 sYlQaAbzbS+m1MBzzcNPVDRdM0jvzHzxvv63ZLWg/1pNJYWBSQWwOtA8OqY00u/iU1uv
 BZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312905; x=1779917705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1xF9Gk/nAuXQzYr5I0F5ONytQ6ebnHoMyIC4gn7lM5Q=;
 b=WoIHvsgCJewlvUf9PI9C3Tb0ckyyJL7hPMjoukzsrExYgMWxY7RI/nDPPfE0LhkDZe
 yMhKEKxurnZHfkpIAmA1CC64SXbnI03VUbvP+Mh+7CzKLoLx4xdKFYIAl5FEF0NS9SFV
 lasJDXVpLJiorCnl70Gg1mtX3lcBX8p/ecJ+x26u9FIlOyLV3sV4lRS0KWrd8686Tp+W
 Lzs5sRnlA+M4AAo7W5vIfH+fcMMiZfSmQPOO8Gq0rcUOqnrvUhn9nF+qBpUEHg5pw7oE
 vX2fAFJJxWRg7iRSYIDJ/QwyR0o7i6K5UPQHQjCQ5GI+JwKb6XbgT1UHk++tRtRjQl7X
 yEaA==
X-Gm-Message-State: AOJu0YxsoPx5reQoyUWgrbQBCy84tEjS1Gw8JSnsml+cRgFKebsI2YeV
 hfR4znDooOGR23haKwkueFk2/oQR0dCO3pmkFGcqVXUMuAVHDm1kZWEmYK3NDDrfC2MFy6xnrtr
 RYGL9T3Xq5y97g/mTMvdZqRyYH1HKqArWgKFWAaL+gSba6IkvE8+9LSptuqzQkwZ1o/gnVM6rjc
 WYlK5NG/2Aat4BZjCv4+RsmzvVLMBUQFytDqwzLQ==
X-Gm-Gg: Acq92OGN1L7lsA+w+mXceQcvcNMoZ4l9hwxAfF6Q16a6hxhKVTG3Ga+Ub2TNtW39+zU
 FXIi2cFW4uUNPb8Gx4j36VVptNk3dqGDzLNN3+H7phvd44B5s94zDYEcX6JGNThaJa20YxGrpyD
 LS+ffrhVmJQT1hIHDcEMVmASIRLobYdSUx9cbNTr1g/DUvRq+DNxBZhStRJ/Gos1v+lagBkc+h6
 DWgRO362CU4L9jBDRFKzahcdaDAT0VJ9b741NxPwo07gqzJQRUNtwE4IALE51vReoQPk8Vrgknq
 nIHHNjk6NF3xmvT+l7KwauT7z2Ilmq8WLonifNeca60E+VzJiz5rytVc9JLAMC6J7VZ97dg8J6q
 0jWNzicWMIFcu5gLxkm6NhqVDqcbMYTVpuDlm6iKCgIae
X-Received: by 2002:a05:6214:4286:b0:8ca:207d:50c8 with SMTP id
 6a1803df08f44-8cc6e30abf2mr4559846d6.16.1779312904982; 
 Wed, 20 May 2026 14:35:04 -0700 (PDT)
X-Received: by 2002:a05:6214:4286:b0:8ca:207d:50c8 with SMTP id
 6a1803df08f44-8cc6e30abf2mr4558856d6.16.1779312904224; 
 Wed, 20 May 2026 14:35:04 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.35.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:35:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>
Subject: [PULL 26/29] migration/multifd: cache migrate_multifd_channels() in
 send/recv hot paths
Date: Wed, 20 May 2026 17:33:54 -0400
Message-ID: <20260520213357.40646-27-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520213357.40646-1-peterx@redhat.com>
References: <20260520213357.40646-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Bin Guo <guobin@linux.alibaba.com>

multifd_send() and multifd_recv() are on the per-page-batch hot path
of live migration.  Both functions call migrate_multifd_channels()
multiple times (3-4 calls each) for modulo arithmetic in the
round-robin channel selection loop.

Each call goes through migrate_get_current() -> dereference
MigrationState -> read parameters.multifd_channels.  While each
individual call is cheap, these functions execute for every page
batch during the entire migration, easily millions of times.

Cache the return value in a local variable at function entry.  The
channel count is fixed for the duration of a migration and cannot
change mid-flight.

For multifd_send(): 3 calls reduced to 1.
For multifd_recv(): 4 calls reduced to 1.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260518110112.21395-8-guobin@linux.alibaba.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b3eef875cc..0ac3f5e719 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -362,13 +362,15 @@ bool multifd_send(MultiFDSendData **send_data)
     /* We wait here, until at least one channel is ready */
     qemu_sem_wait(&multifd_send_state->channels_ready);
 
+    int thread_count = migrate_multifd_channels();
+
     /*
      * next_channel can remain from a previous migration that was
      * using more channels, so ensure it doesn't overflow if the
      * limit is lower now.
      */
-    next_channel %= migrate_multifd_channels();
-    for (i = next_channel;; i = (i + 1) % migrate_multifd_channels()) {
+    next_channel %= thread_count;
+    for (i = next_channel;; i = (i + 1) % thread_count) {
         if (multifd_send_should_exit()) {
             return false;
         }
@@ -378,7 +380,7 @@ bool multifd_send(MultiFDSendData **send_data)
          * sender thread can clear it.
          */
         if (qatomic_read(&p->pending_job) == false) {
-            next_channel = (i + 1) % migrate_multifd_channels();
+            next_channel = (i + 1) % thread_count;
             break;
         }
     }
@@ -998,6 +1000,7 @@ bool multifd_recv(void)
     int i;
     static int next_recv_channel;
     MultiFDRecvParams *p = NULL;
+    int thread_count = migrate_multifd_channels();
     MultiFDRecvData *data = multifd_recv_state->data;
 
     /*
@@ -1005,8 +1008,8 @@ bool multifd_recv(void)
      * using more channels, so ensure it doesn't overflow if the
      * limit is lower now.
      */
-    next_recv_channel %= migrate_multifd_channels();
-    for (i = next_recv_channel;; i = (i + 1) % migrate_multifd_channels()) {
+    next_recv_channel %= thread_count;
+    for (i = next_recv_channel;; i = (i + 1) % thread_count) {
         if (multifd_recv_should_exit()) {
             return false;
         }
@@ -1014,7 +1017,7 @@ bool multifd_recv(void)
         p = &multifd_recv_state->params[i];
 
         if (qatomic_read(&p->pending_job) == false) {
-            next_recv_channel = (i + 1) % migrate_multifd_channels();
+            next_recv_channel = (i + 1) % thread_count;
             break;
         }
     }
-- 
2.53.0


