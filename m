Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9415C61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:22:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1Uyg-0002Ls-6F; Tue, 01 Sep 2026 16:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uye-0002LL-IB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1Uya-0003W6-Om
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:21:04 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HgUoS3980169
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8Mic+2tGgxf
 LrwI4Aux1L89urCmZE/ag52lyadCFB8o=; b=RQpTTuslG6++WUCrBLomnFMFlaT
 tQQWK4V1z9yuZ/qtIKy/Rmkmzpxs0rGJ3xNQO+eUKq6zgLXOFRHI63eQq7+Yqo02
 7h2ZYs85Wn6y7ZgvBpwtGgenVwncMZGUDS/WwfBme8KitygqyzGBiHf71VleH3er
 gbT/1wYL8RPSYHQbZfnRcvCW2C7F51UxqXSWFZsW+uz91EErUfCdS0Jwk+ncwAvJ
 3BzBNJqZ/G5ZC5YX6b+m5XVKU5En0bYJvcmZOeuqrqUMzRl69KR2Vk6IQoZUhQPk
 u6w4zRXS+3BERlCdb0q8j8By5onsfI+xvbNldEYgCyWo7Co8MCeWeg4MH1A==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdy9nj5eg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:20:59 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbb467e56aaso246475a12.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294059; x=1788898859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8Mic+2tGgxfLrwI4Aux1L89urCmZE/ag52lyadCFB8o=;
 b=QHJom1BkNccRct+Mky/vPUunA6EKni7WQuw7rKxzt4andSwPZPfjlAyucmECl/LgRw
 2aEbo/Z44IniILY92WTZu8h8wAGck0NDNh4bMdqePUGKzKceS6vYasJVq198vVI/L8Bm
 lkLogowlL6Dn2sRlRhNIPmpj20wVM6u4t4Eqllssib4wmuzIZqmyCIKJvr3RYIxKI0U9
 lCZQkmoNHgVFv0HN7x+TcVrOhQ5lcY7FhEcmRFXgfYkcreH4w4ALJRXj1DnwQ7+MuZY3
 vdCOTb0QUucqxHHxkkcI11sZeJguipOG0UmfwcvJPLHCVl1YBYSJYjdKQpjSle/hQgsW
 j+Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294059; x=1788898859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8Mic+2tGgxfLrwI4Aux1L89urCmZE/ag52lyadCFB8o=;
 b=MQuf9ZfP97pjwbKyMB24UEh0Zd2dq3YlY9+KkXD3T/er531UDPh3C81Vu1ON5aR96S
 a5ZXbFATCt1z0f23bo1+yXMcdTkL1RcDWeAItDO4NF6jBQMk86CmJoUVGDyM2cLwy2gD
 uRWX+5zjRjpBPVzQgqf65OclsdFJgMJiGa22+Km2hXvL8lYF9Nsm9ygG0x8MMfNdj26W
 q1PSDAXR8wUVZEsiCc50mlgGnBM+D/B3Vr/y7izgQHpkB4+ArhnysTAS3XEh3j8hfWQj
 4LV/xAkgWId9Z2ChUPFgRrcCGBWjnSDxhztRzhuhE7wfSypcEyJqiVG1Fs7FpntLGyT8
 IH6g==
X-Gm-Message-State: AFuF++nzWWhc17htRW7OALLRNfjZ6XJD5KjsPYGzHbn1/BXO2QlOpb07
 aAk/3Pws9SCcSD/RXe+tTSjLf5aIAljm9O/3dcZ1IYu6ydLdZmotXtz5J6H6FYSOAv3EMYSDh/x
 cJIOrEairipItWkDHoO6ugG5CfmJv6bw0BNVWPPOyPZIagKcRG1VrBH30qhsvpqlTdg==
X-Gm-Gg: AYBFou34r631gpwEROOQ82XS4D9NqjAtCHkHGV9/PKs9lYtWwBqI5vBUs22zfA9Mma3
 AseLY0NpXiYqLZ0hoU5RudtUcCh7hu46UDClQqPRgno4WjUT9N7c+On/kNsUMwErN/RE6SCHxvq
 n2EozftwGg4mqzLVnMB6+VhBY4Fj5E1Pu0tZDF1qg2X2a12ck94rjMBgTvSi8YdfuGoahaB5xSv
 DahNp/sUWxrBcJAQRDSTMYOX59hg81CElICtLnij6oGK6vqiadYYml0NxIZWB/vcDa6SZWormNi
 LI0eOw1DShhUrahtIZ5526yIqhIZ6o2E/mGR69Lq+2FUQpYc1ypSIbra26D5j/8mZIplmEtDduA
 TYddgfytdCQOAdxSjLVkJszkAySadRSyWzxyMNIUMA5VK1udgzw0/Tq1sMRg=
