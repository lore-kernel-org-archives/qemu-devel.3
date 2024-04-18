Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D569C4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2024 10:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxOk5-0001eW-KE; Thu, 18 Apr 2024 06:11:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxOk3-0001df-TP
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rxOk0-0004tO-F3
 for qemu-devel@nongnu.org; Thu, 18 Apr 2024 06:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713435099;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RjMb3Pg6/OUNtybxhe3hrJ32jglibhNx5G1TDCLq18w=;
 b=gU9j9VMdNS7CzeeHoAjF+wIvP4TBtNxT6lVdnxfdq9tHlWYbF841dJ3gOjsCxzR+5+TLJb
 BquzLSG3sRLoshpZiVIY3Bq4JZrAxCjCuTUu3RzONTsYjTSUQZCg4pz/t7q9KQcsClo5eW
 4jHWvD3eY403tsw0bns8z7xr50X8Ijk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670--D6wjPEqO8irBQzwtj3Rjw-1; Thu, 18 Apr 2024 06:11:36 -0400
X-MC-Unique: -D6wjPEqO8irBQzwtj3Rjw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F07561049C9B;
 Thu, 18 Apr 2024 10:11:34 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.223])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A5A57C1A225;
 Thu, 18 Apr 2024 10:11:18 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Lieven <pl@dlhnet.de>, "Richard W.M. Jones" <rjones@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-block@nongnu.org
Subject: [PATCH v3 06/13] ci: move external build environment setups to CentOS
 Stream 9
Date: Thu, 18 Apr 2024 12:10:49 +0200
Message-ID: <20240418101056.302103-7-thuth@redhat.com>
In-Reply-To: <20240418101056.302103-1-thuth@redhat.com>
References: <20240418101056.302103-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.719,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

From: Paolo Bonzini <pbonzini@redhat.com>

RHEL 9 (and thus also the derivatives) are available since two years
now, so according to QEMU's support policy, we can drop the active
support for the previous major version 8 now.

Thus upgrade our CentOS Stream build environment playbooks to major
version 9 now.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240412103708.27650-1-pbonzini@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 .../stream/{8 => 9}/build-environment.yml     | 31 ++++++-------
 .../stream/{8 => 9}/x86_64/configure          |  4 +-
 .../stream/{8 => 9}/x86_64/test-avocado       |  0
 scripts/ci/setup/build-environment.yml        | 44 +++++++------------
 4 files changed, 34 insertions(+), 45 deletions(-)
 rename scripts/ci/org.centos/stream/{8 => 9}/build-environment.yml (75%)
 rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/configure (98%)
 rename scripts/ci/org.centos/stream/{8 => 9}/x86_64/test-avocado (100%)

diff --git a/scripts/ci/org.centos/stream/8/build-environment.yml b/scripts/ci/org.centos/stream/9/build-environment.yml
similarity index 75%
rename from scripts/ci/org.centos/stream/8/build-environment.yml
rename to scripts/ci/org.centos/stream/9/build-environment.yml
index 1ead77e2cb..cd29fe6f27 100644
--- a/scripts/ci/org.centos/stream/8/build-environment.yml
+++ b/scripts/ci/org.centos/stream/9/build-environment.yml
@@ -2,32 +2,32 @@
 - name: Installation of extra packages to build QEMU
   hosts: all
   tasks:
-    - name: Extra check for CentOS Stream 8
+    - name: Extra check for CentOS Stream 9
       lineinfile:
         path: /etc/redhat-release
-        line: CentOS Stream release 8
+        line: CentOS Stream release 9
         state: present
       check_mode: yes
-      register: centos_stream_8
+      register: centos_stream_9
 
-    - name: Enable EPEL repo on CentOS Stream 8
+    - name: Enable EPEL repo on CentOS Stream 9
       dnf:
         name:
           - epel-release
         state: present
       when:
-        - centos_stream_8
+        - centos_stream_9
 
-    - name: Enable PowerTools repo on CentOS Stream 8
+    - name: Enable CRB repo on CentOS Stream 9
       ini_file:
-        path: /etc/yum.repos.d/CentOS-Stream-PowerTools.repo
-        section: powertools
+        path: /etc/yum.repos.d/centos.repo
+        section: crb
         option: enabled
         value: "1"
       when:
-        - centos_stream_8
+        - centos_stream_9
 
-    - name: Install basic packages to build QEMU on CentOS Stream 8
+    - name: Install basic packages to build QEMU on CentOS Stream 9
       dnf:
         name:
           - bzip2
@@ -42,7 +42,6 @@
           - gettext
           - git
           - glib2-devel
-          - glusterfs-api-devel
           - gnutls-devel
           - libaio-devel
           - libcap-ng-devel
@@ -61,22 +60,24 @@
           - lzo-devel
           - make
           - mesa-libEGL-devel
+          - meson
           - nettle-devel
           - ninja-build
           - nmap-ncat
           - numactl-devel
           - pixman-devel
-          - python38
+          - python3
+          - python3-pip
           - python3-sphinx
+          - python3-sphinx_rtd_theme
+          - python3-tomli
           - rdma-core-devel
           - redhat-rpm-config
           - snappy-devel
