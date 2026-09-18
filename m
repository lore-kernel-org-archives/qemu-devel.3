Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8C6AC982E1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 19:34:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7eKr-0000KI-24; Fri, 18 Sep 2026 15:33:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eKo-0000Jn-AZ
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:33:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x7eKm-0007Q2-Hl
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 15:33:21 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68IHob3P700844
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Zem9V9vXV7V
 073FvHMHM+jjTsjypJFuquA3uU2HGwQI=; b=DBhRL3UEy/oS9wUATKZPmhcAgn7
 yDE/pp6UN2UShpKcel26ZCPe4fynjW9nZOd85dbgsR10Vvw1VIpv4hKfmAYYHby0
 voUcLIvyJ8uC/lSHP6xdKdyH6idN/yuXuLNSVkiuJcZtOkfKQpbp3/IUjhfKCphR
 F2A3cpA/CGv4r2DKDbKZBHf4wbywaX4/sZUEsgVsYOTc91mE9en486JkG005rtSu
 D8CiFaTsef15jWjQGBo5PX0z9byU8CEQlatEGmuS6p2E2X/XYgaFbqUR2tuGDh2o
 JWkm3xsXTz28o2P2X6vDwc7vkP8OZSZMnfEe0Olct93Owhksb5ZI7q4OJIw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gs83wh271-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 19:33:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8627258ef12so2375063b3a.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789759998; x=1790364798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zem9V9vXV7V073FvHMHM+jjTsjypJFuquA3uU2HGwQI=;
 b=AXtlwVrOXLIdjNpfgCka+8A3KY20ZBO7zZzbY0cSb+iiKJqSlYJCfDYw42/9x4eZLg
 DcodT9FzL8eAehC5LcvzxkvoNyMZLxiguIm2XcKJ2EdfX1NZ5xkkOFBaCTiuYVjiejCo
 TdUh08RNz2xoiqoK4kUh96WVz4aLX4UyPowEJBjc4Vdv1WuInd72VLeD2sJryS7HmSqx
 DVF9i85l77CPIfsEfZZDGKRAgmp1JL+X+O3odYbI+cKQGhgR3/iI0uQ4CGb/A2EybIuO
 GVCumgTkXNkDWlNx6XvFpDL8C5pFO12Dkm1VcOoc59/mnfKjCcdbrLvOGmlY7C6O/W75
 ePtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789759998; x=1790364798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zem9V9vXV7V073FvHMHM+jjTsjypJFuquA3uU2HGwQI=;
 b=T9u/H07FI25fqvTD6m8nRlBDgvN6U4nMba2pUGZiFxIkovdPfvSqONahzlL6hl4LLc
 gE4x1imxkCj6n1k0fzovy9+K6MPCjVthq7axO6VitKeAWH9AEGF0L8KSr0H0eX0wMkT7
 eiufzSYVvPV7q6U8kxQ1MJqy1BxtfW3ybmuiBjXM23YKwNSAxOGqLuvN2D7mmDmZM4Lg
 9XH1nMNxnU4g71CCYas6Q1jElsLw3/Z4/Crs9nq3lUDBOLx7YgwbazbBKu12agh4CXyR
 DeQrBSLMMIcTJ1Ny55BQ/jNmREFSdySTHC/KJKiKTQhTe2LOhIGBjTTCXu66iXcbP6Xc
 s+5A==
X-Gm-Message-State: AFuF++kW7T86wbJVDmbiJw7eF3Z3nlvoGFdcvn63f+xl29FnvtP9BYV+
 iQFdmkDYmXkceGhg+dCHAuxL6dPFoiGXE2K0DH0ImdbHl3OSmVglEOF6pjTFR+N+/wU7JrAkmm4
 f8lLGC8glEMVUYY/AqvT+ee0RKwkAJd1zV+lO4MEG6oseCpxg3WKmhpgOVi8jGPrW7Q==
