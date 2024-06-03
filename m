Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32265C41513
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2024 17:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEBsZ-00077a-Fb; Mon, 03 Jun 2024 13:53:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsL-000705-4M
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:41 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sEBsG-00009b-JC
 for qemu-devel@nongnu.org; Mon, 03 Jun 2024 13:53:40 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4210aa00c94so41514825e9.1
 for <qemu-devel@nongnu.org>; Mon, 03 Jun 2024 10:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717437214; x=1718042014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z5yTiW/q6L2Y5+9xKegtFmhr3gYrS8eAtYlk7YpU4Hg=;
 b=dwOy2DhGhm358ZPC3ixduSxJtJwpPDfVyG5gkrSmy4V5HfJENTKQBtsrnPW/kW0ebH
 FpSuUmI6eooMTSq7y7NSr8amdQ3wDxjx7FdZf09rQH8ULF0u3VoPtVN4IKPgQBDuzfv0
 oJxqlwRRwuH4KXb4z6yu+ou1EIOtgrA3oIdhNHNZP9owuJEVHmoFrpwhfG2NIHp9E7uk
 po2198Qi03WkEbUsgH9ER7ssRfcvClJrsuXuH8wbhTFFfNuiS5orQ3C1ngL9+LWqTLSJ
 A3ISzXCXQHDomPyvIN3es7GE5fMsOlZcGBegut/QiyVtSY07hGfdOMmui+VL2Ln7bUQM
 nDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717437214; x=1718042014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z5yTiW/q6L2Y5+9xKegtFmhr3gYrS8eAtYlk7YpU4Hg=;
 b=Gx20mj/1qz/MgntPMtlCi2Mv0ChCN96L9l8XHl/PMUWHffDJ8ZyvEP2K++JKLuUZp/
 Ss8c+bV7O3gwoEPDIs9g+oqjQE8fEytNXJbp1WSaVl6XN9SHLN2tTOwWBASMW9enyjEM
 UI12bhT85Ia4cn5b4102CIDXlKKVqe9+fwkyRlsrphbU6FIUa2oriZuMP9tRDWGPp64z
 jmEBaEsssDSdTDlu5Qgx2G5hzPvBE1gFBZhhGv6VQ/AgS/7JBdpckwUjqTRoOT0Xzvar
 2UODabYAJVB9vhI+hRo50G+n/Vqz5Y/e7n7d/NgPvAEGcJnjdupeKAGu9HdzJObJ/u/c
 85DQ==
X-Gm-Message-State: AOJu0YwVYVbBuZSmKDMIC/YGEek5G5F+3Tl5V455A8IiqCiHvBw0yVfA
 hUhQxw8yQiZhtcVUbBauyhEkGwg3Sl69qiZSGc7ARAJJFu56EmhWLOnOxfEQE6c=
X-Google-Smtp-Source: AGHT+IFYPjC9GNDwaenBfWpzyHfu6l1S2cX3DZjw9jgZLDYESoxjMB/FEmKa7Uh6CAWhJ1+74oy5KQ==
X-Received: by 2002:a05:600c:4705:b0:421:ad:f104 with SMTP id
 5b1f17b1804b1-4212e0502dcmr93390755e9.10.1717437214623; 
 Mon, 03 Jun 2024 10:53:34 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212f9b9ef1sm114083595e9.9.2024.06.03.10.53.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Jun 2024 10:53:31 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F2F595F9F4;
 Mon,  3 Jun 2024 18:53:28 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-s390x@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Subject: [PATCH v3 05/12] scripts/ci: remove CentOS bits from common
 build-environment
Date: Mon,  3 Jun 2024 18:53:21 +0100
Message-Id: <20240603175328.3823123-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240603175328.3823123-1-alex.bennee@linaro.org>
References: <20240603175328.3823123-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32f.google.com
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
Message-Id: <20240529160934.982373-6-alex.bennee@linaro.org>
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


