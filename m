Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F90ECD6E6E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 21:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVFz8-0006tI-9F; Thu, 04 Jun 2026 17:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFz6-0006sH-4h
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wVFyy-0006ib-Ri
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 17:52:11 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654HQ7WE011974
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 21:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NyZ72wZQQeF
 LeyDZDhgELfGJ6HODP4IvSqNgwtAKJxs=; b=BQ/gO3jL2mo1wqoZEYt3z6PIXMF
 GFhVsaLaiHPua+toaHOPM3L3oQrAfzphAyHNrP6gWPbYU8wmbN75jaZW6eNsCfH9
 eIF65bKZN3Es27dsyYTpH/lFagokl92tS/we++OfknAVCxwh5/klEr5dIEpaBwgZ
 7BnwsEt6hPtshRlgZ6ABELsaIFj/+z0h/x/OSh7YW+g/BTjM7lqT3smj4XMPCxVl
 XCGL624JeDIwn2Yx8un4EQduR/YSKhHV377WNtrocoD+owP7GTJsxTWmzooU/cul
 ZgD9G7+mle+ggaaXRpYqQxjKCjdBFIt7xPSAUqJo/jtpQp76m93f+AcaLFQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek8dc2spp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 21:52:05 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304f1820babso1550274eec.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 14:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780609925; x=1781214725; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyZ72wZQQeFLeyDZDhgELfGJ6HODP4IvSqNgwtAKJxs=;
 b=a709XZPd8mpyz5rywYhFQ8M3qh1SRWK5lbZs+++8iHlhqZ1AgqR3Q7HT6FiTgFBbJq
 SvAT+sAU7+mKHAZQJdTzDgDS/pvR93CuLuu1FHM9QuaqheB2q1CvRtX9VEXKP/DpTvwh
 crPIaXkc25PDOXpoTfzXC3xbM68poIePKEOmUhHg5R+RUmxPjJxSjy5fT234Sf+zhAdF
 9bAPNRrDiIUJIuQty01ZzrsIi1pQU86UujycOW44I+SCEPVw2sjDNu9+pM33QQBn7g+K
 yGDLyesTMX2kH4kYRtFIAtRhtBMnDj5XAga3vptQTfcvtc9JjMoHNOcgAK2IVrhkaf/3
 I28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780609925; x=1781214725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NyZ72wZQQeFLeyDZDhgELfGJ6HODP4IvSqNgwtAKJxs=;
 b=DiURI/kKNDlEiN4z/Y/T5VHbLzIxIxZWpV71MI4sUgweNfpzFGSv/inCg4K4CJng/Y
 GlddC9PsOWGRZY/NJR9OWRrIjymU/jUzOkIk6t9iPT90lR51LOb7XqDs9AI8Ow+NZc0Z
 BiMUag3Dvw2W6hgkU03yrtzMKg6qrlpy7BmD0wAssLXJ4PPUUUa6u0qKx2WU1dvA7Nl/
 kM006aPnXv58C8ZwnBd9vYNpi41NL2wU+6MA1z3lU7KkP25AtkfKhkD4deecrHiAXKZ2
 H26JDQiWC3/YbPm66bjQwvcVlsp4YHfFHjScw9ZRmtZKdhSyqVPA5st3R9hZOF5ikrXg
 vBFw==
X-Gm-Message-State: AOJu0YwQQSsjR+nOlIffCNqgXxmbU0SaSWDoV+waBDSCxyb1hPqvCOGH
 6ojTexAmAftw942eIipsYBYiCMySZomWNghMIulTvsslq44uMr7/4W+DCwh7vVA342gZFN+9m5T
 3001inH0SicnFwe0syq6+W4GY9McZObrGIVM85Nmi7lkTOnEQH7IeMNsfrzBtkYL9kHNE
X-Gm-Gg: Acq92OHmKyh+WaVhgQiLDQCvytDZDaQYrL02cC0xDrdaMYiv0ag+S9cYcbSI0k2EMMZ
 /eHKZif6t0ukHjFCb3X8xzdjkYToIm164TDtruQdnn0SkT0M4Adj40rulsxTS3qZb3wNr6zpb6W
 G/GxtQ4XjKl0eMTdwwXpbr8CBiFYpZGlLL3cK4378I9oMSQI9LfO6vSBZ1i5Z/CZV+6f2MaEYMA
 mDHzrj3tp94qKjM/op2D8BTBcm9X144BUq0jx76SlgLSRl+mImuxM7yfvwgQj1svPc1DuW8O47c
 XIV4i08mBnOUmiT/ZTHq+saGnaDs23X6Dfdwb2loXDFoaf3XifN7PVMWlnZnf9HerwB1e1QA4RB
 IzyPVClfxfHvVs2XPqmAN1gujXMn0uzqtbJoC+qFFAqP3WtWYNach+NftrVLelfgP2Bk2QJGM1P
 jvXd2FkPvuJPzHvkdb
