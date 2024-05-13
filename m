Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20700C25B78
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:16:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6Tf6-0001A5-5M; Mon, 13 May 2024 07:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6Tf3-00015o-V2
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s6Tf1-0004ej-Tv
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715598963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nLXBQWWFu4bgQLquYqCyiKT5hPRicy8sv8QrxNdFSbY=;
 b=Wt5IKcbmNtS1PoBpUM46vOjWWPWKXiu8e+Qj5OX4/4lqdTi8lAXHjGorHQyfLjh0ZRuAFI
 mrgYKSeFNmA0pAVGxt3p5aNBdzbWz4n8WIgYrPTUEEnWNjD+eIXmXuL9EZEh0aQhMJ28Rh
 v7QAmxxfZOJ57MGzL+ko0lQL4hECUkY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-yKiZ5tT7NbqQ_2rpGyf5kw-1; Mon, 13 May 2024 07:16:00 -0400
X-MC-Unique: yKiZ5tT7NbqQ_2rpGyf5kw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AFD5E812296;
 Mon, 13 May 2024 11:15:59 +0000 (UTC)
Received: from toolbox.default.com (unknown [10.42.28.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D9A8200B4D8;
 Mon, 13 May 2024 11:15:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/3] gitlab: use $MAKE instead of 'make'
Date: Mon, 13 May 2024 12:15:50 +0100
Message-ID: <20240513111551.488088-3-berrange@redhat.com>
In-Reply-To: <20240513111551.488088-1-berrange@redhat.com>
References: <20240513111551.488088-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The lcitool generated containers have '$MAKE' set to the path
of the right 'make' binary. Using the env variable makes it
possible to override the choice per job.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 .gitlab-ci.d/buildtest-template.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 22045add80..278a5ea966 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -26,10 +26,10 @@
       then
         pyvenv/bin/meson configure . -Dbackend_max_links="$LD_JOBS" ;
       fi || exit 1;
-    - make -j"$JOBS"
+    - $MAKE -j"$JOBS"
     - if test -n "$MAKE_CHECK_ARGS";
       then
-        make -j"$JOBS" $MAKE_CHECK_ARGS ;
+        $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
     - ccache --show-stats
 
@@ -60,7 +60,7 @@
     - cd build
     - find . -type f -exec touch {} +
     # Avoid recompiling by hiding ninja with NINJA=":"
-    - make NINJA=":" $MAKE_CHECK_ARGS
+    - $MAKE NINJA=":" $MAKE_CHECK_ARGS
 
 .native_test_job_template:
   extends: .common_test_job_template
-- 
2.43.0


