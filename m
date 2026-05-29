Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FD39CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:01:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Dp-0004Zx-Te; Fri, 29 May 2026 17:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dn-0004Oo-G9
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:27 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5Dl-0000tA-G1
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:27 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2Kqq2998017
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0yxF1ltXXIDanlw4lkA3r4pCeK1rhMon8NWDhqLpzTU=; b=V7lNAlhrn0qRhsx6
 Ko1nV7Q+TI41zMOIXjsgngTezh+QnbrYHf95qpC7N1t/kkU7tyhbEtgraH/d4eYr
 hwnK4hMN7z+7wr8zo3QI1wtMDswnx5R2l5OYqdJUWDXpT8ONDXm7e4yTSGuGi1R7
 P83BP9pXsHt4tBQa/aKAer52YROFFM98sjdvEJqNH5gK0PoSFI1VVVoBNRBmJO6P
 c5lG8BFAwKwAxRzRK1/LPdhOT6F6zMIrjCExWixYsR1JHbsrhpxuUbmTeBH6ba/B
 pguR+oxoi6gQf0GB/XvKvR06rpFT3n1vh7CLUC4koHCCsJfYwai18ohqP3Xasm/k
 vZHFfg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4euk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2fe1cf409a1so4777440eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091904; x=1780696704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0yxF1ltXXIDanlw4lkA3r4pCeK1rhMon8NWDhqLpzTU=;
 b=B5oJgbwmpenNzhEuIttCnLRZ7kCeSIxy+TDsSROUh3Nlm+pWqeGpWClLGxDblaeYGv
 9VxfZlr/FfrfH2JWfRKIzwv8lwOgrNukFgOAU1ZvM1LY3alRQ4pjNlpIW633FQ7fojuB
 e/Ve6xC5ObS6fBkJnq8Dt2G0GMkrkiidG9ycmyiWYBGKu719dQhpwZxNaK0yqWkSkPrF
 vmPzFlz1S09FmW5ndpupIAqOwXGcKcP1TI79W/9Bk9LdlQnYUqm6HIBRniKEG4wj6t5g
 knYKtS+9bA/AFeOFprGEUgKrZ/V3NO5TWMEFcipXTwRqD7iIWct9VBeNJexxFl+8dpFR
 3vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091904; x=1780696704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0yxF1ltXXIDanlw4lkA3r4pCeK1rhMon8NWDhqLpzTU=;
 b=Hs5VNlPS8nMxfMzkd2TafRkzmInai9FFtsW798wtd3PsxEoA3Muq4D0sjBZ7OO2wo2
 /uVs9NJdt6NcLZSCGTWBu3qL9wUtEWkH9gy/fGFTjec1WveboONfAUCEZW4ZS81OMraz
 0HGBpQ7LdJC+BIkiEo+ibg3T2HmGcDeAPzZV0e2fcIDk9ycOkMle4XrnJedKOabz38y0
 exxniQt3fXn4eJKr0jkh0H49xMV+8d3DLvqDfxJFZP8ORt0L9V8RV5QBBNLairxzbJsy
 wVzsaBgASLzokc3QnGONWWHhZVJ10FN5XXmRD+4kgsryUcqZINtx9SPRFn3VQzgRiMlo
 VBgw==
X-Gm-Message-State: AOJu0YwQ2GIQYVCKIwFaKOtgc7mpZcaoux6CjvAt2nj9hez++E1ihz7t
 T+SWRmJtHTbIrSvvNctk0z74jzcFhr2e/le4QeekxsZE6d1zn8zG/qh9rnfk+T2DXUw60AMfO9B
 +JMKww/hRBAfI2aWtig2TCq4HjhFJ1tC2aDR4zJFq9zdjuyUYlrK4cAEtm1xVb9Tk3Q==
