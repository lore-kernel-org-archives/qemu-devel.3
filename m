Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE1EBCD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5FE-0000fd-Si; Fri, 29 May 2026 17:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5FB-0000Gm-RF
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5F9-0001FX-Lx
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:53 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2LQa2998043
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uuMHcL0trMHU+gkht0/J3heu7FTwckdHZYJQTdw0Nbs=; b=lSyxLr45PEomURKR
 iveu/6VLCYYS2UlApEap6w7oe38/ZTL8PNQZXuuuSON1Sq13/jm62VQyOmH0F8hK
 Nv9V74cuhQV2r9DwrOAhjhuDCJLqO2N+KgFlp143J9ckTJ3OIB9jgemTO1aDhNwq
 Z2r/MNag3wjB9BcNOyGTPnRPguUFi0LpAAJ/3iGpaaJ1CywEALiSsumBi13TPakz
 s0znMhfGMCYQJ84S6Vdidw8l8F/F+LymzpNGip4z6D6A0kjlk4kW3dAsJIImwnjj
 9/mSZ1xMStlqb9r6tf/BWgLl2m8Lflu5Oh/lmCNr4U2l79I9ewXBl9BYQVF6cB/Y
 FhTchw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4f0c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:59:50 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-12dece274b1so19121284c88.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091990; x=1780696790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uuMHcL0trMHU+gkht0/J3heu7FTwckdHZYJQTdw0Nbs=;
 b=jcEJNEoefgFAnlGH3OOF5Jb45YoZPWY9kx/RQw6OqpdIpdc4RI+5jUZlPsmexc8qtL
 QO6//UyLHUSZM5nXehrTBW4mNdxzseRjavUaK2m53fZhbjEOw4KoFtokeZ0GOsDb8Hef
 7EdzU0YbrBUYEiRyoRzXoBilBKB45dKQwH49YvpHJzOdAoZ6N4jLujhqV/N8cTO9Vclj
 w3gPWdV02Z9EsswozfU6JMNnMaTfh6LpXLcsqDqFXxEFAI5jxY56gYrMG5gCjDV82NRC
 BNNdk+av+y2Vmd4E+/4XwaS8umZjuv08nIfxSjB8ZZv4RB+fBBNj8BBHVTzyn80bnGe1
 EWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091990; x=1780696790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uuMHcL0trMHU+gkht0/J3heu7FTwckdHZYJQTdw0Nbs=;
 b=ZpdQaFdMoUAgDccOrTmK/pHsv4KUFVq7Ras+QMW7nPjXcO0+w9dXgRaF5EGuaI4zwq
 pMonNsxsetkpMqd7wZfBGjNATUADLpFq0RrrTg6hjHtsEVgESY70fEBbfjomfK2CdkdO
 9Z6VYxRlsg7oHtBzJiq+f2PA6XclLY57n6zmQHrEAEM1hiSq8DCdqKMn5Fzi/k3pfqty
 P+Vy5hu2UzKWGdZdO32KtiXTaTQil4hZIXsxb0Qq3ZJzr5QgIZAtQhNsESSSKPQ7QXLN
 cAvPInCTqJyMnaROetg1RY7H9sgTxsXeCLyoy6aVYZwqLa0gEiC5xFQPIoi4RV86GoOd
 oTUw==
X-Gm-Message-State: AOJu0YxX7J4gQu7tqjvxDGEINp+WWZ5fFkHjGiDrzZtPPgPWwMFt8eNC
 LCMcj3YDlak8tEPSDJiQdPnv14cL0ucRh36sxsJsyBJ2GNMp7tA+HfPztaHhoix5YjVuRsYTe+1
 NovwaYcbQdCjj+f+McXLUMMRYCn+aRZ6azJO4zTVZrBPFcStA/a+zjah7ttCtA4Cvbw==
X-Gm-Gg: Acq92OHyksvWPfsz/9xWAH00ba9peDv0CTg748bRW9GGKu+i3dqjwDItdzWNAgKTJrm
 vEjrmoVMNw4nJdTve0WDm0lMgg8SeH51kQ8hd7WR+VuHiMXmLzt/abH9W/mrE6TtBAOpBCpMNH7
 bYFBL7tCHX7kv1kAM7IVLk36KB67dzmvIj6/6GmCUFdM2i3ikgCD6SpzwLebRnyHXtEMJXlM3Lp
 KzELIqGBJjDRL6rLxEsYZDwvzlhJqkOGTs1/mxNe/jvytEZpym3YNf4RfQNy0mXHalyx8WfIa0W
 ce77c04DtGIPWTcjM21FtJXL8pAUZUGVfBdYoD4mBCjenySmjkAi0YsTgPdNlDBxjEs7shqtl+Y
 7cphUhAJ4Psulue+oG8myW7Cs5GRI9qfVxDs9xoHZy/GI99M4HiKFH3y7IjT66SdZj4TjVTTply
 XSANvT
