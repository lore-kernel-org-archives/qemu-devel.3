Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43310C79F9E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 08:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x38T9-0004LB-Lz; Sun, 06 Sep 2026 04:43:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38T7-0004Iq-Sk
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x38T5-00089m-Ug
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 04:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788684195;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zaiAZ1UlzH8o4m66l+A0geodGP8srFS466O2Wgy6VdU=;
 b=HAlrumdthi7/Wu7BbQz/cOd3barKLElZubSxz+4ufffwGbLt4aYziTGAstunIaiAkuL97C
 ZWQBM13x5iP1ukTGib9AihRBgf9j3Kv9fpIMvIt52k/EhXsh9w5A4bM5QV6z+p9tsKcGcT
 4nS51fMaOINpDOZvdf3BYsN1tjCBxeM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-5SQW3TbfPIKGZ-sCkYjsBA-1; Sun,
 06 Sep 2026 04:43:10 -0400
X-MC-Unique: 5SQW3TbfPIKGZ-sCkYjsBA-1
X-Mimecast-MFC-AGG-ID: 5SQW3TbfPIKGZ-sCkYjsBA_1788684187
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 859861955DC3; Sun,  6 Sep 2026 08:43:07 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5ADEF434; Sun,  6 Sep 2026 08:43:05 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 06 Sep 2026 12:42:38 +0400
Subject: [PATCH 7/9] qtest: compile out HMP helper when !CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260906-nohmp-v1-7-daee96491c43@redhat.com>
References: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
In-Reply-To: <20260906-nohmp-v1-0-daee96491c43@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Thomas Huth <th.huth+qemu@posteo.eu>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, qemu-arm@nongnu.org, 
 Halil Pasic <pasic@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=bNWTQYLdYcOcYGyeGHcixqBdkQgP0HeOjs/GAUAOLsQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqnSd5vmqdoL1kkxQP5uTdGvnOD1ugA0ADQj1pB
 gWao51QLFmJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap0neQAKCRDa6OEJdZac
 5fXKD/94N+K8AF8JpOPS6m3xTgvS4+qD/Rndgc/pinilIh92ZMSZ+I3z/PKawWOjz1v+wh31Ark
 6p/R0zApr3LEmv5wDxywO6RlsBlAoqDntF4l2I0poPxxe3aqGLh2dUWKRv+8obESIEzl0xFNvkb
 xcqIwi+RfI5c3XBaLHRzL4ke4JeQ2skH2MHa0nHCdsr7JZLrfwuK5rREvMTQsBqn5Dus5cuICoO
 ANBSEo+2Q3+5LhyNxI1rRVQbU9fMnJz8MzNRw7GX+Nvqc836ihduh71NY6Rdlb34BzPRYMrTQVr
 sRmbP8f4qBrm11EDp6FdeAW2gatAbuRHV5CJOfpV73qU1bjwiSj/aMPWc5Sr+fmjUld55mLEkFR
 VuhIQW8gbq/yq1reVjbMTkFOqDf+rxNI7Im7S47maTEb7NxC9PJkE4ErJhEDt2dBDJKpDEDisCk
 Q3h4qdXPNRQnkw6YU1F8FuODwUBpbfbWgXKy2PF44JEY4Kfsbmhzhca01HPZRbKHG2FTumh40Xq
 gXH/Vt5WOE6wVRisAskAzfU+yzLM/LGl2nXisyxcs5fXtlcBRPc6oj0c7JoP31WaAkbJQO4GWeF
 IzAjBdO8a2DK0fQLxlOVvbeWl4bawfKOzoEXdzx+qqLYPys+ezJHc6EfOnbVgOnAxN8MGQ9QrKi
 2p+STM3VPg+6wYA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This should help prevent introducing HMP tests inadvertently.

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


