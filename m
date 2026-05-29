Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05352CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5CQ-00062v-3Y; Fri, 29 May 2026 17:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CN-0005sf-AO
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CL-0000W2-Nq
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:59 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2NAC2998079
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qN6qj7dmsv49cYYqTHTmth7gJNWedgjE35QwPzPIUD0=; b=auIHJpH33BNn0BgM
 /rkbEHh0cQOUN/pKqM/+zwAB7qBm9l4DDejbYs2o6AWUy8XcNZzSh2nINCxJA5zK
 IJwlvdBFbEi912obI4HL4bqjfr6YgJTQJ67+PRSz/YBhMMB8KOfKHNIu3M4RxRAy
 v8ex9CckUd7xUV/kckFcCVmpZaVMlVTB1V8zFk8rKUG8c84q8wl9IJMHiU8j+0Kn
 1dHeZuafWF0sz8c0cPtXj6d97mL/RFjuXeuwRaNkbT+K5xFLzn0OtcTHIMU0AfnW
 6ta4fFxTU2bSlQ6SBimItoFOItIFYJKGjD8PluPwRzIkQmfIRBDGqLC9ET/oG+42
 Xl8/rw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4ena-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:46 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso2806052eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091806; x=1780696606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qN6qj7dmsv49cYYqTHTmth7gJNWedgjE35QwPzPIUD0=;
 b=XkrMXIiKtM4MGR+Mp2GNrjgOpmaoq+8rVARjce3qN8zQM9jVJgrbW5GA0mwGSAWjl3
 j1GDtIAphamnQ6MyvbYnE5DmlitI9eyHdgNc9Fi68vPFmib6B3Ql8Z+U2gY7vhvdy9K4
 KBHOXqQ6lAIOI1HoLlXsEXjZdeWc3/QReg2lYoeTecOD5iNI5eOgQombrL2WPNePSmsm
 3fXClgOCjhF9d2IRJSyILpy4X2Ts2/WiJ+q+YdGCpBiByqPJYIJsqwz9skYdovYaAt6X
 ktYMcWdo+o/6NU0lRkf4Fg5eH7tgsFV8rCTC5lNVB/pALEhdwbG8hllfCURAM/0kIQak
 M2Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091806; x=1780696606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qN6qj7dmsv49cYYqTHTmth7gJNWedgjE35QwPzPIUD0=;
 b=B3TrFxSproXJS5jFY93vB3AVXl7CfvQ5dFnxEwY/27xb620HK5aw4M3yS6n756wrK6
 D2dLLjn6z8M1DIOuDnTNwLBKu4BMzvHQvKOTBDF7GavBDhDvXOXJA631PZIOzckvZl1z
 Eb/FC5jJlNKzbQJHtmFKDPy1FVUOEKDUE4PUicrNEEJJwAkWVczd8JRdomMkDMroUmVu
 sA/Z8Dnw/JvvcJTnFmZj3wxM7/U+QLoabia8f7lJ0lhpMHEDtraNsCLiDxHWgSVe8Ujn
 tx7Z9oVqUlQzYZ//1X7Vq9nVy5KKjAbj52+n+32gYNRd1cmBzzFapj/CrWPLRdWl54oB
 vjoQ==
X-Gm-Message-State: AOJu0YyskizTOmP6+MYfeAti9spj+UWiyItkRJNKupYASDZGk+kFfP3z
 UBgMF4gcCAM9dYj2q892eeFsiSEMqI7P3OuLELriyHFlHx+adF8VRzmOkCEUi91dOcujyC1+9Tj
 NEQZVOXqmvBHoobF3KlcDkqchXoG4omZopKSGDC42lTLbyUYtnDsRdqrbk1/c3UEBVg==
X-Gm-Gg: Acq92OGiM3gclVH38+/+iEWCFb2BXSXNU3Y5PLFoWWqtDeOZ8LrHejIFdkX8D4d0Hup
 XSHcbKLimG70b1rh6IEXkKDhOWsMni1ygRomJiYaHJ9qzaN9Ru+Yue8FmONnGwU+XpNOXGcE7ot
 OBCCl9wYnJEePj6WEjQd4qDT8qQ8WuAOpuU/FAUbHy/G8cVq3GVJb7gHP8EngLSq/F7x4c6k9Mz
 7WNlCgeliKnqFci4D/Yw1eWZ21oGI2/AAKgNlXmLVxedVLo2ltesamE4T4gWrgM4L0e/Yd76nqW
 UDkx/IQm1RZBpjE24M9zgK8xc4irEttzytMMPyArFwScJCUlImdKiHp93zWCZN9EKN3tVZvQ3WA
 /8X8FwwFRbD0gw79kqKdDGtp3dDnVRTSi60vdoUfeVP/zV+BVx0KTCK7HUQWZxoFdIvVt+ATRYu
 vfbIPd
X-Received: by 2002:a05:7300:2382:b0:304:59cc:aee8 with SMTP id
 5a478bee46e88-304fa5a9b32mr778695eec.18.1780091805705; 
 Fri, 29 May 2026 14:56:45 -0700 (PDT)
X-Received: by 2002:a05:7300:2382:b0:304:59cc:aee8 with SMTP id
 5a478bee46e88-304fa5a9b32mr778678eec.18.1780091805199; 
 Fri, 29 May 2026 14:56:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:43 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 28/38] target/hexagon: Add TCG overrides for rte, nmi
