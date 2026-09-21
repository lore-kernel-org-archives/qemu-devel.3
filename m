Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB58C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 23:16:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8nEI-0008Fp-5N; Mon, 21 Sep 2026 19:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nED-0008EV-E5
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x8nEB-0000FM-AK
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 19:15:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LKfuxf2412099
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=5cnUkUtCziC
 P7pTGs/uiuJdM9yUzrGYA5WJXOyRehuQ=; b=mVezqiObsCv04katzyAo96PSajU
 +/asfaFc/UKoc2bqdiTgE9zR7f+x4Iz6O9t0Y0zp5jowaRosDsjPGSe0M6I2K0CR
 WwnidrHKu0EonuhrpC/prXk1Le7253Yewe5uyv0WXcyVIRyQjvnhhqj5xEBwjk3I
 OKQfVjO6KiQQMT6SEN2Urr6YP+li0mrOK8yNPYyC6veQTP0l11F9CEucBWYyZvRC
 uZ3fupwPxBNNM7XX/ZhvJKKk7Om6UMpKtRMqLvYXIHelIKh1z7VSHx/80+Q/fc9r
 +VxA5aB6v5igTl8NTHpPy7d62hVUy03xey7UC690o9TCal579MbpZFWF+qw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu3csjtp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 23:15:13 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-39e25a5f6e8so6425026a91.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 16:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790032513; x=1790637313; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5cnUkUtCziCP7pTGs/uiuJdM9yUzrGYA5WJXOyRehuQ=;
 b=ddfN7GMZdCkBTf7x0VtlRC8hF53JuLPeLVEVrc5IF4o2zDFLocqX7tPMjfLmeeR9Jt
 UbZZdK/0ZRoPPK1l0XUlt8hgW+VwVpCOJg7zJUBQ8mTiiQZiYsHyn2HdW0xDKMGSEi/6
 1psD40lE1vVN71EJTRZfx56XI4OhcRQDp0dI2vB3RgBohX7DBW0meQgTVilaW8wQQ3gQ
 F2sKtu0I2t5bJd2h/f9tn4pE2UQ43dvHLT371rGoQWdxMo4CmAq752ql7HcU28HhZTSe
 JYxSnUwtQFJ62d9QSP5jQcOjtuU+vCgq0h7LLcSzZcj+5FielWkPaKMi6GF44rCz7XwR
 NG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790032513; x=1790637313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5cnUkUtCziCP7pTGs/uiuJdM9yUzrGYA5WJXOyRehuQ=;
 b=Ghaa/3LWjEeLbCoZHp2zIeuYYNEsdTBoFwpsgDooQ2C3ILXni2w3rcoTEgvpIR7YIl
 aOBie+xV0NmWwhAreL5XDzCrIfkmnyR/sks7LF2yrI5Z//pe93wQ9vfTa543tbzob1xf
 yy6tLF+nejqKRez0z/5ka/+ZaOn7A74DLDFLReAanJP5tREmF6R4jvqwsjVj9Qx48TW1
 h8HQVgctDQfr9QMt3KhdBebmbPbxW+/qMZRDnwL8Kr8IMMinYIkG2oCimlyykuS0+s08
 fl8tlAsOn9ib72q+jp7SAuJXTgn25IwmfKLuORWO+zcg2VcNLMtDtNLAbB4Pzhxtxx+o
 pb4Q==
X-Gm-Message-State: AFuF++ls2YnHsgjcvAD6+E5EIOzQJkxw/TVlGYnBV/z2yl7+4eYRbwmF
 fiYADubFayhsM6lWFDVn3xGaf0bGrWiNtF5ier1VCD1/FRsceE75cr88NxyAWT6rNXBqmoKv+Vu
 Xz1Mf+by0SmPSjsW6yk08HO/q0vyBIoLGF6OuxRBwdAks6C/pPdPcaGkzcPTZupfxCQ==
