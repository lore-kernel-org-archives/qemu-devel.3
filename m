Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BAF7C98318
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:41:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9rB1-00007X-RC; Thu, 24 Sep 2026 17:40:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rAb-0008Of-0g
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:39:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x9rAY-0000w9-HP
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 17:39:56 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdxt02497217
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FF3oKVrSmOz
 9+6SRd3Z5430y9xGNDRaAIKskN0lW/uI=; b=EukkAf+61w9EWUIvxDRa6Snws9V
 QqQ24jZBZCbbk6uhwlsR49sVP4Fg5SM0lqsPYtq9RAbgDFaWcGY/CsBC4v9BnS46
 AIWGSS7sS6fKmI3hOmSuYyE0SdU2l953V6Z/zzTZMgPk57FWHYkGfp9IcmnYaZ4R
 uP3X+aqDkJBAt5alR1/KKzMVOyqO1wFeyopiKeEB+OhrqyjqM8uzcCFXlyRM6A/+
 9rR+8k4tsJrVLSk7xEjJY+X+SGaza+NxYHhyv/Ih0gWAGjkNHZ9BvygWHgkjvtZp
 TzGtnlrIi/DkM8jTpyIP0S0d8B4JtDof3y4+qYm10pOkOZRBHHjb0QYmIqw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw68e1ktm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 21:39:52 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3286d2bac04so307598eec.0
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 14:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790285992; x=1790890792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FF3oKVrSmOz9+6SRd3Z5430y9xGNDRaAIKskN0lW/uI=;
 b=bXvN1yklrrSjEC8KO58k+lgWX6ld/QYCYBz6BwetqA2z/uuk23+Kn98vTgcdE5W6aa
 GYmo4glrq3FDAeQEV0586H6UK1lADpGrL1qhdRsmxon4uHKDfKuCdSA8xLG4C7Z7eKXM
 mArAR6/gh9Jy69rm2x/xo1RGbFIaeK890ywqnwvkOs/fkRdLTOEmlWeZFsN/i7/O2NF5
 7l9sO0uwTiOHSl0/DF76XeCjbXsG3wHFRsttyz4Wfo77GtCjfZrxOQb2usU5Pg2k5Nwg
 Ov3XKn0/KBCzX2NdeO/0XdwzjAsbP432YwsQvuS5cHakWDb1SdSxtMExpqEJLl2OKyUq
 +U2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790285992; x=1790890792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FF3oKVrSmOz9+6SRd3Z5430y9xGNDRaAIKskN0lW/uI=;
 b=UsEjf227+PM2/kdcipZBfHI0Kt80wKMIHVVdgSVJtYyF3X7DzjIaKgYkVNZDiu1IZB
 9D/kVvG9mpek6l6ChQ7D0RsU8Xw2mLJMIAFmtwcNZcT6VXopB3TpMnAT80e13qboB+Lh
 z3qqAKuLHA8I+7UAzCE+tqHqqEHrBA023zd3s+3fl5OZhOr5atYsiLII77CuYgKiDUkF
 97YimBXGCkTM0PZL8IAOegkBpyJgc24QJWkQxCaqi9yKtYLgk41ii6UKLJ9cAJRT0teQ
 tkYVs/9FqkglYTSSPCb3o+hMTHgTY6CuptoNLpxsxwfDUnpQa/mEi0kLacNdnehgGy3I
 CGbA==
X-Gm-Message-State: AFuF++nBGVp+vAZPyHjTjwcdD7oeGNAPxyEm6z+JeggDqE4N7nCHot2r
 GwZuDQlCouceeCZ9Bs8vtPkwLVNR9++AtGvSF6QeDkmua79m5G5QKOfMb4g2L95NDTEYQImtrdq
 EWVY382+JLJ3ybIvRS816ji28mSPam6mpqiCf2g0S6iUDT0hX1zaQr+tOMQdTeZeZRw==
X-Gm-Gg: AYBFou0E2DuMY1L8ohRmkDgTbB+oamB5+hxG5vT5dIv/V5mIrulr+aLnBQw6QTLqdSu
 OJoXz/gt9LRtFK3NUiOlWYPADEBgHDNgU7psEwt4NqiCKh8J/F3QJF/UiAiTGZIeH3s3wNGgyHM
 xqYtLu1K9WLu+PmIwmEk5jv6aKJeQ30lHnwBYBtjQRZ0bOO3JO/yXpOLwktH7eI8y5yxxKikK6I
 QXWLE9+M79Hq/5fPFk16xHUQuDf/Fp0JFqY23t4x6Be5APAKxZ3aMymykZrGFRzqXDEWyMB8qzD
 tlcdiSbJyva2Kp1EHJtXI4M/tHxpGSER8RS5PkZNX3qmoI4hukebwBuof1PKkJlXFvMvv35bwld
 49f9edbsVCVpjgA5yK1V4CMhy2CA/QK/s2VhNfRZgbEtK+01PfnNfjJDAOg==
