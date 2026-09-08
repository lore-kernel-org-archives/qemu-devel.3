Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A725C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:37:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3rJh-0007WB-EB; Tue, 08 Sep 2026 04:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJT-0007Ne-Kc
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:36:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3rJS-0007Iy-87
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 04:36:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788856576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLNU8deII2YV/Np0anR9mXTsHZWaHsyFpOSn0YczNCY=;
 b=ezWwWHZHzgS9oVrhTMQHhxkIIMxvW34K2icyHjAHEqX9aKCCFA381BGhR0gEWjEk8OS3Yl
 dNqwPyCqvwQ+JkYxL4IQeyvo8iDBGLw77qdcrtxhIWer5ADGBfaBKt3uRkqiXU6CQKEJK8
 wIHu3Tg6m9VFG0GaRKEVY1LZslxclkQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-326-n1_anEi6PSie3FzSCy4pcA-1; Tue,
 08 Sep 2026 04:36:12 -0400
X-MC-Unique: n1_anEi6PSie3FzSCy4pcA-1
X-Mimecast-MFC-AGG-ID: n1_anEi6PSie3FzSCy4pcA_1788856571
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A851B1953958; Tue,  8 Sep 2026 08:36:11 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7B0F5B1; Tue,  8 Sep 2026 08:36:10 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 12:35:41 +0400
Subject: [GIT PULL 09/10] qtest: compile out HMP helper when !CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-9-7a3d1f0f1caf@redhat.com>
References: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-7a3d1f0f1caf@redhat.com>
Cc: peter.maydell@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 qemu-devel@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Xa0/LC6u8sESL2zvgI9W3vBYiovc4bTzR3MiwSE4zLE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn8jYpatGjH9OCmD2d9tnJeDFZAox8h9xDeqUR
 /ONC2YVWf6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/I2AAKCRDa6OEJdZac
 5d0TD/4u5vv8+tigGEhGXRCJElUmWhQLhJqROTANy8lvQ9aN00Lda6krn741ICi85VD8d1ddwJs
 tkf9P03TJWZgAYPzkqBMBnVwDw0PVOmU5w8mh91rhVbfkE91//iIkdNGNGTNKRA7ZAJbfnlHxQp
 oX3X+yUCH7SOf/LgNOlopTbDS/0n5RF4MsRsbk1NM2bkEgoistqwVGq+gC6ZwdE/yEhx8Fy8pGb
 PiVvu3DB7dFD6uTx1u+YyMocOSw5NT9FEZGaoIGIhiMrLFj3Ka24qadcmY3gFooz/lU9LGwcSVq
 Vlvy+RcxlsZpmo0CIIAgSmFs+8OaEN1T7/ckgBddrBJ/KTWyif1jB+SmfqQc2+ChycidBpOATlI
 vsche7feS5Nnf3aWfFXt192tbHFUpthlA+fLTPifpH8VRtl3aqlJZkE8oGmVLyZJsLrf4s4JK1O
 Xm+i271rSEkg0Il8mxsKkDt/WYhtJgFugpH6fm1YFWkxqMcN/mZp4fZBsGzOkZtzPOXvTDMLqMN
 x745a86rNN5qHtVgBXZivS4jRYQ41NsF/xUOeSXKm+YzCgDCcVWfUH3cHvyWXEFfwm6tgKOR3DZ
 wf39CHi3bPjqqYCA627E7Y+4bv0v2JMNzkFcfzbKVBfnWpebiy7XLbHdardNUbgpzwJVlhpSJZl
 ZFsjLwka90s5A9Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 23
X-Spam_score: 2.3
X-Spam_bar: ++
X-Spam_report: (2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MISSING_HEADERS=1.021, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

This should help prevent introducing HMP tests inadvertently.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/libqtest.c | 2 ++
 tests/qtest/libqtest.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 370f79a3b6fb..05d884761540 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -1021,6 +1021,7 @@ void qtest_qmp_job_wait(QTestState *s, const char *job_id)
     qobject_unref(response);
 }
 
+#ifdef CONFIG_HMP
 char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
 {
     char *cmd;
@@ -1048,6 +1049,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...)
     va_end(ap);
     return ret;
 }
+#endif
 
 void qtest_qemu_io(QTestState *s, const char *device,
                    const char *fmt, ...)
diff --git a/tests/qtest/libqtest.h b/tests/qtest/libqtest.h
index f06e061d214b..20982d3fe8dd 100644
--- a/tests/qtest/libqtest.h
+++ b/tests/qtest/libqtest.h
@@ -409,6 +409,7 @@ QDict *qtest_qmp_event_ref(QTestState *s, const char *event);
  */
 void qtest_qmp_job_wait(QTestState *s, const char *job_id);
 
+#ifdef CONFIG_HMP
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.
@@ -434,6 +435,7 @@ char *qtest_hmp(QTestState *s, const char *fmt, ...) G_GNUC_PRINTF(2, 3);
  */
 char *qtest_vhmp(QTestState *s, const char *fmt, va_list ap)
     G_GNUC_PRINTF(2, 0);
+#endif
 
 /**
  * qtest_qemu_io:

-- 
2.55.0.543.g5ebe2ebe4ea8


