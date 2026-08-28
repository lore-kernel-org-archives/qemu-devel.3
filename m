Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 104F6C61DCB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 23:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x05Y7-0000Xe-AU; Fri, 28 Aug 2026 18:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Y3-0000UH-KH
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x05Xz-0005kt-QR
 for qemu-devel@nongnu.org; Fri, 28 Aug 2026 18:59:47 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67SMTCuL3665672
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZZ5Ww1Cj51o
 OTmZReK/UzXJCmbAFU8jtdxOL3I8Rsf0=; b=a3gzYoCvT/gqGOj2VBqoeTy6y/z
 Rlfp6LrHST36/SVDBFmXThrmhUep01JsmecdPp9vw8BPtcZqGM181jA30mBGojTu
 jdCfb0D8hE4J29Ygbr8RF3vqy2T+HNcXXiJZeyD2xEz8/R4Vt7m/2posaZLOHtpb
 FgqMI7RWgFtMHbXrwb5MdEo5cnZoc+GCpBPpqOJ5eQGlmsrnn5HlZN568PflI35k
 XFO886vFISuK7vH6jE6apzClFShs018A9V0dr+FMH2UahnP4koJgL3SIb2vocIv4
 n5GkXciAlV9Ta/u52hqV3If1rFvurv66NB7u0u8AFLytoNM/BR3U55pVqYw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gb3mubswb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 22:59:31 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38fa7b09921so2822019a91.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2026 15:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787957971; x=1788562771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZZ5Ww1Cj51oOTmZReK/UzXJCmbAFU8jtdxOL3I8Rsf0=;
 b=B2+Zw334QJEfUw7/ZJiltSSvAIIo6Y7BHg8/bIKJ1uGvCnqaBwGuZ/cFj0GozU4khe
 QAcmxxz66hIiccj1oGrrlVVaneUVxv1JLPY342SQpBDE2Z7OS2vFAl636VqEYUKqnD/7
 Ur/c986CAe1on6nK/0+7Jf3uB3Ajl27D7RvybzI2jFtezkb9qa7s/6ThG6IyYPmIBX1a
 QzF7vwzMwOrsgBlhceU/fowhPYE+W4O2Gd4SzUkiuxRZMX87OQLwZ4mPMOrRbCiF8CXa
 01JmAyjejvx4fVooX1v67W3F54JxhArKvprSUs9IYMg08SOzdSDQps19sE6dm4PAunoF
 8Z8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787957971; x=1788562771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZZ5Ww1Cj51oOTmZReK/UzXJCmbAFU8jtdxOL3I8Rsf0=;
 b=jX96ND0moVMq29O5Kr8rYUy+Dy7M7r6qhVf9uJ969KyT2eNa4O5dWltzUVyhwLd/ll
 v7sIbsRZikgFbqajI7YQMO8SAY7KHCWfHKjr/UQEFvPqFcAW6vHkfm384I35MwL/gdQ7
 4YuyXRQonAOJBfprx633U9EsnfRBsAgZEJqBtli5EcyMXMy1a0uHueh6oP/JDBG0foZS
 qKpxA2ai1F8Hu4L6JbpwgCJpUUtwJvREkkdnaMEnEzWxeK+1q0QGpMog3hN/ZlksFgzs
 o/A2fGnznBVkMI5ZNYszPMI9gL+7JSmJCBJy7RoSWeV1+YdA1odzD+ooVFGpKm3BOuDs
 Z7/Q==
X-Gm-Message-State: AFuF++kLpnRYwQuALRMK/PY0SKSEjjw5EnKtAte6/TPk+u+3W7yrLrxi
 eMW3KKO2qQOeT7zoZVWfAisiMQuq848poPNJkiW7430ismbXHsz5wBKRJ6g3B+3Q+OhaQpDeG6T
 BU+htskwJyUbl3eqi799qKg0Or4eq2CbdGBdlyb1fBMrzzQBPvebB7sl4C3ff9Ws1Cw==