X-Received: by 2002:a17:90b:5827:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-39907d6909fmr17724756a91.14.1788294058424; 
 Tue, 01 Sep 2026 13:20:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5827:b0:381:11eb:d78e with SMTP id
 98e67ed59e1d1-39907d6909fmr17724603a91.14.1788294057575; 
 Tue, 01 Sep 2026 13:20:57 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d7bb9d7sm7734802a91.15.2026.09.01.13.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 13:20:56 -0700 (PDT)
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 08/14] hw/arm: remove {arm, arm_aarch64,
 aarch64}_machine_interfaces
Date: Tue,  1 Sep 2026 20:20:37 +0000
Message-ID: <20260901202043.26532-9-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX2K0xClaEiyVX
 dsGkqwUMzn8dAQ/qBFZlX/9b0XR6yYWHGWY3Am8xKit486Hj+vjgNrefLFOut59vTZ/5romRhjm
 iE4/JjDgnWXEk19bMO0xFC5gN4AHFRw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OCBTYWx0ZWRfX4VVYSFhU0dvP
 SIp8rIVtvluV173T38pHBbWnD/PjlFfmKhIF/Xis5zzdea07nK2fpY4WaWNdhMQ9kH/muENkLDw
 6brkED5pfqytpG8O6/57QQu67bZc70vPtfLc//7VLTRPkSb7yMO6D1MnI2E+2zriTybVJZiVPBt
 VkVUZ3RRaewpI1czEmMs7jzCTW7lQqKNJZczjmhHueLtCauhXWH2ox//fxg70ughzhITF4wFBXD
 Fz9+LJA2AWOlmEl1AnCpFc6qQ+4r5cG3BGciPIRQ9Qp8T3/ydCCJK6CZqpKZOFtZ3jc+p8MK5U8
 VEgMSHqPr2rVxjnx/gN9SP9AS+4wh9N4T9a0NbBI/Kju7iNz3r/V4/6tta/H8ICnJKeCWZ1Z3n5
 N1qo6vtrOpLIRk32jXb6EWV7bRMGlcBrDc4wPA+dqIV250CB+ku9fG4Ot2Chyfb2Dsv0oTPKxKx
 C5jdKDLl4C5kHE/GzJg==
X-Authority-Analysis: v=2.4 cv=e/02j6p/ c=1 sm=1 tr=0 ts=6a9733ab cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=7joVoiQZOSCGeONO0vcA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-ORIG-GUID: XpSmeI3BBxzfYBAqZ5fjdbnUoJ8xSW0y
X-Proofpoint-GUID: XpSmeI3BBxzfYBAqZ5fjdbnUoJ8xSW0y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609010178
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
Reply-to:  Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
From:  Pierrick Bouvier via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

