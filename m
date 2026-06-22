Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56FDBCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbneJ-0004HN-DE; Mon, 22 Jun 2026 19:01:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndi-0003KY-GJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:01:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndg-0002dN-Lh
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:01:14 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZjww3222613
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:01:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=gn83dxXALMHX9hShj5DO/MP/66YGPFEzq+6xQ++j3U4=; b=bY
 /MUOHEs1tFk+QrKfoLfWkZQQ/tbn6zoyPDjd4/SGp+/7NC/hU6LKvsigwpKH2L/Q
 2t9mFG/5hE1VlqhNkNyv2j7Jr7Asf3OEprSIVZ63tZVx+qEm9c6k+AIpDJnFyDpm
 A60Bjj7/qBlnDcFK1np4fM+KYs2lzbcAu3zf93LouR+LVPZSX2Pep4tEExdXL6uZ
 0WHgujskuk0+nrfhDNzEj8HFeSF960YVdTuaUe3eAJOtR20anJhnsGTNbQQx0+ef
 DIPL9VL3DS5MHHnMxCUH7gCsAUMyaU8R9H5WUW8RFaxRZNuWHxRvz5W6cvLsnceV
 IC/jdnmtHB4954mXlDQQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey5sn20hg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:01:01 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139553dd8acso21360280c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169260; x=1782774060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gn83dxXALMHX9hShj5DO/MP/66YGPFEzq+6xQ++j3U4=;
 b=CM+0a23rA2e+pnmWr/VciatTNh0S//e5yVn+2qi6nllwxAZHXQRY7Ldnc5KzL7DQey
 s/xtoCKy/ed7c3Q+Xj0m1E+IZsWv2MwSlR0y7s++JC3lYKE7B6G+33rNuQhXR45nRxXV
 H0U+5WkGa478RMZmWoEwAlFo5Z68OFwrbvXlKgPmqyL8oyqs6T9vZxpjgR4t7zcPYNhg
 YZwX3QPDTsC3MGs5J5CZz17Ls3UUloTnc4BzgT7meD68hs/VAnweYExq/icMXmQVy+lr
 jiXnXs4Bdy2iTBypvjrIGh+fwBCCHLqLpBckFP+KlhBV+G1Ioq6cqPfNYcd6bc+MFmoR
 o8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169260; x=1782774060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gn83dxXALMHX9hShj5DO/MP/66YGPFEzq+6xQ++j3U4=;
 b=ioAGanWBfQJVar7raoxboqC4/rCyd/+ZvbUrziiyfSqj6vDRkWpvRZONKo/KuXnIOh
 P/FipzGuTst242coj9tmbH6ifuK0ZPmgd8IM2KY1jS5tQdxh1tihgcyNiOKdwRJidM08
 c+9L14GqdAjntiu8I4wEUqCOtANwz+nyZpKTd9J6nbwkaFNRGX6HrGRR4w7H/cLLEAXa
 Qup/C93FRBtA/YHRrtpSoxyGBie7I3yepolPhhBe475p0H7alSTI8Ryspfqc9Wp1xCUP
 a0GM7Rqy8yYOxS2bfMWtIe+QoP2Mcwcd9tQ8m+BnvuFDjjQB+G/aUBvAz6Iq8gYgh2eq
 Subw==
X-Gm-Message-State: AOJu0YzIUbBLSZHeb6vLgt+9NG+yYCYU3JCXBay48z9hsuNjHFWZr/4O
 mSX2MJGVqX1/9WgNaob0/1CvDc29HxQFmcx5W90EABKRUM9sDeh2L44da6Lmb8kfYI7McligIWc
 xvigAxhDzo4r3B5SKrCvrMO0dH/EKuKEoDXsjxvnnzcfbXuxec2c7FOqObnkQXnl9Hg==
X-Gm-Gg: AfdE7cke93DW+3x3CidsFZLKg91l0D2ONcLEto+LItnHCqfZXuKHzBqvG8NmbE1ifEn
 nUpF76KYwwyPEp8OiE6hzIHTwH9TwfvN7H6rQ6beLFIjpVnLg4kvwN47cXIFP0v/OE4bPktLDzO
 /qAGnNn1rNmmWJwWj19dZ9GCXIKLeBmN2KwJH2g+Z7b+1QVUMLScawYiFtEdktDR1Fuuhcm0oS7
 kKFpj0l/LFP3frhBlhCB/ZNbhzpr+HkWerrVQPIc3XO+/BCMrogXIvNRy3T22jM1z3SbFG7pGkU
 C7/CZI82W5VXn99PAfuJhItneuQ+YFIvqQG2TztuPxacKbPAIvCxVjppTQ4Mhaw1SpxUtvIgTER
 YbNAesoY//xZzayN/i5KxRjPFG9FqOdbah1Mvp53bOaGKqBO4F6Qz0PRxVM0=
