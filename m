Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8BCD29DF3
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 09:41:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfara-0004oF-PU; Tue, 13 Jan 2026 04:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfarL-0003tk-Br
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfarJ-0003Wl-Pb
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 04:38:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768297121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t/ez37UZl0VfCletKk7E961niqzrd4GVb5O7hezAtxI=;
 b=S511ZyntR8r+a6daJZLuxSdzMk6h/z66RKjUWELFclsFEypT7IN4M8l9xV02yIv6JnoqZj
 dmVKvGVNxSM1dlG0V0KYrRect6EATFToTUsaidQ0x6+WdE8XWMphEOO3vNNl35+EtbBzd2
 hEw+njx3Df8X21G739LImNXMxBb1Up4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-516-kQrMskMMOyK1C79PJ7igzw-1; Tue,
 13 Jan 2026 04:38:37 -0500
X-MC-Unique: kQrMskMMOyK1C79PJ7igzw-1
X-Mimecast-MFC-AGG-ID: kQrMskMMOyK1C79PJ7igzw_1768297116
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9673C195423A; Tue, 13 Jan 2026 09:38:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.79])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9F4C30001A2; Tue, 13 Jan 2026 09:38:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 41/41] tests/rcutorture: Fix build error
Date: Tue, 13 Jan 2026 10:36:37 +0100
Message-ID: <20260113093637.1549214-42-clg@redhat.com>
In-Reply-To: <20260113093637.1549214-1-clg@redhat.com>
References: <20260113093637.1549214-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Newer gcc compiler (version 16.0.0 20260103 (Red Hat 16.0.0-0) (GCC))
detects an unused variable error:

  ../tests/unit/rcutorture.c: In function ‘rcu_read_stress_test’:
  ../tests/unit/rcutorture.c:251:18: error: variable ‘garbage’ set but not used [-Werror=unused-but-set-variable=]
    251 |     volatile int garbage = 0;
        |                  ^~~~~~~

Since the 'garbage' variable is used to generate memory reads from the
CPU while holding the RCU lock, it can not be removed. Tag it as
((unused)) instead to silence the compiler warnings/errors.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260112163350.1251114-1-clg@redhat.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 tests/unit/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/unit/rcutorture.c b/tests/unit/rcutorture.c
index 7662081683f5d781da74402113b73884780b1243..2f19d479a3f210cbca19205a0656eda1f4c2e5a7 100644
--- a/tests/unit/rcutorture.c
+++ b/tests/unit/rcutorture.c
@@ -248,7 +248,7 @@ static void *rcu_read_stress_test(void *arg)
     int pc;
     long long n_reads_local = 0;
     long long rcu_stress_local[RCU_STRESS_PIPE_LEN + 1] = { 0 };
-    volatile int garbage = 0;
+    volatile int garbage __attribute__ ((unused)) = 0;
 
     rcu_register_thread();
 
-- 
2.52.0


