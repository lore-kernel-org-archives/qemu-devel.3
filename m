Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDFF6D2A000
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:47:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0Hr-00060A-3A; Wed, 14 Jan 2026 07:47:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0HX-0005t0-Hm
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:47:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vg0HT-0002DR-9Q
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:47:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768394840;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0DcdU8cbY30HHoc3hMjLD0zlToFc9lRwGcPv0TnFyog=;
 b=LhIb8uroKcjfjQzEAZIOkDmENqcFdLfS4PfZAGuwRJjnnjjyZ0KGh1bxx3Jw4yq16qyiCU
 WajyBzMHgA8mRMOMVGnf4V38q5QVApAHBRsBJIDmdjFL+h0Le9XT0UH2S4QxMvmT+xvvuZ
 JFYOaWiOn1dX0Mc0vuvPphngsJWlzcE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-0Q8AIvuQNjGwPzX5zmqssQ-1; Wed,
 14 Jan 2026 07:47:17 -0500
X-MC-Unique: 0Q8AIvuQNjGwPzX5zmqssQ-1
X-Mimecast-MFC-AGG-ID: 0Q8AIvuQNjGwPzX5zmqssQ_1768394836
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CF9D180057E; Wed, 14 Jan 2026 12:47:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 379F530002D8; Wed, 14 Jan 2026 12:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A402321E6933; Wed, 14 Jan 2026 13:47:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com,
	dave@treblig.org
Subject: [PATCH 3/3] qemu-print: Document qemu_fprintf(),
 qemu_vfprintf() failure
Date: Wed, 14 Jan 2026 13:47:13 +0100
Message-ID: <20260114124713.3308719-4-armbru@redhat.com>
In-Reply-To: <20260114124713.3308719-1-armbru@redhat.com>
References: <20260114124713.3308719-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

These functions fail when @stream is null and the current monitor
isn't HMP.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-print.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/qemu-print.c b/util/qemu-print.c
index 4a30cd1a8e..bbf8c1823e 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -45,6 +45,7 @@ int qemu_printf(const char *fmt, ...)
 /*
  * Print like vfprintf()
  * Print to @stream if non-null, else to current monitor.
+ * Beware: the latter fails unless we have one and it is HMP.
  */
 int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
 {
@@ -57,6 +58,7 @@ int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
 /*
  * Print like fprintf().
  * Print to @stream if non-null, else to current monitor.
+ * Beware: the latter fails unless we have one and it is HMP.
  */
 int qemu_fprintf(FILE *stream, const char *fmt, ...)
 {
-- 
2.52.0


