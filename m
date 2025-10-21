Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00663CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 22:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBKSs-0003pe-5z; Tue, 21 Oct 2025 18:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBKSp-0003p9-Lu
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vBKSn-0001KM-Mf
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 18:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761084256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v2vPYC2fE8GpivztwCqYqJ3Uox9D4sCeEMiTNLY9Snk=;
 b=ib6469JCkQYQZajTbWHMGtpdVHNYelmXE8nd/R5EUUK6RqYk4txZC0Qw3Erdl6q9S2B2gN
 WYAQt8j6Q/N8Qp3L3llfpy4OHlwMQSC/o18uYV+hLN+JZ4AyewfYKYVpaar64wR0AKO4iA
 T0KcmPt8uGKeS1VdNlp8bou8qQMNp50=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-DL-xZkPwOCOnlbJCK9WS8A-1; Tue, 21 Oct 2025 18:04:14 -0400
X-MC-Unique: DL-xZkPwOCOnlbJCK9WS8A-1
X-Mimecast-MFC-AGG-ID: DL-xZkPwOCOnlbJCK9WS8A_1761084253
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-85dd8633b1bso100525185a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 15:04:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761084253; x=1761689053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=v2vPYC2fE8GpivztwCqYqJ3Uox9D4sCeEMiTNLY9Snk=;
 b=GjQchjdS85qE734gkTmshVW2CMyrlBi+euWFANFKqXldHMd2Kx7K+vsvI+FobFVhHg
 0TanroofER6W8hcijSRpjpAdfFkKo3IKj+TE7UVyttV19AZAKfEjb4FSZcbtc+RpwJ4J
 owY3I+pINyDB11mx7kYY+ScA+UrvSHirpKAtPlKAs/lujettwjXJP8LCCqNE6ywmiMHA
 jH89SQpzQYHMqeWnDYHEuXZRkaGWpdHkeI4aNMmJqdoN+ZyitulwxEngmdDOO4OneVWW
 d2+GoWI5Bdpqo0MgHqPu/5XobvsfUNSPf94LpqS5aVYZGz1Rg3pNO5SBypO6vnRPAI5H
 sKBw==
X-Gm-Message-State: AOJu0Yz6dz4OCaMM8pnpcrZlBFYMoaXvLr/EVOlqD7gwPur/Xjjys53o
 KoTuuQeHnZwwRAuR6z/B8b4KKEGIj5d7h2kFZdqdGvX40Hh8W0keVTj6suTLbROMne7kgfCaZz0
 CNFRxMzWgRX/2KlVi62QFqUvUEDx4ir4Q+DyBVG9pN3nUDWP0Fmz6UnWNG69yVYYMFF+GKi4Oqa
 +ZMeGB2l7D1M63MVvpCPHYnF4A1H4gbzfZYIg5vw==
X-Gm-Gg: ASbGncvznhjzuZmhEPTRIXsHp5kEwcsPDxB7CqjvIIfkAzlOjWoGErjQ76ILWoYT12t
 b1BWpUVFFbaAK1nrCQXkzDSCan3eTl8z2RQ/FFy0F/VbRNGIfLNwWvsfBsBQYlhA8YfTDe4cyFY
 KPw0Upv6O4S7/Id8OIQHnm2fp1FwxkdpbbKYiOm3M4qwtecb4yadNuT1myEYvUxBPcjQgGi1sFv
 caXzgXuUAT0FLoX+WCJzO0FP3BSNr5+3B1xyxMlvt8KgrwcYVD/Eo6yblaWklAv5fr0YW8quFh7
 wV6Cdl/sTn05I9vg01fqk3fJ3pdx54jRnwn1ro71JNskRW2WanbA2jS54aKYZAo1
X-Received: by 2002:a05:620a:2699:b0:850:78b7:f878 with SMTP id
 af79cd13be357-899d6d64c4cmr179025985a.0.1761084252873; 
 Tue, 21 Oct 2025 15:04:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwW2abgfFamvG8IFlZPryfrETn5zm5g84CSPTTR46WLq9o2TwWJL0u4/N8VxkTr3tntqSYkw==
X-Received: by 2002:a05:620a:2699:b0:850:78b7:f878 with SMTP id
 af79cd13be357-899d6d64c4cmr179020685a.0.1761084252313; 
 Tue, 21 Oct 2025 15:04:12 -0700 (PDT)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-891cd098edasm849197285a.19.2025.10.21.15.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Oct 2025 15:04:11 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Arun Menon <armenon@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 1/4] migration: Fix error leak in
 postcopy_ram_listen_thread()
Date: Tue, 21 Oct 2025 18:04:04 -0400
Message-ID: <20251021220407.2662288-2-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021220407.2662288-1-peterx@redhat.com>
References: <20251021220407.2662288-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As reported and analyzed by Peter:

https://lore.kernel.org/r/CAFEAcA9otBWtR7rPQ0Y9aBm+7ZWJzd4VWpXrAmGr8XspPn+zpw@mail.gmail.com

Fix it by freeing the error.  When at it, always reset the local_err
pointer in both paths.

Cc: Arun Menon <armenon@redhat.com>
Resolves: Coverity CID 1641390
Fixes: 94272d9b45 ("migration: Capture error in postcopy_ram_listen_thread()")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index aafa40d779..232cae090b 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2136,17 +2136,18 @@ static void *postcopy_ram_listen_thread(void *opaque)
         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
             !migrate_postcopy_ram() && migrate_dirty_bitmaps())
         {
-            error_report("%s: loadvm failed during postcopy: %d. All states "
+            error_report("%s: loadvm failed during postcopy: %d: %s. All states "
                          "are migrated except dirty bitmaps. Some dirty "
                          "bitmaps may be lost, and present migrated dirty "
                          "bitmaps are correctly migrated and valid.",
-                         __func__, load_res);
+                         __func__, load_res, error_get_pretty(local_err));
+            g_clear_pointer(&local_err, error_free);
             load_res = 0; /* prevent further exit() */
         } else {
             error_prepend(&local_err,
                           "loadvm failed during postcopy: %d: ", load_res);
             migrate_set_error(migr, local_err);
-            error_report_err(local_err);
+            g_clear_pointer(&local_err, error_report_err);
             migrate_set_state(&mis->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
                                            MIGRATION_STATUS_FAILED);
         }
-- 
2.50.1


