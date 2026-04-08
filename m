Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DD210F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYTQ-0007fR-Mu; Wed, 08 Apr 2026 15:22:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY4g-0006US-Gv
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:56:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKOl-0005Z0-Tk
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637M6NLs2450582
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vprTvSEgzIgWASZmcb1NhYWButaf8Vz6pBv1wMZS9Rk=; b=a2BYyzSC39a73LWe
 0oRDuBMArRCWjQO9ihjgxgcVNFaw5w1QqOeB8svPYeX/qY3lup/wIbXXLfdYXsYW
 Kk08QEEDkxUKNWZJaYVtG7XHS91kXYa/CJYQkZIUvFaM0lsvT+gF3R36ZnkyZ52+
 tk3NLFH7wcn9aMZ6uDkgs1O5zc4/anxSLdvftYSkSGiJg8XeT04ifr3nl0WWhEbF
 n/tgZ8pExrARn/dUgCB0FIVKdLVOcHuEMasHxdUqW5r7iJ3bbMcDkFoyODDmmhAB
 xnu9ZGDqKsZkESnbWHViib8TNfrKCglcDZOoGuFipIEfonIMUoBzRDlHw9prpDXM
 lgmWgQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ddae68wks-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:14 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1270dcd11c1so9813791c88.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622013; x=1776226813; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vprTvSEgzIgWASZmcb1NhYWButaf8Vz6pBv1wMZS9Rk=;
 b=N2Z+J+9LiaiZgy9NnObzdRCDD/Ewx+37S4+XHSn0WUchJiK6jwRsc9IBbprkt0jETh
 JttqyBn00V/u8kXp4FHk/jgfdn9yZY7OfqYKAoayXJuelli4f4HPKzH64lzvfiWJDNrs
 4cWnj/rIe9VISaAG5qlWgveDT/11oQf0LyB8/V/LH19T5NEU11bqYrTGlJCX00rcWmjJ
 KUVKmQ0iJq4E03Q6ysa1WoSzeQXwv/LzbPF+wl3hLsmt5HTQK8vBqzIldCwfv5bMggo0
 YNqogrleu9+R3x8Tw2VUnRPDgmDNjhcheBuPStISF5xaaeN2S0of74sHgoOGycmi1aTY
 1VsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622013; x=1776226813;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vprTvSEgzIgWASZmcb1NhYWButaf8Vz6pBv1wMZS9Rk=;
 b=G9gCkrEZgBu0ZswQeyrVGtUfAEXkfFfG0GSXonnhtw6rWEnGTQS5FAJk7K24e/YnZR
 JFCUqFw1DTCuYmOFgpM5O8kEG1M5OzXMNe1l1u0aQ7/mp4mHQh+4I5Fl0UI2lJsB5sip
 1l4wGHfedQiqTrxydYJgThpwAIU3RiLbC3AyvJUxP7wNDWUsFUEYT8O6K+EefDCCiaKi
 5nwS7a9VYTTSK63zgNorUgvKHOOZ0NR9r/b7McifZ7xj4N6oss6oDNaGO589Hyn5DD7E
 tWSp3yDQSy/5y0/W3D+5oW95W6PBygExI+NDWdrDIySsic7eNP1/NFg7Q0FVtF5s2RD9
 RxCQ==
X-Gm-Message-State: AOJu0YzPP2N0GiCTDkpwF0xdCK+Rx4p9JzGfwSnQ5goeININjS/peQjK
 qhaqah9rCZJRBnAUVzc4OO6pEpSHE8Pt6OV7O3SF3LC4oQJ+jlVMzJGfPS/OXo2LkaCsvwpc7NG
 WxioA7wgpfcDgupTuEYNEwfwzltruNmPyUgSE924sGXAYPjk+w+IiCsaTICsFgAssBQ==
X-Gm-Gg: AeBDieutZTcWDDW7wIYG1bLzLDKvVJzf5f6kOzuQb7zLbKtXY2PvD1YDS5mtrtF4GCU
 VwSogUN8ET3KILVnn6pSfLjt7pQX5rPAEdiJTSEgCCfK+eTKc8dG35j7L619TOCicRYBwyy0zlI
 km+fOkC57ek+v07cRV7RKckCfvU3bRf/LpN4MUcGepOaLuCLDPfO1rD6MEzEKsBqQxRsetdOU0p
 PXvMd/fBVIEtrygD93aEA9bpednebD1OxSM2bjecxbMkVy7vWtzjCIvnd18628YCAdMS7mNQvaU
 PmnhVTotCNRYFE+D8Tt8ROiLcG20MIX6Ww+cL5iDl4RhCuuATF7oZF0E8QzDHA1D8iKSdEiOXz4
 D8Z45Ue6U2g39zMadDNvmVbhwGoWBWzXtfIU1GYZX1fpTYSFBS4U2NeEIjDzPRuc93/Uizw==
X-Received: by 2002:a05:7022:6997:b0:128:cf75:42a3 with SMTP id
 a92af1059eb24-12bfb745b32mr9190314c88.21.1775622012938; 
 Tue, 07 Apr 2026 21:20:12 -0700 (PDT)
X-Received: by 2002:a05:7022:6997:b0:128:cf75:42a3 with SMTP id
 a92af1059eb24-12bfb745b32mr9190299c88.21.1775622012436; 
 Tue, 07 Apr 2026 21:20:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:11 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 04/28] target/hexagon: Implement {g,s}etimask helpers
