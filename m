Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2241EDE9AC
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 17:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so4pv-0005p4-JJ; Tue, 10 Sep 2024 13:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pZ-0004me-V7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:11 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so4pX-0004Zm-D7
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 13:39:09 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a7b1c2f2bso167212066b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 10:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725989946; x=1726594746; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3rTxwacRyl+bWtsw8yvVr2/Byzv5V7eVXyx+MM0eORw=;
 b=j7aYyE4Xa5FqddUOOkh/qeCGuEGRzjI/8SeU0hjB4xOdUKSvK8Lc8BiXIRCEGdYe7U
 0T3EU15uwD0JS7p+BnwX7TvEfrGWpWzjtdMpQ3QFPvvUK/xE0q9NMbDTtFcU2PG46EdE
 GSnJ8E4Q2eKQrTdyuoK+xuDAqAKEbZdeKGKBgyMOlmng/V8r4NZbV5wb5fPWpcYjBGaK
 ZQ7jQkHOxuk/BZGSBH+Fm+WJusgkTGentQG+s571StWxLmgLDc7DGmJTnzTTp86nKdmq
 e7l12f4QnDb32FXeQOwXnGtx/ewrOoDHsOoDfqpv7YGBcXfVIGnqsA29KMyPBw9ZCxoa
 CoMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725989946; x=1726594746;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3rTxwacRyl+bWtsw8yvVr2/Byzv5V7eVXyx+MM0eORw=;
 b=Jsa32f3PK/vdn6+Lzf5SRl2tpildd5fC+uuXTdUZdoNtJXz1u4vCYdstabM2FCvHPR
 0K22SZAAGoJw5eeAu3k/Z3vqc5GPzl8AfY+f10StGirPSn5oFSVFySau+cE9KrKABPe6
 MGuyZ/bxKY5Aak0yOh0kv3/YtOaBZ2mjS+6Ic/NQiupsJ3rRy5Vl07l38/Z1kZ6EOqtg
 HjnIX+mW9F9Gp0DMHSpEHGq3C3z9uowqGTBIQB4X85BPwPhfIA8nBfxgoh2xsYe1qn0s
 zKqHdv+4k0ridCvSteRSGgUtzKDUO8kXZWa2oAEIS5j7Ykgmg1pX6N06de7onM6dxsmi
 Seug==
X-Gm-Message-State: AOJu0YwACc1gne1C9ztmhhC5rssY2kwzdf6q4C8atbhyHIsVuiCJScIG
 tltJO2Y3eVuqfRAWQttv5GBhNOQwDKjlzkqKBJBfQrmGCOVQUc3EqXmGvBgHAro=
X-Google-Smtp-Source: AGHT+IE0k9TBw1KZtC5bnOYFS68MWn5Sz/qewV0BRe90PR3RY5lZ8Au07wLZwuup8S4m73snV6DoSQ==
X-Received: by 2002:a17:907:7292:b0:a8d:2ab2:c990 with SMTP id
 a640c23a62f3a-a9004aba7ebmr28322066b.64.1725989945877; 
 Tue, 10 Sep 2024 10:39:05 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d2592647esm508348266b.48.2024.09.10.10.39.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 10:39:04 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E07665F9CE;
 Tue, 10 Sep 2024 18:39:00 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-arm@nongnu.org,
 devel@lists.libvirt.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH v2 05/10] scripts/ci: update the gitlab-runner playbook
Date: Tue, 10 Sep 2024 18:38:55 +0100
Message-Id: <20240910173900.4154726-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910173900.4154726-1-alex.bennee@linaro.org>
References: <20240910173900.4154726-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Message-Id: <20240910140733.4007719-5-alex.bennee@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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


