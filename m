Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02873C61DD9
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05bV-0001Yl-S2; Fri, 28 Aug 2026 19:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bG-0000vC-In
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05bC-0006BW-CH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 19:03:06 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTVSQ1173247
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=QeWBktAU6S2
 oup2ejQFV23RQa+NzrG9ajGmawoBV5Og=; b=CO7g5erZnIOZf7ZfTdd0jYXPO8c
 1eeGXV9ppIRWxV3XbpEvY8Y0HyWW3kOObmGm8x5zYofxD9Rmm65exAQr3crC5V3z
 haEkoRfN8WRafTKB4aqxbmILr4qMDz+E3PL0IXlL8+JeZCaEKT1X8Rt40igdkkey
 D5S7zE9dnd7Sn1wjS+oj0RMC3SFJPZ9tToh5o23QXLxOCGgEGy4bI+sJYHQD0/CM
 M8srsOh6HqlPWU0DUhT399vekOVn0LKV4owKciWqI6wrTE/RdtpOeZAQSiMwLJOY
 bPtL6SXyWZ33Yt8G12IOu+1psXCtkeocK9mCT8yn0Il2LvRCWuAa8Sxkhdg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb8afjkgn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 23:03:00 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cf7dd9fd91so17962505ad.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 16:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787958180; x=1788562980; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QeWBktAU6S2oup2ejQFV23RQa+NzrG9ajGmawoBV5Og=;
 b=LD99vhJlMEABktkhYr+1DsY8wcFAcfZYa48HU8MyuhVHPv3s+N+gVUG++xRNd5prna
 DUGkZH+N58H5LgjnN2bnGXZcH9ocCZlhaFD/TeDpc1eQbiQGN1Xchyi9ok99ZxyulTCq
 VzDvxBEtuFGfGNZRF2tIIAVJTGewjKbUYaqHWn7Gg1SJSpdNt53QBst8r3wTZXRgz2p/
 PsqMHfXb5XAL4N95xFlFdYqbaMbCfOjUMg/VGu93m8DFWm/fF6VfYMsEIEZ0UK/nV/+i
 Nu3pb8PvEc4Mfhn1S5xxYK2u/H/ZWWIrSMJ1meCaTxz829MEdQwwvkywahEI6cpBr5UQ
 wuIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787958180; x=1788562980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QeWBktAU6S2oup2ejQFV23RQa+NzrG9ajGmawoBV5Og=;
 b=ITFlIpapJf9ZZ5CQ+RoOpQQoTNNcK6DQ7vYjUneR0VPxpmoVr7J1rj76HIeFJBhu2X
 EpD6NyWFe/wNFQPyHrZT8sD+tKEyICFItN+mN8GFrsL4kEdKbT72JPtcKfzc+K/rbsKu
 F10SCJjwQgVn7Jv/Q1X4HHtbsQLD2kkR3k+0sJAmRYDL5WfwSFzGR91BEWLYa5alv+F5
 GsLsDACM9HA/tYX9D0hRRbWDzcg3liK9iacW1mCW7OGGzfiKd/d/8uKn24/RPGkAwtWK
 z6nf0hc8/km/XniSNCw3q64I2g+EI7FA1yevkyMUq1c5xyH43PhuTCcMFQE+FsADBnFE
 0n/w==
X-Gm-Message-State: AFuF++mRFaCwnzcy/3VXeNY3YNVkPNj8CaWiFWTqcHGjytI44Kd5EykM
 0VflDFIC5FztsQAluksVwfZmx6/DlS9sFC5QJaymKTwoItnH4zi0DyiQI/WCroQPS4onae1dCnb
 e5YQzetKJ70k9qqUXZkf5NYQC5vD8CdbpdL8yhStq/T1IWtY3+LeYcjQAkvFLDfq9XQ==
