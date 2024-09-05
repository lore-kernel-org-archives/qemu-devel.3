Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861BACE7A81
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smHxC-0002kU-8G; Thu, 05 Sep 2024 15:15:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwm-0002Gy-0b
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:15:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1smHwg-0000aJ-BX
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725563705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ihh49LXmnNKzmAc6/52lH3FXuXlPlIe00iZzBxiZB44=;
 b=e9iH7dUdJ0SJu98noEt76odLydi3OZt0rvJWD0d3oADHmx3LGc7KK7WDHW751O2nnOXhYA
 4OcLsfl1tgsnoyLCsPKY0zBROHcWYRBnSMwquUGOGWkspMAv2IKBxQ8sw8gK62Lp+NRVoD
 qc5UD4VFs1ntTYU5BaqgaJ+G1XKZ8qE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-4anuOjF1NFKhNmLB0CEgQA-1; Thu,
 05 Sep 2024 15:15:01 -0400
X-MC-Unique: 4anuOjF1NFKhNmLB0CEgQA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C29951953943; Thu,  5 Sep 2024 19:15:00 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 879531956048; Thu,  5 Sep 2024 19:14:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 8/8] .gitlab-ci.d/buildtest: Build most targets in the
 build-without-defaults job
Date: Thu,  5 Sep 2024 21:14:34 +0200
Message-ID: <20240905191434.694440-9-thuth@redhat.com>
In-Reply-To: <20240905191434.694440-1-thuth@redhat.com>
References: <20240905191434.694440-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .gitlab-ci.d/buildtest.yml | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 0c624813cf..dd1edf88db 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -653,9 +653,6 @@ build-tci:
     - make check-tcg
 
 # Check our reduced build configurations
-# requires libfdt: aarch64, arm, loongarch64, microblaze, microblazeel,
-#   or1k, ppc64, riscv32, riscv64, rx
-# fails qtest without boards: i386, x86_64
 build-without-defaults:
   extends: .native_build_job_template
   needs:
@@ -669,11 +666,7 @@ build-without-defaults:
       --disable-pie
       --disable-qom-cast-debug
       --disable-strip
-    TARGETS: alpha-softmmu avr-softmmu cris-softmmu hppa-softmmu m68k-softmmu
-      mips-softmmu mips64-softmmu mipsel-softmmu mips64el-softmmu
-      ppc-softmmu s390x-softmmu sh4-softmmu sh4eb-softmmu sparc-softmmu
-      sparc64-softmmu tricore-softmmu xtensa-softmmu xtensaeb-softmmu
-      hexagon-linux-user i386-linux-user s390x-linux-user
+      --target-list-exclude=aarch64-softmmu,microblaze-softmmu,mips64-softmmu,mipsel-softmmu,ppc64-softmmu,sh4el-softmmu,xtensa-softmmu,x86_64-softmmu
     MAKE_CHECK_ARGS: check
 
 build-libvhost-user:
-- 
2.46.0