-          - spice-glib-devel
-          - spice-server-devel
           - systemd-devel
           - systemtap-sdt-devel
           - tar
           - zlib-devel
         state: present
       when:
-        - centos_stream_8
+        - centos_stream_9
diff --git a/scripts/ci/org.centos/stream/8/x86_64/configure b/scripts/ci/org.centos/stream/9/x86_64/configure
similarity index 98%
rename from scripts/ci/org.centos/stream/8/x86_64/configure
rename to scripts/ci/org.centos/stream/9/x86_64/configure
index 76781f17f4..1b6f40fd78 100755
--- a/scripts/ci/org.centos/stream/8/x86_64/configure
+++ b/scripts/ci/org.centos/stream/9/x86_64/configure
@@ -16,7 +16,7 @@
 # that patches adding downstream specific devices are not available.
 #
 ../configure \
---python=/usr/bin/python3.8 \
+--python=/usr/bin/python3.9 \
 --prefix="/usr" \
 --libdir="/usr/lib64" \
 --datadir="/usr/share" \
@@ -157,7 +157,6 @@
 --enable-docs \
 --enable-fdt \
 --enable-gcrypt \
---enable-glusterfs \
 --enable-gnutls \
 --enable-guest-agent \
 --enable-iconv \
@@ -180,7 +179,6 @@
 --enable-seccomp \
 --enable-snappy \
 --enable-smartcard \
---enable-spice \
 --enable-system \
 --enable-tcg \
 --enable-tools \
diff --git a/scripts/ci/org.centos/stream/8/x86_64/test-avocado b/scripts/ci/org.centos/stream/9/x86_64/test-avocado
similarity index 100%
rename from scripts/ci/org.centos/stream/8/x86_64/test-avocado
rename to scripts/ci/org.centos/stream/9/x86_64/test-avocado
diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index f344d1a850..9b7d96c01b 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -174,26 +174,26 @@
         - ansible_facts['distribution_version'] == '22.04'
         - ansible_facts['architecture'] == 'aarch64'
 
-    - name: Enable EPEL repo on EL8
+    - name: Enable EPEL repo on EL9
       dnf:
         name:
           - epel-release
         state: present
       when:
         - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_major_version'] == '8'
+        - ansible_facts['distribution_major_version'] == '9'
 
-    - name: Enable PowerTools repo on CentOS 8
+    - name: Enable CRB repo on CentOS 9
       ini_file:
-        path: /etc/yum.repos.d/CentOS-Stream-PowerTools.repo
-        section: powertools
+        path: /etc/yum.repos.d/centos.repo
+        section: crb
         option: enabled
         value: "1"
       when:
         - ansible_facts['distribution_file_variety'] == 'CentOS'
-        - ansible_facts['distribution_major_version'] == '8'
+        - ansible_facts['distribution_major_version'] == '9'
 
-    - name: Install basic packages to build QEMU on EL8
+    - name: Install basic packages to build QEMU on EL9
       dnf:
         # This list of packages start with tests/docker/dockerfiles/centos8.docker
         # but only include files that are common to all distro variants and present
@@ -211,7 +211,6 @@
           - gettext
           - git
           - glib2-devel
-          - glusterfs-api-devel
           - gnutls-devel
           - libaio-devel
           - libcap-ng-devel
@@ -229,17 +228,20 @@
           - lzo-devel
           - make
           - mesa-libEGL-devel
+          - meson
           - nettle-devel
           - ninja-build
           - nmap-ncat
           - numactl-devel
           - pixman-devel
-          - python38
+          - python3
+          - python3-pip
           - python3-sphinx
+          - python3-sphinx_rtd_theme
+          - python3-tomli
           - rdma-core-devel
           - redhat-rpm-config
           - snappy-devel
-          - spice-glib-devel
           - systemd-devel
           - systemtap-sdt-devel
           - tar
@@ -247,28 +249,16 @@
         state: present
       when:
         - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_version'] == '8'
-
-    - name: Install packages only available on x86 and aarch64
-      dnf:
-        # Spice server not available in ppc64le
-        name:
-          - spice-server
-          - spice-server-devel
-        state: present
-      when:
-        - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_version'] == '8'
-        - ansible_facts['architecture'] == 'aarch64' or ansible_facts['architecture'] == 'x86_64'
+        - ansible_facts['distribution_version'] == '9'
 
     - name: Check whether the Python runtime version is managed by alternatives
       stat:
         path: /etc/alternatives/python3
       register: python3
 
-    - name: Set default Python runtime to 3.8 on EL8
-      command: alternatives --set python3 /usr/bin/python3.8
+    - name: Set default Python runtime to 3.9 on EL9
+      command: alternatives --set python3 /usr/bin/python3.9
       when:
         - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_version'] == '8'
-        - python3.stat.islnk and python3.stat.lnk_target != '/usr/bin/python3.8'
+        - ansible_facts['distribution_version'] == '9'
+        - python3.stat.exists and python3.stat.islnk and python3.stat.lnk_target != '/usr/bin/python3.9'
-- 
2.44.0


