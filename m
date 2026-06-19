Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 144B3CD98F2
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 23:32:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waig4-0004D2-7I; Fri, 19 Jun 2026 19:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifr-00046O-Ak
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1waifp-0007U0-Na
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 19:30:59 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65JLXeaq2932941
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=; b=XsEKl2+oKi76K1QR
 KpppJ6xR2Fe4TuDw1EYPAbIJf78PULVeflMlmstQcI+CtYqcaQ7oXb92faK+QiE4
 3xEbxiYoHkepj+V+nG0pXaXSphmMU/WG3YZo/M2cTbQa7rvbWsRsjZVskn/lnfo3
 dbj53p0kPsxwnkNZE3Yv9PAjGogKprKRuVPfJpdiB58NhZvRh2pk3xa0PxCabWfC
 PHCsIJ1QlK5JzPYMB8VrFzgKdpHXzNYhSN2sr+XagcapU/LHugn/ug9zVd/p9hCI
 AzjCGxl/UYVpFK9nodoGsB8WiV2mA6Sq2DB8wHVLOz3+tjazgbyOzfiVqF1V1mLZ
 6276kg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ew5qsa52d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 23:30:46 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30ba395b047so10087314eec.0
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 16:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781911846; x=1782516646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=;
 b=J25HmJObTx/4IwJyRHXGBgPR4dnjcbVsaBP1Zcju8iZnHhOTBaMcOCSbFbXdlegeJD
 xq7AXXXFzkuWOxZWRl0/yWa6hbGP4gjjJzJ8qtkjPdw1CQwodEF7CAx0LfY1NfEUhc5d
 P8Uas2uJxMpNBrH5gcPx7LFeNrK2leoOGMiRu6u0dTfC+/WgvlbFAL/qt3eIaENFjai2
 C3FmexSkoLvNDu+TqmL+9Eb+5G1PqAeehaQklzXfZ8sNB1+y+3qeRXGFQrCYTnKzaZPC
 lrnBymmLPVY05mah5zWLpL1ZwRqX4KngHdzOCgwtKrDx+P5fC7DgpwlBi9+fDvEHab6F
 jMoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781911846; x=1782516646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W9aRU99FRJkCFdVjE14GeGuaLGKvifAUAOZ13h7xav8=;
 b=qfB0FDCX4oG8BA453S8VR+fXwH3mIgR9FzuHYlQUkjF79Q3YpyhES5aHRm0JeSR5Px
 VD+NrzxM4RfXA7qSSqCuPICnViSy1Feh7WwteqhzQbTUzm8+M1a6g4kfkizItqdVluLK
 9qImmsBGbgs0bXnN6xgIvxw77NI6hkpk2C8V7ECA5MW4JGiYuIQ2o0aS/wo524QxJ+OD
 Bhae2KZx5UC08lnw278vlxhMmXZXN5fuxCCMjtPqbeqFnEd1/WI0q8/XpAPTTkolbQLq
 RQAqrXGH6dBhIaUjnCBdnBpQYVMNddC+upvHTnGQlfEJsXLU6oj6OAtd/erPUImZPpGn
 uFyg==
X-Gm-Message-State: AOJu0YwbmuGEcn5mt93bI3Ad95IlgfmFV5sZya0adkiTS2kRN2JZVrqt
 M+xUYLVFS+9RS0DIW2CbfZYj4sBM765uRVTZMK5ZklIvutCBVPrnw6J15bZqUWATTLOc3jrrUs3
 71mnqj6S4F1zX6qANFtMvsMnCvbGeKS+x48brJ7KcfooaNar8uBUAOoBaZ/bCmkT5zQ==
X-Gm-Gg: AfdE7cnKg6TueBM5IvlKt9HRZNMspKUoeznpSvDizIi5ubhKZ/q6PpDwaQEQ51Gpzgr
 TVuRWXk642j+PINhhFsxb8tTn1+P2LpEnh6aWBIlZIDTndb9u0JHpKFOfrX9AWML+B2n77vFc6m
 GyOOy4/dUYL0maRHKqx6e3QnIWLlxUJMwS0HVd7GsG+6JBT4hgT6CnBfMvEAuyo0yCKLfIbNkFR
 OENLJXzkEfz6mTBbpQQLeSpx3zlrpGGRZL4a5tWk+oyX+thev3VxrH2NOWpwXvMVYjsy5rv+3uZ
 f+7SADqHSu+85Lue42cNhusrNLGKsWQFm+yDPK5CF10VJPC5mG+CEKJrTl37qpw+DwmEMmhO6pz
 0JlyRb7LZYajIwDdM4ryrghPIXPxgr4lb5wkUK/2/Vtd1EAFyZnEpyjBfD3Y=