X-Received: by 2002:a05:7300:824e:b0:33e:6b65:5eab with SMTP id
 5a478bee46e88-34004b891d8mr2676550eec.26.1790285991901; 
 Thu, 24 Sep 2026 14:39:51 -0700 (PDT)
X-Received: by 2002:a05:7300:824e:b0:33e:6b65:5eab with SMTP id
 5a478bee46e88-34004b891d8mr2676536eec.26.1790285991187; 
 Thu, 24 Sep 2026 14:39:51 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-341463ec3ecsm1273668eec.31.2026.09.24.14.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:39:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 4/4] tests/tcg: add alternative cross-compilers for macos
 (homebrew)
Date: Thu, 24 Sep 2026 21:39:42 +0000
Message-ID: <20260924213942.26491-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260924213942.26491-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfX0Lqrd+LZrl87
 jJFByVki0p1YEU6SW1pnTFftbny53DjqMb1LFitkgOxX+ZUo8nARmSYmktbpdyFGBgWnMdxMHTZ
 P/Ce6GYw6e5WTu0iIPoNFTaSlbXCviHTivyUeZBM/OJoM3LnyNBxaSNI+52ipcyf0JcOHCbo4n5
 jVFWlbFuL1PRix+hWqTK93GYFXM3DKYXVjLiNIc6EHR6/YIQ+KprHuGcCRRyD+qccR3vr5sQVuR
 kpbaYh3xdyJn05EeNQ2N4LWj8wQW+IMX8wInGLrKzzZ36NtOOg0XL6e0ShoU3OtrTcs6xK+yeiL
 OXi8w+aVTGDW2MVSyvAEycMucEEBho7beb/Rioe6bsegUZKwz6M7IWJ/0MmOyV/hg/LqPdixXOz
 wmDiqwEv62gGAjqDLSoPeAb5O8TyJGdm6oSOtfndY0gTHStrOBvX8N0eqTcnhuG5SAbJOqN9fIq
 +QL7Vzz+zmTsjc0dqhA==
X-Proofpoint-GUID: nWGGZdMqRy1sIzTCOeaOKHCAG7sslTZQ
X-Proofpoint-ORIG-GUID: nWGGZdMqRy1sIzTCOeaOKHCAG7sslTZQ
X-Authority-Analysis: v=2.4 cv=XawcX455 c=1 sm=1 tr=0 ts=6ab598a8 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=NEAV23lmAAAA:8
 a=EUspDBNiAAAA:8 a=xDO-KKndLwJen7abHAMA:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4OCBTYWx0ZWRfXyDhqd6hzUdUq
 5/WmkYr8uV6IQOuWvieGR0uzHjK3pSmwZq+4wXeWJLyyhOcT0AniCGeunYGMbegHcUNUvZEn9m+
 zHia/v0qNAuWdF4mcwF9LweE1PbKcjc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240088
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