X-Gm-Gg: Acq92OFSXpn+w/IA0bUl7P6YZRA3o6BMwTC9J11Ym82jG38hNuJoYnMlcLWLYNTA5DA
 +8jTxErSx7XwNzKTvd8ZMFlhamm70UNrVhP70UuHbNokPIjBgPy6+e2xHnUKpGcy+j8srNbz6v2
 dpyko69tmYhVO9xPAhjfl6gLQR3UQs9xWYxoBi8C7KhlFv9z4tsJA8a0T5yXwXqcCogCz6gxTiF
 w5W+wM1jT5bdmzeslJA94AD3VNJQH+2p0fNTZpqv7rS+RItMrnwZcw6uq67rbDJbyk5+UTvYt4y
 T95KVIHZXqSQvhgZhruahM07Lkv7pB/nB6c4QshG2OQ3kWZ6z2dvvQy+D6DvJA0n8JmRy1dKQur
 6hgVt0G0bqKxZB37K9Z42cveh5dd3v+r5/+949CChYOrWo9qO8yuoMtzCcRObDkMNb+K7yWmw5N
 wiGc46
X-Received: by 2002:a05:7300:72c5:b0:304:5a53:7dac with SMTP id
 5a478bee46e88-304fa62a1c5mr737724eec.25.1780091903553; 
 Fri, 29 May 2026 14:58:23 -0700 (PDT)
X-Received: by 2002:a05:7300:72c5:b0:304:5a53:7dac with SMTP id
 5a478bee46e88-304fa62a1c5mr737710eec.25.1780091903005; 
 Fri, 29 May 2026 14:58:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:22 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 10/28] target/hexagon: Implement exec_interrupt, set_irq
Date: Fri, 29 May 2026 14:57:48 -0700
Message-Id: <20260529215806.608770-11-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX/7lFDT/PNXom
 WA4XF0UpEJC0CaLcahFwmBmFogKofScZDE4Vx92zePRk0CVIURv6LsJvGfjclo5z6AbD8Bh0wGx
 LW2x1bhzsGKOln2yGCTY78h4oiOmcimdaPWzHzqlshOOYSYwqcKMuoncT8Buam9lSbHYvWgqz+9
 kz+4/KNhM8lMJV4eEzBym6+ReNpGUg8ert1lz4y1gi6apDNcO3mZe17BqFI5qg68ij1ZNNAZD2n
 nQ2P2juzIlkJaqsHI1qAdLWnMTwjHmGgm+jQSXiTB6OeZR+1Kto3QOhc38oL+iVDGVCO6qFwJDt
 FYL8L2+HJ0XIecORrIpEj1A8XIRAlHlKCz1EO1xMJtB1ODuomOyUkHDYg51vMx9GcJiOfuP+6Ey
 FD21vlVNJ/MD58v63y2opbQ48EDDhSeO3tTkNVYkdq8T6LDFS3T2VbbJttoB65mOSn3L8B9Dvg6
 TTgyqO8iTUJ4XnTCO2w==