X-Received: by 2002:a05:7300:1488:b0:30b:9e56:e547 with SMTP id
 5a478bee46e88-30c06fec282mr3400552eec.6.1781911845680; 
 Fri, 19 Jun 2026 16:30:45 -0700 (PDT)
X-Received: by 2002:a05:7300:1488:b0:30b:9e56:e547 with SMTP id
 5a478bee46e88-30c06fec282mr3400539eec.6.1781911845166; 
 Fri, 19 Jun 2026 16:30:45 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d75csm1212646eec.15.2026.06.19.16.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 16:30:44 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 63/74] target/hexagon: Add support for loadw_phys
Date: Fri, 19 Jun 2026 15:59:00 -0700
Message-Id: <20260619225911.159473-64-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
References: <20260619225911.159473-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX1Q56/X30uuG2
 M1MXmom5M4VJavv+bd7XPCBZldRDGFB3Azi/bx0bIv8r1KKTbAbRB8WkxjzIRs6oAw9U3Y9XD1I
 BcCgAt8o/MVIEqUYAxz/SXVc55/NxUOPRPJwOdyNZ+DZzya/xjdA0GYcBvQzGmLDA2+Q+ze5B1a
 GwmmpEs10zPA+dglRuY8frrdvThHCaayxOCYORcLmRzB6cyDSgbOtv62mUt1XQFGOgA7MrvKqJW
 nmhICD5fwfv2obqAfN+6iU5DJV4MD9KBzosGnXq7LEzZ3x0Pgk0bK0aW4RxKewakF5CU1oiREoa
 obZ8PoRHcbUiw0o0CUnfRyao9mtMs4GhCZj28skJyjMiDxV5hu1PbsHeR/ePeAPSv5xeYH5q9+2
 CYwpwEBdzMp4PnIdKYzn0uc1NyAH9FhFixhneKoNAKukb8iAgZZaW3si+zyu+C4w6qIxWY41sBw
 Qc14NJGfEfbFxGFdYHQ==
X-Authority-Analysis: v=2.4 cv=M9R97Sws c=1 sm=1 tr=0 ts=6a35d126 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=M_0_kNSAHlZdZebFLzYA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: j81CMSVZQAi3LwWy2zWCEumk0lmk_gb2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDIyNiBTYWx0ZWRfX3GL68neC3WQ0
 lnRWs2Clq3K5fVq+MsjSSEDBwp7kE9YmFIpNcvn75b3yy/4l4Yhe+EYGb+aF22PFIOGrJoyH+fj
 i0tMFYFSmrDFDo5GCqUYpPI9SLuT7Fs=