X-Gm-Gg: AYBFou2IclfJHW3N17DQQkwwQmtwBFAzXzIyXMV3dtx11uVBAPHWdgXmfOiZwZuPhy4
 7m8rgkVXor59w0JfUe6uCcjSsgJ1YYcYZQL6ypiZoTFh/3XLgUiG/7rOervnf7wLMi2BHwqrVw5
 I/xEvqtossBw1jn3WbtjHAyjIylvsurDWC5ePkTqBDYhahxxvrmgdNh+adwoZu9Y+j+ckPq37B5
 nZvYf4kCd4DykDcLAy+BrBFDiI+nbXL9YKmp9aVJZYeykEFuH+sKprejGLJnkkX9GfniBuClWD1
 2cQ/a0+oxcot/aP9pghfj5+DQKU9JpdHprOymwne8n8ayw+NB5fvqKUh/zuljDPBpX+gTe9YQHu
 qz4UN/9CWXaULE2wdpwbWldGKXfn991CnzR+cbgRlp14Fguc9WnR8JEa4izg=
X-Received: by 2002:a17:903:324c:b0:2c2:62ee:5a0d with SMTP id
 d9443c01a7336-2d74df1c634mr202995645ad.14.1787958179970; 
 Fri, 28 Aug 2026 16:02:59 -0700 (PDT)
X-Received: by 2002:a17:903:324c:b0:2c2:62ee:5a0d with SMTP id
 d9443c01a7336-2d74df1c634mr202994215ad.14.1787958179208; 
 Fri, 28 Aug 2026 16:02:59 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3286f99585csm8448569eec.21.2026.08.28.16.02.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 16:02:58 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 40/47] hw/arm: filter arm machines
Date: Fri, 28 Aug 2026 22:58:54 +0000
Message-ID: <20260828225901.367438-41-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: FkzhLrAtbi0hsH-eChyPLoYCDHXrd92F
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXySSx4JX/biCs
 dZSDcwVXSRCJVn7O3DuhZZx0ykakFnYEilgxEPUanJFqk1xcoIlqqgvN0RqcPNleN7+xUJEiF7m
 7G88VPOkUlt1wbKYxDMFLyUQ64Nz9kI=
X-Authority-Analysis: v=2.4 cv=IPoyzAvG c=1 sm=1 tr=0 ts=6a9213a4 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=hFwvlY6mVM_t17AuBOgA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX9+L18iHK7VpO
 6RaIckc6rv2Zm53Td2CznKOpdIxBKCVtOaFKgZ+TbByvJMCf8waW63hRMsabeQ0MVEWmAI+cWFb
 aRuiWmsnE1RnMpxYmgM0qdw7IArTyyd5oddBH0Lqum/qEYEbs4mOTCqVn5xwkSxXw1SSSjmqwPf
 Rf2Qk+C26sa5q6lvJQlwEeiHMyCldgrxkOL8KTJoRz30OpW4FnFhwGd+MhZwPzrVxWuSv5C0X5H
 WXbrpBFMoWmUQ1Wbq3HsZ8W3vCUf02MiEZy0obe25AFj1Jy8nrN93eAKPYn5hpAhIckQNbxLZkC
 LSZPZkFuh7CbbLvMFDXdiFGFDIW/5Vqv8066X9AYAJrwsGgu4kS9M0PlwJTY47im6E4OR+3NFtC
 j6m+EvsH/OpTe8TsV3kxvpWiZzBXD3TUtPCBaZqH8zzTIzMOz63CN1yb2axjZlnhy6I8zu5G96N
 X/mwiJgS4O9btr4p2DQ==
X-Proofpoint-ORIG-GUID: FkzhLrAtbi0hsH-eChyPLoYCDHXrd92F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280200
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

