Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC96CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9b-0003cn-Af; Mon, 22 Jun 2026 18:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9X-0003aj-F3
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9V-0006Zn-L8
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJcgPN1938794
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SxgjDN8stbE6SIBeFPtrecas0sgHajmcu/RG683JGPg=; b=aL+jZyf1bXtmE+kO
 lmDyO4WCyaFhOsJ8Fu1hwFN98iBRjOF35kE3JsnWw7h9c1r8y39G5S6YUDOZDHuK
 sqmZAPZQdcG6fKOT0WkJkMwRhdd2ByRGpLuZEMkgwUrOTEydUayUcQi5wGcNAisZ
 +PW4mLd8ksYc33rU7OtVSKLJppo8Aoec0j9xFwfyBVdEqStICOAh7t0X0JhQRiGF
 rw1i7PK1Un4rVmSpWx+j9CvLT2r8fhTAPZxNPvDeDICMsBKXB283GJMoQ2uN5Edd
 YgeGKAvH1hzGYf64YguZOgqWN5g7gEDHiRNU9PKmHT8Lm1dvycXo/JEbdSQmXCgz
 Si3KWQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5ye9wua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:50 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so5827505eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167390; x=1782772190; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxgjDN8stbE6SIBeFPtrecas0sgHajmcu/RG683JGPg=;
 b=WeazfXsaAch3xLJ9HPCRO4Za7xFSZ2IVmpxFZnn+7fLGzFP/IaJfVFf9zaP09TIDQI
 72iGDf508m7x3YpPxbSGyU5xL4Wvvh4LkKqpPIGL+L74kbVxFyYJhCoVa4TXYcIXIX2z
 1QQK52wQF/MYjpNPZf6gU34oKM5RhjH9WOaAr3sA3+jPFfQjrWfrQB5mxLoEgXrwcQcy
 V3xkzVafXRkKsq7MB7ZBbKy0fEl7RksED5kLBJauzsb7pJ46OfJKDIJ6GUps8ndsf1TY
 lXghh6hFwSxmBkCilzMKgIacVD/aCGaIyLLkeejNKUDwhxqkxizVUihlRvxp4vn6w0U6
 K9cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167390; x=1782772190;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SxgjDN8stbE6SIBeFPtrecas0sgHajmcu/RG683JGPg=;
 b=npiN00WXt9+/HESj308z/NzWbeG6jPHQQc9hLgW54oF9m6jh5uDrcFZ5LdJPAH0Pj0
 bwIjQKEJrludW9yye9FXD16yp6KqC+AQ8gZqyjQCDUU5HzpyYpJost4HX0c+eTgRHmui
 kjOs0oQdHJNSgFl0bbPEDUOTwYEx4/pQRjfDCpyanH7C5iwHLqeKi70KndHAN7HU+PBb
 /RlXJWgXw/Jm1fClwX78AJZOWGJWVPYQ1Ytfoz6tVkpdyIWgxfAEsvanIZhG/SekaC80
 3qFPpgY7+T3yqCmT4ABtcp3h2OORHjl+RJp2iMgSHh6LrxkutD8HZRuOtV0dgJxJoa02
 VNhQ==
X-Gm-Message-State: AOJu0YwlP6ngPFJG+sXwIXc5yAvgxNfDd/DdE3qAgv9wwXl1vqZqNxDF
 mjn4Gq5MrjLKpcCBllGNVwAlJKUDS6Qc7MDEcf7534QbBuMD83sfGecdrp5QGI3gCoihCS3CbPS
 W7LrJutZmnaDJMbHyFf5rnffaeOOIYYj68SbXBMPW57JA9R6TbY2qQdr0PyWrzXkVzQ==
X-Gm-Gg: AfdE7clJdXbG3ntd4n3E+C7TBMISkw7w8L1Zy0oWk3pX4tZb6/4qs/bngLpy1ukIMiL
 aE6Vf3Zqo9MZMJpprd4d1YjsobKbI2M9YkaFZajGTKuxPl0snu3tojorVIiWeZE+15zlm663ufh
 pWNI3cI7Mut0AaVExA93IvILD5I12ExzVcwKHFstzoHbFi9Vqkrpw6CVgSYUVorwDK+mNZ/vwzC
 gBUACFFAF2HpcHdo5aJtOZsm6Fot8QgR/OujYx4+GT5BlUYDAEbDZivsLY3yBuKcUb354P5OduI
 urP7D7ZWiyd/2llbETJI+vnKubk7JEz7lqtfp3bCiDp/O8qJvLqhFlL26FZRGGu9LNgG7wjxoEK
 Vnt0IGT9kpoWNPRby0Gs4xmbXVxidKS3gX/Vbx6NnZrZKCNE49Nrxq5zesfs=