We can now remove those arrays.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/aspeed_ast1040_evb.c               |  1 -
 hw/arm/aspeed_ast10x0_evb.c               |  2 --
 hw/arm/aspeed_ast2400_palmetto.c          |  1 -
 hw/arm/aspeed_ast2400_quanta-q71l.c       |  1 -
 hw/arm/aspeed_ast2400_supermicrox11.c     |  1 -
 hw/arm/aspeed_ast2500_evb.c               |  1 -
 hw/arm/aspeed_ast2500_g220a.c             |  1 -
 hw/arm/aspeed_ast2500_romulus.c           |  1 -
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |  1 -
 hw/arm/aspeed_ast2500_tiogapass.c         |  1 -
 hw/arm/aspeed_ast2500_witherspoon.c       |  1 -
 hw/arm/aspeed_ast2500_yosemitev2.c        |  1 -
 hw/arm/aspeed_ast2600_anacapa.c           |  1 -
 hw/arm/aspeed_ast2600_bletchley.c         |  1 -
 hw/arm/aspeed_ast2600_catalina.c          |  1 -
 hw/arm/aspeed_ast2600_evb.c               |  1 -
 hw/arm/aspeed_ast2600_fby35.c             |  1 -
 hw/arm/aspeed_ast2600_fuji.c              |  1 -
 hw/arm/aspeed_ast2600_gb200nvl.c          |  1 -
 hw/arm/aspeed_ast2600_rainier.c           |  1 -
 hw/arm/aspeed_ast27x0-fc.c                |  1 -
 hw/arm/aspeed_ast27x0_evb.c               |  2 --
 hw/arm/ax3000-boards.c                    |  1 -
 hw/arm/b-l475e-iot01a.c                   |  1 -
 hw/arm/bananapi_m2u.c                     |  2 +-
 hw/arm/collie.c                           |  1 -
 hw/arm/cubieboard.c                       |  2 +-
 hw/arm/exynos4_boards.c                   |  2 --
 hw/arm/imx8mm-evk.c                       |  2 +-
 hw/arm/imx8mp-evk.c                       |  1 -
 hw/arm/integratorcp.c                     |  2 +-
 hw/arm/mcimx7d-sabre.c                    |  2 +-
 hw/arm/microbit.c                         |  1 -
 hw/arm/mps2-tz.c                          |  4 ----
 hw/arm/mps2.c                             |  4 ----
 hw/arm/mps3r.c                            |  1 -
 hw/arm/musca.c                            |  2 --
 hw/arm/musicpal.c                         |  2 +-
 hw/arm/npcm7xx_boards.c                   |  5 -----
 hw/arm/npcm8xx_boards.c                   |  1 -
 hw/arm/omap_sx1.c                         |  2 --
 hw/arm/orangepi.c                         |  2 +-
 hw/arm/raspi.c                            |  5 -----
 hw/arm/raspi4b.c                          |  1 -
 hw/arm/realview.c                         |  4 ----
 hw/arm/sabrelite.c                        |  1 -
 hw/arm/sbsa-ref.c                         |  1 -
 hw/arm/stellaris.c                        |  2 --
 hw/arm/versatilepb.c                      |  2 --
 hw/arm/vexpress.c                         |  2 --
 hw/arm/virt.c                             |  1 -
 hw/arm/xen-pvh.c                          |  1 -
 hw/arm/xilinx_zynq.c                      |  1 -
 hw/arm/xlnx-versal-virt.c                 |  2 --
 hw/arm/xlnx-zcu102.c                      |  1 -
 include/hw/arm/machines-qom.h             | 16 ++--------------
 target/arm/machine.c                      | 12 ------------
 57 files changed, 9 insertions(+), 107 deletions(-)

diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index 2b93d4dfbc5..dd68f9e25c7 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -81,7 +81,6 @@ static const TypeInfo aspeed_ast1040_evb_types[] = {
         .name           = MACHINE_TYPE_NAME("ast1040-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_machine_ast1040_evb_class_init,
-        .interfaces     = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index c19563d1f0a..f377e955adc 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -119,12 +119,10 @@ static const TypeInfo aspeed_ast10x0_evb_types[] = {
         .name           = MACHINE_TYPE_NAME("ast1030-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1030_evb_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("ast1060-evb"),
         .parent         = TYPE_ASPEED_MACHINE,
         .class_init     = aspeed_minibmc_machine_ast1060_evb_class_init,
-        .interfaces     = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index 776aa43a45d..f4918683c3d 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -73,7 +73,6 @@ static const TypeInfo aspeed_ast2400_palmetto_types[] = {
         .name          = MACHINE_TYPE_NAME("palmetto-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_palmetto_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2400_quanta-q71l.c b/hw/arm/aspeed_ast2400_quanta-q71l.c
index 42ad2a2303f..e1ddf682315 100644
--- a/hw/arm/aspeed_ast2400_quanta-q71l.c
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -79,7 +79,6 @@ static const TypeInfo aspeed_ast2400_quanta_q71l_types[] = {
         .name          = MACHINE_TYPE_NAME("quanta-q71l-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_quanta_q71l_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index 88cdb01fc76..86d49fd1dee 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -74,7 +74,6 @@ static const TypeInfo aspeed_ast2400_supermicrox11_types[] = {
         .name          = MACHINE_TYPE_NAME("supermicrox11-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicrox11_bmc_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
index 8b5cb67be9b..5f616252e0b 100644
--- a/hw/arm/aspeed_ast2500_evb.c
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -60,7 +60,6 @@ static const TypeInfo aspeed_ast2500_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2500-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2500_evb_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
index 3f979a78e57..3c654c62dd6 100644
--- a/hw/arm/aspeed_ast2500_g220a.c
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -85,7 +85,6 @@ static const TypeInfo aspeed_ast2500_g220a_types[] = {
         .name          = MACHINE_TYPE_NAME("g220a-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_g220a_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
index 91b660e74bb..b2ed623f680 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -55,7 +55,6 @@ static const TypeInfo aspeed_ast2500_romulus_types[] = {
         .name          = MACHINE_TYPE_NAME("romulus-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_romulus_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index a2450aa9623..77fa028b096 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -70,7 +70,6 @@ static const TypeInfo aspeed_ast2500_supermicro_x11spi_types[] = {
         .name          = MACHINE_TYPE_NAME("supermicro-x11spi-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_supermicro_x11spi_bmc_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index 186dbc1da30..1771f376480 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -83,7 +83,6 @@ static const TypeInfo aspeed_ast2500_tiogapass_types[] = {
         .name          = MACHINE_TYPE_NAME("tiogapass-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_tiogapass_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index 28d437fec08..4cc349c3236 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -105,7 +105,6 @@ static const TypeInfo aspeed_ast2500_witherspoon_types[] = {
         .name          = MACHINE_TYPE_NAME("witherspoon-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_witherspoon_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index eaa75bcccbb..48c813f3c8f 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -84,7 +84,6 @@ static const TypeInfo aspeed_ast2500_yosemitev2_types[] = {
         .name          = MACHINE_TYPE_NAME("yosemitev2-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_yosemitev2_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index 65d6b0faa2d..e82f5c98f26 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -368,7 +368,6 @@ static const TypeInfo aspeed_ast2600_anacapa_types[] = {
         .name          = MACHINE_TYPE_NAME("anacapa-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_anacapa_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index b7e84db1438..9dda83ad4c0 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -90,7 +90,6 @@ static const TypeInfo aspeed_ast2600_bletchley_types[] = {
         .name          = MACHINE_TYPE_NAME("bletchley-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_bletchley_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index f714c9d1b32..f91e0635908 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -675,7 +675,6 @@ static const TypeInfo aspeed_ast2600_catalina_types[] = {
         .name          = MACHINE_TYPE_NAME("catalina-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_catalina_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index c43d2687c1c..404083b61dc 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -58,7 +58,6 @@ static const TypeInfo aspeed_ast2600_evb_types[] = {
         .name          = MACHINE_TYPE_NAME("ast2600-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2600_evb_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index f6244270704..6bcda0ac630 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -171,7 +171,6 @@ static const TypeInfo aspeed_ast2600_fby35_types[] = {
         .name          = MACHINE_TYPE_NAME("fby35-bmc"),
         .parent        = MACHINE_TYPE_NAME("ast2600-evb"),
         .class_init    = aspeed_machine_fby35_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index 37db252e276..cf49149fe9a 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -133,7 +133,6 @@ static const TypeInfo aspeed_ast2600_fuji_types[] = {
         .name          = MACHINE_TYPE_NAME("fuji-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_fuji_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
index ad9a10110b8..705561afe39 100644
--- a/hw/arm/aspeed_ast2600_gb200nvl.c
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -104,7 +104,6 @@ static const TypeInfo aspeed_ast2600_gb200nvl_types[] = {
         .name          = MACHINE_TYPE_NAME("gb200nvl-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_gb200nvl_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 8f0a412ddcf..6e5debc8bc1 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -191,7 +191,6 @@ static const TypeInfo aspeed_ast2600_rainier_types[] = {
         .name          = MACHINE_TYPE_NAME("rainier-bmc"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_rainier_class_init,
-        .interfaces    = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index 54230aa92e6..ccfa4ade265 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -236,7 +236,6 @@ static const TypeInfo ast2700fc_types[] = {
         .class_init     = ast2700fc_class_init,
         .instance_size  = sizeof(Ast2700FCState),
         .is_available   = target_aarch64,
-        .interfaces     = aarch64_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 2b767808e12..0deb3127c21 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -77,14 +77,12 @@ static const TypeInfo aspeed_ast27x0_evb_types[] = {
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a1_evb_class_init,
         .is_available  = target_aarch64,
-        .interfaces    = aarch64_machine_interfaces,
     },
     {
         .name          = MACHINE_TYPE_NAME("ast2700a2-evb"),
         .parent        = TYPE_ASPEED_MACHINE,
         .class_init    = aspeed_machine_ast2700a2_evb_class_init,
         .is_available  = target_aarch64,
-        .interfaces    = aarch64_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index 4b8deec15cf..c7248f9f52b 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -48,7 +48,6 @@ static const TypeInfo ax3000_machine_types[] = {
         .instance_size = sizeof(Ax3000MachineState),
         .class_size    = sizeof(Ax3000MachineClass),
         .class_init    = ax3000_machine_class_init,
-        .interfaces    = aarch64_machine_interfaces,
         .abstract      = true,
     }
 };
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index ee789c8df94..04dce2d19ce 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -132,7 +132,6 @@ static const TypeInfo bl475e_machine_type[] = {
         .parent         = TYPE_MACHINE,
         .instance_size  = sizeof(Bl475eMachineState),
         .class_init     = bl475e_machine_init,
-        .interfaces     = arm_machine_interfaces,
     }
 };
 
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 0079aa1dd2b..15c878d1636 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -154,4 +154,4 @@ static void bpim2u_machine_init(MachineClass *mc)
 }
 
 DEFINE_MACHINE_EXTENDED("bpim2u", MACHINE, Bpim2uMachineState,
-                        bpim2u_machine_init, false, arm_machine_interfaces)
+                        bpim2u_machine_init, false, NULL)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 01d74ad38cd..4b930e6ba12 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -85,7 +85,6 @@ static const TypeInfo collie_machine_typeinfo = {
     .parent = TYPE_MACHINE,
     .class_init = collie_machine_class_init,
     .instance_size = sizeof(CollieMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void collie_machine_register_types(void)
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index d59c1ebba7f..511b71fbd7e 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -135,4 +135,4 @@ static void cubieboard_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("cubieboard", MACHINE, CubieboardMachineState,
                         cubieboard_machine_init, false,
-                        arm_machine_interfaces)
+                        NULL)
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index b7decdb2c7f..62f7cbe875e 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -169,7 +169,6 @@ static const TypeInfo nuri_type = {
     .name = MACHINE_TYPE_NAME("nuri"),
     .parent = TYPE_MACHINE,
     .class_init = nuri_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void smdkc210_class_init(ObjectClass *oc, const void *data)
@@ -190,7 +189,6 @@ static const TypeInfo smdkc210_type = {
     .name = MACHINE_TYPE_NAME("smdkc210"),
     .parent = TYPE_MACHINE,
     .class_init = smdkc210_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void exynos4_machines_init(void)
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index 019c609c542..ffe8e494a57 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -136,4 +136,4 @@ static void imx8mm_evk_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("imx8mm-evk", MACHINE, Imx8mmEvkMachineState,
                         imx8mm_evk_machine_init, false,
-                        aarch64_machine_interfaces)
+                        NULL)
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 16e9722d146..389e7c86d21 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -162,7 +162,6 @@ static const TypeInfo imx8mp_evk_machine_types[] = {
         .class_init = imx8mp_evk_machine_class_init,
         .instance_init = imx8mp_evk_machine_init,
         .instance_size = sizeof(FslImx8mpEvkState),
-        .interfaces = aarch64_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index f8bcf42c615..25ecd931e76 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -706,7 +706,7 @@ static void integratorcp_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("integratorcp", MACHINE, IntegratorcpMachineState,
                         integratorcp_machine_init, false,
-                        arm_machine_interfaces)
+                        NULL)
 
 static const Property core_properties[] = {
     DEFINE_PROP_UINT32("memsz", IntegratorCMState, memsz, 0),
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index 22fe1fa932f..cb4536faadd 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -88,4 +88,4 @@ static void mcimx7d_sabre_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("mcimx7d-sabre", MACHINE, Mcimx7dSabreMachineState,
                         mcimx7d_sabre_machine_init, false,
-                        arm_machine_interfaces)
+                        NULL)
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 9d5c4898469..85285861c5f 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -75,7 +75,6 @@ static const TypeInfo microbit_info = {
     .parent = TYPE_MACHINE,
     .instance_size = sizeof(MicrobitMachineState),
     .class_init = microbit_machine_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void microbit_machine_init(void)
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index d6d178642ba..865009c1e0e 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -1485,28 +1485,24 @@ static const TypeInfo mps2tz_an505_info = {
     .name = TYPE_MPS2TZ_AN505_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an505_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2tz_an521_info = {
     .name = TYPE_MPS2TZ_AN521_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps2tz_an521_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps3tz_an524_info = {
     .name = TYPE_MPS3TZ_AN524_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an524_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps3tz_an547_info = {
     .name = TYPE_MPS3TZ_AN547_MACHINE,
     .parent = TYPE_MPS2TZ_MACHINE,
     .class_init = mps3tz_an547_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void mps2tz_machine_init(void)
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index ac9366d8447..b13b7bc55ec 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -568,28 +568,24 @@ static const TypeInfo mps2_an385_info = {
     .name = TYPE_MPS2_AN385_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an385_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2_an386_info = {
     .name = TYPE_MPS2_AN386_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an386_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2_an500_info = {
     .name = TYPE_MPS2_AN500_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an500_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo mps2_an511_info = {
     .name = TYPE_MPS2_AN511_MACHINE,
     .parent = TYPE_MPS2_MACHINE,
     .class_init = mps2_an511_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void mps2_machine_init(void)
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index caad820d3bc..d6f4c1640ab 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -635,7 +635,6 @@ static const TypeInfo mps3r_machine_types[] = {
         .name = TYPE_MPS3R_AN536_MACHINE,
         .parent = TYPE_MPS3R_MACHINE,
         .class_init = mps3r_an536_class_init,
-        .interfaces = arm_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 75d82eebcac..1b161487e7e 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -658,14 +658,12 @@ static const TypeInfo musca_a_info = {
     .name = TYPE_MUSCA_A_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_a_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo musca_b1_info = {
     .name = TYPE_MUSCA_B1_MACHINE,
     .parent = TYPE_MUSCA_MACHINE,
     .class_init = musca_b1_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void musca_machine_init(void)
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 8a70ed7377e..84d20bca72b 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -1366,7 +1366,7 @@ static void musicpal_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("musicpal", MACHINE, MusicPalMachineState,
                         musicpal_machine_init, false,
-                        arm_machine_interfaces)
+                        NULL)
 
 static void mv88w8618_wlan_class_init(ObjectClass *klass, const void *data)
 {
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 4f14d257465..025de42dac6 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -550,27 +550,22 @@ static const TypeInfo npcm7xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm750-evb"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = npcm750_evb_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gsj"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gsj_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("quanta-gbs-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = gbs_bmc_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("kudo-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = kudo_bmc_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("mori-bmc"),
         .parent         = TYPE_NPCM7XX_MACHINE,
         .class_init     = mori_bmc_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index f462369bea3..2a04cf4f2c9 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -249,7 +249,6 @@ static const TypeInfo npcm8xx_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("npcm845-evb"),
         .parent         = TYPE_NPCM8XX_MACHINE,
         .class_init     = npcm845_evb_machine_class_init,
-        .interfaces     = aarch64_machine_interfaces,
     },
 };
 
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index 3b628d13cbc..c3fe4187b8b 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -226,7 +226,6 @@ static const TypeInfo sx1_machine_v2_type = {
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v2_class_init,
     .instance_size = sizeof(Sx1MachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void sx1_machine_v1_class_init(ObjectClass *oc, const void *data)
@@ -247,7 +246,6 @@ static const TypeInfo sx1_machine_v1_type = {
     .parent = TYPE_MACHINE,
     .class_init = sx1_machine_v1_class_init,
     .instance_size = sizeof(Sx1MachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void sx1_machine_init(void)
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 0e149ed6c98..3f06716c364 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -135,4 +135,4 @@ static void orangepi_machine_init(MachineClass *mc)
 
 DEFINE_MACHINE_EXTENDED("orangepi-pc", MACHINE, OrangePiMachineState,
                         orangepi_machine_init, false,
-                        arm_machine_interfaces)
+                        NULL)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index bbaa20bd630..7ff3e8400e6 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -392,29 +392,24 @@ static const TypeInfo raspi_machine_types[] = {
         .name           = MACHINE_TYPE_NAME("raspi0"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi0_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi1ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi1ap_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi2b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi2b_machine_class_init,
-        .interfaces     = arm_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3ap"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3ap_machine_class_init,
         .is_available   = target_aarch64,
-        .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = MACHINE_TYPE_NAME("raspi3b"),
         .parent         = TYPE_RASPI_MACHINE,
         .class_init     = raspi3b_machine_class_init,
         .is_available   = target_aarch64,
-        .interfaces     = aarch64_machine_interfaces,
     }, {
         .name           = TYPE_RASPI_MACHINE,
         .parent         = TYPE_RASPI_BASE_MACHINE,
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 2ad561fdcfc..08fcdf58c9f 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -127,7 +127,6 @@ static const TypeInfo raspi4b_machine_type = {
     .instance_size  = sizeof(Raspi4bMachineState),
     .class_init     = raspi4b_machine_class_init,
     .is_available   = target_aarch64,
-    .interfaces     = aarch64_machine_interfaces,
 };
 
 static void raspi4b_machine_register_type(void)
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 0c2daf5c01f..aee7d05c3e6 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -437,7 +437,6 @@ static const TypeInfo realview_eb_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_class_init,
     .instance_size = sizeof(RealViewMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_eb_mpcore_class_init(ObjectClass *oc, const void *data)
@@ -460,7 +459,6 @@ static const TypeInfo realview_eb_mpcore_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_eb_mpcore_class_init,
     .instance_size = sizeof(RealViewMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_pb_a8_class_init(ObjectClass *oc, const void *data)
@@ -481,7 +479,6 @@ static const TypeInfo realview_pb_a8_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_pb_a8_class_init,
     .instance_size = sizeof(RealViewMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_pbx_a9_class_init(ObjectClass *oc, const void *data)
@@ -503,7 +500,6 @@ static const TypeInfo realview_pbx_a9_type = {
     .parent = TYPE_MACHINE,
     .class_init = realview_pbx_a9_class_init,
     .instance_size = sizeof(RealViewMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void realview_machine_init(void)
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 140b2ecb9e2..ec307388f45 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -152,7 +152,6 @@ static const TypeInfo sabrelite_machine_init_typeinfo = {
     .instance_init = sabrelite_machine_instance_init,
     .instance_size = sizeof(SabreliteMachineState),
     .abstract      = false,
-    .interfaces    = arm_machine_interfaces,
 };
 
 static void sabrelite_machine_init_register_types(void)
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 484b90053e8..06a0032a1b3 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -944,7 +944,6 @@ static const TypeInfo sbsa_ref_info = {
     .instance_finalize = sbsa_ref_instance_finalize,
     .class_init    = sbsa_ref_class_init,
     .instance_size = sizeof(SBSAMachineState),
-    .interfaces    = aarch64_machine_interfaces,
 };
 
 static void sbsa_ref_machine_init(void)
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 56ecc828f4f..f634918868b 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -1428,7 +1428,6 @@ static const TypeInfo lm3s811evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s811evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s811evb_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 /*
@@ -1450,7 +1449,6 @@ static const TypeInfo lm3s6965evb_type = {
     .name = MACHINE_TYPE_NAME("lm3s6965evb"),
     .parent = TYPE_MACHINE,
     .class_init = lm3s6965evb_class_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void stellaris_machine_init(void)
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 520af79c800..1db9bc1eb24 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -438,7 +438,6 @@ static const TypeInfo versatilepb_type = {
     .parent = TYPE_MACHINE,
     .class_init = versatilepb_class_init,
     .instance_size = sizeof(VersatileMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void versatileab_class_init(ObjectClass *oc, const void *data)
@@ -461,7 +460,6 @@ static const TypeInfo versatileab_type = {
     .parent = TYPE_MACHINE,
     .class_init = versatileab_class_init,
     .instance_size = sizeof(VersatileMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void versatile_machine_init(void)
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index f26d8c6f8d1..1e29fe0f09c 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -850,7 +850,6 @@ static const TypeInfo vexpress_a9_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a9_class_init,
     .instance_init = vexpress_a9_instance_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static const TypeInfo vexpress_a15_info = {
@@ -858,7 +857,6 @@ static const TypeInfo vexpress_a15_info = {
     .parent = TYPE_VEXPRESS_MACHINE,
     .class_init = vexpress_a15_class_init,
     .instance_init = vexpress_a15_instance_init,
-    .interfaces = arm_machine_interfaces,
 };
 
 static void vexpress_machine_init(void)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e7a56e37f73..40650a5ecbf 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -133,7 +133,6 @@ static void arm_virt_compat_default_set(MachineClass *mc)
         .name = MACHINE_VER_TYPE_NAME("virt", __VA_ARGS__), \
         .parent = TYPE_VIRT_MACHINE, \
         .class_init = MACHINE_VER_SYM(class_init, virt, __VA_ARGS__), \
-        .interfaces = arm_aarch64_machine_interfaces, \
     }; \
     static void MACHINE_VER_SYM(register, virt, __VA_ARGS__)(void) \
     { \
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index 10cac28a910..b47dd9efd81 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -96,7 +96,6 @@ static const TypeInfo xen_arm_machine_type = {
     .class_init = xen_arm_machine_class_init,
     .instance_size = sizeof(XenPVHMachineState),
     .instance_init = xen_arm_instance_init,
-    .interfaces = arm_aarch64_machine_interfaces,
 };
 
 static void xen_arm_machine_register_types(void)
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index f3148975406..8ebd8e5ccd5 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -479,7 +479,6 @@ static const TypeInfo zynq_machine_type = {
     .parent = TYPE_MACHINE,
     .class_init = zynq_machine_class_init,
     .instance_size = sizeof(ZynqMachineState),
-    .interfaces = arm_machine_interfaces,
 };
 
 static void zynq_machine_register_types(void)
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 2b04513ba2e..e06a0c55549 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -402,14 +402,12 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal_virt_machine_class_init,
-    .interfaces = aarch64_machine_interfaces,
 };
 
 static const TypeInfo versal2_virt_machine_init_typeinfo = {
     .name       = TYPE_XLNX_VERSAL2_VIRT_MACHINE,
     .parent     = TYPE_XLNX_VERSAL_VIRT_BASE_MACHINE,
     .class_init = versal2_virt_machine_class_init,
-    .interfaces = aarch64_machine_interfaces,
 };
 
 static void versal_virt_machine_init_register_types(void)
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index 4e489702743..da8b3ede873 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -303,7 +303,6 @@ static const TypeInfo xlnx_zcu102_machine_init_typeinfo = {
     .class_init = xlnx_zcu102_machine_class_init,
     .instance_init = xlnx_zcu102_machine_instance_init,
     .instance_size = sizeof(XlnxZCU102),
-    .interfaces = aarch64_machine_interfaces,
 };
 
 static void xlnx_zcu102_machine_init_register_types(void)
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
index 81ffa434303..449592beda0 100644
--- a/include/hw/arm/machines-qom.h
+++ b/include/hw/arm/machines-qom.h
@@ -11,18 +11,6 @@
 
 #include "hw/core/boards.h"
 
-/*
- * A machine filtered with arm_machine_interfaces[] or
- * arm_aarch64_machine_interfaces[] will be available
- * in both qemu-system-arm and qemu-system-aarch64 binaries.
- *
- * One filtered with aarch64_machine_interfaces[] will only
- * be available in the qemu-system-aarch64 binary.
- */
-extern const InterfaceInfo arm_machine_interfaces[];
-extern const InterfaceInfo arm_aarch64_machine_interfaces[];
-extern const InterfaceInfo aarch64_machine_interfaces[];
-
 /*
  * A machine defined with the DEFINE_MACHINE_ARM() macro will be
  * available in both qemu-system-arm and qemu-system-aarch64 binaries.
@@ -32,9 +20,9 @@ extern const InterfaceInfo aarch64_machine_interfaces[];
  */
 #define DEFINE_MACHINE_ARM(namestr, machine_initfn) \
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            arm_machine_interfaces)
+                                            NULL)
 #define DEFINE_MACHINE_AARCH64(namestr, machine_initfn) \
         DEFINE_MACHINE_WITH_INTERFACE_ARRAY(namestr, machine_initfn, \
-                                            aarch64_machine_interfaces)
+                                            NULL)
 
 #endif
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 42a1427fa16..61106f9def6 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -1346,15 +1346,3 @@ const VMStateDescription vmstate_arm_cpu = {
         NULL
     }
 };
-
-const InterfaceInfo arm_machine_interfaces[] = {
-    { }
-};
-
-const InterfaceInfo arm_aarch64_machine_interfaces[] = {
-    { }
-};
-
-const InterfaceInfo aarch64_machine_interfaces[] = {
-    { }
-};
-- 
2.43.0