X-Gm-Gg: AYBFou2ok6PJJW1fB7hEKdTwT+UphN8bvawxom7Jps59yEJ6GtFJGm3WfDNtWzTeWIU
 0UOW09GQBILNdvKeaWmImPzWvi7GRBBkxE5jGSYwpoUPSoC6fTuX5CQjiPz1ty/y9PPriyQzMQq
 UF/menNX5WeVz/8JLGeKVfXC7RKg6e+BfkK3wK0krGWbgGQZFiEcTpWuuq7mHn4wUiCIsK3/gM0
 LkNe42mFzVx0UVQ9otLR6P2in/Q0UYheRh1ofQn9D4Mo798a9CxyNArW4BxBsUdZR0Z0MUzNm6v
 iWC7CZKBINQ5OOOUg+fLH9xFbY/9g2ca7TfUqj0UO4zaVINOJF0uNv35pspq0abBMMnNJniVbrn
 8lPsmhNNWP9CPsaZhp6R9hA5JKERZwyWNuev2k/EOsUSwPWzVVYcOzLriuzw=
X-Received: by 2002:a17:90b:582e:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-396d0fabb3amr18684627a91.13.1787957970602; 
 Fri, 28 Aug 2026 15:59:30 -0700 (PDT)
X-Received: by 2002:a17:90b:582e:b0:395:4de4:92be with SMTP id
 98e67ed59e1d1-396d0fabb3amr18684548a91.13.1787957969839; 
 Fri, 28 Aug 2026 15:59:29 -0700 (PDT)
Received: from debian.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0de4de3sm12862827c88.12.2026.08.28.15.59.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 15:59:27 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: anjo@rev.ng, Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 philmd@oss.qualcomm.com, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 18/47] hw/arm: remove machines-qom.h
Date: Fri, 28 Aug 2026 22:58:32 +0000
Message-ID: <20260828225901.367438-19-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260828225901.367438-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZbMt8MVA c=1 sm=1 tr=0 ts=6a9212d3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=oVOCmnCwC0CRNczbz68A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 9ty2-B-vbJTv7QhBTiLGbdASWCfIL9kz
X-Proofpoint-GUID: 9ty2-B-vbJTv7QhBTiLGbdASWCfIL9kz
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfX2SOqF8XrdEp0
 JY7evPyEo3V68Gb2nYl2TWpouhw95E/Athlwtx5wR1To/9qYn0Q1OVZEdeLDkougd8L+cA1p6qv
 pavxGg2TA/ohxwb5pxYMGEwpr03piFM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDIwMCBTYWx0ZWRfXw5ohu9fg2MuR
 dMESjJkBokVNqVNkOxAhxE0WAFDvD1a1Y42MJwZXIsRIpKcDANu4U5EUGfS+A5JbOXcO5wiOaOc
 wLxpx5itl6lZuBpmkxFkZnK/u3a73k2KqPePBs3WpWZ/qHGR2IFuMH1rDe6JkKI9B/uYoTdk11Z
 HfvlAVxa7Amjiztkuk2h1tbwo068scIAue6kUH6Jm9QfkH2IWEbzjl6H+i9uod0C3cHzsjbJMky
 vowz5A+YUvNkoO2aaTa+eP9qvFGsVFQNQ3NgvWR7uDmx47VD1dAOaEU644F5gM23AUk0E2wslTk
 siU2+dZxq6ljuEEbwpVAMXxyLZa3OKMxRUqk1u+QureXb6jFjKbI6wF2pjrCAhswbyPSQAtNzTp
 quo0h6ZeXDwhttmV2GWwWp43v7itbdQaFZiluVrEn2FvUHTVSM2ddIMysNWxhvCotw+rnNMTWVo
 6EEoTPTH/F55MXG93KA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_07,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608280200
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

