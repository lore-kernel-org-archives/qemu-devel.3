Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1BBCA9EC5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7V9-0003L4-UF; Mon, 12 Oct 2026 00:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UR-0001zX-Ek
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:25 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7UM-0001Bl-Km
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:18:16 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lDUd052418
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p1eQG8R1UQN6KmziUofsbekOHHCaeRUx2pGGaioH9dQ=; b=WWt+IMp662GLIYIM
 Vmprkgwx1hp9wGmrJ1Jo1nsVRgsBeRxDzS+pmBwXvOiJ2G2mcXyQzcrswR/yeW6D
 3oJ7Z/9yzHO9BDROuFkdacezKuxJAet+PnDDeJbv3Uy59VlN6o4GAxQU3kkHGwlG
 pkN84wZMVf93VmFj7fzR1REspoB6rpxlybxAJoTTEHwh9BG7/wFezleBH0934IX8
 n9TCrZ8bcCNqAcRIecaOai/u77MzIcQxTziRoFZu80Cd2vSOxUSk359INKWvhKIU
 4yMbDddD0nbZhiimJGHQys8bc3LT1VvDOSLLy3KOgkkZcmIZ7ju7mJSUAc3U4s8o
 j+RCvg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7en9vg3q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:18:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-341eff9e381so4701059eec.1
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791778683; x=1792383483; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p1eQG8R1UQN6KmziUofsbekOHHCaeRUx2pGGaioH9dQ=;
 b=brvuCxsEfN688JNrO2I+e/mfMfg+ZeH8n9UWGTDPttDZiksVSpAUAzRoftZCi0JMAJ
 oZ6FJEJkvFIBtIwkglX99ggS/mp2/fUSfxzylmh5dJ0wsJGu59Cazk4ysnjzT7UCtIGx
 IvA34g9/IGtDWjKs2FfKk2LLmiwABZAcymsHm4rPGnpE7LxKRr2k7AS7RO3Z+3EQlWCZ
 fIKIEXQyadv2WcK1/YnJp8OX6DQkSPM7cRMKpvoxAhp9tk4fm4MCK/F1PoiWiHJ9twOs
 PGSkk8d6JpQ1jnkl64Zg4gIU9dJNBlrathwnmA0M8g9tflNOcxP8ooQjlEllc8vnl09d
 00mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791778683; x=1792383483;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=p1eQG8R1UQN6KmziUofsbekOHHCaeRUx2pGGaioH9dQ=;
 b=SLdKpMBgq41tQBlf9WGMXyG0shCmNwzQH2JJDJQab8jyy8cWy6vgnWNwLV8wj8zlZd
 d25MzZyC28XgC24DflJ/v1QAMbuB47ac/Mt+nXmLHZl6PAHuQwO7J4Noq3AstWXlKijB
 f2HK2tOJJwhi7afMDFd65/7Hz8SYN9A6PLk4Uz4Pe3mhiYKXw0KgMAzD7w5bsVdSYS2x
 m9UCXpq2aSXluSdQ3QdoI6xxF1TtVskjgoAQ9vzD4PZBcpohcruRkUzXa+ENpZj5bguu
 6MZ15V+dVDpsCRfMAPt0VXn2WxcoKIBHaRsU1onLqo+zLE3h8ixom5A94M75jC0gjGkh
 0ExQ==
X-Gm-Message-State: AFq9FYJRUY1kR8h0+K3OxzxN+rLVxT0TADpmyWKyY+mqMb4bVY9VWOsd
 8SKbb0Q6uIn3DnU6VQTJHCWcplN9M4uKUIz/qQP2OvmsJNk2W9ecVFj9++Qp9miKITzLVyKs11C
 ixqK1YIvkGpXC250jq/w3eAv7uEnDbtE5GGhO2Tapyk9ZeBCyF4P6YswVm4hngTcTbA==
