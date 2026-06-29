Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A4BC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:49:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIk-0005RO-TK; Mon, 29 Jun 2026 09:45:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHb-0003h3-Jk
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:21 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHZ-0006GL-Q4
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:19 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAT3WT2646904
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=; b=W64DWmPjggNktFHZ
 1TCuQ41jEo6VtQdLozAVfK6lVh/J9U+B5VeSODqAoUY8Dwvx9lU0U0l22OyPNBzH
 CUtVhXO0YSvPMQx665nmzBVROqyG2OeVvSwTxRiMbKYm3P5ioz1WzyFcN/GwfT/k
 xg+l5HKvGuufbObhXMv74ErOxPLrPZg46WaSSZJ5yMPNHoWkZenmGKXf26Sav3Ei
 3I50cYtKJyIkqO6m1+JMkLYDJAM8etLv5MOFdOGD/Ev3xrFpM4lQ7XzSz5vpNUM4
 12JcPVglqrXrfqWW5cpX8igGMkCmLvJERon0mmaHpLVkCg41qr6TV6EbCnZ4qaAZ
 vmkI6A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3m4tshga-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-37d4eede8ccso1950285a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740646; x=1783345446; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=;
 b=gvVwXjgs/fpsJS7fQX7sdEcaukdT6vvhf/rFG7OztPUhpD2VJqTJOCO2P13/l2gsmU
 hrxNRq7AZyCBmz8V7qAfxnMW8hnlLUR55ESmbhdLw/3jwK5Dj9dILGp3NFlz9hoy/tkc
 NuxEol1bylJ/0D2VB/oTgZouEZea+K4gP41CwHhRZL7WDuIODASUIYhIXHf2uXnUvOGH
 1/J5NfT4mColVwEXumcCd9RcFHVfIK9EGykt2AvjY0dPPTlmEDkmwmcaMIAi8htRyFFY
 +UAJMDlRNOh2QXRiTHuWdkSwWNOrI9FRrM0RJo9OOVitm32M0mI1G+EKcRb4CWAJN87+
 Bnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740646; x=1783345446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=;
 b=TgupBHRcFVMfn4fxwRNGsSgXHX1NHkivb+rK+6VrIZkzSj7eIz7nrXF0o3kpdWIdIL
 54ww0JjH3vakSsrrdhhKTzspl+9J4OZbQHQ8i+4/S/p7SjweGNb0HCIq9V+hhk3M0jBZ
 UrOLKHjJ5Qs/3QvFkLTrMHjfJ+k8p6LM8Ov4jJ5ywTOg+bmI8eKC5d9mLarPVGlhilKs
 vG4y69iQT3z+Bo9xznsng8lK01lCIN6RTiGtabrphnoafCvc72O6EBy5xZmTTXpPg/KC
 bytgi7TNbHrXThaB6VUff3poZR5LD3rVtdpBUGYCfdbhhEfFgWg/POkZaVOm0yhHB8l7
 TrWA==
X-Gm-Message-State: AOJu0YyKnTf9GVwR+exEnWs8QRN7SCfdYJVHVnluwbK5ADI6eAvBA9CU
 kcyvs0jEHVOHOg9iBnYUlbwN215oX716m8Fkc1PWb+pGZ0uno9e52/xb2tsv1MU5D/2lFKadPrt
 a3u0Iyu9FD4tTJjOmD3xJGXM8A23DQz6+gnRCFtqDo9VHbtHFAWC1BgPtmY+CB6dnzg==
X-Gm-Gg: AfdE7cnMCNZ0AltUKopQUReXdn3kGxSXynzj6JWCCNfdcGbD203rMXGFPhKA6zTlj72
 oK/ONzuFMI7mrSTvn2la7Rg4fUHGJdOqoSQ0QjnhjVPjWg8jv86utLdaJtf6zW+i7MRYEqFwvZ3
 waEdJN88sWbl1xjXd8My593Nsa8eVVpIaOHObwEDJkIiaWoeLcLXeA+gau1teKp4B6P8KR4MQiU
 zkXyK0Sa9MZDMtWsi4dmMTZyZpkHIscdr1I4COrQ4FzINP6v5qibbr51i2l4AttSaXNO+0ktXg3
 OYR3dINk6z+pbRyhwn2XUOxnZ1BR1P9gvSDIxalYLCyJ063IQmQTRjmeZ6LjvEciZjmMgw8Sc/b
 bsNnS0cYx8yrh56X4mpMw9ElQ/0Acfv9P1k9VilIb1eHj0jOicDk5d1luFFs=
X-Received: by 2002:a17:902:fc44:b0:2c9:b480:f5d0 with SMTP id
 d9443c01a7336-2c9b480f7c2mr73118555ad.39.1782740645633; 
 Mon, 29 Jun 2026 06:44:05 -0700 (PDT)
