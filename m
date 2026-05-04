Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A06FCD343A
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2026 11:38:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wJrcu-0004Ek-Vu; Mon, 04 May 2026 07:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcs-0003vm-A5
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wJrcq-00019h-Qc
 for qemu-devel@nongnu.org; Mon, 04 May 2026 07:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777894692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82+lAluaZQmwO0cbys/HebvHtb8nAYQwYC80HeZ2EvU=;
 b=YSlPYKf3KRhjh57+iTLR03f8qfd5vYCOe07eYSOju2l+BAFr5dRaeo2J5AWavgyxTHDtiJ
 8UzN11r5LHh/wR6LNlguxVzGtK8hOwAQ6J/IoDGeLRa3kWmp548HqMIHaLUZV4gqk9p2dd
 aoRS/v/wK9jrPYlPdVqVN00GVP0fY4Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-uqYrgyp6NxiyfV6WVTYoUQ-1; Mon,
 04 May 2026 07:38:09 -0400
X-MC-Unique: uqYrgyp6NxiyfV6WVTYoUQ-1
X-Mimecast-MFC-AGG-ID: uqYrgyp6NxiyfV6WVTYoUQ_1777894689
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1D73D1955F1A
 for <qemu-devel@nongnu.org>; Mon,  4 May 2026 11:38:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F00B930001A1; Mon,  4 May 2026 11:38:07 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 04 May 2026 15:35:18 +0400
Subject: [PATCH v2 30/46] system/qtest: add missing qtest_finalize()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260504-qom-tests-v2-30-ef7e3dc94f7a@redhat.com>
References: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
In-Reply-To: <20260504-qom-tests-v2-0-ef7e3dc94f7a@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=9AkKHVjOuoPxJmyGfw1IlVjKN2smzpd0Yrdw/2aWqhM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBp+IRt5jmaObgzU+ELnzZ/U2VrHYFUIjUD7qGuW
 VrwfVDGAKCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCafiEbQAKCRDa6OEJdZac
 5UlMD/9Y7laAhkCD4IlrZ+9OIj253VKlPtvz8cnjIvsrGzN5OJwKYyObcyxvFmbNXnqpXHElPMk
 JU7ALdZiQCwihD5EmI3Ri71aK8MaEym7BTNh3jaFMrCqcTrKTpzocuC4hu+dRCLSzCPijD/aU3C
 +rsoem+frqG6hIzF3g4BcI/VpfUua6G3WjK46rGWslX0M21oWaYEx0r7FSdL0YvpPPbrsdeC9dp
 PhXKKN0EYgpoIxXOPL39G/jEhuGclQaPlQ9speX7PrqZlBXl2bBX1wHmPRU9J3gSvwsftdjvRLc
 LMA8J5gYyKNdBnvLqFjuWXKqr9wO6hDGj0CgilAGd4ktZvlu+vXfG8ki/+p016FXH/piYyFKJcQ
 Kf15FDoOdS1Kg8WYcohFIHeeYoUpb7IU2HNYXXgEPXR4h2n6MoG8gZclOR5774c2u92FQ6jOSzS
 iBbDWcSa6CiA1atSmruNqp02pueOCVB3QXZRbrSn8KrXvo67J/JbLlLIGNIUFEXk/FsvQOFwcaB
 tSrCFx+zCuiEzWi4jRI1PXCTp9834+LRriV9uC4jMNEM6mhEG+Tmcik6pJZlrCtFGo1K4urBy5m
 IwE+yTy9uvv+6nEBYiwEXgkTnKFeo+7B8TcC9c+YiYZSL3vGnC126FSAyjlf6PYH4V/WEQI5Whv
 4wlG50M5cWRDmEg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.444,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Free owned resources on object finalization.

Fixes: 6ba7ada3559e ("qtest: add a QOM object for qtest")
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 system/qtest.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/system/qtest.c b/system/qtest.c
index cf90cd53adb..a79d10d1361 100644
--- a/system/qtest.c
+++ b/system/qtest.c
@@ -1020,10 +1020,20 @@ static void qtest_class_init(ObjectClass *oc, const void *data)
                                   qtest_get_log, qtest_set_log);
 }
 
+static void qtest_finalize(Object *obj)
+{
+    QTest *q = QTEST(obj);
+
+    g_free(q->chr_name);
+    g_free(q->log);
+    object_unref(q->chr);
+}
+
 static const TypeInfo qtest_info = {
     .name = TYPE_QTEST,
     .parent = TYPE_OBJECT,
     .class_init = qtest_class_init,
+    .instance_finalize = qtest_finalize,
     .instance_size = sizeof(QTest),
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_USER_CREATABLE },

-- 
2.54.0


