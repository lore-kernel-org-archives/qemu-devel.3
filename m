Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8C9FCD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:56:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Bf-0003Mj-U9; Fri, 29 May 2026 17:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bd-0003Gm-S7
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:13 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Bb-0000M7-JV
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:13 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2Pw5518563
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aZbuEtnVCjIpsy/5KpvYanmAQki3lti3DT9FIRiZ2S8=; b=IJYI4xZf+grnHYsX
 7a4zjDoXI3IJAFyCKVfdTZiB6zs/+rRXEqTyfFxjHEisCsqxrvfMmliAFPIkD0Kp
 TKl2jUU2MpnKEzfT7yvqWJZFLhp25oUNH13NdaYioIQkFmf+s+uAEqQgqb/8Fi8C
 xGowoQRqZ7336+711lr0RHVpAGA/tv6mQ6nfAYjJLMxTp+pQlNejnxAAiaYXoo4i
 GPH6zZo9qUPfOxpkrdgy/rzxT8RuPZK8F2TH6K05XXxIah1NbFGyPp350G0h1Cbz
 +dTeSrcQcvWfhPJc7wFRrnn0AOaPtQX0DHrXEHK4bsNipAmAMcXhxM1cSOoLpVv5
 Sal8fA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efechhkqe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:10 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304ed777a96so465658eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091770; x=1780696570; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aZbuEtnVCjIpsy/5KpvYanmAQki3lti3DT9FIRiZ2S8=;
 b=Gq4udfxsZ6hfK64YCNMxw5W+Wtm30qu+Rx/B28ETkq4PFmGCtj7a9L+WtwiHpmzoyA
 WP/B27IOZ6lHhk4ljg3EUQyTp3+XV+kKFdy8mX3B/WTCEo/fFPmC4O6e1lqrdGcWQrCo
 RGXmv8EV/Av7MZ8DsTq222gSuoWHxSWyKpPQcsovUZ8tizc8XVhHVxgbLPyHiZikDWOh
 i7QbbeGhACNzyHkrMPX/K/p47+drZnhgD5lIGku1KtyrH2JLmJeiN4hoD3AjwfQ/+7Xu
 3asnIq0Q4SQiT7TS2C+SUMwzSAlRJKUmxEC/wHsprBXpaLVAV7pYkgwDK5Ud4+sp3woK
 P6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091770; x=1780696570;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aZbuEtnVCjIpsy/5KpvYanmAQki3lti3DT9FIRiZ2S8=;
 b=JL/Q+aLnyHQ2w04AMWvrOI/9pd2ISd6PSRxvrtEdGmyNejIfsZD0LKiI07PAtoqMo0
 Ux9eU735j9XSCzdwhMMETN59FJAWefQM7B4ibrHpaBFM0Fxk76teJ5WGQZkWT/RVqixh
 hvNH8Aj4DE5dHYmj4FK4eOB39PKtuwVCwSXD03FmZ1SXChWnBuAWyA5/Xa/Tv2OfzjBR
 ogheOFWxOjpC1MO/pqewPpC4Xh0HFqgVP25UuHyFXo/M7E+wS92zV+4psehC8jo4/Dun
 xoAzh4ymFZut3nyYX0aMa/jP06i/3e2we7pBcB8o/nmTgymD9bFozsAVYn2xzueLKxvp
 wsOA==
X-Gm-Message-State: AOJu0Yzs5KD07/R9ZVxr845YP87ar6KhcAds0yY/9GFhVen9FFIDEyrA
 D0X0Ww87B4cl7fVASQlLXvEjluhngYTzH6J7Hh6o2O6mKgycy6UZa+aDDExziHnS519gYie0LE5
 E5G/UahMQI9pGiO6Re11fE7cHyDrqSyuJIP585SPC14Is/Lwo2PSFIQqs/Bw9CQ8Qcw==
X-Gm-Gg: Acq92OFlBhMWLMB7fq0fc60iMXz8430kFS97leaAaMKn1UjnHGwA38jlGbZ/+vOiumt
 0t1rHXT6DBWZJB1w8gxCp9wHDgmMpE81xvPNqjnJzU8IfK07W5VXsWS5kWMs4v8F98sOVP0NIfW
 cZFj/LrguCc+xfd80URClN0cqMPAcNgnW7CKVkQGQKe4TsPyPJUy0No15FFGzL2ugeD7mt26pDu
 r21XnRMWrWSOEIklHRUAqwUts/stVxviAp0twF3ANu2Q1BjK3ThoED85Xs7yS4THzMcjxffNBBx
 qApLnLQYiiLlL7v6TOH46XzhufAqHZ7+lKT8NZuJb2VolKxrLUpq6Tt9fFNQwI0j75tSpCofyJC
 XU37FbGX6oduZ/IkjF1Q+L7Lb3+K8bzrFmpO+XMysRoNmFDrU9gZJs2ppWgBtj6nhTVibKLgAok
 4MpFQg
X-Received: by 2002:a05:7301:9f11:b0:2ed:e16:6b39 with SMTP id
 5a478bee46e88-304fb2f6092mr479754eec.17.1780091769638; 
 Fri, 29 May 2026 14:56:09 -0700 (PDT)
