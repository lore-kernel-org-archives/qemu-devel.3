Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD4ACFB44F
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 17:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxrMV-000362-M6; Mon, 07 Oct 2024 13:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxrMU-00035h-7K
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sxrMS-00052H-RG
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 13:17:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728321452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sc2hTj7jpfWdjMhpPHr+7m+wRgj4Ifxu8Int0E+iwWE=;
 b=G9rNZzy7jdw1ZY0+TW+rDaL53/CLbCNsBwqg9k/0TcqmefbMDKEpnxZde2Ktn+ldxWMmZN
 oyD/NBcBknD3QhWp5YJWQPgd+mtfbwacMFYnnkmW3OMeEsyWt0hGHCLcPJ9e0s2MRaZUGb
 aselw8DkLKs/SS9542ldgKe7F3SFKcM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-fKBvb-yYPDaWGAnockJE6A-1; Mon, 07 Oct 2024 13:17:29 -0400
X-MC-Unique: fKBvb-yYPDaWGAnockJE6A-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d002fb48fso1802343f8f.3
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 10:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728321448; x=1728926248;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sc2hTj7jpfWdjMhpPHr+7m+wRgj4Ifxu8Int0E+iwWE=;
 b=dnBBRugfg0g33bb9CMFbw5QhYejX00TiSBjkZ1f4j0iTC5HrKwiyObVGPD78+jlipS
 K3w3dr6YWM5VD9JbvX3ieGncpBDpNA7kz0xwoABl8vH56mf1CcGd9dc6HPyHGqNPSslK
 wQ81uEzwZJjDqv8aHuCHhBYKW2Qhbn9apihPI0Rv7cXvfVOY7MwEwF4MTkeToSCiEUgb
 LpOHgTaGETEcBGDpWSFKzZtQte/yMfgwd4eO9hIGEUkRYrqBgIEGbJFRAaUXGBI6YdoM
 8/MI9Uwgf4KhIuZ/Lh1Zwo6IazcUeAqrYb3DVdTqebRNRFndRCTmlXwDEbb7NIMbyLT1
 b8Ag==
X-Gm-Message-State: AOJu0YzxAWjKZSTk5MH6uI0jH6Z6WQD8as+IgnfZg+cuyQ0EJrI31QQp
 84xMLyzy4DM+zZCdx47hOfjtMuC1aWIJhoUmvJg/DhwTvv19tr66fsOj8Hzj5eQLKdgNj1PDzrT
 ya6zVfHe75fAdHYemBzHfnamctCQVl3/wrC++a38uqJKCD/Jiq+ZcZgFDkIOy7SSng0Xy4FxK3p
 oxP3q77j6UthjU5X6KOYXpIYDkX7HMuB+HJCGXPkY=
X-Received: by 2002:a5d:4535:0:b0:37c:cc77:3e72 with SMTP id
 ffacd0b85a97d-37d0e789f6cmr6501282f8f.33.1728321447884; 
 Mon, 07 Oct 2024 10:17:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGhlIAAsprEg/+BS9hnnHB+Vx/eDmljbssj/ojVxlm1aIDVFQ6D8j1Gr0oqrKacyuAKUrOUDA==
X-Received: by 2002:a5d:4535:0:b0:37c:cc77:3e72 with SMTP id
 ffacd0b85a97d-37d0e789f6cmr6501265f8f.33.1728321447326; 
 Mon, 07 Oct 2024 10:17:27 -0700 (PDT)
Received: from avogadro.local ([151.62.111.131])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d1695e8b6sm6175030f8f.71.2024.10.07.10.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 10:17:26 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 2/2] gitlab-ci: add Rust-enabled CI job
Date: Mon,  7 Oct 2024 19:17:13 +0200
Message-ID: <20241007171717.1436982-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241007171717.1436982-1-pbonzini@redhat.com>
References: <20241007171717.1436982-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 .gitlab-ci.d/buildtest.yml  | 13 +++++++++++++
 .gitlab-ci.d/containers.yml |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 669c980c4b4..a92e731d6af 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -120,6 +120,19 @@ build-system-fedora:
       xtensa-softmmu m68k-softmmu riscv32-softmmu ppc-softmmu sparc64-softmmu
     MAKE_CHECK_ARGS: check-build
 
+build-system-fedora-rust:
+  extends:
+    - .native_build_job_template
+    - .native_build_artifact_template
+  needs:
+    job: amd64-fedora-rust-container
+  variables:
+    IMAGE: fedora-rust-nightly
+    CONFIGURE_ARGS: --disable-gcrypt --enable-nettle --disable-docs --enable-rust
+    TARGETS: aarch64-softmmu
+    MAKE_CHECK_ARGS: check-build
+  allow_failure: true
+
 check-system-fedora:
   extends: .native_test_job_template
   needs:
diff --git a/.gitlab-ci.d/containers.yml b/.gitlab-ci.d/containers.yml
index ae79d4c58bc..414ae5e828b 100644
--- a/.gitlab-ci.d/containers.yml
+++ b/.gitlab-ci.d/containers.yml
@@ -27,3 +27,9 @@ python-container:
   extends: .container_job_template
   variables:
     NAME: python
+
+amd64-fedora-rust-container:
+  extends: .container_job_template
+  variables:
+    NAME: fedora-rust-nightly
+  allow_failure: true
-- 
2.46.1


