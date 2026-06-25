Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F463CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 22:22:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcsS5-0000i9-AF; Thu, 25 Jun 2026 18:21:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsS2-0000gi-Th
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wcsS0-0001KV-RS
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 18:21:38 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65PFejCZ2544201
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EMApZzEwZegJ8aGMmuF7MuEZqtij0GKYrTT3h5aUe1k=; b=pE0Sd2Dx8cZkt/lX
 j3blk/oEhGWSZGTogtvzD6hoWWmBRfP7/1upWzIo8Wa4exJ7IyAj7rV5URQWaUiU
 EtA9nUEsgoeNYgO1O8SgTQjONIiW5oyX2jS4w027JZTTpQmpggmiWFJhhABtBMsT
 pg+9HyJMFOj3BFNKVV3jU3JnaL14pFX4eDhpB4ip5t4b7Sx1I1kkx6tuhWrZeOsY
 A2KgWaVfQP1YkA5/IovEmVjc0aVlUjOLAWqKsT3f+/l66RUsBsPpQasUkeUPVu+g
 W9fmZW5cfzyWY5utPt/NTaBzP8yAhVdZsVN08xgD513VwWAUh1Y4hLLFZAUFfNrA
 m3F7qQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q448y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 22:21:35 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-137fe4a3640so662950c88.0
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 15:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782426095; x=1783030895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EMApZzEwZegJ8aGMmuF7MuEZqtij0GKYrTT3h5aUe1k=;
 b=TT8DZv3ASwmHrntw3GZA5Dl97U3S5dr+39JsYgo+CJnpMpm3z+KiMaUoq5CiK0h7MJ
 iVl7B9GG96ZJXYv6EQC3mvrXDA+bRAUq6osOxtYgUz79OhMBmIsePAREuFbSb4dAZ71J
 QOGqZPjX3cUVoni21W0MORIIm6RG8WvgVRou0rvf8tD7nStDfOd+boOGTHqsDzSDtmqk
 hga0+6jygApf8fReBqJ9MjEcIvC8tnT7C/z8YpoJSSJQQduMalXiUqHCTLzjS4YFQSDU
 JroBpQOlcdf3cpUhOOdU0gEh/ZgOpRzNkOOqqm40dnOoZmIK4BklFAAStzlcIGLMxwjV
 +lHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782426095; x=1783030895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EMApZzEwZegJ8aGMmuF7MuEZqtij0GKYrTT3h5aUe1k=;
 b=ThJx9CCNugos9osFcDGtfTkcNNLECP7U7VKIKnXtdOU9IHy8q5DAJZ552g6fmhB4fF
 /dKsQjHGFRkq5zy+2nNtfZaOfL/CuMThGTe/BGCz32iOcn8XrzBeutF6wyyFAPuXNL3p
 cOD5x5zSSVmpPgD5hgtyJPp6aIRMJXXAf03/3pj3jD7WuEEhS9t58p6sER/k0eXb1uEy
 2c726fExJ6BcSw8DwZ+WXgFaC5i/dX5vHUxafJcASlSBVIN6bcBNPTOVhgDRjEfPP5a9
 jvGQVYzLnC5D7tZ42rY99BzXiNGyqKav0VhnWxktIBO3mZjjaaMQvLCfqIKeO3pLtGHk
 fv4Q==
X-Gm-Message-State: AOJu0YyinRFc31g0Z92ggBux+qviUgb8+hhfh5K+9G0MsyY6/6K3qzr/
 kFtbGbA/eeoYskaR84pwVrkwUbsXTptqcy4CMpBm0bmsluRRHDgF6kClbpErETyD2qwPHaPgnmD
 uHLx2J6pFe/2du6eGRLrlX/k8bh+FQ8C2sLhJmHPTUF3km/YhAhnOMZEOgoQg2VlTuw==
