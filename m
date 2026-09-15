Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46140C982C5
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:13:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6Upf-00014V-PT; Tue, 15 Sep 2026 11:12:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6UpO-0000zu-VZ
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:12:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x6UpN-00006y-AF
 for qemu-devel@nongnu.org; Tue, 15 Sep 2026 11:12:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789485128;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+/TEs6WfoqvbeLKb/7GlRm0zX4tMP9iSW1sKdXtrjYQ=;
 b=KF4bZHAHkLFrvJufZHw+MYfEql+r/UhGgtRpZJgGUGfidPROwd5Vq5SqniM7Q+z6vdfP2X
 etQzGQIYzcmNx4YRs1l1eiHoAshWQq308zAXucIvakLzvkABcVZDLADMlwxDniRK5sDaFr
 6zZVmqT0GaLwVipo4xAe7BbZsY6pk3Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-332-8zwyUbarOoeWSs4bnphLzQ-1; Tue,
 15 Sep 2026 11:12:05 -0400
X-MC-Unique: 8zwyUbarOoeWSs4bnphLzQ-1
X-Mimecast-MFC-AGG-ID: 8zwyUbarOoeWSs4bnphLzQ_1789485123
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 608141956077; Tue, 15 Sep 2026 15:12:03 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.46])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 93C33195604E; Tue, 15 Sep 2026 15:11:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jonathan Cameron <jic23@kernel.org>, Kevin Wolf <kwolf@redhat.com>,
 Peter Xu <peterx@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Lukas Straub <lukasstraub2@web.de>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 linux-cxl@vger.kernel.org, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 5/7] qapi/parser: fix intermediate "intro" detection
Date: Tue, 15 Sep 2026 11:11:25 -0400
Message-ID: <20260915151127.1002244-6-jsnow@redhat.com>
In-Reply-To: <20260915151127.1002244-1-jsnow@redhat.com>
References: <20260915151127.1002244-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

In 43e7ad1a3fa5, I adjusted the insertion algorithm for inserting
something after the "introduction" to cope with both the old and new
syntax while we converted QAPI to the new syntax. There's a bug in
that code that only shows up in a handful of cases and only when using
the new syntax while this affordance/flex code is still enabled.

In the case that we do actually have a real bona-fide intro section,
we want to insert directly after that real-deal intro section, not
after any plaintext sections that may follow it. This code adjusts the
temporary code to strongly prefer inserting after the actual intro
section if it exists.

Once again: once conversion is done, you will be delighted by how much
of this ugly code goes away.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9e14c2f7921..6ded504835d 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -845,6 +845,16 @@ def _insert_after_intro(
         needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
         be sufficient.
         """
+        first = self.all_sections[0]
+        if first.text and first.kind == QAPIDoc.Kind.INTRO:
+            # First section is introduction and is non-empty: insert here.
+            # Rest assured all of this ugliness will very soon go away.
+            # Pinkie-swear.
+            return self._insert_near_kind(
+                QAPIDoc.Kind.INTRO, section, after=True
+            )
+
+
         index = 0
         for index, ref_section in enumerate(self.all_sections):
             if ref_section.kind.name in ("PLAIN", "INTRO"):
-- 
2.55.0


