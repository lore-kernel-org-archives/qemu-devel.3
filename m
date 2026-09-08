Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B2B5C79FA1
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:53:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3sVL-0004FZ-9l; Tue, 08 Sep 2026 05:52:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sVI-0004FD-UY
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x3sVH-0002gq-G7
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 05:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788861154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vLNU8deII2YV/Np0anR9mXTsHZWaHsyFpOSn0YczNCY=;
 b=X4+3c+4AUmYOPkscoihm5isNjiFaU2XuFfw3iKMX7uhe0MfawLamf0HLBh6AjyR6Q6V5n1
 WBfvHihT4mJArXJJctzGOo4+92rFp6huOGeU7s0ZPmUTrlUec9tDee44FaAHEBy4837SKO
 1P5cxm6itC7Piz94VD+5kMTPnd7wghc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-W23JiT8COQ6u8-4H7uTjxg-1; Tue,
 08 Sep 2026 05:52:31 -0400
X-MC-Unique: W23JiT8COQ6u8-4H7uTjxg-1
X-Mimecast-MFC-AGG-ID: W23JiT8COQ6u8-4H7uTjxg_1788861150
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 925FF1830517; Tue,  8 Sep 2026 09:52:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C95AC30001A2; Tue,  8 Sep 2026 09:52:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 08 Sep 2026 13:51:58 +0400
Subject: [GIT PULL 09/10] qtest: compile out HMP helper when !CONFIG_HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260908-nohmp-v1-9-b19b693a5665@redhat.com>
References: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
In-Reply-To: <20260908-nohmp-v1-0-b19b693a5665@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1572;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=Xa0/LC6u8sESL2zvgI9W3vBYiovc4bTzR3MiwSE4zLE=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqn9q6izd8j01YC3It1eraRo+9HzwVoEeyQf6s4
 vyOXEIVD/GJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCap/augAKCRDa6OEJdZac
 5Tp7D/9tcjQ3KmhgdbAGTGFcjefczZ1bSO/Y1DD+9A/lg5eJMC7n1OkQed/736XxUmjaW6zJaB9
 1G/Pk0+r/giVQb1JAkQRyYzQbaTAjOzzUmRJ4770GOv5Ur6+pNmAkgY31myB84XnEScX90BqRG6
 /eLa5eIMHdKtzTvipC2EKR8o1PPnVK25v9NcMdZZ6dYfkvvF4YNBhvTtKG1RXQYdlNioBw7iGxF
 ZU3wFBHpZiAhYjpyKGvc2KkJXui4njOwRmcbhxHmZkXy2tfUTpWRI+ncxZ4TS02u13t/olLdaIT
 qZqCce38x0HBFCkNw+BjFfBxHoRbovi3r/HkyMduQ0sg2GUlOzIpyuk8LoXhUsllJFVaV5vlNIL
 hAigfTd4cNN3sGZ/Sk7GCv58gU1ZRAqUw9lfyYGNIcy25gQZXXsoTi3Nr6hNG6ebviwop67dM34
 w6TV7e+xjrjxbsu96pKN9nma/QCaJOqXyxe3UAIq+aGFkwyF6BRrEKn+M04qvFpmGLWy8msVRVg
 WrbflhItWcr+xjdNl/+Rratdawv+TgJOqBlv7ZTdjq5hVhfrTx0ci3iUUg8UWAfjEe9K7uA/kkR
 /f3EFsG3KAglJytKuHUK0zR3Xhzo7reUriYhnTO5m04Gzj0ufvhrDoSZrzAcv5cRvlH5XhQVNh0
 6qVrldsvD0xvbcA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


