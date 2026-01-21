Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C74C44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:35:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigly-0007kr-9t; Wed, 21 Jan 2026 17:33:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglx-0007jv-4U
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1viglv-0003jH-Nx
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034835;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ofQMmuZcfwwZ+QpkUNutXrt2ubx9LxkcsFWNYdfsjvY=;
 b=iIo8NU6tJTUy0LQ3iR69IpP6CMPzYg1cDdZ1qzta6mK8Y5FpzZUMG7YzrDQ3p8nTKt6wtQ
 r/5MK/e8wTkjEs8O+Dnx8DYeV2lvcGhybEZKXPPHPO2obA3G1WfA0PI4Ytu4Jj3aWATiRf
 M/Xph+bG75+B/Dp4OIq0IHXDHoZThE8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-KP3b2RyiNoCziWTQHoezEQ-1; Wed, 21 Jan 2026 17:33:54 -0500
X-MC-Unique: KP3b2RyiNoCziWTQHoezEQ-1
X-Mimecast-MFC-AGG-ID: KP3b2RyiNoCziWTQHoezEQ_1769034833
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8bc4493d315so85627785a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034833; x=1769639633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ofQMmuZcfwwZ+QpkUNutXrt2ubx9LxkcsFWNYdfsjvY=;
 b=WS9ZwR9F9EW+iBPghpVgpJPygfhZzkyox04tY5B0yCT4ddHIuru9QHe/g9DofTqkcj
 OpPCEZ/+PB9WUnTgDV2ilEwl5zmGbvIyRVSbdrP/Ugk3mD/wyuQ9q8QJKR08VQv7ji34
 X5DdtPBpPnMOp72OexoKwkPTv07eaeSZPjMVGFmTKY/zB23kTBzR4t5H0jbkgES5xrOw
 Ut5rNNz7re9ZQ5l3ik866tl2A/jvciBrIynPng2xByhAWmi5orZHCSHvs3+NfUINDRAx
 8IhrdycKzYweVHRdZhPs/soIiaPUw+8Ca8pmjU2njxaVj+OXog86dc805a9yNYss5n7b
 MDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034833; x=1769639633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ofQMmuZcfwwZ+QpkUNutXrt2ubx9LxkcsFWNYdfsjvY=;
 b=wKoybwiqM/n1KtSTb41A9aCUqzLBFGmAxXcWV/QelVNDsgB8/uSiucwJOrdsRqB+L+
 cr3vC7Tghj97hch01bE+fRkg4bl6htIEo4gnf+6THQT5FSr/3ZcMtbaEolr19o2SdZl7
 bWgbh1JG/5A6R+sJj+7Pq0x17IxuplsbodWxzd4nJOYdY7PF2MbwGt/grSAkH5O7vGa6
 3q/QQRfI3QBScNB6Nrq4DjvHZc+9bug1mFXa9Ke3+FzrQRQULwcgxc723E1eQ43AaBwZ
 w0VgGDbhxjoWNFAjpl1Xbt1dGsilHIFJbDHrLNqpV77J+gguoviM3MKSDv/q8URHT5jc
 vV9g==
X-Gm-Message-State: AOJu0YzCAZTGXdyJWKPwyimlmy14QHg7Ys67949qwGI1PYL7qsj/8ita
 aBOmOr3mjz9NrOkpm+qNJN2PNv/oUXo/SoKjXTd5o+bSEGpsr61NBB3SSCTFMvbozEWlueF6J+U
 pdjCxOIbyoDL6V7LE6P8yYM1LpQgBUEQxZ6QAadu3qOXSAEVG0wLnFgkUgzQ52YfY4y9S8gnt6q
 K8f8XpnT46/sIc+FLINtbReS7R2JWeTqfKjquCMg==
