Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A633CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 04:56:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEJhO-00087f-Ot; Wed, 07 Oct 2026 00:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEFp3-00069U-J9
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:48:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xEFop-0007GL-S2
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 20:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791333901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1QccO1ewA7uCctsMw+H9QSnUhVtqxnp43iU3gAZqGys=;
 b=J0k9rAJXyDAmQ0guPu5KgBkrT/FbPSEvAaTjDCLNi9osmjUULaLrkeUGuVODZOrX0J2867
 8ijeJm2utFeXIG5gA2Y3qj+4aSwoKHU3gTCx1Vgx0mimvcRBdsEX6mINFc/yQkteQpXu5v
 mIV7em1SmJIS0NSTRl5y4ec8+bdMylo=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-7dV8-ErNPUOlY6VVYxQopg-1; Tue, 06 Oct 2026 14:20:57 -0400
X-MC-Unique: 7dV8-ErNPUOlY6VVYxQopg-1
X-Mimecast-MFC-AGG-ID: 7dV8-ErNPUOlY6VVYxQopg_1791310856
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53390e79a19so54325921cf.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 11:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1791310856; x=1791915656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1QccO1ewA7uCctsMw+H9QSnUhVtqxnp43iU3gAZqGys=;
 b=CKRsUFfostpNXsDU0zh7i4XAFQ7Tm885oTxUEBrR+uxskvGMP0qsJvghdlEA+a1gq4
 /yHm0gGTzdXezEtQOxj9leGdGpYt8Uje/SXAil5VsG08QwVQD3r77YFTpNXq800hL1M1
 vw64qAS1K08vutdCNEJsk1TxTNHLon6cgtrZPZOTvcF6tS/sUOd4O5TbQOukqTQDBDge
 XJnEHLYrCCsxhWst1mrog/kaj3ryLQ3snVwT49wPPf585qhbjUWpqTfDsk2onmWjYwgp
 ShljyLwPbicGiJJl/TbqhYR4gLQmp2Bqt6g2h1ME0qgPGDEdqf+ayKT9IOQyT6UgbF6j
 5D1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791310856; x=1791915656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1QccO1ewA7uCctsMw+H9QSnUhVtqxnp43iU3gAZqGys=;
 b=DwxXHQPt5UEP2s0QUyQH9R/pZ7VPSPWprK87OdBbNby1rWej48FFUPpWBwCLQ+5AHe
 RYe0lvOD2Jt5lUT/nGaMFauxFUVw9sCcAx2a+6M2acCh0ZeUmaE8WA9jWiov/6f0LjmD
 jXWbc5GahCbi7Q8na2ucmEHmYrKvhldmf0rpiPYy4SI51ZGjyfHd09Nh5HPxYIe7tgwt
 2hE7XwpieOKfAB/NzfmdoP0DWxieczAht1zianmubWxHxAzlJng8lATriBsQLbMA2zqt
 3l+H3N1I10a2GZanhNDN/JZ852lITP8l95RR6IDdJr7tSK6pzpbO51nlRWEzBdaVr3/6
 CQGA==
X-Gm-Message-State: AFuF++nMzafVxxnlPnvIKUej8hA50LEECaRFIofYf967jY1nBmIxphgv
 IUMfWTUmyGIDQPPU6uEdauGbQLni8uRo2kvJHh9AMPr5SFPOfOtpPx06f4ZAifZusNjATALe4P4
 WTrXUVPGoBR6oyKvzHN/o9uJHJXEEUr6RvK5URFTRkTL66plfF3+7rXH+hu15+XOBwQWbGYUXEv
 NK+ORJ8nrQTYM2kfSrcd1a9K0yUBamHFlFE2gLoQ==
