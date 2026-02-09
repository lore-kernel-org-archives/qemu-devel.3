Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D49E7E0D5
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 18:43:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpWDV-0005p8-BN; Mon, 09 Feb 2026 13:42:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vpWDD-0005jc-QQ
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 13:42:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vpWD8-0008Uo-Lr
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 13:42:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770662533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s5joZJigKxefQ91FnmD1xEUQSgV2CmuE+Lp0I27XhBE=;
 b=bYc9h5OWrzVpGeMupHZODLKTt8rqEihc+j5odYrY7pveptBb4/IqR1IBCLaxXe4HTf8Ybl
 a1BEgOMHjn3M1vojO0y+aH7bnxPS/KhukdgBZc7Ga/ptwB2YF1Njz309GRvzq19Ifb4jDX
 dn7WNa2LOGA9Um3JU/gWr3YmS0CRfCM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-5gDdAx0OPy6UZg3ljPYA7Q-1; Mon,
 09 Feb 2026 13:42:10 -0500
X-MC-Unique: 5gDdAx0OPy6UZg3ljPYA7Q-1
X-Mimecast-MFC-AGG-ID: 5gDdAx0OPy6UZg3ljPYA7Q_1770662528
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A04F51956095; Mon,  9 Feb 2026 18:42:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.77])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BA4AC18003F6; Mon,  9 Feb 2026 18:42:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Subject: [PATCH v6 06/16] tests: Use configured python to run GitLab iotests
Date: Mon,  9 Feb 2026 13:41:13 -0500
Message-ID: <20260209184124.1263625-7-jsnow@redhat.com>
In-Reply-To: <20260209184124.1263625-1-jsnow@redhat.com>
References: <20260209184124.1263625-1-jsnow@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


