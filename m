Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55964F94CAC
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2026 20:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFHb9-0000x0-4F; Tue, 21 Apr 2026 16:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHb0-0000vW-Bh
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFHay-0008IH-N7
 for qemu-devel@nongnu.org; Tue, 21 Apr 2026 16:21:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776802879;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2hkkcDDKW3DzXc310oMI/NYDVD946MPATIpbxQ70/iE=;
 b=I64mFfm2NhYimuit7PBty3Yux1CmDXyjbf3OfZWdfK1axQFh2134m4NXDRVLa1sADE8iy8
 Meuo7FUjlaVkZ/4H7tvuSE5mXzzX4ju9ZW2tKTRnVQFWYUIIpngQC4OF0p24TOQPzN+k4o
 +7KepSYETuv3QSK34Qstuny7YSraknc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-Zn9IZhzwOb6zkH5X5QCoeQ-1; Tue, 21 Apr 2026 16:21:17 -0400
X-MC-Unique: Zn9IZhzwOb6zkH5X5QCoeQ-1
X-Mimecast-MFC-AGG-ID: Zn9IZhzwOb6zkH5X5QCoeQ_1776802877
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8aca154e2b5so18593926d6.2
 for <qemu-devel@nongnu.org>; Tue, 21 Apr 2026 13:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776802877; x=1777407677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hkkcDDKW3DzXc310oMI/NYDVD946MPATIpbxQ70/iE=;
 b=gTimU4MTOAK1KNjU+wq6P8yYCt7XWcoPFwJG+IC0oBMFoQvJ/3ERbKgguByB6QTVzZ
 DMRxMXhQ2Vqq9bvr6YFDh0LnMQNBbE/cLjCEtP0NsW19G2O+xR7RgxhzjIXoPNuBI3T3
 iOCgenPa3SBxozWx72idLFwtdNRwUlElWVtg0aM+SCgvwCs/rRzZn6e5R5p2EopPzkt1
 UApQ0xVXmTuHbjeMIOrEjydOx6nti0Slpnlw/eXpVQj9meDV7DcvP1hVooJ3/iz/3irv
 9id7RPoca0UTcuiaWF11S9/W6gZp+6I/PSkhm91lEISC/M8VagJbwbQGLC+M7qIl5jBD
 5/WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776802877; x=1777407677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2hkkcDDKW3DzXc310oMI/NYDVD946MPATIpbxQ70/iE=;
 b=BCRdIDxgc2Kl7SLxIEpTKw0dwdj3j89HmM/axqQ5vPM7M8YZ5awqBwOFx5HPtxYnf5
 tvCvv6NDqoyv1b7hJ0YfcVGMdQNm4oaM2/FvF9GSajO1FRWn4czhyjav08SfmqAuSMXY
 oadzvDQgW1nVfcoBgObTVAVxtaPHB3xQiu7jhI7Q/yvumVNpDWo+82QV8n0SGo4PiyBB
 1NH/BtnbCBCziw6ZXmMo1W0FeD1mw4GfUYORmGBHG8R5G+3Xh7ZgVd4cVU3ADiSoT20W
 PChcUi0aTKG/wuv2rWstV9PMqCQC5Ac+oSiUYYewu4nPt24EQYbN15/88fDOhuuLOPhs
 uiwg==
X-Gm-Message-State: AOJu0YzzZXE8epNQe/aKeJwQYwWPIscLVVoX7or6i3usj9vHY49e5zvv
 KWOe0fb5Zc/dKD75LEl2Ev2oI7sA7inD8wrjtqApgJQKScBN7iv7X6VbDuZmVodo6hKdEpOnlUN
 tDpMCeZ5rYD2ZX/eB6GBUmiQyaM/8Jase72HgbBuSFUui/gDyqmTzWO3OgLQkKqmlYqIiDEROt9
 xlfFK7OBESXPTmppoVmKLPaWtMKXdBXNUizQUZLQ==
X-Gm-Gg: AeBDiesCEvvlHRQVF3tvGi2uD/vM6xZNWl1TVIx/hojaRkyhtw2DzrKrTxzDr/ZOBGv
 gg2gry/UembiqbfeQGYeuukXZyg5N9rw/puEqaR2T/73pQjSIU7ri0aQ1B2VpaVh9aYtJ3BRW20
 m9HD6wJ47kpHLCzLXY9QVeyfSvufGRlitELccACg1Egfd1Jua9HULOXqN0GgvtcRuPdsKyPYazi
 2nMWV4Rdv0zAh4j6b4RMc2wnVjGnKMXmB/cvVKvQEd8uGJr4/34W1ZJylyWJe+1nzZN5/IJf2XL
 z2uupCLSO6FkK9sY1JWUfkqvx8wCN+xqMyRuzR9ekbFn++RgWSUlR0RwHxqrogfMl/Pgc3bC0sh
 j6rnRJ86nppmXiBYtQ749sW6yDl0218lr5boSO/gZ8ljc66yl9Ib24j80mg==
X-Received: by 2002:a05:6214:19e7:b0:8b0:2dc3:31a7 with SMTP id
 6a1803df08f44-8b02dc3346emr327435866d6.30.1776802876839; 
 Tue, 21 Apr 2026 13:21:16 -0700 (PDT)
X-Received: by 2002:a05:6214:19e7:b0:8b0:2dc3:31a7 with SMTP id
 6a1803df08f44-8b02dc3346emr327434886d6.30.1776802876061; 
 Tue, 21 Apr 2026 13:21:16 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae5c26csm114343556d6.31.2026.04.21.13.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 13:21:15 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Kirti Wankhede <kwankhede@nvidia.com>,
 Zhiyi Guo <zhguo@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 02/16] migration: Fix low possibility downtime violation
Date: Tue, 21 Apr 2026 16:20:56 -0400
Message-ID: <20260421202110.306051-3-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421202110.306051-1-peterx@redhat.com>
References: <20260421202110.306051-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


