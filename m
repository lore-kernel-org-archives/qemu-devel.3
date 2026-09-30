Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398E0CA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBjdc-0007Qf-Dq; Tue, 29 Sep 2026 22:01:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdY-0007Pe-TE
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdX-00034C-87
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:01:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNQ3tW1138141
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4yy3X5kOotq
 16xlcJWmBlBh/DIFBHILiC+j5/drb+7M=; b=NPd1Me/cDaX8WzOvwPG+K9Z5WYS
 xeCmxVDlU2Zezef8M6xgpDELy3yIwKwA4/LVhxQZ8aR2DKKNYRH/4DfD3rMq21gM
 R4kvSTr9hPtZRk9/5V5k+UvFEMZnZ9p5eUY6NNzf89d1pOWwChx/e72KGeuP13j9
 28OiDGuwiWyGY9iWyfGaT3HxAu8j6UaS2Twhz/BhCe6V6H9vty1cbZ/t3iaUOFxm
 VjGs5/PVxoTCBVRl0PU4yl90ydN/5dcxMhqRSlbccMWhVl5FtxCG3Z++EaWGsOuN
 uA3zKq7og73LkzTe4GWDAVBj1oHgvqCeGZE4AmdrBdYHpP8lCSx2lnwQQmA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1kn22-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:01:32 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34318e88ba2so3830799eec.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733692; x=1791338492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4yy3X5kOotq16xlcJWmBlBh/DIFBHILiC+j5/drb+7M=;
 b=SGzjalyDsvVr5kGPE9q0TZ6RdVDYG9bMXuUQ2p6zI869hbzGeFzNDHmW/Gct6a/YF9
 X1e8RlH+333qkanMMk+02uEVZQAt+xp0U+k5A4vuTf0fNJ9JquUPqddjvBPvZFVQYp2u
 Exym2cEmb9MPFgOOdNk7PCUgQaqduOt2wa+qWxqeTwzIGkzb2aTspmoRxAJFDyi3/qP3
 U/q7p/mzOMhw0QhkO4tNBNr01ZSuxz5bGdD0adpQoHahUDskp8TsRa0yQ9GpTlsoafsq
 LkMAtsCoWzmsy+s5p6GwYf1GPiqufjCQeM+Z2wdgV2cvl7WV+rpchRhVNrhVfOeeLkZz
 l7mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733692; x=1791338492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4yy3X5kOotq16xlcJWmBlBh/DIFBHILiC+j5/drb+7M=;
 b=OvFu7+ZUnEctEcEzyvvwyzFW3fFbPRuBhr0xWYq2VVIuUJ9kE4SiTeBB/eQmfHgZJ8
 /vogPvMdV8LpZzhOaaC6UdwmZU5tN9teehMni3u+ogd1SGSkSBjbDyF0fgTP2AQqrfwb
 6RBfAMee1DwOL8Nn6PInl2oOra8aQBV47dW0WXbURxYeKnKWhm6QAvQN87uJKmOVutcR
 ZZxWR/RVRMAlz/wWImO9j/d9ZtKW7q8VGA1VaW4hltw5CID8nIhuprNMwPihlu9f3ivS
 IJCCq+fovjRs4uTBXE+wov85jM5YXO2BXQxuZ+E7H3VzVFUO4+gAUwllF3GWsjLBewDX
 w/OA==
X-Gm-Message-State: AFq9FYJGldiOZBKnNlHYVIJFnaXNAi2jzP0sfYVIf+N3y2l+0vF3613N
 tUlJRbPFzQOeRl5WrotMiO2hSkrfe3qfBDPaFNdT6tjaNpTyRZJoLYxzKxByANqw2JARPwZtaG4
 U7kfxke0BGtRgFGlh0aFMDeZ+G2vHnr+intiT3StazaL8QzMdBLYrLXoy3bdhGOeLEg==
