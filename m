Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD20F3381C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 08:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2QEJ-0006Xy-Jk; Tue, 17 Mar 2026 04:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCp-0003SZ-GV
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2QCm-0006qQ-Gw
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 04:55:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773737698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fweQuvSX1fJ436MkX9foXwMd8CWTbAfJ1duBpJZqSfM=;
 b=TIOCL+qE6Zu9ErQRVSwgSG3sUnS/q8bIrnh8D0fQeiqjbb0nU6jF+xZwOLBZJPnOk5w2PF
 goHsbJJgvn5+8KiAo9DJHx+j1VWXJU8Ak6KjUjquelm7PucIiWqNX7wPPAsIUtMt0/Z0VX
 wYO+VRPOi0wkU4rsqQT0YSfAANNz4Ig=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-436-9ge4crJSNLumu6Wwi0S2sQ-1; Tue,
 17 Mar 2026 04:54:56 -0400
X-MC-Unique: 9ge4crJSNLumu6Wwi0S2sQ-1
X-Mimecast-MFC-AGG-ID: 9ge4crJSNLumu6Wwi0S2sQ_1773737696
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 080151800629
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:56 +0000 (UTC)
Received: from localhost (unknown [10.44.22.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C259A180075E
 for <qemu-devel@nongnu.org>; Tue, 17 Mar 2026 08:54:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 17 Mar 2026 12:50:58 +0400
Subject: [PATCH 44/60] ui/vnc: VncDisplay.id is not const
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260317-qemu-vnc-v1-44-48eb1dcf7b76@redhat.com>
References: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
In-Reply-To: <20260317-qemu-vnc-v1-0-48eb1dcf7b76@redhat.com>
To: qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=cDn9IqWN893vcRegr8B65WB5VYcrJdV13eo/ttHO/EQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpuRXctfEBcMoF7jFrkDt6V/HrwPmtR8sg93VoY
 NGDMaJ3gRKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCabkV3AAKCRDa6OEJdZac
 5fjJD/9CgFy7p8bI63smT2C3IJQme53jNlKTzbAxPVOCJJJkO44y/nRJrqVU//s46glw1WixHr5
 WRM4u9bK8I5gXIIHg8l9M1yB9E1+E6iYQWi6EPo9ohq/lLt6i19JhlLWUE0C0DUFg/RGO9Ps8eD
 xXdQWE/6lmHZC/nD1DltoCLHKfrjBq3ho1SQZuhQvaX9KqZSu5qqK1skeEPYQL7wuk207gMr0eA
 pXWJijiCGNYC5ZDtl5/taQ1zyhUYB4B9PN6FhThbZ18WW4iQDX21DpolKn54q12sIT2wS8Ukwh6
 5cFOqjNmejOEbkdSR8Xl+Bfeisuo/zgRyVIk0ug37Rg+KExrjsu+5ttOrvCHWWxqTAMF0uWrZta
 +9pgs5L4b1ObXI3yI0EIouNeePuociSKHachjO5QBpYMcOhm9EjRHHNY1caKDEPp5TRYQ1mpTep
 TMzs1KAflojATYehbPSkFc12iXnutDbkgSvNONRBPZsAgejeyC9HLnPARtBQqs6iYVz1QfJfEUZ
 mzfIV18igrWnrcWmOPytU53bB9WCLVAC/FLlTscoKx1A5rY+zjdsDJFMiI1usn81m4ssrNIDUs/
 UsU3X+SV6ZGkt3QcQMqFjJE/Gx1r36/8/0gekgXL4WxaqoFls/NP195GuqD0cjoC4R7SCSkRYwy
 dEokU1a+oJcxqXw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
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

s/strdup/g_strdup to highlight the issue and be consistent with other
allocations.

The next patch is going to introduce vnc_display_free() to take care of
deallocating it.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 ui/vnc.h | 2 +-
 ui/vnc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index ec8d0c91b57..c5d678ac31e 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -166,7 +166,7 @@ struct VncDisplay
     pixman_image_t *server;    /* vnc server surface */
     int true_width; /* server surface width before rounding up */
 
-    const char *id;
+    char *id;
     QTAILQ_ENTRY(VncDisplay) next;
     char *password;
     time_t expires;
diff --git a/ui/vnc.c b/ui/vnc.c
index af5fb3c1551..763b13acbde 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3430,7 +3430,7 @@ void vnc_display_init(const char *id, Error **errp)
     }
     vd = g_malloc0(sizeof(*vd));
 
-    vd->id = strdup(id);
+    vd->id = g_strdup(id);
     QTAILQ_INSERT_TAIL(&vnc_displays, vd, next);
 
     QTAILQ_INIT(&vd->clients);

-- 
2.53.0


