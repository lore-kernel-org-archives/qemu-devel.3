Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD178CA5FD6
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 16:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCJnP-00057V-80; Thu, 01 Oct 2026 12:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJnN-00057L-OK
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCJnM-0001zE-6d
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 12:38:09 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691FseTr2886387
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 16:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ywY9UxRA+1W
 W9M1IO4LxSrSUBZ+lHAYcD7RiodxAjYc=; b=kEh47gyfRhHuHBaBUj00dlbUmiw
 WzYG8ONozzJqMbhuLMqVLSKbSp0YspSII5C2+7BArguTIwMrOWhZwuVfEsv4F/UC
 OLKrsF6i1NgKU6T2kOSqd4mCJvYgecoU5MWImCPS3muRuvYVPPFg42OzAPpV/1++
 wlropFbU3Pyop4o9eTH2Demk0wHtOpOLF9Ai13IILnJkraQo+GfV6tyEADhYHYvZ
 zQFXdk7UX2EbYuAZsp8URNzubvlz75YUpnHPflTsQwZocyla+cjZf32dAeYI4lQg
 W6qalDzG2ZOT8Zs1Y8RQjUzl/EwpDDkoC3Qr3lQ6z3OqDVuxtw3L+aOX9aQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1sdcgn1s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 16:38:05 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-149e8e8ad71so1240349c88.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 09:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790872685; x=1791477485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ywY9UxRA+1WW9M1IO4LxSrSUBZ+lHAYcD7RiodxAjYc=;
 b=WQl/jSCpPBCZBU3Rm5pkKYUmY20wdNuNSrRPNXtgSKUB5JrKDtVmO4t3jgZmQ8zyOG
 BKwc0g6qVSN/XE/PEbUnNA4KMVcpnKr2ElD2bulCmzqFfoZ1KZ3+9U6Ei+qmYqoOi0Cs
 WAv7kJNfSEu8BBtpBsXdJFOwxvFIUhn2GHKJHCEXTVXVrrOYw1sdBmsvBnE6DpQBYv2b
 YrSXU7vnrlfvYd6KgKxIzlgSV68vWRTTRfrrYA28RNWelsQb/B1pdqQIQQUbg4ezgz2m
 A7o8OZrTE7utdjO4pi163JeIdSmyv0L0nF+Ldkw1g3olVmLN/kZZqK8qYAnJK4nYnyze
 64Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790872685; x=1791477485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ywY9UxRA+1WW9M1IO4LxSrSUBZ+lHAYcD7RiodxAjYc=;
 b=TeLs7DDF9Rarw1Iet1HobABJh7iOWkUQRe1h2et2PwLObAkAyBedaaMrxIlL9zgIl3
 YTpO3c/V4BjTiMlMU2b8JJ6nYWWXLvjitlDSRscdwk/AjGnuFfYUYoKTdKcUySOtDzTr
 t3PPa+2OQXF8Z3Jv8rebXj+8hR331WBeDbzPkUDQdHVFdyLtuvsV25FnxnYVJIiKnqmx
 XfG/JexkeSPiJuDBk5j+ozVLFWJSyNZ602Ggo+8tHrFQ7G344VHUtRUa6rYTFnQiW46s
 UunjEHlQ6Z5EvT9ytV8J7nOhkOD3etrscqjViFKvnj4TE3vTnwM0r4lG+nY5AI+lk6/v
 ctVA==
X-Gm-Message-State: AFuF++k8lmJPy4tXaMXIeF4BHz3f1AubVLlkw1lXxctV2ZQ/xz/vGHKR
 snw3zXWQ0guSqEKOtxr2ERuqL6lcsxrMSmNNYtDwW43Ewhp9ul0V/6FQx8ITPNHqUBDDv3Xrc7K
 qwndZkT0IifW+sIahk86AYPDMTcSaMmCoju+AQVZA9Y8vh2zDhq5e3KO3U3Et0PVjZA==