X-Gm-Gg: AYBFou2LkgRstgix90hOicJcS7FtKakGC/aIKIebzE0l40870Jg/0D71Z7We/HzAwYX
 AfQ574ivDo+0yHBNMNy0oKJ5LIQMxCINDCUWRYLIBFNlHzBDpqss6zISHx/I4oe8jUAgkM3Iwi8
 XB5V+7TNTldT7RTztCYFOnJtZ/s/GfAQahHe0FYcIvw3IFO6GvnhxFIHszn78MTmV9KMKBM96i8
 8jSbvSQEtTMO90efEWTuZYD6IE4zwKdyITICs/aYimOrBMqPr07fuIkENGsCg6G8g5rY0Y5Rl2R
 ipc5YgpDJrLVG0UYSPkKoi12ZW279r4hmRrShQTpIvL38wvctzUJSJMNH8Vk5mWyjG/yVJZ2ndT
 BtJChbh3J6U7WPZY70KBstTtHa7Ook16PD7ASlYjK6VxGxw5xqwFMs2fbH4Ga
X-Received: by 2002:a05:7301:9e08:b0:34b:6d45:de57 with SMTP id
 5a478bee46e88-34cdb5f5697mr99961eec.9.1790733691533; 
 Tue, 29 Sep 2026 19:01:31 -0700 (PDT)
X-Received: by 2002:a05:7301:9e08:b0:34b:6d45:de57 with SMTP id
 5a478bee46e88-34cdb5f5697mr99949eec.9.1790733690979; 
 Tue, 29 Sep 2026 19:01:30 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 03/21] system/meson: use stub_ss for dtb stubs
Date: Wed, 30 Sep 2026 02:00:50 +0000
Message-ID: <20260930020108.217892-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX1SXLKJiosszi
 Hq8DSvC2OUeoKbooR7S4hrBUXJESyz1jb1qqUSGXeuG6zR2sayfltCK2VR8PbPyuuN69IotltAT
 VJACemP02pLRga1E0zI03TE5SMuK1tk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX19eigviXiVpP
 49y8Tw2ClzOoxh3r6GAueErY4r7rrZ307SCrmpF1UACIktDYiaMlxSLPCfEYo8oWMVGOXpgRr1O
 8Oz2R1/OpZfUdrmVxujH0Gr7plpP+926SQBzaKDn6LRrFBi//Gwf8CLJiVkf7fyv9bH/RnQr7/a
 QGVrIvnXoEk5hawWPCk1Sb5aDmPVG5/INdbVWaH0kvyKqUkdBtdssPIPC9j8EuSMHYUvJJRcEJD
 +4148l8a5BYD/KPr+WAEDkGrTRFUENE1Ho2gNb8HUVvtaePdYeECgMcPEHrnWMLieh0FkVOUvuq
 FnpkDavkhN53FN7Ldz4ZS0aHOYu2cgrPozXeisQYVtrMgwHrPPQG4DQzE55YdCDjUcfmtmIPrBs
 Dbj2EDX96sAEWbX+ttK3zUWLwIwX/8KJYofTQSkyjaiTk1xoRi39efNtH3kjVmT7VJg9pPCyJCJ
 eM58bCMMDYq4h3xTm0A==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abc6d7c cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=DG0srgjjPWtBgymGp64A:9 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-ORIG-GUID: suoOsKm8VFplol97TLiy1GaLOFiiJMCj
X-Proofpoint-GUID: suoOsKm8VFplol97TLiy1GaLOFiiJMCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300007
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

Remove multiple definition of `qmp_dumpdtb' error, when linking m68k
target with other multi targets.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 system/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/system/meson.build b/system/meson.build
index 41e2e4a292d..a6ba7a04f7d 100644
--- a/system/meson.build
+++ b/system/meson.build
@@ -41,8 +41,8 @@ endif
 
 system_ss.add(when: seccomp, if_true: files('qemu-seccomp.c'))
 system_ss.add(when: 'CONFIG_DEVICE_TREE',
-              if_true: [fdt, files('device_tree.c')],
-              if_false: files('device_tree-stub.c'))
+              if_true: [fdt, files('device_tree.c')])
+stub_ss.add(files('device_tree-stub.c'))
 if host_os == 'linux'
   system_ss.add(files('async-teardown.c'))
 endif
-- 
2.43.0


