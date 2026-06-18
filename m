Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00D25CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 17:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waGvB-0008MV-QK; Thu, 18 Jun 2026 13:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waGvA-0008LC-63
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1waGv8-0007wp-MH
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 13:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781805173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YkyHemMsuNTr89VtBokmxFdi2g1Xneh1sXw01D7UGgI=;
 b=YWNTnzUjzPsSDJUJenhbpkmAZ4emhfBNASnpn1Jp5dASP03z7LqvOCC+wcOFphsBh6dAKx
 kLn2iQpTxLyFYS0BM04wQvzd3qsw1B0Nfeq9mMVuUbrs26rMR95u/cRZQ1qE6p6JfwQptJ
 DcKCZSDVjLXgfjjpWusOVvkZL7elIsY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-nR5SQwviObm_2vJYntBePg-1; Thu,
 18 Jun 2026 13:52:52 -0400
X-MC-Unique: nR5SQwviObm_2vJYntBePg-1
X-Mimecast-MFC-AGG-ID: nR5SQwviObm_2vJYntBePg_1781805171
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14C50195607B
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 17:52:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A1EB630000DB; Thu, 18 Jun 2026 17:52:50 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Tom Stellard <tstellar@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/1] trace/control: Fix -Wunused-but-set-global warning with
 clang 23+
Date: Thu, 18 Jun 2026 13:52:47 -0400
Message-ID: <20260618175247.748320-2-stefanha@redhat.com>
In-Reply-To: <20260618175247.748320-1-stefanha@redhat.com>
References: <20260618175247.748320-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Tom Stellard <tstellar@redhat.com>

../trace/control.c:41:13: error: variable 'init_trace_on_startup' set but not used [-Werror,-Wunused-but-set-global]
   41 | static bool init_trace_on_startup;
      |             ^
1 error generated.

Signed-off-by: Tom Stellard <tstellar@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20260617224145.1419961-1-tstellar@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
2.54.0


