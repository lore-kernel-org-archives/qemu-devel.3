Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C32F8C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:49:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqZl-0000Xr-78; Mon, 10 Mar 2025 23:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqYF-0006Yh-2x
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:45:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqYD-0002aY-Dm
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:45:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4Ytk19LX55+7EpSEI8rLdCV9fHRThZbGNWh/JRZGlk=;
 b=g3da+rnJoS6qj4IZjkNmlHo3DCDzV6XAzvjg0obXJYWTfns0qKP7fKKRU8Be+Un7+cVoq9
 2RFraGY4XbQpK8d0EhKsPfNTUN+TePmfdHBktgwQeCG8OEg+1zO25PyrBBUzBqcUjEs/6y
 cxEY5kEZA+ZBUzmo8BDhcmh3CYFHhr8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-bDE8HBOwNkGAImi-Q8Xg9A-1; Mon,
 10 Mar 2025 23:45:01 -0400
X-MC-Unique: bDE8HBOwNkGAImi-Q8Xg9A-1
X-Mimecast-MFC-AGG-ID: bDE8HBOwNkGAImi-Q8Xg9A_1741664700
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3792195608B; Tue, 11 Mar 2025 03:44:59 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BCF951828A81; Tue, 11 Mar 2025 03:44:56 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 32/63] qapi/parser: adjust info location for doc body
 section
Date: Mon, 10 Mar 2025 23:42:30 -0400
Message-ID: <20250311034303.75779-33-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This doesn't seem to improve error reporting now. It will with the
forthcoming QAPI doc transmogrifier.

If I stick bad rST into qapi/block-core.json like this:

>  ##
>  # @SnapshotInfo:
>  #
> +# rST syntax error: *ahh!
> +#
>  # @id: unique shapshot id
>  #
>  # @name: user chosen name

The existing code's error message will point to the beginning of the doc
comment, which is less than helpful. The transmogrifier's message will
point to the erroneous line, but to accomplish this, it needs this
patch.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 64f0bb824ae..97def9f0e4f 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -686,7 +686,11 @@ def end(self) -> None:
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
2.48.1