X-Gm-Gg: AYBFou2/8HVoHvGgzzZbElRybeQgnlVpW+fp6bK3oKGuHIUZ1UC+9Dsrxo5tbWrNric
 egFE2daZPpNVRL3NeeMEiUzAhrDodSQnY0BzveMHQaxcBcYyyTbzsmFfDE9EqxLDUVlGKaKMT6B
 E27t0lDwRv0QR/fryjpoHepDI7zfHzcThtThS2vGBLXWOZL4DrX9Tyn3fpbiyV/Y0Ilx5krD1Df
 CKpEM17WViHJGNWG6zyNPp9TjwQiwZJdrREqAwgX0m/2hWjsSO2jy09MfR0072D1cULW+ZcOQQD
 SzKxyMTQN7hwODgOtgVmrhiJBwY5dYAfgUyrwXFXX6rStjltB3OyHZ+IW22Z5vwhHj10jXUuF7d
 O9n76ousga4NK7rIWQ1f4Q/x4r76K8R8j1pKf56DFkoX6bMc=
X-Received: by 2002:a05:693c:620f:b0:33b:c24c:d31c with SMTP id
 5a478bee46e88-3537dfc7ddbmr14832781eec.7.1791778682394; 
 Sun, 11 Oct 2026 21:18:02 -0700 (PDT)
X-Received: by 2002:a05:693c:620f:b0:33b:c24c:d31c with SMTP id
 5a478bee46e88-3537dfc7ddbmr14832767eec.7.1791778681794; 
 Sun, 11 Oct 2026 21:18:01 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537c841648sm32369096eec.3.2026.10.11.21.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 21:18:00 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Marco Liebel <marco.liebel@oss.qualcomm.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 21/25] hw/hexagon: protect the shared architectural TLB
Date: Sun, 11 Oct 2026 21:17:18 -0700
Message-Id: <20261012041722.1159355-22-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
References: <20261012041722.1159355-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Woe+otfv c=1 sm=1 tr=0 ts=6acc5f7b cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=rp48sNE5vvaaZFK1b3sA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: vid7Y-nb8tDRuYORPK65C0GVPLLfrAW8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX0Gkpr92LLQbz
 otz/NksgbGxDXc+67UpFcmkRZgXOFCNcG6eJxAbKMWLrV1c/RjT8ScJyiWJOdEIHjxDL5cl6DhS
 owjn7iPsJSsrcEbscrC/XNs9F03VBmV3N6YQ6QgCkMha9eikKeLaDTagf8OSe5xycS4OGzoi8NT
 jdS79PjKtlz6WDPJqumOgu3s+i98saQASUjgre1tTgdNZzQFQG8++fQqBl03Qezm6B5VVkMvBJS
 5fS8bnWyB5CNY9ZUbpUpx0WyrwclPl7xMO/bg35XtYOCLATDFlV1oNvLqhaqb0AbNWguFj0gqc6
 2ppK3G7ICUK6cneu71a3bZiJigB2TMzV4mVD/xc5/1MF33uU7tX77G6pQV3/LQVw9gKUCrpHjPW
 aVPzhAejUtWE/1+euWR8NK3mttAPzNrhtg5jA3e3omdtp0pdhhTNdF4Dfx4OcC21/wB62vN4vps
 ji1m1zeIc/Aa8ZHzX3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxNiBTYWx0ZWRfX7KKbq6UJEHmD
 Ldex67axXboFMukcBe6owvGGA9BRR/aRVb946OvGIbA/jC9o3wOrdPaxnaQAIs4jZ/Vs17ZrL6U
 rbqSLupWCxIJxDlsd5aiuNe9UpAdxeU=
X-Proofpoint-ORIG-GUID: vid7Y-nb8tDRuYORPK65C0GVPLLfrAW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120016
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

