Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3C2CD3430
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEId-0000Ka-14; Tue, 05 May 2026 07:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIY-0000HG-In
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIV-0001Vl-OD
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777981842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMXQyvnHEAG9TIhUUaRQwYWOhE0K0bK8wtDC9fUTs7k=;
 b=AyUq2gR5o6hfat+FngbH7VqsZK8T8QyHwkXVyxhSbgm6mzMmmYLRmz+zWP6yBepO0eoxlm
 KJ2Vwa6Atkv8UMAM4zQqTmkt1tPyDJ3jq1bI6LVi2+afZOiJHsgndwSE3m+zxNwtlaOyhM
 8CAs5QQJJYQUgUmOCSulqmcYsXPh7W4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-197-vgSwlRGAOm2NoAAoT96D4Q-1; Tue,
 05 May 2026 07:50:40 -0400
X-MC-Unique: vgSwlRGAOm2NoAAoT96D4Q-1
X-Mimecast-MFC-AGG-ID: vgSwlRGAOm2NoAAoT96D4Q_1777981839
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C76618003FC
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 11:50:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4641A30001BE
 for <qemu-devel@nongnu.org>; Tue,  5 May 2026 11:50:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CF17121E6A07; Tue, 05 May 2026 13:50:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
Subject: [PULL 4/5] qemu-print: Document qemu_fprintf(),
 qemu_vfprintf() failure
Date: Tue,  5 May 2026 13:50:35 +0200
Message-ID: <20260505115036.1170186-5-armbru@redhat.com>
In-Reply-To: <20260505115036.1170186-1-armbru@redhat.com>
References: <20260505115036.1170186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-ID: <20260114124713.3308719-4-armbru@redhat.com>
[Comments rewritten in review]
---
 util/qemu-print.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/util/qemu-print.c b/util/qemu-print.c
index 4a30cd1a8e..7b9591035e 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -44,7 +44,10 @@ int qemu_printf(const char *fmt, ...)
 
 /*
  * Print like vfprintf()
- * Print to @stream if non-null, else to current monitor.
+ * Print to @stream if non-null, else to current HMP monitor if we
+ * have one, else fail without printing anything.
+ * Return number of characters printed on success, negative value on
+ * error.
  */
 int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
 {
@@ -56,7 +59,10 @@ int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
 
 /*
  * Print like fprintf().
- * Print to @stream if non-null, else to current monitor.
+ * Print to @stream if non-null, else to current HMP monitor if we
+ * have one, else fail without printing anything.
+ * Return number of characters printed on success, negative value on
+ * error.
  */
 int qemu_fprintf(FILE *stream, const char *fmt, ...)
 {
-- 
2.54.0


