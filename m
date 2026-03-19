Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEF131091930
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MYH-0001Lw-HO; Thu, 19 Mar 2026 19:13:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYF-0001Ks-Et
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1w3MYC-0001Oc-Jm
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773961991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fZkKChfolbOCjcYtzW/j8UchHmlgfocdKxXn+D4VI3U=;
 b=UkZy+34WyN6XK472kkWSqo1ha0wbSE0Vdn5hG3f0nqy45PRuA5dgWLo4UUk3Cy72uo8x8q
 R6O8z2t/gr9BbWZ+9mfXiBEd8lGVDHWNZuNCgf/KpAVc4TyOKB4xpjXUYrQ+z/zyM2s/ib
 L9W8fR6OMB9wEvpjGwNRaZEPZnXUR7o=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-232-sK9PT_VeMEys0EfKrufeTg-1; Thu, 19 Mar 2026 19:13:10 -0400
X-MC-Unique: sK9PT_VeMEys0EfKrufeTg-1
X-Mimecast-MFC-AGG-ID: sK9PT_VeMEys0EfKrufeTg_1773961990
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b274f94f8so85628311cf.1
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773961989; x=1774566789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fZkKChfolbOCjcYtzW/j8UchHmlgfocdKxXn+D4VI3U=;
 b=Xx1Rrqz/YcXCXGowT42t2OEfy2TjbgUYVSz1xFLyl/NyO4w1qYrj0yQUDNYtr9lwT8
 siNAYGz2Is5SVip6wW2BaplPq3JxBbAKheh967JLrz5BxTIhY7bF1IIHgVyXc2COY6TL
 JOncZI5W7/TzzMxPiY1pCyA7XvdqfrRVK/j8zUFqaYeg4qAa/ksXOZM6dyrfGIRU24qd
 jRqg8aXT/4SMoHano5gSj+sUMVw3+sTC5FEyxxDsVZroWn2ijd3JjRTUXTOJ4FORL1Bg
 JpV7IxYLFkzVob1TiuhcZtV4dvfVsqvUn7zZQLNiLLOEh7HpkMlNCm0Yp26bBRjv4HHS
 vpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773961989; x=1774566789;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fZkKChfolbOCjcYtzW/j8UchHmlgfocdKxXn+D4VI3U=;
 b=cBdw6Vdue4lGy19Kklq2TFBr2+1o9mctuxMm9uKSfs/kS+AzNqZFiSMv1zE727nHEe
 IPK9JdvIZ2ZL50wC1fcSBLwqrHO04R9NTfkZ08BBf075QfoimFa/6i5akk8zx4JeRjOX
 cqC9ObnHB1dETa5s8eyKV+jh7Kt15CrXo94JqjM0XPLHlg7FgKFBh4Q1IDsTJM0YS5+P
 df0vUMo679DNwuqLWvp96mnFzTC6dfj0n3OOWX3EGkH6BMtqaaK/0iGLiV0Q2GrjJTH4
 hllGv0ERVQQqOr0SsjoiYtJxA9/HVqmUoHapeUQkzOGv+vvdBbgsVwfnYNH+2f9IVY0V
 hqLQ==
X-Gm-Message-State: AOJu0YwhNPn7ZinkmEO7TZ4sbDf2i6U+3i/jcbgTq1Wnrn5T7vw/0lLJ
 XbJTIh/0TVX44R1NgYzmWdkuU9q12OBCvneC9JyWqUL/n0T7ETjDNC4WQyESC/m4TBflRbEPpUM
 LcRKeCu72I13Pvna4D8bbFe/K9dsKuWt5uAP/0d0yHE61GBIJO6Wfln311iEtM/4DGOo2o2uXel
 r83psPNWVUHVOyPRH9L56A7F2zwaIHeQhZv36N1A==
X-Gm-Gg: ATEYQzysoWyQacYRUPFdG5ZiujtGVwcBD13NtQspntUvOYs7SV7Aop8roN9BMD8QdKB
 nhTcuSxmmjbOZSE1c5pyvgxUVHcrzErlc0FxnAKYBtM5Fp1jYab9X+Uq9vcI7QKIxTvoy1PrQ3k
 0hIRCjJ8sm59JiTlik7bU9un2Hx8U/df8nG+Sl53gs7tddBe0P/eak7AbiYFUwXNCLo6sW7INxe
 8pYK83+Rfgr8m1zUnqEGaYk+ZHzyxYN3d2FE/8YG1j77nCaJuozGAv+OEUappO5mmrGxfm+uOLb
 b0fCqRU1uq3VK4yBJM3Hea+4XpbbW3ScFdzvh2JRZJg89mLtG4gnodobSc+oopGvEKCLM7JoyXj
 WyJkpSYh7ATk1RA==
X-Received: by 2002:a05:622a:5c17:b0:50b:36b6:d84d with SMTP id
 d75a77b69052e-50b3715666fmr17221191cf.26.1773961989512; 
 Thu, 19 Mar 2026 16:13:09 -0700 (PDT)
X-Received: by 2002:a05:622a:5c17:b0:50b:36b6:d84d with SMTP id
 d75a77b69052e-50b3715666fmr17220691cf.26.1773961988965; 
 Thu, 19 Mar 2026 16:13:08 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50b36e5bee3sm6717161cf.21.2026.03.19.16.13.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Mar 2026 16:13:06 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>,
 Alex Williamson <alex@shazbot.org>, Yishai Hadas <yishaih@nvidia.com>,
 Fabiano Rosas <farosas@suse.de>, Pranav Tyagi <prtyagi@redhat.com>,
 peterx@redhat.com, Zhiyi Guo <zhguo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH RFC 01/12] migration: Fix low possibility downtime violation
Date: Thu, 19 Mar 2026 19:12:51 -0400
Message-ID: <20260319231302.123135-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260319231302.123135-1-peterx@redhat.com>
References: <20260319231302.123135-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When QEMU queried the estimated version of pending data and thinks it's
ready to converge, it'll send another accurate query to make sure of it.
It is needed to make sure we collect the latest reports and that equation
still holds true.

However we missed one tiny little difference here on "<" v.s. "<=" when
comparing pending_size (A) to threshold_size (B)..

QEMU src only re-query if A<B, but will kickoff switchover if A<=B.

I think it means it is possible to happen if A (as an estimate only so far)
accidentally equals to B, then re-query won't happen and switchover will
proceed without considering new dirtied data.

It turns out it was an accident in my commit 7aaa1fc072 when refactoring
the code around.  Fix this by using the same equation in both places.

Fixes: 7aaa1fc072 ("migration: Rewrite the migration complete detect logic")
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5c9aaa6e58..dfc60372cf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3242,7 +3242,7 @@ static MigIterateState migration_iteration_run(MigrationState *s)
          * postcopy started, so ESTIMATE should always match with EXACT
          * during postcopy phase.
          */
-        if (pending_size < s->threshold_size) {
+        if (pending_size <= s->threshold_size) {
             qemu_savevm_state_pending_exact(&must_precopy, &can_postcopy);
             pending_size = must_precopy + can_postcopy;
             trace_migrate_pending_exact(pending_size, must_precopy,
-- 
2.50.1