X-Received: by 2002:a05:7301:9f11:b0:2ed:e16:6b39 with SMTP id
 5a478bee46e88-304fb2f6092mr479742eec.17.1780091769036; 
 Fri, 29 May 2026 14:56:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:07 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 07/38] target/hexagon: Make gen_exception_end_tb non-static
Date: Fri, 29 May 2026 14:55:23 -0700
Message-Id: <20260529215554.606133-8-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 0fVbIBTJg0fsBjGpMHnV6ensmq-ND6iR
X-Proofpoint-GUID: 0fVbIBTJg0fsBjGpMHnV6ensmq-ND6iR
X-Authority-Analysis: v=2.4 cv=U6Siy+ru c=1 sm=1 tr=0 ts=6a1a0b7a cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=t4cj51CzC67JwBy76UgA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOCBTYWx0ZWRfX9JeaObd0EmxV
 yg4PiBT623pF6lrnrJnHFESfXx/gTOGBFhXfcw9vwUwyuQhQS6RXe90LO5IVzLlYM2X6m77eJqQ
 dMnTt/ow4ZuoIn9IRQh2h9j/FrZ5/YKFSUYdT1kfMYAm4wwpDdhOvI+gDEO5KHqwrN5OEA1J5d0
 HGOX0DZQrY7Q7JR+Hv4AhFCckPiq7sFDy9CGtqcDtJDwA0mqUem0uj5XglTD5fS30CyyHI7gejb
 o/N1c1qHUGr0Ly0O41wxz2lI5aIJ584IWm05RZDOeJzLZJqi4hJ00t8+O6RxhC23AKAuVnTWRqw
 n5Ha/uvsUJMMEn4U6LRL3Eu9nWkLKusGmt1yPmUAtKOkjoirHMjX/Koj4bp+tt0XMO2nZzM4Rx5
 QDoHouiyTaEbYW5154foPn7aMSMlcRsfHL6AlnHeiIuD3Q7yMyryP6G+wtGgZvjoaQkcdlFKQV6
 d+vogqVb1zuao7NFXeg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290218
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oIHwgMiArKwogdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMgfCA0ICsrLS0KIDIg
ZmlsZXMgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRl
LmgKaW5kZXggMWZjMTg1ZTNlZGQuLmQ4MGJjNTMyZTI0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4
YWdvbi90cmFuc2xhdGUuaAorKysgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaApAQCAtMjgz
LDYgKzI4Myw4IEBAIGV4dGVybiBUQ0d2IGhleF92c3RvcmVfYWRkcltWU1RPUkVTX01BWF07CiBl
eHRlcm4gVENHdiBoZXhfdnN0b3JlX3NpemVbVlNUT1JFU19NQVhdOwogZXh0ZXJuIFRDR3YgaGV4
X3ZzdG9yZV9wZW5kaW5nW1ZTVE9SRVNfTUFYXTsKIAordm9pZCBoZXhfZ2VuX2V4Y2VwdGlvbl9l
bmRfdGIoRGlzYXNDb250ZXh0ICpjdHgsIGludCBleGNwKTsKKwogdm9pZCBwcm9jZXNzX3N0b3Jl
KERpc2FzQ29udGV4dCAqY3R4LCBpbnQgc2xvdF9udW0pOwogCiBGSUVMRChQUk9CRV9QS1RfU0NB
TEFSX1NUT1JFX1MwLCBNTVVfSURYLCAgICAgICAwLCAyKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hl
eGFnb24vdHJhbnNsYXRlLmMgYi90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYwppbmRleCAwYjkz
MzdkOTEyMC4uYmJhMWE3M2Y0ZjQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCkBAIC0xODcsNyArMTg3LDcgQEAg
c3RhdGljIHZvaWQgZ2VuX2VuZF90YihEaXNhc0NvbnRleHQgKmN0eCkKICAgICBjdHgtPmJhc2Uu
aXNfam1wID0gRElTQVNfTk9SRVRVUk47CiB9CiAKLXN0YXRpYyB2b2lkIGdlbl9leGNlcHRpb25f
ZW5kX3RiKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgZXhjcCkKK3ZvaWQgaGV4X2dlbl9leGNlcHRp
b25fZW5kX3RiKERpc2FzQ29udGV4dCAqY3R4LCBpbnQgZXhjcCkKIHsKICAgICBnZW5fZXhlY19j
b3VudGVycyhjdHgpOwogICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBj
dHgtPm5leHRfUEMpOwpAQCAtNTgwLDcgKzU4MCw3IEBAIHN0YXRpYyB2b2lkIGdlbl9pbnNuKERp
c2FzQ29udGV4dCAqY3R4KQogICAgICAgICBjdHgtPmluc24tPmdlbmVyYXRlKGN0eCk7CiAgICAg
ICAgIG1hcmtfc3RvcmVfd2lkdGgoY3R4KTsKICAgICB9IGVsc2UgewotICAgICAgICBnZW5fZXhj
ZXB0aW9uX2VuZF90YihjdHgsIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSk7CisgICAgICAgIGhl
eF9nZW5fZXhjZXB0aW9uX2VuZF90YihjdHgsIEhFWF9DQVVTRV9JTlZBTElEX09QQ09ERSk7CiAg
ICAgfQogfQogCi0tIAoyLjM0LjEKCg==

