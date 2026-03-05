Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCEA6F33A6B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9Kg-0002PY-BC; Thu, 05 Mar 2026 09:05:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy9KL-0002Ma-Cl
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:05:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vy9KJ-0007qa-PR
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:05:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772719518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XhfFN8U15NqB4Bc6DcRHQSgS6GgvH/Lw/q/0TJZP/GA=;
 b=XQJu28lcShunCPDaIlLtBByhaTIbpfPxRW9lY7mbt3Nb6loSV1+2N4ejnEbMVQK1pM10wT
 IVETtW2MhlbmiQHQGt5ttVluVf7EGRf4iDP5lNZYOPNhO/d3reeqOf1Covy8yhfXf4xK1m
 m8HsFcjLgszsDE7W/P1ieFHY3MBEE0Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-ObZrjnyJOueoy86V0dWong-1; Thu,
 05 Mar 2026 09:05:15 -0500
X-MC-Unique: ObZrjnyJOueoy86V0dWong-1
X-Mimecast-MFC-AGG-ID: ObZrjnyJOueoy86V0dWong_1772719514
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BDF118005BD; Thu,  5 Mar 2026 14:05:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EF7C01800576; Thu,  5 Mar 2026 14:05:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A6D5421E6884; Thu, 05 Mar 2026 15:05:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 5/6] qemu-print: Document qemu_fprintf(),
 qemu_vfprintf() failure
Date: Thu,  5 Mar 2026 15:05:07 +0100
Message-ID: <20260305140508.218316-6-armbru@redhat.com>
In-Reply-To: <20260305140508.218316-1-armbru@redhat.com>
References: <20260305140508.218316-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
2.53.0


