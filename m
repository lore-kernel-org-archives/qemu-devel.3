Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF97C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razg5-0005xc-KO; Fri, 16 Feb 2024 09:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razg0-0005s6-6R
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razfx-00082k-I6
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708095532;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jFra4CtkyGk1BwqGOvR1rHQxrN6FZdv0KmlgPIjRtIY=;
 b=H8jdjXt+rxWTsp1ksbviLR/pcnO5rCDiDi1Mty7tvMmiVwrAFNRVceTphpK+chx/gjXWIF
 MnjGUzNSruRaztUYRkdZtEPTVJpsD1usJisj8hIJKzKtth7/9qTUoONTkhEy6KUJdzIrcZ
 wfRffGueZ2pRP/o+W0UUfZ8wv2PKe4c=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-orax_jSYM2ys7nporySdUw-1; Fri,
 16 Feb 2024 09:58:49 -0500
X-MC-Unique: orax_jSYM2ys7nporySdUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 876C53813F38;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 65938492BE2;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 35D0421E5A58; Fri, 16 Feb 2024 15:58:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 13/16] qapi: Merge adjacent untagged sections
Date: Fri, 16 Feb 2024 15:58:37 +0100
Message-ID: <20240216145841.2099240-14-armbru@redhat.com>
In-Reply-To: <20240216145841.2099240-1-armbru@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The parser mostly doesn't create adjacent untagged sections, and
merging the ones it does create is hardly worth the bother.  I'm doing
it to avoid behavioral change in the next commit.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py                   | 3 +++
 tests/qapi-schema/doc-empty-features.out | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index de2ce3ec2c..48cc9a6367 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -719,6 +719,9 @@ def _start_features_section(self, name: str) -> None:
         self._start_symbol_section(self.features, name)
 
     def _start_section(self, tag: Optional[str] = None) -> None:
+        if not tag and not self._section.tag:
+            # extend current section
+            return
         if tag in ('Returns', 'Since') and self.has_section(tag):
             raise QAPIParseError(self._parser,
                                  "duplicated '%s' section" % tag)
diff --git a/tests/qapi-schema/doc-empty-features.out b/tests/qapi-schema/doc-empty-features.out
index 0f85623dde..473f59552d 100644
--- a/tests/qapi-schema/doc-empty-features.out
+++ b/tests/qapi-schema/doc-empty-features.out
@@ -14,6 +14,4 @@ command foo None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
 doc symbol=foo
     body=
-
-    section=None
 not a description
-- 
2.43.0