Date: Fri, 29 May 2026 14:55:44 -0700
Message-Id: <20260529215554.606133-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX+YKnhcXxAHEx
 emWR9yfhag9Vat1S1dv4LqOmxUkE3sr1/0m7CSY9SWB/CRnfcYdzpw5ziVeozWDzqvgFNwnmX0M
 7fUQ4n4k6kM4YDxEhr58tozhYd1iYTjLlq6EKVm2+KNyp8trPaU7i07V7JWc/EebgD6aKA1MtL0
 Q7O91zbrlC6i/0IayhudAjP41apCEvbYMdP1NLdFl+7DFnnvqU4DUSnkqUYiTGYRVDkahQyKdTs
 enhD2Xf12FiZSL0ypEU/3nc0WvOT79j1t63I5hV9cBKq0AD9Jt0KEQWGS3P2FoalQkdtodmKJ8+
 Qfz3loXsM893G4No9z+qOiLLoCd0P3CiDNbCka4S9nhSo60YfWT8hBMD4/GD++hSewrRfyqgYN1
 d7ZCliqFpPaMrFMs32hAv5ksth9Vxmii0VaQmgqRLN36oZXuJGAq+9hmg18RwubDYUmLOKmDcKz
 GPNA+HKMwmRqIlh4nZQ==
X-Proofpoint-ORIG-GUID: YBpI4sO09Q9g3AOEHK04vfcNEDA_hOhK
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0b9e cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=zRxYJKy5J8nCns2dKEsA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: YBpI4sO09Q9g3AOEHK04vfcNEDA_hOhK
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl90Y2dfc3lzLmggfCAxOSArKysrKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9oZWxw
ZXIuaCAgICAgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgICB8ICA0ICsrKysK
IDMgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9o
ZXhhZ29uL2dlbl90Y2dfc3lzLmggYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCmluZGV4
IDg2NTBmNjRhNmQ0Li4wMDBmYzQxNWM3NCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2Vu
X3RjZ19zeXMuaAorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnX3N5cy5oCkBAIC05NSw0ICs5
NSwyMyBAQAogICAgICAgICBnZW5faGVscGVyX3N0b3AodGNnX2Vudik7IFwKICAgICB9IHdoaWxl
ICgwKQogCisvKgorICogcnRlIChyZXR1cm4gZnJvbSBleGNlcHRpb24pCisgKiAgICAgQ2xlYXIg
dGhlIEVYIGJpdCBpbiBTU1IKKyAqICAgICBKdW1wIHRvIEVMUgorICovCisjZGVmaW5lIGZHRU5f
VENHX0oyX3J0ZShTSE9SVENPREUpIFwKKyAgICBkbyB7IFwKKyAgICAgICAgVENHdl9pMzIgbmV3
X3NzciA9IHRjZ190ZW1wX25ld19pMzIoKTsgXAorICAgICAgICB0Y2dfZ2VuX2RlcG9zaXRfdGwo
bmV3X3NzciwgaGV4X3Rfc3JlZ1tIRVhfU1JFR19TU1JdLCBcCisgICAgICAgICAgICAgICAgICAg
ICAgICAgICB0Y2dfY29uc3RhbnRfdGwoMCksIFwKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
IHJlZ19maWVsZF9pbmZvW1NTUl9FWF0ub2Zmc2V0LCBcCisgICAgICAgICAgICAgICAgICAgICAg
ICAgICByZWdfZmllbGRfaW5mb1tTU1JfRVhdLndpZHRoKTsgXAorICAgICAgICBnZW5fbG9nX3Ny
ZWdfd3JpdGUoY3R4LCBIRVhfU1JFR19TU1IsIG5ld19zc3IpOyBcCisgICAgICAgIGdlbl9qdW1w
cihjdHgsIGhleF90X3NyZWdbSEVYX1NSRUdfRUxSXSk7IFwKKyAgICB9IHdoaWxlICgwKQorCisj
ZGVmaW5lIGZHRU5fVENHX1k0X25taShTSE9SVENPREUpIFwKKyAgICBnZW5faGVscGVyX25taSh0
Y2dfZW52LCBSc1YpCisKICNlbmRpZgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVy
LmggYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAppbmRleCA2ODJmMGM2YzI2ZS4uOWNhODdhY2Zl
NjMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhh
Z29uL2hlbHBlci5oCkBAIC0xMjcsNCArMTI3LDUgQEAgREVGX0hFTFBFUl8yKHN0YXJ0LCB2b2lk
LCBlbnYsIGkzMikKIERFRl9IRUxQRVJfMShzdG9wLCB2b2lkLCBlbnYpCiBERUZfSEVMUEVSXzIo
d2FpdCwgdm9pZCwgZW52LCBpMzIpCiBERUZfSEVMUEVSXzIocmVzdW1lLCB2b2lkLCBlbnYsIGkz
MikKK0RFRl9IRUxQRVJfMihubWksIHZvaWQsIGVudiwgaTMyKQogI2VuZGlmCmRpZmYgLS1naXQg
YS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
CmluZGV4IGRhMDBkZmQ2NWMzLi44N2RhMWZlNDMwYyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFn
b24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE0Nzks
NiArMTQ3OSwxMCBAQCB2b2lkIEhFTFBFUihzZXRwcmlvKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgdGhyZWFkLCB1aW50MzJfdCBwcmlvKQogICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVk
KCk7CiB9CiAKK3ZvaWQgSEVMUEVSKG5taSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90
IHRocmVhZF9tYXNrKQoreworICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7Cit9CiAjZW5kaWYK
IAogCi0tIAoyLjM0LjEKCg==

