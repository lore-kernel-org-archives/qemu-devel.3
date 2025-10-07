Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FC4CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 11:57:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v66Is-0002oQ-MU; Tue, 07 Oct 2025 07:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IX-0002Yz-4b
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:56:09 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v66IC-0001JY-72
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 07:56:03 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46f53f88e0bso17290765e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759838136; x=1760442936; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dJyQsL+cPE5QXe8EQvQ1Pt6/OFgKx8gOarr9WgNRk7w=;
 b=pSSGUESdD3ZXQ24f8u2336DRdmZkok8sSAFtCfjWVEWYVbl9K4B2qn8Pp6jCbbEw8E
 bYA/gJ1sK4lJIESILKQ1H2MUNDJJArp6z3FrQRyQPKNVMRnON6tGHF/Y5rom9P4XB3Gn
 zxIQME6Q/bzjOXvBKL5ph6HwZ2o8H6iXSRfcnucKzI4nF+EgVyL4uqy3w/bOhXGBRTr4
 Dee6q9GqJ/oFzXbmqr73w4BqPRsFSPAfzN4mo2mOh47EIy+zzZXMCC/H0W1gwgs+R7D4
 M3Yq9ehjTA/+kxZJjySYsvXEhuX1mF4UIczoe9XpylDwMWI0OyvSfShbAIe+1/G90eaZ
 l6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759838136; x=1760442936;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dJyQsL+cPE5QXe8EQvQ1Pt6/OFgKx8gOarr9WgNRk7w=;
 b=kN9DUS6GxEH7ZakqBviAsZC2B7zdlabKT5MqjnOSAKmpQEKNQsMb1Pcb3wcUdNVn3v
 gvtGU6FMbHHNjIkC3D18wzwMqFOXwpzSGNbf7lQVy8XdzPyK5RGCwwX+OTwDNP2VQ0Pp
 ZK9xb+yE7P02BElxGtF3YQ7QZbCLv0wXMUyWaT0ED3SfNbPC0tmmyz6hdL1wYcB1eehu
 u7HDAZPjgVZDdADJNr/jpa67+JGAVG5LQXanJxscBdsPVpbPnkgycTKDUH3kqXG675LF
 vmbtz/EHtDuU1xOblwhQ6pd3Wyb4BZ0Og4TafQebI0lKhoSVs6K0qJ/chTPaNxeUE4Sn
 +33w==
X-Gm-Message-State: AOJu0YyFyLNlAggP1oQF95OX0aURhsfl+dcVQeOL496GT8UO/SR69EiJ
 Wbpw1a4y7zA8/oVB8D1xS5yxbSomkU1TaIwpI2nApBebwROLvilP37NLZCq1Ibcoowqt2RiKw/I
 LJkv8
X-Gm-Gg: ASbGncuu0DN/71KpJl/pY+PO9UZL8he1BlFL3dNcvq9LBR2lMBEs35Z8R0YPHyh57ao
 KqUI3UCSdKLpQqSB0QQua29lZiOAAk36VLFkwx9VgOoZuZO5TEpgaVBRUh9+tZDfjeun8NLi8Ew
 GP/OL81aaIXdiz+nHsi8YQpucB940fxpRtHy2nIlSH+BYzU6Vr0McAOTam7VEICgaqgn3BQRDjl
 O8U6LKhUF13Lj4SSBcBsfdSuby2xCnCv9WvwU+27Vr3NXyNq+Z3ot21AQdSj4rbbVeLPjT7+sZy
 L1aULoyShJZK8b6AAO2p3sG9kruhC8a57e+CA6wYyhIULAPy4PmW4ZYHBa8c1WrSkJcfE3iB4db
 LQBnV6Af//zLB9cRr8mRrjHpAnYXFht887U+f7Aq/AOb49z8E4lk=
X-Google-Smtp-Source: AGHT+IEcxwo6GFNiwVZ5WQlAe3ySYjfO0CJzQEtSuLAjGixjqVa+3xe2Bim49P1EBwtCSnGqInM5sg==
X-Received: by 2002:a05:600c:3b12:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-46e7110efbemr109119505e9.15.1759838135964; 
 Tue, 07 Oct 2025 04:55:35 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e723591fcsm201851575e9.10.2025.10.07.04.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 04:55:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 969AD5FCAA;
 Tue, 07 Oct 2025 12:55:26 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 07/17] scripts/ci: use recommended registration command
