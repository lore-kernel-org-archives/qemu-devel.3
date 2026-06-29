Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF0BC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:03:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we3A3-0002lj-OH; Sun, 28 Jun 2026 23:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39z-0002Wx-Pm
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39y-0006PR-4w
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:51 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2d5ZZ1544214
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=; b=SUk9Fi+eVAdUqeQX
 pzlecqYNKYf/ob/ssDx6KC8bpjA28QA38LfFMbWsiubUJi/yQW/K/NTl6foECkX/
 MxBc6O19gcgaMr7rAT9n/3L27sCyed9Sjj/v5iOKkiJL2j2Tx7guxye6kgHVGdBR
 o8d7xUIASvYGEI2he1H04lCLMWQcjC67qTQR24DrMS4sHEJzxABeOCPpTV1iX7gP
 gPOhTCvqb1hHt/uLv0IvNgqlDb2BiD/qGGJvIqeqFUEX7SzjhK1wKlap8biznpMr
 HUyNVG7BV88N5wm54Tn4xrFH3J1tCMm+4sZOJ5bJEL+yAbg4I3Kioa4AlqA6t+A8
 2CHDmQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f26tumae2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:38 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1384427c3efso8557818c88.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705578; x=1783310378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=ZhK52mDoVJnOSiZmJDNyRCZ9fpqHLjYFn3z1gEk1cMS3ZLEyU6jR1uYW5NE6BDFjAd
 qFbd2M38hGM/eiei47OyT8B4gVfh6MQBhZK7jQTZzPGQewWuBvFxuSJCeF3kEx07aut6
 JCdA4/CfGv7Who3Qd8ogMMkCkd9YSsBcRaJnNG2Or9cZosXJuRKzGKayyIBgSoYz4as0
 Z2u4vDrsVBLZUPYKcFxt379TExuClYT4zc4pzsQBHM1SLwJIFXRLtheOdXnV7n6L49EZ
 qZc+Vpqa87MPrqejbdGdrq6FWnYSWh1gEpVD73zsuzn6IkaEwaiMoSK8A4wDD8TZc8U8
 jFUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705578; x=1783310378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ohgluABwS6D8saHfHv2eOLCkXGQOTd4JgFhw3pUO1aE=;
 b=gTZ348HAK0jU+zzYrf8/BtUdDrD5On4ryKLmhnRsnT/+QTGrGNnVTvBru+1RKbv3gX
 HnIqoKavf+oVFXzPVdllm7h7G0Y+WDwrZ8msaHaYVl4dLSLB7a8K+DC+AaxaGEOZoMV3
 z6+GhcYopiQiU7f96e2nI/UXO9C9ujGJ89qAPq/6+bTRJ5rbb3hpyL3T3Ya8F1Ix6vep
 ISgZzddJYKz5GZ1Ir4GqUVOGf/+2XiCzL05OE1sbYuMlkzHwLN8X6ger5rFaU/4VjMC2
 FP1huWaVEM4PKwzRK6ppInMAWqZ/HbGXGxkS/nSdK7OdCHLhIbJ97OXKQKE/3HtB6HZC
 DDPQ==
X-Gm-Message-State: AOJu0YwKXtp2zkKcvueYmqeCVnDgu8oVMUCF1ENYDbvu5RrqXsermF2B
 GGkdMrlg7zUcXSdGvcJMYrDEQ0vNFFxp3yFXUNFvjUag10gSqIKNaht5ZvOJnahQr3FlyHL0Rd1
 sNJtKrby+ZUOHlN6QaZzsS2O3xiVgI0zG8BLc/BcCNmDGTnxA0coKl9/V96wnlHdfVw==
