Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B81C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 21:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whDdI-0002GY-HE; Tue, 07 Jul 2026 17:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDdG-0002Fa-HH
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:47:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1whDdE-0003Kl-2S
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 17:47:10 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667J5M23341671
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 21:47:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hCtCNBOx5KL
 x3RPcDfN8SRwG7vxw7FAYZuLqcrwyUSI=; b=AeYTzP9YluBjioyVDXNYseciZ5v
 fAJoKFFILOS0TyDlRKQyP/07G5GQO+NwwqeTGUjlk/fDmr2YtROcBotU3sk4Qjro
 9GEGoj1+0Q+9JHJhTD/CfwFcge43bx1WRswu0Askk4O+v8lKNmH59WtKZA8+bZPB
 ORXbwZUN3qbVMmam0tjLuKKzB+mB9gqgUT95WdrJAkxSXIjwLrTV32QIakqOXedm
 Jm0Dz+GTAb1WKgkloN4uU+BNZzUYyoLLViNdXb3x+Oloh9XINdRhfCDtYd9QSGFN
 xeTrtUnRPWfIV6QDEC7+2LgYhLaJRawNIdK6t2c9eFx7So4+pgfcuprL4Aw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8w2ubpk0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 21:47:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cca5e0a0c9so1264835ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783460824; x=1784065624; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hCtCNBOx5KLx3RPcDfN8SRwG7vxw7FAYZuLqcrwyUSI=;
 b=RLVXG+e9pSTIfewUItuDx8cVQ4k96tUV1BUtXYgc+Ei8S+mCSUS2Ek9eVtemSNgKgq
 HPjZIQ2PJs/y3HSIha0xFykmdv6Clp0joY5AnBBWxdjAb/dBizeQTw8KvvlFEUP3tFY7
 +ccUnLk+eTnk6l4Ari0EvWd202Vj00KGGECFkmzQvVhrltjNoscOapVxWVpldvJQgiMi
 WUWo3Vc2IhVJf6F7pHhx7iW/Td6DbxAm99i+rBFK5XSgBzYsA5xqUTgyYQta99mCs4R8
 ccF5Ab0jJdYjTdjm1I+iM7+800INibQeSvJwDORDcUE6Z4GGvcw05syzaXyGNzx2S8pG
 KF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783460824; x=1784065624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hCtCNBOx5KLx3RPcDfN8SRwG7vxw7FAYZuLqcrwyUSI=;
 b=p0jcz8EjjAMwFmr4Jxfcm+IkV1Ux+uaMh7Zm8u8gQb+PEyUPVD8TzeD56ZRRnQZbpp
 yuQqVtmA3eb2OPiDU39P+8ncYr/qIXGWIOrjJdLU3ONZZKNu2sc13ULatlFReToFDAlD
 vY/KmFLJF0FtWULhdNHDeS4HaZz6XCOBsEB/2ZbHYV5X95uGKPqikgDTk5a3AbF+PMgo
 +1Y5bYOv9KmjJDN5Nq9v7TSRpOYeeEbCgfwr7nSibUYXd9MdK8JzhkcW8gPr4zd0tfEa
 BhIVIRcpL5H/D6uD9igz9oXiTdHppp82eNQx9AbC+Bebx2sEPaQa6ayn1o9+zUHN70s/
 WoCQ==
X-Gm-Message-State: AOJu0YxK+HRwLouWfHHTyu+8oiLvFNoOxW6j9dUawWw8YsqoukcRVzyB
 ZY1qFaVutCYuJMp8fiMUwwrL46tGP3V8RgevBPYNr29HmF5Ijv6M+uiz704uW4AtmoqPJ+MWX1M
 7dMwnSK9TipITABvGHlHqlg8Yyu3Z9ZeoeGB5rOXUlxeQK+iqC7vGNFflDQkBpfs7Hw==
X-Gm-Gg: AfdE7cnE8CpO6CNIeybTMJisYHhgiQQKPrPNmyAVA4DJeahS0Bc1JbOB1qpyeZm/+pD
 u037sCaQOXySWH4niNNb6Ty7KTM6vqE0/x0N00lH1LIMRBF9PDmdp/oRgG4ceVlZvsB3KSQt34q
 sBEjndeA8helt6JIUrqkh3EZ87lb0JnyPa8JOqR/lLhuKnupVk+hQX0dov3czbpzHrZoHfziXz5
 BWwBGL7bG8r3Y3pANjoTX3XbXoHp7m4vt3Z7xtlnaLDzgDf41KfvYuYvD6770faZ54MC4XmcXsw
 28CMYVxLxaRXV5lKiwNgN2lQ586xdB2DJ9+Uyn3p3uMFKN7HXOYDqDtY7nKPM3n7WbYyr5nCNHb
 3wPPXIIzHTzZLu4weKualuNiJE8mYta0056TpSepMpA1lZAIcd2hfj1c3IreIDo8HkLsRuXOI
