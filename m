Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791E1D0E6F4
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 11:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2qgx-00025h-Eo; Mon, 21 Oct 2024 07:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qgv-00025C-8J
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t2qgs-0001Uq-9y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 07:35:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729510513;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6c4zfgPK1uXbCp9TP3YFdnWGgDrkyRl4csOphvPzFG8=;
 b=KJj4VF75mhIBBCg4qVO8fcL082tu8EU5QkQV6TgNvdUvpRyAS/4Lq4d35teVq08v73fnei
 mahQkUDVrM+YtWJJYycEpSuoTfi2g89loGn9pBe+nLbe2ZxHRE61DIkgH0ds7d2+Xztt0a
 Xz9BmRUom6YZl070EJImeSE1i3VP7qw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49-5CEe5B-DOQSTK3fjfoLHEQ-1; Mon,
 21 Oct 2024 07:35:10 -0400
X-MC-Unique: 5CEe5B-DOQSTK3fjfoLHEQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2240519560BE; Mon, 21 Oct 2024 11:35:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.49])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0922619560AA; Mon, 21 Oct 2024 11:35:07 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 02/21] tests/qtest: Raise the ide-test timeout
Date: Mon, 21 Oct 2024 13:34:39 +0200
Message-ID: <20241021113500.122500-3-thuth@redhat.com>
In-Reply-To: <20241021113500.122500-1-thuth@redhat.com>
References: <20241021113500.122500-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.421,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

The ide-test occasionally times out: on the system I run
vm-build-openbsd on, it usually takes about 18 seconds, but
occasionally hits the 60s timeout, likely when the host machine is
under heavy load.  I have also seen this test hit its time limit on
the s390x CI runner.

Double the timeout for this test so that it won't hit its timeout
even when the host is running more slowly than usual.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20241015113705.239067-1-peter.maydell@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index b207e38696..e8be8b3942 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -4,6 +4,7 @@ slow_qtests = {
   'bios-tables-test' : 910,
   'cdrom-test' : 610,
   'device-introspect-test' : 720,
+  'ide-test' : 120,
   'migration-test' : 480,
   'npcm7xx_pwm-test': 300,
   'npcm7xx_watchdog_timer-test': 120,
-- 
2.47.0


