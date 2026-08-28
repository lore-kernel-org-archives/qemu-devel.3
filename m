Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E62C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:44:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x03Pf-0006J6-Oj; Fri, 28 Aug 2026 16:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03Pc-0005xU-Au
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x03PY-0008DN-6f
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 16:42:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787949771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uU8sds7aM6wAilrJnyaQ3kr01ihnKymK2P5WMvoYwbg=;
 b=YTfttf44CD9M1ey6gXFOjuOkB72s92TQ/VLc2NgTLFbm+AzDsSgThOyPP79SKj5zdvUB4M
 a3Jr90fZmbDvuVoBojHV5ALQThqWp1zoSAL/yUxQJbx+A12oTJYG0suzEsZyHN3QyvP/YZ
 PJhXVksgzIvmWDUw1lxWkJ0ojLxWUYE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-294-Y1pwp4HgMXu1sZJUpo3SPA-1; Fri,
 28 Aug 2026 16:42:44 -0400
X-MC-Unique: Y1pwp4HgMXu1sZJUpo3SPA-1
X-Mimecast-MFC-AGG-ID: Y1pwp4HgMXu1sZJUpo3SPA_1787949763
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C5F618A3C11; Fri, 28 Aug 2026 20:42:43 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 60D281955F0A; Fri, 28 Aug 2026 20:42:42 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sat, 29 Aug 2026 00:41:51 +0400
Subject: [GIT PULL 12/50] tests/qtest/pnv: drop unnecessary -serial mon:stdio
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260829-nohmp-v1-12-4dcc2b4b0055@redhat.com>
References: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
In-Reply-To: <20260829-nohmp-v1-0-4dcc2b4b0055@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, Nicholas Piggin <npiggin@gmail.com>, 
 Aditya Gupta <adityag@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Gautam Menghani <gautam@linux.ibm.com>, qemu-ppc@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=1840;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qZLyCeiYWh2MeR/q2fqqG83AqU+7LAiJGxG5LAGGE0s=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqkfKUPXoBC2fUDOnVl03NcDGH0lHCmlEQeH9CW
 q0DtsfAuqiJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapHylAAKCRDa6OEJdZac
 5bVBD/46SxRdy6lOG7+N2W0HVpsjdW9qaf16lc8MiA+AFDk7Lpu1iNBEPUr0c4pIQbzcPH2ZT9F
 J6NBumD5FurpHMa7aw/C+tpYJlo7rIWOCioYfopZnCj1EjwivggeBzpjspKrvqLwFyXhfa6Vvrf
 ZbkPz+OYuqWQ6CC2Iwp7pS+GeDh8eRrpueWkXN8osyXv7YvUzJplukk4NlEwjBgk7Gqph4wCrHG
 hJu9CW5ghosNKBpf3YYpNcD/AHkOsv58iM17jfhPD/iIcKvIwFXxzj2jQ/iHfd4+uXLNEUUxHKD
 R/Axq0/uwNjTj9oDgFrGsDoeAW8xzlgGH/DmGHE5Xv34Dt4MUGF8luXSwxTC8Qv9Qv4IpQHnvsk
 EzIQgnO/Vnt+gVNcsQ0cXMUDXIfmabDHliiMQ+4Hj5cYrcW7Tur5zNqEQurgaDaOMszqfufg/Po
 68uOLQ4+W09IoC6IOfWaXz3SGNOmfjWP/3n2Un4RfmYWKLoLmkoESGw3Dvi56Sos+snxcCdgRjA
 C9jW8X7Va3PicgGDqFtJdSuZEK6VKAxUdXIMy/jdD86RML0TRbfUzXGGfDp2als2Dzo0WhmsScw
 lYW/hiq30YC4X5DxiPLh9/ENj4bfHH3Jd6sT7APwaoOPyK7cNBBJptYkL9icayOXZNPJ1jYiSGt
 fel2/HPS3Zcz2Fg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
Message-ID: <20260828-qemu-no-hmp-v5-12-9227de146347@redhat.com>
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