X-Gm-Gg: AYBFou0L7I9f7Pdw1pvzi5hbff8qSRnAo8u1jkUZBAedZye4SB8AftdsnlD3hm9LY+E
 bVa3BfTBQAt+GrfiYlhw05oE2UC4y35TeosnyNJSgz2b+2mbGJb9+tAyD5YPkAGpyc6NtijQ0jF
 i5paeTbTVjM7mHcrnsHObMruBTwOjKhbGvO/Q807u5XAFY57yYFQg4Vhu1/I4FMQwqsHmmhofT9
 rcCaGqq1jHyQYZ6APGuxSxE7pkCShok4r9KHUcU/ueSPYjBmGkukyFFwg2FBohZA90KI1catBse
 f/CtFjF8kCl1ln8BD8EtQnYNo7kwbL66RotJwAr/Xt4GCTyRlEEBfWr6599bMXJVd43f0L8+qO0
 z7H8xO3dF3g4QlwH6PU8rcTrq69gzd0xWERx/QjujbgYUW3cTYUxW+n/dFWOnlw==
X-Received: by 2002:a17:90b:3e4d:b0:39e:6a81:5a8f with SMTP id
 98e67ed59e1d1-3a06af10388mr500004a91.35.1790032512929; 
 Mon, 21 Sep 2026 16:15:12 -0700 (PDT)
X-Received: by 2002:a17:90b:3e4d:b0:39e:6a81:5a8f with SMTP id
 98e67ed59e1d1-3a06af10388mr499983a91.35.1790032512392; 
 Mon, 21 Sep 2026 16:15:12 -0700 (PDT)
Received: from localhost.localdomain (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a0674c0b4bsm1295939a91.13.2026.09.21.16.15.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 16:15:11 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 5/7] tests/docker/dockerfiles/debian-all-test: remove arch
 specific bits
Date: Mon, 21 Sep 2026 23:14:56 +0000
Message-ID: <20260921231458.3369-6-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260921231458.3369-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfX9gfYWgqJchnu
 qby6Sx6ZEQgyomn638mE4I8fXqnp1vCiI+0Z+dF/quBYhUeKbX+w9u7jj2TQLXIaP8KxlihQDmT
 sFPQgDfj1GxoqJoRnLk7LJEMH+T8mfc=
X-Proofpoint-GUID: gQcyq537-ccP6Zqz8-s1byH1FFOxreVX
X-Authority-Analysis: v=2.4 cv=QovLTlyd c=1 sm=1 tr=0 ts=6ab1ba81 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=TNSyY6zQAAAA:8
 a=3B-k7g5EAAAA:20 a=EUspDBNiAAAA:8 a=nziV0R4lOykNgt2sUWYA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=01gnQneks5i7xkQX6LlV:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDM0MCBTYWx0ZWRfXwZ0cfhHPvBBE
 dJ+RdxS6oCpu6+B9yNp26OBCUQtou/JMO2Qr2/9qx0QphC3xWdL8CV7ctzvuwOG39j+jpC2pvLp
 ymbJA4sUOxUWBupuEGpgv0TqtgyvFCVyFBc9a+jebLkzyiX7aaino8Qgjby1jC7+IpZN60m2yo8
 QYzcyCzlXuKB2LJd6jCsvTsjKcG3a5frwqj2D7ifFhWWuwYV3UNxsSXub7h2wdUbwxHhA5Ao+tN
 hQ4zZdNDOyqC2LNnADKdxRbA0rqDKXSBibUy78NsUnaNrRIHfgLX4ZXr2eCoe5xXF1bHY/3IdB1
 bHT6DWas7vGHXMj1ZVd2I2hr5gQUgVqgvfHgqgl8ngafdweyGJ8ya8wE8PqodT/UeZlry1smAUd
 S7PeHYPjuBOH/tbQZ+kwnGr6Mds3vmBSnyjbpCHEqTlkHiRjJ/dro9s4CyzxVR6esYSZbszvXd1
 bHGV3b/uKAd0QRNJc6A==
X-Proofpoint-ORIG-GUID: gQcyq537-ccP6Zqz8-s1byH1FFOxreVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_06,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210340
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

Now that this image is amd64 only, we don't need those ifs anymore.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .../dockerfiles/debian-all-test-cross.docker  | 35 +++++++++----------
 tests/lcitool/refresh                         | 35 +++++++++----------
 2 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index b6aba26c0c8..1eb419bb8fd 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -66,15 +66,15 @@ RUN apt update && \
   rsync
 
 # https://openrisc.io/2025/04/20/toolchainrootfsbins
