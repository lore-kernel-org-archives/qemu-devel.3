Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8302E6FE27
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 15:38:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smb2P-00019u-LF; Fri, 06 Sep 2024 11:38:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smb2N-00018o-Bs
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:38:15 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1smb2L-0006gd-Jn
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 11:38:15 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5c25554ec1eso2385236a12.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725637091; x=1726241891; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aapQk1vd/skAQcOUzQTtovi1QafMjbKZgpmgK7D3jz4=;
 b=x/EIy125UbLfymACwGAE+Bcjl8HrLUmgaYvysjDMpst7UHjMQtkjQEV/ofk5Ts+j1x
 DSvY9N2OwaMZzHg/LRLozbd5eT1xt1c6CUrGB05YWA0FvMwIhV9+/x3jzs9Azq+it+58
 2UkpZdTwZ+keRwYREPPBDYMJngINjvs3DpQEuyAQ1zRAIXDfZ+g+r1gcMSel2OJ2LPwt
 JFV/kWUsU0iMAggukllE4MWDQSzJiWPKVLGZ4qA3RegmrZfFqS5iuZi9g0FKtJ/L/VZw
 niuzIKQln0oKH5FNmulNNJS8DU6+A7sn1HA41Qmb1ul86N9pk8zF2uL0qMV0PmDbw6v9
 b4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725637091; x=1726241891;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aapQk1vd/skAQcOUzQTtovi1QafMjbKZgpmgK7D3jz4=;
 b=RdmUWLHkJAhlVXAx/0DA54l6A8Rpi/Ds5VDMMFasQoLXjYGC76CQKpWvcB+NHWmAZs
 4ITSKwU3VN4AOgo1zBvIhZcJiXajbj2Pa0dVwA438VDXuRttkrQljfTSi1JPScL0Sbw8
 LxNTkAxvOIFRuCXJJIG+KrciG3ik5rtDz9/UqyJu5L5SLAzQS8579EHbhSb/RMzASyAj
 LyxLjuanUxxT9/o3t/y46N5/fgjpvZiVqwZiPg3vW0dOTRy1+Ygxf/uyr5oxZO70wxxo
 Xa5i4P5kXXjerbgsqB1npCJ3306y11hWdyjT7alM7I4WrRhkkdTmEWX4fAqCgrIz942w
 R7Wg==
X-Gm-Message-State: AOJu0YwFQKkBI98pi0pOTTW8erOELRyYeVWaA/aZja9Rt59KCdAsmBq1
 MvUK8+K2CcVCdpa17zlOIYSuqbXKix0TU0TLhedFPxc8ZtLlNu+aySj8K5rh9Ww=
X-Google-Smtp-Source: AGHT+IGakDTMhIjuBadaXP0ukogB37VR6L/uTnSsE/3KG8qCYZTDf0LyfnZht3f/9WiM+Od3W0sBAQ==
X-Received: by 2002:a17:907:c1f:b0:a8d:1284:6de5 with SMTP id
 a640c23a62f3a-a8d12846edcmr21118166b.14.1725637089951; 
 Fri, 06 Sep 2024 08:38:09 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8a7b888be4sm190301866b.63.2024.09.06.08.38.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2024 08:38:08 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id EB54D5F754;
 Fri,  6 Sep 2024 16:38:07 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [RFC PATCH] scripts/ci: update the gitlab-runner playbook
Date: Fri,  6 Sep 2024 16:38:03 +0100
Message-Id: <20240906153803.1765483-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


