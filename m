Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FA5CD2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoCi-0004l1-3I; Tue, 27 Jan 2026 13:54:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBd-00034z-SW
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBc-0000jT-B0
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VQjHMvx3XPpUkrdVwOgSZF1RvbP7lisB8RqoyBnK7Q4=;
 b=O5xgsa8HZM5jMingW6l3Ts48LUMgpmdJszCo2sG6EJGfxPxxZ/AB4dirJdfdU8/uAi5GfO
 mijHl9w4JKMWSKqsam9gBpoHvIoeOkW9pcmugF/UBFwL0z7rj8cflactPR7mZqYFpg3I/+
 ZUXmwsayKogjuRBh0+Qc2l3lJ7lBsRU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-Ucnr4diPNlmqQ77fnM8UCg-1; Tue, 27 Jan 2026 13:53:10 -0500
X-MC-Unique: Ucnr4diPNlmqQ77fnM8UCg-1
X-Mimecast-MFC-AGG-ID: Ucnr4diPNlmqQ77fnM8UCg_1769539989
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50148a1cc44so269629491cf.0
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539989; x=1770144789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VQjHMvx3XPpUkrdVwOgSZF1RvbP7lisB8RqoyBnK7Q4=;
 b=e6JLk8AvONW/Eigjb80aOyDC3DIRbBqlpHhEjvKYSezK/TJNTFcnAj3/BJE4sClzmC
 DOz7IkdSyvyCDGDlxKEHPUpupqoqLamvoFp/Vsb+OleWC81yCxuYQOtoBR2yk5jBelT5
 kqth25NFs9d8r43FzsPcnAt1EvyuiNOEIYtJXki9she7maP/lRgqknks75oa+WyhhA5G
 aRP19AQaqeaSX+Z9P2wweGH9mWpFeYqpVdWMlBZAolrRBs1ed2ir31fiSqSo7bzD/O2o
 Rqx1pOWfMRqjI2/fUi0Q41DZGj3O3UKTPNxGaG+DalNNC+S/8V0CUP8oAk2H8LIvrrVH
 U6SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539989; x=1770144789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VQjHMvx3XPpUkrdVwOgSZF1RvbP7lisB8RqoyBnK7Q4=;
 b=Mm3wrgsx/tFoSunPBxj98kdE+bVM5lGu6CY492QF3+Kw09SGbIwybuVRlkN09kxGmY
 MXN0E5UGN9gGiOY1kK9P7uO33PRX5U3FNJAqRIwnzt/FNf6dmeW9sZTmyWa3QZW2jQNw
 p7y8G/+GAj6854CsaLUeMZtBp/DijK+gs3ICXb7m5cUDkbICbv2Rr6gxilLV+5bJVBDo
 6g1miMUMXhBZtfOH00VHoR+Hs+pTlwqn0IPI/Ic6AnAlfjJ7DsDDt5vdwR/CaL0doi0a
 HaiZifhcU2bz5xo67KRAumFauLG+VAOAkQU/f5K4pJPXQOBhcyMUcGDyR/oCqE5C/+bg
 sXxQ==
X-Gm-Message-State: AOJu0YzjpWnA+42gDLJJzZLSqAisaxXFBiAb+PJ170e/xRqpJpxB3eI7
 vq3XnFWAglTiFDFgVd/eXv/GVgDa1KmJQPc/Wg9sbab5UvKcGXwFbALwKvmi62jLozGmYJ1mmYA
 F3QWQHjHwUOcQbBxtPUIbwPnB+FQa9WkWQt8uk/bNX2GAsRlkkmoh0ybgWO45VpYHeAp4+QI43i
 7c+0fNMyXI/RlAJ7ldZvUsqeHuSJmc3upED7JASQ==
X-Gm-Gg: AZuq6aJEGgwQBaAXXnONgFLdB8VJJ14hCjKL+Fq9iod9BSqNMY9GiprQ6SYS3cCIz5y
 f8Hy9+jOrvs688snJ3QE4r4aKPTzUFhRU2N+FnzKXiMU3v9I07Bs027b6NzJ4watbxEV8bX1HYU
 WofXCXIJHQHNgRkUoIIm+yuKU1kH0415VtwhUdAcfbdMcWZVUoIn+JiGvivypL/7Hl3dkOGLB7H
 +mVAAOnciq2tBHMVdw5wj8j/i9lzqxCZ0t4OEi81oCNx1NWo8/IGVIHytxzOf/RhlwP66UymZPl
 vj4fcZobGl0nWtRfmlTT9JRzaqXQv5YYNyJJHOFCzgAhHg5XHcxkVAQdp+d9k17fwz+lOVGzJGU
 R
X-Received: by 2002:ac8:7d03:0:b0:4f3:58e6:6246 with SMTP id
 d75a77b69052e-5032f9fcc9dmr35501731cf.58.1769539988638; 
 Tue, 27 Jan 2026 10:53:08 -0800 (PST)
X-Received: by 2002:ac8:7d03:0:b0:4f3:58e6:6246 with SMTP id
 d75a77b69052e-5032f9fcc9dmr35501471cf.58.1769539988165; 
 Tue, 27 Jan 2026 10:53:08 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.53.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:53:07 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 10/24] migration: Drop iterable_only in
 qemu_savevm_state_complete_precopy
Date: Tue, 27 Jan 2026 13:52:40 -0500
Message-ID: <20260127185254.3954634-11-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260127185254.3954634-1-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Reviewed-by: Fabiano Rosas <farosas@suse.de>
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
index b103a82fc0..e3f1cc7b2e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2752,7 +2752,7 @@ static int migration_completion_precopy(MigrationState *s)
         goto out_unlock;
     }
 
-    ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false);
+    ret = qemu_savevm_state_complete_precopy(s->to_dst_file);
 out_unlock:
     bql_unlock();
     return ret;
diff --git a/migration/savevm.c b/migration/savevm.c
index d41be3a4a2..da9a60c73f 100644
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
@@ -1830,7 +1828,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
 
     ret = qemu_file_get_error(f);
     if (ret == 0) {
-        qemu_savevm_state_complete_precopy(f, false);
+        qemu_savevm_state_complete_precopy(f);
         ret = qemu_file_get_error(f);
     }
     if (ret != 0) {
-- 
2.50.1


