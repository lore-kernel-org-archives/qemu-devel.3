Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CABFCA5FEC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Oct 2026 10:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDJNx-0004UU-Az; Sun, 04 Oct 2026 06:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNv-0004U2-8V
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:23:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xDJNt-0002tC-U3
 for qemu-devel@nongnu.org; Sun, 04 Oct 2026 06:23:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791109437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UPfsN916qtDR/9A7xtsIs06fHc7wwmLhjlkZrg8Qj3A=;
 b=Mlz6DA6xvxSGCIqtI0Om5IEE7c+np7w30ctF2zPUhbwHO+ISJsYqTgXfDo+7pA4m6SSR/p
 MURiRzrZaQ6N9aX9YwjudVvVL/hJYT1UgFrV1wjx15G7wwDeaGV+k9DNeGxHNveNjiLRos
 Ck6UZLsk/+ZqVKkVkYyjiyf2H7/jxzA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-5-7j0nWXV9MJWw-8Xm7m6d7A-1; Sun,
 04 Oct 2026 06:23:53 -0400
X-MC-Unique: 7j0nWXV9MJWw-8Xm7m6d7A-1
X-Mimecast-MFC-AGG-ID: 7j0nWXV9MJWw-8Xm7m6d7A_1791109432
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F7C61955DC6; Sun,  4 Oct 2026 10:23:52 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5AA791956089; Sun,  4 Oct 2026 10:23:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 04 Oct 2026 14:23:18 +0400
Subject: [PATCH 04/63] audio/paaudio: fix server string in PAConnection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261004-issue-4560-v1-4-ccbef537cbeb@redhat.com>
References: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
In-Reply-To: <20261004-issue-4560-v1-0-ccbef537cbeb@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Pavee Hui <phui@google.com>, Gerd Hoffmann <kraxel@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TdVtONrXe8+Ir4bfY/26WY9VXMLWxfzLKGGUWKJUSUY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqwikhf3j1K+mHZ5K1Wafg7t0wrZgDkri/umwcL
 +m5Y4ut/yyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCasIpIQAKCRDa6OEJdZac
 5UqUD/9w5k46766dqw2ENdj7SfqGqjfFAQQqhA1lsWm0r1pPer703EzUd1tQ31vUEZg0CnGaGNK
 hqXIlQzpArKNYYE7uQcoXYoZcECYV5SOFa2GXLhOz4Y17rgeGWOjK69YO35GEAfKhti1Vxc64Oq
 +2OUnG+u4HNyKnJaX4BIil8LtpSj7Rm+/L8q1L8ehcUYB8wrhIMw8JbGcYFyo57wm54eV5psetS
 3O7FSjmAnSFru1+H0OK807DeeFow/AiCiPZ5xYc+XuwSSALBVawF4JrJ/WqrBT8inMaeyJl2oWX
 Vo5JoB6wLj7ZN/mAgxWzGI9M4poKx1LiwCTyPJrIOAYHHDL/lzAOmWAGXImP97E/zxjj2tRz2rg
 ZgKYIxvC2H09TRSjgqAIWfD2GlKWAbIc3k9lKUgxUqpsOSFGKlf9qS4gmPmz7fY+pn/rjNjhqjn
 Ik9mwadmHLykJdPNR4kLDMoWSzeWA1PoQpiatjx4sIxCcB8WSkWeBObyua23zotRdX8XmHLK4FB
 prFwRq4+hj8XhZT4JjIuhHFXHlxl8lkP/cU+oLuc2dFzn8spzOI/x3xi4BhgoOIeRNRF+kir4Ss
 11OAhztCiblJpcs+Vgk5Z+kCQgeoq7skwoR0Kqhk+DT+SQnN0o6aa+l5xhoEwnK8ASkGWoufvsC
 07gEes9DFb/+8yA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
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

qpa_conn_init() receives a server string but never stores it. Save a
copy with g_strdup() and free it in qpa_conn_fini(), as intended in
original commit to allow connection reuse.

Reported-by: Pavee Hui <phui@google.com>
Fixes: 9d34e6d8a1a1 ("paaudio: prepare for multiple audiodev")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 audio/paaudio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/audio/paaudio.c b/audio/paaudio.c
index 24327ecbf453..9d0a622fc5e6 100644
--- a/audio/paaudio.c
+++ b/audio/paaudio.c
@@ -747,6 +747,7 @@ static void qpa_validate_per_direction_opts(Audiodev *dev,
 static void *qpa_conn_init(const char *server)
 {
     PAConnection *c = g_new0(PAConnection, 1);
+    c->server = g_strdup(server);
     QTAILQ_INSERT_TAIL(&pa_conns, c, list);
 
     c->mainloop = pa_threaded_mainloop_new();
@@ -875,6 +876,7 @@ static void qpa_conn_fini(PAConnection *c)
     }
 
     QTAILQ_REMOVE(&pa_conns, c, list);
+    g_free(c->server);
     g_free(c);
 }
 

-- 
2.56.0.rc0.29.g47ce80527c56


