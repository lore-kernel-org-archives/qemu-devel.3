Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79D6CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 21:49:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wX4JK-00077c-EO; Tue, 09 Jun 2026 17:48:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4JA-0006sA-SW
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wX4J1-00087F-E0
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 17:48:24 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659K4Gwq3229818
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 21:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=x73CnRpHc6q
 Jw1lBr7pHZdPL4NlO8wFYpVniuD7+UrA=; b=G0Ol8EPeNc1XHvd8iKFhI0qur3K
 UUrEikZhP74FfI5ZFgM2093LFxe+OI3aT17ipRBDs2x2MqhzLuS4tGAj0jwBUDGD
 2dSyt+B7s8d78miFRCT9wtFVLDjy3/FNg9q5Y9Dexf9CPG3x997XPDsIXO0UYKDz
 tHMVkW3IzuWXUPfFSjxtMzyUSg06WGaDDwyy3mE+6isinHnp14Ds9sMY8BvkUc0f
 PfXb8bDTwQXxk+002iMAJYnwl4gsJfgdQqZeePqHdLiT6uU+c35GXathQEkYoZQ0
 ihvxaUseWb/+XyaunAXmiCMFmbTBkyznigyp/1Dq6BChfowC68YWOOw0wKQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epeqgkxqs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 21:48:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304dd917645so6455896eec.1
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 14:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781041687; x=1781646487; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x73CnRpHc6qJw1lBr7pHZdPL4NlO8wFYpVniuD7+UrA=;
 b=bgqsI1HTCy2/u7LKjhN0A41FN3jsH5nrZxOJE5y6RT01CDQKKHe7DFCro9OWXX3WA5
 dO52fv1yMuTAeRUCOhpB/g9LNEYUXz28GVePyQvMeKjmHx76yEGwQHAqj+9pVZHTLXBQ
 qmPf0npiUo5LSbqtHYP+l1LPcFwmzpgxeA+Yx91zdAoF+xp2AU59fF55OuZ4HmTj8Mxl
 XgoiKSbjGcKOeUoXgyzc78nXdmuBdYEG19bNSaYLlNGCQqvlA9muCuDZJJoQsDYSneTc
 V+pOs0wHhoVVsSEVNpl3fATx5vj5ze1Vbfi6yJvutWtGCIjINnms4h5hr3iY099U/GAb
 3aHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781041687; x=1781646487;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x73CnRpHc6qJw1lBr7pHZdPL4NlO8wFYpVniuD7+UrA=;
 b=IjHZ8fkGYGwvgbVpylt6j9NteSLFXIKLbgtJjJ95PRvqXuYHtt4f9qfsTwsegDU3jB
 kwCbB9jq3ibsqSjWToaxpWJlfSIgWOwXWnyV3DEU4l0HzwxyogNV8Qg1HQhq/WiMQSLy
 +/WblZuhuMMPQi8jxB42EAu1btpQj+/WEbB9BGNuAOCqfjX5RgCoXmK7KNR+qqvB+RhS
 nufSyLCiBrVgI4C2bvbdo8eXCnzLStFw5QweWrYdqnhObHWdC3eZkf2sXuNHso8lrT0s
 b0PkEtlKoo3PUsy6SR+JInwm8GEnec6Z8LHzXzTaaz9dHQd/xhpaTu6mtTCrbweFXppa
 mWPQ==
X-Gm-Message-State: AOJu0YySQsS8vWxNglV4Bx0/cIkcDyz8SgeU/+OHVu9Ur/te2cyEt6pA
 dyf4po6Xywn2zzpgDnqzONBPrlH5DcDOI96y9GPAxS1QgvRvJiZ5PLdQb03KCI1JJiDKyjTezOC
 QqOgDmPNbxDzKhDIL/eAohGkIAaB3emBFy0YRAY5rxytP1dr82a4epjA9Gz3umv7z0rNN