X-Received: by 2002:a05:7300:8bab:b0:30b:dd58:e155 with SMTP id
 5a478bee46e88-30c07156edamr12657321eec.20.1782167389539; 
 Mon, 22 Jun 2026 15:29:49 -0700 (PDT)
X-Received: by 2002:a05:7300:8bab:b0:30b:dd58:e155 with SMTP id
 5a478bee46e88-30c07156edamr12657303eec.20.1782167389013; 
 Mon, 22 Jun 2026 15:29:49 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:47 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 26/75] target/hexagon: Add TCG overrides for int handler
 insts
Date: Mon, 22 Jun 2026 15:28:15 -0700
Message-Id: <20260622222904.607771-27-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: F-mnpmwTsKICwBcOTdysAFL36aVzp-4F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX08Zsptkt4nCF
 dqzJso5Mno4YqQI6rhaTRg+ZLCXfuNOfTRNpmlKkP7Qkyl/VTq0L+sbIWK5KMUXgr2PLbEtHtSy
 QYU0VSaiThTsWQb6bMRmXPSgc5s7USI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX0Pba/UXgWyh2
 a5w0T3Z9unfXUDhJfEnaS0FfgRioyEpHLHjpITBIy4T2v0lBudF9xP4+blT0ia5cKMArC7LA6Ad
 OYoruXKKzxZVE3kLfVEQR69Zdqg1mIxdMuuTRHxS2ta8OvRHEAlE96I/CtPQrZbsiakkjXzztfT
 fHw10FRsZHJejWI5vcqv4/ACUjDch1OztdpwhP67MdSEVJ1Mmsb6usyygN+uQhpDoqH4oJqmCUT
 UCL/FMOFF3+HTL6bzroN7lW7AsefGyuYfkIKHtYIk5hiPzrS9o55N3VT9wywS3vPGRJza2363ML
 /is3WAxi4LCVtrIfeKpudOmJliqFxAhrFe3ShcFXnJqTnDmbTuNNOFZCggPZg7eK6s0tJIPymq0
 Vo7qke+ww1P/ro3jWXXjCWZgO6/lKoYffYfpLmOSYmHYiIR2hGNxcgkqsrPKW5hQHuhZnw471W5
 zwh+cbAyoQGuAPkA17Q==
