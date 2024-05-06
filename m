Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1715C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:45:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJh-0000ab-BD; Sun, 05 May 2024 22:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJc-0000Wm-Ux
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJZ-0007XF-Va
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:56 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4462Wgos017193;
 Mon, 6 May 2024 02:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=faydbKHf9aQLFGjdnppLq3gka3YfCxOyTWGC2H2pLeY=; b=j4
 dkk9y29NE/31PHzf7rehtqHA9WZ2P9l0vQw3PI8CRrYzmO8RK0ltP5/hKn46YpTj
 x2w3QpT2jz+63vkTDaM1b/PXAAWkFn4Hl0Quoxt9fUAPAUugFXxF3RoWXdeIaeIs
 tjLo3CTIvloYQxf+bAhOYRZDe03WVMjrX+M3z3cmWUqwEvS5+xehJNE9qMQx+koM
 BD7J/aqjtM8nAEPJOBrEnOOEjS0/78KZYgLPKuaCsmKSwvrJ8aLIXKLOERJndIa7
 LSOCCbU1sOdeG7tWW3haha/AUrQM9hwrBFWrVLF4MAGk62P5TyFuTIY+Aox08/zr
 10VYTIYUwRi5eIyvm1Xg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwc1c2gy9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 02:42:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4462goVe004660
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 6 May 2024 02:42:50 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 5 May 2024 19:42:50 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 10/15] Hexagon (target/hexagon) Mark has_pred_dest in trans
 functions
