Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64445CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:37:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY39-0002BU-Mq; Thu, 11 Jun 2026 01:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2u-0001h5-Tk
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:44 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY2t-0002rP-AV
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:33:40 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GClK3843632
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 C0N6L0VsODWcTmkNpYAs+/Ptwq9hq8dQoO0cvDCq6Us=; b=Reid4H6/3yfXctfN
 TnYwH0IiK8wilKegntkA9ltKAcnN1oztsrzBDwMTmBKG4kUwW9kCifpuKjXS/T2H
 tdTIB9qHwI/rTzozcolZpMTneWMFKLDRG9gMMCB3ciTOkd/rR5hGIJ92aM8K3RMg
 sUoQFn5aekg15jkGkqKDjAjYPTExiEZy439gdioGM/zMODS3Bm2bwDNJ+SFodYyN
 Nq0elDTNZJ+B6+BHhyCkMp6dl3hmjr4A9HHAMC/5orwSB346Z4Q6R1T0MuIoY4Ss
 L6e9vJSOioxVrGRJM2uaWKH9hIpIazsacO375rbjYAwWintLkvSVMFCqBNjpcaTt
 6JQgJg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe701rub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:33:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-307625ee07fso11483417eec.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156017; x=1781760817; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0N6L0VsODWcTmkNpYAs+/Ptwq9hq8dQoO0cvDCq6Us=;
 b=j6aj2k3pKlFBB77sT9KH+aSmR6Rgepp/35Ubwqyed0vXM6Rw0v9b7+KhRlcJU+outW
 ps8SWNR40popzfwYtf/qJ3ZOlwpHLX8FffFxq3mEVZRbWXCFKe4DzcO3VsLTaKC7xHgm
 U6iAFSqqMVya5lrbCOS33s/y37QpphcFCs90lJ08QW/9QSh18NNxe8vZEt4qVhO+evsM
 yB42USPM5uMnz2bVPGKDuejMcpxbmlB7qdoA0c7eJWPn4i+vXxbLxJZMAHKC0sX/08iF
 ND0CSC/23D27rmPLuD6HfXNTLa7pbnp10SWDeyE75C0ra+c9MJrDiUL6Z5sTSDLTm+0V
 F3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156017; x=1781760817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C0N6L0VsODWcTmkNpYAs+/Ptwq9hq8dQoO0cvDCq6Us=;
 b=Zry6mBOU5Q658VizMoF1M1iP2SVfjGjt7o2JPTBP/Nvt2MbDv0ciQGA5qS6R9aWAJ4
 rXyeQeCU77t3UMQQiKFrjjti1ujA9nUa3JDsZrmlBvARvCft+dq6uV2YPkxJ2LdDekiU
 UGOAr7uprbuDjibMvrsP9IVVVQNddQ46Yc8rksYVeZRno0DDTTfIXikqopJubEo11gsG
 nWHHQlsypPxvSqKN1bX1s3ya+ZEciCVc4TsW0LhMCYMD0/Pg9kTe+6vKgFVQa6fxRTv6
 U/YgT781C1QLftWf7PYLlnfHvM+ldpX95ZrWldlIYpKbc8y5eBNhM2TF9ZlPVV6WogAA
 3Y2g==
X-Gm-Message-State: AOJu0YxnBozyiwy9wjJ2jSqN7BX9kvr4E5ONL0BGHgzhBYizX+JR8i/h
 sY1fSRHJ3mZpFUGL9quCxaIRTk8EcEU5wrDo2eYIc9ECJZPQ5KndY0yr1YrIgQnvqiZ6Vy+9hiu
 4iS72ePaBpoVdMFv66AyiqK+Z9VYzeu+HkN8Ly++YE8PLx47jVHp86jtax2P5kZjewg==
X-Gm-Gg: Acq92OHEi5iTe9KSt9u2uDpPrgqyhBZalchXNy+FcF9NIs8kl+ZE0EKo30V2JafikLh
 VkWemDf4rAcbSX1K01qBE7K/qpiHW+PrF0EOkicKO806cCQjxfwRdCAVI3AtgWtc16IpTyLPPIa
 4HrhOYcsW3Fhw/yIYvgtSStIctkhwYU9EHTvUva+PzyrefO+3QXHbv26lL56mlS2ptjViFuIvtk
 GRojTUqGVasF9lemF1EOqQdrUbDRKalL5LhUPoz8RZmXquw5PiINhgZRlWtnf783KPCO0tMMSxE
 D1Mww/V7FY/+V9o/vmfL57AVKaD2L5EuTE9Ptf8mk8+9qUv94nc08YFPZl9LUMXfCreMVi0Uyc4
 ZEdIDVAu+mhM5z7HYdNIFupBOD8MkaZAD/5IDWQHZJIAEE+Cnh9vNndLM1u85tW/mTu5R5p9K0F
 8fcfma
