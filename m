Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60FA5C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgry8-0002du-Fm; Mon, 06 Jul 2026 18:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxm-00021Z-29
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgrxj-00071F-P3
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 18:38:53 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KEAkO1504926
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 22:38:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4X3GdDl1+s/
 Ezjkj+20gIVDAjNYTAfeno9CnTek5enY=; b=e4bMJjKrsLyiDdqZOPNKIWA27mN
 /BpriL5EsTAfQLPFLYL0z4ggmc1k8/nAyPn8SEv3THlH7PmHU0ThvBh9pCBycb59
 QFM+pG/nRCCogYmCwyjh1yPMpnMIilmGMvzw170xQhSaXvZKCugzB1Qilq6fXznd
 z0Lp9VCEZhmSmx+wzV4O1kqW73Avcxxt7a/bVUHC8gkspgz7itHqAojIsi6j1ww0
 bq8oShnV6vgPZl9WZ6YWf9YVV3u4a3KC028MIsX/VezgIpGwtwe+eC0wVWl9WtvI
 VrSg1NsRnVGTt3RvdLKK7Dua9M+Ix+cZqgQIk2rT53+gL4bK98RIjyVT50w==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98k35t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 22:38:49 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c85a298cd62so3025496a12.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 15:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783377529; x=1783982329; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4X3GdDl1+s/Ezjkj+20gIVDAjNYTAfeno9CnTek5enY=;
 b=RBmcX6MdObDLUCKE1So15txxjXvjxVuRb9c0LYCEkTrI3tCsV7Ss49Z1Z9Iix/bm9u
 TMlVDPxBNX0lRjDQdNdHKvKzyaKDXhP3bQLiGSyTb7uKfc8Ol/sIBuqy9JkuQiCV4LRX
 tY0at4B6LfGgsm/r0SaymaKcqpucnLwHdsqwW4yx3R7b0wJKOYCxit+R+7x35c3Frpvl
 k64Lv67/lfl7cgWok4QASIWIedNRhs6aDd67iWUCryDm9nv8O/EHrXwcMkaSjvzM4vFl
 cf9XrD5+WbdrOjyKfc7Kaccpsq3B6wnLG2h11QrwObpqGJavuMU3SXQy6JhUQ8eKywEp
 63TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783377529; x=1783982329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4X3GdDl1+s/Ezjkj+20gIVDAjNYTAfeno9CnTek5enY=;
 b=iBgNxkC+EBNBqWLowpwMkFy+gbvpC6o7kQ61lRooaUJ24lcWjfYPbxjJMehwbrJwv9
 kgHeuzbDUXVAIl0e1PG2MceuLuV/zyjftCLspPLhr9jI30fFoG/g0G7hyWVrbYGuGqmM
 H+8pJepaqnrulG0g/dA6CojibnFzI70DOkbggKEXDbEcKJ4ST3VBmnvV71pje9Jsvsj6
 e5tEEsjouCAYeVgCLZ8IK06BcKMAhdMO+fWY2lCHNStUHF+I7oibyai3eDdwqfNsQ38e
 EIBB6c9rBnUHEh0ssdQcnhTzy0OIHSdjdAJ9F+hjPVdT4K9kNkK9ldFwNNTdsc90MeCs
 GJeA==
X-Gm-Message-State: AOJu0Yw59pYEUp8ydo4PezyVgFfzRCxtVcyxfWSyT0Y03Lv2axSaeDy7
 p61y7WdpthveTZuaIXJaqcNWjFuU2WbiTL7ecOU16qyKb9nolepYhr09blelLyQvNKuAMN5SmNf
 ZS7rzFnHLgn28JFdmjpZZvZaQLrLS1QxmToD6BJFrG0quO0L+WN7Ns/tCHvnSBLS6mw==
X-Gm-Gg: AfdE7clRFib+xe0pL2isnvnRMbzR3zNueiU/JsHqnEplJ57q3NW+nklePfmPnjb/esq
 3FuPafBLfHB7h4IiI40K/PIzVZuVN7vLuTyDdUh8bCQTYU8Gfx2IZLxJh32tmELxWyflLQqij0x
 TKUqA9q+/tHpGnTRFMQsm1UnapC20iBhcVfpwmaiK4/1RRt2dDVveFNCbmOxwovEXNCStpw+O3w
 XqH+7o9+m5QQdfR07l81/2wTRTH48fSgVgYkaYoeOJLxLXSttllWxG9RQGnv17buYH8/33davu7
 tYf8i2eKX4uaOGT1MKBxPySzW2CYOVB1V17vcXu7PJY7Fj2ZWGvtf/YT3fpDxeNHWh+JuOMAXjD
 HT7/yB/ecYjUbty7b72KhbaB0Mm/CPZa8ZO2rp440ns2cfPJXY6gip0KIzY+3cJa/b3CVNN6yV+
 8nVOK9sg==