X-Received: by 2002:a17:902:fc44:b0:2c9:b480:f5d0 with SMTP id
 d9443c01a7336-2c9b480f7c2mr73118295ad.39.1782740645148; 
 Mon, 29 Jun 2026 06:44:05 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:04 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 55/77] target/hexagon: Implement setprio, resched
Date: Mon, 29 Jun 2026 06:12:10 -0700
Message-Id: <20260629131232.2487780-56-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX5gjCmYCkR2YC
 Sv19w4H1UBkdyGKV5EQES0K6brGhYtGS83c6yuXWhaiIPwCjtrQ8NmoGhwiQFipm/ilck9ABesD
 5Z4lvhLFOXpIBN71rjVj36euxOwzhWO/inhkdVzCQ3GlZucIeEjUEE9TteDNAh9Tsn7/M90baXn
 AsEFf+++sm2fkVvdbq50v1JyStDQEFP2gtVfz8aX2DowkUSqiSKYSoYHv7A1onhGd0WYzUjQpKg
 MBeli2/Zo5efvdnBCozw4eDXbCkS26HmsrjI9FZKktkEQ33SY9oezbxYf784QPAM9jWyCZbyIcQ
 LMOxqoVV4U41vGkdvTaUl+uWFcXHFuNB72+b9yuXQpLJaPcWFr0wE+7CoqwBB3ioGGNKv4vSOJg
 RwsFgcce3BEDyhsWwdaGHiuo696A5oHKxamswRuRDdrU3jyt2dtC9GAWsh6ismmidYEAPFv0HUd
 dEfLf6aBukuT4hPS0oQ==
X-Authority-Analysis: v=2.4 cv=R58z39RX c=1 sm=1 tr=0 ts=6a4276a6 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9hY_xzidxOicKg_qOOkA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX/nQIRyvcOSkm
 uztTBMQV7GhEJRA3zuCGPnj4ieuP0e4UsmMFoLTChRTvw1VxIdHkq+BYRRr20/FZDT0AAPSX+sS
 xOVNVEIgh5xuyV6WvTRMQzYREX2vr4k=