X-Received: by 2002:a05:7300:7490:b0:304:e72a:d4d9 with SMTP id
 5a478bee46e88-308049eb621mr1178528eec.19.1781156017229; 
 Wed, 10 Jun 2026 22:33:37 -0700 (PDT)
X-Received: by 2002:a05:7300:7490:b0:304:e72a:d4d9 with SMTP id
 5a478bee46e88-308049eb621mr1178509eec.19.1781156016690; 
 Wed, 10 Jun 2026 22:33:36 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806ee207asm720800eec.29.2026.06.10.22.33.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:33:35 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com,
 Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
Subject: [PATCH v6] target/hexagon: Add guest reg reading functionality
Date: Wed, 10 Jun 2026 22:32:49 -0700
Message-Id: <20260611053249.3918491-29-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
References: <20260611053249.3918491-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: E_f2KD963XHNxfEuIhVy2FlV6MUhyu_T
X-Authority-Analysis: v=2.4 cv=B9eJFutM c=1 sm=1 tr=0 ts=6a2a48b2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=IJQQmebJWjVxhimlKuwA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX4LSUFNltYG3B
 Qf9exoipw8SVRE2cOwV4RblJCmBe+Ma8XxR217sYpLQSqCECwNF6zLiTCVFX57r6H82uXNugNj3
 RKSZ3K1B4eAxSZ0Ot3U1H+2Ziw5XSqPrQceq+xVV6drhFWZ6GyyXHVuj4OyJyEmVjQ2wP8Kqugg
 BvKhSVeWBVO9Y26FrFvdtzw1OQ+JgjtTFR363CVeug2PkEJggDXYGKngtVKUSyK52tvxK/flDWW
 OrNltgo8j7wSXp0XECYhjWNMsa86rBINOD3IhZdS9HE9cXA95BS21pA7697khOWDGobD5fE1Sqb
 wXk8+yoHh8VB2pjrImAICdgIxPSaKj3Qwk649CviXQtDR67bAJ51AzuImPF7fQsx6abVcVWMlhr
 L2uZr4HeEpkBIB/h9V8m9txBrsONNozB87SLO0eiCSNCQEK9YFNTv9O+Dus485+fG8cHgaT8doR
 SosKiqnWGjm5Qvm5sWw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MiBTYWx0ZWRfX1nRsEdeQ3xcm
 /+kBL7xLnJcA9YSF2k88u7wFXi17mY2KVUgKapn8OUsYELdUzm/eJpJYCirdSmjJLCI0/JZitu/
 V5prnq9jo3G+yPCg3iazhnJMQT+2Z4I=
X-Proofpoint-ORIG-GUID: E_f2KD963XHNxfEuIhVy2FlV6MUhyu_T
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110052
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

