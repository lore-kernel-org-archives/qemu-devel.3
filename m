Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EF6FC27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:52:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBdv-0007f1-Uu; Thu, 06 Jun 2024 07:50:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdt-0007dw-Qx
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:53 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdr-0000s0-1I
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:53 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52b93370ad0so1143539e87.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674649; x=1718279449; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXWdlomnsbuR2dFJ27nGIJWK1MsThS2P51i0jY+0KAU=;
 b=hLDbF7sVTbXBAVajqL5h4QpaaoZm1Lq6Or0E9lhpexZC573/26n2pvNdbwNzTV1B9T
 B9GXgleWzw1rPSllVNr3KKu+qQcG/DQfG/U1bMm3ABGemwf1pVCHCd+LAcrNlITrEH54
 v8Cals1oIumCfQkFV0O/q/Rl2Bvt3eogSCOC46X4uA/4UYL9fkqytKwHw0wA+YNerTln
 N5CLeBd2LKMLB73RuyLyT6VBwe68mUEndCwQ7mSoPWtRMFwKgWAZo6iBl2jREFAyefQc
 BzPF3Ja+2NKfBPnFiYxb3JrFZnC/Fkr3/aDxBIs9AYMQgcEyQQxke4iBWwXq/CZwaqca
 R3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674649; x=1718279449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pXWdlomnsbuR2dFJ27nGIJWK1MsThS2P51i0jY+0KAU=;
 b=mI5eOswuUbmCLakvQqCHcZliNDRhUvskMDxiR16LFDCkwwcM5ETQXpq3leUFJOOsmg
 EeR8eqyN66Eu+ntRkOcGzbbgQsG/Lbv71YO295fq8U3Vt38prGvX1G2dNTS3T7x22zZG
 1mQ4ggDHHv7sDTpOJFUditSie1zs/NE6xtwHoDT2khZSckeJu2bonkH1H38DMLIRIMlj
 n3E0dAshG/8Y/WUfZYAhPsfhsjLvGVaOM/ngEpEwurpMRC7g9MrCz9wcWP/kXFetMZon
 dwBKuK8RPU+dB7O/bxdmcZ8QZ29jV/mWMVlolxpiu3cw4SVsiEbZ2AE4pyBUwaVjxYh2
 bdnw==
X-Gm-Message-State: AOJu0YzUn50mJifwmbCM9Y3qZmz7z4xU0GSGZYe+0IHa1YX1r+t/xhNS
 nk5pGZNRxL5wDuvTv1an/rBsnZsy28707+QJYXldmSzq9/T2Ka/VG8tZyyaNm8k=
X-Google-Smtp-Source: AGHT+IGEvtuP1uv0TezAx/c0k4j8bR6IgghrDKju+u7BPXNsxB6igYzEIEVj6poeE8iVZyDNK6dQ2A==
X-Received: by 2002:ac2:5592:0:b0:52b:fb4:1283 with SMTP id
 2adb3069b0e04-52bab4d8022mr3779436e87.15.1717674649051; 
 Thu, 06 Jun 2024 04:50:49 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6c805cbca9sm87311266b.65.2024.06.06.04.50.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:48 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 011845F8CB;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 01/12] ci: remove centos-steam-8 customer runner
Date: Thu,  6 Jun 2024 12:50:36 +0100
Message-Id: <20240606115047.421045-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x132.google.com
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

This broke since eef0bae3a7 (migration: Remove block migration) but
even after that was addressed it still fails to complete. As it will
shortly be EOL lets to remove the runner definition and the related
ansible setup bits.

We still have centos9 docker images build and test.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-2-alex.bennee@linaro.org>

diff --git a/docs/devel/ci-jobs.rst.inc b/docs/devel/ci-jobs.rst.inc
index be06322279..3756bbe355 100644
--- a/docs/devel/ci-jobs.rst.inc
+++ b/docs/devel/ci-jobs.rst.inc
@@ -182,13 +182,6 @@ If you've got access to an IBM Z host that can be used as a gitlab-CI
 runner, you can set this variable to enable the tests that require this
 kind of host. The runner should be tagged with "s390x".
 
