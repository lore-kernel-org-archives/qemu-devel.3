Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88EEDC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:52:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBe3-0007ld-Fn; Thu, 06 Jun 2024 07:51:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBe2-0007ky-3F
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:51:02 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdz-0000tX-VG
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:51:01 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-57a44c2ce80so901691a12.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674657; x=1718279457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YTTXqMf0b0oTPm9wdm0t2jDDbyUt2mB4jk7ZzBK8cIk=;
 b=Ot3bvCvepFGudaNZPcAKv3jn6zAai0lLOrVdvqIgEx62ragWbg2rt8tGnvC1pRKA5G
 H/rfDMcgdWVU2kPtgdjawdbShSY+3UCs8HlVbHnm3QYJqOdsVC89K/5+q0WKTiCLHZW6
 PZ8mMbIDKRvK09UhRI+x6OJjoZylO8BbKicb7vlgfccwZZO94Fhrz055p09SSgNNcU/X
 ps2gcxfCvYrUpsFlvOdSFkywuCJSSI8IMqOiC3ZEADmlJW9eHjfeY/YKmkTzq64V9cat
 BE3pDYWPE7Ao11cWSlNlKOtD9PLFKjqHZXiNBn6UNU1wKPBpCR04ksI8gM/yTsOMHJp3
 fH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674657; x=1718279457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YTTXqMf0b0oTPm9wdm0t2jDDbyUt2mB4jk7ZzBK8cIk=;
 b=Ts0qVvQHX2134tj89725CCg0tFmImvZn8g6sI1yGGWxVK64UF1TE32qekqJ+xiKjmm
 3PH+lLr87eoFYVYgooqE2tcXh1qQIJJzKR0bibKUdes7Kifrwahrz5K6A3w/5W3AIlrX
 MA79z21w4ZqpG0pIIrOMLUH3MZg5GBZ8prrvA+xbMVj+JpYXSsMc55Uqxkr9A+Yo472o
 Tt7YhPCRhibxsFswCBw+2eFcwU+hH024yZyaucBiyCRDTvsxsHB/AybXw5n1ZDCS5PCw
 PIXMvLmQ+T0n+N5+nmh/fA+4YYywHmPdw0hmhsWIgFVjBeyJDIVSAwDMQTc1HqLWon0a
 Tljw==
X-Gm-Message-State: AOJu0Yw8iaYSm3OsqJxl4/jj/b7/F/I1tMNyZX5fpyDFp0PxCrXvfRJ9
 rKXZkpSfRSeFCeNxves04majQpU1cakCktqlbUZd/71siAt7bpNSvZjqPpRwUqg=
X-Google-Smtp-Source: AGHT+IE8MuI+xGUxkzzhKCtE+JyBqc28zw7WUS8DlIFFQBq2qyr5YrD5YsfWDL8gr+QDfr/ixZkkVg==
X-Received: by 2002:a50:d701:0:b0:578:56e1:7ba3 with SMTP id
 4fb4d7f45d1cf-57a8bcb4ccamr3509216a12.38.1717674657569; 
 Thu, 06 Jun 2024 04:50:57 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae1412absm956602a12.57.2024.06.06.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 5D6435FA28;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 05/12] scripts/ci: remove CentOS bits from common
 build-environment
Date: Thu,  6 Jun 2024 12:50:40 +0100
Message-Id: <20240606115047.421045-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

Although I've just removed the CentOS specific build-environment its
probably a bit too confusing to have multiple distros mixed up in one
place. Prior to moving clean-up what will be just for ubuntu.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-6-alex.bennee@linaro.org>

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


