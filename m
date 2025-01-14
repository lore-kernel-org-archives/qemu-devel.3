Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31917C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 18:59:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm8P-0005ij-S2; Tue, 14 Jan 2025 13:59:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm7t-0005eV-Bf
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm7o-0002kt-CC
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736881130;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9Rxj/WNy6u5pAcVBszc9E/LdxdMVNShv4fm7WS/rUk=;
 b=JNREztXLSptvIxDfs8nUTG0G71utcqU8/WsEOKgQ5cXpIf+wXaikPph6SkAbgVMpt40u6m
 SX0m93wzM2FDpfOEEmp7yhS888Xe52t0JmhtESZICi87c5N8BeoxEcPbcjwsF14doKWFzX
 3SmPuYYhWibhtUvdOEuwB39u226Nqo0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-uW9FY2BtPBq88g0N0BStuQ-1; Tue,
 14 Jan 2025 13:58:48 -0500
X-MC-Unique: uW9FY2BtPBq88g0N0BStuQ-1
X-Mimecast-MFC-AGG-ID: uW9FY2BtPBq88g0N0BStuQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9D13F19560B0; Tue, 14 Jan 2025 18:58:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 83B3919560A3; Tue, 14 Jan 2025 18:58:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 02/23] qapi/parser: adjust info location for doc body
 section
Date: Tue, 14 Jan 2025 13:58:19 -0500
Message-ID: <20250114185840.3058525-3-jsnow@redhat.com>
In-Reply-To: <20250114185840.3058525-1-jsnow@redhat.com>
References: <20250114185840.3058525-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Instead of using the info object for the doc block as a whole (which
always points to the very first line of the block), update the info
pointer for each call to ensure_untagged_section when the existing
section is otherwise empty. This way, Sphinx error information will
match precisely to where the text actually starts.

For example, this patch will move the info pointer for the "Hello!"
untagged section ...

> ##       <-- from here ...
> # Hello! <-- ... to here.
> ##

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index adc85b5b394..36cb64a677a 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -687,7 +687,11 @@ def end(self) -> None:
     def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
         if self.all_sections and not self.all_sections[-1].tag:
             # extend current section
-            self.all_sections[-1].text += '\n'
+            section = self.all_sections[-1]
+            if not section.text:
+                # Section is empty so far; update info to start *here*.
+                section.info = info
+            section.text += '\n'
             return
         # start new section
         section = self.Section(info)
-- 
2.47.1


