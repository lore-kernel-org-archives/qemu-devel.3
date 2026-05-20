Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB49BCD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 21:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPoZV-0002i6-G2; Wed, 20 May 2026 17:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZN-0002IA-Ez
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wPoZL-0007f2-Pp
 for qemu-devel@nongnu.org; Wed, 20 May 2026 17:35:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779312911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BN/SAy/s/zQ4OQntT5AIDwA9mLnJ4zwvh7mc8onZCok=;
 b=O1qIjz1CTxLXk3XdG9eVcd5bXGrMYBzUxrlwdMr7T9v4KkDkZfbgJ7z46mDLJ6THGxlVuX
 80za0SS7360xUuruCXQC8ARD9mrbG4qCAGtI6Q0nyYXMg385LPPszjovhY249zsOBszz3g
 Z6E5DMs/4+IYDBYNW6GDl0b9pZm95L8=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-531-0DP-C-hdPiaFktSfEtG4eA-1; Wed, 20 May 2026 17:35:09 -0400
X-MC-Unique: 0DP-C-hdPiaFktSfEtG4eA-1
X-Mimecast-MFC-AGG-ID: 0DP-C-hdPiaFktSfEtG4eA_1779312909
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-514b673c8f1so58320071cf.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 14:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779312909; x=1779917709; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BN/SAy/s/zQ4OQntT5AIDwA9mLnJ4zwvh7mc8onZCok=;
 b=FEoZMc/C/kaGCdbg9IRqeE4pj1bPgZyq+DtGC5XmrzIwMjAOizy52WShql14YmZmvV
 tyzdypW2BJtCcLvQIJ0hNxTQiBQfl8s46pOvCunMX6nznbaqhyb4SFk2RL+PVGkoYlhn
 hs2zSXelOYYEpy8iIhcLBJCaYc5emYTp46ZYynxdSXiTDzIYfKbGfUpkvMPK9rxQVa2o
 JzuTjgnh1+JwyclEh9arrlbZR8cwrhfM1S/8Xabf8yoATJ0aCx4ztGsl4XSmS0HuIsEv
 YhUcASRP84nqsoSvFIA3aaGRFwkvS684L2LGkPcTvLVcCmHyBLWsx+AGJpCTpPcG9MiL
 xD/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779312909; x=1779917709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BN/SAy/s/zQ4OQntT5AIDwA9mLnJ4zwvh7mc8onZCok=;
 b=WZqa+AdMJQE0feVVBsiuP4BJ/vw77KAuaaWPdVQpmxssG14pyEymljhqeeWD8X6XaM
 kP0vKxPqRiVCBccTwcU+3CmoadTRqFKwUH62A2mGVXdJairEW/EPt+tRo0lfRUFxEtgz
 X2uDxINCEWaqv7mvVcthHRWmiEqv0vYWFc+/doYpw4B7QlvZGLigfr4yc5NJdxGm4XzB
 SfrdGiGEN8fCpa3fxHHJOIAxuvjq7p9MldZJpQOaWuM38pBhjQFN1LmtdD05BuLl5qxU
 KGo5HnMVlYfCU2iCIQMWlWw8mvaKjrnCp8YO8EtMciWigC7L5BqOkaXVVHt5O9q7B/O+
 qVcA==
X-Gm-Message-State: AOJu0YyDOMoIXXn0B3+IycMj1czS3CgzGTtXo2yfD/n6x79FQlRaa2VU
 wXdUEh6iSt9/W/l87gtjNfo4sgR/uaRoAb40GaNsyWiV/kccEE5RizOZ5G2bF9p9mKd3yPPJBBs
 nWG245RGKHcG3QxqO1SHXBwcwnG3oMG6OPBf8Chjv057o6bMGS9De7tnhtqqlU/A31MsmriwZkM
 /LjmmFuiJi/cC1UMijvDluacJjB+z62tfMCdBHmw==
X-Gm-Gg: Acq92OFhr0wmXOuimn6BJAAoTMYffpefZlO3VnqqbeBGMTNS+yPUrlw2EQ559OIY0qR
 o7RW56Zyoq40mMDzs7GAxfSMGEhGFquwSlv9bNfY5gMvloSsKVWsOFic/cGsOOI9CFmfvPc1L2v
 eUJqko4HLb1+KRZtHImqY/OPgpBaYrS+iYXEdVwTQy2m9+KDLkqu1rHEGOFQUwVdKsqep3W2Xq+
 5gGQqeXgyxIoqNH/ggVkS9TohmFBXb631KrbgKVcihC9iw6c+IahHU8szLgv4r9VxRrWvBVPHSP
 JPBVMWfu+g6d2O3b29HAZOpn8L9hNQmDWslOCQA6RJJ6Bf3NRJmjITqhVP6CyyjAk1D+qLbJIVY
 BsMttf3VYtGDn+u0u09fikSIEWOdb85AS7ozMxJPjMJ4h
X-Received: by 2002:a05:622a:190e:b0:50f:b494:7887 with SMTP id
 d75a77b69052e-516c55ba389mr3671231cf.51.1779312907931; 
 Wed, 20 May 2026 14:35:07 -0700 (PDT)
X-Received: by 2002:a05:622a:190e:b0:50f:b494:7887 with SMTP id
 d75a77b69052e-516c55ba389mr3670401cf.51.1779312907230; 
 Wed, 20 May 2026 14:35:07 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ca360b362fsm133062716d6.22.2026.05.20.14.35.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 14:35:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Bin Guo <guobin@linux.alibaba.com>
Subject: [PULL 27/29] migration/multifd: cache channel count in
 multifd_send_sync_main
Date: Wed, 20 May 2026 17:33:55 -0400
Message-ID: <20260520213357.40646-28-peterx@redhat.com>
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

multifd_send_sync_main() is called once per RAM synchronization round
during live migration.  It iterates over all multifd channels twice
(signal loop + wait loop), calling migrate_multifd_channels()
independently in each loop header.

Cache migrate_multifd_channels() in a local thread_count variable at
function entry, matching the pattern already used in
multifd_send_setup() and multifd_recv_setup().  This eliminates 2
redundant config lookups per sync call.

Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20260518110112.21395-9-guobin@linux.alibaba.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 0ac3f5e719..dbad525d2a 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -611,13 +611,15 @@ static int multifd_zero_copy_flush(QIOChannel *c)
 int multifd_send_sync_main(MultiFDSyncReq req)
 {
     int i;
+    int thread_count;
     bool flush_zero_copy;
 
     assert(req != MULTIFD_SYNC_NONE);
 
+    thread_count = migrate_multifd_channels();
     flush_zero_copy = migrate_zero_copy_send();
 
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+    for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         if (multifd_send_should_exit()) {
@@ -634,7 +636,7 @@ int multifd_send_sync_main(MultiFDSyncReq req)
         qatomic_set(&p->pending_sync, req);
         qemu_sem_post(&p->sem);
     }
-    for (i = 0; i < migrate_multifd_channels(); i++) {
+    for (i = 0; i < thread_count; i++) {
         MultiFDSendParams *p = &multifd_send_state->params[i];
 
         if (multifd_send_should_exit()) {
-- 
2.53.0


