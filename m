Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D6BC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whDdI-0002Gl-NL; Tue, 07 Jul 2026 17:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDdG-0002Fc-Lh
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:47:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDdE-0003LD-Q2
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:47:10 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5ZYE504935
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 21:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Stsnr1wHWoo
 kTGW8h85pDTwRf5ne80+sKlffikmGnQY=; b=RTyFLUBecMbIDUuuLcUfM6xxb7J
 EJDi20kkDzxD/tQ8A/HOYXPQgu4dqA0ujCunPcRGNFCwBpaBRSLg3Yf3nVtPyzB0
 WM5OMdU0mQ30ZWpVveDvbEUsnwKrFOeyxvLvOwR2ZqgtS1l4k4p409jV73Xtkywe
 lh7v1M0iDmjfs06spq3smcfnQOjQLYG5SVLuQj8TUT00SXmd3XaPqB0XOZyebJur
 aPtuPJEo/PK0wEqxRRld9WHZArQqK/Mtp8ER7aZvLSY6U6YJtqMKK1cUOmn49lk8
 UgYquRit+ZyX6I8VBCkAWsD439yCmmFkxZIUEOospq670LvhLA831Fm3ehQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8vdjbu64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 21:47:07 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso3855489a12.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 14:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783460827; x=1784065627; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Stsnr1wHWookTGW8h85pDTwRf5ne80+sKlffikmGnQY=;
 b=KHPDf+brZgg3CkKKb8JT/aI90ht9eDWKo4RIeoVu+bOWjk+N/uDK78Lf5S9HHotQKF
 wija1yf30rSWsv0RLpPNSTUynNcT6mZvZWq2LIxzgicmG9gBbDu3/Sc/jcSHOcEhSx1x
 woCh4unMBwvbt0dqVRN1ANhZm0b3RgWCddvk/6QCTbp/rJyj5T4oT1Kaq+ZgMhTPeXuj
 RXiB4WY12EXP7tGfmjs9ZRAd0DJs4eQMNSg0S4TlN4rbFjBJZ+Rtj1umNsHZt0DxSG+m
 WfT2OEhYUWU4aNeKOyLWg/zjN1z7MUcnlcKY+aedivsPFHKlCc8s+Jiky7wfq0sMCsOt
 A6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783460827; x=1784065627;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Stsnr1wHWookTGW8h85pDTwRf5ne80+sKlffikmGnQY=;
 b=VXh4Wvc4jsqu7CSGXqA/Xd1T2Wv1gL5iBUGJkZ4fT0RkuQ754xJkaDgrJdOGoUUb2F
 g0PvVZ6FvVh7XWc1EsUuzf9jdxKNzdiVZuXpUvFpgLmoDbNqrEk05YMw0RYPd8uCu4TJ
 sLzec5d/1KVpiA3pVe1fPmmb5P3AqRmH7odOOWZHQH7iSvU0zM/JFqT1J+TBH7fUeknt
 AZdccNYA0A0UTFthRZwrJ0Ztp0oyMc/JFa+Ttay/zJ52vlt115nQgnDtxo5xQgAtvw6q
 uSty4fVxkCW9qf5agJKKmALMtNWRCrmJQpcLDkHTXEf21NlICI253M5oKZaV/NtB+iFU
 ZZ/A==
X-Gm-Message-State: AOJu0YybXcIhUnlApAon1J0HzMkD39D4sF+7Y/FvRJ7vI2Fb5Ug6vqo0
 gFcV1gdYv8r4ZWNDmeWGwEM1AAID+0s1VGWxqIQUMLkzgX1dLE9pAseuIX9asfssLPPuKKxflDf
 IuuygXsStm4fm3ztXts2ebvf/ICCCnIE6wJ8bXvgD6vb/UuhDpmJDQsK71Y5UJ5TtQA==
X-Gm-Gg: AfdE7cnwRyBSTOYCzHpCoahbDLgwfepAGXDBkogMNnyVxtsVIquU7+cbZfZdzDriW8i
 vq+f1+Sw6f2KwqvvPTDLeoq6IrbGoZKFdd48v1wQ550DKIqibETj8ouWwDIfSyHLfPytcKA+4Nl
 m/8/bn05bSkcUFtgBrLGa6I6UYBOOPas+Vd8s9mrKakG+NWni0pOW301aCjSWBhKCuAiPfceEQ7
 nITSL4fcnSZBJJEAHX2dlMvLi7CPdo8sHsOA7cpsVj9X1aepxFec6c9PTztQN2Zm1DVUdzarUFO
 o5vmHEK64BpmuVsMp8G6+8YfdGAK8a7MYYGz9qJlw4Y0B3qGSYkN43+L/HOY2xSchJZm4aBvd5h
 OrZANTfYmWVMOOqOXaCLHco4UQYSdt6txpvzrq4LX9tzsFDGuxzhd7SOgLvAHwsBKYchidoxJ
