Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDD2C3600A
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 10:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqVZ0-0002pQ-LG; Tue, 17 Sep 2024 06:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVYy-0002Wf-8S
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sqVYw-0007J6-E1
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 06:36:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726569361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eQHq/tsypySJ0eiLfVHNGlAvfoLS6BlCQvVDUC7m4E4=;
 b=Kt5pa1AqCjHQCVcc36UjMwsIaQV5qFsfDEplF7zUB5/CWlDVmWqzKRJY2uMLX09P8wU3pj
 EFDr2zuLEx2xLOjDIvK+Jkf9b+HUJnwgwYKnDwbyjEc9hCmm6WH4wrYntPSpofx/WeYdY/
 UUq//KFClg+SC+tOnJ5bRVaavy8MhTs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-VHu-6EctPzmO_aLj04jnnw-1; Tue,
 17 Sep 2024 06:35:58 -0400
X-MC-Unique: VHu-6EctPzmO_aLj04jnnw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF80A1955F40; Tue, 17 Sep 2024 10:35:57 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.158])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5865E19560A3; Tue, 17 Sep 2024 10:35:55 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/17] .gitlab-ci.d/buildtest: Build most targets in the
 build-without-defaults job
Date: Tue, 17 Sep 2024 12:35:29 +0200
Message-ID: <20240917103540.149144-7-thuth@redhat.com>
In-Reply-To: <20240917103540.149144-1-thuth@redhat.com>
References: <20240917103540.149144-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Now that all the qtests are able to deal with builds that use the
"--without-default-devices" configuration switch, we can add all
targets to the build-without-defaults job. But to avoid burning too
much CI cycles in this job, exclude some targets where we already
have similar test coverage by a related target.

Message-ID: <20240905191434.694440-9-thuth@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index b75e4edbf6..2ab8c4806e 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -659,9 +659,6 @@ build-tci:
     - make check-tcg
 
 # Check our reduced build configurations
-# requires libfdt: aarch64, arm, loongarch64, microblaze, microblazeel,
-#   or1k, ppc64, riscv32, riscv64, rx
-# fails qtest without boards: i386, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
@@ -675,11 +672,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: alpha-softmmu avr-softmmu hppa-softmmu m68k-softmmu
-      mips-softmmu mips64-softmmu mipsel-softmmu mips64el-softmmu
-      ppc-softmmu s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softmmu
-      sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
-      hexagon-linux-user i386-linux-user s390x-linux-user
+      --target-list-exclude=aarch64-softmmu,microblaze-softmmu,mips64-softmmu,mipsel-softmmu,ppc64-softmmu,sh4el-softmmu,xtensa-softmmu,x86_64-softmmu
     MAKE_CHECK_ARGS: check
 
 build-libvhost-user:
-- 
2.46.0


