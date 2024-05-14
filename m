Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED62C04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 12:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6rdB-0005Cj-SJ; Tue, 14 May 2024 08:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rd7-0005C1-DN
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1s6rd5-0005F1-Vk
 for qemu-devel@nongnu.org; Tue, 14 May 2024 08:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715691099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ee7Fi+mEF3maNlhA+rKnGHb7FzAkAvKF9dzv3XNijog=;
 b=eP3paY4ly7OU+4fH9q2mqGyHKBv0nwsUUwMX4eYRlXUuTnOyObt4cjNIJe1NrmF0dz9bEP
 kS/JwFq80vF97jAnKBATrFcsb5bi8s07aR8WxCnTnOB//LRJUBvlMyCgnNa6kU2HlhmQPW
 gbcdeieT8mpuId9X3xmPmRagVTbvyPc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-SFuHlLvNMs2EgmbfLsWnoQ-1; Tue,
 14 May 2024 08:51:26 -0400
X-MC-Unique: SFuHlLvNMs2EgmbfLsWnoQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E98F2380009D;
 Tue, 14 May 2024 12:51:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.26])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 129A3400057;
 Tue, 14 May 2024 12:51:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 03/11] gitlab: use $MAKE instead of 'make'
Date: Tue, 14 May 2024 14:51:11 +0200
Message-ID: <20240514125119.284638-4-thuth@redhat.com>
In-Reply-To: <20240514125119.284638-1-thuth@redhat.com>
References: <20240514125119.284638-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Daniel P. Berrangé <berrange@redhat.com>

The lcitool generated containers have '$MAKE' set to the path
of the right 'make' binary. Using the env variable makes it
possible to override the choice per job.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240513111551.488088-3-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
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
2.45.0


