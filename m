Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E35EB26E9
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Feb 2026 16:36:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpqip-0006af-SI; Tue, 10 Feb 2026 11:36:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpqim-0006Zc-8B
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:36:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vpqik-000166-ND
 for qemu-devel@nongnu.org; Tue, 10 Feb 2026 11:36:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770741374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kvVlQnOpbnPeBZq0pp35c7c6ILOyZAva36VWv6HAW88=;
 b=g6ndp1AUXfbaiF/jA2FbmhwlN1PBn5nBgp1e9bpFZq3fqfJzBQ2N9EaXkBiZOYAFks5NSk
 1OLcv+p3mxk6xgyYEmJyNqbNIe8XeZ7DYdMYlovsdAX/s3/gf9E9erTp9wtDDzWCLgj2hP
 wehWlWmk8LH6D44CENcwSwWXE7+4Gmk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-330-gv8krx99MHq4dGUPO_GFIA-1; Tue,
 10 Feb 2026 11:36:11 -0500
X-MC-Unique: gv8krx99MHq4dGUPO_GFIA-1
X-Mimecast-MFC-AGG-ID: gv8krx99MHq4dGUPO_GFIA_1770741370
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8A92118005B0; Tue, 10 Feb 2026 16:36:10 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.44.34.137])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB9C919560B0; Tue, 10 Feb 2026 16:36:07 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 3/4] tests/docker: allow display of docker output
Date: Tue, 10 Feb 2026 16:35:55 +0000
Message-ID: <20260210163556.713841-4-berrange@redhat.com>
In-Reply-To: <20260210163556.713841-1-berrange@redhat.com>
References: <20260210163556.713841-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
 tests/docker/Makefile.include | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 7d4582b6a8..df14538c0f 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -23,6 +23,8 @@ RUNC ?= $(shell $(DOCKER_SCRIPT) probe)
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
 
+DOCKER_V ?= $(V)
+
 .DELETE_ON_ERROR: $(DOCKER_SRC_COPY)
 $(DOCKER_SRC_COPY):
 	@mkdir $@
@@ -40,14 +42,14 @@ docker-qemu-src: $(DOCKER_SRC_COPY)
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
@@ -73,7 +75,7 @@ docker-binfmt-image-debian-%: $(DOCKER_FILES_DIR)/debian-bootstrap.docker
 			DEB_TYPE=$(DEB_TYPE) 					\
 			$(if $(DEB_URL),DEB_URL=$(DEB_URL),)			\
 			$(DOCKER_SCRIPT) build -t qemu/debian-$* -f $< 		\
-			$(if $V,,--quiet) $(if $(NOCACHE),--no-cache) 		\
+			$(if $(DOCKER_V),,--quiet) $(if $(NOCACHE),--no-cache) 	\
 			$(if $(NOUSER),,--add-current-user) 			\
 			$(if $(EXTRA_FILES),--extra-files $(EXTRA_FILES))	\
 			$(if $(EXECUTABLE),--include-executable=$(EXECUTABLE)), \
@@ -105,16 +107,17 @@ debian-toolchain-run = \
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
@@ -231,7 +234,10 @@ docker-run: docker-qemu-src
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
2.53.0


