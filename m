Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C2DC61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 12:06:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzvL9-0007Gr-8T; Fri, 28 Aug 2026 08:05:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKw-0006vP-0P
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wzvKt-0002e5-Pz
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 08:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787918731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SopzVZmki+Hnpy0NQ2yaF9P+Y9MMP6qFbH7RSqmwlo0=;
 b=TniACTzZVGRGYnh6MTwPpehCskJN1ILgbjNnzQXlQFhG6LkJZFGPcW9Vt2PzuFbuemrXm8
 ND1Kfz7STCFAVFwyQvgFGakocUzK0jymFyrL+Yl9fwq8TvRc0/xeq9xOC/LIABdCLmF+U8
 dEbiXd06f8cl3B2tMedsFoBoDXmN4eI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-80-NvuQ328HN6uN_FlGR3afSg-1; Fri,
 28 Aug 2026 08:05:27 -0400
X-MC-Unique: NvuQ328HN6uN_FlGR3afSg-1
X-Mimecast-MFC-AGG-ID: NvuQ328HN6uN_FlGR3afSg_1787918726
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA26A1835AF5; Fri, 28 Aug 2026 12:05:25 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EA5FD7DB; Fri, 28 Aug 2026 12:05:24 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 28 Aug 2026 16:04:09 +0400
Subject: [PATCH v5 12/50] tests/qtest/pnv: drop unnecessary -serial mon:stdio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-qemu-no-hmp-v5-12-9227de146347@redhat.com>
References: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
In-Reply-To: <20260828-qemu-no-hmp-v5-0-9227de146347@redhat.com>
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
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkXk46GTUU1py5stmO6cvLAD9PXRTywnu1FhJr
 Fg/Uc8bFgOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapF5OAAKCRDa6OEJdZac
 5QOrD/oCiaIYSX5WPJa3EhN9CM2Hrv5H6FqfcmzqK39TQlsWW/aK6sD7q+Sc/ZWRYmGnX26H9gf
 IHTmQplkcrp68+MIA9U3L1JA6NyNQZWeTpRdZx57yxsB1IbbcC8LVtrrQvmKDtiAYb+mvpUpKNj
 ESd7APA11bYzau8xBrk6tBUlZJvI/iXfemoTWUtWf3CjEspEo96EvNYY6jiJ05uJB8s8qTvkIJA
 bu//HYsAYtVVI2jkvFXUDDezo+36LzZwfZPrlAzdY+v0w9QdbHgGHS3Wn0ONGlwL//roR6SBz8T
 trvFkazjt1IE7ffeP+U5ljeI5OSxepx8R263qLA9J2q5HG2OEkScwbvtyjtAmh2ei4So0Od9IdX
 ULxyLjSUKcW2F23kXBhPFkSihkIsN7V7col9Cs2V0KMDVnaxPnJwosB/l3CQqRe/Nva1pp5nQ9P
 vReysh6Pajyotfe10p/QoF9iQIhv6UbabcqOguUH8yNlgbXeErC7EHDPSsxvknn/bOK0zdwXn3n
 HS2ZuymOQyqgIA/EhZrMoTS3NwaW/K2B6fBEwWDQJajrBkwI0vpa2HL0yE0FsP0w8dexM/nEMiu
 iGwtz1FcSc8fKCa2j91rjhvHrCoJwtqGbbFEgkPDUbuj2jSi22yRz+t/xnZhEvPLC5Xp7z4pYjo
 griy27o/7DVZxcg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


