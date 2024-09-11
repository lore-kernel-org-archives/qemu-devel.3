Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3080DEE0213
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 06:48:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soH7x-0000dq-7q; Wed, 11 Sep 2024 02:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7v-0000YO-P7
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:55 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1soH7s-0004Pa-Kr
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 02:46:55 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8a6d1766a7so195148966b.3
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726037211; x=1726642011; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FrvaAWuF5v0aOpUmK/2t60ZFaqLxvEHy+/W3U6nvVig=;
 b=OaPdf/jaOMfpBc0FPBwpZksFFTXAkca4U6xVZcoeMexnrE4H+yUIoAORtuOelWqFvw
 fx550NHLepfQUL+zwCtiREpS8rBrwHwvww7jf52ufpEFRizjur1xbYp/3zLkXrfAfuwb
 HmIr31/X2efZUB0Pr8i3sUi9sRDsIXs+2Ade0+8DfqNAdiMnepnqUT9+d4a9KNaTPoev
 CugY4TEPcZie+cVYLtuQfN9vjyr6XWm2/Yeh/3UJxG+II9Prx+ZUaBZui0OQhNzBGFnr
 xdKr1/idBOZ8AEDiu/ZdP7+/QsYlsINT/wCDB1Ej76RT0scXtHn4pdEBs6pJPDx34j70
 OLig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726037211; x=1726642011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FrvaAWuF5v0aOpUmK/2t60ZFaqLxvEHy+/W3U6nvVig=;
 b=DP0R1qtazcp5Uvcsap0QWxGx95YofztxinOoED2zoivVEQCZhJ4FgMWUHcst+70E9W
 PgMgbXQy48r2WPRucBGelIXJTFd2j+MsXGMuWHUGmmxrRfLX/WssK1wf6r326wT5upzD
 gqRK2i8YnQz09I+HK0C5QvK169kqoiRImbTgRWfZFDIXsVxeNL5ysm/ONKnSHNgmiUWZ
 2CslIleR0m6r0TAOUByUJGotIlWKyJ3xqaQNDAFuWlFyJUhkgqYjhZ9NZ9Sfpk+XxJl3
 unF0kBN7WpW/Y9o+p/LzIHvigJIyMHR6Bv/9GiiDCT8EtX2KvrpdGFkvXh9Ghv6qLORB
 gkxA==
X-Gm-Message-State: AOJu0Yx/8Id6R5Q0EtGHoFUN7LVKihHisk84D9iRnPmNavvYe57cJ5Yz
 tT/qeL3NjnXWSOicIjvlEzuRGTdisTdOIs+ogZrltJdshno3Z58gDqTjDGc+eE0=
X-Google-Smtp-Source: AGHT+IERtAsQgeXXopaqqU30+ux46vAEZ8HmDungI4VJsCJTHc6dyDo9Zpr00/MfbC/dPDtYAw4X1w==
X-Received: by 2002:a17:907:86a1:b0:a8a:83e9:43e2 with SMTP id
 a640c23a62f3a-a90047457e7mr183129466b.12.1726037210948; 
 Tue, 10 Sep 2024 23:46:50 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9012fa463csm19801366b.139.2024.09.10.23.46.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 23:46:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 802E05FA0E;
 Wed, 11 Sep 2024 07:46:46 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 05/10] scripts/ci: update the gitlab-runner playbook
Date: Wed, 11 Sep 2024 07:46:40 +0100
Message-Id: <20240911064645.357592-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240911064645.357592-1-alex.bennee@linaro.org>
References: <20240911064645.357592-1-alex.bennee@linaro.org>
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240910173900.4154726-6-alex.bennee@linaro.org>

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


