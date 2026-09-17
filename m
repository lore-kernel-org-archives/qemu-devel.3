Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BCAC982D2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 19:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7I4F-0005pU-K6; Thu, 17 Sep 2026 15:46:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7I48-0005mW-Uy
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 15:46:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x7I47-0005Ek-Ha
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 15:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789674398;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZAVusv6m/bEGGSvcwML1ZDmyHw8pmyH0ioJKtxzotI=;
 b=UtUjd1lGP1mX7zUA9snS0VA7+Gn++t3OP4nJhPWGmbV2IgqDJUFsfjAJhNoKlmzTwQ+oIZ
 0QJ+/lPTYdLObYrx6XVP8bKX5G/YUikoH+Y2ilbjd8jz3wsVKKATaChxHiwEpOLa+zRZ0+
 JJMTEnH1gnXanKowGTCbwdI4bAAlbrM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-XRN2gd4AOfyppiFoVK7CjQ-1; Thu,
 17 Sep 2026 15:46:37 -0400
X-MC-Unique: XRN2gd4AOfyppiFoVK7CjQ-1
X-Mimecast-MFC-AGG-ID: XRN2gd4AOfyppiFoVK7CjQ_1789674395
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D27218F0F2B; Thu, 17 Sep 2026 19:46:35 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.85])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5584119AC049; Thu, 17 Sep 2026 19:46:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Junjie Cao <junjie.cao@intel.com>, Michael Roth <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-cxl@vger.kernel.org, Jason Wang <jasowangio@gmail.com>,
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>, Jonathan Cameron <jic23@kernel.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v5 5/7] qapi/parser: fix intermediate "intro" detection
Date: Thu, 17 Sep 2026 15:46:12 -0400
Message-ID: <20260917194614.549584-6-jsnow@redhat.com>
In-Reply-To: <20260917194614.549584-1-jsnow@redhat.com>
References: <20260917194614.549584-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 scripts/qapi/parser.py | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9e14c2f7921..dcc04b2663e 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -845,6 +845,14 @@ def _insert_after_intro(
         needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
         be sufficient.
         """
+        first = self.all_sections[0]
+        if first.text and first.kind == QAPIDoc.Kind.INTRO:
+            # First section is introduction and is non-empty: insert here.
+            # Rest assured all of this ugliness will very soon go away.
+            # Pinkie-swear.
+            self.all_sections.insert(1, section)
+            return
+
         index = 0
         for index, ref_section in enumerate(self.all_sections):
             if ref_section.kind.name in ("PLAIN", "INTRO"):
-- 
2.55.0


