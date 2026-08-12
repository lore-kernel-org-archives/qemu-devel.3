Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDAAC5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:46:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuB7O-0005Ia-0D; Wed, 12 Aug 2026 11:43:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB72-0004mT-1f
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:28 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wuB70-0000MZ-FM
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 11:43:27 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CDbckQ3641666
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l/TPmb71nhtmwh1BntVvFun3sm2MPM4sfZPk8QztV8w=; b=aosC7/V4Tqqs1rB/
 I9pxYr61N9Xs4224XAsuNbBSHI9R338cF6JyaHI53aiyqsC2UrisPdd1VImupxdF
 PjuTFizygFVdRyLmasRlm/OBa6HGJx4DdK9dqwIWQ3JnwcEPMtLNpLGG/usOeUcG
 k8HUp2ivrjq5keuwSmzhRaN3ZakJgxhc/Jv24/DYvEQ8HLhz9Jjo88A6Y0k3JNlb
 y0DYOYiOxWqp4j5x8hc7Aat2p3SvVTpxGgKKRrNO/UgvATnmMOa1Z3rZ5F64rex2
 4hnjY9HWa8MrQUBEXAuMwXPqm67F+deXncw/t0mqVPKEW6ywiknenBg+m7BQFjJV
 RYRkEg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g0p3d1p4t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:43:14 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cbb6433e9d4so1345652a12.3
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 08:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786549393; x=1787154193; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l/TPmb71nhtmwh1BntVvFun3sm2MPM4sfZPk8QztV8w=;
 b=QIexrsV2yPAQnY8dp3iijiD3J3A+44b57IKIWot/cSIBcGLNi1RysQs6QmExvfKdN+
 n+5AVciTDUIjuLa4ZKRQLGUoedUazusjETvKUHcH4X04hpcGr8JrH8eGHAekG5wDTYb1
 N8ENqk/R58dMYYUs27GlYUyCqHF+0hiHrAdQtf+5GeOnpZ/Ct4Z9f5PUMKvkjh563K4U
 Fa16vCaeIKcWFAlZw4eCLi0ONxn50KzKxcpP0VlVbXbxXUpZPooyELFDaTmM2py1ZFZA
 shZIKThqUHfmp+oX/YvCuIwzauHIik8RppwscN2mmeG+TSYk6iKUFx/+Ze6JYJ23lueV
 8L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549393; x=1787154193;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/TPmb71nhtmwh1BntVvFun3sm2MPM4sfZPk8QztV8w=;
 b=mpNZqGpzmATZifxtMouPrUMUiCixD5lqKP6giAAM4xsCcwsFeWvMEcDcYNrf2buYNl
 /HD6QUFw3teZNGCfRqE4ITM7wyd7RJ5JwIp/qhONwTbaa7RnJZabBQsGW8miCGrh5OjL
 TjcoJiZsJARp63JKJsPIyM/+quFTp96vpql/gDdw0pONM1NfqUbOsv1HzKD4TLfWHaZa
 P+5NXQhCeAASl0gjsywSvw3OSetZFShcfOrNQcEYzL7O8FgPgq7IvoQlww+zN4exLPX+
 TsiRcVd3jWg3mMwGdQfhyg5Ibii/B4mgy+RzKZp2rarBErFPptmCuwHMN/FokP212j4k
 HSgA==
X-Gm-Message-State: AOJu0YyZha1j7gCRFCi9DLGWZlnuPOqKTl+Zn97F7Mq0socAAL8wVDPx
 qkfPU7nM2W61/Y2elkXDBCJKkXOnF1TtLpIx0L3FKwb9xNaz+C1nujbci+hIAnF1aQX1XWvvmXR
 Y2tY20U6n5+KiwijCax4dCIKw7kfcgV2lEPQep84EEST42Q1vYOX8i/V1viMzXcGwpg==
X-Gm-Gg: AR+sD11F7HufJ9ldsTmIar7b7oQf7pku9KAQIShbWMGBeovJDICt29DgvNfqDvQxzec
 u8r3Hvhe/pB/L9OdV22+lCjT/Lhrtt65vTJGn2bTnmGCN44QTV4idYd81dgcuhf5zINl/1xPn38
 qU4fQpmWkrSh5WW5Jr78yRrkKE0QNE2QExFXe0OZB5wvXqkCSHiFk34EuI6TwDe6weLd6pZOWeZ
 1zlcak/ZUVzI18lH6Yu/JDChyN+2T7DG9fnRig3YAXS84wH5zY39lJbrAZH5FgCmf0Q/MVvw+/q
 9SfYEF8TMkLIfb5vx0vrfSn+42sv57ii6zw2AKlkXA9x2fttyIvHypPGXwEGYhBkjS4pCmt8dn9
 sh7mtMiF28hNEs4MHgWy70Cy5QqtEroiP6BAxzatoymfozx6c
