Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BDCCD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5CO-0005w6-S3; Fri, 29 May 2026 17:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CN-0005ri-1G
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CL-0000YY-A0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:58 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2I8c589615
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=; b=nFsJwVJvgF/0M651
 ++usH3hgnEGutGRkyscmOvJxaVrd3dPlL8C5P6fXVNBo8L+SHXYmZ97rbIbcECFP
 fnjqf4wXEqEobEwu8olVEmm+Fcakzn2szdMSyuG7PGOFdyBF0t/PMU06fr6C8GWR
 /XD7bh9M6FyxUOiM4WgDOLh7g9BEQc0inOT9uJUm9fmjCSqChdQFd+V7gZspjBYF
 BsDmjltzb4eJuwh9RgVWXt7f7QUL2Srq9PtnkqY1HQvgyV/VJBjgywTqmlT9UtmU
 OvgSBeg1jfIwLqkWh6C+hgrIFsBfYGYloxM7Xr/76tOdb+MIJ1WB/gGRinoc5rb/
 TcsZPg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rckbs9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so5135703eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091815; x=1780696615; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=azGentyQryG+AVMCGOFeb0lKzDyV+UGIK8mUXubcTfEBnvxlTwVQU7O2bIyW6JigiR
 F9wdECPM3fTHpIbvtrBBFGhrbp0NXVbZ57NQlhjGFg9oJ4Mg0yZjf8EvcW9DHIeg9jh9
 AywsnIT2cYwX/AyeK23ICtEeXqiwfCb3QKgY/zeGTTojiPmWL6wwUi1vmmovBiXkn/J2
 4jtz0lnbXqFPwCSgxPe7MUQSMiHRhfEHGgUJ0FQio19cS5uTA63B2XP85gLNdhUkz0r7
 T94Fm0GHWV79HqWLv8QQMTWu2knr1pbsoPPA3Kj356fj33lO2jCKURZHeCIqkEs9HIEi
 wgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091815; x=1780696615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=KdQok+s30FB2s9LvKxlKbMpm4U/8cfuaU0IB0TorUX2vBebxGUHLcmTJ4TaPN0bJJe
 ira+CR80SMm8+iiotpdt262f571YscuNSTf0EjZDfkA49rnNypjI9f44kc4vs1INbpLa
 e74B9KVwgzdCYwSa+V0gqqjaurJxJ1RFXABI8GpJHdUJ7WITByBEcRp1VIg7QgLoFY1f
 i+8my7cFKFf5rLFHgD4FOe+I6TClhiol4h4VaE6+4PuJYta/T5PEXOJbaxaWxR7Wq60o
 HKpayO/NoTCmfBu5k/1urQfRaap1almVzmqq9akttogIvuUJ5UaaSdiBjSAx2XtO0Aom
 rOLw==
X-Gm-Message-State: AOJu0YwYJ5Fb/BGHbXQrDRtpLyv4U/Jy5/kqds/XiZJBZIwChra1ogqS
 cgDg+4hTbpCVDa6uXsqJ0hFGD43XJxpPcoCGd2K8cWReLf/GG7SaIpVZJDZpoYQ96xkuIQQaVnJ
 XVulTOgeXC8KhCwq57aMYOMGF6NYVIPbqhZJto580zcuTLBKrvh9UZqtuG9Onmg6HIA==
X-Gm-Gg: Acq92OE/ElNfOM9Uk8wL+eAxTFxeVP2hJv9A5W0sW+LtjHmqtBq5P2X7VRvL5459xln
 2x7mU3hWfwSJZB074Qt7J5ADFRnWYRytFYfp7Y8i/ZTM+BcCeCASIQ6ILN/6ddHUgVmq001NCRM
 YQz9C3XJ/4c+aPk2oUhTNITGXMRmUPLKY6b1xIzCP55Skc40Ti+zFRSZTs5o0jfm5K5U857AVBH
 6Gk6B6HCczGc3HYV/7Rug4UfPVll0bxvB2c0srKbsIH9gOdwq/9whdS36wsjXZ9XVJCEDUjyVIe
 LTM0sP43wTdIYLIM3Gl6YL+qKeBnvjqglYzZXWfMDLz0Hm+Apuj7Q7GFJ8n6lR/1hglph94Z5Sr
 sAjvv/jMU1h8Z728hJf2Lti0nGivnXDICTiZSd3hbwp4luzlyqg3d1CmO9dnsuHcmwKY+p07MTV
 /vGoh5
X-Received: by 2002:a05:7300:8605:b0:2dd:6937:79d5 with SMTP id
 5a478bee46e88-304fa4c7c24mr960232eec.8.1780091815115; 
 Fri, 29 May 2026 14:56:55 -0700 (PDT)
X-Received: by 2002:a05:7300:8605:b0:2dd:6937:79d5 with SMTP id
 5a478bee46e88-304fa4c7c24mr960218eec.8.1780091814577; 
 Fri, 29 May 2026 14:56:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org