X-Received: by 2002:a05:7023:a4d:20b0:138:4023:8b6 with SMTP id
 a92af1059eb24-139a34f527cmr6789685c88.10.1782169260144; 
 Mon, 22 Jun 2026 16:01:00 -0700 (PDT)
X-Received: by 2002:a05:7023:a4d:20b0:138:4023:8b6 with SMTP id
 a92af1059eb24-139a34f527cmr6789656c88.10.1782169259400; 
 Mon, 22 Jun 2026 16:00:59 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:58 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 74/75] tests/qtest: Add hexagon boot-serial-test
Date: Mon, 22 Jun 2026 15:29:03 -0700
Message-Id: <20260622222904.607771-75-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: N1HgHNq_WKIYrRQZXNw98t8vUsdepFBW
X-Proofpoint-ORIG-GUID: N1HgHNq_WKIYrRQZXNw98t8vUsdepFBW
X-Authority-Analysis: v=2.4 cv=PuKjqQM3 c=1 sm=1 tr=0 ts=6a39bead cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=_K2MQWaM9sUw3x3I4k0A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXwhe5YxD356E/
 uXuD8KyXzmeTUYrnjJltAqYggJPMyKy8pdfGQm2EUWGZ6fG0NEllx+Q1QcyeCcV2iYMubgngOxV
 az2nslxQnb3re407WgFm0iT/6kbcng4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXx5zQUdhVqM/M
 rrgfDyUV+pznZoD/ipDsJE0Dw9oKo3aWLVz1kd99X5LrUzEKpoIEt3JamvszEmcW4V2m/+aiMMp
 sPrFHLD1SSq1W6y/TTaEKkLEBnURUsvcTh/b1eExGPh8+8hK1NgZ0bSpBiX215ioc9azNgQkC5r
 KM4nQf+zRcUcSjXSErO5qpV1sVGBWv4YfAuT71XPjoITvLqItoKORgGqJBwu7XBTi5E8nwoM104
 KDb2OoKpL7GXTBKISsS6aDuoopcnclQ0fEUtgCxwZC7r1muTIGVikEf/wt782W8kj8vHuzgcB45
 ZiXChtOfj/gEqfOIw11qvptnl4IbT/oNLzS1Lni4xnE27D4au0N8VSHd+0b9ap6wy80gboSsJTx
 BhnZZymiSdarchzNZkeDL/bwkeZN3bJkAtDKoJTHsIlSXxtu/z1s4FHMDra+NApA9LvgvSUAQrf
 uYliV4QwsD147vyQJDA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
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