-RUN if dpkg-architecture -e amd64; then \
-cd /tmp && \
+RUN cd /tmp && \
   wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
   tar --no-same-owner -xf *.tar.xz && \
   rsync -a or1k-none-linux-musl/ /usr/ && \
-  rm -rf /tmp/*; \
-fi
+  rm -rf /tmp/*
 
-ENV AVAILABLE_COMPILERS="\
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends \
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
   gcc-arm-linux-gnueabihf \
@@ -97,19 +97,18 @@ ENV AVAILABLE_COMPILERS="\
   libc6-dev-s390x-cross\
   gcc-sh4-linux-gnu \
   libc6-dev-sh4-cross \
-  "
-RUN if dpkg-architecture -e amd64; then \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
-fi && \
-apt update && \
-DEBIAN_FRONTEND=noninteractive eatmydata \
-apt install -y --no-install-recommends \
-${AVAILABLE_COMPILERS} && \
-dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+  gcc-hppa-linux-gnu \
+  libc6-dev-hppa-cross \
+  gcc-m68k-linux-gnu \
+  libc6-dev-m68k-cross \
+  gcc-powerpc-linux-gnu \
+  libc6-dev-powerpc-cross \
+  gcc-powerpc64-linux-gnu \
+  libc6-dev-ppc64-cross \
+  gcc-sparc64-linux-gnu \
+  libc6-dev-sparc64-cross \
+  && \
+  dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
 ENV QEMU_CONFIGURE_OPTS=--disable-docs
 ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 # As a final step configure the user (if env is defined)
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index ceabb9e978a..2bf5896a7d3 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -182,15 +182,15 @@ RUN apt update && \
   rsync
 
 # https://openrisc.io/2025/04/20/toolchainrootfsbins
-RUN if dpkg-architecture -e amd64; then \
-cd /tmp && \
+RUN cd /tmp && \
   wget -q https://github.com/stffrdhrn/or1k-toolchain-build/releases/download/or1k-16.1.0-20260614/or1k-none-linux-musl-16.1.0-20260614.tar.xz && \
   tar --no-same-owner -xf *.tar.xz && \
   rsync -a or1k-none-linux-musl/ /usr/ && \
-  rm -rf /tmp/*; \
-fi
+  rm -rf /tmp/*
 
-ENV AVAILABLE_COMPILERS="\
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
+  apt install -y --no-install-recommends \
   gcc-aarch64-linux-gnu \
   libc6-dev-arm64-cross \
   gcc-arm-linux-gnueabihf \
@@ -213,19 +213,18 @@ ENV AVAILABLE_COMPILERS="\
   libc6-dev-s390x-cross\
   gcc-sh4-linux-gnu \
   libc6-dev-sh4-cross \
-  "
-RUN if dpkg-architecture -e amd64; then \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-hppa-linux-gnu libc6-dev-hppa-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-m68k-linux-gnu libc6-dev-m68k-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc-linux-gnu libc6-dev-powerpc-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
-  export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
-fi && \
-apt update && \
-DEBIAN_FRONTEND=noninteractive eatmydata \
-apt install -y --no-install-recommends \
-${AVAILABLE_COMPILERS} && \
-dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
+  gcc-hppa-linux-gnu \
+  libc6-dev-hppa-cross \
+  gcc-m68k-linux-gnu \
+  libc6-dev-m68k-cross \
+  gcc-powerpc-linux-gnu \
+  libc6-dev-powerpc-cross \
+  gcc-powerpc64-linux-gnu \
+  libc6-dev-ppc64-cross \
+  gcc-sparc64-linux-gnu \
+  libc6-dev-sparc64-cross \
+  && \
+  dpkg-query --showformat '${Package}_${Version}_${Architecture}' --show > /packages.txt
 ENV QEMU_CONFIGURE_OPTS=--disable-docs
 ENV DEF_TARGET_LIST=aarch64-linux-user,alpha-linux-user,arm-linux-user,hppa-linux-user,i386-linux-user,m68k-linux-user,mips-linux-user,mips64-linux-user,mips64el-linux-user,mipsel-linux-user,ppc-linux-user,ppc64-linux-user,ppc64le-linux-user,riscv64-linux-user,s390x-linux-user,sh4-linux-user,sparc64-linux-user
 """
-- 
2.43.0


