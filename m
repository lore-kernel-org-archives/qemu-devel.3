Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F47ACD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:33:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzi-0008Pf-3S; Thu, 11 Jun 2026 01:30:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzT-00086p-Bw
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:30:08 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzR-000161-H7
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:30:07 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GK2D2248024
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=; b=OZ43QU7grVst4TPd
 4JRQ+VBXCEjvS015AuHaFuwiwDD49LQkJxO1noIqhVFFzb9UcnRw5rFGo0LWJRie
 atUNTHXveDz+pChZsFdcbZQ+cjgK1T1/Ax5yhyK+vYThbrHbVXleVl/+MuV+ZYLQ
 mNb+SpqFa57s2KvYgUstvH7xWuBJ+OfWgDih/MD9RgvUFeQWDHrHHYWjuwgthpXY
 TaNkN7wBsSoPjqMpO09G/iKw80NJETGvFB1OHCuPV+J5yLRQk6bZ8R0CN1YNIHzc
 bpLBqbTb33KjawDskAGXoNOFScpMJAEnJi8MuoXD0hp/YvfDZ2LzL0+zEboSuX/w
 7i91sA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe79hr5y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:53 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so10599341eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155793; x=1781760593; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=M1UJhvu7rEiNlNd3xWYP8Xj4zflKhB6R7ompFZwzRsFip8TUddonXlQ+vyB2rk9m8b
 aqKR0CTBjfSnfzP0EAHthOdfJsSEAWe2Ki32dMVqCtuY6wHslplL13wJOAHAkH03f4Xf
 mXhwuZn9ckSatTAcMAJAGIWKnFvb5h+qz0SEvRSIDnEVxQ6kGBErFxMH7EinEwTt+ep8
 9z2TA26ROGyi/eAeRnWVMgYqA/VrPvtC3w7+Xo+ymKR65spKkoy/1c26MIhNrA+97kzd
 JmapJsJEj1RdcIZaL+Web0lxYwAsQP0jG1BnZ3k+fe3Ll38zEuDShd6DdSeK2EY0RZc+
 USag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155793; x=1781760593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T4QeLlBFUTpGlmsbriWoI9s9TWXslg2oBf/G9cVJFSw=;
 b=VElU/0DfABcS8DwDB7RyUfFtl0IZ9Qk2X5FuXK5ZHcIdmsO4g/fLriztrvO4+2b+7l
 m05bRP3+JwhKrX8h/Xwt+BKBPFmY4etBGUTx6Lv7c5/jsUs0A8amZLmsNAWe5Q8PB7b6
 b+Gydhy1TyH1Th3pstWmSnaw1RuNF1XWZq7ENk1JbfhRNcJmc/mDC/H3OLnmhrnmszBa
 Rbc8aPLuFVbjtJQfURqT32iDTksVedNuZLKpBzXWG97lJrvr98LAGtGaE8EbQBi5/UEk
 k56i6RqzgoTFJZVbprsx6j6+czkOt/Hg4XuTdG97ZE5zuWJ/bLIBks6EAoWo0SQkPp6b
 Tg1g==
X-Gm-Message-State: AOJu0YwG9H5jMGEljprmVyqiaEiLFtKHOJQpLHvZFHCgStwurrIS9x9C
 sf3FigsQfKdIMt/KpwlWl6EotMI/JIw9sktTSHNes/PsElC3VYQKODCfJYHSZ82pfKzePbpNWaz
 NrDn31gUZiYcAY0o1aHeOGqk4s8zxWf4JXH1AKRT6p0zLg8OlL6TQ9iPvFNaYetBfHw==
X-Gm-Gg: Acq92OGjqnUlEM6xQ11HPolLLUuCG14jMIQfHJegc61xW4luJUMZ2TpxDkKqJHdIAJ8
 n4M3MLRv0dD4lsCR5nhEZTh55jArAc8iL2IclxBFFILAE4wkY6WwGp7DPDWcVa59dR4aOiGwAbB
 qJpypXI4glU6/JD9AUc3Ommwl+QqYcsP1oFWFMmLdH9vGW/90/etRfcyFaXWUu/v9x7XCSBM9ZG
 oZXaFGLx3UAEvI58M/dlkVH7zM5rb0jvkMUVW/Rcv3zNWa+YVAIhsGmLcA9lMerJFtW88RYTPJA
 lYuDfROCDh5jQm4sJFkoY6cMPOzgo8WejKZD2ib8z05yhZEEovsJxeKvOwP1vASwH84hG0tqZZJ
 iohlwCcflONdNoL2IYGgGUVXCiIpbdpgEhlz4o1hC686IHeTy+L5XroKL7P5GFfrOrFWGkR0NNQ
 s4qdx1
X-Received: by 2002:a05:7300:1801:b0:2ed:b131:240e with SMTP id
 5a478bee46e88-30804a40d59mr1063525eec.23.1781155793240; 
 Wed, 10 Jun 2026 22:29:53 -0700 (PDT)
X-Received: by 2002:a05:7300:1801:b0:2ed:b131:240e with SMTP id
 5a478bee46e88-30804a40d59mr1063503eec.23.1781155792708; 
 Wed, 10 Jun 2026 22:29:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:51 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com