Subject: [PATCH v7 34/38] hw/hexagon: Declare hexagon TLB device interface
Date: Fri, 29 May 2026 14:55:50 -0700
Message-Id: <20260529215554.606133-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: VgR510fIG4ueulbFzL8Q-mJXwpSawMo3
X-Proofpoint-ORIG-GUID: VgR510fIG4ueulbFzL8Q-mJXwpSawMo3
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a1a0ba7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=p_7iY2stt2bzV07uMJkA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX6LmcgewQ+ncr
 HpfpVqnDb9W/o00oFM6wue28fVCxxZ4psYIWn0C4nJQiM2fXofN8/iFukJW8M16Hbw4df+IRZog
 U7fD2c2XPIGeW3Qy5N9PI252Rb5vcx5eERbfRlouqVZeAvM8cUnaVKrk4HbZFu7PcT4ctRLej8l
 Mm8vyJZSuLHAt1LgnoeoVl+tcm/SPjJNtuNCPb/IWKArNhvsjNJJ+XM3RXTG3iPMSSYghkRchQq
 N7N8UHFlQXT17hPuyqtPS7O+vbJREPr6wzth79ZJfuy5U/JPi8a5b6VrJmtj5B6NEU0duEjSo28
 +jhP8CJ6+DK02S+UP7eG1c/FFrrdzDBuqcuBTg2nFae3hwsNABgrmLHcNHVnvnd2/ljWwDi6nQ1
 kt4Svb5RdH8q/W6i9uugzjudnGFM0vAj7EmIp7GdaD6VMUXAT7w4fwx82Aw3EkHR8jZoSbXDRHm
 S2lDQ3hDKLAK6p6zNqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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

QWRkIHRoZSBoZXhhZ29uIFRMQiBkZXZpY2UgaW50ZXJmYWNlIGhlYWRlci4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90bGIuaCB8IDQ2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmggYi9pbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbl90bGIuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uOTBk
OWVkODQwNDMKLS0tIC9kZXYvbnVsbAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90
bGIuaApAQCAtMCwwICsxLDQ2IEBACisvKgorICogSGV4YWdvbiBUTEIgUU9NIERldmljZQorICoK
KyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMg
c3Vic2lkaWFyaWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKKyAqLworCisjaWZuZGVmIEhXX0hFWEFHT05fVExCX0gKKyNkZWZpbmUgSFdfSEVYQUdPTl9U
TEJfSAorCisjaW5jbHVkZSAiaHcvY29yZS9zeXNidXMuaCIKKyNpbmNsdWRlICJxb20vb2JqZWN0
LmgiCisjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCIKKyNpbmNsdWRlICJleGVjL21tdS1hY2Nlc3Mt
dHlwZS5oIgorI2luY2x1ZGUgIm1vbml0b3IvbW9uaXRvci5oIgorI2RlZmluZSBUWVBFX0hFWEFH
T05fVExCICJoZXhhZ29uLXRsYiIKK09CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEhleGFnb25U
TEJTdGF0ZSwgSEVYQUdPTl9UTEIpCisKK3N0cnVjdCBIZXhhZ29uVExCU3RhdGUgeworICAgIFN5
c0J1c0RldmljZSBwYXJlbnRfb2JqOworCisgICAgdWludDMyX3QgbnVtX2VudHJpZXM7CisgICAg
dWludDY0X3QgKmVudHJpZXM7Cit9OworCit1aW50NjRfdCBoZXhhZ29uX3RsYl9yZWFkKEhleGFn
b25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCk7Cit2b2lkIGhleGFnb25fdGxiX3dyaXRl
KEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCwgdWludDY0X3QgdmFsdWUpOwor
Citib29sIGhleGFnb25fdGxiX2ZpbmRfbWF0Y2goSGV4YWdvblRMQlN0YXRlICp0bGIsIHVpbnQz
Ml90IGFzaWQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgVkEsIE1NVUFj
Y2Vzc1R5cGUgYWNjZXNzX3R5cGUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRy
ICpQQSwgaW50ICpwcm90LCB1aW50NjRfdCAqc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQzMl90ICpleGNwLCBpbnQgKmNhdXNlX2NvZGUsIGludCBtbXVfaWR4KTsKKwordWlu
dDMyX3QgaGV4YWdvbl90bGJfbG9va3VwKEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBh
c2lkLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFZBLCBpbnQgKmNhdXNl
X2NvZGUpOworCitpbnQgaGV4YWdvbl90bGJfY2hlY2tfb3ZlcmxhcChIZXhhZ29uVExCU3RhdGUg
KnRsYiwgdWludDY0X3QgZW50cnksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCBpbmRleCk7CisKK3ZvaWQgaGV4YWdvbl90bGJfZHVtcChNb25pdG9yICptb24sIEhleGFn
b25UTEJTdGF0ZSAqdGxiKTsKKworYm9vbCBoZXhhZ29uX3RsYl9kdW1wX2VudHJ5KE1vbml0b3Ig
Km1vbiwgdWludDY0X3QgZW50cnkpOworCit1aW50MzJfdCBoZXhhZ29uX3RsYl9nZXRfbnVtX2Vu
dHJpZXMoSGV4YWdvblRMQlN0YXRlICp0bGIpOworCisjZW5kaWYgLyogSFdfSEVYQUdPTl9UTEJf
SCAqLwotLSAKMi4zNC4xCgo=