X-Received: by 2002:a17:902:ce0d:b0:2cc:e620:e307 with SMTP id
 d9443c01a7336-2cce620eb2fmr4868625ad.20.1783460824143; 
 Tue, 07 Jul 2026 14:47:04 -0700 (PDT)
X-Received: by 2002:a17:902:ce0d:b0:2cc:e620:e307 with SMTP id
 d9443c01a7336-2cce620eb2fmr4868455ad.20.1783460823649; 
 Tue, 07 Jul 2026 14:47:03 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ccc9bdcbe2sm18368045ad.9.2026.07.07.14.47.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 14:47:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: mark.cave-ayland@ilande.co.uk, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 berrange@redhat.com, mjt@tls.msk.ru
Subject: [PATCH 2/4] tests/docker/dockerfiles/ubuntu2404.docker: add missing
 apt update
Date: Tue,  7 Jul 2026 14:46:53 -0700
Message-ID: <20260707214655.1138626-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260707214655.1138626-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDIxMyBTYWx0ZWRfX5Jo3zHkF4UCC
 QsQJmCKluBfIYWPHseZ+BauevqCd6cLob3LzInEn6hhxx11dH3VVodo8yZdZF7XyM6nuvpK7K0P
 hfv05N5Jj391mXj2LQh7jP2jWgX1csA=
X-Proofpoint-GUID: BO8d-rY5Di8aJlzoLseqEGw3hRXylg7O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDIxMyBTYWx0ZWRfX633vKMY11hPF
 N23Pq5ISXH/6iWpzz/MLm/BedZrDCWP2kYPKJYDGy+K0Kj0XKkZWphq/0WBvZJIkaUNBFg3jNak
 /QkOh5FF+ECHZhPUL4lemdkrWnKZMyLuQQ2mYPcM3XSrBE+DqLHUk996y7g33TNDP5wrtDBeSBW
 IcfgomaS7/hSlOEu6d50aVsTs4vU2bvBly70bjjnWTp3FR5z4z37MvR6o5kHq/sLB3yMZh2yqKF
 g9x97rTKq0d7gM3hkuucdkLMieX+GRljWA8oSwpSp1Aiwhtlcv7i4UYfN7VtBtY5qV7D0UjucfE
 tNCR2cYFhSuO3n7LKiWW6Yg4IGWSM0mSdtCEIZpNhPqJuk7Qfb1a1rhvXGf0MI8PF/ERG6yzctg
 3vVaEdE+oU7LXcSN2da4OMbfvg2VHQari1r1FgkIYeiIWyh8TKXTfbIaxSLd0GGEMLC0aKcL7QN
 j89m/P3ARgS9yKIcKQw==
X-Proofpoint-ORIG-GUID: BO8d-rY5Di8aJlzoLseqEGw3hRXylg7O
X-Authority-Analysis: v=2.4 cv=bPQm5v+Z c=1 sm=1 tr=0 ts=6a4d73d9 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=n6MYwUk4AAAA:8
 a=EUspDBNiAAAA:8 a=WKaNRiMFEbhJKHKE1H0A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_05,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0
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
 tests/docker/dockerfiles/ubuntu2404.docker | 3 ++-
 tests/lcitool/refresh                      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/docker/dockerfiles/ubuntu2404.docker b/tests/docker/dockerfiles/ubuntu2404.docker
index 26bc2dd94f4..27992e34fd9 100644
--- a/tests/docker/dockerfiles/ubuntu2404.docker
+++ b/tests/docker/dockerfiles/ubuntu2404.docker
@@ -160,7 +160,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
 ENV RUSTDOC=/usr/bin/rustdoc-1.83
 ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends cargo
 RUN cargo install --locked bindgen-cli
 # As a final step configure the user (if env is defined)
diff --git a/tests/lcitool/refresh b/tests/lcitool/refresh
index 1fdd37440c9..bbbc6d3c46a 100755
--- a/tests/lcitool/refresh
+++ b/tests/lcitool/refresh
@@ -157,7 +157,8 @@ ENV RUSTC=/usr/bin/rustc-1.83
 ENV RUSTDOC=/usr/bin/rustdoc-1.83
 ENV CARGO_HOME=/usr/local/cargo
 ENV PATH=$CARGO_HOME/bin:$PATH
-RUN DEBIAN_FRONTEND=noninteractive eatmydata \
+RUN apt update && \
+  DEBIAN_FRONTEND=noninteractive eatmydata \
   apt install -y --no-install-recommends cargo
 RUN cargo install --locked bindgen-cli
 """
-- 
2.47.3


