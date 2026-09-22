Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75AB2C98304
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:23:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x971G-0004UF-O2; Tue, 22 Sep 2026 16:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970X-0002Ro-RZ
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x970W-0000Gr-JO
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790108546;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=03QaRt2B3RoI2+iALPUtzvIRPMKnxpX4aGTTmWXZTP0=;
 b=gUl5lE6QybdF4iQMoNToT8rmhBWzAHQoCQLuKoEm0TE+C+g7GGzfFqSu0piaALlXvwcNTC
 /5HrSkQkEB4GnNaDgz7GAljx7RPVptoOTuefVDQYb64/uPU1EeOi+z8MHTLROWGH8UfPvO
 cqSoEpJDJbg5NwsQCKFDnlAuavwrQY8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-fbsgdV4eOjCHyM8TwAHLmw-1; Tue,
 22 Sep 2026 16:22:23 -0400
X-MC-Unique: fbsgdV4eOjCHyM8TwAHLmw-1
X-Mimecast-MFC-AGG-ID: fbsgdV4eOjCHyM8TwAHLmw_1790108542
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B39B183458F; Tue, 22 Sep 2026 20:22:22 +0000 (UTC)
Received: from localhost (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 99B173000223; Tue, 22 Sep 2026 20:22:21 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 23 Sep 2026 00:18:01 +0400
Subject: [PATCH 54/88] qemu-iotests/146: migrate away from HMP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260923-nohmp-v1-54-ebc029d4bd80@redhat.com>
References: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
In-Reply-To: <20260923-nohmp-v1-0-ebc029d4bd80@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
X-Developer-Signature: v=1; a=openpgp-sha256; l=603;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=gIZ+F2NHVPXgCtxtHRZBC4g4US4YscExD5nvOXJYWYI=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqsuKyP9Nz9uNsO/sLKgyuzs0snW3VDjIOXs7wa
 5G/wBY4ih6JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCarLisgAKCRDa6OEJdZac
 5c73D/4rLUrOBYLa8654it7BRUkX54hISfUzXpfBqIoehYHiDDWpu+LGT+FdQEps1LEkvQKewwP
 fhZg9Cxl59qAkG3eiWE4W1rLWutQ8t3Zm3xqzXfl2/1L69GN6xm1vH6VcevxFpe/EpcTHLw5tKh
 THFAGOEnHW09rbLHYpFQzPTvqL3nNtqbyWnB3vI7W9r3EbPONeb2xnoTrQL+MKdKokX81ebWJqc
 sFR5Re1moxMFmnhfNmca+m3foEizxdFbjj0SAKPJ7FpL4vv4C8oB7THc+2g1+Pc3mSEQI8fjx64
 JNa+7ecOb+X0FmFGEb2oOhjEyG76Mp+2uop1C7AoPZJJh9u01IzoC5yYukA7JJdqT1ZOl8GBcKJ
 +y6smP9NcTN76jVYbJOTibbsN4w54JQjhm6BUKBCp45KxlpXagMx0J6i/vEdmTGKi7WAKT+/C5k
 nISaLwMr9p3841yvf1DsK8Y866U4Q8SlEiE81bWmqAILdygzbdsP7/u0WvSvZqJH6YJhHxWwOJt
 x8bwZt+DGSOAW/sL/p/n2TaxpU9iw0MWpMBZM9m3HoO6aJnpdgSrbfnKS9SYHTy38sOhws2m98p
 zejwWLmJy3X9EkKwJFiNg0exeFaFf949tyUAls+n7LODyg4y99LgD4nEHAg3Tg3dpoNmkWK4WLO
 fUndn+vn7w2oQ6w==
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

HMP is actually unused.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 tests/qemu-iotests/146 | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/tests/qemu-iotests/146 b/tests/qemu-iotests/146
index f63291d0ffba..3cd41e8180a0 100755
--- a/tests/qemu-iotests/146
+++ b/tests/qemu-iotests/146
@@ -42,11 +42,6 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt vpc
 _supported_proto file
 _supported_os Linux
-_require_hmp
-
-
-qemu_comm_method="monitor"
-silent=
 
 echo
 echo === Testing VPC Autodetect ===

-- 
2.56.0.rc0.29.g47ce80527c56