Header is now empty so we can remove it.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 hw/arm/aspeed.c                           |  1 -
 hw/arm/aspeed_ast1040_evb.c               |  1 -
 hw/arm/aspeed_ast10x0_evb.c               |  1 -
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
 hw/arm/aspeed_ast27x0_evb.c               |  1 -
 hw/arm/ax3000-boards.c                    |  1 -
 hw/arm/b-l475e-iot01a.c                   |  1 -
 hw/arm/bananapi_m2u.c                     |  1 -
 hw/arm/collie.c                           |  1 -
 hw/arm/cubieboard.c                       |  1 -
 hw/arm/digic_boards.c                     |  1 -
 hw/arm/exynos4_boards.c                   |  1 -
 hw/arm/imx25_pdk.c                        |  1 -
 hw/arm/imx8mm-evk.c                       |  1 -
 hw/arm/imx8mp-evk.c                       |  1 -
 hw/arm/integratorcp.c                     |  1 -
 hw/arm/kzm.c                              |  1 -
 hw/arm/max78000fthr.c                     |  1 -
 hw/arm/mcimx6ul-evk.c                     |  1 -
 hw/arm/mcimx7d-sabre.c                    |  1 -
 hw/arm/microbit.c                         |  1 -
 hw/arm/mps2-tz.c                          |  1 -
 hw/arm/mps2.c                             |  1 -
 hw/arm/mps3r.c                            |  1 -
 hw/arm/msf2-som.c                         |  1 -
 hw/arm/musca.c                            |  1 -
 hw/arm/musicpal.c                         |  1 -
 hw/arm/netduino2.c                        |  1 -
 hw/arm/netduinoplus2.c                    |  1 -
 hw/arm/npcm7xx_boards.c                   |  1 -
 hw/arm/npcm8xx_boards.c                   |  1 -
 hw/arm/olimex-stm32-h405.c                |  1 -
 hw/arm/omap_sx1.c                         |  1 -
 hw/arm/orangepi.c                         |  1 -
 hw/arm/raspi.c                            |  1 -
 hw/arm/raspi4b.c                          |  1 -
 hw/arm/realview.c                         |  1 -
 hw/arm/sabrelite.c                        |  1 -
 hw/arm/sbsa-ref.c                         |  1 -
 hw/arm/stellaris.c                        |  1 -
 hw/arm/stm32vldiscovery.c                 |  1 -
 hw/arm/versatilepb.c                      |  1 -
 hw/arm/vexpress.c                         |  1 -
 hw/arm/virt.c                             |  1 -
 hw/arm/xen-pvh.c                          |  1 -
 hw/arm/xilinx_zynq.c                      |  1 -
 hw/arm/xlnx-versal-virt.c                 |  1 -
 hw/arm/xlnx-zcu102.c                      |  1 -
 hw/core/null-machine.c                    |  1 -
 hw/nitro/machine.c                        |  1 -
 hw/remote/machine.c                       |  1 -
 include/hw/arm/machines-qom.h             | 14 --------------
 target-info-qom.c                         |  1 -
 target/arm/machine.c                      |  1 -
 72 files changed, 85 deletions(-)
 delete mode 100644 include/hw/arm/machines-qom.h

diff --git a/hw/arm/aspeed.c b/hw/arm/aspeed.c
index 8fa16b3831c..a7cfbd6c5e0 100644
--- a/hw/arm/aspeed.c
+++ b/hw/arm/aspeed.c
@@ -14,7 +14,6 @@
 #include "hw/arm/boot.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/gpio/pca9552.h"
 #include "hw/gpio/pca9554.h"