X-Gm-Gg: Acq92OGc+Joj14ZKhX1M5bd9JczIpFKnSN5bFf8JZ9GE8t8o4CdI7TvlNw9d5c04hxu
 lWzyHykNOIErwTScSgWWTN+dqYu4ZLSXJIZ4ujtrRvv3uhnq8XOZQFBuHDdePyWsvcF82QefFEV
 Q2Gk6/Ta6KLfFFCI37SCXOEWxbRU39LOpML3xdn6lGgPb1w8iH0IWTYzuqY7j+b+V0esKNBFtlx
 wGJqd2fiLTTcAIX8yxPe1GWclLum/0biAp6A62bdB4I+hpYNetI9aQkvUTrMwTkJzyXGzqZ1sSx
 3lr5UULvCIDQJQjuDZkzNWITumtUf9eGQYKlHIi9tXnv08D1d94atpdaOsRzEyDd65gPC9TC/p/
 ZLb0vpi6FvfvdJbQx+x6A2vKKzsMwJnyr89Lyy8U8gPgW8i88uc8ApJkhTf2JmDB1K5j7AMOpZy
 T76qYJx+hOgA7iBEcT
X-Received: by 2002:a05:7022:f81:b0:137:4062:4c1b with SMTP id
 a92af1059eb24-138066d1951mr12378228c88.11.1781041687495; 
 Tue, 09 Jun 2026 14:48:07 -0700 (PDT)
X-Received: by 2002:a05:7022:f81:b0:137:4062:4c1b with SMTP id
 a92af1059eb24-138066d1951mr12378199c88.11.1781041687026; 
 Tue, 09 Jun 2026 14:48:07 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f5550bcdsm17095895c88.14.2026.06.09.14.48.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 14:48:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>
Subject: [PATCH 14/27] tests/tcg/meson.build: add default flag for testing
 compiler support
Date: Tue,  9 Jun 2026 14:47:32 -0700
Message-ID: <20260609214745.772536-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260609214745.772536-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDIwNSBTYWx0ZWRfX7pjJPs9WN/jZ
 atq8/kE+hktYw6J6/j6Fcz0on7BfjD09/hQKjoycEIIzBmudZw4go7qvOmwCkMuZ9BrVmmHTFxA
 95hWHbV06NwacCYciw8GpXaWCRpuHzsN+gP51EQ26vXzz1m4N/fP39bR0RRKtiheVInXu5vQfck
 V1VuZLgbpBkbwYfhl3JOZq4MEITWa9iYsQK5ptnWAiED39VXh8BuVnHDqe7/Kf8kUwrxTY0mMy4
 0exqHIoPVUjmXisahvtFIjlolQXRcYkVFRRqXx/oYfKVzj71CaHOL0PExX8xvkTZ2O4imQxOSE0
 d7x1cOSt+u4iB4rJhmv3BpyFZkAC/WJTi7tq7O+7TuC2Ng878Y4aTpNVnDBQFqEa7LiFC/vJxVb
 Kb39aCi8uLSInGgdYjykaZJWrR2VZYRvr0GGKX/aO2wcmz/OA86nIV9TJJ+IXXCZgDFt3tX/4B0
 0G25iDtI27CpzNFzLwQ==
X-Proofpoint-ORIG-GUID: XBbvIG6ajJHzinMRKTajpClufZ5w3c2M
X-Authority-Analysis: v=2.4 cv=KdHidwYD c=1 sm=1 tr=0 ts=6a288a18 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=ipGdpegYSuLUQ3QCAGcA:9 a=zgiPjhLxNE0A:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: XBbvIG6ajJHzinMRKTajpClufZ5w3c2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090205
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

This global variable can be used as cflags when checking if a compiler
supports specific flags.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 tests/tcg/meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/tcg/meson.build b/tests/tcg/meson.build
index d0080eb0f9f..aca59933d71 100644
--- a/tests/tcg/meson.build
+++ b/tests/tcg/meson.build
@@ -1,3 +1,4 @@
+cc_check_args = ['-xc', '/dev/null', '-o', '/dev/null', '-c']
 env = find_program('env')
 
 gdb_progs = ['gdb-multiarch', 'gdb']
-- 
2.43.0


