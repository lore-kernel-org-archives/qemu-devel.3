Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB52C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:01:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm8i-0005nV-Aw; Tue, 14 Jan 2025 13:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm82-0005fs-I6
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm80-0002mS-6t
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736881142;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a/G4yc/p/2wMX6BiIvRIqUD+4hHDp8CTM3dlloufTPA=;
 b=O+h0a3fePlf54DqOZjlQnnmVkZFeuoRd/O3Xpq1sJ6t76PiqePUAJQwAAlCbQ3Aguugx8V
 LKoaCBNWHwdUTCtO9CqwsNhd/rZ91D78lOm81N4U9jNvmEjqnaIoys8tFFoLTZT8X6nHw4
 vOZI2yVZU13OSVnHqNM00TOXtwEO4JM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-h6dK_RcoP9y9kWIh6Jz0QQ-1; Tue,
 14 Jan 2025 13:58:58 -0500
X-MC-Unique: h6dK_RcoP9y9kWIh6Jz0QQ-1
X-Mimecast-MFC-AGG-ID: h6dK_RcoP9y9kWIh6Jz0QQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8D241954191; Tue, 14 Jan 2025 18:58:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9DF7B19560A3; Tue, 14 Jan 2025 18:58:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 09/23] qapi/source: allow multi-line QAPISourceInfo
 advancing
Date: Tue, 14 Jan 2025 13:58:26 -0500
Message-ID: <20250114185840.3058525-10-jsnow@redhat.com>
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

This is for the sake of the new rST generator (the "transmogrifier") so
we can advance multiple lines on occasion while keeping the
generated<-->source mappings accurate.

next_line now simply takes an optional n parameter which chooses the
number of lines to advance.

RFC: Here's the exorbitant detail on why I want this:

This is used mainly when converting section syntax in free-form
documentation to more traditional rST section header syntax, which
does not always line up 1:1 for line counts.

For example:

```
 ##
 # = Section     <-- Info is pointing here, "L1"
 #
 # Lorem Ipsum
 ##
```

would be transformed to rST as:

```
=======        <-- L1
Section        <-- L1
=======        <-- L1
               <-- L2
Lorem Ipsum    <-- L3
```

After consuming the single "Section" line from the source, we want to
advance the source pointer to the next non-empty line which requires
jumping by more than one line.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/source.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index 7b379fdc925..ffdc3f482ac 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -47,9 +47,9 @@ def set_defn(self, meta: str, name: str) -> None:
         self.defn_meta = meta
         self.defn_name = name
 
-    def next_line(self: T) -> T:
+    def next_line(self: T, n: int = 1) -> T:
         info = copy.copy(self)
-        info.line += 1
+        info.line += n
         return info
 
     def loc(self) -> str:
-- 
2.47.1


