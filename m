Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9658C52D73
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 17:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbO2Z-0007RN-PD; Tue, 06 Aug 2024 13:32:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sbO2X-0007LY-Nm
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 13:32:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sbO2V-0006MH-UG
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 13:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722965523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3d6XMb3rg8qagy9L556QHcs1su9m4o4U8evvKQPrw1o=;
 b=Oct47dLHZElM/iSn74kd2AqH07UkFurmXL245ynQ3PfUvhV+rzrDBE6w/WkCVDnCokVdRN
 Ckenq6ENPeGDXGHKvqU3CaBA3Usl81ZpZNpSLAr6MmTw01ABMM1W5OcCczGnkrgrg3t90h
 OoNlwdUZlMJbUf8C5lbmOPq8EoPFfgk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-78-HCMI_sXsMvKtkbo1ab6cCw-1; Tue,
 06 Aug 2024 13:31:58 -0400
X-MC-Unique: HCMI_sXsMvKtkbo1ab6cCw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71A2E195422B; Tue,  6 Aug 2024 17:31:49 +0000 (UTC)
Received: from p1.localdomain.com (unknown [10.39.192.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A23AC19560AE; Tue,  6 Aug 2024 17:31:38 +0000 (UTC)
From: Cleber Rosa <crosa@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, Troy Lee <leetroy@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Beraldo Leal <bleal@redhat.com>,
 kvm@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paul Durrant <paul@xen.org>, Eric Auger <eric.auger@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>, qemu-arm@nongnu.org,
 Cleber Rosa <crosa@redhat.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>
Subject: [PATCH v2 1/9] Bump avocado to 103.0
Date: Tue,  6 Aug 2024 13:31:11 -0400
Message-ID: <20240806173119.582857-2-crosa@redhat.com>
In-Reply-To: <20240806173119.582857-1-crosa@redhat.com>
References: <20240806173119.582857-1-crosa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This bumps Avocado to latest the LTS release.

An LTS release is one that can receive bugfixes and guarantees
stability for a much longer period and has incremental minor releases
made.

Even though the 103.0 LTS release is pretty a rewrite of Avocado when
compared to 88.1, the behavior of all existing tests under
tests/avocado has been extensively tested no regression in behavior
was found.

To keep behavior of jobs as close as possible with previous version,
this version bump keeps the execution serial (maximum of one task at a
time being run).

Reference: https://avocado-framework.readthedocs.io/en/103.0/releases/lts/103_0.html
Signed-off-by: Cleber Rosa <crosa@redhat.com>
---
 pythondeps.toml        | 2 +-
 tests/Makefile.include | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/pythondeps.toml b/pythondeps.toml
index f6e590fdd8..175cf99241 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -30,5 +30,5 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.1.1" }
 # Note that qemu.git/python/ is always implicitly installed.
 # Prefer an LTS version when updating the accepted versions of
 # avocado-framework, for example right now the limit is 92.x.
-avocado-framework = { accepted = "(>=88.1, <93.0)", installed = "88.1", canary = "avocado" }
+avocado-framework = { accepted = "(>=103.0, <104.0)", installed = "103.0", canary = "avocado" }
 pycdlib = { accepted = ">=1.11.0" }
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 6618bfed70..537804d101 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -141,7 +141,7 @@ check-avocado: check-venv $(TESTS_RESULTS_DIR) get-vm-images
             --show=$(AVOCADO_SHOW) run --job-results-dir=$(TESTS_RESULTS_DIR) \
             $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
 			--filter-by-tags-include-empty-key) \
-            $(AVOCADO_CMDLINE_TAGS) \
+            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=1 \
             $(if $(GITLAB_CI),,--failfast) $(AVOCADO_TESTS), \
             "AVOCADO", "tests/avocado")
 
-- 
2.45.2