X-Received: by 2002:a05:6a20:2d12:b0:3bf:baed:c797 with SMTP id
 adf61e73a8af0-3c08ef1dd29mr2744785637.49.1783377529195; 
 Mon, 06 Jul 2026 15:38:49 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d12:b0:3bf:baed:c797 with SMTP id
 adf61e73a8af0-3c08ef1dd29mr2744753637.49.1783377528753; 
 Mon, 06 Jul 2026 15:38:48 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm1399484c88.14.2026.07.06.15.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 15:38:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 62/91]
 tests/docker/dockerfiles/debian-all-test-cross.docker: add or1k toolchain
Date: Mon,  6 Jul 2026 15:33:14 -0700
Message-ID: <20260706223343.988769-63-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4c2e79 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=TNSyY6zQAAAA:8
 a=3B-k7g5EAAAA:20 a=EUspDBNiAAAA:8 a=i16mCVGQ5myNtHPAFsoA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=01gnQneks5i7xkQX6LlV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX4mdXwZY8EkYi
 GSkdVG0JjYCo0lHX/hLYYUOvMTFo8lcWpf05OdII1cCAk1prAgmHsabVHIm6XCdqF9pQp7RkdYa
 gU/EWyosZ2DwuNCyf6NochBeYoi9XwpD43gT+YD475X/DetEeMW8gZFjl2BX4B6MC4JQ9MxLQE2
 Z9q+jKjawzXARUlRNT+RRTEO533a1+TGirnmVQ/ihLhNCZvagO7wINvl8lUiULahOmMJM1o2FAq
 yUnFTxryCO+O00j/48SMoyaR+bB69/lvuW+Xq611ZbtvKx94XFgvzRo6wP17zMwflKFDwTLEwWA
 nCFDf1Mz7R+8t4byCTZM8RbCQsBawEQ/wrJzAac11zhbDjOYmJNKPASZemI7rfgQ1Y5oigClNJ8
 nJIrf/Dv6I16zu1Yaanpo7uwJDmKA0DloLgD4uSjYCJeUAHA6FuyYzUALw4r/DHsAhf+qfZE0ya
 h+0DKspRkmcLintG31w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIyOCBTYWx0ZWRfX37JrpvBqDRYG
 blJvQig2rGs02QD9tp1Ux7KdXlMBi6JCbFGWJxMNIWacX19gkhtU49E+ufv3SPIFrlxE6iC8/di
 rXc+0W3V7WfDAM+eA8+O4mI3QQY4LFM=
X-Proofpoint-GUID: kz35EK5E8l2_bUtymG8V2kAFu8lZjoc3
X-Proofpoint-ORIG-GUID: kz35EK5E8l2_bUtymG8V2kAFu8lZjoc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060228
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

To avoid escape hell in tests/lcitool/refresh, just use a raw
multiline string instead of a list of strings.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .../dockerfiles/debian-all-test-cross.docker  |  16 ++-
 tests/lcitool/refresh                         | 107 ++++++++++--------
 2 files changed, 75 insertions(+), 48 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index a10ffc73500..98ea1e0d679 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -54,13 +54,26 @@ ENV LANG="en_US.UTF-8"
 ENV MAKE="/usr/bin/make"
 ENV NINJA="/usr/bin/ninja"
 ENV PYTHON="/usr/bin/python3"
+
 # extras for cross and alternate toolchains
 RUN DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   clang\
   dpkg-dev\
   gdb-multiarch\
