Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B5710F9969
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYT4-0006Yj-BK; Wed, 08 Apr 2026 15:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAY49-0006LU-3u
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wAWCF-00026z-LJ
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 12:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775667366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hkkcDDKW3DzXc310oMI/NYDVD946MPATIpbxQ70/iE=;
 b=MRE5i90/LyoGKiisuNs0IgqmKtKECUnBp9vlz9QXsNiGMjuzIhn3qHCUGWMw/fbS9OZC58
 wxeyjv4DS38OGGyNuXKWxDAlKO6/Tuz95d+DIr/3BZXk8WlcKdhA5HGVMpKAj89igv6BV8
 LqQdIFO3y03iQtZwxqMsNW6E3IuSdgw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-oxB8IKRKMsSI7OsPv4PnRA-1; Wed, 08 Apr 2026 12:56:05 -0400
X-MC-Unique: oxB8IKRKMsSI7OsPv4PnRA-1
X-Mimecast-MFC-AGG-ID: oxB8IKRKMsSI7OsPv4PnRA_1775667364
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8e4c29caso3423151cf.0
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775667364; x=1776272164; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hkkcDDKW3DzXc310oMI/NYDVD946MPATIpbxQ70/iE=;
 b=G8wKDi1x5gzg3mdzxnkHCPbmoXL6vac8kKTnVdoyEPaq0weB2D1z1zpvDv0kSsRHo/
 aViV98n1aoyzoEEdn8xhvKghQoy3Dy2cCUfL8tmXFlgv7Dvx89ZI8KK5r4x5mo3Ejznc
 uUHwAZTEyLR6gE/1LBgcMuDHTO5A1yyi0OdjAfili9mdXeCtzljszm89bK7G2nZHBUDF
 MJoVaTt1tYwF0o22OKs1i0qBwSsJwTLaClGP495BqRt8ECsGBQLlpWY5M2mytaxWmqMx
 VLLUqdUmVAG96exup1aRLtwvKtBMPUw7CrqvuwGEv9eaItw6lA5FHo0iM5rdygfTLf0t
 vNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775667364; x=1776272164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2hkkcDDKW3DzXc310oMI/NYDVD946MPATIpbxQ70/iE=;
 b=K+jd0KjKR95w2+IQHPE8TTy0I2QZiMLggApZyIV3A6Hxzw/bYciWl6auIZVlzmqwe/
 aIhdlYfjRH1DrtcBp994hh1hl1xyCMFabMKHtzPFG45Vwl/LD5fvz0t1Rj4QVUdiFwsf
 2xgS+PkJ9cFXBM9WFWO5cucXHkyfDYKvNUetdsVDFNHjqWHzQ8sGIg6ZkSkDzX061JOH
 8YfJ1NZJX/bXodxwzZFnjoK3yq/9fsvRLW5xQq0s+6d2vjsSz9R4wjH/rjiwXwAIXeeg
 awoOVkn22HxgUZobnCmqNMbHcTsFsal2b4qlGxk1ibA9Luv5Hc7kB1lP+bXwE3MqfeIo
 WTRQ==
X-Gm-Message-State: AOJu0Yzf7sOLtVSSeTDSW4i1lj/AwUtm1MpxQcQEHS1R1QOi5uTvKvSv
 02qxj7OVVnlfVfGRs+V5TA5wwJgmK+g4BDKnMWwk8YpspERCrK0bxDQ6+JdS2b4BFQh3/fqYdy0
 MIKfTuK2swBkT2QBlV5gGlxmbYo18agR62nD+15vhB8CeM1IAHtQa7uR4LYAsXWRdKLmZhIIvnl
 KX6EVbcE/gHkTtsXLxa81sMODkE1y2buusoywLhw==
X-Gm-Gg: AeBDietcodyWfntBSgYqzsJx0E1CwsLHyjzZv9i6aKZe+XHH5EUl7RSRK6SRYm8SruU
 He0HeqtpvO0tGLteJrcui3Ijj/JY5EuxE8M392BTcq5+CTr87SJj+fxZJsbd7Q/jqvfSMRuUhMU
 2JHm9DsgeMjPT0aqub1i1TuWW6yGatjP7kaduvj/59qVdw64FCFUXubp8FCCyX4XvXcJgLNTK/T
 mKux3JENDQJQK017FLb7AZv3Q9LPvM1D/kpCoDFNS4na9rdI3Q2HKL9zBmKeLcKH8ZJrB6LSNO1
 AuX0fvLvDDXQhy/QuxUX7Hgj4BemBmvoW8b0ytrxSZYYYJE9VsiaTRD8XqABzn8yPVNgO2S71IT
 vQekogn4Fe/s4GVLBV0GpzMMaZZDPTl8B+SeP5Anewv4I
X-Received: by 2002:ac8:5f4f:0:b0:50d:a8f5:d519 with SMTP id
 d75a77b69052e-50da8f5de93mr92568191cf.14.1775667363724; 
 Wed, 08 Apr 2026 09:56:03 -0700 (PDT)
X-Received: by 2002:ac8:5f4f:0:b0:50d:a8f5:d519 with SMTP id
 d75a77b69052e-50da8f5de93mr92567241cf.14.1775667362810; 
 Wed, 08 Apr 2026 09:56:02 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50d712c2617sm130491901cf.31.2026.04.08.09.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 09:56:02 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Peter Xu <peterx@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>,
 qemu-stable@nongnu.org
Subject: [PATCH 01/14] migration: Fix low possibility downtime violation
Date: Wed,  8 Apr 2026 12:55:45 -0400
Message-ID: <20260408165559.157108-2-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408165559.157108-1-peterx@redhat.com>
References: <20260408165559.157108-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
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
2.53.0