X-Received: by 2002:a17:902:f644:b0:2c9:aae1:a61c with SMTP id
 d9443c01a7336-2ccbeb1e2f0mr62297305ad.20.1783460826724; 
 Tue, 07 Jul 2026 14:47:06 -0700 (PDT)
X-Received: by 2002:a17:902:f644:b0:2c9:aae1:a61c with SMTP id
 d9443c01a7336-2ccbeb1e2f0mr62297115ad.20.1783460826274; 
 Tue, 07 Jul 2026 14:47:06 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdcbe2sm18368045ad.9.2026.07.07.14.47.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 14:47:05 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com, mjt@tls.msk.ru
Subject: [PATCH 4/4] tests/docker/dockerfiles/debian-all-test-cross.docker:
 add missing apt update
Date: Tue,  7 Jul 2026 14:46:55 -0700
Message-ID: <20260707214655.1138626-5-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=R7cz39RX c=1 sm=1 tr=0 ts=6a4d73db cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=n6MYwUk4AAAA:8
 a=EUspDBNiAAAA:8 a=fbayYWIdwhgohUsoNHwA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: ysIS1aT6TK88a3MSMrTn4BTQgbXJwUsh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIxMyBTYWx0ZWRfX3B5mwLLlHHAZ
 x9uO1qsRWr8L6LyvhoPj6jVfybCxgmv4xcDceN+sCnYUFL3hFyumoQqilcNFsaa7IAoOA7MjNIx
 kBGavTYKSR7ILomv/DPUeyieM1nMT49/NdhWXX94PxQdUiniYC6D1hlc8fbVTG4wpyQVUQsoAF4
 39Z/5QgHq+YtdeD82zj0VIcP+v5vfMPwiens7jZ5qj7U/oes25qcy3OhlsGmR64/WOFNAkikZH2
 V0X9fFC3Z+BGQITG9CHEV4IyRjQlqUiWU+RLmdih5jk3luleY90oB1LQq/toarjXVCbbgNL45kZ
 zBkavPczdDUa6cvl3BH92i4zCk+pjYFFEX9HyOv9G4J1670A0xl+9NjI7ikb6CNIt/n4sa737Nb
 MHlZH9qsrL9dW1hlIyXOnMZUtZI0w85pqVWeML99yTIQAMSctn2WrVRpooo/U/+2ckA24nCRu1N
 zRTMebIwn0JJR8gkL+A==
X-Proofpoint-ORIG-GUID: ysIS1aT6TK88a3MSMrTn4BTQgbXJwUsh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIxMyBTYWx0ZWRfX+s4GrCzdirt8
 1XNaQw4syLOgNW8z019UCUp6k0j0EboLmftLU4lvKBsBVqGL62igXmEbNm8AM1IC0IMnHLXBuYa
 qPPjBs8/o4ejdV4N1UBHhMN/UtIUvBo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070213
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

RUN statements should always use apt update && apt install together:
https://docs.docker.com/build/building/best-practices/#apt-get

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/dockerfiles/debian-all-test-cross.docker | 4 +++-
 tests/lcitool/refresh                                 | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/tests/docker/dockerfiles/debian-all-test-cross.docker
index a10ffc73500..2dc580552e3 100644
--- a/tests/docker/dockerfiles/debian-all-test-cross.docker
+++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
@@ -55,7 +55,8 @@ ENV MAKE="/usr/bin/make"
 ENV NINJA="/usr/bin/ninja"
 ENV PYTHON="/usr/bin/python3"
 # extras for cross and alternate toolchains
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   clang\
   dpkg-dev\
@@ -92,6 +93,7 @@ RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
 fi && \
+apt update && \
 DEBIAN_FRONTEND=noninteractive eatmydata \
 apt install -y --no-install-recommends \
 ${AVAILABLE_COMPILERS} && \
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 8def84d946e..6bc611b0e6c 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -166,7 +166,8 @@ RUN cargo install --locked bindgen-cli
 
 debian_all_test_cross_compilers = r"""
 # extras for cross and alternate toolchains
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends \
   clang\
   dpkg-dev\
@@ -203,6 +204,7 @@ RUN if dpkg-architecture -e amd64; then \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-powerpc64-linux-gnu libc6-dev-ppc64-cross"; \
   export AVAILABLE_COMPILERS="${AVAILABLE_COMPILERS} gcc-sparc64-linux-gnu libc6-dev-sparc64-cross"; \
 fi && \
+apt update && \
 DEBIAN_FRONTEND=noninteractive eatmydata \
 apt install -y --no-install-recommends \
 ${AVAILABLE_COMPILERS} && \
-- 
2.47.3