X-Proofpoint-ORIG-GUID: zjSXrxmVUdGCGAUys7QgQOg730_7ckZ9
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0c00 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=GA9jbsKyPMLDJDmtv64A:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: zjSXrxmVUdGCGAUys7QgQOg730_7ckZ9
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgODQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFn
b24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCBhNTU4NmMxMzg2Zi4uZjA4NjUw
MjAzNmMgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhh
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
dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAorI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCitz
dGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9zZXRfaXJxKHZvaWQgKm9wYXF1ZSwgaW50IGlycSwgaW50
IGxldmVsKQoreworICAgIEhleGFnb25DUFUgKmNwdSA9IEhFWEFHT05fQ1BVKG9wYXF1ZSk7Cisg
ICAgQ1BVU3RhdGUgKmNzID0gQ1BVKGNwdSk7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBj
cHVfZW52KGNzKTsKKworICAgIHN3aXRjaCAoaXJxKSB7CisgICAgY2FzZSBIRVhBR09OX0NQVV9J
UlFfMCAuLi4gSEVYQUdPTl9DUFVfSVJRXzc6CisgICAgICAgIHFlbXVfbG9nX21hc2soQ1BVX0xP
R19JTlQsICIlczogaXJxICVkLCBsZXZlbCAlZFxuIiwKKyAgICAgICAgICAgICAgICAgICAgICBf
X2Z1bmNfXywgaXJxLCBsZXZlbCk7CisgICAgICAgIGlmIChsZXZlbCkgeworICAgICAgICAgICAg
aGV4X3JhaXNlX2ludGVycnVwdHMoZW52LCAxIDw8IGlycSwgQ1BVX0lOVEVSUlVQVF9IQVJEKTsK
KyAgICAgICAgfQorICAgICAgICBicmVhazsKKyAgICBkZWZhdWx0OgorICAgICAgICBnX2Fzc2Vy
dF9ub3RfcmVhY2hlZCgpOworICAgIH0KK30KKyNlbmRpZgorCiBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9pbml0KE9iamVjdCAqb2JqKQogeworI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkp
CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUob2JqKTsKKyAgICBxZGV2X2luaXRf
Z3Bpb19pbihERVZJQ0UoY3B1KSwgaGV4YWdvbl9jcHVfc2V0X2lycSwgOCk7CisjZW5kaWYKIH0K
IAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisKK3N0YXRpYyBib29sIGhleGFnb25fY3B1X2V4
ZWNfaW50ZXJydXB0KENQVVN0YXRlICpjcywgaW50IGludGVycnVwdF9yZXF1ZXN0KQoreworICAg
IENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vudihjcyk7CisgICAgaWYgKGludGVycnVwdF9y
ZXF1ZXN0ICYgQ1BVX0lOVEVSUlVQVF9UTEJfVU5MT0NLKSB7CisgICAgICAgIGNzLT5oYWx0ZWQg
PSBmYWxzZTsKKyAgICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQVF9U
TEJfVU5MT0NLKTsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQorICAgIGlmIChpbnRlcnJ1
cHRfcmVxdWVzdCAmIENQVV9JTlRFUlJVUFRfSzBfVU5MT0NLKSB7CisgICAgICAgIGNzLT5oYWx0
ZWQgPSBmYWxzZTsKKyAgICAgICAgY3B1X3Jlc2V0X2ludGVycnVwdChjcywgQ1BVX0lOVEVSUlVQ
VF9LMF9VTkxPQ0spOworICAgICAgICByZXR1cm4gdHJ1ZTsKKyAgICB9CisgICAgaWYgKGludGVy
cnVwdF9yZXF1ZXN0ICYgKENQVV9JTlRFUlJVUFRfSEFSRCB8IENQVV9JTlRFUlJVUFRfU1dJKSkg
eworICAgICAgICByZXR1cm4gaGV4X2NoZWNrX2ludGVycnVwdHMoZW52KTsKKyAgICB9CisgICAg
cmV0dXJuIGZhbHNlOworfQorCisjZW5kaWYKKwogc3RhdGljIGNvbnN0IFRDR0NQVU9wcyBoZXhh
Z29uX3RjZ19vcHMgPSB7CiAgICAgLyogTVRUQ0cgbm90IHlldCBzdXBwb3J0ZWQ6IHJlcXVpcmUg
c3RyaWN0IG9yZGVyaW5nICovCiAgICAgLmd1ZXN0X2RlZmF1bHRfbWVtb3J5X29yZGVyID0gVENH
X01PX0FMTCwKQEAgLTQyNiw2ICs1MDcsOSBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFn
b25fdGNnX29wcyA9IHsKICAgICAuc3luY2hyb25pemVfZnJvbV90YiA9IGhleGFnb25fY3B1X3N5
bmNocm9uaXplX2Zyb21fdGIsCiAgICAgLnJlc3RvcmVfc3RhdGVfdG9fb3BjID0gaGV4YWdvbl9y
ZXN0b3JlX3N0YXRlX3RvX29wYywKICAgICAubW11X2luZGV4ID0gaGV4YWdvbl9jcHVfbW11X2lu
ZGV4LAorI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCisgICAgLmNwdV9leGVjX2ludGVy
cnVwdCA9IGhleGFnb25fY3B1X2V4ZWNfaW50ZXJydXB0LAorI2VuZGlmIC8qICFDT05GSUdfVVNF
Ul9PTkxZICovCiB9OwogCiBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9iamVj
dENsYXNzICpjLCBjb25zdCB2b2lkICpkYXRhKQotLSAKMi4zNC4xCgo=

