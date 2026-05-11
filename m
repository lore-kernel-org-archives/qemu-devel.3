Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7364CD484E
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 20:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMX9J-0004qq-1u; Mon, 11 May 2026 16:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX9F-0004bg-4M
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wMX9C-000295-B0
 for qemu-devel@nongnu.org; Mon, 11 May 2026 16:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778530956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zaFmpzO9wm5ZBT47gYTD3GZuFhtThIZcvMGQksKD/Co=;
 b=abRL2uknNkdw8k7huIRi1B4vaHWIPmVoNoiC/rmHxrELPBZ8q2R886FAY8NJSkJwPV+rD1
 T4ANx+M/Q/YmhqUP2Fx6NjL1BNubKtAwFt7RoWEMI612Iy6YPBXHYgnPwaRssyi2dP9WoC
 tBXkminkR8ogOZMFPp2nko9HIy0UtgY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-mw7HuTHwOPWd0h16rRB-ew-1; Mon,
 11 May 2026 16:22:33 -0400
X-MC-Unique: mw7HuTHwOPWd0h16rRB-ew-1
X-Mimecast-MFC-AGG-ID: mw7HuTHwOPWd0h16rRB-ew_1778530952
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 62AF618002C8; Mon, 11 May 2026 20:22:32 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D16C91955D84; Mon, 11 May 2026 20:22:30 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 14/24] system/qtest: add missing qtest_finalize()
Date: Tue, 12 May 2026 00:21:00 +0400
Message-ID: <20260511202111.3091440-15-marcandre.lureau@redhat.com>
In-Reply-To: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
References: <20260511202111.3091440-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Free owned resources on object finalization.

Fixes: 6ba7ada3559e ("qtest: add a QOM object for qtest")
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