X-Proofpoint-GUID: F-mnpmwTsKICwBcOTdysAFL36aVzp-4F
X-Authority-Analysis: v=2.4 cv=YpI/gYYX c=1 sm=1 tr=0 ts=6a39b75e cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=ncxFUDX8U6Z2rYVbhVQA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpEZWZpbmUgVENHIG92ZXJyaWRl
cyBmb3Ige2MsfXN3aSB7YyxzfWlhZCwgaWFzc2lnbntyLHd9LCB7cyxnfWV0aW1hc2sKaW5zdHJ1
Y3Rpb25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFp
bC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21t
LmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIHwgMjUgKysrKysrKysrKysr
KysrKysrKysrKwogdGFyZ2V0L2hleGFnb24vaGVscGVyLmggICAgICB8ICA4ICsrKysrKysrCiB0
YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyAgIHwgNDAgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAzIGZpbGVzIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3Rj
Z19zeXMuaAppbmRleCBmNzhjOTYzNWMzZi4uNGNiYmRkMWY3MGIgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL2dlbl90Y2dfc3lzLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19zeXMu
aApAQCAtNyw2ICs3LDMxIEBACiAjaWZuZGVmIEhFWEFHT05fR0VOX1RDR19TWVNfSAogI2RlZmlu
ZSBIRVhBR09OX0dFTl9UQ0dfU1lTX0gKIAorLyogU3lzdGVtIG1vZGUgaW5zdHJ1Y3Rpb25zICov
CisjZGVmaW5lIGZHRU5fVENHX1kyX3N3aShTSE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX3N3
aSh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfY3N3aShTSE9SVENPREUpIFwK
KyAgICBnZW5faGVscGVyX2Nzd2kodGNnX2VudiwgUnNWKQorCisjZGVmaW5lIGZHRU5fVENHX1ky
X2NpYWQoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9jaWFkKHRjZ19lbnYsIFJzVikKKwor
I2RlZmluZSBmR0VOX1RDR19ZNF9zaWFkKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfc2lh
ZCh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfaWFzc2lnbncoU0hPUlRDT0RF
KSBcCisgICAgZ2VuX2hlbHBlcl9pYXNzaWdudyh0Y2dfZW52LCBSc1YpCisKKyNkZWZpbmUgZkdF
Tl9UQ0dfWTJfaWFzc2lnbnIoU0hPUlRDT0RFKSBcCisgICAgZ2VuX2hlbHBlcl9pYXNzaWducihS
ZFYsIHRjZ19lbnYsIFJzVikKKworI2RlZmluZSBmR0VOX1RDR19ZMl9nZXRpbWFzayhTSE9SVENP
REUpIFwKKyAgICBnZW5faGVscGVyX2dldGltYXNrKFJkViwgdGNnX2VudiwgUnNWKQorCisjZGVm
aW5lIGZHRU5fVENHX1kyX3NldGltYXNrKFNIT1JUQ09ERSkgXAorICAgIGdlbl9oZWxwZXJfc2V0
aW1hc2sodGNnX2VudiwgUHRWLCBSc1YpCisKICNkZWZpbmUgZkdFTl9UQ0dfWTJfc2V0cHJpbyhT
SE9SVENPREUpIFwKICAgICBnZW5faGVscGVyX3NldHByaW8odGNnX2VudiwgUHRWLCBSc1YpCiAK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFnb24vaGVs
cGVyLmgKaW5kZXggNTQwNTM0MmY3OTguLjk1NTI4NzEzM2U0IDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApAQCAtMTA5LDYg
KzEwOSwxNCBAQCBERUZfSEVMUEVSXzIocHJvYmVfaHZ4X3N0b3Jlcywgdm9pZCwgZW52LCBpbnQp
CiBERUZfSEVMUEVSXzIocHJvYmVfcGt0X3NjYWxhcl9odnhfc3RvcmVzLCB2b2lkLCBlbnYsIGlu
dCkKIAogI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCitERUZfSEVMUEVSXzIoc3dpLCB2
b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihjc3dpLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9I
RUxQRVJfMihjaWFkLCB2b2lkLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihzaWFkLCB2b2lkLCBl
bnYsIGkzMikKK0RFRl9IRUxQRVJfMihpYXNzaWdudywgdm9pZCwgZW52LCBpMzIpCitERUZfSEVM
UEVSXzIoaWFzc2lnbnIsIGkzMiwgZW52LCBpMzIpCitERUZfSEVMUEVSXzIoZ2V0aW1hc2ssIGkz
MiwgZW52LCBpMzIpCitERUZfSEVMUEVSXzMoc2V0aW1hc2ssIHZvaWQsIGVudiwgaTMyLCBpMzIp
CiBERUZfSEVMUEVSXzIoc3JlZ19yZWFkLCBpMzIsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKHNy
ZWdfcmVhZF9wYWlyLCBpNjQsIGVudiwgaTMyKQogREVGX0hFTFBFUl8yKGdyZWdfcmVhZCwgaTMy
LCBlbnYsIGkzMikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXggMzIzNmNlMGM4ZjAuLmM5MGI3NTcyNDE5IDEw
MDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdv
bi9vcF9oZWxwZXIuYwpAQCAtMTM5MCw2ICsxMzkwLDQ2IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEy
OHFtKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgaW50MzJfdCB1aVYpCiB9CiAKICNpZm5kZWYgQ09O
RklHX1VTRVJfT05MWQordm9pZCBIRUxQRVIoY2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVp
bnQzMl90IG1hc2spCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBI
RUxQRVIoc2lhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCit7CisgICAg
Z19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29u
U3RhdGUgKmVudiwgdWludDMyX3QgbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgp
OworfQorCit2b2lkIEhFTFBFUihjc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qg
bWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit2b2lkIEhFTFBFUihp
YXNzaWdudykoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHNyYykKK3sKKyAgICBnX2Fz
c2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50MzJfdCBIRUxQRVIoaWFzc2lnbnIpKENQVUhl
eGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNo
ZWQoKTsKK30KKwordWludDMyX3QgSEVMUEVSKGdldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVu
diwgdWludDMyX3QgdGlkKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CisKK3Zv
aWQgSEVMUEVSKHNldGltYXNrKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgdGlkLCB1
aW50MzJfdCBpbWFzaykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCiB2b2lk
IEhFTFBFUihzcmVnX3dyaXRlX21hc2tlZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHJlZywgdWludDMyX3QgdmFsKQogewogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Ci0tIAoy
LjM0LjEKCg==