Subject: [PATCH v8] hw/hexagon: Declare hexagon TLB device interface
Date: Wed, 10 Jun 2026 22:28:54 -0700
Message-Id: <20260611052857.3911981-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: DxL8uK2zF_39MAlomKm4qWhU-CcRX19N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX8rwYOQ0Mvcd+
 zubQQ+ANiYNmSjBZQcxY9mWuHj65ZIGl3JJpGoAn1r6HeOCvgncVGNlbiRh/znDL4jJ3SnV+L9t
 EM8RwkCuAc1PpJ+ARMkaX8aqumOkbkR258X8XXr3xlTn9T1Koe6Mzhrrs/5xmltZm9clnhCCS1O
 8/EZSRSbykIb8ZX0OUGRxWyhZXxbLgoDfbwp8vIJ0OsSTYunF8kC7InrVz9CyyO1Wr1tHjRnHcU
 kU9WtD8QGpCTKAYv6FnEnhBzHEdpOjEjMMLrLY2xJyGmwG0PekTHMluXJ0YTP5+Gsc0h7c/kqSt
 +qiW/MMgpfxZIXN8lvo2QEgNKZzjYm9HJaQ1HRE93l7AVKQtvLcFi+Of+O9azQ70uzDj+P6KvfJ
 vE8SVY8KuRoO7RtKSR+4PRjVmRYBwDqlZSdVCDqWVt5poYVquC1UZ5l3mP/FjHvNDtC2YLuuDyS
 oa3XkhY3jRWpdoAxzRw==
X-Proofpoint-GUID: DxL8uK2zF_39MAlomKm4qWhU-CcRX19N
X-Authority-Analysis: v=2.4 cv=fbydDUQF c=1 sm=1 tr=0 ts=6a2a47d2 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=p_7iY2stt2bzV07uMJkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX6zljM0Xv5KAh
 DqQhV84W98zZuivDylaW14zbYXEXP5egv0oqyR0Z4MdN5OLTcuvHgUFTth3oWrLIx4dpoN+/Hw/
 Db1cpo3RAZjXD8rUQI/Xr8wGZ4QPS34=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110051
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

QWRkIHRoZSBoZXhhZ29uIFRMQiBkZXZpY2UgaW50ZXJmYWNlIGhlYWRlci4KClJldmlld2VkLWJ5
OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNp
Z25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0t
CiBpbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90bGIuaCB8IDQ2ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNDYgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFnb25fdGxiLmggYi9pbmNsdWRlL2h3L2hleGFnb24v
aGV4YWdvbl90bGIuaApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMC4uOTBk
OWVkODQwNDMKLS0tIC9kZXYvbnVsbAorKysgYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90
bGIuaApAQCAtMCwwICsxLDQ2IEBACisvKgorICogSGV4YWdvbiBUTEIgUU9NIERldmljZQorICoK
KyAqIENvcHlyaWdodCAoYykgUXVhbGNvbW0gVGVjaG5vbG9naWVzLCBJbmMuIGFuZC9vciBpdHMg
c3Vic2lkaWFyaWVzLgorICogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKKyAqLworCisjaWZuZGVmIEhXX0hFWEFHT05fVExCX0gKKyNkZWZpbmUgSFdfSEVYQUdPTl9U
TEJfSAorCisjaW5jbHVkZSAiaHcvY29yZS9zeXNidXMuaCIKKyNpbmNsdWRlICJxb20vb2JqZWN0
LmgiCisjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCIKKyNpbmNsdWRlICJleGVjL21tdS1hY2Nlc3Mt
dHlwZS5oIgorI2luY2x1ZGUgIm1vbml0b3IvbW9uaXRvci5oIgorI2RlZmluZSBUWVBFX0hFWEFH
T05fVExCICJoZXhhZ29uLXRsYiIKK09CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEhleGFnb25U
TEJTdGF0ZSwgSEVYQUdPTl9UTEIpCisKK3N0cnVjdCBIZXhhZ29uVExCU3RhdGUgeworICAgIFN5
c0J1c0RldmljZSBwYXJlbnRfb2JqOworCisgICAgdWludDMyX3QgbnVtX2VudHJpZXM7CisgICAg
dWludDY0X3QgKmVudHJpZXM7Cit9OworCit1aW50NjRfdCBoZXhhZ29uX3RsYl9yZWFkKEhleGFn
b25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCk7Cit2b2lkIGhleGFnb25fdGxiX3dyaXRl
KEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBpbmRleCwgdWludDY0X3QgdmFsdWUpOwor
Citib29sIGhleGFnb25fdGxiX2ZpbmRfbWF0Y2goSGV4YWdvblRMQlN0YXRlICp0bGIsIHVpbnQz
Ml90IGFzaWQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDMyX3QgVkEsIE1NVUFj
Y2Vzc1R5cGUgYWNjZXNzX3R5cGUsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHdhZGRy
ICpQQSwgaW50ICpwcm90LCB1aW50NjRfdCAqc2l6ZSwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBpbnQzMl90ICpleGNwLCBpbnQgKmNhdXNlX2NvZGUsIGludCBtbXVfaWR4KTsKKwordWlu
dDMyX3QgaGV4YWdvbl90bGJfbG9va3VwKEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBh
c2lkLAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQzMl90IFZBLCBpbnQgKmNhdXNl
X2NvZGUpOworCitpbnQgaGV4YWdvbl90bGJfY2hlY2tfb3ZlcmxhcChIZXhhZ29uVExCU3RhdGUg
KnRsYiwgdWludDY0X3QgZW50cnksCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50
NjRfdCBpbmRleCk7CisKK3ZvaWQgaGV4YWdvbl90bGJfZHVtcChNb25pdG9yICptb24sIEhleGFn
b25UTEJTdGF0ZSAqdGxiKTsKKworYm9vbCBoZXhhZ29uX3RsYl9kdW1wX2VudHJ5KE1vbml0b3Ig
Km1vbiwgdWludDY0X3QgZW50cnkpOworCit1aW50MzJfdCBoZXhhZ29uX3RsYl9nZXRfbnVtX2Vu
dHJpZXMoSGV4YWdvblRMQlN0YXRlICp0bGIpOworCisjZW5kaWYgLyogSFdfSEVYQUdPTl9UTEJf
SCAqLwotLSAKMi4zNC4xCgo=