X-Gm-Gg: AYBFou3foWRxGYYL+RSLaDUj9WKcCEUfzATwGboTzxWmaYmsR2WSASszMTreshiAbSX
 LbFXSvN3eU5xu708Kz/zmHaOKr8nE+RQgXdNJnySdfmi7j9t/bQqk0f7co1lJQ/1J70Ji8UvfDs
 Jxm2tPupMDLpIa7945/sHKZt9qFfT8IX3OGJgb5DXlHDcIM2lWJMHviW4BcKOaxpcxAzixyrVE8
 cjnJ4hO0tI/g+cJX3wxROUJLr2MplLkgfUIUsKIsWDIng+3zI36E9Tk0TFKbpNZAOIVSO9v5Nkq
 o2DUwlNN4y0ViTOWUDMOLZs4LKJdX+kE0RIhjHqOavYLncT1ULU5C/595naU7rUrA5Gm4E4=
X-Received: by 2002:ac8:6f09:0:b0:533:3192:7a8e with SMTP id
 d75a77b69052e-53566d92720mr38236401cf.43.1791310855903; 
 Tue, 06 Oct 2026 11:20:55 -0700 (PDT)
X-Received: by 2002:ac8:6f09:0:b0:533:3192:7a8e with SMTP id
 d75a77b69052e-53566d92720mr38235691cf.43.1791310855242; 
 Tue, 06 Oct 2026 11:20:55 -0700 (PDT)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5357219c5f5sm1623791cf.25.2026.10.06.11.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 11:20:54 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 5/7] migration: Dump type of channel in
 set_incoming_channel tracepoint
Date: Tue,  6 Oct 2026 14:20:44 -0400
Message-ID: <20261006182046.3767283-6-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006182046.3767283-1-peterx@redhat.com>
References: <20261006182046.3767283-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Add this info to be crystal clear on what channel we're installing.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.h    |  3 ++-
 migration/channel.c    | 10 +++++++++-
 migration/trace-events |  2 +-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/channel.h b/migration/channel.h
index a7d0d29058..678712f291 100644
--- a/migration/channel.h
+++ b/migration/channel.h
@@ -24,7 +24,8 @@ typedef enum {
     CH_NONE,
     CH_MAIN,
     CH_MULTIFD,
-    CH_POSTCOPY
+    CH_POSTCOPY,
+    CH_NUM,
 } MigChannelType;
 
 void migration_channel_process_incoming(QIOChannel *ioc);
diff --git a/migration/channel.c b/migration/channel.c
index 8407ea46cb..b9065efd03 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -34,6 +34,13 @@
 #include "trace.h"
 #include "yank_functions.h"
 
+static const char *const mig_channel_str[CH_NUM] = {
+    [CH_NONE] = "NONE",
+    [CH_MAIN] = "MAIN",
+    [CH_MULTIFD] = "MULTIFD",
+    [CH_POSTCOPY] = "PREEMPT",
+};
+
 void migration_connect_outgoing(MigrationState *s, MigrationAddress *addr,
                                 Error **errp)
 {
@@ -219,7 +226,8 @@ static bool migration_incoming_channel_install(MigrationIncomingState *mis,
     }
 
     trace_migration_set_incoming_channel(ioc,
-                                         object_get_typename(OBJECT(ioc)));
+                                         object_get_typename(OBJECT(ioc)),
+                                         mig_channel_str[ch]);
     migration_ioc_register_yank(ioc);
 
     if (migration_incoming_setup(ioc, ch, errp)) {
diff --git a/migration/trace-events b/migration/trace-events
index c93c9f9e75..8840d82f8d 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -208,7 +208,7 @@ migration_transferred_bytes(uint64_t qemu_file, uint64_t multifd, uint64_t rdma)
 
 # channel.c
 migration_channel_process_incoming(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
-migration_set_incoming_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
+migration_set_incoming_channel(void *ioc, const char *ioctype, const char *type) "ioc=%p ioctype=%s type=%s"
 migration_set_outgoing_channel(void *ioc, const char *ioctype) "ioc=%p ioctype=%s"
 
 # global_state.c
-- 
2.55.0


