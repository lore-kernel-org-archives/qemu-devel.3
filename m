Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F56ECE564
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1Wy-0007Yd-Ba; Tue, 10 Sep 2024 10:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wv-0007O5-Or
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:41 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Ws-0006Tv-6H
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:41 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5c3cdba33b0so5894411a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977256; x=1726582056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aapQk1vd/skAQcOUzQTtovi1QafMjbKZgpmgK7D3jz4=;
 b=QKu9bjtEvLDx32kwB5s+u0Kf8bDDclFtxEUsWJvxYzf5ug5yT7Q6AIflT22jBuuRoH
 7tP/mz3P5Df4mieuAYoQBtorS5XYmTUjhD8xd8q9WBNOk5oEkeVmSx3Qyc0y+eJJbgdB
 EpqMnOg5azCs5StrfM7fqiqu0L2Z8jHqOU0rT596iVCR6iV+XXBvGkfDjx4x4O8conGy
 49P41WiEbMg5WB16R3pVAfIswJI6bFJxqJokNqsqZUoRQrbMeak3RO28p0wN5KvGVG6W
 TLjn63dPKZ40vb+R4htPGSDHfOnJiLeqiM35/amrNVQRUBqq3yKbEYZMFfuRsduKRYYG
 QnpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977256; x=1726582056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aapQk1vd/skAQcOUzQTtovi1QafMjbKZgpmgK7D3jz4=;
 b=r6/dGj4Q0CTpqWdgs/4AOfD6nC+Spxksq+RzfMExLeNtpAqLv5flkB0UQFfQ8ZMkT0
 iuTmIlF8bFm+aWe0KklgwA74tHMUOILWe8RjYW9XM7+eYl2i6bK+aejZ65F7Y7IWb2mC
 hgOkD2phALZ9sCSt5VDEMtsOJtDuPFBhJXKkYNgdf4cfQmiP2se4vUX016Muecr2siAz
 tvNIq3kDGED7bwMWBtPqdkr9Umxi36BwpnwmTLmchGSctZUgzZcuOBEsFx6Y8Cgn39y9
 pqz4EliG7KCMbp0ZL+YTc377yV6gK8MJwQ/kqPXtcU0BhtqJytYQQoGQjQH+EpoabpAI
 S8pg==
X-Gm-Message-State: AOJu0Yw69aAHaUFI2/PQL/xmW/3bG9lB0uzeIPYdkNzgLyZwZ8v5EToc
 9ZH0D27QBfo1Haz1kpQwO+DURP5xyfPKa0fsGBTaRYz8IqfrvKxVbkWVYjFtnnI=
X-Google-Smtp-Source: AGHT+IEVAIEEqGMWQsXh9dt5MPuBFRt53jahMB917OVma3lzDJh9VVW7y8UMT1SN4mnhFtYUk1VutQ==
X-Received: by 2002:a17:907:7ea3:b0:a86:9f56:21e6 with SMTP id
 a640c23a62f3a-a8ffab832ebmr81996566b.33.1725977256225; 
 Tue, 10 Sep 2024 07:07:36 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25d64880sm480900266b.219.2024.09.10.07.07.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:34 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0BCDA5F9CC;
 Tue, 10 Sep 2024 15:07:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 04/26] scripts/ci: update the gitlab-runner playbook
Date: Tue, 10 Sep 2024 15:07:11 +0100
Message-Id: <20240910140733.4007719-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The upstream install instructions:

  https://docs.gitlab.com/runner/install/linux-repository.html

Now refer to repositories and a setup script. Modernise the playbook
to use the preferred delivery method.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/setup/gitlab-runner.yml | 39 +++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 9 deletions(-)

diff --git a/scripts/ci/setup/gitlab-runner.yml b/scripts/ci/setup/gitlab-runner.yml
index 7bdafab511..57e7faebf1 100644
--- a/scripts/ci/setup/gitlab-runner.yml
+++ b/scripts/ci/setup/gitlab-runner.yml
@@ -49,30 +49,51 @@
     - debug:
         msg: gitlab-runner arch is {{ gitlab_runner_arch }}
 
-    - name: Download the matching gitlab-runner (DEB)
+    # Debian/Ubuntu setup
+    - name: Get gitlab-runner repo setup script (DEB)
       get_url:
         dest: "/root/"
-        url: "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_{{ gitlab_runner_arch }}.deb"
+        url: "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh"
+        mode: 0755
       when:
         - ansible_facts['distribution'] == 'Ubuntu'
 
-    - name: Download the matching gitlab-runner (RPM)
+    - name: Run gitlab-runner repo setup script (DEB)
+      shell: "/root/script.deb.sh"
+      when:
+        - ansible_facts['distribution'] == 'Ubuntu'
+
+    - name: Install gitlab-runner (DEB)
+      ansible.builtin.apt:
+          name: gitlab-runner
+          update_cache: yes
+          state: present
+      when:
+        - ansible_facts['distribution'] == 'Ubuntu'
+
+    # RPM setup
+    - name: Get gitlab-runner repo setup script (RPM)
       get_url:
         dest: "/root/"
-        url: "https://gitlab-runner-downloads.s3.amazonaws.com/latest/rpm/gitlab-runner_{{ gitlab_runner_arch }}.rpm"
+        url: "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh"
+        mode: 0755
       when:
         - ansible_facts['distribution'] == 'CentOS'
 
-    - name: Install gitlab-runner via package manager (DEB)
-      apt: deb="/root/gitlab-runner_{{ gitlab_runner_arch }}.deb"
+    - name: Run gitlab-runner repo setup script (RPM)
+      shell: "/root/script.rpm.sh"
       when:
-        - ansible_facts['distribution'] == 'Ubuntu'
+        - ansible_facts['distribution'] == 'CentOS'
 
-    - name: Install gitlab-runner via package manager (RPM)
-      yum: name="/root/gitlab-runner_{{ gitlab_runner_arch }}.rpm"
+    - name: Install gitlab-runner (RPM)
+      yum:
+        name: gitlab-runner
+        update_cache: yes
+        state: present
       when:
         - ansible_facts['distribution'] == 'CentOS'
 
+    # Register Runners
     - name: Register the gitlab-runner
       command: "/usr/bin/gitlab-runner register --non-interactive --url {{ gitlab_runner_server_url }} --registration-token {{ gitlab_runner_registration_token }} --executor shell --tag-list {{ ansible_facts[\"architecture\"] }},{{ ansible_facts[\"distribution\"]|lower }}_{{ ansible_facts[\"distribution_version\"] }} --description '{{ ansible_facts[\"distribution\"] }} {{ ansible_facts[\"distribution_version\"] }} {{ ansible_facts[\"architecture\"] }} ({{ ansible_facts[\"os_family\"] }})'"
 
-- 
2.39.2


