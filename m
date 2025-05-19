Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E01C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 18:24:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH58h-0002vA-Gv; Mon, 19 May 2025 14:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH58X-0002rr-5I
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH58T-0000gs-9m
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:22:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747678965;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLbLFiqORFw8cWiPNerRB88Dx75W953eXT2REMP2iHs=;
 b=IcHpuF0eDFq52SJfvSFfqlAKOisFQ6HwwNeOCPI6KT7wxDY+72rmqtuvJoVb7CG3gyJUAB
 I+oO3V+h4xjgpmxj7d9RRRV5j1VHaJxL9wzvWfYwQlu+S4W73LkYhntIQPSEctnGo+9xtM
 G1FcNnqQhlNgndLCkDqTOpyEMj5ZHJ4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-qh2hhjZNMH-Lt8rDbFnifw-1; Mon,
 19 May 2025 14:22:41 -0400
X-MC-Unique: qh2hhjZNMH-Lt8rDbFnifw-1
X-Mimecast-MFC-AGG-ID: qh2hhjZNMH-Lt8rDbFnifw_1747678959
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8FD4C195608C; Mon, 19 May 2025 18:22:39 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.235])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 759E519560A3; Mon, 19 May 2025 18:22:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 John Snow <jsnow@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 7/8] python: update mkvenv to type-check under different
 python versions
Date: Mon, 19 May 2025 14:21:51 -0400
Message-ID: <20250519182153.3835722-8-jsnow@redhat.com>
In-Reply-To: <20250519182153.3835722-1-jsnow@redhat.com>
References: <20250519182153.3835722-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Currently, we instruct mypy to pretend it is type checking under a
specific version of python. For our case, where our scripts may in fact
actually be executing under a number of different environments in the
build system, we want mypy to remove this restriction.

This patch adjusts some of the import logic in mkvenv.py to make it type
check under a wider range of python versions.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/scripts/mkvenv.py | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index b626903fa8d..1e86c0ffa9e 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -99,16 +99,18 @@
         HAVE_DISTLIB = False
 
 # Try to load tomllib, with a fallback to tomli.
-# HAVE_TOMLLIB is checked below, just-in-time, so that mkvenv does not fail
+# TOML is checked below, just-in-time, so that mkvenv does not fail
 # outside the venv or before a potential call to ensurepip in checkpip().
-HAVE_TOMLLIB = True
+TOML = None
 try:
     import tomllib
+    TOML = tomllib
 except ImportError:
     try:
-        import tomli as tomllib
+        import tomli
+        TOML = tomli
     except ImportError:
-        HAVE_TOMLLIB = False
+        pass
 
 # Do not add any mandatory dependencies from outside the stdlib:
 # This script *must* be usable standalone!
@@ -194,6 +196,7 @@ def compute_venv_libpath(context: SimpleNamespace) -> str:
         # Python 3.12+, not strictly necessary because it's documented
         # to be the same as 3.10 code below:
         if sys.version_info >= (3, 12):
+            assert isinstance(context.lib_path, str)
             return context.lib_path
 
         # Python 3.10+
@@ -710,7 +713,7 @@ def _do_ensure(
 
 
 def _parse_groups(file: str) -> dict[str, dict[str, Any]]:
-    if not HAVE_TOMLLIB:
+    if not TOML:
         if sys.version_info < (3, 11):
             raise Ouch("found no usable tomli, please install it")
 
@@ -722,7 +725,7 @@ def _parse_groups(file: str) -> dict[str, dict[str, Any]]:
     # Debian bullseye-backports) and v2.0.x
     with open(file, "r", encoding="ascii") as depfile:
         contents = depfile.read()
-        return tomllib.loads(contents)  # type: ignore
+        return TOML.loads(contents)  # type: ignore
 
 
 def ensure_group(
-- 
2.48.1