diff --git a/hw/arm/aspeed_ast1040_evb.c b/hw/arm/aspeed_ast1040_evb.c
index dd68f9e25c7..486f0f6a1ba 100644
--- a/hw/arm/aspeed_ast1040_evb.c
+++ b/hw/arm/aspeed_ast1040_evb.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/core/qdev-clock.h"
diff --git a/hw/arm/aspeed_ast10x0_evb.c b/hw/arm/aspeed_ast10x0_evb.c
index f377e955adc..c937bb74665 100644
--- a/hw/arm/aspeed_ast10x0_evb.c
+++ b/hw/arm/aspeed_ast10x0_evb.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/core/qdev-clock.h"
diff --git a/hw/arm/aspeed_ast2400_palmetto.c b/hw/arm/aspeed_ast2400_palmetto.c
index f4918683c3d..e2350e5b6ca 100644
--- a/hw/arm/aspeed_ast2400_palmetto.c
+++ b/hw/arm/aspeed_ast2400_palmetto.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2400_quanta-q71l.c b/hw/arm/aspeed_ast2400_quanta-q71l.c
index e1ddf682315..e8cbbb8a052 100644
--- a/hw/arm/aspeed_ast2400_quanta-q71l.c
+++ b/hw/arm/aspeed_ast2400_quanta-q71l.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 
diff --git a/hw/arm/aspeed_ast2400_supermicrox11.c b/hw/arm/aspeed_ast2400_supermicrox11.c
index 86d49fd1dee..c75898cc6d1 100644
--- a/hw/arm/aspeed_ast2400_supermicrox11.c
+++ b/hw/arm/aspeed_ast2400_supermicrox11.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2500_evb.c b/hw/arm/aspeed_ast2500_evb.c
index 5f616252e0b..6ca2a36322c 100644
--- a/hw/arm/aspeed_ast2500_evb.c
+++ b/hw/arm/aspeed_ast2500_evb.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2500_g220a.c b/hw/arm/aspeed_ast2500_g220a.c
index 3c654c62dd6..00bb1c61053 100644
--- a/hw/arm/aspeed_ast2500_g220a.c
+++ b/hw/arm/aspeed_ast2500_g220a.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2500_romulus.c b/hw/arm/aspeed_ast2500_romulus.c
index b2ed623f680..340a74408b6 100644
--- a/hw/arm/aspeed_ast2500_romulus.c
+++ b/hw/arm/aspeed_ast2500_romulus.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 
diff --git a/hw/arm/aspeed_ast2500_supermicro-x11spi.c b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
index 77fa028b096..5a7e49d6ccd 100644
--- a/hw/arm/aspeed_ast2500_supermicro-x11spi.c
+++ b/hw/arm/aspeed_ast2500_supermicro-x11spi.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2500_tiogapass.c b/hw/arm/aspeed_ast2500_tiogapass.c
index 1771f376480..6cb567526c4 100644
--- a/hw/arm/aspeed_ast2500_tiogapass.c
+++ b/hw/arm/aspeed_ast2500_tiogapass.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
diff --git a/hw/arm/aspeed_ast2500_witherspoon.c b/hw/arm/aspeed_ast2500_witherspoon.c
index 4cc349c3236..26ddb673470 100644
--- a/hw/arm/aspeed_ast2500_witherspoon.c
+++ b/hw/arm/aspeed_ast2500_witherspoon.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/misc/led.h"
diff --git a/hw/arm/aspeed_ast2500_yosemitev2.c b/hw/arm/aspeed_ast2500_yosemitev2.c
index 48c813f3c8f..3ba1ed5f6fa 100644
--- a/hw/arm/aspeed_ast2500_yosemitev2.c
+++ b/hw/arm/aspeed_ast2500_yosemitev2.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
diff --git a/hw/arm/aspeed_ast2600_anacapa.c b/hw/arm/aspeed_ast2600_anacapa.c
index e82f5c98f26..697be58b0e4 100644
--- a/hw/arm/aspeed_ast2600_anacapa.c
+++ b/hw/arm/aspeed_ast2600_anacapa.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/sensor/adc128d818.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
diff --git a/hw/arm/aspeed_ast2600_bletchley.c b/hw/arm/aspeed_ast2600_bletchley.c
index 9dda83ad4c0..2822f6bdf5a 100644
--- a/hw/arm/aspeed_ast2600_bletchley.c
+++ b/hw/arm/aspeed_ast2600_bletchley.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/gpio/pca9552.h"
diff --git a/hw/arm/aspeed_ast2600_catalina.c b/hw/arm/aspeed_ast2600_catalina.c
index f91e0635908..23636ab6985 100644
--- a/hw/arm/aspeed_ast2600_catalina.c
+++ b/hw/arm/aspeed_ast2600_catalina.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
diff --git a/hw/arm/aspeed_ast2600_evb.c b/hw/arm/aspeed_ast2600_evb.c
index 404083b61dc..8a17c4453e9 100644
--- a/hw/arm/aspeed_ast2600_evb.c
+++ b/hw/arm/aspeed_ast2600_evb.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/aspeed_ast2600_fby35.c b/hw/arm/aspeed_ast2600_fby35.c
index 6bcda0ac630..65d98fafec6 100644
--- a/hw/arm/aspeed_ast2600_fby35.c
+++ b/hw/arm/aspeed_ast2600_fby35.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
diff --git a/hw/arm/aspeed_ast2600_fuji.c b/hw/arm/aspeed_ast2600_fuji.c
index cf49149fe9a..8a87c2dbee3 100644
--- a/hw/arm/aspeed_ast2600_fuji.c
+++ b/hw/arm/aspeed_ast2600_fuji.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
diff --git a/hw/arm/aspeed_ast2600_gb200nvl.c b/hw/arm/aspeed_ast2600_gb200nvl.c
index 705561afe39..311feb82023 100644
--- a/hw/arm/aspeed_ast2600_gb200nvl.c
+++ b/hw/arm/aspeed_ast2600_gb200nvl.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
diff --git a/hw/arm/aspeed_ast2600_rainier.c b/hw/arm/aspeed_ast2600_rainier.c
index 6e5debc8bc1..43a8f01a9e7 100644
--- a/hw/arm/aspeed_ast2600_rainier.c
+++ b/hw/arm/aspeed_ast2600_rainier.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/nvram/eeprom_at24c.h"
diff --git a/hw/arm/aspeed_ast27x0-fc.c b/hw/arm/aspeed_ast27x0-fc.c
index ccfa4ade265..73362b60d2a 100644
--- a/hw/arm/aspeed_ast27x0-fc.c
+++ b/hw/arm/aspeed_ast27x0-fc.c
@@ -22,7 +22,6 @@
 #include "hw/arm/boot.h"
 #include "hw/block/flash.h"
 #include "hw/arm/aspeed_coprocessor.h"
