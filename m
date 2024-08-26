Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F03C54731
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 09:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siWGN-0002sv-Sy; Mon, 26 Aug 2024 05:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siWGG-0002m9-JC
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 05:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siWGE-0006xu-C8
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 05:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724665420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=86Fy/cPq3k7WOBd2kCuMbzdhs/QnlUUhbX48bjQ5ga8=;
 b=ihm0cevBZm889L6UWtwpiA7RFxzclwF0Sh1tAwmkAkonFLDT6SD30EBEtCavnwPZCe3pm1
 xDZsRwIx+y0MV38e2LDwSXqNnurq7YitXcQ4VT3j9V3b4i9C+opj+HT2qToSucUYJFhN8U
 yvyKNfiIaM7KVENu4fXUHLUHHU2vmF0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-7M08Jf-jOW-S6CUFn6kodg-1; Mon,
 26 Aug 2024 05:43:37 -0400
X-MC-Unique: 7M08Jf-jOW-S6CUFn6kodg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D6671955D58; Mon, 26 Aug 2024 09:43:36 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.178])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EA9519560AA; Mon, 26 Aug 2024 09:43:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 1/3] gitlab-ci: Replace build_script -> step_script in Cirrus
 jobs
Date: Mon, 26 Aug 2024 11:43:28 +0200
Message-ID: <20240826094330.276592-2-thuth@redhat.com>
In-Reply-To: <20240826094330.276592-1-thuth@redhat.com>
References: <20240826094330.276592-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Long due upgrade, see [1]:

  In GitLab Runner 13.2 a translation for step_script to
  build_script was added to the custom executor. In 14.0
  the build_script stage will be replaced with step_script.

We are using GitLab 17 [2]!

This removes the following warning:

  WARNING: Starting with version 17.0 the 'build_script'
  stage will be replaced with 'step_script':
  https://gitlab.com/groups/gitlab-org/-/epics/6112

[1] https://about.gitlab.com/releases/2021/05/22/gitlab-13-12-released/#remove-translation-from-stepscript-to-buildscript-in-custom-executor
[2] https://about.gitlab.com/releases/2024/05/16/gitlab-17-0-released/

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240816213203.18350-1-philmd@linaro.org>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/cirrus/build.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/cirrus/build.yml b/.gitlab-ci.d/cirrus/build.yml
index 43dd52dd19..102cdbd8b1 100644
--- a/.gitlab-ci.d/cirrus/build.yml
+++ b/.gitlab-ci.d/cirrus/build.yml
@@ -26,7 +26,7 @@ build_task:
     - git clone --depth 100 "$CI_REPOSITORY_URL" .
     - git fetch origin "$CI_COMMIT_REF_NAME"
     - git reset --hard "$CI_COMMIT_SHA"
-  build_script:
+  step_script:
     - mkdir build
     - cd build
     - ../configure --enable-werror $CONFIGURE_ARGS
-- 
2.46.0