QWRkIGEgbXV0ZXggdG8gSGV4YWdvblRMQlN0YXRlIGFuZCBob2xkIGl0IHdoaWxlIGludGVyYWN0
aW5nIHdpdGggVExCCmVudHJpZXMuCgpSZXZpZXdlZC1ieTogTWFyY28gTGllYmVsIDxtYXJjby5s
aWViZWxAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4u
Y2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGluY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3Rs
Yi5oIHwgIDUgKysrKy0KIGh3L2hleGFnb24vaGV4YWdvbl90bGIuYyAgICAgICAgIHwgMjcgKysr
KysrKysrKysrKysrKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9oZXhhZ29uL2hleGFn
b25fdGxiLmggYi9pbmNsdWRlL2h3L2hleGFnb24vaGV4YWdvbl90bGIuaAppbmRleCA2YmMzM2Mw
NTQ1Mi4uNTZhYTBiMmJlZWQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29u
X3RsYi5oCisrKyBiL2luY2x1ZGUvaHcvaGV4YWdvbi9oZXhhZ29uX3RsYi5oCkBAIC0xMyw2ICsx
Myw3IEBACiAjaW5jbHVkZSAiZXhlYy9od2FkZHIuaCIKICNpbmNsdWRlICJleGVjL21tdS1hY2Nl
c3MtdHlwZS5oIgogI2luY2x1ZGUgIm1vbml0b3IvaG1wLmgiCisjaW5jbHVkZSAicWVtdS90aHJl
YWQuaCIKIAogI2RlZmluZSBUWVBFX0hFWEFHT05fVExCICJoZXhhZ29uLXRsYiIKIE9CSkVDVF9E
RUNMQVJFX1NJTVBMRV9UWVBFKEhleGFnb25UTEJTdGF0ZSwgSEVYQUdPTl9UTEIpCkBAIC0yMiwx
MCArMjMsMTIgQEAgc3RydWN0IEhleGFnb25UTEJTdGF0ZSB7CiAKICAgICB1aW50MzJfdCBudW1f
ZW50cmllczsKICAgICB1aW50NjRfdCAqZW50cmllczsKKyAgICBRZW11TXV0ZXggbG9jazsKIH07
CiAKIHVpbnQ2NF90IGhleGFnb25fdGxiX3JlYWQoSGV4YWdvblRMQlN0YXRlICp0bGIsIHVpbnQz
Ml90IGluZGV4KTsKLXZvaWQgaGV4YWdvbl90bGJfd3JpdGUoSGV4YWdvblRMQlN0YXRlICp0bGIs
IHVpbnQzMl90IGluZGV4LCB1aW50NjRfdCB2YWx1ZSk7Cit1aW50NjRfdCBoZXhhZ29uX3RsYl93
cml0ZShIZXhhZ29uVExCU3RhdGUgKnRsYiwgdWludDMyX3QgaW5kZXgsCisgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50NjRfdCB2YWx1ZSk7CiAKIGJvb2wgaGV4YWdvbl90bGJfZmluZF9t
YXRjaChIZXhhZ29uVExCU3RhdGUgKnRsYiwgdWludDMyX3QgYXNpZCwKICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1aW50MzJfdCBWQSwgTU1VQWNjZXNzVHlwZSBhY2Nlc3NfdHlwZSwKZGlm
ZiAtLWdpdCBhL2h3L2hleGFnb24vaGV4YWdvbl90bGIuYyBiL2h3L2hleGFnb24vaGV4YWdvbl90
bGIuYwppbmRleCAxNTdkMDNlNTFiZi4uMjg2MDFiNzhhNmYgMTAwNjQ0Ci0tLSBhL2h3L2hleGFn
b24vaGV4YWdvbl90bGIuYworKysgYi9ody9oZXhhZ29uL2hleGFnb25fdGxiLmMKQEAgLTcsNiAr
Nyw3IEBACiAKICNpbmNsdWRlICJxZW11L29zZGVwLmgiCiAjaW5jbHVkZSAicWVtdS9sb2cuaCIK
KyNpbmNsdWRlICJxZW11L2xvY2thYmxlLmgiCiAjaW5jbHVkZSAiaHcvaGV4YWdvbi9oZXhhZ29u
X3RsYi5oIgogI2luY2x1ZGUgImh3L2NvcmUvcWRldi1wcm9wZXJ0aWVzLmgiCiAjaW5jbHVkZSAi
aHcvY29yZS9yZXNldHRhYmxlLmgiCkBAIC0xNjIsNiArMTYzLDcgQEAgYm9vbCBoZXhhZ29uX3Rs
Yl9kdW1wX2VudHJ5KE1vbml0b3JITVAgKmhtcCwgdWludDY0X3QgZW50cnkpCiAKIHZvaWQgaGV4
YWdvbl90bGJfZHVtcChNb25pdG9ySE1QICpobXAsIEhleGFnb25UTEJTdGF0ZSAqdGxiKQogewor
ICAgIFFFTVVfTE9DS19HVUFSRCgmdGxiLT5sb2NrKTsKICAgICBmb3IgKHVpbnQzMl90IGkgPSAw
OyBpIDwgdGxiLT5udW1fZW50cmllczsgaSsrKSB7CiAgICAgICAgIGhleGFnb25fdGxiX2R1bXBf
ZW50cnkoaG1wLCB0bGItPmVudHJpZXNbaV0pOwogICAgIH0KQEAgLTMwMywxMyArMzA1LDIwIEBA
IHN0YXRpYyBib29sIGhleF90bGJfaXNfbWF0Y2godWludDY0X3QgZW50cnkxLCB1aW50NjRfdCBl
bnRyeTIsCiB1aW50NjRfdCBoZXhhZ29uX3RsYl9yZWFkKEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1
aW50MzJfdCBpbmRleCkKIHsKICAgICBnX2Fzc2VydChpbmRleCA8IHRsYi0+bnVtX2VudHJpZXMp
OworICAgIFFFTVVfTE9DS19HVUFSRCgmdGxiLT5sb2NrKTsKICAgICByZXR1cm4gdGxiLT5lbnRy
aWVzW2luZGV4XTsKIH0KIAotdm9pZCBoZXhhZ29uX3RsYl93cml0ZShIZXhhZ29uVExCU3RhdGUg
KnRsYiwgdWludDMyX3QgaW5kZXgsIHVpbnQ2NF90IHZhbHVlKQordWludDY0X3QgaGV4YWdvbl90
bGJfd3JpdGUoSGV4YWdvblRMQlN0YXRlICp0bGIsIHVpbnQzMl90IGluZGV4LAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgdWludDY0X3QgdmFsdWUpCiB7CisgICAgdWludDY0X3Qgb2xkOwor
CiAgICAgZ19hc3NlcnQoaW5kZXggPCB0bGItPm51bV9lbnRyaWVzKTsKKyAgICBRRU1VX0xPQ0tf
R1VBUkQoJnRsYi0+bG9jayk7CisgICAgb2xkID0gdGxiLT5lbnRyaWVzW2luZGV4XTsKICAgICB0
bGItPmVudHJpZXNbaW5kZXhdID0gdmFsdWU7CisgICAgcmV0dXJuIG9sZDsKIH0KIAogYm9vbCBo
ZXhhZ29uX3RsYl9maW5kX21hdGNoKEhleGFnb25UTEJTdGF0ZSAqdGxiLCB1aW50MzJfdCBhc2lk
LApAQCAtMzIzLDYgKzMzMiw3IEBAIGJvb2wgaGV4YWdvbl90bGJfZmluZF9tYXRjaChIZXhhZ29u
VExCU3RhdGUgKnRsYiwgdWludDMyX3QgYXNpZCwKICAgICAqZXhjcCA9IDA7CiAgICAgKmNhdXNl
X2NvZGUgPSAwOwogCisgICAgUUVNVV9MT0NLX0dVQVJEKCZ0bGItPmxvY2spOwogICAgIGZvciAo
dWludDMyX3QgaSA9IDA7IGkgPCB0bGItPm51bV9lbnRyaWVzOyBpKyspIHsKICAgICAgICAgaWYg
KGhleF90bGJfZW50cnlfbWF0Y2godGxiLT5lbnRyaWVzW2ldLCBhc2lkLCBWQSwgYWNjZXNzX3R5
cGUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBBLCBwcm90LCBzaXplLCBleGNw
LCBjYXVzZV9jb2RlLCBtbXVfaWR4KSkgewpAQCAtMzQ5LDYgKzM1OSw3IEBAIHVpbnQzMl90IGhl
eGFnb25fdGxiX2xvb2t1cChIZXhhZ29uVExCU3RhdGUgKnRsYiwgdWludDMyX3QgYXNpZCwKICAg
ICB1aW50MzJfdCBub3RfZm91bmQgPSAweDgwMDAwMDAwOwogICAgIHVpbnQzMl90IGlkeCA9IG5v
dF9mb3VuZDsKIAorICAgIFFFTVVfTE9DS19HVUFSRCgmdGxiLT5sb2NrKTsKICAgICAqaW1wcmVj
aXNlX2V4Y2VwdGlvbiA9IDA7CiAgICAgZm9yICh1aW50MzJfdCBpID0gMDsgaSA8IHRsYi0+bnVt
X2VudHJpZXM7IGkrKykgewogICAgICAgICB1aW50NjRfdCBlbnRyeSA9IHRsYi0+ZW50cmllc1tp
XTsKQEAgLTM4Nyw2ICszOTgsNyBAQCBpbnQgaGV4YWdvbl90bGJfY2hlY2tfb3ZlcmxhcChIZXhh
Z29uVExCU3RhdGUgKnRsYiwgdWludDY0X3QgZW50cnksCiAgICAgaW50IG1hdGNoZXMgPSAwOwog
ICAgIGludCBsYXN0X21hdGNoID0gMDsKIAorICAgIFFFTVVfTE9DS19HVUFSRCgmdGxiLT5sb2Nr
KTsKICAgICBmb3IgKHVpbnQzMl90IGkgPSAwOyBpIDwgdGxiLT5udW1fZW50cmllczsgaSsrKSB7
CiAgICAgICAgIGlmIChoZXhfdGxiX2lzX21hdGNoKGVudHJ5LCB0bGItPmVudHJpZXNbaV0sIGZh
bHNlKSkgewogICAgICAgICAgICAgbWF0Y2hlcysrOwpAQCAtNDEyLDYgKzQyNCwxNiBAQCB1aW50
MzJfdCBoZXhhZ29uX3RsYl9nZXRfbnVtX2VudHJpZXMoSGV4YWdvblRMQlN0YXRlICp0bGIpCiAK
IHN0YXRpYyB2b2lkIGhleGFnb25fdGxiX2luaXQoT2JqZWN0ICpvYmopCiB7CisgICAgSGV4YWdv
blRMQlN0YXRlICpzID0gSEVYQUdPTl9UTEIob2JqKTsKKworICAgIHFlbXVfbXV0ZXhfaW5pdCgm
cy0+bG9jayk7Cit9CisKK3N0YXRpYyB2b2lkIGhleGFnb25fdGxiX2ZpbmFsaXplKE9iamVjdCAq
b2JqKQoreworICAgIEhleGFnb25UTEJTdGF0ZSAqcyA9IEhFWEFHT05fVExCKG9iaik7CisKKyAg
ICBxZW11X211dGV4X2Rlc3Ryb3koJnMtPmxvY2spOwogfQogCiBzdGF0aWMgdm9pZCBoZXhhZ29u
X3RsYl9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKQEAgLTQzNiw2ICs0
NTgsOCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX3RsYl91bnJlYWxpemUoRGV2aWNlU3RhdGUgKmRl
dikKIHN0YXRpYyB2b2lkIGhleGFnb25fdGxiX3Jlc2V0X2hvbGQoT2JqZWN0ICpvYmosIFJlc2V0
VHlwZSB0eXBlKQogewogICAgIEhleGFnb25UTEJTdGF0ZSAqcyA9IEhFWEFHT05fVExCKG9iaik7
CisKKyAgICBRRU1VX0xPQ0tfR1VBUkQoJnMtPmxvY2spOwogICAgIGlmIChzLT5lbnRyaWVzKSB7
CiAgICAgICAgIG1lbXNldChzLT5lbnRyaWVzLCAwLCBzaXplb2YodWludDY0X3QpICogcy0+bnVt
X2VudHJpZXMpOwogICAgIH0KQEAgLTQ3Niw2ICs1MDAsNyBAQCBzdGF0aWMgY29uc3QgVHlwZUlu
Zm8gaGV4YWdvbl90bGJfaW5mbyA9IHsKICAgICAucGFyZW50ID0gVFlQRV9TWVNfQlVTX0RFVklD
RSwKICAgICAuaW5zdGFuY2Vfc2l6ZSA9IHNpemVvZihIZXhhZ29uVExCU3RhdGUpLAogICAgIC5p
bnN0YW5jZV9pbml0ID0gaGV4YWdvbl90bGJfaW5pdCwKKyAgICAuaW5zdGFuY2VfZmluYWxpemUg
PSBoZXhhZ29uX3RsYl9maW5hbGl6ZSwKICAgICAuY2xhc3NfaW5pdCA9IGhleGFnb25fdGxiX2Ns
YXNzX2luaXQsCiB9OwogCi0tIAoyLjM0LjEKCg==