RnJvbTogTWF0aGV1cyBUYXZhcmVzIEJlcm5hcmRpbm8gPHF1aWNfbWF0aGJlcm5AcXVpY2luYy5j
b20+CgpTaWduZWQtb2ZmLWJ5OiBNYXRoZXVzIFRhdmFyZXMgQmVybmFyZGlubyA8cXVpY19tYXRo
YmVybkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgfCAgMSArCiB0
YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysKIHRhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMTYgKysrKysrKysrKysrKystLQogMyBmaWxlcyBjaGFu
Z2VkLCAzNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5kZXggNmE5NWE2YmM1YjEu
LjRhMTJkYzA0NzI3IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuaApAQCAtMjIwLDYgKzIyMCw3IEBAIEdfTk9SRVRVUk4gdm9pZCBoZXhh
Z29uX3JhaXNlX2V4Y2VwdGlvbl9lcnIoQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgKiBub3Qgc3Rv
cHBlZC4KICAqLwogYm9vbCBoZXhhZ29uX3RocmVhZF9pc19lbmFibGVkKENQVUhleGFnb25TdGF0
ZSAqdGhyZWFkX2Vudik7Cit1aW50MzJfdCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgcmVnKTsKIHZvaWQgaGV4YWdvbl9jcHVfc29mdF9yZXNldChDUFVI
ZXhhZ29uU3RhdGUgKmVudik7CiAjZW5kaWYKIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCAxMWExYTUyMjE2Yy4uNGZlMDkwMjFh
NWQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29u
L2NwdS5jCkBAIC03NjksNiArNzY5LDI1IEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2NsYXNz
X2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAjZW5kaWYKIH0KIAorI2lm
bmRlZiBDT05GSUdfVVNFUl9PTkxZCit1aW50MzJfdCBoZXhhZ29uX2dyZWdfcmVhZChDUFVIZXhh
Z29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQoreworICAgIGlmIChyZWcgPD0gSEVYX0dSRUdf
RzMpIHsKKyAgICAgICAgcmV0dXJuIGVudi0+Z3JlZ1tyZWddOworICAgIH0KKyAgICBzd2l0Y2gg
KHJlZykgeworICAgIGNhc2UgSEVYX0dSRUdfR1BDWUNMRUxPOgorICAgICAgICByZXR1cm4gaGV4
YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudF9sb3coZW52KTsKKyAgICBjYXNlIEhFWF9HUkVHX0dQ
Q1lDTEVISToKKyAgICAgICAgcmV0dXJuIGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnRfaGln
aChlbnYpOworICAgIGRlZmF1bHQ6CisgICAgICAgIHFlbXVfbG9nX21hc2soTE9HX1VOSU1QLCAi
cmVhZGluZyBncmVnICUiIFBSSWQzMgorICAgICAgICAgICAgICAgICIgbm90IHlldCBzdXBwb3J0
ZWQuXG4iLCByZWcpOworICAgICAgICByZXR1cm4gMDsKKyAgICB9Cit9CisjZW5kaWYKKwogc3Rh
dGljIHZvaWQgaGV4YWdvbl9jcHVfY2xhc3NfYmFzZV9pbml0KE9iamVjdENsYXNzICpjLCBjb25z
dCB2b2lkICpkYXRhKQogewogICAgIEhleGFnb25DUFVDbGFzcyAqbWNjID0gSEVYQUdPTl9DUFVf
Q0xBU1MoYyk7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDQzMjIwYTEyMWY2Li43ZDc4YTYyNjUwNyAxMDA2
NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24v
b3BfaGVscGVyLmMKQEAgLTE4NzcsMTMgKzE4NzcsMjUgQEAgdWludDY0X3QgSEVMUEVSKHNyZWdf
cmVhZF9wYWlyKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVnKQogfQogCiB1aW50
MzJfdCBIRUxQRVIoZ3JlZ19yZWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3QgcmVn
KQorCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICByZXR1cm4gaGV4YWdvbl9n
cmVnX3JlYWQoZW52LCByZWcpOwogfQogCiB1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIp
KENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCisKIHsKLSAgICBnX2Fzc2VydF9u
b3RfcmVhY2hlZCgpOworICAgIGlmIChyZWcgPT0gSEVYX0dSRUdfRzAgfHwgcmVnID09IEhFWF9H
UkVHX0cyKSB7CisgICAgICAgIHJldHVybiAodWludDY0X3QpKGVudi0+Z3JlZ1tyZWddKSB8Cisg
ICAgICAgICAgICAgICAoKCh1aW50NjRfdCkoZW52LT5ncmVnW3JlZyArIDFdKSkgPDwgMzIpOwor
ICAgIH0KKyAgICBzd2l0Y2ggKHJlZykgeworICAgIGNhc2UgSEVYX0dSRUdfR1BDWUNMRUxPOgor
ICAgICAgICByZXR1cm4gaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3VudChlbnYpOworICAgIGRl
ZmF1bHQ6CisgICAgICAgIHJldHVybiAodWludDY0X3QpaGV4YWdvbl9ncmVnX3JlYWQoZW52LCBy
ZWcpIHwKKyAgICAgICAgICAgICAgICgodWludDY0X3QpKGhleGFnb25fZ3JlZ19yZWFkKGVudiwg
cmVnICsgMSkpIDw8IDMyKTsKKyAgICB9CiB9CiAKIC8qCi0tIAoyLjM0LjEKCg==