-#include "hw/arm/machines-qom.h"
 
 #define TYPE_AST2700FC MACHINE_TYPE_NAME("ast2700fc")
 OBJECT_DECLARE_SIMPLE_TYPE(Ast2700FCState, AST2700FC);
diff --git a/hw/arm/aspeed_ast27x0_evb.c b/hw/arm/aspeed_ast27x0_evb.c
index 0deb3127c21..460c9ff0d2e 100644
--- a/hw/arm/aspeed_ast27x0_evb.c
+++ b/hw/arm/aspeed_ast27x0_evb.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/aspeed.h"
 #include "hw/arm/aspeed_soc.h"
 #include "hw/sensor/tmp105.h"
diff --git a/hw/arm/ax3000-boards.c b/hw/arm/ax3000-boards.c
index c7248f9f52b..dc98ee7b71a 100644
--- a/hw/arm/ax3000-boards.c
+++ b/hw/arm/ax3000-boards.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "hw/arm/ax3000-boards.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
 
diff --git a/hw/arm/b-l475e-iot01a.c b/hw/arm/b-l475e-iot01a.c
index 04dce2d19ce..de19212ab85 100644
--- a/hw/arm/b-l475e-iot01a.c
+++ b/hw/arm/b-l475e-iot01a.c
@@ -29,7 +29,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/core/split-irq.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/stm32l4x5_soc.h"
 #include "hw/gpio/stm32l4x5_gpio.h"
 #include "hw/display/dm163.h"
diff --git a/hw/arm/bananapi_m2u.c b/hw/arm/bananapi_m2u.c
index 15c878d1636..8f59111fd4e 100644
--- a/hw/arm/bananapi_m2u.c
+++ b/hw/arm/bananapi_m2u.c
@@ -27,7 +27,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-r40.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 #define TYPE_BPIM2U_MACHINE MACHINE_TYPE_NAME("bpim2u")
 OBJECT_DECLARE_SIMPLE_TYPE(Bpim2uMachineState, BPIM2U_MACHINE)
diff --git a/hw/arm/collie.c b/hw/arm/collie.c
index 4b930e6ba12..ca6b3addb7b 100644
--- a/hw/arm/collie.c
+++ b/hw/arm/collie.c
@@ -15,7 +15,6 @@
 #include "hw/core/boards.h"
 #include "strongarm.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "system/address-spaces.h"
 #include "qom/object.h"
diff --git a/hw/arm/cubieboard.c b/hw/arm/cubieboard.c
index 511b71fbd7e..ae27056938f 100644
--- a/hw/arm/cubieboard.c
+++ b/hw/arm/cubieboard.c
@@ -22,7 +22,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-a10.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/i2c/i2c.h"
 
 #define TYPE_CUBIEBOARD_MACHINE MACHINE_TYPE_NAME("cubieboard")
diff --git a/hw/arm/digic_boards.c b/hw/arm/digic_boards.c
index c7ecf22a958..90c19106ad0 100644
--- a/hw/arm/digic_boards.c
+++ b/hw/arm/digic_boards.c
@@ -29,7 +29,6 @@
 #include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "hw/arm/digic.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/core/loader.h"
 #include "system/qtest.h"
diff --git a/hw/arm/exynos4_boards.c b/hw/arm/exynos4_boards.c
index 62f7cbe875e..78632877df8 100644
--- a/hw/arm/exynos4_boards.c
+++ b/hw/arm/exynos4_boards.c
@@ -28,7 +28,6 @@
 #include "hw/core/sysbus.h"
 #include "net/net.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "system/address-spaces.h"
 #include "hw/arm/exynos4210.h"
 #include "hw/net/lan9118.h"
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 3246512c214..243c30a67e7 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -28,7 +28,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/fsl-imx25.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "system/qtest.h"
diff --git a/hw/arm/imx8mm-evk.c b/hw/arm/imx8mm-evk.c
index ffe8e494a57..8a5737502fd 100644
--- a/hw/arm/imx8mm-evk.c
+++ b/hw/arm/imx8mm-evk.c
@@ -11,7 +11,6 @@
 #include "system/address-spaces.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mm.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index 389e7c86d21..3f376f86d91 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -10,7 +10,6 @@
 #include "system/address-spaces.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/fsl-imx8mp.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "system/kvm.h"
diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 25ecd931e76..382ea7850d8 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -13,7 +13,6 @@
 #include "migration/vmstate.h"
 #include "hw/core/boards.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/misc/arm_integrator_debug.h"
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 909dd929e63..387bf54ced1 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -17,7 +17,6 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx31.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "system/address-spaces.h"
diff --git a/hw/arm/max78000fthr.c b/hw/arm/max78000fthr.c
index 290a14c8ad9..ed50bb91979 100644
--- a/hw/arm/max78000fthr.c
+++ b/hw/arm/max78000fthr.c
@@ -12,7 +12,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/core/qdev-clock.h"
 #include "qemu/error-report.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/max78000_soc.h"
 #include "hw/arm/boot.h"
 
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index a3dafb20131..40071d2c7b9 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -14,7 +14,6 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6ul.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/mcimx7d-sabre.c b/hw/arm/mcimx7d-sabre.c
index cb4536faadd..db8a62e5f6c 100644
--- a/hw/arm/mcimx7d-sabre.c
+++ b/hw/arm/mcimx7d-sabre.c
@@ -16,7 +16,6 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx7.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index 85285861c5f..c1a3f6903fe 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -12,7 +12,6 @@
 #include "qapi/error.h"
 #include "hw/core/boards.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "system/system.h"
 #include "system/address-spaces.h"
 
diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index 865009c1e0e..d767207e2e1 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -52,7 +52,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/or-irq.h"
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index b13b7bc55ec..35d867328a9 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -31,7 +31,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armv7m.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/or-irq.h"
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
diff --git a/hw/arm/mps3r.c b/hw/arm/mps3r.c
index d6f4c1640ab..eedb877e4bc 100644
--- a/hw/arm/mps3r.c
+++ b/hw/arm/mps3r.c
@@ -37,7 +37,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/bsa.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/char/cmsdk-apb-uart.h"
 #include "hw/i2c/arm_sbcon_i2c.h"
 #include "hw/intc/arm_gicv3.h"
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
index 8d00fef43b0..1372d7f628a 100644
--- a/hw/arm/msf2-som.c
+++ b/hw/arm/msf2-som.c
@@ -32,7 +32,6 @@
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/qdev-clock.h"
 #include "system/address-spaces.h"
 #include "hw/arm/msf2-soc.h"
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 1b161487e7e..571bee1b72b 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -26,7 +26,6 @@
 #include "system/system.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/armsse.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/char/pl011.h"
 #include "hw/core/split-irq.h"
diff --git a/hw/arm/musicpal.c b/hw/arm/musicpal.c
index 84d20bca72b..e1a336e861a 100644
--- a/hw/arm/musicpal.c
+++ b/hw/arm/musicpal.c
@@ -15,7 +15,6 @@
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
index 6a639264d61..0db8798b4bd 100644
--- a/hw/arm/netduino2.c
+++ b/hw/arm/netduino2.c
@@ -30,7 +30,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f205_soc.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 /* Main SYSCLK frequency in Hz (120MHz) */
 #define SYSCLK_FRQ 120000000ULL
diff --git a/hw/arm/netduinoplus2.c b/hw/arm/netduinoplus2.c
index d04ab8aeea4..5ac0eb81637 100644
--- a/hw/arm/netduinoplus2.c
+++ b/hw/arm/netduinoplus2.c
@@ -30,7 +30,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 /* Main SYSCLK frequency in Hz (168MHz) */
 #define SYSCLK_FRQ 168000000ULL
diff --git a/hw/arm/npcm7xx_boards.c b/hw/arm/npcm7xx_boards.c
index 025de42dac6..9c526a26839 100644
--- a/hw/arm/npcm7xx_boards.c
+++ b/hw/arm/npcm7xx_boards.c
@@ -17,7 +17,6 @@
 #include "qemu/osdep.h"
 
 #include "hw/arm/npcm7xx.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
 #include "hw/i2c/i2c_mux_pca954x.h"
 #include "hw/i2c/smbus_eeprom.h"
