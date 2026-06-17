Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB07CD98ED
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 22:43:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZyyb-0000ox-6z; Wed, 17 Jun 2026 18:43:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tstellar@redhat.com>)
 id 1wZyyX-0000oR-BN
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 18:43:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tstellar@redhat.com>)
 id 1wZyyV-0000YK-2f
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 18:43:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781736189;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=xMkd/iawPS9Ijv1QqTbNxNptAOb/d9qZNblWXd1EZJE=;
 b=BAKQgz4nbsvXwPXhw/u8dYbdycXAz7lscjjZK4D/h1Ku9qTbdfgXMqrArKiMhFyl/ipoiR
 LYPxteZchj2108NABsRCgRiLC/LUaPyy/W4bYYximN1d34Nq2yJjsd89aBwz5iKU+HK0xB
 q9uHAOZFSivQEp0CwDw+lNXdZlwP66o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-247-d_9ccMo1ODaoOZxCu-MRAQ-1; Wed,
 17 Jun 2026 18:42:02 -0400
X-MC-Unique: d_9ccMo1ODaoOZxCu-MRAQ-1
X-Mimecast-MFC-AGG-ID: d_9ccMo1ODaoOZxCu-MRAQ_1781736121
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F3B01955F01
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 22:42:01 +0000 (UTC)
Received: from tstellar-thinkpadp1gen4i.remote.csb (unknown [10.22.80.22])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B99FC3000223; Wed, 17 Jun 2026 22:42:00 +0000 (UTC)
From: Tom Stellard <tstellar@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tom Stellard <tstellar@redhat.com>
Subject: [PATCH] trace/control: Fix -Wunused-but-set-global warning with clang
 23+
Date: Wed, 17 Jun 2026 15:41:45 -0700
Message-ID: <20260617224145.1419961-1-tstellar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=tstellar@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

../trace/control.c:41:13: error: variable 'init_trace_on_startup' set but not used [-Werror,-Wunused-but-set-global]
   41 | static bool init_trace_on_startup;
      |             ^
1 error generated.

Signed-off-by: Tom Stellard <tstellar@redhat.com>
---
 trace/control.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/trace/control.c b/trace/control.c
index 1c8c50064a..49f0a4c5cd 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -38,7 +38,9 @@ static TraceEventGroup *event_groups;
 static size_t nevent_groups;
 static uint32_t next_id;
 static uint32_t next_vcpu_id;
+#ifdef CONFIG_TRACE_SIMPLE
 static bool init_trace_on_startup;
+#endif
 static char *trace_opts_file;
 
 QemuOptsList qemu_trace_opts = {
@@ -295,7 +297,9 @@ void trace_opt_parse(const char *optstr)
         trace_enable_events(qemu_opt_get(opts, "enable"));
     }
     trace_init_events(qemu_opt_get(opts, "events"));
+#ifdef CONFIG_TRACE_SIMPLE
     init_trace_on_startup = true;
+#endif
     g_free(trace_opts_file);
     trace_opts_file = g_strdup(qemu_opt_get(opts, "file"));
     qemu_opts_del(opts);
-- 
2.51.0