Date: Tue,  7 Apr 2026 21:19:29 -0700
Message-Id: <20260408041953.1899532-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfX9ia4U2Lbd7wR
 e9GyEDSnvPM9yQ0JYZpAE8m20OrWygrnO0uGsT4suEj8FIKfUkjg8Rf5+U4MFZ876KpqWTsaQ4A
 e7eRIMqP8mUdM+WIcxHtKCLcFRTGMkMsqRYgZcDdQ+cVQLTxac/hwV7wJqhybnEJ5Q+JtZAoixw
 ghIiVWU7uUcUmPhInnbcWPSAMAL2KwKSKU/YlCtT8vHbmwqL8uLZPbkOdAcXIzL3j2TymG/pKh4
 15ihaAfvS8dji7xu5xXTQ6mqfZAdh/RjBvjH+fvYHza4QjepUuVf6h89h290QxDwkNNY453R3rk
 mkHdE4jpfWbJuTcK0hOjt89aDYaXbzvSH3mKGk9ecw/pbTizwt/1lsdR0fw8KXeURBrq228bDtx
 9C2lGkE6sgXxNL0dauPIk8VuuwtoQIcjHXhntsnNsDYyUGUA+3PfahVVCyH4GjFu9h+GFlKaF1S
 nPZ9tTbHth1iG2BPs0Q==
X-Proofpoint-GUID: n_MoP21CLu8HC-Wj4B6dr_UwfN0mlWwt
X-Proofpoint-ORIG-GUID: n_MoP21CLu8HC-Wj4B6dr_UwfN0mlWwt
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69d5d77e cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=he7afFXPmx5H4pWyvLYA:9
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jIHwgMzYgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZp
bGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IGEyOGVkMDYxNDEyLi4yMzVjNzBmNzM3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0OTgs
MTIgKzE0OTgsNDQgQEAgdm9pZCBIRUxQRVIocmVzdW1lKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgdGlkKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cisg
ICAgQ1BVU3RhdGUgKmNzOworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0go
Y3MpIHsKKyAgICAgICAgSGV4YWdvbkNQVSAqZm91bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOwor
ICAgICAgICBDUFVIZXhhZ29uU3RhdGUgKmZvdW5kX2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAg
ICAgICAgaWYgKGZvdW5kX2Vudi0+dGhyZWFkSWQgPT0gdGlkKSB7CisgICAgICAgICAgICB1aW50
MzJfdCBpbWFzayA9IGZvdW5kX2Vudi0+dF9zcmVnW0hFWF9TUkVHX0lNQVNLXTsKKyAgICAgICAg
ICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAiIGltYXNrID0gMHglIiBQUkl4MzIgIlxuIiwgX19m
dW5jX18sCisgICAgICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQsCisgICAgICAg
ICAgICAgICAgICAgICAgICAgICh1aW50MzJfdClHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2sp
KTsKKyAgICAgICAgICAgIHJldHVybiBHRVRfRklFTEQoSU1BU0tfTUFTSywgaW1hc2spOworICAg
ICAgICB9CisgICAgfQorICAgIHJldHVybiAwOwogfQogCiB2b2lkIEhFTFBFUihzZXRpbWFzayko
Q1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHRpZCwgdWludDMyX3QgaW1hc2spCiB7Ci0g
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBDUFVTdGF0ZSAqY3M7CisKKyAgICBCUUxf
TE9DS19HVUFSRCgpOworICAgIENQVV9GT1JFQUNIKGNzKSB7CisgICAgICAgIEhleGFnb25DUFUg
KmZvdW5kX2NwdSA9IEhFWEFHT05fQ1BVKGNzKTsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICpm
b3VuZF9lbnYgPSAmZm91bmRfY3B1LT5lbnY7CisKKyAgICAgICAgaWYgKHRpZCA9PSBmb3VuZF9l
bnYtPnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5kX2Vudiwg
SEVYX1NSRUdfSU1BU0ssIElNQVNLX01BU0ssIGltYXNrKTsKKyAgICAgICAgICAgIHFlbXVfbG9n
X21hc2soQ1BVX0xPR19JTlQsICIlczogdGlkICIgVEFSR0VUX0ZNVF9seAorICAgICAgICAgICAg
ICAgICAgICAgICAgICAiIGltYXNrIDB4JSIgUFJJeDMyICJcbiIsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBmb3VuZF9lbnYtPnRocmVhZElkLCBpbWFzayk7CisgICAgICAg
ICAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShmb3VuZF9lbnYpOworICAgICAgICAgICAgcmV0dXJu
OworICAgICAgICB9CisgICAgfQorICAgIHFlbXVfbG9nX21hc2soTE9HX0dVRVNUX0VSUk9SLAor
ICAgICAgICAgICAgICAgICAgInNldGltYXNrIHVzZWQgd2l0aCBhbiBpbnZhbGlkIHRpZCBuZWFy
IFBDOiAweCUiCisgICAgICAgICAgICAgICAgICBQUkl4MzIgIlxuIiwgZW52LT5uZXh0X1BDKTsK
IH0KIAogdm9pZCBIRUxQRVIoc3JlZ193cml0ZV9tYXNrZWQpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCByZWcsIHVpbnQzMl90IHZhbCkKLS0gCjIuMzQuMQoK

