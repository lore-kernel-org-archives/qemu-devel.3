Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10D6C25B76
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 00:58:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG6sI-0007mY-3Y; Sat, 08 Jun 2024 20:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sF-0007ku-Ro
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sC-0003tS-9T
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:29 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4590q2ie004598;
 Sun, 9 Jun 2024 00:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +0YPOUqiirDtqhXzuFbMUEhgklj+jc6YmWswnge7u5c=; b=oDVyLw34veD6LmfJ
 LNGfq/ADVG+IcXRDxpdRHOAX8tSWZIEEJHOvMIerWwG+F1azj95GLB/GXkIA/BHJ
 763uVdChl1MqWrdZTZ0zgKKPWHTRoqkLRgHLYoz+tqXroP44pOqfUmY40gqxnOJH
 mgWefRzYF4UcQ6B0pxjuHBSqtCucMNBDJcLe6eq8QPJq7PFY8dic07KB5pNmRwND
 uEIi+jRo94Y5KI0OZgo5yVAsaE/Cq5yVdPxifbJ7gOc+eBnx6I6ZokVCs7oYgxcO
 yjJGqwDk0gobG9cyn3l+gZTQLwZ5s2KUZcy9yUyabuE5LNkqy3O89jkN4iq1SiyX
 WH4Gqg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymea6h5t9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 00:57:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4590vKaY005416
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 9 Jun 2024 00:57:20 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 8 Jun 2024 17:57:20 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 1/6] Hexagon: fix HVX store new
Date: Sat, 8 Jun 2024 17:57:00 -0700
Message-ID: <20240609005705.2809037-2-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609005705.2809037-1-bcain@quicinc.com>
References: <20240609005705.2809037-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: YwqtFjq7zpbtDvQkf8fXZdmmhllx8dTi
X-Proofpoint-ORIG-GUID: YwqtFjq7zpbtDvQkf8fXZdmmhllx8dTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 malwarescore=0 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406090006
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
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
b20+CgpBdCAwOWE3ZTdkYjBmIChIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgUmVtb3ZlIHVzZXMg
b2YKb3BfcmVnc19nZW5lcmF0ZWQuaC5pbmMsIDIwMjQtMDMtMDYpLCB3ZSd2ZSBjaGFuZ2VkIHRo
ZSBsb2dpYyBvZgpjaGVja19uZXdfdmFsdWUoKSB0byB1c2UgdGhlIG5ldyBwcmUtY2FsY3VsYXRl
ZApwYWNrZXQtPmluc25bLi4uXS5kZXN0X2lkeCBpbnN0ZWFkIG9mIGNhbGN1bGF0aW5nIHRoZSBp
bmRleCBvbiB0aGUgZmx5CnVzaW5nIG9wY29kZV9yZWdpbmZvWy4uLl0uIFRoZSBkZXN0X2lkeCBp
bmRleCBpcyBjYWxjdWxhdGVkIHJvdWdobHkgbGlrZQp0aGUgZm9sbG93aW5nOgoKICAgIGZvciBy
ZWcgaW4gaXNldFt0YWddWyJzeW50YXgiXToKICAgICAgICBpZiByZWcuaXNfd3JpdHRlbigpOgog
ICAgICAgICAgICBkZXN0X2lkeCA9IHJlZ25vCiAgICAgICAgICAgIGJyZWFrCgpUaHVzLCB3ZSB0
YWtlIHRoZSBmaXJzdCByZWdpc3RlciB0aGF0IGlzIHdyaXR0YWJsZS4gQmVmb3JlIHRoYXQsCmhv
d2V2ZXIsIHdlIGFsc28gdXNlZCB0byBmb2xsb3cgYW4gYWxwaGFiZXRpY2FsIG9yZGVyIG9uIHRo
ZSByZWdpc3Rlcgp0eXBlOiAnZCcsICdlJywgJ3gnLCBhbmQgJ3knLiBObyBsb25nZXIgZm9sbG93
aW5nIHRoYXQgbWFrZXMgdXMgc2VsZWN0CnRoZSB3cm9uZyByZWdpc3RlciBpbmRleCBhbmQgdGhl
IEhWWCBzdG9yZSBuZXcgaW5zdHJ1Y3Rpb24gZG9lcyBub3QKdXBkYXRlIHRoZSBtZW1vcnkgbGlr
ZSBleHBlY3RlZC4KClNpZ25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxx
dWljX21hdGhiZXJuQHF1aWNpbmMuY29tPgpSZXZpZXdlZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5A
cXVpY2luYy5jb20+ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25A
Z21haWwuY29tPgpNZXNzYWdlLUlkOiA8ZjU0OGRjMWMyNDA4MTljNzI0MjQ1ZTg4N2YyOWY5MTg0
NDFlOTEyNS4xNzE2MjIwMzc5LmdpdC5xdWljX21hdGhiZXJuQHF1aWNpbmMuY29tPgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdv
bi9nZW5fdHJhbnNfZnVuY3MucHkgfCAgOSArKysrKystLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2
eF9taXNjLmMgICAgICB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrCiAyIGZpbGVzIGNoYW5n
ZWQsIDI5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5IGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1
bmNzLnB5CmluZGV4IDlmODZiNGVkYmQuLjMwZjBjNzNlMGMgMTAwNzU1Ci0tLSBhL3RhcmdldC9o
ZXhhZ29uL2dlbl90cmFuc19mdW5jcy5weQorKysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNf
ZnVuY3MucHkKQEAgLTg5LDYgKzg5LDcgQEAgZGVmIGdlbl90cmFuc19mdW5jcyhmKToKIAogICAg
ICAgICBuZXdfcmVhZF9pZHggPSAtMQogICAgICAgICBkZXN0X2lkeCA9IC0xCisgICAgICAgIGRl
c3RfaWR4X3JlZ19pZCA9IE5vbmUKICAgICAgICAgaGFzX3ByZWRfZGVzdCA9ICJmYWxzZSIKICAg
ICAgICAgZm9yIHJlZ25vLCAocmVnX3R5cGUsIHJlZ19pZCwgKl8pIGluIGVudW1lcmF0ZShyZWdz
KToKICAgICAgICAgICAgIHJlZyA9IGhleF9jb21tb24uZ2V0X3JlZ2lzdGVyKHRhZywgcmVnX3R5
cGUsIHJlZ19pZCkKQEAgLTk3LDkgKzk4LDExIEBAIGRlZiBnZW5fdHJhbnNfZnVuY3MoZik6CiAg
ICAgICAgICAgICAiIiIpKQogICAgICAgICAgICAgaWYgcmVnLmlzX3JlYWQoKSBhbmQgcmVnLmlz
X25ldygpOgogICAgICAgICAgICAgICAgIG5ld19yZWFkX2lkeCA9IHJlZ25vCi0gICAgICAgICAg
ICAjIGRlc3RfaWR4IHNob3VsZCBiZSB0aGUgZmlyc3QgZGVzdGluYXRpb24sIHNvIGNoZWNrIGZv
ciAtMQotICAgICAgICAgICAgaWYgcmVnLmlzX3dyaXR0ZW4oKSBhbmQgZGVzdF9pZHggPT0gLTE6
Ci0gICAgICAgICAgICAgICAgZGVzdF9pZHggPSByZWdubworICAgICAgICAgICAgaWYgcmVnLmlz
X3dyaXR0ZW4oKToKKyAgICAgICAgICAgICAgICAjIGRlc3RfaWR4IHNob3VsZCBiZSB0aGUgZmly
c3QgZGVzdGluYXRpb24gYWxwaGFiZXRpY2FsbHkKKyAgICAgICAgICAgICAgICBpZiBkZXN0X2lk
eF9yZWdfaWQgaXMgTm9uZSBvciByZWdfaWQgPCBkZXN0X2lkeF9yZWdfaWQ6CisgICAgICAgICAg
ICAgICAgICAgIGRlc3RfaWR4ID0gcmVnbm8KKyAgICAgICAgICAgICAgICAgICAgZGVzdF9pZHhf
cmVnX2lkID0gcmVnX2lkCiAgICAgICAgICAgICBpZiByZWdfdHlwZSA9PSAiUCIgYW5kIHJlZy5p
c193cml0dGVuKCkgYW5kIG5vdCByZWcuaXNfcmVhZCgpOgogICAgICAgICAgICAgICAgIGhhc19w
cmVkX2Rlc3QgPSAidHJ1ZSIKIApkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21p
c2MuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKaW5kZXggMWZlMTRiNTE1OC4uOTBj
MzczM2RhMCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21pc2MuYworKysgYi90
ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCkBAIC00NzQsNiArNDc0LDI3IEBAIHN0YXRpYyB2
b2lkIHRlc3RfdmNvbWJpbmUodm9pZCkKICAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgQlVG
U0laRSk7CiB9CiAKK3ZvaWQgdGVzdF9zdG9yZV9uZXcoKQoreworICAgIGFzbSB2b2xhdGlsZSgK
KyAgICAgICAgInIwID0gIzB4MTIzNDU2NzhcbiIKKyAgICAgICAgInYwID0gdnNwbGF0KHIwKVxu
IgorICAgICAgICAicjAgPSAjMHhmZjAwZmYwMFxuIgorICAgICAgICAidjEgPSB2c3BsYXQocjAp
XG4iCisgICAgICAgICJ7XG4iCisgICAgICAgICIgICB2ZGVhbCh2MSx2MCxyMClcbiIKKyAgICAg
ICAgIiAgIHZtZW0oJTApID0gdjAubmV3XG4iCisgICAgICAgICJ9XG4iCisgICAgICAgIDoKKyAg
ICAgICAgOiAiciIoJm91dHB1dFswXSkKKyAgICAgICAgOiAicjAiLCAidjAiLCAidjEiLCAibWVt
b3J5IgorICAgICk7CisgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBNQVhfVkVDX1NJWkVfQllURVMg
LyA0OyBpKyspIHsKKyAgICAgICAgZXhwZWN0WzBdLndbaV0gPSAweDEyMzQ1Njc4OworICAgIH0K
KyAgICBjaGVja19vdXRwdXRfdyhfX0xJTkVfXywgMSk7Cit9CisKIGludCBtYWluKCkKIHsKICAg
ICBpbml0X2J1ZmZlcnMoKTsKQEAgLTUxNSw2ICs1MzYsOCBAQCBpbnQgbWFpbigpCiAKICAgICB0
ZXN0X3Zjb21iaW5lKCk7CiAKKyAgICB0ZXN0X3N0b3JlX25ldygpOworCiAgICAgcHV0cyhlcnIg
PyAiRkFJTCIgOiAiUEFTUyIpOwogICAgIHJldHVybiBlcnIgPyAxIDogMDsKIH0KLS0gCjIuMjUu
MQoK