QWRkIGJvb3Qtc2VyaWFsLXRlc3Qgc3VwcG9ydCBmb3IgSGV4YWdvbiBhcmNoaXRlY3R1cmUgdXNp
bmcgdGhlIHZpcnQKbWFjaGluZS4KClJldmlld2VkLWJ5OiBGYWJpYW5vIFJvc2FzIDxmYXJvc2Fz
QHN1c2UuZGU+CkFja2VkLWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFy
by5vcmc+ClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2aWVyIDxwaWVycmljay5ib3V2aWVyQG9z
cy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3Nz
LnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMgfCA4ICsr
KysrKysrCiB0ZXN0cy9xdGVzdC9tZXNvbi5idWlsZCAgICAgICAgfCAyICsrCiAyIGZpbGVzIGNo
YW5nZWQsIDEwIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90ZXN0cy9xdGVzdC9ib290LXNl
cmlhbC10ZXN0LmMgYi90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10ZXN0LmMKaW5kZXggYmNkMGE5
YzUwZTcuLjM3ZmVlN2E5MWM0IDEwMDY0NAotLS0gYS90ZXN0cy9xdGVzdC9ib290LXNlcmlhbC10
ZXN0LmMKKysrIGIvdGVzdHMvcXRlc3QvYm9vdC1zZXJpYWwtdGVzdC5jCkBAIC0xNDIsNiArMTQy
LDEzIEBAIHN0YXRpYyBjb25zdCB1aW50OF90IGtlcm5lbF9zdG0zMnZsZGlzY292ZXJ5W10gPSB7
CiAgICAgMHgwNCwgMHgzOCwgMHgwMSwgMHg0MCAgICAgICAgICAgICAgICAgIC8qIDB4NDAwMTM4
MDQgPSBVU0FSVDEgVFhEICovCiB9OwogCitzdGF0aWMgY29uc3QgdWludDhfdCBiaW9zX2hleGFn
b25bXSA9IHsKKyAgICAweDAwLCAweDQwLCAweDAwLCAweDAxLCAgICAgICAgICAgICAgICAgLyog
aW1tZXh0KCMweDEwMDAwMDAwKSAqLworICAgIDB4MDAsIDB4YzAsIDB4MDAsIDB4NzgsICAgICAg
ICAgICAgICAgICAvKiByMCA9ICMjMHgxMDAwMDAwMCAqLworICAgIDB4NTQsIDB4YzAsIDB4MDAs
IDB4M2MsICAgICAgICAgICAgICAgICAvKiBtZW1iKHIwKyMwKSA9ICMweDU0IFdyaXRlICdUJyAq
LworICAgIDB4ZjgsIDB4ZmYsIDB4ZmYsIDB4NTkgICAgICAgICAgICAgICAgICAvKiBqdW1wIDB4
MCA7IExvb3AgYmFjayB0byBzdGFydCAqLworfTsKKwogdHlwZWRlZiBzdHJ1Y3QgdGVzdGRlZiB7
CiAgICAgY29uc3QgY2hhciAqYXJjaDsgICAgICAgLyogVGFyZ2V0IGFyY2hpdGVjdHVyZSAqLwog
ICAgIGNvbnN0IGNoYXIgKm1hY2hpbmU7ICAgIC8qIE5hbWUgb2YgdGhlIG1hY2hpbmUgKi8KQEAg
LTE5NCw2ICsyMDEsNyBAQCBzdGF0aWMgY29uc3QgdGVzdGRlZl90IHRlc3RzW10gPSB7CiAgICAg
eyAiYXJtIiwgIm1pY3JvYml0IiwgIiIsICJUIiwgc2l6ZW9mKGtlcm5lbF9ucmY1MSksIGtlcm5l
bF9ucmY1MSB9LAogICAgIHsgImFybSIsICJzdG0zMnZsZGlzY292ZXJ5IiwgIiIsICJUIiwKICAg
ICAgIHNpemVvZihrZXJuZWxfc3RtMzJ2bGRpc2NvdmVyeSksIGtlcm5lbF9zdG0zMnZsZGlzY292
ZXJ5IH0sCisgICAgeyAiaGV4YWdvbiIsICJ2aXJ0IiwgIiIsICJUVCIsIHNpemVvZihiaW9zX2hl
eGFnb24pLCBOVUxMLCBiaW9zX2hleGFnb24gfSwKIAogICAgIHsgTlVMTCB9CiB9OwpkaWZmIC0t
Z2l0IGEvdGVzdHMvcXRlc3QvbWVzb24uYnVpbGQgYi90ZXN0cy9xdGVzdC9tZXNvbi5idWlsZApp
bmRleCA0ODk3MzI1ZDg0YS4uYjJkMzY0OTlkMjcgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3F0ZXN0L21l
c29uLmJ1aWxkCisrKyBiL3Rlc3RzL3F0ZXN0L21lc29uLmJ1aWxkCkBAIC0yOTUsNiArMjk1LDgg
QEAgcXRlc3RzX3Jpc2N2NjQgPSBbJ3Jpc2N2LWNzci10ZXN0J10gKyBcCiAgICBbJ2lvbW11LXJp
c2N2LXRlc3QnXSA6IFtdKSArIFwKICAgKGNvbmZpZ19hbGxfZGV2aWNlcy5oYXNfa2V5KCdDT05G
SUdfSzIzMCcpID8gWydrMjMwLXdkdC10ZXN0J10gOiBbXSkKIAorcXRlc3RzX2hleGFnb24gPSBb
J2Jvb3Qtc2VyaWFsLXRlc3QnXQorCiBxb3NfdGVzdF9zcyA9IHNzLnNvdXJjZV9zZXQoKQogcW9z
X3Rlc3Rfc3MuYWRkKAogICAnYWM5Ny10ZXN0LmMnLAotLSAKMi4zNC4xCgo=

