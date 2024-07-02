Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A06C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 10:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOapL-00046j-Da; Tue, 02 Jul 2024 06:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapJ-00045V-LP
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sOapG-000750-2y
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 06:33:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719916409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y0NL3aqv+v3DosFGjnrW8EZ2itT91S+J9/+IbzdYKwk=;
 b=TWG/oc4lV6FvFh7pMKr9Gb2qccK6oeBI3kXOS0Yk0T19DKIv6w6ao0VXvjqnUThHS6k+ab
 uT5EldvrvuWmha07sN70FKKU4928e2ND9RZbN8S3NwmtwYOFv9LXZ0oNGObzzTtlVQZZAi
 uz52eA23OZAdiywDhSllhAg8ehMwt9E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-5RNaKzizMyiyPZBd7JcGlQ-1; Tue,
 02 Jul 2024 06:33:27 -0400
X-MC-Unique: 5RNaKzizMyiyPZBd7JcGlQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D40F019560A6; Tue,  2 Jul 2024 10:33:26 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.116])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 86CD119560AA; Tue,  2 Jul 2024 10:33:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PULL 04/12] tests/qtest: Free unused QMP response
Date: Tue,  2 Jul 2024 12:33:02 +0200
Message-ID: <20240702103310.347201-5-thuth@redhat.com>
In-Reply-To: <20240702103310.347201-1-thuth@redhat.com>
References: <20240702103310.347201-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This fixes LeakSanitizer warnings.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20240627-san-v2-11-750bb0946dbd@daynix.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qtest/libqtest.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index c7f6897d78..ca46b1f8d0 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -749,6 +749,8 @@ QDict *qtest_qmp_receive(QTestState *s)
                         response, s->eventData)) {
             /* Stash the event for a later consumption */
             s->pending_events = g_list_append(s->pending_events, response);
+        } else {
+            qobject_unref(response);
         }
     }
 }
-- 
2.45.2