X-Received: by 2002:a05:7300:2311:b0:2f2:6dde:df66 with SMTP id
 5a478bee46e88-3077b5a13cemr251096eec.22.1780609924933; 
 Thu, 04 Jun 2026 14:52:04 -0700 (PDT)
X-Received: by 2002:a05:7300:2311:b0:2f2:6dde:df66 with SMTP id
 5a478bee46e88-3077b5a13cemr251075eec.22.1780609924323; 
 Thu, 04 Jun 2026 14:52:04 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3074df64eb9sm5270115eec.25.2026.06.04.14.52.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 14:52:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/5] tests: add ubuntu 2404
Date: Thu,  4 Jun 2026 14:51:44 -0700
Message-ID: <20260604215148.3769627-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260604215148.3769627-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: rTExYj5wS_LXVF1cw_cAZbCmIu9dCRiJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIxNCBTYWx0ZWRfX7SmYY4NfP8Sf
 v1s1wFX9ueN1HSYwRYpV6vManEg79dLceqlgixBX30ciLyxdkJ/Bcv783qFZ/M22nOtQU/mJKX0
 9MglxV5yBkaStezR8w7U+l9KMQqdE80EZfE/Ycn97cc4NM01SeurH3ihzAlmJbOGr2Wi+rnHCCm
 PD6I3wgdmZtc5J02dYeV4wPmKZiUSC0Qxe9ZPMrWZ2EKwH2tmRW7IOUPK/vwwXsn4MnT5vzJevO
 Be2CVlqag4GnN5hYx3BuKemq/qeISav4k2fDn0QavwbJfWUuHCOUjYi9DC9Ha9wgrWMqkAwtSob
 JtoFMH/Fg8g3+u9bb7FWT70raCpR9zt27tr/2yvDzSk8gfbxov/66rSaEjk6RpupT+UNxeWPKET
 UhR8DyhzaHPx+8EKwJ0H43K5rNDEnUTWllWv03noIJLruIfR/oXdVNY6VIGqF4qt3tcwdJX6W8z
 DrEY6BUWNUCXxCOfmWg==
X-Authority-Analysis: v=2.4 cv=eJwjSnp1 c=1 sm=1 tr=0 ts=6a21f385 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=p0WdMEafAAAA:8
 a=danhDmx_AAAA:8 a=EUspDBNiAAAA:8 a=nYRz0HzsKyOsPlwwv1sA:9
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: rTExYj5wS_LXVF1cw_cAZbCmIu9dCRiJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040214
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/ubuntu2404.docker | 172 +++++++++++++++++++++
 tests/lcitool/refresh                      |   6 +-
 2 files changed, 176 insertions(+), 2 deletions(-)
 create mode 100644 tests/docker/dockerfiles/ubuntu2404.docker

diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
new file mode 100644
index 00000000000..26bc2dd94f4
--- /dev/null
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -0,0 +1,172 @@
+# THIS FILE WAS AUTO-GENERATED
+#
+#  $ lcitool dockerfile --layers all ubuntu-2404 qemu
+#
+# https://gitlab.com/libvirt/libvirt-ci
+
+FROM docker.io/library/ubuntu:24.04
+
+RUN export DEBIAN_FRONTEND=noninteractive && \
+    apt-get update && \
+    apt-get install -y eatmydata && \
+    eatmydata apt-get dist-upgrade -y && \
+    eatmydata apt-get install --no-install-recommends -y \
+                      bash \
+                      bc \
+                      bindgen \
+                      bison \
+                      bsdextrautils \
+                      bzip2 \
+                      ca-certificates \
+                      ccache \
+                      clang \
+                      coreutils \
+                      dbus \
+                      debianutils \
+                      diffutils \
+                      exuberant-ctags \
+                      findutils \
+                      flex \
+                      gcc \
+                      gcovr \
+                      gettext \
+                      git \
+                      hostname \
+                      libaio-dev \
+                      libasan8 \
+                      libasound2-dev \
+                      libattr1-dev \
+                      libbpf-dev \
+                      libbrlapi-dev \
+                      libbz2-dev \
+                      libc6-dev \
+                      libcacard-dev \
+                      libcap-ng-dev \
+                      libcapstone-dev \
+                      libcbor-dev \
+                      libclang-rt-dev \
+                      libcmocka-dev \
+                      libcurl4-gnutls-dev \
+                      libdaxctl-dev \
+                      libdrm-dev \
+                      libepoxy-dev \
+                      libfdt-dev \
+                      libffi-dev \
+                      libfuse3-dev \
+                      libgbm-dev \
+                      libgcrypt20-dev \
+                      libglib2.0-dev \
+                      libgnutls28-dev \
+                      libgtk-3-dev \
+                      libgtk-vnc-2.0-dev \
+                      libibverbs-dev \
+                      libiscsi-dev \
+                      libjemalloc-dev \
+                      libjpeg-turbo8-dev \
+                      libjson-c-dev \
+                      liblttng-ust-dev \
+                      liblzo2-dev \
+                      libncursesw5-dev \
+                      libnfs-dev \
+                      libnuma-dev \
+                      libpam0g-dev \
+                      libpcre2-dev \
+                      libpipewire-0.3-dev \
+                      libpixman-1-dev \
+                      libpmem-dev \
+                      libpng-dev \
+                      libpulse-dev \
+                      librbd-dev \
+                      librdmacm-dev \
+                      libsasl2-dev \
+                      libsdl2-dev \
+                      libsdl2-image-dev \
+                      libseccomp-dev \
+                      libselinux1-dev \
+                      libslirp-dev \
+                      libsnappy-dev \
+                      libsndio-dev \
+                      libspice-protocol-dev \
+                      libspice-server-dev \
+                      libssh-dev \
+                      libstd-rust-dev \
+                      libsystemd-dev \
+                      libtasn1-6-dev \
+                      libubsan1 \
+                      libudev-dev \
+                      liburing-dev \
+                      libusb-1.0-0-dev \
+                      libusbredirhost-dev \
+                      libvdeplug-dev \
+                      libvirglrenderer-dev \
+                      libvte-2.91-dev \
+                      libxdp-dev \
+                      libxen-dev \
+                      libzstd-dev \
+                      llvm \
+                      locales \
+                      make \
+                      mtools \
+                      multipath-tools \
+                      nettle-dev \
+                      ninja-build \
+                      openssh-client \
+                      pkgconf \
+                      python3 \
+                      python3-numpy \
+                      python3-opencv \
+                      python3-pillow \
+                      python3-pip \
+                      python3-setuptools \
+                      python3-sphinx \
+                      python3-sphinx-rtd-theme \
+                      python3-tomli \
+                      python3-venv \
+                      python3-wheel \
+                      python3-yaml \
+                      rpm2cpio \
+                      rustc-1.83 \
+                      sed \
+                      socat \
+                      sparse \
+                      swtpm \
+                      systemtap-sdt-dev \
+                      tar \
+                      tesseract-ocr \
+                      tesseract-ocr-eng \
+                      vulkan-tools \
+                      xorriso \
+                      zlib1g-dev \
+                      zstd && \
+    eatmydata apt-get autoremove -y && \
+    eatmydata apt-get autoclean -y && \
+    sed -Ei 's,^# (en_US\.UTF-8 .*)$,\1,' /etc/locale.gen && \
+    dpkg-reconfigure locales && \
+    rm -f /usr/lib*/python3*/EXTERNALLY-MANAGED && \
+    dpkg-query --showformat '${Package}_${Version}_${Architecture}\n' --show > /packages.txt && \
+    mkdir -p /usr/libexec/ccache-wrappers && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/clang && \
+    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc
+
+RUN /usr/bin/pip3 install meson==1.8.1
+
+ENV CCACHE_WRAPPERSDIR="/usr/libexec/ccache-wrappers"
+ENV LANG="en_US.UTF-8"
+ENV MAKE="/usr/bin/make"
+ENV NINJA="/usr/bin/ninja"
+ENV PYTHON="/usr/bin/python3"
+ENV RUSTC=/usr/bin/rustc-1.83
+ENV RUSTDOC=/usr/bin/rustdoc-1.83
+ENV CARGO_HOME=/usr/local/cargo
+ENV PATH=$CARGO_HOME/bin:$PATH
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends cargo
+RUN cargo install --locked bindgen-cli
+# As a final step configure the user (if env is defined)
+ARG USER
+ARG UID
+RUN if [ "${USER}" ]; then \
+  id ${USER} 2>/dev/null || useradd -u ${UID} -U ${USER}; fi
+
+ENV ENABLE_RUST=1
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index fa545cf1f4f..26abc695735 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -151,7 +151,7 @@ fedora_rustup_nightly_extras = [
     'RUN $CARGO --list\n',
 ]
 
-ubuntu2204_rust_extras = [
+ubuntu2404_rust_extras = [
     "ENV RUSTC=/usr/bin/rustc-1.83\n",
     "ENV RUSTDOC=/usr/bin/rustdoc-1.83\n",
     "ENV CARGO_HOME=/usr/local/cargo\n",
@@ -229,8 +229,10 @@ try:
                         trailer="".join(debian13_extras))
     generate_dockerfile("fedora", "fedora-43")
     generate_dockerfile("opensuse-leap", "opensuse-leap-16")
+    generate_dockerfile("ubuntu2404", "ubuntu-2404",
+                        trailer="".join(ubuntu2404_rust_extras))
     generate_dockerfile("ubuntu2204", "ubuntu-2204",
-                        trailer="".join(ubuntu2204_rust_extras),
+                        trailer="".join(ubuntu2404_rust_extras),
                         # https://bugs.launchpad.net/ubuntu/+source/rustc-1.83/+bug/2120318
                         enable_rust=False)
 
-- 
2.43.0