This ensures those machines are not visible from other targets having a
different base architecture.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/aspeed_ast1040_evb.c               | 1 +
 hw/arm/aspeed_ast10x0_evb.c               | 2 ++
 hw/arm/aspeed_ast2400_palmetto.c          | 1 +
 hw/arm/aspeed_ast2400_quanta-q71l.c       | 1 +
 hw/arm/aspeed_ast2400_supermicrox11.c     | 1 +
 hw/arm/aspeed_ast2500_evb.c               | 1 +
 hw/arm/aspeed_ast2500_g220a.c             | 1 +
 hw/arm/aspeed_ast2500_romulus.c           | 1 +
 hw/arm/aspeed_ast2500_supermicro-x11spi.c | 1 +
 hw/arm/aspeed_ast2500_tiogapass.c         | 1 +
 hw/arm/aspeed_ast2500_witherspoon.c       | 1 +
 hw/arm/aspeed_ast2500_yosemitev2.c        | 1 +
 hw/arm/aspeed_ast2600_anacapa.c           | 1 +
 hw/arm/aspeed_ast2600_bletchley.c         | 1 +
 hw/arm/aspeed_ast2600_catalina.c          | 1 +
 hw/arm/aspeed_ast2600_evb.c               | 1 +
 hw/arm/aspeed_ast2600_fby35.c             | 1 +
 hw/arm/aspeed_ast2600_fuji.c              | 1 +
 hw/arm/aspeed_ast2600_gb200nvl.c          | 1 +
 hw/arm/aspeed_ast2600_rainier.c           | 1 +
 hw/arm/b-l475e-iot01a.c                   | 1 +
 hw/arm/bananapi_m2u.c                     | 2 +-
 hw/arm/collie.c                           | 1 +
 hw/arm/cubieboard.c                       | 2 +-
 hw/arm/digic_boards.c                     | 2 +-
 hw/arm/exynos4_boards.c                   | 2 ++
 hw/arm/imx25_pdk.c                        | 2 +-
 hw/arm/integratorcp.c                     | 2 +-
 hw/arm/kzm.c                              | 2 +-
 hw/arm/max78000fthr.c                     | 2 +-
 hw/arm/mcimx6ul-evk.c                     | 2 +-
 hw/arm/mcimx7d-sabre.c                    | 2 +-
 hw/arm/microbit.c                         | 1 +
 hw/arm/mps2-tz.c                          | 4 ++++
 hw/arm/mps2.c                             | 4 ++++
 hw/arm/mps3r.c                            | 1 +
 hw/arm/msf2-som.c                         | 2 +-
 hw/arm/musca.c                            | 2 ++
 hw/arm/musicpal.c                         | 2 +-
 hw/arm/netduino2.c                        | 2 +-
 hw/arm/netduinoplus2.c                    | 2 +-
 hw/arm/npcm7xx_boards.c                   | 5 +++++
 hw/arm/olimex-stm32-h405.c                | 3 ++-
 hw/arm/omap_sx1.c                         | 2 ++
 hw/arm/orangepi.c                         | 2 +-
 hw/arm/raspi.c                            | 3 +++
 hw/arm/realview.c                         | 4 ++++
 hw/arm/sabrelite.c                        | 1 +
 hw/arm/stellaris.c                        | 2 ++
 hw/arm/stm32vldiscovery.c                 | 3 ++-
 hw/arm/versatilepb.c                      | 2 ++
 hw/arm/vexpress.c                         | 2 ++
 hw/arm/virt.c                             | 1 +
 hw/arm/xilinx_zynq.c                      | 1 +
 54 files changed, 78 insertions(+), 16 deletions(-)

diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index 486f0f6a1ba..f8bdd22b5b7 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -80,6 +80,7 @@ static const TypeInfo aspeed_ast1040_evb_types[] = {
         .name           = MACHINE_TYPE_NAME("ast1040-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_machine_ast1040_evb_class_init,
+        .is_available   = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index c937bb74665..38a3dbb946d 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -118,10 +118,12 @@ static const TypeInfo aspeed_ast10x0_evb_types[] = {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
+        .is_available   = target_base_arm,
     }, {
         .name           = MACHINE_TYPE_NAME("ast1060-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1060_evb_class_init,
+        .is_available   = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index e2350e5b6ca..d4de48343d8 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -72,6 +72,7 @@ static const TypeInfo aspeed_ast2400_palmetto_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2400_quanta-q71l.c b/hw/arm/aspeed_ast2400_quanta-q71l.c
index e8cbbb8a052..2a34d7a5158 100644
--- a/hw/arm/aspeed_ast2400_quanta-q71l.c
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -78,6 +78,7 @@ static const TypeInfo aspeed_ast2400_quanta_q71l_types[] = {
         .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_quanta_q71l_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index c75898cc6d1..d45cee6ed76 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -73,6 +73,7 @@ static const TypeInfo aspeed_ast2400_supermicrox11_types[] = {
         .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
index 6ca2a36322c..7b46434bd93 100644
--- a/hw/arm/aspeed_ast2500_evb.c
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -59,6 +59,7 @@ static const TypeInfo aspeed_ast2500_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2500_evb_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
index 00bb1c61053..81181f49f19 100644
--- a/hw/arm/aspeed_ast2500_g220a.c
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -84,6 +84,7 @@ static const TypeInfo aspeed_ast2500_g220a_types[] = {
         .name          = MACHINE_TYPE_NAME("g220a-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_g220a_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
index 340a74408b6..680ea27279e 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -54,6 +54,7 @@ static const TypeInfo aspeed_ast2500_romulus_types[] = {
         .name          = MACHINE_TYPE_NAME("romulus-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_romulus_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index 5a7e49d6ccd..2b27c5791f5 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -69,6 +69,7 @@ static const TypeInfo aspeed_ast2500_supermicro_x11spi_types[] = {
         .name          = MACHINE_TYPE_NAME("supermicro-x11spi-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicro_x11spi_bmc_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index 6cb567526c4..6e611e65a44 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -82,6 +82,7 @@ static const TypeInfo aspeed_ast2500_tiogapass_types[] = {
         .name          = MACHINE_TYPE_NAME("tiogapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_tiogapass_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index 26ddb673470..acf5d19c2b1 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -104,6 +104,7 @@ static const TypeInfo aspeed_ast2500_witherspoon_types[] = {
         .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_witherspoon_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index 3ba1ed5f6fa..94066ddda2e 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -83,6 +83,7 @@ static const TypeInfo aspeed_ast2500_yosemitev2_types[] = {
         .name          = MACHINE_TYPE_NAME("yosemitev2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_yosemitev2_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index 697be58b0e4..4c1172a2c9e 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -367,6 +367,7 @@ static const TypeInfo aspeed_ast2600_anacapa_types[] = {
         .name          = MACHINE_TYPE_NAME("anacapa-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_anacapa_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index 2822f6bdf5a..f4579f12764 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -89,6 +89,7 @@ static const TypeInfo aspeed_ast2600_bletchley_types[] = {
         .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index 23636ab6985..4e79120d542 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -674,6 +674,7 @@ static const TypeInfo aspeed_ast2600_catalina_types[] = {
         .name          = MACHINE_TYPE_NAME("catalina-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_catalina_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index 8a17c4453e9..7e59e94c9e4 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -57,6 +57,7 @@ static const TypeInfo aspeed_ast2600_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index 65d98fafec6..6c17999fa14 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -170,6 +170,7 @@ static const TypeInfo aspeed_ast2600_fby35_types[] = {
         .name          = MACHINE_TYPE_NAME("fby35-bmc"),
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
         .class_init    = aspeed_machine_fby35_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 8a87c2dbee3..84b96a4d108 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -132,6 +132,7 @@ static const TypeInfo aspeed_ast2600_fuji_types[] = {
         .name          = MACHINE_TYPE_NAME("fuji-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fuji_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
index 311feb82023..47eb53dd912 100644
--- a/hw/arm/aspeed_ast2600_gb200nvl.c
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -103,6 +103,7 @@ static const TypeInfo aspeed_ast2600_gb200nvl_types[] = {
         .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_gb200nvl_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 43a8f01a9e7..4e000ae98b1 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -190,6 +190,7 @@ static const TypeInfo aspeed_ast2600_rainier_types[] = {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_rainier_class_init,
+        .is_available  = target_base_arm,
     }
 };
 
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index de19212ab85..1b93eb1b30f 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -131,6 +131,7 @@ static const TypeInfo bl475e_machine_type[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(Bl475eMachineState),
         .class_init     = bl475e_machine_init,
+        .is_available   = target_base_arm,
     }
 };
 
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 7b86986efb1..c72e55d6f18 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -153,4 +153,4 @@ static void bpim2u_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
-                        bpim2u_machine_init, false, NULL, NULL)
+                        bpim2u_machine_init, false, target_base_arm, NULL)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index ca6b3addb7b..a849c04b86e 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -84,6 +84,7 @@ static const TypeInfo collie_machine_typeinfo = {
     .parent = TYPE_MACHINE,
     .class_init = collie_machine_class_init,
     .instance_size = sizeof(CollieMachineState),
+    .is_available = target_base_arm,
 };
 
 static void collie_machine_register_types(void)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index da45bb2be52..929d4c8267f 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -134,4 +134,4 @@ static void cubieboard_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
                         cubieboard_machine_init, false,
-                        NULL, NULL)
+                        target_base_arm, NULL)
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index 5fd7ed5dc42..e600a647d62 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -145,4 +145,4 @@ static void canon_a1100_machine_init(MachineClass *mc)
     mc->default_ram_id = "ram";
 }
 
-DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init, NULL)
+DEFINE_MACHINE("canon-a1100", canon_a1100_machine_init, target_base_arm)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 78632877df8..f45bd419fb5 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -168,6 +168,7 @@ static const TypeInfo nuri_type = {
     .name = MACHINE_TYPE_NAME("nuri"),
     .parent = TYPE_MACHINE,
     .class_init = nuri_class_init,
+    .is_available = target_base_arm,
 };
 
 static void smdkc210_class_init(ObjectClass *oc, const void *data)
@@ -188,6 +189,7 @@ static const TypeInfo smdkc210_type = {
     .name = MACHINE_TYPE_NAME("smdkc210"),
     .parent = TYPE_MACHINE,
     .class_init = smdkc210_class_init,
+    .is_available = target_base_arm,
 };
 
 static void exynos4_machines_init(void)
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 50e53585447..03f1fd5078e 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -149,4 +149,4 @@ static void imx25_pdk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init, NULL)
+DEFINE_MACHINE("imx25-pdk", imx25_pdk_machine_init, target_base_arm)
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 6314bbb6c13..d575c8856e2 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -705,7 +705,7 @@ static void integratorcp_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
                         integratorcp_machine_init, false,
-                        NULL, NULL)
+                        target_base_arm, NULL)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 2353e73b243..aabc38c6052 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -137,4 +137,4 @@ static void kzm_machine_init(MachineClass *mc)
     mc->default_ram_id = "kzm.ram";
 }
 
-DEFINE_MACHINE("kzm", kzm_machine_init, NULL)
+DEFINE_MACHINE("kzm", kzm_machine_init, target_base_arm)
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index a182e1379b9..b5e46da1444 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -47,4 +47,4 @@ static void max78000_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("max78000fthr", max78000_machine_init, NULL)
+DEFINE_MACHINE("max78000fthr", max78000_machine_init, target_base_arm)
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index f7e654b6228..eb9215f5225 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -77,4 +77,4 @@ static void mcimx6ul_evk_machine_init(MachineClass *mc)
     mc->auto_create_sdcard = true;
 }
 
-DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init, NULL)
+DEFINE_MACHINE("mcimx6ul-evk", mcimx6ul_evk_machine_init, target_base_arm)
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 2c884b5c78f..84b293c256a 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -87,4 +87,4 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
                         mcimx7d_sabre_machine_init, false,
-                        NULL, NULL)
+                        target_base_arm, NULL)
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index c1a3f6903fe..e82ed9901d6 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -74,6 +74,7 @@ static const TypeInfo microbit_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(MicrobitMachineState),
     .class_init = microbit_machine_class_init,
+    .is_available = target_base_arm,
 };
 
 static void microbit_machine_init(void)
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index d767207e2e1..4f9a5dfe53b 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1484,24 +1484,28 @@ static const TypeInfo mps2tz_an505_info = {
     .name = TYPE_MPS2TZ_AN505_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an505_class_init,
+    .is_available = target_base_arm,
 };
 
 static const TypeInfo mps2tz_an521_info = {
     .name = TYPE_MPS2TZ_AN521_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an521_class_init,
+    .is_available = target_base_arm,
 };
 
 static const TypeInfo mps3tz_an524_info = {
     .name = TYPE_MPS3TZ_AN524_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an524_class_init,
+    .is_available = target_base_arm,
 };
 
 static const TypeInfo mps3tz_an547_info = {
     .name = TYPE_MPS3TZ_AN547_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an547_class_init,
+    .is_available = target_base_arm,
 };
 
 static void mps2tz_machine_init(void)
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 35d867328a9..d721cc1a436 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -567,24 +567,28 @@ static const TypeInfo mps2_an385_info = {
     .name = TYPE_MPS2_AN385_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an385_class_init,
+    .is_available = target_base_arm,
 };
 
 static const TypeInfo mps2_an386_info = {
     .name = TYPE_MPS2_AN386_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an386_class_init,
+    .is_available = target_base_arm,
 };
 
 static const TypeInfo mps2_an500_info = {
     .name = TYPE_MPS2_AN500_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an500_class_init,
+    .is_available = target_base_arm,
 };
 
 static const TypeInfo mps2_an511_info = {
     .name = TYPE_MPS2_AN511_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an511_class_init,
+    .is_available = target_base_arm,
 };
 
 static void mps2_machine_init(void)
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index eedb877e4bc..0f78cb6ccfb 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -634,6 +634,7 @@ static const TypeInfo mps3r_machine_types[] = {
         .name = TYPE_MPS3R_AN536_MACHINE,
         .parent = TYPE_MPS3R_MACHINE,
         .class_init = mps3r_an536_class_init,
+        .is_available = target_base_arm,
     },
 };
 
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 92f36ce3785..f8f188574cb 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -108,4 +108,4 @@ static void emcraft_sf2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init, NULL)
+DEFINE_MACHINE("emcraft-sf2", emcraft_sf2_machine_init, target_base_arm)
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 571bee1b72b..67cfd92f279 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -657,12 +657,14 @@ static const TypeInfo musca_a_info = {
     .name = TYPE_MUSCA_A_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_a_class_init,
+    .is_available = target_base_arm,
 };
 
 static const TypeInfo musca_b1_info = {
     .name = TYPE_MUSCA_B1_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_b1_class_init,
+    .is_available = target_base_arm,
 };
 
 static void musca_machine_init(void)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 52805e41892..4720377629d 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1365,7 +1365,7 @@ static void musicpal_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("musicpal", MACHINE, MusicPalMachineState,
                         musicpal_machine_init, false,
-                        NULL, NULL)
+                        target_base_arm, NULL)
 
 static void mv88w8618_wlan_class_init(ObjectClass *klass, const void *data)
 {
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 47e9e55213c..bb16dec169c 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -65,4 +65,4 @@ static void netduino2_machine_init(MachineClass *mc)
     mc->ignore_memory_transaction_failures = true;
 }
 
