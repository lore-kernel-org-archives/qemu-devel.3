Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1610C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:00:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razg4-0005w4-6p; Fri, 16 Feb 2024 09:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razfx-0005ky-24
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razfu-000800-S8
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708095529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IF7JxkVNUntYDGAKBfbnah3OG7b1sydltmlm+PpIuks=;
 b=ItBwwk9kF3p4fDxw0RSD26SGJlIlSvt7J9gdtcDei7lu3KBIjHW8vShCR6fdDwxwZr+PK0
 mMQDJbk8fc1x0p8Q+xLvmL0PtG6c/lKB05n0eI6DyvH0VuZSKaWJgN1jJj/TsGGYRvsWBQ
 cC4Nc15cwsvV2lz7w/68YihTPtE02PE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-lgoka0ZjOy6FjcD6RWELJw-1; Fri, 16 Feb 2024 09:58:48 -0500
X-MC-Unique: lgoka0ZjOy6FjcD6RWELJw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1946A101A52A;
 Fri, 16 Feb 2024 14:58:48 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EAA50492BC6;
 Fri, 16 Feb 2024 14:58:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1425B21E65EB; Fri, 16 Feb 2024 15:58:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 03/16] tests/qapi-schema: Cover 'Features:' not followed by
 descriptions
Date: Fri, 16 Feb 2024 15:58:27 +0100
Message-ID: <20240216145841.2099240-4-armbru@redhat.com>
In-Reply-To: <20240216145841.2099240-1-armbru@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
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

A 'Features:' line without any features is useless, but not an error
now.  However, a later commit will make it one, because that makes
rejecting duplicate 'Features:' easier.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/doc-empty-features.err  |  0
 tests/qapi-schema/doc-empty-features.json | 10 ++++++++++
 tests/qapi-schema/doc-empty-features.out  | 19 +++++++++++++++++++
 tests/qapi-schema/meson.build             |  1 +
 4 files changed, 30 insertions(+)
 create mode 100644 tests/qapi-schema/doc-empty-features.err
 create mode 100644 tests/qapi-schema/doc-empty-features.json
 create mode 100644 tests/qapi-schema/doc-empty-features.out

diff --git a/tests/qapi-schema/doc-empty-features.err b/tests/qapi-schema/doc-empty-features.err
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-empty-features.json b/tests/qapi-schema/doc-empty-features.json
new file mode 100644
index 0000000000..06f814e45d
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-features.json
@@ -0,0 +1,10 @@
+# 'Features:' line not followed by feature descriptions
+
+##
+# @foo:
+#
+# Features:
+#
+# not a description
+##
+{ 'command': 'foo' }
diff --git a/tests/qapi-schema/doc-empty-features.out b/tests/qapi-schema/doc-empty-features.out
new file mode 100644
index 0000000000..0f85623dde
--- /dev/null
+++ b/tests/qapi-schema/doc-empty-features.out
@@ -0,0 +1,19 @@
+module ./builtin
+object q_empty
+enum QType
+    prefix QTYPE
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+module doc-empty-features.json
+command foo None -> None
+    gen=True success_response=True boxed=False oob=False preconfig=False
+doc symbol=foo
+    body=
+
+    section=None
+not a description
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 4c714c792f..4b8329d070 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -71,6 +71,7 @@ schemas = [
   'doc-duplicated-return.json',
   'doc-duplicated-since.json',
   'doc-empty-arg.json',
+  'doc-empty-features.json',
   'doc-empty-section.json',
   'doc-empty-symbol.json',
   'doc-good.json',
-- 
2.43.0