diff --git a/hw/arm/npcm8xx_boards.c b/hw/arm/npcm8xx_boards.c
index 2a04cf4f2c9..4b3af165034 100644
--- a/hw/arm/npcm8xx_boards.c
+++ b/hw/arm/npcm8xx_boards.c
@@ -19,7 +19,6 @@
 #include "chardev/char.h"
 #include "hw/core/boards.h"
 #include "hw/arm/npcm8xx.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/cpu.h"
 #include "hw/core/loader.h"
 #include "hw/core/qdev.h"
diff --git a/hw/arm/olimex-stm32-h405.c b/hw/arm/olimex-stm32-h405.c
index 154501fc3c7..de9ac4978ce 100644
--- a/hw/arm/olimex-stm32-h405.c
+++ b/hw/arm/olimex-stm32-h405.c
@@ -31,7 +31,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f405_soc.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 /* olimex-stm32-h405 implementation is derived from netduinoplus2 */
 
diff --git a/hw/arm/omap_sx1.c b/hw/arm/omap_sx1.c
index c3fe4187b8b..a7e469ea6a3 100644
--- a/hw/arm/omap_sx1.c
+++ b/hw/arm/omap_sx1.c
@@ -32,7 +32,6 @@
 #include "hw/arm/omap.h"
 #include "hw/core/boards.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "system/qtest.h"
 #include "system/address-spaces.h"
diff --git a/hw/arm/orangepi.c b/hw/arm/orangepi.c
index 3f06716c364..7a19732f5df 100644
--- a/hw/arm/orangepi.c
+++ b/hw/arm/orangepi.c
@@ -26,7 +26,6 @@
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/allwinner-h3.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 #define TYPE_ORANGEPI_MACHINE MACHINE_TYPE_NAME("orangepi-pc")
 OBJECT_DECLARE_SIMPLE_TYPE(OrangePiMachineState, ORANGEPI_MACHINE)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 7ff3e8400e6..fadbacb2534 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -24,7 +24,6 @@
 #include "qemu/error-report.h"
 #include "hw/core/boards.h"
 #include "hw/core/loader.h"
-#include "hw/arm/machines-qom.h"
 #include "qom/object.h"
 
 #define TYPE_RASPI_MACHINE  MACHINE_TYPE_NAME("raspi-common")
diff --git a/hw/arm/raspi4b.c b/hw/arm/raspi4b.c
index 08fcdf58c9f..7d3eed96304 100644
--- a/hw/arm/raspi4b.c
+++ b/hw/arm/raspi4b.c
@@ -11,7 +11,6 @@
 #include "qemu/cutils.h"
 #include "qapi/error.h"
 #include "qapi/visitor.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/arm/raspi_platform.h"
 #include "hw/display/bcm2835_fb.h"
 #include "hw/core/registerfields.h"
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index aee7d05c3e6..ceba0331b08 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -12,7 +12,6 @@
 #include "target/arm/cpu.h"
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/split-irq.h"
 #include "hw/misc/arm_sysctl.h"
 #include "hw/net/lan9118.h"
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index ec307388f45..05dfabd9376 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -14,7 +14,6 @@
 #include "qapi/error.h"
 #include "hw/arm/fsl-imx6.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "hw/core/qdev-properties.h"
 #include "qemu/error-report.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 6ba353341a1..158b461eb48 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -35,7 +35,6 @@
 #include "hw/arm/bsa.h"
 #include "hw/arm/fdt.h"
 #include "hw/arm/smmuv3.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/core/boards.h"
 #include "hw/ide/ide-bus.h"
diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index f634918868b..f41315e1928 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -15,7 +15,6 @@
 #include "hw/sd/sd.h"
 #include "hw/ssi/ssi.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "qemu/timer.h"
 #include "hw/i2c/i2c.h"
 #include "net/net.h"
diff --git a/hw/arm/stm32vldiscovery.c b/hw/arm/stm32vldiscovery.c
index 0b39543c1ff..d899a134b38 100644
--- a/hw/arm/stm32vldiscovery.c
+++ b/hw/arm/stm32vldiscovery.c
@@ -31,7 +31,6 @@
 #include "qemu/error-report.h"
 #include "hw/arm/stm32f100_soc.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 
 /* stm32vldiscovery implementation is derived from netduinoplus2 */
 
