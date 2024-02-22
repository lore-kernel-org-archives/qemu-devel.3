Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4528EC5478C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rd5lf-0007Xb-4I; Thu, 22 Feb 2024 04:53:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5ld-0007Wp-MZ
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rd5lc-0006oL-7p
 for qemu-devel@nongnu.org; Thu, 22 Feb 2024 04:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708595602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YrjZy0FuhbxBEP9u9XFV47cbHOZBoaPzqp9FQlFMFqk=;
 b=Og0uUGVWC0Cz1+zUHFXGjgnZlkUxz9Jo0SDMxxHXstwUsAF2DMNuctzzoI/vqsy1+GEMhr
 tS2XaPIyatRvE4unUkvZPQCF6YqhY/iUZQNettRrmZ4kOIL0t3UZOqttQE2cbDhhaZBScM
 hJjVIpqQzVLWLKG/L04FO1zcg1CUKq8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-AKpTQ6ePNOSj7b_D8gJDDA-1; Thu,
 22 Feb 2024 04:53:18 -0500
X-MC-Unique: AKpTQ6ePNOSj7b_D8gJDDA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 94AAB3C11C67;
 Thu, 22 Feb 2024 09:53:18 +0000 (UTC)
Received: from x1n.redhat.com (unknown [10.72.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 976418CED;
 Thu, 22 Feb 2024 09:53:15 +0000 (UTC)
From: peterx@redhat.com
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/5] migration/multifd: Make multifd_channel_connect()
 return void
Date: Thu, 22 Feb 2024 17:52:59 +0800
Message-ID: <20240222095301.171137-4-peterx@redhat.com>
In-Reply-To: <20240222095301.171137-1-peterx@redhat.com>
References: <20240222095301.171137-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

It never fails, drop the retval and also the Error**.

Suggested-by: Avihai Horon <avihaih@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/multifd.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index da2e7c1db1..f52f01ca85 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -925,9 +925,7 @@ static bool multifd_tls_channel_connect(MultiFDSendParams *p,
     return true;
 }
 
-static bool multifd_channel_connect(MultiFDSendParams *p,
-                                    QIOChannel *ioc,
-                                    Error **errp)
+static void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc)
 {
     qio_channel_set_delay(ioc, false);
 
@@ -938,7 +936,6 @@ static bool multifd_channel_connect(MultiFDSendParams *p,
     p->thread_created = true;
     qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
                        QEMU_THREAD_JOINABLE);
-    return true;
 }
 
 /*
@@ -970,7 +967,8 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
             return;
         }
     } else {
-        ret = multifd_channel_connect(p, ioc, &local_err);
+        multifd_channel_connect(p, ioc);
+        ret = true;
     }
 
 out:
-- 
2.43.0