X-Gm-Gg: AYBFou07Ck4U/KX8kaC8NKSF1uNcuYcfMmxSg0FEltnKtJ3VNhDqBscn0dnP04HtgGu
 cCy9PZW8SiTwYaSukUWdTVjdyLNnN26uFpwaJhTG7AS2qRrxgNw08oQw9/M62buMUh1GcAGsR+S
 bkZArhxebPQ3Op7O99qyRIUbx7SuU7aiqPftO2+Iu/PDpNsJtquMnLOSODcxKA8fWH2J39z0Fyh
 38gb0V0lQF9ktJzjuqWH9nv7Ho7avusXYJYCybRA2rI4iMrTCp1hJqKiMoWOChNdyRgGjTad4wo
 6HLnyRYYCid7dV1fqOLJ8CciY17OGq7MfXVbGjYxZafazfu/sWmkv4QnftJ1zxr+8hxmr7tKcy4
 2DamCy/ClBL37gocl/Kux5euy8zBcOqYqBid0kvtKRhIWsrD/vBX1LE35tWtT
X-Received: by 2002:a05:701b:424c:20b0:14a:51c8:e9f2 with SMTP id
 a92af1059eb24-14d332a220emr5366859c88.31.1790872684708; 
 Thu, 01 Oct 2026 09:38:04 -0700 (PDT)
X-Received: by 2002:a05:701b:424c:20b0:14a:51c8:e9f2 with SMTP id
 a92af1059eb24-14d332a220emr5366824c88.31.1790872684120; 
 Thu, 01 Oct 2026 09:38:04 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14f26bb14cbsm389846c88.7.2026.10.01.09.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 09:38:03 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Dominic P <gcc@gcc.dp11.uk>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 3/3] tests/tcg/multiarch: add missing test_pnew_jump_loads.c
 test
Date: Thu,  1 Oct 2026 16:37:51 +0000
Message-ID: <20261001163751.172720-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261001163751.172720-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OgRBMAVxz-23s1SvbHQ3URz1Xp9WJZYB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX4Hc17xbmHBs+
 zIGyoQmZfG7hiqukd58nVv+kJF96ivB9i0CFt8yTyJ9ABIVdS1W+WCFJ3gA8cPIMtAOJRvo7Fqf
 5QcYUAkjJLckINiGYs1Wck8cMPVJnpM=
X-Proofpoint-GUID: OgRBMAVxz-23s1SvbHQ3URz1Xp9WJZYB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA2NiBTYWx0ZWRfX4xyoHaN1MIs+
 KC/gLLPTvw5Bs2upDOm1GxpgRMVJow3P3vMuQABj3zXykwXXZbmCt5WpyAq50vQOSe5+aktKOVa
 6DRjqtrST5HsopzBG+SaCRTw0QFU9CtjvCJA6a9g/d6SKSMdcfwGBdzmct0ZCfjMAMDF+8rH6X1
 MbZqjVnYycGiCAzM0hKliweu0GRpytViJC6MsE1b1bivP1DBveEwsmGUoU7CoryJThzwJXaWzcS
 ycYwxQ8AkfLyLj/4hToEDtDd/zgt2nmw8LligizHWtOXHFxd9nanaGAXlVTa6JtmIy1rW4X+bBL
 Agvo975HqMBAw6YCDFnNeGx1kOFtu5mF3MnDCN0ICTA4fkhdasgbl+VW26AbovE6lv7g7LPt1oi
 6QIOGnBcSiYL2trWY8Li4Dk3vRo7Q0zEJMY4ppbIUSA9VmBQzQhcVKdtHWiBBiUCDvQmzRi8Y05
 oixxLCPkbYuBbwA+eqg==
X-Authority-Analysis: v=2.4 cv=D87SufRj c=1 sm=1 tr=0 ts=6abe8c6d cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=9IdpS5SbVdai3JfGgc4A:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 adultscore=0 impostorscore=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010066
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/hexagon/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
index 7b220174ff1..c46d90e3954 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -84,6 +84,7 @@ tests += {
   'test_lsr.S': {'cflags': asmflags},
   'test_mpyi.S': {'cflags': asmflags},
   'test_packet.S': {'cflags': asmflags},
+  'test_pnew_jump_loads.c': {'cflags': cflags},
   'test_reorder.S': {'cflags': asmflags},
   'test_round.S': {'cflags': asmflags},
   'test_vavgw.S': {'cflags': asmflags},
-- 
2.43.0