X-Gm-Gg: AfdE7ckJHz3hC/gPSp/A9a5q1qg1hD7p/DH0YSaEptf5Q2tUiqzrP50X0/c00zB4KnR
 JQxVFlcRyN52pqYzD1xltoeOHCR7FXM+OvPXkzHdr0tAga+67Cr/7qTqO39bNIDPTy6oHDtVVmZ
 gPN4G8iLr60QvCBqHQkA3RHbnxaM2cgZB1w/IOsHieE65g+cy4pJ51AsiNH7r0gH7O9SLVQ2ovV
 +kYJD95jF7iGugLwHu/JH+1Jjt7Gsu+MZBmKT5kxD+Yc59nw65MsHA8galbsjkJ5/jJLtNMAcaY
 PDl4IXqRL6oHW/CgXgHZjz/kSdIWTcSE8VuwIc1QrB1hcPxIUN58gcE41Hzb8WTlNgXLNy76elA
 BywRNZYgL6bw5eGEZAhzrImKMdK4GfHURZvVQSWIdrqGcEGUmKDfdKnztcA0=
X-Received: by 2002:a05:7022:43a4:b0:137:f49d:3388 with SMTP id
 a92af1059eb24-139dbb5b144mr13109020c88.21.1782705578034; 
 Sun, 28 Jun 2026 20:59:38 -0700 (PDT)
X-Received: by 2002:a05:7022:43a4:b0:137:f49d:3388 with SMTP id
 a92af1059eb24-139dbb5b144mr13109004c88.21.1782705577548; 
 Sun, 28 Jun 2026 20:59:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:37 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 39/77] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Sun, 28 Jun 2026 20:57:52 -0700
Message-Id: <20260629035830.1520296-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: utmRqlFzHS3DVUJAUU5VNPp_WbkBEPTm
X-Authority-Analysis: v=2.4 cv=A8Rc+aWG c=1 sm=1 tr=0 ts=6a41edaa cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: utmRqlFzHS3DVUJAUU5VNPp_WbkBEPTm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX9GXfkoZX0w3n
 RBGpY0CNyqp73VSN7jvjFag7zq5QzumI5I9eA1JcJEv5kSxYy0fqa68wk/FMyLl3+vUSnjO4l7f
 abzFB3CsJ+LM8dJS8a1vdyX4NrhmQv4UajOgB83PuU96X2pwDAH9eATUM3haL7HnMzI+6NXYcOI
 1LT8uNPTLXC9IoOx89YrnZOClV4SSgMARvIEMzI+c3SSI+8eySWbfQrjAu37Z9TbaVBWLIe5LTw
 YJmhDzDJCeWUHWX8I4Z3Q7q88TiTVgQKFAwmh2++KzVQk27f2Fc08a/U9haNnafck7Knv4Y80Dq
 sggASmhkYosPtW6h3kEirQrUa3k9ZX7C+4kN6zvQDNf6Ff/LoI/PphIwEPS7lfh1faH4a0dl6j5
 luG5es72u9XrTni4JKK+ry4aRAfh7kXE63eqwhjn6/I3gMdC5m2wqLiAVDykvccz7M3iF/dwn4y
 aga6RrqHIpUmpLVkcWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX6zZiSOxfNOD8
 HjxrhEhw6PVcCZe97FfsamGHlxN0PpZbzqb5S8znRHML4PR9ZawHe03QR88abL6aEPqB/HMoh21
 b66uSVP8UtICNg0+TKp6Xpwujqg/dYo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290031
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IDM4YTQzNjQ3ZGQ5Li4wNDFlNjhhMTUwZSAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTY1Myw2
ICs2NTMsMTYgQEAgc3RhdGljIGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQs
IFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9b
RklFTERdLndpZHRoLCBcCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERd
Lm9mZnNldCkKIAorI2RlZmluZSBmR0VUX0ZJRUxEKFZBTCwgRklFTEQpIFwKKyAgICBmRVhUUkFD
VFVfQklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0u
d2lkdGgsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0ub2Zmc2V0
KQorI2RlZmluZSBmU0VUX0ZJRUxEKFZBTCwgRklFTEQsIE5FV1ZBTCkgXAorICAgIGZJTlNFUlRf
QklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERdLndpZHRo
LCBcCisgICAgICAgICAgICAgICAgIHJlZ19maWVsZF9pbmZvW0ZJRUxEXS5vZmZzZXQsIFwKKyAg
ICAgICAgICAgICAgICAgKE5FV1ZBTCkpCisKICNpZmRlZiBRRU1VX0dFTkVSQVRFCiAjZGVmaW5l
IGZEQ1pFUk9BKFJFRykgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

