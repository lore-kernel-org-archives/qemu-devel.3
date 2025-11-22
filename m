Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5FC3CFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcnB-0003Qp-Hq; Fri, 21 Nov 2025 20:52:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbVG-0007e6-UT
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:29:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTF-0003e0-FK
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771225;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SudVAchgZ3enzSuaz6qNw29hKeE4PlULQA5kP/QnNrU=;
 b=X1ElYhYOvCn5SKs4D0d6xa2tFYt7n8kb1UJ18NQEl/UlfSSWMx8lujXZvtjij4gJ8MDvUK
 9FUeRXhfPDI7LPWUuhk9otleR82VJclnddU7pSDG7j3iUBVQ2Nck3okE9HuLv+UBaLtMIZ
 e341PONIumJoqDpwoACSVaH936sWcW8=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-2f0ZQ3S1MR2VXIWDzXtGWA-1; Fri, 21 Nov 2025 19:27:03 -0500
X-MC-Unique: 2f0ZQ3S1MR2VXIWDzXtGWA-1
X-Mimecast-MFC-AGG-ID: 2f0ZQ3S1MR2VXIWDzXtGWA_1763771223
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b17194d321so339938785a.0
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763771223; x=1764376023; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SudVAchgZ3enzSuaz6qNw29hKeE4PlULQA5kP/QnNrU=;
 b=s8xU2/PxCB7tRO/2/HFnacGRqCYfXNaUChQWlhLhmDQXEAbLpq7xrW8w1B3HEf+WPx
 iTaPwW1uTACJQ/6R8O/LMpVUgCVGlf8Bq8oDDZX/DrJoy0AW/W+ZlB/GNufy1XVDLR2I
 pEIc2JOq2oQphWFfPb4wvxxVaN6xLzhKPXutk6ED6k3xING/6ey8WBzK2LvkRfi5JjeK
 9ZZxyg6K6oTDMRUeIqXUHp+DTbb8dNHgXv6qU2uQPVFDEvpgkPQydexPxshdeHpZ8O57
 WNBNGaEt62ccJ2oxQmVCadvdGbhyMkD3wqnfvubVnTTS+QDCCPDgkL43ok4ywTqlp3qW
 RmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771223; x=1764376023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SudVAchgZ3enzSuaz6qNw29hKeE4PlULQA5kP/QnNrU=;
 b=EpwBP0UOaS4+UfDYtdGNojNgGWUkHnwS0gskgy8Jne0gPAGK30T7NGi2KR4vOHOSZp
 KhgOsqJ5aUCF4uagvbpfZ3FQmnZW3j+4LpTsq/7ZZnlJWkcz1EOmQuqV8ZIHi83qKM0q
 jLIwW3RMMOs9vRZw457SNOY9GP6nMopxZ3hX8jXPZmFrbctI9elthWjsglRAW3qtHZsW
 b6bVrUZUnPnHEODKDMm9zqzV5G4GQWiMGqkgXkUDqT8DctqwAbltx58PuIKceQfBOolX
 wgLDSDYnv+YlI/tCxnsgJ0vgS3S+oWjjtW/mEl9pzTVSkh0ku3DEX3bC427KaDN1yxXY
 ro0g==
X-Gm-Message-State: AOJu0Yz1WdizQ21iBL4s+apOz1dGZ5GaNnNDs8Zhz6Dq7oz4S4xNiep9
 MpztJKFM4YtthhoKrQ+B3qDi2kPu/AxB1siEPLHbSNQLwiOq1lfBPxquNPBoyJ8zj9Ss5/8bNtX
 9bmdPYSr8CGW4ooOyZ0/pyMxQPo4XivTaKFhrkQwNJJs+jlzdUMsizYFBtBDnNdpaamVqTrdnqX
 sB7e0Lf6EnNpVxePnDizW39dmYeXId0tP6vJuPmw==
X-Gm-Gg: ASbGncuaXVJpisbslqv+atHYrYn1ckngpgQ0xKk8hh8mm271GvxxLYMJuEyP9tqqb3G
 xWoHZxj8Uf1EHh8y7fWY7fYwQ1dNUwpquoch+HxsJVR0+6bWgHh2D63f8Z0OOzsNi/AJGMlBKZJ
 xInrwUeDZgjsiML9S03nWe5BEQPKB8a1IkxECvEcU9s6U7C4sAdYVmLX4pmEtZjNDD7g0AFjemh
 g0bSMi6GbFt24ybKLSvcIWAx7pZ7dw1wzP27FPziu0WhOJPc8U3lkvH2eSjIdxDhr30bT/wTyyV
 mY3DLII3h6B4m1daxJfF8wY7BXjesoSnq6WpIWLpEgaFuJpBI9ZvnRbEU0KUk+wSWPtAK12MGkb
 z
X-Received: by 2002:a05:622a:d5:b0:4ee:15e7:d9c6 with SMTP id
 d75a77b69052e-4ee58911324mr70422021cf.53.1763771222802; 
 Fri, 21 Nov 2025 16:27:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCfUP1AUWM8ZWKgbzEJLUfgTloUcvu2D55Fx3WDliRSBqUEbRl6tFl7L0k4IdntCouJSxeug==
X-Received: by 2002:a05:622a:d5:b0:4ee:15e7:d9c6 with SMTP id
 d75a77b69052e-4ee58911324mr70421701cf.53.1763771222215; 
 Fri, 21 Nov 2025 16:27:02 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e8df63sm43870291cf.30.2025.11.21.16.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 16:27:01 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 3/9] migration: Plug memory leaks after migrate_set_error()
Date: Fri, 21 Nov 2025 19:26:49 -0500
Message-ID: <20251122002656.687350-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122002656.687350-1-peterx@redhat.com>
References: <20251122002656.687350-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

From: Markus Armbruster <armbru@redhat.com>

migrate_set_error(s, err) stores a copy of @err in @s.  The original
@err is not freed.  Most callers free it immediately.  Some callers
free it later, or pass it on.  And some leak it.  Fix those.

Perhaps migrate_set_error(s, err) should take ownership of @err.  The
callers that free it immediately would become simpler, and avoid a
copy and a deallocation.  The others would have to pass
error_copy(err).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Link: https://lore.kernel.org/r/20251115083500.2753895-2-armbru@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/cpr-exec.c | 3 ++-
 migration/multifd.c  | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
index d284f6e734..0b8344a86f 100644
--- a/migration/cpr-exec.c
+++ b/migration/cpr-exec.c
@@ -159,11 +159,12 @@ static void cpr_exec_cb(void *opaque)
     error_report_err(error_copy(err));
     migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
     migrate_set_error(s, err);
+    error_free(err);
+    err = NULL;
 
     /* Note, we can go from state COMPLETED to FAILED */
     migration_call_notifiers(s, MIG_EVENT_PRECOPY_FAILED, NULL);
 
-    err = NULL;
     if (!migration_block_activate(&err)) {
         /* error was already reported */
         error_free(err);
diff --git a/migration/multifd.c b/migration/multifd.c
index 98873cee74..a529c399e4 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -964,6 +964,7 @@ bool multifd_send_setup(void)
 
         if (!multifd_new_send_channel_create(p, &local_err)) {
             migrate_set_error(s, local_err);
+            error_free(local_err);
             ret = -1;
         }
     }
@@ -988,6 +989,7 @@ bool multifd_send_setup(void)
         ret = multifd_send_state->ops->send_setup(p, &local_err);
         if (ret) {
             migrate_set_error(s, local_err);
+            error_free(local_err);
             goto err;
         }
         assert(p->iov);
-- 
2.50.1


