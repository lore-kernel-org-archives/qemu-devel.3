Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48CA1C5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 19:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvgJA-0000Xs-Tj; Sun, 16 Aug 2026 15:14:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIo-0008Uy-Qa
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wvgIl-0007R7-2J
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 15:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786907626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SopzVZmki+Hnpy0NQ2yaF9P+Y9MMP6qFbH7RSqmwlo0=;
 b=AGqGzbCpuMsBrD+sTWMOcBwipwM/DKyc5OuowI+DCJxKXnWoC7li2x8jvOdvH8nsVhGXQi
 hUMf6N52nTJ8X55Pk02DLHMwZiBRKjPlyc9/SXWUjXJP3BOUVpB4jIeN5VCanQtF05wgy2
 a94mEbmQBL9IBrGOIyAW+ft2hCfHG+w=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-99-T5LWhpN1Mfuw0YfBZVO6bg-1; Sun,
 16 Aug 2026 15:13:43 -0400
X-MC-Unique: T5LWhpN1Mfuw0YfBZVO6bg-1
X-Mimecast-MFC-AGG-ID: T5LWhpN1Mfuw0YfBZVO6bg_1786907621
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E01619560A5; Sun, 16 Aug 2026 19:13:41 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88FB7422; Sun, 16 Aug 2026 19:13:40 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 16 Aug 2026 23:12:39 +0400
Subject: [PATCH v3 12/49] tests/qtest/pnv: drop unnecessary -serial mon:stdio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260816-qemu-no-hmp-v3-12-e53fc35bc550@redhat.com>
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
In-Reply-To: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1774;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=VqG8CcLp6vBSBhgsb7VgD9sJ4gnMAM/5MArloE3n1GI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqgguxBKnyPTzS4WkTm2IG5eX1y40GezABWDBug
 m/pdS1CwHqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoILsQAKCRDa6OEJdZac
 5U3FEACUhEO1fdhdOkvcuhltT/j08r5H/SQa0bq0Ev7paXEUP/vXLT6i/pTKcSabVdvLP/tl9Yg
 Kx8+FZLyyKmGkoUBFJLx9KO31d709dpf1lPsh/vMBxww+tjBRvUnZlw0VZ2EAwf+tpF/+vnCx/r
 xVhH+xt6JKADgxHVnHmQhRh64mexcOCsG84GEYIANePGMNMZlDIigaznIAvZYtw+/lE2c1paFaJ
 /jtq6nNVsfANfl4ykQpx9aFhe2gOHGyhoT2d/jQzyXrM7gSiYYmuh+opLuixAYQ44pI8qgpDIp1
 Frd3lIfAT3JOwDzjsktEelwLju7zh3aD4DNvF0lmGlKnAtwbogbjDK/Wr9Up+UlQR2j+55yYkW5
 UQIIvpWmqPgBnr1MGlfqgPBj/1As/xAuV91WnXyw1rVlWWKM4TR+V49JNBjH0qdCtZtwlyFcmLD
 FBuLOcnODAFXcylUT/r0Txnj5fPCWj7xxwVMl64KhCiNpmXbhnAEV1RFefC8tQHwsPfRag82sbX
 KCVdwxDlXpzcxBmbtlYqZPO3RbJSlUdkLw9U+b3zjBZ44YEVyp/hedCI3eyp0Mu6aqy7zzuFZB0
 HTZCSKjl2Ztui6+U9EsmfI02LXp383lu6AR//PVf4gCd8mkOAZq9ZjhkJj9nwxcqaln6XpReEo7
 OBW0urmCi29ti3A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.342,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
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

The pnv-xive2-test and pnv-host-i2c-test pass "-serial mon:stdio"
but never use HMP commands. The "mon:" chardev prefix creates an
HMP monitor mux, which fails when HMP is disabled. Other pnv tests
(e.g. pnv-spi-seeprom-test) don't specify -serial at all.

Drop the unnecessary -serial mon:stdio option.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qtest/pnv-host-i2c-test.c | 2 +-
 tests/qtest/pnv-xive2-test.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/pnv-host-i2c-test.c b/tests/qtest/pnv-host-i2c-test.c
index 5fd54f9de771..f97f6f65eed3 100644
--- a/tests/qtest/pnv-host-i2c-test.c
+++ b/tests/qtest/pnv-host-i2c-test.c
@@ -414,7 +414,7 @@ static void test_host_i2c(const void *data)
     }
 
     qts = qtest_initf("-M %s -smp %d,cores=1,threads=%d -nographic "
-                      "-nodefaults -serial mon:stdio -S "
+                      "-nodefaults -S "
                       "-d guest_errors",
                       machine, SMT, SMT);
 
diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
index 9f67a0066864..a0892c0f8e89 100644
--- a/tests/qtest/pnv-xive2-test.c
+++ b/tests/qtest/pnv-xive2-test.c
@@ -552,7 +552,7 @@ static void test_xive(const void *data)
     QTestState *qts;
 
     qts = qtest_initf("-M %s -smp %d,cores=1,threads=%d -nographic "
-                      "-nodefaults -serial mon:stdio -S "
+                      "-nodefaults -S "
                       "-d guest_errors -trace '*xive*'",
                       machine, SMT, SMT);
     init_xive(qts);

-- 
2.55.0.543.g5ebe2ebe4ea8