-DEFINE_MACHINE("netduino2", netduino2_machine_init, NULL)
+DEFINE_MACHINE("netduino2", netduino2_machine_init, target_base_arm)
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index 40701f47f09..47cef82fda6 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -65,4 +65,4 @@ static void netduinoplus2_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init, NULL)
+DEFINE_MACHINE("netduinoplus2", netduinoplus2_machine_init, target_base_arm)
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 9c526a26839..6c4297b4a0f 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -549,22 +549,27 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm750-evb"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = npcm750_evb_machine_class_init,
+        .is_available   = target_base_arm,
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gsj"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gsj_machine_class_init,
+        .is_available   = target_base_arm,
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gbs-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gbs_bmc_machine_class_init,
+        .is_available   = target_base_arm,
     }, {
         .name           = MACHINE_TYPE_NAME("kudo-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = kudo_bmc_machine_class_init,
+        .is_available   = target_base_arm,
     }, {
         .name           = MACHINE_TYPE_NAME("mori-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = mori_bmc_machine_class_init,
+        .is_available   = target_base_arm,
     },
 };
 
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 4630f78617b..eed4e387f5e 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -71,4 +71,5 @@ static void olimex_stm32_h405_machine_init(MachineClass *mc)
     mc->default_ram_size = 0;
 }
 
-DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init, NULL)
+DEFINE_MACHINE("olimex-stm32-h405", olimex_stm32_h405_machine_init,
+               target_base_arm)
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index a7e469ea6a3..de70f21aa77 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -225,6 +225,7 @@ static const TypeInfo sx1_machine_v2_type = {
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
     .instance_size = sizeof(Sx1MachineState),
+    .is_available = target_base_arm,
 };
 
 static void sx1_machine_v1_class_init(ObjectClass *oc, const void *data)
@@ -245,6 +246,7 @@ static const TypeInfo sx1_machine_v1_type = {
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
     .instance_size = sizeof(Sx1MachineState),
+    .is_available = target_base_arm,
 };
 
 static void sx1_machine_init(void)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 87ed2ef4b69..dada6d95417 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -134,4 +134,4 @@ static void orangepi_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
                         orangepi_machine_init, false,
-                        NULL, NULL)
+                        target_base_arm, NULL)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index fadbacb2534..9c223efaa3f 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -391,14 +391,17 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi0"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi0_machine_class_init,
+        .is_available   = target_base_arm,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi1ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi1ap_machine_class_init,
+        .is_available   = target_base_arm,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
+        .is_available   = target_base_arm,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index ceba0331b08..63f0a9bcbaa 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -436,6 +436,7 @@ static const TypeInfo realview_eb_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
     .instance_size = sizeof(RealViewMachineState),
