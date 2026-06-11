Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511F6CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY2Z-0001Ey-Fy; Thu, 11 Jun 2026 01:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2W-0000yd-9P
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2U-0002bF-59
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:15 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GQXb3817115
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=; b=X4uiPtuSZ7YLsygL
 9E/ewXURhL6tZaRxRLTLI4ohaT6TyWRQrdDE2fqlDcQLlaOHrtxaL0ZwY0iVZcxH
 CyQ92gt2TIBJBm85J7OTxkcH2/K23bmHLJP9eea9mEpOgUwYMeF/f8ueVhVMXPi3
 c46vnPBCg/AMpDTFXuP460LGI01DTyPCbTECXW82V4e1RlsYzXsNdvP3jqUi02DS
 Fg82BKC96Jr/AKQGn7ef+m8WDK3W//8TFvrq4GVF+al7II542nU493VJMXGpIx37
 2vuhVeJHvbjcnnXaIr3gsUKz8MVlZcjCjMrP/6KppjG0Dc4KjRHhcxrRzLmOuG8q
 Z+7Njg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6uss68-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:12 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-3074797dfa9so1752263eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155992; x=1781760792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=;
 b=UHtOWmUbDFuctT+KIgVhfWkeoWLFUqukenTqipZxeXj+LM5X58bTNlpoLPMWHlwA0J
 PMeFcbW8Ufonpo6YF+9CjK3Rvs07yILJIMa7QhsdHzuEnAeT8e687stCbonJXVS/OSWB
 +upG02jA7AieKw5OWwvHuUR2jS5RAt7Ma1I3r2ANbUD0S1/SWJN0q4RWJky2Uken5NBs
 JOSIyYTh58cuEzUGELmbB51ktkS+IfwkaN6smzdzZ6c+E/WGZpoJucoDVScfQWMjzHUi
 vXEn1nVyvqHsk73ySR3FPpx/wJ9PrTkl0Ius0EuRwGL44M5asNwjleosOkuMMCiqaK4W
 x1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155992; x=1781760792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zeFyaaj9ezk3dMnLRJvqloiuq+fIgJ0YErhEi239GAY=;
 b=XHQziHxESd3vttm5i+7ZDIRVEykiBM1T1ejo1P+hFfiUXRkcC2s6SNywu2kz9Ko90+
 SgT40sIS02NbHNX+HQ+U3EuFHwbNixJfibxcigdAqnLz6LFzaja8rYIMyH/ElprubxdA
 F0t/lyRDFKUxXfuMMWYpetbX+QOCniX3TnyKR8agvIqLWPNkpPmy2l9wfuton/h9S3xe
 VsLJJkgPsDcFtk/8u74POTqGywmumsO4UePv970AsT2P68PcLcXZrstcDVk4UcxMbVwk
 DvN3ZzSLqesaIOCAH/Qp3f4attibPsWP1aMMg/EKS7qrMnUUyhj5qV/4hXQoUPtiomJ3
 vuSQ==
X-Gm-Message-State: AOJu0YxzxrW+rhMq24s5YfVxIbQ3KpzQjDKLjjr1NKwgLZHPHojX/OI+
 3WK14m5PUmKdLbfVkrwadaNUqyvO+KjYuphPMfzt4zqMTFDoNpgPAFCNrW8tIu0MkZ0f1Qrhqli
 ErkAlVUl1yx3dIAurmd2juQg2FBuo3YmROoUC1bdqvCfZrc5eX+MMjeSxO7WcOFfchQ==
