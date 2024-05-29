Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEEC3C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 16:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCLsK-0000lR-IY; Wed, 29 May 2024 12:10:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLsH-0000ef-Q5
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:01 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sCLrz-0003J9-BO
 for qemu-devel@nongnu.org; Wed, 29 May 2024 12:10:00 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5755fafa5a7so2871087a12.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 09:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716998982; x=1717603782; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7ocN3iu2P/KUFSX0mQ1QfO2Wf/aR5p0+MLZ25Wa96/8=;
 b=sfgjpDMTRA+bSjg9rrUd65snLEqPTm0BRMMimBGCuKrrOZI5kb2k0CasGZkztsrhrS
 Tw/Zbjm2CrBbrmiN8herBq5g0AdRx+XOFOn7n/9kp+027uUUX1MtRkdxMyIb2QKwxm+w
 pKfk1pxanIvOk3FBsS9oniKQqAaFJSYZOuUEvsm8FIEOvJhZMzhedJ2lJHeCbAQ/kj8m
 eHAMxPhhM2ws4y+TZRHlY1CubR9u4sCF7F9V+RVG/h3S9fnfvbtahnxk/oAz9cSbnSvt
 1JN7MYi1Jfwb3dOJ9vRWxThOjI69hnRFiMu7ho/AeRy9qt64HT4p3rGQirYjyBI/Cys0
 5uJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716998982; x=1717603782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7ocN3iu2P/KUFSX0mQ1QfO2Wf/aR5p0+MLZ25Wa96/8=;
 b=QP4R2QtR6dQWhC9nrcnMkubawLKH7DHBiAVjqqE5u9GE+ZfPik2m/LCGis9nLhozwW
 BZ6wcJV/RatWl0amOu9ic3LcINxp0wTJZEYoX43V0GHJitVk/eGZy/V5+1LEwXkyjDVQ
 0B2B3X4y9AagL1H1mR8gxYrSDmKuwd4PidQDzLEchyxAJ83BGx6I/S+qGiXS70FkWcUi
 /R3OD7QGoqdrLEZlUfd4pO6idi7VZjrbBb5XqsHetKMEfl0HqcGwQrKeloK33g+I+w8C
 BsnZQUCigRtBQDFlc/o11QuGdATTur+JOzPFVnHPi06Qlj/DvMdnH1jAeO8oqkPndoDd
 /UYA==
X-Gm-Message-State: AOJu0Yx0FNBQLQj991abfeX1x407qXDVaJSlhSlxuPAY63vDZz5nXPxF
 TUN5yloD/EXrYVg5ooqnRy3cTtO4Tf1jhrpddQaicU5I1JWWxeAhUMVuQ7VzAMU=
X-Google-Smtp-Source: AGHT+IHMTMIsr24JhV7rfM1hBb72hXo4/F3ouSvTPHBjnmmBn1dM1xtTT4NVHnltg/iLuIKJeGJmXg==
X-Received: by 2002:a17:906:130d:b0:a63:47e9:64f1 with SMTP id
 a640c23a62f3a-a6347e96559mr334365166b.11.1716998981765; 
 Wed, 29 May 2024 09:09:41 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c817981sm734495666b.31.2024.05.29.09.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 May 2024 09:09:38 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7F4CA5F8E9;
 Wed, 29 May 2024 17:09:35 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 qemu-arm@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Joel Stanley <joel@jms.id.au>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH 05/10] scripts/ci: remove CentOS bits from common
 build-environment
Date: Wed, 29 May 2024 17:09:29 +0100
Message-Id: <20240529160934.982373-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529160934.982373-1-alex.bennee@linaro.org>
References: <20240529160934.982373-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Although I've just removed the CentOS specific build-environment its
probably a bit too confusing to have multiple distros mixed up in one
place. Prior to moving clean-up what will be just for ubuntu.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 scripts/ci/setup/build-environment.yml | 98 --------------------------
 1 file changed, 98 deletions(-)

diff --git a/scripts/ci/setup/build-environment.yml b/scripts/ci/setup/build-environment.yml
index de0d866a1e..e82097b465 100644
--- a/scripts/ci/setup/build-environment.yml
+++ b/scripts/ci/setup/build-environment.yml
@@ -184,101 +184,3 @@
         - ansible_facts['distribution_version'] == '22.04'
         - ansible_facts['architecture'] == 'aarch64'
 
-    - name: Enable EPEL repo on EL8
-      dnf:
-        name:
-          - epel-release
-        state: present
-      when:
-        - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_major_version'] == '8'
-
-    - name: Enable PowerTools repo on CentOS 8
-      ini_file:
-        path: /etc/yum.repos.d/CentOS-Stream-PowerTools.repo
-        section: powertools
-        option: enabled
-        value: "1"
-      when:
-        - ansible_facts['distribution_file_variety'] == 'CentOS'
-        - ansible_facts['distribution_major_version'] == '8'
-
-    - name: Install basic packages to build QEMU on EL8
-      dnf:
-        # This list of packages start with tests/docker/dockerfiles/centos8.docker
-        # but only include files that are common to all distro variants and present
-        # in the standard repos (no add-ons)
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
-          - systemd-devel
-          - systemtap-sdt-devel
-          - tar
-          - zlib-devel
-        state: present
-      when:
-        - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
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
-
-    - name: Check whether the Python runtime version is managed by alternatives
-      stat:
-        path: /etc/alternatives/python3
-      register: python3
-
-    - name: Set default Python runtime to 3.8 on EL8
-      command: alternatives --set python3 /usr/bin/python3.8
-      when:
-        - ansible_facts['distribution_file_variety'] in ['RedHat', 'CentOS']
-        - ansible_facts['distribution_version'] == '8'
-        - python3.stat.islnk and python3.stat.lnk_target != '/usr/bin/python3.8'
-- 
2.39.2