X-Gm-Gg: AfdE7clQZNHvLU14wxnRjUaovwn2mevdb7zREWWSqaQCmDKuYRhRi5+foef0KvT11kq
 XC4AHa/tayUnzIejvtTE0lD4D5ykqcS4NxGK3tcJTdL0pHkVsg9Xn2LCU5FkOvwpVwnBLx0gxQq
 zph6K2Zr2KMCkmGK8AG1mXg46FP/vIIJT4Tsi5XjH+EEtg98bpecNBOH5g6J4Qrx6zUOIwsKOm8
 PzyjZlS8BkCH93AG98oOgxJybfmKu8T/FlKWWJFUZz20/C+CpUfFa0uwclRTlxuV7vdz2IEGEn3
 cixh1xp2fWzsU0LpoSEmD7mnqyZ70l1BQ/FeUAuaRcAsHDsfyqfgxM6tfSEOwPWqETma8hI1UXE
 H8Ad5PR49BJy13hrofeAgbf+onTu9X9Up6TSiWU2Q1PP4cwn129Fd0wbZsdMhEGhR3sXa6MC3tf
 DtJ2ivdA==
X-Received: by 2002:a05:7022:6727:b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-139db93a89fmr3155378c88.0.1782426094505; 
 Thu, 25 Jun 2026 15:21:34 -0700 (PDT)
X-Received: by 2002:a05:7022:6727:b0:137:5b9d:cf87 with SMTP id
 a92af1059eb24-139db93a89fmr3155365c88.0.1782426093951; 
 Thu, 25 Jun 2026 15:21:33 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f318e7sm11538477c88.3.2026.06.25.15.21.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 15:21:33 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 4/6] gitlab: pull ccache setup into
 .base_meson_ccache_job_template
Date: Thu, 25 Jun 2026 15:21:09 -0700
Message-ID: <20260625222111.1761-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260625222111.1761-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tk2HRq7vwdTZkr-VXPfBLrRYiBXq7JhU
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX1+dYApbPBsWM
 50ks2cyJU6JH4AClXD+JaeUj7KLuH0gnFcSs8oceHjwfLOP4qpJ6jMf64hcylNGWcMzmJRvi4ko
 fU6uDULd+iN/68ky4Yg/+6ho0VQ8OiQ=
X-Proofpoint-GUID: tk2HRq7vwdTZkr-VXPfBLrRYiBXq7JhU
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3da9ef cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=-W3SEfyVoSCHGyKDL2gA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDE5MyBTYWx0ZWRfX0usr566YKhxz
 s0A6lkkrDwQ3DVyBxNeQ4dF2tFPS7K1fgfiA5UxITpaBJ9ktIql8FEbrBEijlwNn61AhNAZXnsD
 tmd9QUC4tCDKC1RKGTLC9NKxFha/teb2bx3a39NWHF151dn95Hpkw91j3BPlwvRLa1LZ32wPMZv
 P+/lKMpLu+ULgyHkXOQRig85wupZS5BMdRWFVoqEtXZHt9K3weulb4tZJw8sSVUy3ch8R4rAsmj
 Yg1q/umpmmvJXfZxqaMPHsggcvcMPDq67/7qNxUE8wXF8L6+ExrpbgexsDBLhx09Kw2q2F2nlKX
 ukSKzqry2Uyc0BuijN0Rc2AzjeTsXJvfw0QhlwD7ruOIELAIOLNWxVZUGi4eICjxBUeRTiM/heb
 KPsR2oC8ipRwVRW0o+/YEEK/iNZnGb+IJNY9/cEnBvde22gnmSO/dfFqvLvRLLqpJ2TTc85bum7
 Q+gMbsmekW/+x8jgafw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_02,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250193
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