X-Gm-Gg: Acq92OGCIKpAtc/TTExK93Yzk6Km2L5AxGY5OLzXaUvlxr5Ub0Z3MffkoqPHmdebbOL
 AefgWrsP0vS4n1Wgwe8hPVCBzW2eJj6chQ0edVpfdPa0FdexVCTL27xDtfLYnH6M9sRNfVkzy3P
 AjOmBfj0aodIHkUNA7kQyDO+R6R6WD/XphiXGSpMhuzNVwhUANoBhzPb1CtXxJSlHGjtTt94MxR
 l2lrmzLwydMUC4fJA2dAkfwAn4Z4cSPcE5QZNLz1JIUcWxJj0xVgBkUxE1ExmGaUNHaV/5iyV1R
 mBxjbbJ+2Qh5eN7JIEPv5it1u6BkAWiJadBofTDtCUzFhaiHS+UMKf/ZSZ+Ul7X9CcyhdiGiqM2
 +H9eAHnkfw4UY0+rzvpwfCxbIbAfrJqTlyQeD+Bbl5JDWB9Xh6RWs1+nkMr0x22J/fVL0RRUpCY
 y5RdlJ
X-Received: by 2002:a05:7301:1291:b0:304:ab8:f87c with SMTP id
 5a478bee46e88-3080463b772mr1080363eec.12.1781155992149; 
 Wed, 10 Jun 2026 22:33:12 -0700 (PDT)
X-Received: by 2002:a05:7301:1291:b0:304:ab8:f87c with SMTP id
 5a478bee46e88-3080463b772mr1080346eec.12.1781155991624; 
 Wed, 10 Jun 2026 22:33:11 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:10 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6] target/hexagon: Implement exec_interrupt, set_irq
Date: Wed, 10 Jun 2026 22:32:31 -0700
Message-Id: <20260611053249.3918491-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=FJ8rAeos c=1 sm=1 tr=0 ts=6a2a4898 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GA9jbsKyPMLDJDmtv64A:9
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX/WpAoznCV5ue
 Gvz0mSFClYnc68GTZdUMBa+Ia63dQQOQ4PHTMKzADGYyapykz/16Qdk8SYDWsyG28eROXAhL6kO
 n2JaluGAS5f5DsGa2dEwaz74ngWSy2g=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX9vJBr1wE/dyB
 OmodUCD2fFbxW5ab3TYDPmIEaVUddtB+y4+HMdcdwHt0z6TFxRQ9MFQnN/ootBZZvdtbmX/OIA7
 XsaPsyOJCvpF28b3Cul57Zgh1bIBkrifO0LmP40Osx/BB42T6dDwtfdfe3M5JqL02nuyNPt+5o6
 nG2MmA7lpEOeFANinn9rqFpJjKEMZgMCfF9zUWs0IJ5MBOcDUPgNIlgXl0/z8HpcOWJhHvwc2j+
 u3lcYHf/PDY5kW8R5r30Yj1QdoUGfRpupVs40VIkd9N7ecSjWlLco2LN2J2N/i5qapLKyKrDMv/
 Hy2X30bYsEI1OTrAG/4Bm8pHsO2jquH/DFO0oadLPNjR3imEbjigxquxdiBjp5wTjD5Rn5hyTF7
 Pf1NMS1TceTBjSZPd/oW1JOPsPIrbIMUp1CbSTOWChVw7V5VaefXNPwHgqjo2buX6ARipLGnykU
 zDW/zIevN7aBT6A5INQ==