X-Gm-Gg: AZuq6aIOm4TMsWwukQD5+YWz/dO8jMhd1gHyl2JZOisvjX5ZqITV4X84Ck5qqtqL8x8
 IKaxpHDoosV/zObP9SPSm7M0szf2w9DbjsM7r2PW6KREejXLYLHcI7jxKIi9GSIdLnduyn+LzLi
 r0RSsNqkGCU18ed7H+xMr7ua7TYzyiAith8iFw1bI9Bn/u94gHFAZJlXXIYUIYYn+TRfg6ZkBms
 fgNs0sYJCjx5d1/MCElXJba2+ZUaFCS3oD4cdkCz7iOU9j6MCAyRZFMyvA6Amn+2Gq8DRVrawQZ
 j8wgNAmFFB/JSYLNjhuJs7vN4aAQmeT8xegIryoZx1sp4wqfeGGQ+M3b4Zk3OJ4lnuzEwEl8ZWQ
 5
X-Received: by 2002:a05:620a:a305:b0:8c6:a80c:cf6a with SMTP id
 af79cd13be357-8c6a80ccf97mr2150214185a.81.1769034832936; 
 Wed, 21 Jan 2026 14:33:52 -0800 (PST)
X-Received: by 2002:a05:620a:a305:b0:8c6:a80c:cf6a with SMTP id
 af79cd13be357-8c6a80ccf97mr2150210585a.81.1769034832316; 
 Wed, 21 Jan 2026 14:33:52 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89470b0ac3fsm25598306d6.25.2026.01.21.14.33.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:33:51 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Juraj Marcin <jmarcin@redhat.com>,
 peterx@redhat.com
Subject: [PATCH 10/10] migration: Drop iterable_only in
 qemu_savevm_state_complete_precopy
Date: Wed, 21 Jan 2026 17:33:35 -0500
Message-ID: <20260121223336.3381912-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260121223336.3381912-1-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Now after removing the special case in COLO, we can drop this parameter.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.h    |  2 +-
 migration/migration.c |  2 +-
 migration/savevm.c    | 12 +++++-------
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/migration/savevm.h b/migration/savevm.h
index 528607f09e..ea01ca63ec 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -42,7 +42,7 @@ void qemu_savevm_state_header(QEMUFile *f);
 int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
 void qemu_savevm_state_cleanup(void);
 void qemu_savevm_state_complete_postcopy(QEMUFile *f);
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only);
+int qemu_savevm_state_complete_precopy(QEMUFile *f);
 void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
                                      uint64_t *can_postcopy);
 void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
diff --git a/migration/migration.c b/migration/migration.c
index 1bcde301f7..5d21d6dc11 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3018,7 +3018,7 @@ static int migration_completion_precopy(MigrationState *s)
         goto out_unlock;
     }
 
-    ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false);
+    ret = qemu_savevm_state_complete_precopy(s->to_dst_file);
 out_unlock:
     bql_unlock();
     return ret;
diff --git a/migration/savevm.c b/migration/savevm.c
index 529cf310e0..1bf1037ce1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1717,7 +1717,7 @@ int qemu_savevm_state_complete_precopy_non_iterable(QEMUFile *f,
     return 0;
 }
 
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
+int qemu_savevm_state_complete_precopy(QEMUFile *f)
 {
     int ret;
 
@@ -1726,11 +1726,9 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only)
         return ret;
     }
 
-    if (!iterable_only) {
-        ret = qemu_savevm_state_complete_precopy_non_iterable(f, false);
-        if (ret) {
-            return ret;
-        }
+    ret = qemu_savevm_state_complete_precopy_non_iterable(f, false);
+    if (ret) {
+        return ret;
     }
 
     return qemu_fflush(f);
@@ -1831,7 +1829,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
     ret = qemu_file_get_error(f);
     if (ret == 0) {
         qemu_savevm_maybe_send_switchover_start(f);
-        qemu_savevm_state_complete_precopy(f, false);
+        qemu_savevm_state_complete_precopy(f);
         ret = qemu_file_get_error(f);
     }
     if (ret != 0) {
-- 
2.50.1


