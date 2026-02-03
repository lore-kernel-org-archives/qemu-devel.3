Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F00E8B365
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:36:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnN7r-0003cK-7x; Tue, 03 Feb 2026 15:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vnN7k-0003W6-C8
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:35:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vnN7i-0000o1-S5
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770150946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5joZJigKxefQ91FnmD1xEUQSgV2CmuE+Lp0I27XhBE=;
 b=W+ioU7/2+d0dW2f8/n1B9KG4At1ngo0XJ2PVwlBS1HCwTPBfMqXZ+xI4/usT27lTN0n/Ll
 +3MkrYhMsaLh6NS6GXWAvQWJRG8x8Qe28RGwDojINaiDEEH9b64IqAFzWCuLtoLUXwOGYt
 RtETOvDYcn7hPo63xKdU4WvuZIBQHqE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-207-0Qw0uwAyMl6vpdzSjw9NEg-1; Tue,
 03 Feb 2026 15:35:42 -0500
X-MC-Unique: 0Qw0uwAyMl6vpdzSjw9NEg-1
X-Mimecast-MFC-AGG-ID: 0Qw0uwAyMl6vpdzSjw9NEg_1770150941
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCD47180035D; Tue,  3 Feb 2026 20:35:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.43])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 992611800285; Tue,  3 Feb 2026 20:35:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Maksim Davydov <davydov-max@yandex-team.ru>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Yonggang Luo <luoyonggang@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v5 06/16] tests: Use configured python to run GitLab iotests
Date: Tue,  3 Feb 2026 15:35:01 -0500
Message-ID: <20260203203512.672552-7-jsnow@redhat.com>
In-Reply-To: <20260203203512.672552-1-jsnow@redhat.com>
References: <20260203203512.672552-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

use the configured python (and the pyvenv) to run iotests instead of the
system default python3 interpreter. Use the new "run" script in the
build directory to execute the command inside the meson developer
environment, templated in qemu.git/run.in.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index e9b5b05e6e8..4c280dd29bc 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -350,15 +350,15 @@ build-tcg-disabled:
     - make -j"$JOBS"
     - make check-unit
     - make check-qapi-schema
-    - cd tests/qemu-iotests/
-    - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
-            052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
-            170 171 184 192 194 208 221 226 227 236 253 277 image-fleecing
-    - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
-            124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
-            208 209 216 218 227 234 246 247 248 250 254 255 257 258
-            260 261 262 263 264 270 272 273 277 279 image-fleecing
-    - cd ../..
+    - ./run tests/qemu-iotests/check -raw 001 002 003 004 005 008 009
+            010 011 012 021 025 032 033 048 052 063 077 086 101 104 106
+            113 148 150 151 152 157 159 160 163 170 171 184 192 194 208
+            221 226 227 236 253 277 image-fleecing
+    - ./run tests/qemu-iotests/check -qcow2 028 051 056 057 058 065 068
+            082 085 091 095 096 102 122 124 132 139 142 144 145 151 152
+            155 157 165 194 196 200 202 208 209 216 218 227 234 246 247
+            248 250 254 255 257 258 260 261 262 263 264 270 272 273 277
+            279 image-fleecing
     - make distclean
 
 build-user:
-- 
2.52.0