+    .is_available = target_base_arm,
 };
 
 static void realview_eb_mpcore_class_init(ObjectClass *oc, const void *data)
@@ -458,6 +459,7 @@ static const TypeInfo realview_eb_mpcore_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
     .instance_size = sizeof(RealViewMachineState),
+    .is_available = target_base_arm,
 };
 
 static void realview_pb_a8_class_init(ObjectClass *oc, const void *data)
@@ -478,6 +480,7 @@ static const TypeInfo realview_pb_a8_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
     .instance_size = sizeof(RealViewMachineState),
+    .is_available = target_base_arm,
 };
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, const void *data)
@@ -499,6 +502,7 @@ static const TypeInfo realview_pbx_a9_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
     .instance_size = sizeof(RealViewMachineState),
+    .is_available = target_base_arm,
 };
 
 static void realview_machine_init(void)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 05dfabd9376..57c2fda362e 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -151,6 +151,7 @@ static const TypeInfo sabrelite_machine_init_typeinfo = {
     .instance_init = sabrelite_machine_instance_init,
     .instance_size = sizeof(SabreliteMachineState),
     .abstract      = false,
+    .is_available  = target_base_arm,
 };
 
 static void sabrelite_machine_init_register_types(void)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index f41315e1928..5c13a29b95e 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1427,6 +1427,7 @@ static const TypeInfo lm3s811evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s811evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s811evb_class_init,
+    .is_available = target_base_arm,
 };
 
 /*
@@ -1448,6 +1449,7 @@ static const TypeInfo lm3s6965evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s6965evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s6965evb_class_init,
+    .is_available = target_base_arm,
 };
 
 static void stellaris_machine_init(void)
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 35c16bda411..4bab9340942 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -68,4 +68,5 @@ static void stm32vldiscovery_machine_init(MachineClass *mc)
     mc->valid_cpu_types = valid_cpu_types;
 }
 
-DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init, NULL)
+DEFINE_MACHINE("stm32vldiscovery", stm32vldiscovery_machine_init,
+               target_base_arm)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index f94bf96599e..c75448f12b7 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -437,6 +437,7 @@ static const TypeInfo versatilepb_type = {
     .parent = TYPE_MACHINE,
     .class_init = versatilepb_class_init,
     .instance_size = sizeof(VersatileMachineState),
+    .is_available = target_base_arm,
 };
 
 static void versatileab_class_init(ObjectClass *oc, const void *data)
@@ -459,6 +460,7 @@ static const TypeInfo versatileab_type = {
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
     .instance_size = sizeof(VersatileMachineState),
+    .is_available = target_base_arm,
 };
 
 static void versatile_machine_init(void)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 914cda66d20..a75a80f38b5 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -849,6 +849,7 @@ static const TypeInfo vexpress_a9_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a9_class_init,
     .instance_init = vexpress_a9_instance_init,
+    .is_available = target_base_arm,
 };
 
 static const TypeInfo vexpress_a15_info = {
@@ -856,6 +857,7 @@ static const TypeInfo vexpress_a15_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a15_class_init,
     .instance_init = vexpress_a15_instance_init,
+    .is_available = target_base_arm,
 };
 
 static void vexpress_machine_init(void)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 0871a35e11f..583b5edf9a6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -132,6 +132,7 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
+        .is_available = target_base_arm, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index c1897ab1cf3..d18b6b1cd8c 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -478,6 +478,7 @@ static const TypeInfo zynq_machine_type = {
     .parent = TYPE_MACHINE,
     .class_init = zynq_machine_class_init,
     .instance_size = sizeof(ZynqMachineState),
+    .is_available = target_base_arm,
 };
 
 static void zynq_machine_register_types(void)
-- 
2.43.0