Date: Sun, 5 May 2024 19:42:22 -0700
Message-ID: <20240506024227.3345791-11-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240506024227.3345791-1-bcain@quicinc.com>
References: <20240506024227.3345791-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: 5cXLAp97aLDfEBductsWZZRhmnbxypb6
X-Proofpoint-ORIG-GUID: 5cXLAp97aLDfEBductsWZZRhmnbxypb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=861 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060012
Received-SPF: pass client-ip=205.220.180.131; envelope-from=bcain@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkNoZWNrIHRo
YXQgdGhlIHZhbHVlIG1hdGNoZXMgb3Bjb2RlX3dyZWdzCgpTaWduZWQtb2ZmLWJ5OiBUYXlsb3Ig
U2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdlZC1ieTogQnJpYW4gQ2Fp
biA8YmNhaW5AcXVpY2luYy5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDI0MDMwNzAzMjMyNy40Nzk5LTUt
bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2Fp
bkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyAgICAgICAgICAgfCAz
ICsrKwogdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5IHwgNSArKysrKwogdGFyZ2V0
L2hleGFnb24vaW5zbi5oICAgICAgICAgICAgIHwgMSArCiAzIGZpbGVzIGNoYW5nZWQsIDkgaW5z
ZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jIGIvdGFyZ2V0
L2hleGFnb24vZGVjb2RlLmMKaW5kZXggYTRkODUwMGZlYS4uODRhMzg5OTU1NiAxMDA2NDQKLS0t
IGEvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vZGVjb2RlLmMK
QEAgLTM2Niw2ICszNjYsOSBAQCBzdGF0aWMgdm9pZCBkZWNvZGVfc2h1ZmZsZV9mb3JfZXhlY3V0
aW9uKFBhY2tldCAqcGFja2V0KQogICAgICAgICBmb3IgKGZsYWcgPSBmYWxzZSwgaSA9IDA7IGkg
PCBsYXN0X2luc24gKyAxOyBpKyspIHsKICAgICAgICAgICAgIGludCBvcGNvZGUgPSBwYWNrZXQt
Pmluc25baV0ub3Bjb2RlOwogCisgICAgICAgICAgICBnX2Fzc2VydChwYWNrZXQtPmluc25baV0u
aGFzX3ByZWRfZGVzdCA9PQorICAgICAgICAgICAgICAgICAgICAgKHN0cnN0cihvcGNvZGVfd3Jl
Z3Nbb3Bjb2RlXSwgIlBkNCIpIHx8CisgICAgICAgICAgICAgICAgICAgICAgc3Ryc3RyKG9wY29k
ZV93cmVnc1tvcGNvZGVdLCAiUGU0IikpKTsKICAgICAgICAgICAgIGlmICgoc3Ryc3RyKG9wY29k
ZV93cmVnc1tvcGNvZGVdLCAiUGQ0IikgfHwKICAgICAgICAgICAgICAgICAgc3Ryc3RyKG9wY29k
ZV93cmVnc1tvcGNvZGVdLCAiUGU0IikpICYmCiAgICAgICAgICAgICAgICAgR0VUX0FUVFJJQihv
cGNvZGUsIEFfU1RPUkUpID09IDApIHsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90
cmFuc19mdW5jcy5weSBiL3RhcmdldC9oZXhhZ29uL2dlbl90cmFuc19mdW5jcy5weQppbmRleCAx
MjAxMTcyZGRhLi45Zjg2YjRlZGJkIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5fdHJh
bnNfZnVuY3MucHkKKysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5CkBAIC03
MCw2ICs3MCw3IEBAIGRlZiBtYXJrX3doaWNoX2ltbV9leHRlbmRlZChmLCB0YWcpOgogIyMgICAg
ICAgICBpbnNuLT5yZWdub1syXSA9IGFyZ3MtPlJ0OwogIyMgICAgICAgICBpbnNuLT5uZXdfcmVh
ZF9pZHggPSAtMTsKICMjICAgICAgICAgaW5zbi0+ZGVzdF9pZHggPSAwOworIyMgICAgICAgICBp
bnNuLT5oYXNfcHJlZF9kZXN0ID0gZmFsc2U7CiAjIyAgICAgICAgIHJldHVybiB0cnVlOwogIyMg
ICAgIH0KICMjCkBAIC04OCw2ICs4OSw3IEBAIGRlZiBnZW5fdHJhbnNfZnVuY3MoZik6CiAKICAg
ICAgICAgbmV3X3JlYWRfaWR4ID0gLTEKICAgICAgICAgZGVzdF9pZHggPSAtMQorICAgICAgICBo
YXNfcHJlZF9kZXN0ID0gImZhbHNlIgogICAgICAgICBmb3IgcmVnbm8sIChyZWdfdHlwZSwgcmVn
X2lkLCAqXykgaW4gZW51bWVyYXRlKHJlZ3MpOgogICAgICAgICAgICAgcmVnID0gaGV4X2NvbW1v
bi5nZXRfcmVnaXN0ZXIodGFnLCByZWdfdHlwZSwgcmVnX2lkKQogICAgICAgICAgICAgZi53cml0
ZShjb2RlX2ZtdChmIiIiXApAQCAtOTgsNiArMTAwLDggQEAgZGVmIGdlbl90cmFuc19mdW5jcyhm
KToKICAgICAgICAgICAgICMgZGVzdF9pZHggc2hvdWxkIGJlIHRoZSBmaXJzdCBkZXN0aW5hdGlv
biwgc28gY2hlY2sgZm9yIC0xCiAgICAgICAgICAgICBpZiByZWcuaXNfd3JpdHRlbigpIGFuZCBk
ZXN0X2lkeCA9PSAtMToKICAgICAgICAgICAgICAgICBkZXN0X2lkeCA9IHJlZ25vCisgICAgICAg
ICAgICBpZiByZWdfdHlwZSA9PSAiUCIgYW5kIHJlZy5pc193cml0dGVuKCkgYW5kIG5vdCByZWcu
aXNfcmVhZCgpOgorICAgICAgICAgICAgICAgIGhhc19wcmVkX2Rlc3QgPSAidHJ1ZSIKIAogICAg
ICAgICBpZiBsZW4oaW1tcykgIT0gMDoKICAgICAgICAgICAgIG1hcmtfd2hpY2hfaW1tX2V4dGVu
ZGVkKGYsIHRhZykKQEAgLTEyMSw2ICsxMjUsNyBAQCBkZWYgZ2VuX3RyYW5zX2Z1bmNzKGYpOgog
ICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCiAgICAgICAgICAgICBpbnNuLT5uZXdfcmVh
ZF9pZHggPSB7bmV3X3JlYWRfaWR4fTsKICAgICAgICAgICAgIGluc24tPmRlc3RfaWR4ID0ge2Rl
c3RfaWR4fTsKKyAgICAgICAgICAgIGluc24tPmhhc19wcmVkX2Rlc3QgPSB7aGFzX3ByZWRfZGVz
dH07CiAgICAgICAgICIiIikpCiAgICAgICAgIGYud3JpdGUodGV4dHdyYXAuZGVkZW50KGYiIiJc
CiAgICAgICAgICAgICAgICAgcmV0dXJuIHRydWU7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9pbnNuLmggYi90YXJnZXQvaGV4YWdvbi9pbnNuLmgKaW5kZXggYTc3MDM3OTk1OC4uMjRkY2Y3
ZmU5ZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vaW5zbi5oCisrKyBiL3RhcmdldC9oZXhh
Z29uL2luc24uaApAQCAtNDEsNiArNDEsNyBAQCBzdHJ1Y3QgSW5zdHJ1Y3Rpb24gewogICAgIHVp
bnQzMl90IG5ld192YWx1ZV9wcm9kdWNlcl9zbG90OjQ7CiAgICAgaW50MzJfdCBuZXdfcmVhZF9p
ZHg7CiAgICAgaW50MzJfdCBkZXN0X2lkeDsKKyAgICBib29sIGhhc19wcmVkX2Rlc3Q7CiAKICAg
ICBib29sIHBhcnQxOyAgICAgICAgICAgICAgLyoKICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICogY21wLWp1bXBzIGFyZSBzcGxpdCBpbnRvIHR3byBpbnNucy4KLS0gCjIuMjUuMQoK

