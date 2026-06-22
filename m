Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251EECD98F2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9f-0003fB-8H; Mon, 22 Jun 2026 18:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9e-0003eW-0d
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9c-0006r7-9K
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:09 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZg9B179000
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=; b=Waz8h/h2UElsDg8m
 kIIf7XINWB0wodiHcS419AvTCpTYpFz89BSepG6JjuibUQZenVGIEQXzr5QlY8WM
 QviiwAGBX8xeR+wp7arVoFUYugLkgMES5wdOoz1s7TkJUIECwjRnUreBZo7wdhTU
 tS2bJJ6IAj2mSzG+2Pp03G8HBEYhkiajAUABD8RP8ijjHvXGS8O7nCYR7tGsDthP
 SJh0heQ3i2jMznTnK/Ddum8aGqwwJZKNP9P9OO3C8lctX5OnlB2Cju71346XrTdV
 1ehQM9Gz5R4n7PRJYfKInqUvTPx27Sw23CCYU7gisvKX5tvkDVPuIqhq0zJbf7y2
 4fvomg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey2yhtjk3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:30:06 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bccca5620so6794885eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167406; x=1782772206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=;
 b=iRDQQbE8C4QaVghVeo5FYmZeOXa5lCAgof1tC3CPG/BvADUtpzHFU62znfIyoLmmmA
 3dZqixhw1SyiPkCP3QgxGmA7a9inw+74oYoFo43qYHlxQxcwfFcHAUAIvNNQjzJk+q5U
 7JmackVvo1r0Q1dz4wPIBZsAajBLkJZJb1hvwYLSLmw3VcGUXR3LD0O4Ud/4BPJXdaJu
 nxjbXGyOW/WFuM6YJ4zJ6Vts8YzoCoADjfYij8kFQap0GzA/l/y+0SEVdZoes0iDt+VZ
 VUsxHjKi7a4VhsuUan84/e58ZEv5YGjHmEOqcqi3inkr6JfS8czKzAU30KI5HMnYrTtH
 Wl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167406; x=1782772206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4QO0cWAkJ+q+F3pETQo9dtN15DOJjfUdoMf8+Tm9oak=;
 b=Up5Rk1KuWuDTjehtRKsf/81Eu9fErihDxsIgZaKj3MFQimylRDp+yFAR4H90UVqIWo
 NpBFZc8g7fW7QN6+LAnUleyDX+uDWp66ILzffAhFc1ns+KCYc+VJBWpjFfzU3N8vy7J1
 dUiHf0xlCAdTYXfBIkI+Z7Un7OOA421BchShZjEKL657ZeP6UMES4+tZUamEAWkmYjF8
 T10QfJl1gDq12ontZSBWVCYN1iZlqu/C11yvR55iHWFyQmOVfo9pCetFDFuNFcgbgaa7
 s/3ZV0XwN1K8+lzrNISS4kAw8c+uaF6h3s8K8EtQyMsOOIMhyFfJ0TlF5ImgEBq3+9jB
 ByCw==
X-Gm-Message-State: AOJu0YyWRmW1zgO52X7jJP/bXQAcjaFYQTakhGd0nEPry73Gu4NTEQv4
 7uQLUWxS2SxFr7oHrOFuzg3AMDEcWSXOC4AOVFDJX+aLkklf1ASNG2JizmvkMHnKAlNPFTOVcSf
 u0qY+/9DM3S1EXbKqpPmFaQiUaNoC+1ZzoQ1jctdsoCrPuxCIx3rFupIYnoqSNM0jSw==
X-Gm-Gg: AfdE7cnU4IqRRDG+MzddJPuhog3Ef44O6F1C0FVbNsbaEfz8UN47P/+NHk5kKCeGBZ0
 0R37EEtLGTlYgRyOLxSCCLHs9h/9gRUQTHJrlwFPZkUCLOvUquZwqlMB9VE2eq8H/nsGe/YjdS5
 JsL6a+XmMFjmrvHbqRRmSavqqwFQwgFdrVn6uK1ax2OHrEOH5o2NK94c4jGoev86l2I2Tsta5p5
 UhiryHfEcITn3C1VataI4J2t4NDJtRl2IzQ21x61R1wdBstFl5gk+SPVZVlMpM3rFj5aySU7ejG
 +kvqi8vwJ9NbTkjdDy0xIjusB6Ez+eYA2dEsrFF0PFXdrt7O5cVS8e8GJgw9Ss/XrMbY4P5QCuI
 XYgyPs4DaovfIkfcK40c6jEOuzY5F37DC0A5GqWz/M/AExgdnflMKyzi5sI8=