This provides a consistent ccache setup across all build jobs.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260624124657.2725376-5-berrange@redhat.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 .gitlab-ci.d/base.yml                | 16 +++++++++++++
 .gitlab-ci.d/buildtest-template.yml  | 14 ++---------
 .gitlab-ci.d/crossbuild-template.yml | 35 +++++-----------------------
 3 files changed, 24 insertions(+), 41 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 94107579fe3..366e654bcb9 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -148,3 +148,19 @@ variables:
       - build/meson-logs
     reports:
       junit: build/meson-logs/*.junit.xml
+
+.base_meson_ccache_job_template:
+  extends: .base_meson_job_template
+  cache:
+    paths:
+      - ccache
+    key: "$CI_JOB_NAME"
+    when: always
+  script:
+    - export CCACHE_BASEDIR="$(pwd)"
+    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
+    - export CCACHE_MAXSIZE="500M"
+    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
+    - ccache --zero-stats
+  after_script:
+    - ccache --show-stats
diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 0fa2351d877..8dfd17a0b5e 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -1,13 +1,8 @@
 
 .native_build_job_template:
-  extends: .base_meson_job_template
+  extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  cache:
-    paths:
-      - ccache
-    key: "$CI_JOB_NAME"
-    when: always
   before_script:
     - source scripts/ci/gitlab-ci-section
     - section_start setup "Pre-script setup"
@@ -15,14 +10,10 @@
     - cat /packages.txt
     - section_end setup
   script:
-    - export CCACHE_BASEDIR="$(pwd)"
-    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
-    - export CCACHE_MAXSIZE="500M"
-    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
+    - !reference [.base_meson_ccache_job_template, script]
     - du -sh .git
     - mkdir build
     - cd build
-    - ccache --zero-stats
     - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
           --disable-debug-info
@@ -43,7 +34,6 @@
         $MAKE -j"$JOBS" $MAKE_CHECK_ARGS ;
       fi
     - section_end test
-    - ccache --show-stats
 
 # We jump some hoops in common_test_job_template to avoid
 # rebuilding all the object files we skip in the artifacts
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index 36bb9a405c0..aadae26844b 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -1,12 +1,7 @@
 .cross_system_build_job:
-  extends: .base_meson_job_template
+  extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  cache:
-    paths:
-      - ccache
-    key: "$CI_JOB_NAME"
-    when: always
   timeout: 80m
   before_script:
     - source scripts/ci/gitlab-ci-section
@@ -15,13 +10,9 @@
     - cat /packages.txt
     - section_end setup
   script:
-    - export CCACHE_BASEDIR="$(pwd)"
-    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
-    - export CCACHE_MAXSIZE="500M"
-    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
+    - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
     - cd build
-    - ccache --zero-stats
     - section_start configure "Running configure"
     - ../configure --enable-werror --disable-docs --enable-fdt=system
         --disable-user $QEMU_CONFIGURE_OPTS $EXTRA_CONFIGURE_OPTS
@@ -46,7 +37,6 @@
       mv -v qemu-setup*.exe qemu-setup-${version}.exe;
       fi
     - section_end installer
-    - ccache --show-stats
 
 # Job to cross-build specific accelerators.
 #
@@ -54,22 +44,15 @@
 # KVM), and set extra options (such disabling other accelerators) via the
 # $EXTRA_CONFIGURE_OPTS variable.
 .cross_accel_build_job:
-  extends: .base_meson_job_template
+  extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
   timeout: 60m
-  cache:
-    paths:
-      - ccache/
-    key: "$CI_JOB_NAME"
   before_script:
     - source scripts/ci/gitlab-ci-section
     - JOBS=$(expr $(nproc) + 1)
   script:
-    - export CCACHE_BASEDIR="$(pwd)"
-    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
-    - export CCACHE_MAXSIZE="500M"
-    - export PATH="$CCACHE_WRAPPERSDIR:$PATH"
+    - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
     - cd build
     - section_start configure "Running configure"
@@ -87,20 +70,14 @@
     - section_end test
 
 .cross_user_build_job:
-  extends: .base_meson_job_template
+  extends: .base_meson_ccache_job_template
   stage: build
   image: $CI_REGISTRY_IMAGE/qemu/$IMAGE:$QEMU_CI_CONTAINER_TAG
-  cache:
-    paths:
-      - ccache/
-    key: "$CI_JOB_NAME"
   before_script:
     - source scripts/ci/gitlab-ci-section
     - JOBS=$(expr $(nproc) + 1)
   script:
-    - export CCACHE_BASEDIR="$(pwd)"
-    - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
-    - export CCACHE_MAXSIZE="500M"
+    - !reference [.base_meson_ccache_job_template, script]
     - mkdir build
     - cd build
     - section_start configure "Running configure"
-- 
2.47.3


