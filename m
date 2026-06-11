Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B513CD8CB2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzH-0007y1-SS; Thu, 11 Jun 2026 01:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzD-0007nZ-MZ
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzC-0000rM-5O
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:51 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQ873835150
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=wpC5BJns/e7rnjU44P5tuMzi2K1CHTF7Mp5LI6vhDjY=; b=LH
 4XUCWs2sWSFiWsT/U7XyjyqW7i6MijOvJvmsTRxPaepqHKt4dx/QxpBSC6wgtFvN
 oH/k4vLUQzieO/re27v/9TQg180m85OLmxKX1a6bXv1tewFy/5NcUEGn21XcxNyJ
 wqYMVFpA91f29KG5IFPl7kSrYrSjPT0KtlkxCV2xHkJJGpT+8EyDZ11ieQqdfgJZ
 5o2cR52ETBpTPcICGaD2sNGyaVvhEioRvewd0uzReYlrOttDOHrXvDLddJXw2pPp
 WtiPpexO2UKOyebsQo0hH3KTxKdun3Izcco0cTY9Kb0xVsvO71WFDuDUys7Ekw/d
 V5hqtOutfDc3vJIsWXEQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6ths6v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:37 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304e7fc90b1so7775265eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155777; x=1781760577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wpC5BJns/e7rnjU44P5tuMzi2K1CHTF7Mp5LI6vhDjY=;
 b=GsMlB1iBMw5Ow3dN+FbQpsQNkygbbEQNY9FfHhTFjWOQW2FPJ2khxsCTZlKJHMtyN1
 P7QA6ISQxt1DKnLx1Gs9hOV9mjVNWHaSnz50exDyF+BIWy5hLn+B81qu1zU3fTjgyqK/
 Kz95FdyC0ah30woMWY+kPBIBrm4KYH8RpADy76cS65mqZK6otvn5az3tzObRC7hqZa2F
 m23het92NSkLbltjuPqC2jmoe9NcKL/JLFXCxBrvKQl2ktB/Ba/nltfLNgA5Y+BHOAPU
 MSrqWp+wXNpXClOMrggVPg56iwoJPaVVeg+/JpGXb8Cy31agsJIOuALl454URgseCnrC
 D+5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155777; x=1781760577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wpC5BJns/e7rnjU44P5tuMzi2K1CHTF7Mp5LI6vhDjY=;
 b=lLs/sMknAMhUyE778T5ctLc9HBPhpVJdeqas1W7ZhvXBqRFv3wuRbDbwyW6Cu7N+Mn
 VDWshYvTB0FLuwcsmsmn4hZeBobu1ga4lPDiMdCPlTQYwHrprpySrrb02Nxid3FUgqAc
 Wb+M7VshvAor0X5Ed9DS6chnfoDlEtCHQWR9kJLUR4h3f4YeZIk2gZet6aLHs0qZkoBZ
 +/5GtqHlg4UxtbqLJls+vsK4gdoZx7fMbJIy1OrlXYMqmKjO91QItMu+NC/z4vWybfIR
 Z2QFyPThdPP5r330jqz/VNU8UfjEUtLgCEBFvF1NKe4lr2yjqnv0xTlbGcQ5IuWreTb9
 M7Bg==
X-Gm-Message-State: AOJu0YxlUJO4A7Xra0ieGw275wSHF2awTRV23DBIlzYkGwksHYY6R1Wj
 DRxzQ+wpgIBWzi7YW1WQbprgXhqFOJc2HXFh4zMCjkIrdOY+hLI4puEgtB0pu6oGwag74+5nNEn
 2dd3zZ41Ka2PWJyo4cZKjhGzV026IiPv/ploHJfCoQeFKnnk5+CRQoyezqq8wayulGA==
X-Gm-Gg: Acq92OEc5ib0jxbkstwVHnIjYP7/kh3+Hnddk4wK88PGXIb0GlCheM0BkRZHZ3M1l6l
 1M5nnZXC0Nad77UoiUn7ojqDxZ3qs/DNQYSqeIHBA7xJjVRks0dvCtBKmisHvWLvXDqHkcxF9bM
 tACXxsnA6LnrKLg4cr5sp0Y45MGtK6sUPa7HBwA9tjFQ9qWanYoeW9CWPPSUfHSpoqRoyw5Lgrl
 qPSzFhqm4PjVPVYBncRkTHbXeZTlYb/R4xxTUkeHli/5zc06ZuOg+GT8A5uhkzvoip5Oh4BSeTE
 HnCKw9c8dhbjlsofXKE3Fx8YRz3J8g0dGQnJEjyaXacDZzP9HLlI3c0KQe6txmVfdWfwNpnjljO
 LF/XlGdxMVL7cHoCTzidLbQi2Fd6GcKYt0h6E7DBbQJfrMO+bNg9JYbuuaUqEvYh33vtBEQnfKA
 1xaiv6
X-Received: by 2002:a05:7300:818a:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-308046227e0mr1052678eec.2.1781155776914; 
 Wed, 10 Jun 2026 22:29:36 -0700 (PDT)
