Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99FE5CCA471
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 15:55:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4huu-0005Qz-Tn; Fri, 03 Oct 2025 11:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4huR-00059o-5q
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v4htn-0007iJ-AJ
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 11:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759506039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EIS9N+XTk5tx/u2RxErgwY85wLlsKRuBFzwmKgR6xeg=;
 b=Lz2m9KfJTuEExhnlVrm9uFA/khmoFGEI237SxrnWolrcSQAyuqDCLRd755z6OebQfpe6Yl
 4VOV5QWeOk6JUPYzjp4GhXmHZtUF0anr1Ai6fEdLOIIFwc+8Gkl4s3JbLpgUJ68Cvs2ARA
 yZGqSiewyh0dTiUHkYsWjw6tnK+jyng=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-FblRs309MB25MkU1wQiuCQ-1; Fri, 03 Oct 2025 11:40:37 -0400
X-MC-Unique: FblRs309MB25MkU1wQiuCQ-1
X-Mimecast-MFC-AGG-ID: FblRs309MB25MkU1wQiuCQ_1759506037
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-818bf399f8aso58418826d6.2
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 08:40:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759506037; x=1760110837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EIS9N+XTk5tx/u2RxErgwY85wLlsKRuBFzwmKgR6xeg=;
 b=TCSAkSAX4qlmohdgnNwaHVwgTO7xiCa3iXig/TY89ghR1JJJGsvzTw3vWT+AcGrif9
 MlK8mMLpeOorYgmV8cKBBp7bSayl6E1BvDjxjwVzYj9sZq4Pr2vohdDY1TUriN+EV36S
 e1UJP6Fl9eHUWddf8JQUFwljdQAOMSfUw1AapxKFa8f6S5Rs7zlnAMhzzWMfGlb2RbU1
 Hp66WrFuY3fr7POdlyGflcaL2JlSrxCRnVBn3rKBTf12SgYUKIK47sK7s2jDf26ayUc1
 Skhf9T7X0FrrIlGsklPqJUdpAFOEBPa2FCiYMLXnNpt9orBwnyyEFCjha6jkTVx0atMw
 DIyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9ZtX+yQWEijfw8p3kpcuuLHdir7peC5vf28MM6V5ZkRzW8TqwcePaupBIlPGi/U0/+AG5Gdb3bLRy@nongnu.org
X-Gm-Message-State: AOJu0Yz+T3kYKLFDEemXUO92Tx2l8HUIcpI7k0b8aX7NGp5g5apGVip2
 2tLALVBaATJmadnevAc7u/6X+w/O08G0vUlNEU3eN4HjKLeOB0mrCSzAk25G0o7cbv95Lxyy2lO
 REwXwi1YmYbjUsHToKa7G+J97w9X4DelMBgiD7V+0k5lz9bJcB95uWbkJ
X-Gm-Gg: ASbGncuVx5B+z5kgmgqKCzTuiXfES24gFOmQ0T1LrB9C/Zox/lG0GHjSc15ZeMYGDPH
 8NMTFLCVH0GsyOgppSna0BvaMUBPOd/Ym+7u1gn9ZsDtuftQgML9Dg1/WgehGleF89fLbwTgw10
 7fGKlXL1b0GYGd2YBXYgVOdB5AMfOc0Zjg1ErnpaoNicyd6v70sD02pPV9hwciC7tvQwm3NM55b
 Vdx4Qi+RRNKF23GROn0UUcmrkwkZWYRRAHfHGWbaoJ3voYdYeycGjyPFMQX+6GTOC4VjKG+iqNj
 jy9giDwQ/vLqum5diooAWL01OSijxA+zUa5+Nw==
X-Received: by 2002:a05:6214:19e6:b0:798:513e:3bd with SMTP id
 6a1803df08f44-879dc77bdb2mr40634596d6.3.1759506036712; 
 Fri, 03 Oct 2025 08:40:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFO7mmbdlmbgtMnfgHUOmK/rO89vVScq2mTnmB/DglrZ4aX9KtpYAn9RtfGEMIYc9bbOFO6Ug==
X-Received: by 2002:a05:6214:19e6:b0:798:513e:3bd with SMTP id
 6a1803df08f44-879dc77bdb2mr40634156d6.3.1759506036104; 
 Fri, 03 Oct 2025 08:40:36 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb53d91fsm40656746d6.23.2025.10.03.08.40.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 08:40:35 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>, qemu-stable@nongnu.org
Subject: [PULL 31/45] migration: Fix state transition in postcopy_start()
 error handling
Date: Fri,  3 Oct 2025 11:39:34 -0400
Message-ID: <20251003153948.1304776-32-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251003153948.1304776-1-peterx@redhat.com>
References: <20251003153948.1304776-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

From: Juraj Marcin <jmarcin@redhat.com>

Commit 48814111366b ("migration: Always set DEVICE state") introduced
DEVICE state to postcopy, which moved the actual state transition that
leads to POSTCOPY_ACTIVE.

However, the error handling part of the postcopy_start() function still
expects the state POSTCOPY_ACTIVE, but depending on where an error
happens, now the state can be either ACTIVE, DEVICE or CANCELLING, but
never POSTCOPY_ACTIVE, as this transition now happens just before a
successful return from the function.

Instead, accept any state except CANCELLING when transitioning to FAILED
state.

Cc: qemu-stable@nongnu.org
Fixes: 48814111366b ("migration: Always set DEVICE state")
Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20250826115145.871272-1-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3ff85098d5..edb8ff0d46 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2878,8 +2878,9 @@ static int postcopy_start(MigrationState *ms, Error **errp)
 fail_closefb:
     qemu_fclose(fb);
 fail:
-    migrate_set_state(&ms->state, MIGRATION_STATUS_POSTCOPY_ACTIVE,
-                          MIGRATION_STATUS_FAILED);
+    if (ms->state != MIGRATION_STATUS_CANCELLING) {
+        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
+    }
     migration_block_activate(NULL);
     migration_call_notifiers(ms, MIG_EVENT_PRECOPY_FAILED, NULL);
     bql_unlock();
-- 
2.50.1