X-Proofpoint-ORIG-GUID: yDfJZLRlNkbFyb0YeLBzbgrbD5jkB1y3
X-Proofpoint-GUID: yDfJZLRlNkbFyb0YeLBzbgrbD5jkB1y3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 adultscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgaGFyZHdhcmUtYXNzaXN0
ZWQgc2NoZWR1bGVyIGhlbHBzIG1hbmFnZSB0YXNrcyBvbiB0aGUgcnVuIHF1ZXVlCmFuZCBpbnRl
cnJ1cHQgc3RlZXJpbmcuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
fCA3NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDc3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDM0YzU1YjU2MGNhLi4zYzI1
M2IzOTFlNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE1OTAsNiArMTU5MCw2NCBAQCBzdGF0aWMgdm9p
ZCBoZXhhZ29uX3dhaXRfdGhyZWFkKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykK
ICAgICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOwogfQogCitzdGF0aWMg
aW5saW5lIFFFTVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpCit7CisgICAgdWludDMyX3Qgc2NoZWRjZmc7CisgICAgdWludDMyX3Qgc2NoZWRjZmdfZW47
CisgICAgaW50IGludF9udW1iZXI7CisgICAgQ1BVU3RhdGUgKmNzOworICAgIHVpbnQzMl90IGxv
d2VzdF90aF9wcmlvID0gMDsgLyogMCBpcyBoaWdoZXN0IHByaW8gKi8KKyAgICB1aW50MzJfdCBi
ZXN0d2FpdF9yZWc7CisgICAgdWludDMyX3QgYmVzdF9wcmlvOworICAgIEhleGFnb25DUFUgKmNw
dTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lO
VCwgIiVzOiBjaGVjayByZXNjaGVkXG4iLCBfX2Z1bmNfXyk7CisgICAgY3B1ID0gZW52X2FyY2hj
cHUoZW52KTsKKyAgICBzY2hlZGNmZyA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAgICAgIGhleGFn
b25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19TQ0hFRENGRywKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7CisgICAgc2No
ZWRjZmdfZW4gPSBHRVRfRklFTEQoU0NIRURDRkdfRU4sIHNjaGVkY2ZnKTsKKyAgICBpbnRfbnVt
YmVyID0gR0VUX0ZJRUxEKFNDSEVEQ0ZHX0lOVE5PLCBzY2hlZGNmZyk7CisKKyAgICBpZiAoIXNj
aGVkY2ZnX2VuKSB7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICBDUFVfRk9SRUFDSChj
cykgeworICAgICAgICBIZXhhZ29uQ1BVICp0aHJlYWQgPSBIRVhBR09OX0NQVShjcyk7CisgICAg
ICAgIENQVUhleGFnb25TdGF0ZSAqdGhyZWFkX2VudiA9ICYodGhyZWFkLT5lbnYpOworICAgICAg
ICB1aW50MzJfdCB0aF9wcmlvID0gR0VUX0ZJRUxEKAorICAgICAgICAgICAgU1RJRF9QUklPLCB0
aHJlYWRfZW52LT50X3NyZWdbSEVYX1NSRUdfU1RJRF0pOworICAgICAgICBpZiAoIWhleGFnb25f
dGhyZWFkX2lzX2VuYWJsZWQodGhyZWFkX2VudikpIHsKKyAgICAgICAgICAgIGNvbnRpbnVlOwor
ICAgICAgICB9CisKKyAgICAgICAgbG93ZXN0X3RoX3ByaW8gPSAobG93ZXN0X3RoX3ByaW8gPiB0
aF9wcmlvKQorICAgICAgICAgICAgPyBsb3dlc3RfdGhfcHJpbworICAgICAgICAgICAgOiB0aF9w
cmlvOworICAgIH0KKworICAgIGJlc3R3YWl0X3JlZyA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19CRVNU
V0FJVCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7
CisgICAgYmVzdF9wcmlvID0gR0VUX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIGJlc3R3YWl0X3JlZyk7
CisKKyAgICAvKgorICAgICAqIElmIHRoZSBsb3dlc3QgcHJpb3JpdHkgdGhyZWFkIGlzIGxvd2Vy
IHByaW9yaXR5IHRoYW4gdGhlCisgICAgICogdmFsdWUgaW4gdGhlIEJFU1RXQUlUIHJlZ2lzdGVy
LCB3ZSBtdXN0IHJhaXNlIHRoZSByZXNjaGVkdWxlCisgICAgICogaW50ZXJydXB0IG9uIHRoZSBs
b3dlc3QgcHJpb3JpdHkgdGhyZWFkLgorICAgICAqLworICAgIGlmIChsb3dlc3RfdGhfcHJpbyA+
IGJlc3RfcHJpbykgeworICAgICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULAorICAgICAg
ICAgICAgICAgICIlczogcmFpc2luZyByZXNjaGVkIGludCAldSwiCisgICAgICAgICAgICAgICAg
IiBjdXIgUEMgMHglIiBQUkl4MzIgIlxuIiwKKyAgICAgICAgICAgICAgICBfX2Z1bmNfXywgKHVu
c2lnbmVkKWludF9udW1iZXIsIGVudi0+Z3ByW0hFWF9SRUdfUENdKTsKKyAgICAgICAgU0VUX1NZ
U1RFTV9GSUVMRChlbnYsIEhFWF9TUkVHX0JFU1RXQUlULCBCRVNUV0FJVF9QUklPLCB+MCk7Cisg
ICAgICAgIGhleF9yYWlzZV9pbnRlcnJ1cHRzKGVudiwgMSA8PCBpbnRfbnVtYmVyLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CisgICAgfQorfQorCiB2b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgUEMpCiB7CiAgICAgQlFMX0xPQ0tfR1VBUkQoKTsKQEAgLTE2OTgs
OCArMTc1NiwyNyBAQCB1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25T
dGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0K
IAorLyoKKyAqIHNldHByaW8vcmVzY2hlZCAtIGhhcmR3YXJlLWFzc2lzdGVkIHNjaGVkdWxlciBo
ZWxwZXJzIGZvciBtYW5hZ2luZworICogdGhlIHJ1biBxdWV1ZSBhbmQgaW50ZXJydXB0IHN0ZWVy
aW5nLgorICovCiB2b2lkIEhFTFBFUihzZXRwcmlvKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgdGhyZWFkLCB1aW50MzJfdCBwcmlvKQogeworICAgIENQVVN0YXRlICpjczsKKworICAg
IEJRTF9MT0NLX0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgSGV4YWdv
bkNQVSAqZm91bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgICAgICBDUFVIZXhhZ29uU3Rh
dGUgKmZvdW5kX2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAgICAgICAgaWYgKHRocmVhZCA9PSBm
b3VuZF9lbnYtPnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5k
X2VudiwgSEVYX1NSRUdfU1RJRCwgU1RJRF9QUklPLCBwcmlvKTsKKyAgICAgICAgICAgIHFlbXVf
bG9nX21hc2soQ1BVX0xPR19JTlQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICIlczogdGlk
ICUiIFBSSXUzMiAiIHByaW8gPSAweCUiIFBSSXgzMiAiXG4iLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICBfX2Z1bmNfXywgZm91bmRfZW52LT50aHJlYWRJZCwgcHJpbyk7CisgICAgICAgICAg
ICByZXNjaGVkKGVudik7CisgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0KKyAgICB9CiAg
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0KIAotLSAKMi4zNC4xCgo=

