Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D57C44501
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 09:18:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZGK-00042V-Uz; Tue, 14 Jul 2026 05:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjZGI-00040m-1w
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wjZGG-0006iF-4c
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 05:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784020625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vsXzrxWP0GHHX6WtiiV5Xt0EqferLOFtROs031mmOds=;
 b=VcUb+sVI67iZGgWJ2uHFCDuN1AyHkZ48KAfu4xdpArLrBPQEsGN7N1wvm4t+IYkY1bV+mH
 fUm1SntsNKMKawb9QURNfNpockQrNw5iVbfp8yHl4LZJZ/dPUh7OQrr0Fy4cgPzfJJhKAs
 VjaiB0w7Dhq/2WZsz0mVgWR8x37/9Rs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-ChrXbyHQO-2LGc2j_kHMGA-1; Tue,
 14 Jul 2026 05:17:04 -0400
X-MC-Unique: ChrXbyHQO-2LGc2j_kHMGA-1
X-Mimecast-MFC-AGG-ID: ChrXbyHQO-2LGc2j_kHMGA_1784020623
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6FAA01955F3B
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:17:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C2F2D6E
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 09:17:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8615621E6827; Tue, 14 Jul 2026 11:17:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 4/4] json-parser: fix formatting of comment
Date: Tue, 14 Jul 2026 11:17:00 +0200
Message-ID: <20260714091700.3797064-5-armbru@redhat.com>
In-Reply-To: <20260714091700.3797064-1-armbru@redhat.com>
References: <20260714091700.3797064-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20260713114622.1950506-1-pbonzini@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Mea culpa]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/json-parser.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/qobject/json-parser.c b/qobject/json-parser.c
index 5935730c0c..6b1b4762bd 100644
--- a/qobject/json-parser.c
+++ b/qobject/json-parser.c
@@ -29,9 +29,10 @@
  * object, an error, or NULL (if the object is incomplete and no error
  * happened) after every token.  Therefore it has an explicit
  * representation of its parser stack; each stack entry consists of a
- * parser state and a QObject: - a QList, for an array that is being
- * added to - a QDict, for a dictionary that is being added to - a
- * QString, for the key of the next pair that will be added to a QDict
+ * parser state and a QObject:
+ * - a QList, for an array that is being added to
+ * - a QDict, for a dictionary that is being added to
+ * - a QString, for the key of the next pair that will be added to a QDict
  *
  * The stack represents an arbitrary nesting of arrays and dictionaries
  * (whose next key has been parsed); it can also have a dictionary whose
-- 
2.54.0


