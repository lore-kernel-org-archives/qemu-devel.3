Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12693C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 19:11:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wywXy-0004Up-E9; Tue, 25 Aug 2026 15:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXx-0004UU-50
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wywXv-0003wa-MC
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 15:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787685055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SopzVZmki+Hnpy0NQ2yaF9P+Y9MMP6qFbH7RSqmwlo0=;
 b=VRljj0XLSmZaO6md2PcoO3g/7kne5tZ0h0AV/I+lODkP1BXNSlVo68BSL05hQANhATYcDI
 TASGl+JoNRdNMsENO7yVKvkoVcQJnRBrPLhhZsBLZb57FOtZTp43fYNFZEerzryLJWWsyd
 dKQLvSsrcbWdjfuo5/027ScsDIdg5z0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-220-_Z5OCpKUMoSjcOoonvj1jw-1; Tue,
 25 Aug 2026 15:10:51 -0400
X-MC-Unique: _Z5OCpKUMoSjcOoonvj1jw-1
X-Mimecast-MFC-AGG-ID: _Z5OCpKUMoSjcOoonvj1jw_1787685049
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6ABFD195DE21; Tue, 25 Aug 2026 19:10:49 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 761E21955F0C; Tue, 25 Aug 2026 19:10:48 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 25 Aug 2026 23:09:19 +0400
Subject: [PATCH v4 12/49] tests/qtest/pnv: drop unnecessary -serial mon:stdio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260825-qemu-no-hmp-v4-12-af60857c2fbe@redhat.com>
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 dave@treblig.org, 
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqjeiHBN7NzbXzZ+dRsm7YtWyV+JpVVzBUF9KyZ
 1+MNJg8oviJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCao3ohwAKCRDa6OEJdZac
 5eNUD/kBaOxTMPz91+m2SqFj2UIAIqpWEPwOHOI10NRbHOFL4UwzcYx+Nvtz4muNZPI5suvmkvH
 MxzpRcbkRSqywgrgaObQoYVfq0PKmrU5vV0Zt1WxNBNrcDhd2r9Fa6b8i0rGGyw9NzYNGQiMO10
 4NSeCRZYuMT7HCBASgosT5RnKdM5gJ5tJLkTz8WtVJIwzZjkLjyUT9t/uFTSzflIdlEBEYI5K4q
 IN8eO9AS1TtYYIw4OaAFU0UIfDAyfWImF4E1IwDLihVVPiYEGA0IxPhX98sxqrUQPVloVM6ZdJp
 FbansqzQeiJYtBTDB/GC9K2hMpebizpHPaXVXKkxlW6Lvotd0iwzpEy6OZpvxMpA+TqgoT/ac74
 2GyFHQIkC1u967er/UVpa/qT4m85rZLRT/fdly1w70E8tJ7JwEy2/6JJ327CGYoF9AhSQ5bH6ub
 BrNdqDRXWXIFgs+Ti//Yeg/L91K023UadIHVKP6sJhsDThkb4QijdOsqsa42RNmuet4Xs5Z5V+0
 HBtK4u2O46rokKGyMTddVCfMr4/EDdV/R65ZpyHK6wZeJgTUeHcS27gOWCjd5HFkc6HZIIfZfc1
 IG9v/hSZJAAC5r5+V0j1PTdD6ERZJxDvhauG7dhMsRUlyy5LBfkPB8utcRfNrV74UnFtjny5lMP
 DYV6MdQ6uAopfJg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