diff --git a/hw/arm/versatilepb.c b/hw/arm/versatilepb.c
index 1db9bc1eb24..f94bf96599e 100644
--- a/hw/arm/versatilepb.c
+++ b/hw/arm/versatilepb.c
@@ -12,7 +12,6 @@
 #include "hw/core/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/net/smc91c111.h"
 #include "net/net.h"
 #include "system/system.h"
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 1e29fe0f09c..914cda66d20 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -26,7 +26,6 @@
 #include "qemu/datadir.h"
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/misc/arm_sysctl.h"
 #include "hw/net/lan9118.h"
 #include "hw/i2c/i2c.h"
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index eae4f0fe413..0871a35e11f 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -37,7 +37,6 @@
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
 #include "hw/arm/virt.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/block/flash.h"
 #include "hw/display/ramfb.h"
 #include "net/net.h"
diff --git a/hw/arm/xen-pvh.c b/hw/arm/xen-pvh.c
index b47dd9efd81..f05956c1662 100644
--- a/hw/arm/xen-pvh.c
+++ b/hw/arm/xen-pvh.c
@@ -10,7 +10,6 @@
 #include "hw/core/boards.h"
 #include "system/system.h"
 #include "hw/xen/xen-pvh-common.h"
-#include "hw/arm/machines-qom.h"
 
 #define TYPE_XEN_ARM  MACHINE_TYPE_NAME("xenpvh")
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 8ebd8e5ccd5..c1897ab1cf3 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -20,7 +20,6 @@
 #include "qapi/error.h"
 #include "hw/core/sysbus.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "net/net.h"
 #include "system/system.h"
 #include "hw/core/boards.h"
diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index e06a0c55549..4018f2bf7d1 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -21,7 +21,6 @@
 #include "hw/arm/fdt.h"
 #include "hw/arm/xlnx-versal.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "qom/object.h"
 #include "target/arm/cpu.h"
 
diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
index da8b3ede873..bb596218540 100644
--- a/hw/arm/xlnx-zcu102.c
+++ b/hw/arm/xlnx-zcu102.c
@@ -19,7 +19,6 @@
 #include "qapi/error.h"
 #include "hw/arm/xlnx-zynqmp.h"
 #include "hw/arm/boot.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/boards.h"
 #include "qemu/error-report.h"
 #include "qemu/log.h"
diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index c1ecf3214fd..2aa748233b3 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -16,7 +16,6 @@
 #include "hw/core/boards.h"
 #include "system/address-spaces.h"
 #include "hw/core/cpu.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/riscv/machines-qom.h"
 
 static void machine_none_init(MachineState *mch)
diff --git a/hw/nitro/machine.c b/hw/nitro/machine.c
index bb8878299bc..88d01960a01 100644
--- a/hw/nitro/machine.c
+++ b/hw/nitro/machine.c
@@ -31,7 +31,6 @@
 #include "system/system.h"
 #include "system/nitro-accel.h"
 #include "qemu/accel.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/core/eif.h"
 #include <zlib.h> /* for crc32 */
 
diff --git a/hw/remote/machine.c b/hw/remote/machine.c
index 6580e0d9683..ced782f6a9c 100644
--- a/hw/remote/machine.c
+++ b/hw/remote/machine.c
@@ -24,7 +24,6 @@
 #include "hw/core/qdev.h"
 #include "hw/remote/vfio-user-obj.h"
 #include "hw/pci/msi.h"
-#include "hw/arm/machines-qom.h"
 
 static void remote_machine_init(MachineState *machine)
 {
diff --git a/include/hw/arm/machines-qom.h b/include/hw/arm/machines-qom.h
deleted file mode 100644
index e3eebbdefbc..00000000000
--- a/include/hw/arm/machines-qom.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- * QOM type definitions for ARM / Aarch64 machines
- *
- *  Copyright (c) Linaro
- *
- * SPDX-License-Identifier: GPL-2.0-or-later
- */
-
-#ifndef HW_ARM_MACHINES_QOM_H
-#define HW_ARM_MACHINES_QOM_H
-
-#include "hw/core/boards.h"
-
-#endif
diff --git a/target-info-qom.c b/target-info-qom.c
index eb9491338ca..7959853e0da 100644
--- a/target-info-qom.c
+++ b/target-info-qom.c
@@ -12,7 +12,6 @@
 #include "qemu/target-info-impl.h"
 #include "qemu/target-info-init.h"
 #include "qemu/target-info-qom.h"
-#include "hw/arm/machines-qom.h"
 #include "hw/riscv/machines-qom.h"
 
 static const TypeInfo target_info_types[] = {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 61106f9def6..7005f4e5d77 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -11,7 +11,6 @@
 #include "migration/qemu-file-types.h"
 #include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
-#include "hw/arm/machines-qom.h"
 
 static bool vfp_needed(void *opaque)
 {
-- 
2.43.0