-  libclang-rt-dev
+  libclang-rt-dev\
+  wget\
+  rsync
+
+# https://openrisc.io/2025/04/20/toolchainrootfsbins
+RUN if dpkg-architecture -e amd64; then \
+cd /tmp && \
+  wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
+  tar --no-same-owner -xf *.tar.xz && \
+  rsync -a or1k-none-linux-musl/ /usr/ && \
+  rm -rf /tmp/*; \
+fi
+
 ENV AVAILABLE_COMPILERS="\
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
@@ -96,6 +109,7 @@ DEBIAN_FRONTEND=noninteractive eatmydata \
 apt install -y --no-install-recommends \
 ${AVAILABLE_COMPILERS} && \
 dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+
 ENV QEMU_CONFIGURE_OPTS=--disable-docs
 ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index e0da0d2de1d..ec3ae672c11 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -161,52 +161,65 @@ ubuntu2404_rust_extras = [
     'RUN cargo install --locked bindgen-cli\n',
 ]
 
-debian_all_test_cross_compilers = [
-    "# extras for cross and alternate toolchains\n",
-    "RUN DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
-    "  apt install -y --no-install-recommends \\\n",
-    "  clang\\\n",
-    "  dpkg-dev\\\n",
-    "  gdb-multiarch\\\n",
-    "  libclang-rt-dev\n",
-    "ENV AVAILABLE_COMPILERS=\"\\\n",
-    "  gcc-aarch64-linux-gnu \\\n",
-    "  libc6-dev-arm64-cross \\\n",
-    "  gcc-arm-linux-gnueabihf \\\n",
-    "  libc6-dev-armhf-cross \\\n",
-    "  gcc-alpha-linux-gnu \\\n"
-    "  libc6.1-dev-alpha-cross \\\n"
-    "  gcc-mips-linux-gnu \\\n",
-    "  libc6-dev-mips-cross \\\n",
-    "  gcc-mips64-linux-gnuabi64 \\\n",
-    "  libc6-dev-mips64-cross \\\n",
-    "  gcc-mips64el-linux-gnuabi64 \\\n",
-    "  libc6-dev-mips64el-cross \\\n",
-    "  gcc-mipsel-linux-gnu \\\n",
-    "  libc6-dev-mipsel-cross \\\n",
-    "  gcc-powerpc64le-linux-gnu \\\n",
-    "  libc6-dev-ppc64el-cross \\\n",
-    "  gcc-riscv64-linux-gnu \\\n",
-    "  libc6-dev-riscv64-cross \\\n",
-    "  gcc-s390x-linux-gnu \\\n",
-    "  libc6-dev-s390x-cross\\\n",
-    "  gcc-sh4-linux-gnu \\\n",
-    "  libc6-dev-sh4-cross \\\n",
-    "  \"\n",
-    "RUN if dpkg-architecture -e amd64; then \\\n",
-    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross\"; \\\n",
-    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross\"; \\\n",
-    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross\"; \\\n",
-    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross\"; \\\n",
-    "  export AVAILABLE_COMPILERS=\"${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross\"; \\\n",
-    "fi && \\\n",
-    "DEBIAN_FRONTEND=noninteractive eatmydata \\\n",
-    "apt install -y --no-install-recommends \\\n",
-    "${AVAILABLE_COMPILERS} && \\\n",
-    "dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt\n",
-    "ENV QEMU_CONFIGURE_OPTS=--disable-docs\n",
-    "ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user\n",
-]
+debian_all_test_cross_compilers = r"""
+# extras for cross and alternate toolchains
+RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends \
+  clang\
+  dpkg-dev\
+  gdb-multiarch\
+  libclang-rt-dev\
+  wget\
+  rsync
+
+# https://openrisc.io/2025/04/20/toolchainrootfsbins
+RUN if dpkg-architecture -e amd64; then \
+cd /tmp && \
+  wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
+  tar --no-same-owner -xf *.tar.xz && \
+  rsync -a or1k-none-linux-musl/ /usr/ && \
+  rm -rf /tmp/*; \
+fi
+
+ENV AVAILABLE_COMPILERS="\
+  gcc-aarch64-linux-gnu \
+  libc6-dev-arm64-cross \
+  gcc-arm-linux-gnueabihf \
+  libc6-dev-armhf-cross \
+  gcc-alpha-linux-gnu \
+  libc6.1-dev-alpha-cross \
+  gcc-mips-linux-gnu \
+  libc6-dev-mips-cross \
+  gcc-mips64-linux-gnuabi64 \
+  libc6-dev-mips64-cross \
+  gcc-mips64el-linux-gnuabi64 \
+  libc6-dev-mips64el-cross \
+  gcc-mipsel-linux-gnu \
+  libc6-dev-mipsel-cross \
+  gcc-powerpc64le-linux-gnu \
+  libc6-dev-ppc64el-cross \
+  gcc-riscv64-linux-gnu \
+  libc6-dev-riscv64-cross \
+  gcc-s390x-linux-gnu \
+  libc6-dev-s390x-cross\
+  gcc-sh4-linux-gnu \
+  libc6-dev-sh4-cross \
+  "
+RUN if dpkg-architecture -e amd64; then \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
+  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
+fi && \
+DEBIAN_FRONTEND=noninteractive eatmydata \
+apt install -y --no-install-recommends \
+${AVAILABLE_COMPILERS} && \
+dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+
+ENV QEMU_CONFIGURE_OPTS=--disable-docs
+ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
+"""
 
 def cross_build(prefix, targets):
     conf = "ENV QEMU_CONFIGURE_OPTS=--cross-prefix=%s\n" % (prefix)
@@ -293,7 +306,7 @@ try:
     generate_dockerfile("debian-all-test-cross", "debian-13",
                         project="qemu-minimal",
                         enable_rust=False,
-                        trailer="".join(debian_all_test_cross_compilers))
+                        trailer=debian_all_test_cross_compilers)
 
     #
     # GitLab packages lists
-- 
2.47.3