X-Received: by 2002:a05:7022:ec88:b0:132:5d96:3e48 with SMTP id
 a92af1059eb24-137d42beeb9mr540837c88.38.1780091989670; 
 Fri, 29 May 2026 14:59:49 -0700 (PDT)
X-Received: by 2002:a05:7022:ec88:b0:132:5d96:3e48 with SMTP id
 a92af1059eb24-137d42beeb9mr540818c88.38.1780091989124; 
 Fri, 29 May 2026 14:59:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69c0asm2101445c88.11.2026.05.29.14.59.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:59:48 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Sid Manning <sidneym@quicinc.com>
Subject: [PATCH v6 6/9] hw/hexagon: Add support for cfgbase
Date: Fri, 29 May 2026 14:59:34 -0700
Message-Id: <20260529215937.610229-7-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
References: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX0gUAurwi4cau
 v+PzAh0KiCMJ7iwK4saf8pyBR2uFaUUYLs41ulDprIX9VfXqy2JI1fKUKlTkh1NyagHRlMmrhaW
 w7LozDHo9O1DtLgPu7UFOeZeo7tW1SsCKxZL9hpDbhEXaCKAYACRuOFXKGY0O7AipELaSVGw0xe
 AeU6AMNQtepk6SlJbj0bN5dqqvbEVKElZo/dgmGXsKxy0+r5eE1UeCQySp+hBQbBrzzkEbH7Lqf
 wL6RGf5DM/ZOsswkPxvTHmHouPMYjoqUENCeqQIgZbKa1S/0P/6tWBlB0LmK2d5tE1Gh7cilFsK
 VjoZD27JPpLNeXYcUaDfccdsPoaBv1cl5NHag0x+dvv1pLBCj9xJB6NBxNvt35YGxKKoY7GaA4a
 ZE5qySPND62z+/Ezlt4+64dlh0NLlhhRlnyHbFOnxd0aLsB2ccKtdjef4plaTpngpsXOCbS/TbK
 DDmspFiDoK1+F1qBsRw==
X-Proofpoint-ORIG-GUID: NMcMKi-wLp3KF1EIPK5YBXdN4MJOZCbc
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0c56 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=7umkzkyUMl8fFcUskJ4A:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: NMcMKi-wLp3KF1EIPK5YBXdN4MJOZCbc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+Ci0tLQogaHcvaGV4YWdvbi9oZXhhZ29uX2Rz
cC5jIHwgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgfCAxIC0KIDIgZmlsZXMgY2hh
bmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaHcvaGV4
YWdvbi9oZXhhZ29uX2RzcC5jIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCmluZGV4IDU5MzRh
OTliNTIyLi5mM2IxMzE5OTY3OCAxMDA2NDQKLS0tIGEvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5j
CisrKyBiL2h3L2hleGFnb24vaGV4YWdvbl9kc3AuYwpAQCAtMTYxLDYgKzE2MSwxMCBAQCBzdGF0
aWMgdm9pZCBoZXhhZ29uX2NvbW1vbl9pbml0KE1hY2hpbmVTdGF0ZSAqbWFjaGluZSwgUmV2X3Qg
cmV2LAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgT0JKRUNUKHRsYl9kZXYpLCAm
ZXJyb3JfZmF0YWwpOwogICAgICAgICBxZGV2X3JlYWxpemVfYW5kX3VucmVmKERFVklDRShjcHUp
LCBOVUxMLCAmZXJyb3JfZmF0YWwpOwogICAgIH0KKworICAgIHJvbV9hZGRfYmxvYl9maXhlZF9h
cygiY29uZmlnX3RhYmxlLnJvbSIsICZtX2NmZy0+Y2ZndGFibGUsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgIHNpemVvZihtX2NmZy0+Y2ZndGFibGUpLCBtX2NmZy0+Y2ZnYmFzZSwKKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgJmFkZHJlc3Nfc3BhY2VfbWVtb3J5KTsKIH0KIAogc3RhdGlj
IHZvaWQgaW5pdF9tYyhNYWNoaW5lQ2xhc3MgKm1jKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA4OTVhZmEyYzFmZi4uMzllYzgx
Mzk1NDIgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdS5jCkBAIC0zOTksNyArMzk5LDYgQEAgdm9pZCBoZXhhZ29uX2NwdV9zb2Z0X3Jlc2V0
KENQVUhleGFnb25TdGF0ZSAqZW52KQogfQogI2VuZGlmCiAKLQogc3RhdGljIHZvaWQgaGV4YWdv
bl9jcHVfcmVzZXRfaG9sZChPYmplY3QgKm9iaiwgUmVzZXRUeXBlIHR5cGUpCiB7CiAgICAgQ1BV
U3RhdGUgKmNzID0gQ1BVKG9iaik7Ci0tIAoyLjM0LjEKCg==