Date: Tue,  7 Oct 2025 12:55:15 +0100
Message-ID: <20251007115525.1998643-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

The registration-token method is being deprecated:

  https://docs.gitlab.com/ci/runners/new_creation_workflow/

As a result we can drop a bunch of the descriptive stuff as that is
entered on the web UI. We don't need a secondary runner if we just
create one with both aarch64 and aarch32 tags.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20251001170947.2769296-8-alex.bennee@linaro.org>

diff --git a/scripts/ci/setup/gitlab-runner.yml b/scripts/ci/setup/gitlab-runner.yml
index 7350f6cff4a..7025935487a 100644
--- a/scripts/ci/setup/gitlab-runner.yml
+++ b/scripts/ci/setup/gitlab-runner.yml
@@ -16,7 +16,7 @@
   tasks:
     - debug:
         msg: 'Checking for a valid GitLab registration token'
-      failed_when: "gitlab_runner_registration_token == 'PLEASE_PROVIDE_A_VALID_TOKEN'"
+      failed_when: "gitlab_runner_authentication_token == 'PLEASE_PROVIDE_A_VALID_TOKEN'"
 
     - name: Create a group for the gitlab-runner service
       group:
@@ -95,15 +95,7 @@
 
     # Register Runners
     - name: Register the gitlab-runner
-      command: "/usr/bin/gitlab-runner register --non-interactive --url {{ gitlab_runner_server_url }} --registration-token {{ gitlab_runner_registration_token }} --executor shell --tag-list {{ ansible_facts[\"architecture\"] }},{{ ansible_facts[\"distribution\"]|lower }}_{{ ansible_facts[\"distribution_version\"] }} --description '{{ ansible_facts[\"distribution\"] }} {{ ansible_facts[\"distribution_version\"] }} {{ ansible_facts[\"architecture\"] }} ({{ ansible_facts[\"os_family\"] }})'"
-
-    # The secondary runner will still run under the single gitlab-runner service
-    - name: Register secondary gitlab-runner
-      command: "/usr/bin/gitlab-runner register --non-interactive --url {{ gitlab_runner_server_url }} --registration-token {{ gitlab_runner_registration_token }} --executor shell --tag-list aarch32,{{ ansible_facts[\"distribution\"]|lower }}_{{ ansible_facts[\"distribution_version\"] }} --description '{{ ansible_facts[\"distribution\"] }} {{ ansible_facts[\"distribution_version\"] }} {{ ansible_facts[\"architecture\"] }} ({{ ansible_facts[\"os_family\"] }})'"
-      when:
-        - ansible_facts['distribution'] == 'Ubuntu'
-        - ansible_facts['architecture'] == 'aarch64'
-        - ansible_facts['distribution_version'] == '24.04'
+      command: "/usr/bin/gitlab-runner register --non-interactive --url {{ gitlab_runner_server_url }} --token {{ gitlab_runner_authentication_token }} --executor shell"
 
     - name: Install the gitlab-runner service using its own functionality
       command: "/usr/bin/gitlab-runner install --user gitlab-runner --working-directory /home/gitlab-runner"
diff --git a/scripts/ci/setup/vars.yml.template b/scripts/ci/setup/vars.yml.template
index 4b355fb80fd..e9ddc05f3b0 100644
--- a/scripts/ci/setup/vars.yml.template
+++ b/scripts/ci/setup/vars.yml.template
@@ -6,5 +6,6 @@ ansible_to_gitlab_arch:
   x86_64: amd64
   aarch64: arm64
   s390x: s390x
-# A unique token made available by GitLab to your project for registering runners
-gitlab_runner_registration_token: PLEASE_PROVIDE_A_VALID_TOKEN
+# A unique token made obtained from GitLab for each runner
+# see: https://gitlab.com/PROJECT/REPO/-/runners/new
+gitlab_runner_authentication_token: PLEASE_PROVIDE_A_VALID_TOKEN
-- 
2.47.3


