Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E1AC3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 00:24:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgCfF-0007F1-RL; Mon, 19 Aug 2024 20:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCf2-00062k-Gu
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sgCf0-0003tG-Jb
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 20:23:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724113422;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+BWut0oMwogFBURxJ7pVFl65sLZ5cIGHleFZfkcXaHk=;
 b=eoO5OvX+xE0RRWIQvO+pXmjmTd0j+3m0xpAywJ7y8wpctfXkgnBn0/RZXB7Q+xvmk1YJqW
 0gW7y9shWjRtWFqnGtBt16eZAFeu2EMvHDqMeDX3lLEACUhzCSSqZAtsMRcMsQacjr97Q/
 wE8/74I8smh8fmja5XejTFKpfZw6xhs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-TxBZQL6uMXO8wIz1apXwKQ-1; Mon,
 19 Aug 2024 20:23:39 -0400
X-MC-Unique: TxBZQL6uMXO8wIz1apXwKQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 145261955D57; Tue, 20 Aug 2024 00:23:38 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.8.20])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8034A1956053; Tue, 20 Aug 2024 00:23:35 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Beraldo Leal <bleal@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 6/8] python: allow short names for variables on older pylint
Date: Mon, 19 Aug 2024 20:23:15 -0400
Message-ID: <20240820002318.1380276-7-jsnow@redhat.com>
In-Reply-To: <20240820002318.1380276-1-jsnow@redhat.com>
References: <20240820002318.1380276-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.134,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pylint >= 3.0.0 disabled this feature, but older pylint does not: allow
short names by default by using a regex to do so.

Incidentally, this removes the need for most of the allow list we had before, so
remove most of that, too.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/setup.cfg | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/python/setup.cfg b/python/setup.cfg
index 72b58c98c99..58dba90f815 100644
--- a/python/setup.cfg
+++ b/python/setup.cfg
@@ -148,17 +148,11 @@ disable=consider-using-f-string,
 
 [pylint.basic]
 # Good variable names which should always be accepted, separated by a comma.
-good-names=i,
-           j,
-           k,
-           ex,
-           Run,
-           _,   # By convention: Unused variable
-           fh,  # fh = open(...)
-           fd,  # fd = os.open(...)
-           c,   # for c in string: ...
-           T,   # for TypeVars. See pylint#3401
-           SocketAddrT,  # Not sure why this is invalid.
+good-names=SocketAddrT,  # Not sure why this is invalid.
+
+# pylint < 3.0 warns by default on short variable names.
+# Disable this for older versions.
+good-names-rgxs=^[_a-z][_a-z0-9]?$
 
 [pylint.similarities]
 # Ignore imports when computing similarities.
-- 
2.45.0


