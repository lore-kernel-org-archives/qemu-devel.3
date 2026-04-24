Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24350FED3E5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIgo-0003bm-RG; Fri, 24 Apr 2026 11:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGIgY-00034Q-29
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:43:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wGIgW-0007dR-JK
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:43:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777045395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jX9dwcT8mOoBKG1N5b6BGOud+N23mFYCwO2maRACc7w=;
 b=YQTqKAfTiBEro7du/Ja1p8PSMCnsnd0QWpc/vgl293ptRxdb3ran6qe/xwUiCSnU8j+p4t
 Ppj/trEMfnf/QDA3G4x8UeISxL3jDIRvblWYtVWm22zHGUvVzKvYa6MxXXkorzJI536fF/
 rgulu4eH8+Hry8UH3C6uEOG2kFqK4bg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-ItCAkABQNXSVTGHBS3uiBg-1; Fri,
 24 Apr 2026 11:43:12 -0400
X-MC-Unique: ItCAkABQNXSVTGHBS3uiBg-1
X-Mimecast-MFC-AGG-ID: ItCAkABQNXSVTGHBS3uiBg_1777045391
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2373F195606C; Fri, 24 Apr 2026 15:43:11 +0000 (UTC)
Received: from thinkbook.redhat.com (unknown [10.44.32.213])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F2A62180047F; Fri, 24 Apr 2026 15:43:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 16/16] gitlab: remove I/O tests from build-tcg-disabled job
Date: Fri, 24 Apr 2026 16:42:04 +0100
Message-ID: <20260424154205.364268-17-berrange@redhat.com>
In-Reply-To: <20260424154205.364268-1-berrange@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Now that we have dedicated CI jobs for running I/O tests on each
supported format/protocol, we no longer need to special case a
run of a hand picked set of tests in the build-tcg-disabled job.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index d4591d30e9..710dfbcc77 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -446,15 +446,6 @@ build-tcg-disabled:
     - make -j"$JOBS"
     - make check-unit
     - make check-qapi-schema
-    - ./run tests/qemu-iotests/check -raw 001 002 003 004 005 008 009
-            010 011 012 021 025 032 033 048 052 063 077 086 101 104 106
-            113 148 150 151 152 157 159 160 163 170 171 184 192 194 208
-            221 226 227 236 253 277 image-fleecing
-    - ./run tests/qemu-iotests/check -qcow2 028 051 056 057 058 065 068
-            082 085 091 095 096 102 122 124 132 139 142 144 145 151 152
-            155 157 165 194 196 200 202 208 209 216 218 227 234 246 247
-            248 250 254 255 257 258 260 261 262 263 264 270 272 273 277
-            279 image-fleecing
     - make distclean
 
 build-user:
-- 
2.53.0