X-Gm-Gg: AYBFou1WiqpEb6mWEQRzB75cajE5li+4kEKQnr6HypoohDLb430gdhQTcAI2IvtYN0T
 20Eb/FcHtF4qYZSdT87tcas+AjYu9xjDhiC1INL5vjcizNxuBFCrDHKr6soS18tl+Q5zCJHMP7K
 k6dUW+GvPvx39cuRd7IZUdcqZD+JYRXQuz+YYjfUBKesOrST2K1dFxiKI24nEmEWh5zqk4yYpHP
 pfFOfsoDlga0US3PjpmsNg7DWiTtWLz4Qq/N726vs9/5Fb72mdozRf4dXtBFJ14RKW7m/P3q0gE
 eHkSgodQ9CO443X00Y3Bxds+JLiiyy42Z6HbiN/mgO/M0FV/kncnVS9GbDbjXmdqHfLlFyKNwkR
 cVKv5Zze0VX2CdTSOaPTfTJTcf13DaXy9UszQQ0oxzCQPogGAJNwxMhNqX+I=
X-Received: by 2002:a05:6a21:e8b:b0:3da:3492:83d0 with SMTP id
 adf61e73a8af0-3dd8c530321mr6618731637.23.1789759998108; 
 Fri, 18 Sep 2026 12:33:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:e8b:b0:3da:3492:83d0 with SMTP id
 adf61e73a8af0-3dd8c530321mr6618709637.23.1789759997580; 
 Fri, 18 Sep 2026 12:33:17 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33c3311a716sm810682eec.8.2026.09.18.12.33.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 12:33:16 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 3/3] tests/docker/docker.py: do not add-current-user if $UID ==
 0
Date: Fri, 18 Sep 2026 12:32:59 -0700
Message-ID: <20260918193259.704462-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918193259.704462-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260918193259.704462-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QNi7e3CZZI3ilN-vYmRPI_cqZlIDKoVh
X-Proofpoint-ORIG-GUID: QNi7e3CZZI3ilN-vYmRPI_cqZlIDKoVh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDI4MSBTYWx0ZWRfX57CE2XERJYzc
 TE0KSx/SOPlc4vBBXozPWFvHh617m+tZepTNRqJ4Sj5kqKQ1uiprVglQ2azVt1O1CvtrkuIZA90
 w4t3tAo8wo98rddNrn5IwCesUhzFkdhdFSiLSkAM4yaYDOR7ZGiZeEDK/ltAMyvVPYVK5dHmopL
 BmDDrFvli5zIL8uYlDEkm86OKTWDbsWlmc3DUOpzvRQDQoER+7e9qW8XxguksWvVUSUTL8pCjWh
 bAPwsWt05BPpwTEstaqzrEFo2KuMiXFT7K4CvAXuLrYjXonBmF/HZeNWffFxImEHVBMmhMUylAT
 ba+uctHINyVnyAVfV3iGzEb3J5apqyM8PniQX1yuiTOHWLtUIKWil18fL4RD4DG9phUvOhe4eY9
 U6/FlIZAcb/8vrBUpcu5GgT+1OCBgddl7lQjMWB4l9KMPyS61A2AQwBcvVkSRx676GKPPDUP6WS
 1asUcTJS4sxJfOMVZ6w==
X-Authority-Analysis: v=2.4 cv=ScRi5fRu c=1 sm=1 tr=0 ts=6aad91ff cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=-vN-UFzxm2gmQjGixjoA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDI4MSBTYWx0ZWRfXwVswhVvtoTco
 OsRc5mZtwTz3lixJo5aguUDAe276tN995q29kI/JTxVdaP/WbcBKfsaxawmt0URnGsGHkTLz8eY
 wyRX/I5cxSi+1rzq+qSuurIffOMO2yY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180281
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

root already exists, so this step fails with:
useradd: UID 0 is not unique

The setup where it happens is when working on QEMU using a dev container
with podman, with default root user being mapped to host user. In this
case, uid in container is 0 but effective uid on host is user's id.

Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260917221117.274619-4-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/docker/docker.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 7c15da59db6..80b1a5c6925 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -300,9 +300,10 @@ def build_image(self, tag, docker_dir, dockerfile,
 
         if user:
             uid = os.getuid()
-            uname = getpass.getuser()
-            build_args += ["--build-arg", "USER=%s" % uname,
-                           "--build-arg", "UID=%s" % uid]
+            if uid != 0:
+                uname = getpass.getuser()
+                build_args += ["--build-arg", "USER=%s" % uname,
+                               "--build-arg", "UID=%s" % uid]
 
         if registry is not None:
             pull_args = ["pull", "%s/%s" % (registry, tag)]
-- 
2.47.3