X-Proofpoint-GUID: j81CMSVZQAi3LwWy2zWCEumk0lmk_gb2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_05,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606190226
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgICAgICAgICAgfCAzICsrKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvZW5j
b2RlX3BwLmRlZiB8IDEgKwogdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmICAgICB8
IDMgKysrCiAzIGZpbGVzIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rh
cmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5
CmluZGV4IGFjYWFhM2M5NDRhLi5kOTFhNjUzYzNkNCAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFn
b24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0y
NjQsNiArMjY0LDkgQEAgZGVmIG5lZWRfc2xvdCh0YWcpOgogICAgICAgICBhbmQgIkFfQ1ZJX0dB
VEhFUiIgbm90IGluIGF0dHJpYmRpY3RbdGFnXQogICAgICAgICBhbmQgKCJBX1NUT1JFIiBpbiBh
dHRyaWJkaWN0W3RhZ10KICAgICAgICAgICAgICBvciAiQV9MT0FEIiBpbiBhdHRyaWJkaWN0W3Rh
Z10pCisgICAgICAgIGFuZCB0YWcgIT0gIkw0X2xvYWR3X3BoeXMiCisgICAgICAgIGFuZCB0YWcg
IT0gIkw2X21lbWNweSIKKyAgICAgICAgYW5kIHRhZyAhPSAiWTZfZG1saW5rIgogICAgICk6CiAg
ICAgICAgIHJldHVybiAxCiAgICAgZWxzZToKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2lt
cG9ydGVkL2VuY29kZV9wcC5kZWYgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9lbmNvZGVfcHAu
ZGVmCmluZGV4IDA0ZTkxMWY1OWM4Li4xYzY0NDk1ZDUxOSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvZW5jb2RlX3BwLmRlZgorKysgYi90YXJnZXQvaGV4YWdvbi9pbXBvcnRl
ZC9lbmNvZGVfcHAuZGVmCkBAIC0zODQsNiArMzg0LDcgQEAgREVGX0VOQzMyKEw0X3JldHVybl9m
bmV3X3BudCwgSUNMQVNTX0xEIiAwMTEgMCAwMDAgc3Nzc3MgUFAxMDEwdnYgLS0tZGRkZGQiKQog
CiAvKiogTG9hZCBBY3F1aXJlIFN0b3JlIFJlbGVhc2UgRW5jb2RpbmcgKiovCiAKK0RFRl9FTkMz
MihMNF9sb2Fkd19waHlzLCAgICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMXR0dHR0
IC0wMGRkZGRkIikKIERFRl9FTkMzMihMMl9sb2Fkd19sb2NrZWQsICAgIElDTEFTU19MRCIgMDAx
IDAgMDAwIHNzc3NzIFBQMDAwLS0tIDAwMGRkZGRkIikKIERFRl9FTkMzMihMNF9sb2FkZF9sb2Nr
ZWQsICAgIElDTEFTU19MRCIgMDAxIDAgMDAwIHNzc3NzIFBQMDEwLS0tIDAwMGRkZGRkIikKIApk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmIGIvdGFyZ2V0L2hl
eGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCmluZGV4IDUzMTk4MTc2YTk5Li40ZTFlNWQ1MzI2ZCAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQvbGRzdC5pZGVmCisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkL2xkc3QuaWRlZgpAQCAtMjAzLDYgKzIwMyw5IEBAIFE2SU5TTihT
Ml9zdG9yZXdfbG9ja2VkLCJtZW13X2xvY2tlZChSczMyLFBkNCk9UnQzMiIsIEFUVFJJQlMoQV9S
RUdXUlNJWkVfNEIsQV9NCiBRNklOU04oTDRfbG9hZGRfbG9ja2VkLCJSZGQzMj1tZW1kX2xvY2tl
ZChSczMyKSIsIEFUVFJJQlMoQV9SRUdXUlNJWkVfOEIsQV9NRU1TSVpFXzhCLEFfTE9BRCxBX1JF
U1RSSUNUX1NMT1QwT05MWSxBX1JFU1RSSUNUX1BBQ0tFVF9BWE9LLEFfTk9URV9BWE9LKSwgIkxv
YWQgZG91YmxlIHdpdGggbG9jayIsCiB7IGZFQV9SRUcoUnNWKTsgZkxPQURfTE9DS0VEKDEsOCx1
LEVBLFJkZFYpIH0pCiAKK1E2SU5TTihMNF9sb2Fkd19waHlzLCJSZDMyPW1lbXdfcGh5cyhSczMy
LFJ0MzIpIiwgQVRUUklCUyhBX1JFR1dSU0laRV80QixBX1BSSVYsQV9SRVNUUklDVF9TTE9UME9O
TFksQV9OT1RFX1BSSVYsQV9NRU1TSVpFXzRCLEFfTE9BRCxBX05PVEVfTk9QQUNLRVQsQV9SRVNU
UklDVF9OT1BBQ0tFVCksICJMb2FkIHdvcmQgZnJvbSBwaHlzaWNhbCBhZGRyZXNzIiwKK3sgZkxP
QURfUEhZUygxLDQsdSxSc1YsUnRWLFJkVik7IH0pCisKIFE2SU5TTihTNF9zdG9yZWRfbG9ja2Vk
LCJtZW1kX2xvY2tlZChSczMyLFBkNCk9UnR0MzIiLCBBVFRSSUJTKEFfUkVHV1JTSVpFXzhCLEFf
TUVNU0laRV84QixBX1NUT1JFLEFfUkVTVFJJQ1RfU0xPVDBPTkxZLEFfUkVTVFJJQ1RfUEFDS0VU
X0FYT0ssQV9OT1RFX0FYT0ssQV9SRVNUUklDVF9MQVRFUFJFRCxBX05PVEVfTEFURVBSRUQpLCAi
U3RvcmUgd29yZCB3aXRoIGxvY2siLAogeyBmRUFfUkVHKFJzVik7IGZTVE9SRV9MT0NLRUQoMSw4
LEVBLFJ0dFYsUGRWKSB9KQogCi0tIAoyLjM0LjEKCg==

