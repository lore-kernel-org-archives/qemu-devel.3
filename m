Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC0FC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 11:52:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woJsN-0006LH-R6; Mon, 27 Jul 2026 07:52:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsM-0006J2-Sz
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1woJsL-0003j8-E0
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 07:52:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785153124;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Un9MFmgiI0GYdEwtMJsqGn6/GL6Qv/asRCSZZkrtJY=;
 b=ZGvVSRkwFNroWxJfxWGe6IzLJuCYiscp1ZNRXh3mqZEVhWt1FKWQBmDH+swjb8Ai8oHUnQ
 nryWDp+FkKarNGKbYa0Yzh3gWI+x29u7HW4u1fGY3p69CGKAFgVsclV1GKfpijaVX3ROeA
 a9K+1YIuHX5dm+0r7zEQ+g4LFoUCT3g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-41-I-QVTRD2Ob6Konlnq9-NUA-1; Mon,
 27 Jul 2026 07:52:01 -0400
X-MC-Unique: I-QVTRD2Ob6Konlnq9-NUA-1
X-Mimecast-MFC-AGG-ID: I-QVTRD2Ob6Konlnq9-NUA_1785153120
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 20666180067C; Mon, 27 Jul 2026 11:52:00 +0000 (UTC)
Received: from localhost (unknown [10.44.24.5])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AE0291800480; Mon, 27 Jul 2026 11:51:58 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 27 Jul 2026 15:51:14 +0400
Subject: [GIT PULL 05/23] net/colo: fix g_hash_table_destroy assertion on
 uninitialized filter
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260727-fix-v1-5-ca3fa3851347@redhat.com>
References: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
In-Reply-To: <20260727-fix-v1-0-ca3fa3851347@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Zhang Chen <zhangckid@gmail.com>, 
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowangio@gmail.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1171;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=OqIbE6DWbJhM40ezkRA+84k6vHrSNl5lG0Vfhey8LQQ=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqZ0Y+Qyqzv2w6egFn0YRrs8cUQPYDHCooJeLCU
 NCTZyGRZB+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCamdGPgAKCRDa6OEJdZac
 5b2CEACDP4CIUSatf/8X5R3nuQg+TEFNt6UsskWrIOgTQLZWIGuaA63F6fvxXdv907k7RQoZHfo
 8tJYSOrXBwNgjjgPmhu1MJWwg86Mixeq0oxjb/4ALXw5PUOVUsbYet7tx7fDZvbQVyB8q+mshEE
 RqCME6wsv295etw1uigoAFZniF1416/tKE7aOxW3romAgnlHNiSKOfIUO/AccuwmabdP9CFup8n
 k2a7T+xcLcSDZabwqXPrLJ9cwrddCdX/eWDq07etx8VYDCMnAt5wZIN0FfFjajITzAN59jFkmIp
 livyVr1ZmaD/6TLJ8VqiBZ3+2L873IQMjAvkAVwq/V7nQDwDVki5xLQ3JmsxboXRt5b24GNA5Es
 nzRR1rIYPtg1ekaGmQzhZNtIlI9zrD7rIm1dmChucavyAfk2TWYAaOrpltIJZbHXOu9rJdTqsqQ
 JTtHiWmXUDTPP3OMIg39mkfWyLpxXAYu41Zm+h6aWaKscprBrt6YukFYNluvqMUKc4vB+u+wl7b
 ZJJJu8KevU7PJIADOg5x0VIOjpat5Hw4KrHeOB4hVd2CCyjWv3duvAi1by9NHJ6zo6XcDlr8VJU
 zP4+VwAJn8sKKa5B34x/Y2sYpu0HvKn5TixhJAqfX/Hy0BoYgbPC/OD6ein7ZineetjmcluVRrc
 ryRf+19w4As3drw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

colo_rewriter_cleanup() unconditionally destroys connection_track_table,
but the table is only allocated in colo_rewriter_setup(). When the
filter-rewriter object is finalized without having been set up (e.g.
during qom-test property enumeration), the pointer is NULL and
g_hash_table_destroy() fires an assertion.

Use g_clear_pointer() to skip the destroy when the table was never
initialized.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Zhang Chen <zhangckid@gmail.com>
Message-ID: <20260709111315.1108185-1-marcandre.lureau@redhat.com>
---
 net/filter-rewriter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
index cdf85aa5eed3..c85d180eb963 100644
--- a/net/filter-rewriter.c
+++ b/net/filter-rewriter.c
@@ -373,7 +373,7 @@ static void colo_rewriter_cleanup(NetFilterState *nf)
         g_free(s->incoming_queue);
     }
 
-    g_hash_table_destroy(s->connection_track_table);
+    g_clear_pointer(&s->connection_track_table, g_hash_table_destroy);
 }
 
 static void colo_rewriter_setup(NetFilterState *nf, Error **errp)

-- 
2.55.0