X-Received: by 2002:a05:7300:6c95:b0:304:3c33:7ae7 with SMTP id
 5a478bee46e88-30c06e0f05fmr10778647eec.7.1782167406252; 
 Mon, 22 Jun 2026 15:30:06 -0700 (PDT)
X-Received: by 2002:a05:7300:6c95:b0:304:3c33:7ae7 with SMTP id
 5a478bee46e88-30c06e0f05fmr10778626eec.7.1782167405657; 
 Mon, 22 Jun 2026 15:30:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.30.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:30:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 39/75] target/hexagon: Implement iassign{r,w} helpers
Date: Mon, 22 Jun 2026 15:28:28 -0700
Message-Id: <20260622222904.607771-40-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX1YabO1gzXeSp
 ZmIxi9fPr4kPk9Vhff5kxLdVl+nXxMMgnMRo7+eDxXqohVYgZ92YglA5PQhurViQi5fbRkiSrY4
 nMgu1UjFmavpn2YmBVBlP80zZ/G4eAg=
X-Proofpoint-ORIG-GUID: Ytge7Su8CSpRoTgpUczHYm4SdN6ss3Nk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXxeKns83Wcrq+
 1AdsQA0xRSvSpu7k/qpuXeHTnustV9eVE6c+AowMMoMAWN1yK8jv4IeZfbiym5Gr/+pts+drxTi
 CYPPBpe9Y0d8Xp7d4dPFp3GmYv02VmbruUPeiB5qmWmC4rkfj9bdxMhK0b+jGWABtAAjjvxRqR2
 9wS5PXIutCwA5xUoxM7eicO/4xaUGUEw7S2Ek2hRbcAkNDYxNhP9XPlIkB5gdqi9a78yCJywmaj
 gWFOK0qpTdhhh9GhDlXqsoTxzlPL86fut/QRZclFC6SZr2wmyGxBspz0Cv7QaTgu/dLRjS8gKnK
 UGUYqG4qR70rg6l4bYMmYq5j+b2lDFTiIqBn2oFtxmEJNLkXSnPNHzCEv7fUXWO/JDiWd0K9Qf5
 kOCk1sSlXCv7rl9dOKe4A4W380QS5RF8AqOXTREaPfbigMNVzlEE+qOMhuuQJcbW3OBIreH2K9j
 yF7LSJTDQmYBJP9ecCA==
