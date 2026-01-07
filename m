Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9493CFD628
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:03:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTBE-00051c-U7; Wed, 07 Jan 2026 08:02:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdTAm-0004vz-4V
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:02:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdTAj-0007Bw-AA
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767790916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kubT+ovvIz8B3qKCu1Vkgo6tV5welKZjjdi75BU2CIs=;
 b=DtKjxH1PCnUKvDC6iYbvaIwFs41p/ZgpeMgE7MC9wooHHNzDZyNzZWW6of6PF22XxYAzYG
 vM43d3Ssm0huKVC1AJO8NsVCb6fj05LC37tmJ9LpUFS0oPNj9N/LhM96SJvmiLnjQ8Cnkj
 Yf4Rj+qORzPV61b2HgbuXtmQsERKpzE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-B3mPg5rFM2ukEAlKVxoOeA-1; Wed,
 07 Jan 2026 08:01:55 -0500
X-MC-Unique: B3mPg5rFM2ukEAlKVxoOeA-1
X-Mimecast-MFC-AGG-ID: B3mPg5rFM2ukEAlKVxoOeA_1767790913
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA8E319540DE; Wed,  7 Jan 2026 13:01:52 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.169])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C0F8719560A2; Wed,  7 Jan 2026 13:01:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 2/4] tests/docker: allow display of docker output
Date: Wed,  7 Jan 2026 13:01:43 +0000
Message-ID: <20260107130145.1495219-3-berrange@redhat.com>
In-Reply-To: <20260107130145.1495219-1-berrange@redhat.com>
References: <20260107130145.1495219-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
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

The --quiet command is used with docker unless V=1 is passed to make,
and as a result stdout from docker is never visible by default, making
it hard to diagnose failures building / running containers.

Meanwhile passing V=1 is undesirable as that makes the entire build
system verbose.

Introduce a $(DOCKER_V) make variable which is initialized from $(V)

It is thus possible to display docker output without also enabling
make verbose output.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/docker/Makefile.include | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 7d4582b6a8..d58a280333 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -40,14 +40,14 @@ docker-qemu-src: $(DOCKER_SRC_COPY)
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	  $(call quiet-command,			\
 		DOCKER_BUILDKIT=1 $(RUNC) build		\
-		$(if $V,,--quiet)			\
+		$(if $(DOCKER_V),,--quiet)		\
 		$(if $(NOCACHE),--no-cache,		\
 			$(if $(DOCKER_REGISTRY),--cache-from $(DOCKER_REGISTRY)/qemu/$*)) \
 		--build-arg BUILDKIT_INLINE_CACHE=1 	\
 		$(if $(NOUSER),,			\
 			--build-arg USER=$(USER)	\
 			--build-arg UID=$(UID))		\
-		-t qemu/$* - < $< $(if $V,,> /dev/null),\
+		-t qemu/$* - < $< $(if $(DOCKER_V),,> /dev/null),\
 		"BUILD", $*)
 
 # General rule for inspecting registry images.
@@ -73,7 +73,7 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 			DEB_TYPE=$(DEB_TYPE) 					\
 			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
 			$(DOCKER_SCRIPT) build -t qemu/debian-$* -f $< 		\
-			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
+			$(if $(DOCKER_V),,--quiet) $(if $(NOCACHE),--no-cache) 	\
 			$(if $(NOUSER),,--add-current-user) 			\
 			$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
 			$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
@@ -105,16 +105,17 @@ debian-toolchain-run = \
 	$(if $(NOCACHE)$(NOFETCH),					\
 		$(call quiet-command,					\
 			$(DOCKER_SCRIPT) build -t qemu/$1 -f $< 	\
-			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache)	\
+			$(if $(DOCKER_V),,--quiet) 			\
+			$(if $(NOCACHE),--no-cache)			\
 			--registry $(DOCKER_REGISTRY) --extra-files	\
 			$(DOCKER_FILES_DIR)/$1.d/build-toolchain.sh,	\
 			"BUILD", $1),				        \
 		$(call quiet-command,					\
-			$(DOCKER_SCRIPT) fetch $(if $V,,--quiet)	\
+			$(DOCKER_SCRIPT) fetch $(if $(DOCKER_V),,--quiet) \
 				qemu/$1 $(DOCKER_REGISTRY),		\
 			"FETCH", $1)					\
 		$(call quiet-command,					\
-			$(DOCKER_SCRIPT) update $(if $V,,--quiet) 	\
+			$(DOCKER_SCRIPT) update $(if $(DOCKER_V),,--quiet) \
 				qemu/$1 				\
 				$(if $(NOUSER),,--add-current-user) 	\
 			"PREPARE", $1))
@@ -231,7 +232,10 @@ docker-run: docker-qemu-src
 			-e TARGET_LIST=$(subst $(SPACE),$(COMMA),$(TARGET_LIST))	\
 			-e EXTRA_CONFIGURE_OPTS="$(EXTRA_CONFIGURE_OPTS)" \
 			-e TEST_COMMAND="$(TEST_COMMAND)" 		\
-			-e V=$V -e J=$J -e DEBUG=$(DEBUG)		\
+			-e V=$V						\
+			-e DOCKER_V=$(DOCKER_V)				\
+			-e J=$J						\
+			-e DEBUG=$(DEBUG)				\
 			-e SHOW_ENV=$(SHOW_ENV) 			\
 			$(if $(NOUSER),,				\
 				-v $(DOCKER_QEMU_CACHE_DIR):$(DOCKER_QEMU_CACHE_DIR) 	\
-- 
2.52.0


