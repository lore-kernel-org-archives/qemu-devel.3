Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DF8CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Aug 2025 20:50:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ulZSf-00026N-3l; Mon, 11 Aug 2025 16:49:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ulZSd-00025m-Ab
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 16:49:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ulZSX-0008V2-Jr
 for qemu-devel@nongnu.org; Mon, 11 Aug 2025 16:49:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754945366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=CQbe91S3uYByF6cPyraY71e5cBELSRKSscwlqRZokVA=;
 b=hsdyRLhCCi3Mr3Pr9MaYkyEfjSK2MpiIKHf07JNIqnCC/vHF7zUguzHjPa2nt5rGtSmGm9
 l2eELZNaE0PmKmG4yDn+t3Tcx1SD9VU6ClWsnC8dMg16VMYT4e87AypnN8huX0YX3Icofq
 KDbCi9dyuh6h0ANyftipeuSIB4HY4bM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-7EhFESGmMC-2UMNpAXX3-w-1; Mon,
 11 Aug 2025 16:49:24 -0400
X-MC-Unique: 7EhFESGmMC-2UMNpAXX3-w-1
X-Mimecast-MFC-AGG-ID: 7EhFESGmMC-2UMNpAXX3-w_1754945363
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3EA76180044F; Mon, 11 Aug 2025 20:49:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.164])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49F051955F16; Mon, 11 Aug 2025 20:49:19 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH] mkvenv: support pip 25.2; prefer packaging over distlib
Date: Mon, 11 Aug 2025 16:49:18 -0400
Message-ID: <20250811204918.260524-1-jsnow@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Stop using distlib LegacyVersion parsing and begin using `packaging`
version parsing instead.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 python/scripts/mkvenv.py | 39 +++++++++++++++++++++++++++++++++------
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 8ac5b0b2a05..1aa9fc7badb 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -94,17 +94,32 @@
 HAVE_DISTLIB = True
 try:
     import distlib.scripts
-    import distlib.version
 except ImportError:
     try:
         # Reach into pip's cookie jar.  pylint and flake8 don't understand
         # that these imports will be used via distlib.xxx.
         from pip._vendor import distlib
         import pip._vendor.distlib.scripts  # noqa, pylint: disable=unused-import
-        import pip._vendor.distlib.version  # noqa, pylint: disable=unused-import
     except ImportError:
         HAVE_DISTLIB = False
 
+
+HAVE_PACKAGING = True
+try:
+    import packaging.requirements  # type: ignore
+    import packaging.version  # type: ignore
+except ImportError:
+    try:
+        # Reach into pip's cookie jar yet again.
+        # Shush all the tools rightly telling us this is a bad idea.
+        # pylint: disable=ungrouped-imports, unused-import
+        from pip._vendor import packaging  # type: ignore
+        import pip._vendor.packaging.requirements
+        import pip._vendor.packaging.version  # noqa
+    except ImportError:
+        HAVE_PACKAGING = False
+
+
 # Try to load tomllib, with a fallback to tomli.
 # HAVE_TOMLLIB is checked below, just-in-time, so that mkvenv does not fail
 # outside the venv or before a potential call to ensurepip in checkpip().
@@ -669,12 +684,22 @@ def _do_ensure(
     canary = None
     for name, info in group.items():
         constraint = _make_version_constraint(info, False)
-        matcher = distlib.version.LegacyMatcher(name + constraint)
-        print(f"mkvenv: checking for {matcher}", file=sys.stderr)
+        req = packaging.requirements.Requirement(name + constraint)
+
+        def _match(
+            req: 'packaging.requirements.Requirement',
+            version_str: str
+        ) -> bool:
+            return bool(req.specifier.contains(
+                packaging.version.Version(version_str),
+                prereleases=True
+            ))
+
+        print(f"mkvenv: checking for {req}", file=sys.stderr)
 
         dist: Optional[Distribution] = None
         try:
-            dist = distribution(matcher.name)
+            dist = distribution(req.name)
         except PackageNotFoundError:
             pass
 
@@ -683,7 +708,7 @@ def _do_ensure(
             # Always pass installed package to pip, so that they can be
             # updated if the requested version changes
             or not _is_system_package(dist)
-            or not matcher.match(distlib.version.LegacyVersion(dist.version))
+            or not _match(req, dist.version)
         ):
             absent.append(name + _make_version_constraint(info, True))
             if len(absent) == 1:
@@ -753,6 +778,8 @@ def ensure_group(
 
     if not HAVE_DISTLIB:
         raise Ouch("found no usable distlib, please install it")
+    if not HAVE_PACKAGING:
+        raise Ouch("found no usable packaging lib, please install it")
 
     parsed_deps = _parse_groups(file)
 
-- 
2.50.1


