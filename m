Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1116CFD36C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 04:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNkGD-0004c4-CK; Mon, 24 Nov 2025 23:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vNkEo-0003FK-51
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 23:01:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vNkEm-0006XP-Ad
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 23:01:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764043267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PpNJeLptXAR78lNsMqjGWD+kHCvErZEx7jFK8oQr/LU=;
 b=HTGapuiNbmsojaeBemo2zFh/DCUiOxtooYtWmz3cYMhL0xWfX+2eMenRCMIWvZZxwjm5Tg
 /dsoSIYU37B2PaFWEW9yARMwCXj8mF3bHfJZnNpxyz/iwtCwoRN+9nXEQXI0nfR/6TrZK0
 RIPf9oe7jX43qwbnv1KMxD9YV+RLTdw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-132-OfrvYaHuNyGNnFigz-qIIQ-1; Mon,
 24 Nov 2025 23:01:04 -0500
X-MC-Unique: OfrvYaHuNyGNnFigz-qIIQ-1
X-Mimecast-MFC-AGG-ID: OfrvYaHuNyGNnFigz-qIIQ_1764043263
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 28D811956075; Tue, 25 Nov 2025 04:01:03 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 11B2718004D8; Tue, 25 Nov 2025 04:01:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v2 05/16] tests/iotests: Use configured python to run GitLab
 iotests
Date: Mon, 24 Nov 2025 23:00:33 -0500
Message-ID: <20251125040045.461148-6-jsnow@redhat.com>
In-Reply-To: <20251125040045.461148-1-jsnow@redhat.com>
References: <20251125040045.461148-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

use the python (and the pyvenv) to run iotests instead of the system
default python3 interpreter.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 44df116139b..c3a9e8428c2 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -351,10 +351,10 @@ build-tcg-disabled:
     - make check-unit
     - make check-qapi-schema
     - cd tests/qemu-iotests/
-    - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
+    - ../../pyvenv/bin/python3 ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
             052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
             170 171 184 192 194 208 221 226 227 236 253 277 image-fleecing
-    - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
+    - ../../pyvenv/bin/python3 ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
             124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
             208 209 216 218 227 234 246 247 248 250 254 255 257 258
             260 261 262 263 264 270 272 273 277 279 image-fleecing
-- 
2.51.1