X-Proofpoint-GUID: FIu0GbzuAa5CrBFOsedrKH0cp80VuxoJ
X-Proofpoint-ORIG-GUID: FIu0GbzuAa5CrBFOsedrKH0cp80VuxoJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
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
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgODQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBlYzBjYTNlZTY3OC4uMGQ2NTUx
ZGQ1YjYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdS5jCkBAIC0xNiw2ICsxNiw3IEBACiAgKi8KIAogI2luY2x1ZGUgInFlbXUvb3NkZXAu
aCIKKyNpbmNsdWRlICJxZW11L2xvZy5oIgogI2luY2x1ZGUgInFlbXUvcWVtdS1wcmludC5oIgog
I2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImludGVybmFsLmgiCkBAIC0zMSwxMCArMzIsMTIg
QEAKICNpbmNsdWRlICJoZXhfbW11LmgiCiAKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2lu
Y2x1ZGUgIm1hY3Jvcy5oIgogI2luY2x1ZGUgInN5c19tYWNyb3MuaCIKICNpbmNsdWRlICJhY2Nl
bC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIgogI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjZW5k
aWYKIAogc3RhdGljIE9iamVjdENsYXNzICpoZXhhZ29uX2NwdV9jbGFzc19ieV9uYW1lKGNvbnN0
IGNoYXIgKmNwdV9tb2RlbCkKQEAgLTMwNCw2ICszMDcsMzYgQEAgc3RhdGljIHZvaWQgaGV4YWdv
bl9jcHVfc3luY2hyb25pemVfZnJvbV90YihDUFVTdGF0ZSAqY3MsCiAgICAgY3B1X2Vudihjcykt
PmdwcltIRVhfUkVHX1BDXSA9IHRiLT5wYzsKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
Citib29sIGhleGFnb25fdGhyZWFkX2lzX2VuYWJsZWQoQ1BVSGV4YWdvblN0YXRlICplbnYpCit7
CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gZW52X2FyY2hjcHUoZW52KTsKKyAgICB1aW50MzJfdCBt
b2RlY3RsOworICAgIHVpbnQzMl90IHRocmVhZF9lbmFibGVkX21hc2s7CisgICAgYm9vbCBFX2Jp
dDsKKworICAgIGlmICghY3B1LT5nbG9iYWxyZWdzKSB7CisgICAgICAgIHJldHVybiB0cnVlOwor
ICAgIH0KKyAgICBtb2RlY3RsID0KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZChjcHUt
Pmdsb2JhbHJlZ3MsIEhFWF9TUkVHX01PREVDVEwsCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgdGhyZWFkX2VuYWJsZWRfbWFzayA9IEdFVF9GSUVM
RChNT0RFQ1RMX0UsIG1vZGVjdGwpOworICAgIEVfYml0ID0gdGhyZWFkX2VuYWJsZWRfbWFzayAm
ICgweDEgPDwgZW52LT50aHJlYWRJZCk7CisKKyAgICByZXR1cm4gRV9iaXQ7Cit9CisKK3N0YXRp
YyBib29sIGhleGFnb25fY3B1X2hhc193b3JrKENQVVN0YXRlICpjcykKK3sKKyAgICBDUFVIZXhh
Z29uU3RhdGUgKmVudiA9IGNwdV9lbnYoY3MpOworCisgICAgcmV0dXJuIGhleGFnb25fdGhyZWFk
X2lzX2VuYWJsZWQoZW52KSAmJgorICAgICAgICAoY3MtPmludGVycnVwdF9yZXF1ZXN0ICYgKENQ
VV9JTlRFUlJVUFRfSEFSRCB8IENQVV9JTlRFUlJVUFRfU1dJCisgICAgICAgICAgICB8IENQVV9J
TlRFUlJVUFRfSzBfVU5MT0NLIHwgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKSk7Cit9CisjZW5k
aWYKKwogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN0b3JlX3N0YXRlX3RvX29wYyhDUFVTdGF0ZSAq
Y3MsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IFRyYW5z
bGF0aW9uQmxvY2sgKnRiLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb25zdCB1aW50NjRfdCAqZGF0YSkKQEAgLTQxMiwxMCArNDQ1LDU4IEBAIHN0YXRpYyBpbnQg
aGV4YWdvbl9jcHVfbW11X2luZGV4KENQVVN0YXRlICpjcywgYm9vbCBpZmV0Y2gpCiAgICAgcmV0
dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCitzdGF0aWMg
dm9pZCBoZXhhZ29uX2NwdV9zZXRfaXJxKHZvaWQgKm9wYXF1ZSwgaW50IGlycSwgaW50IGxldmVs
KQoreworICAgIEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKG9wYXF1ZSk7CisgICAgQ1BV
U3RhdGUgKmNzID0gQ1BVKGNwdSk7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52
KGNzKTsKKworICAgIHN3aXRjaCAoaXJxKSB7CisgICAgY2FzZSBIRVhBR09OX0NQVV9JUlFfMCAu
Li4gSEVYQUdPTl9DUFVfSVJRXzc6CisgICAgICAgIHFlbXVfbG9nX21hc2soQ1BVX0xPR19JTlQs
ICIlczogaXJxICVkLCBsZXZlbCAlZFxuIiwKKyAgICAgICAgICAgICAgICAgICAgICBfX2Z1bmNf
XywgaXJxLCBsZXZlbCk7CisgICAgICAgIGlmIChsZXZlbCkgeworICAgICAgICAgICAgaGV4X3Jh
aXNlX2ludGVycnVwdHMoZW52LCAxIDw8IGlycSwgQ1BVX0lOVEVSUlVQVF9IQVJEKTsKKyAgICAg
ICAgfQorICAgICAgICBicmVhazsKKyAgICBkZWZhdWx0OgorICAgICAgICBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9p
bml0KE9iamVjdCAqb2JqKQogeworI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisgICAgSGV4YWdv
bkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUob2JqKTsKKyAgICBxZGV2X2luaXRfZ3Bpb19pbihERVZJ
Q0UoY3B1KSwgaGV4YWdvbl9jcHVfc2V0X2lycSwgOCk7CisjZW5kaWYKIH0KIAorI2lmbmRlZiBD
T05GSUdfVVNFUl9PTkxZCisKK3N0YXRpYyBib29sIGhleGFnb25fY3B1X2V4ZWNfaW50ZXJydXB0
KENQVVN0YXRlICpjcywgaW50IGludGVycnVwdF9yZXF1ZXN0KQoreworICAgIENQVUhleGFnb25T
dGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisgICAgaWYgKGludGVycnVwdF9yZXF1ZXN0ICYgQ1BV
X0lOVEVSUlVQVF9UTEJfVU5MT0NLKSB7CisgICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsKKyAg
ICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKTsK
KyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorICAgIGlmIChpbnRlcnJ1cHRfcmVxdWVzdCAm
IENQVV9JTlRFUlJVUFRfSzBfVU5MT0NLKSB7CisgICAgICAgIGNzLT5oYWx0ZWQgPSBmYWxzZTsK
KyAgICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9LMF9VTkxPQ0sp
OworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9CisgICAgaWYgKGludGVycnVwdF9yZXF1ZXN0
ICYgKENQVV9JTlRFUlJVUFRfSEFSRCB8IENQVV9JTlRFUlJVUFRfU1dJKSkgeworICAgICAgICBy
ZXR1cm4gaGV4X2NoZWNrX2ludGVycnVwdHMoZW52KTsKKyAgICB9CisgICAgcmV0dXJuIGZhbHNl
OworfQorCisjZW5kaWYKKwogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhhZ29uX3RjZ19vcHMg
PSB7CiAgICAgLyogTVRUQ0cgbm90IHlldCBzdXBwb3J0ZWQ6IHJlcXVpcmUgc3RyaWN0IG9yZGVy
aW5nICovCiAgICAgLmd1ZXN0X2RlZmF1bHRfbWVtb3J5X29yZGVyID0gVENHX01PX0FMTCwKQEAg
LTQyNiw2ICs1MDcsOSBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29wcyA9
IHsKICAgICAuc3luY2hyb25pemVfZnJvbV90YiA9IGhleGFnb25fY3B1X3N5bmNocm9uaXplX2Zy
b21fdGIsCiAgICAgLnJlc3RvcmVfc3RhdGVfdG9fb3BjID0gaGV4YWdvbl9yZXN0b3JlX3N0YXRl
X3RvX29wYywKICAgICAubW11X2luZGV4ID0gaGV4YWdvbl9jcHVfbW11X2luZGV4LAorI2lmbmRl
ZiBDT05GSUdfVVNFUl9PTkxZCisgICAgLmNwdV9leGVjX2ludGVycnVwdCA9IGhleGFnb25fY3B1
X2V4ZWNfaW50ZXJydXB0LAorI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZICovCiB9OwogCiBz
dGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9iamVjdENsYXNzICpjLCBjb25zdCB2
b2lkICpkYXRhKQotLSAKMi4zNC4xCgo=