X-Received: by 2002:a05:6a20:a11b:b0:3bf:77d7:667d with SMTP id
 adf61e73a8af0-3cc3f790676mr6022597637.28.1786549393315; 
 Wed, 12 Aug 2026 08:43:13 -0700 (PDT)
X-Received: by 2002:a05:6a20:a11b:b0:3bf:77d7:667d with SMTP id
 adf61e73a8af0-3cc3f790676mr6022535637.28.1786549392846; 
 Wed, 12 Aug 2026 08:43:12 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31da7bf64b5sm8121190eec.10.2026.08.12.08.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 08:43:12 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 24/41] tests/tcg/hexagon: add HVX test for V6_vsubwsat
 saturation
Date: Wed, 12 Aug 2026 08:42:03 -0700
Message-Id: <20260812154220.1029828-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
References: <20260812154220.1029828-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: pZv-fqkdYlqHXkQfOilGKRjRQofUmTBv
X-Proofpoint-GUID: pZv-fqkdYlqHXkQfOilGKRjRQofUmTBv
X-Authority-Analysis: v=2.4 cv=UfNhjqSN c=1 sm=1 tr=0 ts=6a7c9492 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KziaR8soUeEz0EukW7EA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfX1THlupBI1d1t
 V5F7MbazSDDowBhJ98gvZ754F5HDjzXc1TYEuy74FYP7E2Iq/yVXMuLVRqz6l1wowpYKLa7bmOY
 xDfyK3nGPVJIqDIQKQKPdvY8m4WMQWHb+FNk+MZhEW153wCTBcMzUC+H7NM6Vye6jQ60iS443ss
 E0K8ao5BOVDWIWvBCtzfUQS4mWGjuAya7ukWDkFTi9+RwolAjCpMA+aTLTM33E7TxVsPNzfTqDV
 E3mNI63bo8wYLihRPKTB5W0oeQHpvNDqFj52nHp6SrXNDzqZ1AgUby3tpl28Hna6JA+k8Wsc2L4
 44ZPksODIwL+96IOgne70yZAvrWtltlxG+yDo4f67iILpQr7dqe8OxYePPrbkfMRgWfxdGz2AJy
 nBK+IXL0vQq5HPQ7sQsrX+0aeKGpkzutMizOl8iTJ2NR08WDRhPOwzO2FCxZMbBLOWDP3MiTj9z
 CeyLRHEY8YFcUbx94pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEyOCBTYWx0ZWRfXwI7bO8t7VLbB
 H9303B4ay8j1qHhCyc6FTUsZQ07L9clgKYCj6wXTd5RyEJQoWknSUquTjbUWuUAaCJfn6pBQpFV
 C7w6xomVIrhRZjDsm4QjhuYlHYj+1ow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120128
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

UmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxj
b21tLmNvbT4KTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvcWVtdS1kZXZlbC8yMDI2MDgw
NzE1MjI0MS4xNTc2MzM0LTctYnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tClNpZ25lZC1vZmYt
Ynk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90
Y2cvaGV4YWdvbi9odnhfbWlzYy5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNDQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rl
c3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgYi90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5j
CmluZGV4IDkwYzM3MzNkYTA3Li42NDFjZmY1OWFiYSAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hl
eGFnb24vaHZ4X21pc2MuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCkBAIC0y
MCw2ICsyMCw4IEBACiAjaW5jbHVkZSA8c3RkYm9vbC5oPgogI2luY2x1ZGUgPHN0cmluZy5oPgog
I2luY2x1ZGUgPGxpbWl0cy5oPgorI2luY2x1ZGUgPGhleGFnb25fdHlwZXMuaD4KKyNpbmNsdWRl
IDxodnhfaGV4YWdvbl9wcm90b3MuaD4KIAogaW50IGVycjsKIApAQCAtMzg2LDYgKzM4OCw0NyBA
QCBzdGF0aWMgdm9pZCB0ZXN0X3ZzdWJ1d3NhdF9kdih2b2lkKQogICAgIGNoZWNrX291dHB1dF93
KF9fTElORV9fLCAyKTsKIH0KIAorc3RhdGljIHZvaWQgdGVzdF92c3Vid3NhdCh2b2lkKQorewor
ICAgIGNvbnN0IGludDMyX3QgeDAgPSBJTlQzMl9NSU47CisgICAgY29uc3QgaW50MzJfdCB5MCA9
IDE7CisgICAgY29uc3QgaW50MzJfdCB4MSA9IElOVDMyX01BWDsKKyAgICBjb25zdCBpbnQzMl90
IHkxID0gLTE7CisgICAgSFZYX1ZlY3RvciB2MDsKKyAgICBIVlhfVmVjdG9yIHYxOworICAgIEhW
WF9WZWN0b3IgdnJlczsKKworICAgIC8qIElOVDMyX01JTiAtIDEgdW5kZXJmbG93cyBhbmQgbXVz
dCBzYXR1cmF0ZSB0byBJTlQzMl9NSU4gKi8KKyAgICBtZW1zZXQoZXhwZWN0LCAweDEyLCBzaXpl
b2YoTU1WZWN0b3IpKTsKKyAgICBtZW1zZXQob3V0cHV0LCAweDM0LCBzaXplb2YoTU1WZWN0b3Ip
KTsKKworICAgIHYwID0gUTZfVl92c3BsYXRfUih4MCk7CisgICAgdjEgPSBRNl9WX3ZzcGxhdF9S
KHkwKTsKKyAgICB2cmVzID0gUTZfVndfdnN1Yl9Wd1Z3X3NhdCh2MCwgdjEpOworICAgIG1lbWNw
eSgmb3V0cHV0WzBdLCAmdnJlcywgc2l6ZW9mKE1NVmVjdG9yKSk7CisKKyAgICBmb3IgKGludCBq
ID0gMDsgaiA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDQ7IGorKykgeworICAgICAgICBleHBlY3Rb
MF0ud1tqXSA9IElOVDMyX01JTjsKKyAgICB9CisKKyAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVf
XywgMSk7CisKKyAgICAvKiBJTlQzMl9NQVggLSAoLTEpIG92ZXJmbG93cyBhbmQgbXVzdCBzYXR1
cmF0ZSB0byBJTlQzMl9NQVggKi8KKyAgICBtZW1zZXQoZXhwZWN0LCAweDEyLCBzaXplb2YoTU1W
ZWN0b3IpKTsKKyAgICBtZW1zZXQob3V0cHV0LCAweDM0LCBzaXplb2YoTU1WZWN0b3IpKTsKKwor
ICAgIHYwID0gUTZfVl92c3BsYXRfUih4MSk7CisgICAgdjEgPSBRNl9WX3ZzcGxhdF9SKHkxKTsK
KyAgICB2cmVzID0gUTZfVndfdnN1Yl9Wd1Z3X3NhdCh2MCwgdjEpOworICAgIG1lbWNweSgmb3V0
cHV0WzBdLCAmdnJlcywgc2l6ZW9mKE1NVmVjdG9yKSk7CisKKyAgICBmb3IgKGludCBqID0gMDsg
aiA8IE1BWF9WRUNfU0laRV9CWVRFUyAvIDQ7IGorKykgeworICAgICAgICBleHBlY3RbMF0ud1tq
XSA9IElOVDMyX01BWDsKKyAgICB9CisKKyAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMSk7
Cit9CisKIHN0YXRpYyB2b2lkIHRlc3RfbG9hZF90bXBfcHJlZGljYXRlZCh2b2lkKQogewogICAg
IHZvaWQgKnAwID0gYnVmZmVyMDsKQEAgLTUzMCw2ICs1NzMsNyBAQCBpbnQgbWFpbigpCiAKICAg
ICB0ZXN0X3ZhZGR1d3NhdCgpOwogICAgIHRlc3RfdnN1YnV3c2F0X2R2KCk7CisgICAgdGVzdF92
c3Vid3NhdCgpOwogCiAgICAgdGVzdF9sb2FkX3RtcF9wcmVkaWNhdGVkKCk7CiAgICAgdGVzdF9s
b2FkX2N1cl9wcmVkaWNhdGVkKCk7Ci0tIAoyLjM0LjEKCg==