X-Received: by 2002:a05:7300:818a:b0:2c5:220c:5670 with SMTP id
 5a478bee46e88-308046227e0mr1052658eec.2.1781155776415; 
 Wed, 10 Jun 2026 22:29:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v8] target/hexagon: Implement do_raise_exception()
Date: Wed, 10 Jun 2026 22:28:42 -0700
Message-Id: <20260611052857.3911981-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX+miuQ3jE1zlM
 V0++HeJD05Xh6MfWBTOCju+3CX0nljiKtxDy7RGU6Muir1jwFcGt9mJ9jgD13Ieq/CpTU5S1M5W
 pSdNC3JwPdWBJy2Icu1Vl1SQ11ViC4waEw1Q/M6W7SGdPX7UcBFu2RlXUzVU9RHzvyEoB+FUDO6
 2J+KuUx/jbbooinUTInN1YnQfidG2AaqHPgg1LM82vRNtXM2y9TX9aMDcXckpk6Kv5fT7aoy/IS
 /wg54x3yHWWJ1mLHH3OGyjhfzw4etR3vFWPJT52/yaIxF0heDSgElGS4oN+H2r0RYhp0r4JLMoM
 wng6X86/3bpCjVZrAnTKZIwCDE+rw9LlpFM+YZftPCy86+hI63HhWw7RNf0exbBnkBRcphNhra7
 BP/mupSzgYcyGvOFhZ+eSff1y73hWmRGY4lyrepZsUAzeEMLjOTD7Itf5tMVWHTd1H0MKqGCzA0
 EeooRENcuxaiyRC2/cA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX7HOSbJ0I/HdO
 oqesQdTgP+NJY7phcbiC27fKq4D4eG0eCJjKXHAy92iLtIE8H6RSiykWaH/2Yt5aQGeY4Jd7VtW
 HazOH4hpu2bUV+z7pN6zAt03UZ6PwIA=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a47c1 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=hK29HtBGQMdOITfcgGsA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: yR9frFJi8DjSst-WCCp8_PWfVDWrGhCj
X-Proofpoint-GUID: yR9frFJi8DjSst-WCCp8_PWfVDWrGhCj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBl
IE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggIHwgIDUgKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTQgKysr
KysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CmluZGV4IGNkMDZmZjQxZDRmLi4zM2Q3M2VkMThkMSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5oCkBAIC0zMSw2ICsz
MSwxMSBAQCB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRlICplbnYpOwogCiBleHRl
cm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RIUkVBRF9S
RUdTXTsKIAordm9pZCBHX05PUkVUVVJOIGRvX3JhaXNlX2V4Y2VwdGlvbihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwKKyAgICAgICAgdWludDMyX3QgZXhjZXB0aW9uLAorICAgICAgICB1aW50MzJfdCBQ
QywKKyAgICAgICAgdWludHB0cl90IHJldGFkZHIpOworCiAjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKIGV4dGVybiBjb25zdCBWTVN0YXRlRGVzY3JpcHRpb24gdm1zdGF0ZV9oZXhhZ29uX2NwdTsK
ICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgYi90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYwppbmRleCAzNTliZjEyZjFmMi4uMzI3YzIzM2MwMWIgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhhZ29uL29w
X2hlbHBlci5jCkBAIC00MCw2ICs0MCwyMCBAQAogI2RlZmluZSBTRl9NQU5UQklUUyAgICAyMwog
CiAvKiBFeGNlcHRpb25zIHByb2Nlc3NpbmcgaGVscGVycyAqLworR19OT1JFVFVSTgordm9pZCBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IGV4Y2VwdGlv
biwKKyAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFBDLCB1aW50cHRyX3QgcmV0YWRk
cikKK3sKKyAgICBDUFVTdGF0ZSAqY3MgPSBlbnZfY3B1KGVudik7CisgICAgcWVtdV9sb2dfbWFz
ayhDUFVfTE9HX0lOVCwgIiVzOiAweCUwOCIgUFJJeDMyICIsIEAgJTA4IiBQUkl4MzIgIlxuIiwK
KyAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCBleGNlcHRpb24sIFBDKTsKKyAgICBBU1NFUlRf
RElSRUNUX1RPX0dVRVNUX1VOU0VUKGVudiwgZXhjZXB0aW9uKTsKKworICAgIGVudi0+Z3ByW0hF
WF9SRUdfUENdID0gUEM7CisgICAgY3MtPmV4Y2VwdGlvbl9pbmRleCA9IGV4Y2VwdGlvbjsKKyAg
ICBjcHVfbG9vcF9leGl0X3Jlc3RvcmUoY3MsIHJldGFkZHIpOworfQorCiBHX05PUkVUVVJOIHZv
aWQgaGV4YWdvbl9yYWlzZV9leGNlcHRpb25fZXJyKENQVUhleGFnb25TdGF0ZSAqZW52LAogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBleGNlcHRp
b24sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnRwdHJf
dCBwYykKLS0gCjIuMzQuMQoK