Add support for cross compilers that can be installed with
homebrew: https://github.com/orgs/Homebrew/packages?tab=packages&q=-gcc
- i686-elf-gcc
- x86_64-elf-gcc
- aarch64-elf-gcc
- m68k-elf-gcc (ignored since we don't have system tests for m68k)
- riscv64-elf-gcc
- arm-none-eabi-gcc

Those toolchain target bare metal, so can be used for softmmu targets
only (macos has no user target anyway).

With this, we can also cleanup our CI for MacOS since it does not
require any --cross-prefix anymore.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/macos.yml               | 7 -------
 tests/tcg/aarch64/system/meson.build | 2 +-
 tests/tcg/arm/system/meson.build     | 1 +
 tests/tcg/i386/system/meson.build    | 1 +
 tests/tcg/riscv64/system/meson.build | 2 +-
 tests/tcg/x86_64/system/meson.build  | 2 +-
 6 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
index 40b9b637b3b..c798384392c 100644
--- a/.gitlab-ci.d/macos.yml
+++ b/.gitlab-ci.d/macos.yml
@@ -41,10 +41,6 @@ aarch64-macos-15-build:
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS:
         --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,x86_64-softmmu
-        --cross-prefix-aarch64=aarch64-elf-
-        --cross-prefix-arm=arm-none-eabi-
-        --cross-prefix-i386=i686-elf-
-        --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
     TEST_TARGETS: check-unit check-tcg
 
@@ -59,8 +55,5 @@ aarch64-macos-26-build:
     PKG_CONFIG_PATH: /opt/homebrew/curl/lib/pkgconfig:/opt/homebrew/ncurses/lib/pkgconfig:/opt/homebrew/readline/lib/pkgconfig
     CONFIGURE_ARGS:
         --target-list=aarch64-softmmu,i386-softmmu,x86_64-softmmu
-        --cross-prefix-aarch64=aarch64-elf-
-        --cross-prefix-i386=i686-elf-
-        --cross-prefix-x86_64=x86_64-elf-
         --disable-plugins
     TEST_TARGETS: check-unit check-tcg
diff --git a/tests/tcg/aarch64/system/meson.build b/tests/tcg/aarch64/system/meson.build
index fb3b33861ea..f9c4448abaf 100644
--- a/tests/tcg/aarch64/system/meson.build
+++ b/tests/tcg/aarch64/system/meson.build
@@ -96,7 +96,7 @@ if 'qemu-system-aarch64' in emulators
   tcg_tests += {
     'aarch64-softmmu': {
       'cc': cc,
-      'cc_alt': cc_alt,
+      'cc_alt': cc_alt + ['aarch64-elf-gcc'],
       'cc_dockerfile': cc_dockerfile,
       'cc_feat_cflags': cc_feat_cflags,
       'folder': 'aarch64/system',
diff --git a/tests/tcg/arm/system/meson.build b/tests/tcg/arm/system/meson.build
index 93d0cfec24e..89734f95605 100644
--- a/tests/tcg/arm/system/meson.build
+++ b/tests/tcg/arm/system/meson.build
@@ -64,6 +64,7 @@ if 'qemu-system-arm' in emulators
   tcg_tests += {
     'arm-softmmu': {
       'cc': cc,
+      'cc_alt': ['arm-none-eabi-gcc'],
       'cc_dockerfile': cc_dockerfile,
       'folder': 'arm/system',
       'gdb_arch': 'arm',
diff --git a/tests/tcg/i386/system/meson.build b/tests/tcg/i386/system/meson.build
index c3a19f43260..91c6e887191 100644
--- a/tests/tcg/i386/system/meson.build
+++ b/tests/tcg/i386/system/meson.build
@@ -42,6 +42,7 @@ if 'qemu-system-i386' in emulators
   tcg_tests += {
     'i386-softmmu': {
       'cc': cc,
+      'cc_alt': ['i686-elf-gcc'],
       'cc_dockerfile': cc_dockerfile,
       'folder': 'i386/system',
       'gdb_arch': 'i386',
diff --git a/tests/tcg/riscv64/system/meson.build b/tests/tcg/riscv64/system/meson.build
index c87e3eee1ad..c2d7d098871 100644
--- a/tests/tcg/riscv64/system/meson.build
+++ b/tests/tcg/riscv64/system/meson.build
@@ -65,7 +65,7 @@ if 'qemu-system-riscv64' in emulators
   tcg_tests += {
     'riscv64-softmmu': {
       'cc': cc,
-      'cc_alt': cc_alt,
+      'cc_alt': cc_alt + ['riscv64-elf-gcc'],
       'cc_dockerfile': cc_dockerfile,
       'folder': 'riscv64',
       'gdb_arch': 'riscv64',
diff --git a/tests/tcg/x86_64/system/meson.build b/tests/tcg/x86_64/system/meson.build
index 08b770d43ae..7d61257b771 100644
--- a/tests/tcg/x86_64/system/meson.build
+++ b/tests/tcg/x86_64/system/meson.build
@@ -52,7 +52,7 @@ if 'qemu-system-x86_64' in emulators
   tcg_tests += {
     'x86_64-softmmu': {
       'cc': cc,
-      'cc_alt': cc_alt,
+      'cc_alt': cc_alt + ['x86_64-elf-gcc'],
       'cc_dockerfile': cc_dockerfile,
       'folder': 'x86_64/system',
       'gdb_arch': 'x86_64',
-- 
2.43.0