-CENTOS_STREAM_8_x86_64_RUNNER_AVAILABLE
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-If you've got access to a CentOS Stream 8 x86_64 host that can be
-used as a gitlab-CI runner, you can set this variable to enable the
-tests that require this kind of host. The runner should be tagged with
-both "centos_stream_8" and "x86_64".
-
 CCACHE_DISABLE
 ~~~~~~~~~~~~~~
 The jobs are configured to use "ccache" by default since this typically
diff --git a/.gitlab-ci.d/custom-runners.yml b/.gitlab-ci.d/custom-runners.yml
index 29e52df283..1aa3c60efe 100644
--- a/.gitlab-ci.d/custom-runners.yml
+++ b/.gitlab-ci.d/custom-runners.yml
@@ -32,4 +32,3 @@ include:
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-s390x.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch64.yml'
   - local: '/.gitlab-ci.d/custom-runners/ubuntu-22.04-aarch32.yml'
-  - local: '/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml'
diff --git a/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml b/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml
deleted file mode 100644
index 367424db78..0000000000
--- a/.gitlab-ci.d/custom-runners/centos-stream-8-x86_64.yml
+++ /dev/null
@@ -1,24 +0,0 @@
-# All centos-stream-8 jobs should run successfully in an environment
-# setup by the scripts/ci/setup/stream/8/build-environment.yml task
-# "Installation of extra packages to build QEMU"
-
-centos-stream-8-x86_64:
- extends: .custom_runner_template
- allow_failure: true
- needs: []
- stage: build
- tags:
- - centos_stream_8
- - x86_64
- rules:
- - if: '$CI_PROJECT_NAMESPACE == "qemu-project" && $CI_COMMIT_BRANCH =~ /^staging/'
- - if: "$CENTOS_STREAM_8_x86_64_RUNNER_AVAILABLE"
- before_script:
- - JOBS=$(expr $(nproc) + 1)
- script:
- - mkdir build
- - cd build
- - ../scripts/ci/org.centos/stream/8/x86_64/configure
-   || { cat config.log meson-logs/meson-log.txt; exit 1; }
- - make -j"$JOBS"
- - make NINJA=":" check check-avocado
diff --git a/scripts/ci/org.centos/stream/8/build-environment.yml b/scripts/ci/org.centos/stream/8/build-environment.yml
deleted file mode 100644
index 1ead77e2cb..0000000000
--- a/scripts/ci/org.centos/stream/8/build-environment.yml
+++ /dev/null
@@ -1,82 +0,0 @@
----
-- name: Installation of extra packages to build QEMU
-  hosts: all
-  tasks:
-    - name: Extra check for CentOS Stream 8
-      lineinfile:
-        path: /etc/redhat-release
-        line: CentOS Stream release 8
-        state: present
-      check_mode: yes
-      register: centos_stream_8
-
-    - name: Enable EPEL repo on CentOS Stream 8
-      dnf:
-        name:
-          - epel-release
-        state: present
-      when:
-        - centos_stream_8
-
-    - name: Enable PowerTools repo on CentOS Stream 8
-      ini_file:
-        path: /etc/yum.repos.d/CentOS-Stream-PowerTools.repo
-        section: powertools
-        option: enabled
-        value: "1"
-      when:
-        - centos_stream_8
-
-    - name: Install basic packages to build QEMU on CentOS Stream 8
-      dnf:
-        name:
-          - bzip2
-          - bzip2-devel
-          - capstone-devel
-          - dbus-daemon
-          - device-mapper-multipath-devel
-          - diffutils
-          - gcc
-          - gcc-c++
-          - genisoimage
-          - gettext
-          - git
-          - glib2-devel
-          - glusterfs-api-devel
-          - gnutls-devel
-          - libaio-devel
-          - libcap-ng-devel
-          - libcurl-devel
-          - libepoxy-devel
-          - libfdt-devel
-          - libgcrypt-devel
-          - libiscsi-devel
-          - libpmem-devel
-          - librados-devel
-          - librbd-devel
-          - libseccomp-devel
-          - libslirp-devel
-          - libssh-devel
-          - libxkbcommon-devel
-          - lzo-devel
-          - make
-          - mesa-libEGL-devel
-          - nettle-devel
-          - ninja-build
-          - nmap-ncat
-          - numactl-devel
-          - pixman-devel
-          - python38
-          - python3-sphinx
-          - rdma-core-devel
-          - redhat-rpm-config
-          - snappy-devel
-          - spice-glib-devel
-          - spice-server-devel
-          - systemd-devel
-          - systemtap-sdt-devel
-          - tar
-          - zlib-devel
-        state: present
-      when:
-        - centos_stream_8
diff --git a/scripts/ci/org.centos/stream/8/x86_64/configure b/scripts/ci/org.centos/stream/8/x86_64/configure
deleted file mode 100755
index 868db665f6..0000000000
--- a/scripts/ci/org.centos/stream/8/x86_64/configure
+++ /dev/null
@@ -1,198 +0,0 @@
-#!/bin/sh -e
-#
-# Configuration for QEMU based on CentOS Stream 8 x86_64 builds
-#
-# The "configure" command line is based on:
-#
-# https://git.centos.org/rpms/qemu-kvm/blob/c8s-stream-rhel/f/SPECS/qemu-kvm.spec
-#
-# But, because the SPEC file contains a number of conditionals and
-# variable and expansions only available at RPM build time, this version
-# was initially generated from an actual RPM build on an x86_64 platform.
-#
-# From that initial version, options that are required or are a
-# consequence of non-upstream patches have been adapted.  One example
-# is "--without-default-devices" which is *not* present here, given
-# that patches adding downstream specific devices are not available.
-#
-../configure \
---python=/usr/bin/python3.8 \
---prefix="/usr" \
---libdir="/usr/lib64" \
---datadir="/usr/share" \
---sysconfdir="/etc" \
---interp-prefix=/usr/qemu-%M \
---localstatedir="/var" \
---docdir="/usr/share/doc" \
---libexecdir="/usr/libexec" \
---extra-ldflags="-Wl,--build-id -Wl,-z,relro -Wl,-z,now" \
---extra-cflags="-O2 -g -pipe -Wall -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2 -Wp,-D_GLIBCXX_ASSERTIONS -fexceptions -fstack-protector-strong -grecord-gcc-switches -specs=/usr/lib/rpm/redhat/redhat-hardened-cc1 -specs=/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=generic -fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection" \
---with-suffix="qemu-kvm" \
---firmwarepath=/usr/share/qemu-firmware \
---target-list="x86_64-softmmu" \
---block-drv-rw-whitelist="qcow2,raw,file,host_device,nbd,iscsi,rbd,blkdebug,luks,null-co,nvme,copy-on-read,throttle,gluster" \
---audio-drv-list="" \
---block-drv-ro-whitelist="vmdk,vhdx,vpc,https,ssh" \
---with-coroutine=ucontext \
---tls-priority=@QEMU,SYSTEM \
---disable-af-xdp \
---disable-attr \
---disable-auth-pam \
---disable-avx2 \
---disable-avx512f \
---disable-bochs \
---disable-bpf \
---disable-brlapi \
---disable-bsd-user \
---disable-bzip2 \
---disable-cap-ng \
---disable-capstone \
---disable-cfi \
---disable-cfi-debug \
---disable-cloop \
---disable-cocoa \
---disable-coroutine-pool \
---disable-crypto-afalg \
---disable-curl \
---disable-curses \
---disable-debug-info \
---disable-debug-mutex \
---disable-debug-tcg \
---disable-dmg \
---disable-docs \
---disable-fuse \
---disable-fuse-lseek \
---disable-gcrypt \
---disable-gio \
---disable-glusterfs \
---disable-gnutls \
---disable-gtk \
---disable-guest-agent \
---disable-guest-agent-msi \
---disable-hvf \
---disable-iconv \
---disable-kvm \
---disable-libdaxctl \
---disable-libiscsi \
---disable-libnfs \
---disable-libpmem \
---disable-libssh \
---disable-libudev \
---disable-libusb \
---disable-linux-aio \
---disable-linux-io-uring \
---disable-linux-user \
---disable-live-block-migration \
---disable-lto \
---disable-lzfse \
---disable-lzo \
---disable-malloc-trim \
---disable-membarrier \
---disable-modules \
---disable-module-upgrades \
---disable-mpath \
---disable-multiprocess \
---disable-netmap \
---disable-nettle \
---disable-numa \
---disable-nvmm \
---disable-opengl \
---disable-parallels \
---disable-pie \
---disable-qcow1 \
---disable-qed \
---disable-qom-cast-debug \
---disable-rbd \
---disable-rdma \
---disable-replication \
---disable-rng-none \
---disable-safe-stack \
---disable-sanitizers \
---disable-sdl \
---disable-sdl-image \
---disable-seccomp \
---disable-slirp-smbd \
---disable-smartcard \
---disable-snappy \
---disable-sparse \
---disable-spice \
---disable-strip \
---disable-system \
---disable-tcg \
---disable-tools \
---disable-tpm \
---disable-u2f \
---disable-usb-redir \
---disable-user \
---disable-vde \
---disable-vdi \
---disable-vhost-crypto \
---disable-vhost-kernel \
---disable-vhost-net \
---disable-vhost-user \
---disable-vhost-user-blk-server \
---disable-vhost-vdpa \
---disable-virglrenderer \
---disable-virtfs \
---disable-vnc \
---disable-vnc-jpeg \
---disable-png \
---disable-vnc-sasl \
---disable-vte \
---disable-vvfat \
---disable-werror \
---disable-whpx \
---disable-xen \
---disable-xen-pci-passthrough \
---disable-xkbcommon \
---disable-zstd \
---enable-attr \
---enable-avx2 \
---enable-cap-ng \
---enable-capstone \
---enable-coroutine-pool \
---enable-curl \
---enable-debug-info \
---enable-docs \
---enable-fdt \
---enable-gcrypt \
---enable-glusterfs \
---enable-gnutls \
---enable-guest-agent \
---enable-iconv \
---enable-kvm \
---enable-libiscsi \
---enable-libpmem \
---enable-libssh \
---enable-libusb \
---enable-libudev \
---enable-linux-aio \
---enable-lzo \
---enable-malloc-trim \
---enable-modules \
---enable-mpath \
---enable-numa \
---enable-opengl \
---enable-pie \
---enable-rbd \
---enable-rdma \
---enable-seccomp \
---enable-snappy \
---enable-smartcard \
---enable-spice \
---enable-system \
---enable-tcg \
---enable-tools \
---enable-tpm \
---enable-trace-backends=dtrace \
---enable-usb-redir \
---enable-vhost-kernel \
---enable-vhost-net \
---enable-vhost-user \
---enable-vhost-user-blk-server \
---enable-vhost-vdpa \
---enable-vnc \
---enable-png \
---enable-vnc-sasl \
---enable-werror \
---enable-xkbcommon
diff --git a/scripts/ci/org.centos/stream/8/x86_64/test-avocado b/scripts/ci/org.centos/stream/8/x86_64/test-avocado
deleted file mode 100755
index 73e7a1a312..0000000000
--- a/scripts/ci/org.centos/stream/8/x86_64/test-avocado
+++ /dev/null
@@ -1,65 +0,0 @@
-#!/bin/sh -e
-#
-# Runs a previously vetted list of tests, either marked explicitly for
-# KVM and x86_64, or tests that are generic enough to be valid for all
-# targets. Such a test list can be generated with:
-#
-# ./pyvenv/bin/avocado list --filter-by-tags-include-empty \
-#   --filter-by-tags-include-empty-key -t accel:kvm,arch:x86_64 \
-#   tests/avocado/
-#
-# This is almost the complete list of avocado based tests available at
-# the time this was compile, with the following exceptions:
-#
-# * Require machine type "x-remote":
-#   - tests/avocado/multiprocess.py:Multiprocess.test_multiprocess_x86_64
-#
-# * Requires display type "egl-headless":
-#   - tests/avocado/virtio-gpu.py:VirtioGPUx86.test_virtio_vga_virgl
-#   - tests/avocado/virtio-gpu.py:VirtioGPUx86.test_vhost_user_vga_virgl
-#
-#  * Test is marked (unconditionally) to be skipped:
-#   - tests/avocado/virtio_check_params.py:VirtioMaxSegSettingsCheck.test_machine_types
-#
-make get-vm-images
-./pyvenv/bin/avocado run \
-    --job-results-dir=tests/results/ \
-    tests/avocado/boot_linux.py:BootLinuxX8664.test_pc_i440fx_kvm \
-    tests/avocado/boot_linux.py:BootLinuxX8664.test_pc_q35_kvm \
-    tests/avocado/boot_linux_console.py:BootLinuxConsole.test_x86_64_pc \
-    tests/avocado/cpu_queries.py:QueryCPUModelExpansion.test \
-    tests/avocado/empty_cpu_model.py:EmptyCPUModel.test \
-    tests/avocado/hotplug_cpu.py:HotPlugCPU.test \
-    tests/avocado/netdev-ethtool.py:NetDevEthtool.test_igb \
-    tests/avocado/netdev-ethtool.py:NetDevEthtool.test_igb_nomsi \
-    tests/avocado/info_usernet.py:InfoUsernet.test_hostfwd \
-    tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu \
-    tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_pt \
-    tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict \
-    tests/avocado/intel_iommu.py:IntelIOMMU.test_intel_iommu_strict_cm \
-    tests/avocado/linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_exit_error_msg_with_linux_v3_6 \
-    tests/avocado/linux_initrd.py:LinuxInitrd.test_with_2gib_file_should_work_with_linux_v4_16 \
-    tests/avocado/migration.py:Migration.test_migration_with_exec \
-    tests/avocado/migration.py:Migration.test_migration_with_tcp_localhost \
-    tests/avocado/migration.py:Migration.test_migration_with_unix \
-    tests/avocado/pc_cpu_hotplug_props.py:OmittedCPUProps.test_no_die_id \
-    tests/avocado/replay_kernel.py:ReplayKernelNormal.test_x86_64_pc \
-    tests/avocado/reverse_debugging.py:ReverseDebugging_X86_64.test_x86_64_pc \
-    tests/avocado/version.py:Version.test_qmp_human_info_version \
-    tests/avocado/virtio_version.py:VirtioVersionCheck.test_conventional_devs \
-    tests/avocado/virtio_version.py:VirtioVersionCheck.test_modern_only_devs \
-    tests/avocado/vnc.py:Vnc.test_change_password \
-    tests/avocado/vnc.py:Vnc.test_change_password_requires_a_password \
-    tests/avocado/vnc.py:Vnc.test_no_vnc \
-    tests/avocado/vnc.py:Vnc.test_no_vnc_change_password \
-    tests/avocado/x86_cpu_model_versions.py:CascadelakeArchCapabilities.test_4_0 \
-    tests/avocado/x86_cpu_model_versions.py:CascadelakeArchCapabilities.test_4_1 \
-    tests/avocado/x86_cpu_model_versions.py:CascadelakeArchCapabilities.test_set_4_0 \
-    tests/avocado/x86_cpu_model_versions.py:CascadelakeArchCapabilities.test_unset_4_1 \
-    tests/avocado/x86_cpu_model_versions.py:CascadelakeArchCapabilities.test_v1_4_0 \
-    tests/avocado/x86_cpu_model_versions.py:CascadelakeArchCapabilities.test_v1_set_4_0 \
-    tests/avocado/x86_cpu_model_versions.py:CascadelakeArchCapabilities.test_v2_4_0 \
-    tests/avocado/x86_cpu_model_versions.py:CascadelakeArchCapabilities.test_v2_unset_4_1 \
-    tests/avocado/x86_cpu_model_versions.py:X86CPUModelAliases.test_4_0_alias_compatibility \
-    tests/avocado/x86_cpu_model_versions.py:X86CPUModelAliases.test_4_1_alias \
-    tests/avocado/x86_cpu_model_versions.py:X86CPUModelAliases.test_none_alias
diff --git a/scripts/ci/org.centos/stream/README b/scripts/ci/org.centos/stream/README
deleted file mode 100644
index e3eadfe3ea..0000000000
--- a/scripts/ci/org.centos/stream/README
+++ /dev/null
@@ -1,17 +0,0 @@
-This directory contains scripts for generating a build of QEMU that
-closely matches the CentOS Stream[1] builds of the qemu-kvm package.
-
-To have the environment ready to configure, build QEMU and run tests,
-please start with a CentOS Stream machine and:
-
- * apply the generic "build-environment.yml" playbook located at
-   scripts/ci/setup
-
- * apply the "build-environment.yml" in the directory following the
-   CentOS Stream version (such as "8").
-
-This currently only covers CentOS Stream 8 environments and
-packages[2].
-
-[1] https://www.centos.org/centos-stream/
-[2] https://git.centos.org/rpms/qemu-kvm/commits/c8s-stream-rhel
-- 
2.39.2


