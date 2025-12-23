Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BA6DE6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3Py-0002SS-GW; Tue, 23 Dec 2025 09:31:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P6-00016C-9Y
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3P2-0003kD-UN
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500220;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3jI5kulKRQefdFP90vbsqSgk1iSh74hQlPxeDrABO+I=;
 b=c1S1l1X7pwa2RS94Qgb1ORDy3qleUCWwx6mNsnzHl3segSqtFUAbOEohAxBLpnr6LnpxcH
 nfXKEPhxutIee9Nabzs7yK3d61BCR2UZ2kv4MtC3Xy1HnmEmfAjyHKV6YMRFwZih8crgZE
 RvIywpICCVO1PMXmqgdWOkoBbmi1BYE=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-K8UldiytMQCo4iSWGBnA6g-1; Tue, 23 Dec 2025 09:30:18 -0500
X-MC-Unique: K8UldiytMQCo4iSWGBnA6g-1
X-Mimecast-MFC-AGG-ID: K8UldiytMQCo4iSWGBnA6g_1766500218
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8bb3388703dso1752651385a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500217; x=1767105017; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jI5kulKRQefdFP90vbsqSgk1iSh74hQlPxeDrABO+I=;
 b=ccQf/qW/Op4RxKQt0GoZ5fmscG2cJdv2LHkaVzrSemCp3zyMp1aNws/SXfqdQlSQB1
 xgPAc1klSdZIZT2q0rvxINMJkET2na1pvRdV7nNsxjEUQ0g0y73cdyMRcvcVkDimR5Xm
 SgJb3I974FYrkNP9cpo90lR6uYLTjztIgduuaRuRJGnixHL530rC5YhzPaIViL7Eg6WE
 uJms0rAPqVXYU0VhveI5P5+QUoTlDMbhQq3Ae1Wg2s7rJ9tuyGH8VHrJyzX2BLKaOYMo
 vKwXjIa588XbzrxvbSRVA9g6d/7r+MegWPv45aVgP7HnJ4weLMhFvzg2v1NzsBVMKNCF
 2wOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500217; x=1767105017;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3jI5kulKRQefdFP90vbsqSgk1iSh74hQlPxeDrABO+I=;
 b=loRetHDCbx/1PwNTEWv/soHTg/yYfqh9JZI8hbja4T/lsZIr59aCZvXU4lpDnsLvHy
 F+wWyW+Itm6KEvXmvD/JolsuC0hCtgVi04GR3k5n6TsagTVnzAV+etvtuNOxoc/AqAhh
 tCrQ+IEdj/eb/gc8eGQw9VMBpdXr12cv/5PDm5zRDVpihy6N634eO0mgRVT0jBJCaplW
 WF28IOlU5FhiGC4VJPpvRXcsvLk5YO9FJD0V/UuPF9zyOLqeXTpgLDWGVu+UpwVFbA0i
 iyznrxJV1AClIdB/eNlnX+cSpJnbEFPt3aJPWNYcqKeUPrjtENgjzroG0tNL5Qy1B2uf
 nRbg==
X-Gm-Message-State: AOJu0Yy6KmmCcAC7EsB0MXYlKPyyp1UaYzIfZxsTVamvkuMO/qe9ocjd
 gVsUbj459a9us1L6lxohtMuWm7cPdKtTlMzFKw60chVixAwwJk0G0V1Y2OCUyNRhqRqRbfdvGYp
 rNZQFw5AwjVuCrTu4C/hjj3FhkcLfoLGqFVbL0Ic27iDdJINsyjT4leXg0T+RCeV2duwVyRcsmH
 M6x4K6D5wgLgvuEIhKRqMMjbcYbVuof39iY/f6Sg==
X-Gm-Gg: AY/fxX6/RKHEbogRBpt+oIja/Zw+HYiebYYEKt54L7clzYM8Tccelw4TyvvQVUU0Vf1
 RTVyR+r8WJ3jF1Dm/mb0qtyvtgzmw609uHK2xVvA8qMGCwgDKEOMrRCgR2aKrNzgxaM1dyjaC0B
 8uGmd58i3wAX7PJGHcdhkb3RaC4Pg2g7TpJCJMeJjcLzz1sfeWE6GahOn+mjNeByDns3d8TxoTa
 CRvOb6VGs8fBLueEYki+rqP99S1M46JYyRuJdvAfCZUmmHnVBKwPoziSDsDHa2BFMvIQztKOB1o
 ahTIFv7DL7Yg8on9jkFJTuUa4yRGM6fG1StjduOwaRLPiCh0suX44iMUlmy3AfcCi9To6ZNLkMd
 00x0=
X-Received: by 2002:a05:620a:2682:b0:8b1:1585:2252 with SMTP id
 af79cd13be357-8c08f6568b5mr2019578385a.1.1766500217302; 
 Tue, 23 Dec 2025 06:30:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFz9k7yYeGnwI0plGbCQuTKEQuG3wqcKpZoLXfOyrJYBGh+FGc/9ud9bvREuj3ePfui4Ze/Ug==
X-Received: by 2002:a05:620a:2682:b0:8b1:1585:2252 with SMTP id
 af79cd13be357-8c08f6568b5mr2019568285a.1.1766500216576; 
 Tue, 23 Dec 2025 06:30:16 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:16 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 12/31] migration: Use error_propagate() in
 migrate_error_propagate()
Date: Tue, 23 Dec 2025 09:29:40 -0500
Message-ID: <20251223142959.1460293-13-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It improves readability, as suggested by Markus.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20251202175317.1186544-1-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 70813e5006..d55fde222a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1555,12 +1555,7 @@ void migrate_error_propagate(MigrationState *s, Error *error)
 {
     QEMU_LOCK_GUARD(&s->error_mutex);
     trace_migrate_error(error_get_pretty(error));
-
-    if (!s->error) {
-        s->error = error;
-    } else {
-        error_free(error);
-    }
+    error_propagate(&s->error, error);
 }
 
 bool migrate_has_error(MigrationState *s)
-- 
2.50.1