X-Proofpoint-GUID: Ytge7Su8CSpRoTgpUczHYm4SdN6ss3Nk
X-Authority-Analysis: v=2.4 cv=cKbQdFeN c=1 sm=1 tr=0 ts=6a39b76e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnV9S1Uu6eltRR5mmX4A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220216
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgppYXNzaWdue3Isd30gYXJlIHRo
ZSAiSW50ZXJydXB0IHRvIHRocmVhZCBhc3NpZ25tZW50IHtyZWFkLHdyaXRlfSIKaW5zdHJ1Y3Rp
b25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDU2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNTQgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBi
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDc4Mjc2OTZjNmIyLi42ZjAxZjNiOTFk
OCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MTcsMTIgKzE0MTcsNjQgQEAgdm9pZCBIRUxQRVIoY3N3
aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiAKIHZvaWQgSEVMUEVSKGlh
c3NpZ253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogewotICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDMyX3QgbW9kZWN0bDsKKyAgICB1aW50MzJfdCB0
aHJlYWRfZW5hYmxlZF9tYXNrOworICAgIENQVVN0YXRlICpjcHU7CisgICAgSGV4YWdvbkNQVSAq
aGV4X2NwdTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaGV4X2NwdSA9IGVudl9hcmNo
Y3B1KGVudik7CisgICAgbW9kZWN0bCA9IGhleF9jcHUtPmdsb2JhbHJlZ3MgPworICAgICAgICBo
ZXhhZ29uX2dsb2JhbHJlZ19yZWFkKGhleF9jcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVD
VEwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCkgOiAwOwor
ICAgIHRocmVhZF9lbmFibGVkX21hc2sgPSBHRVRfRklFTEQoTU9ERUNUTF9FLCBtb2RlY3RsKTsK
KworICAgIENQVV9GT1JFQUNIKGNwdSkgeworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVh
ZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNwdSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVh
ZF9pZF9tYXNrID0gMHgxIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhy
ZWFkX2VuYWJsZWRfbWFzayAmIHRocmVhZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJf
dCBpbWFzayA9IHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAg
ICB1aW50MzJfdCBpbnRiaXRwb3MgPSAoc3JjID4+IDE2KSAmIDB4RjsKKyAgICAgICAgICAgIHVp
bnQzMl90IHZhbCA9IChzcmMgPj4gdGhyZWFkX2Vudi0+dGhyZWFkSWQpICYgMHgxOworICAgICAg
ICAgICAgaW1hc2sgPSBkZXBvc2l0MzIoaW1hc2ssIGludGJpdHBvcywgMSwgdmFsKTsKKyAgICAg
ICAgICAgIHRocmVhZF9lbnYtPnRfc3JlZ1tIRVhfU1JFR19JTUFTS10gPSBpbWFzazsKKworICAg
ICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lOVCwgIiVzOiB0aHJlYWQgIiBUQVJHRVRf
Rk1UX2xkCisgICAgICAgICAgICAgICAiLCBuZXcgaW1hc2sgMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICB0aHJlYWRfZW52LT50aHJlYWRJZCwgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIGhleF9pbnRlcnJ1cHRfdXBkYXRlKGVudik7CiB9CiAKIHVpbnQz
Ml90IEhFTFBFUihpYXNzaWducikoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykK
IHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIHVpbnQzMl90IG1vZGVjdGw7Cisg
ICAgdWludDMyX3QgdGhyZWFkX2VuYWJsZWRfbWFzazsKKyAgICB1aW50MzJfdCBpbnRiaXRwb3M7
CisgICAgdWludDMyX3QgZGVzdF9yZWc7CisgICAgQ1BVU3RhdGUgKmNwdTsKKyAgICBIZXhhZ29u
Q1BVICpoZXhfY3B1OworCisgICAgQlFMX0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY3B1ID0gZW52
X2FyY2hjcHUoZW52KTsKKyAgICBtb2RlY3RsID0gaGV4X2NwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoaGV4X2NwdS0+Z2xvYmFscmVncywgSEVYX1NSRUdf
TU9ERUNUTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6
IDA7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVMRChNT0RFQ1RMX0UsIG1vZGVj
dGwpOworICAgIC8qIHNyYyBmaWVsZHMgYXJlIGluIHNhbWUgcG9zaXRpb24gYXMgbW9kZWN0bCwg
YnV0IG1lYW4gZGlmZmVyZW50IHRoaW5ncyAqLworICAgIGludGJpdHBvcyA9IEdFVF9GSUVMRChN
T0RFQ1RMX1csIHNyYyk7CisgICAgZGVzdF9yZWcgPSAwOworICAgIENQVV9GT1JFQUNIKGNwdSkg
eworICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKnRocmVhZF9lbnYgPSAmKEhFWEFHT05fQ1BVKGNw
dSktPmVudik7CisgICAgICAgIHVpbnQzMl90IHRocmVhZF9pZF9tYXNrID0gMHgxIDw8IHRocmVh
ZF9lbnYtPnRocmVhZElkOworICAgICAgICBpZiAodGhyZWFkX2VuYWJsZWRfbWFzayAmIHRocmVh
ZF9pZF9tYXNrKSB7CisgICAgICAgICAgICB1aW50MzJfdCBpbWFzayA9IHRocmVhZF9lbnYtPnRf
c3JlZ1tIRVhfU1JFR19JTUFTS107CisgICAgICAgICAgICBkZXN0X3JlZyB8PSAoKGltYXNrID4+
IGludGJpdHBvcykgJiAweDEpIDw8IHRocmVhZF9lbnYtPnRocmVhZElkOworICAgICAgICB9Cisg
ICAgfQorCisgICAgcmV0dXJuIGRlc3RfcmVnOwogfQogCiB2b2lkIEhFTFBFUihzdGFydCkoQ1BV
SGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGltYXNrKQotLSAKMi4zNC4xCgo=

