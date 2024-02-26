Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2404C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZ0-0002gv-OC; Mon, 26 Feb 2024 05:50:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYd-0002b9-EC
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYZ-0003ie-6n
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQVYjud/iikXvNXQY29C36T+8gUjVDp21/TZqAtAHLE=;
 b=SYQiFSdauaOzhb7fVybWWBeuAry+0aGSLqlxBEKwWvMeKgTspM3b6k/8DjT2Rpv4L0ugQI
 TDqUvVejmq4LfChPjxQooVzGjIpyS7c4vlMPl1VQVV5WqIP0TapkxBhrIKV7ebP0JVijGE
 IWT6peV4x8OipAmCEMpVGB1IxehcgSw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-215-TSmN0kQsOlGzpmX2cytH2A-1; Mon,
 26 Feb 2024 05:49:56 -0500
X-MC-Unique: TSmN0kQsOlGzpmX2cytH2A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B33001C382A5;
 Mon, 26 Feb 2024 10:49:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90F21492BC7;
 Mon, 26 Feb 2024 10:49:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8F8EC21E66A3; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 04/17] tests/qapi-schema: Cover 'Features:' not followed by
 descriptions
Date: Mon, 26 Feb 2024 11:49:41 +0100
Message-ID: <20240226104954.3781985-5-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Message-ID: <20240216145841.2099240-4-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


