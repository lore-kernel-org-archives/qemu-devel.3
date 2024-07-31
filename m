Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98EACC3DA49
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:11:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYxrV-0001Bc-NI; Tue, 30 Jul 2024 21:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sYxrR-0001AA-Ct
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:10:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sYxrO-0002f4-P3
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:10:36 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46V19Uog028742;
 Wed, 31 Jul 2024 01:10:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=M1lb1++QhY94awzbcvb2kE
 4oPcF9uB/pudthl7L/LiE=; b=n99jQchoJWfQs8KmeIw4DBTUV/72T43vgSVAZh
 rjVpzcffX6rMWgzMPNBXs/GrIrjMjdMACNZq0NEDlQNly5qKLLrn2Jmc7s5U7q2a
 iDN+zgpi8XX2BqGRtkvPzSIcSOOS0SxZB4dviuB6QfVBS0jwKFzIF+cgPB0MSi0M
 zUWW43bHN+4e2JUS5wXEtQt4TTMdqDZ80NWBkNtg5l96iuSyg7vb2uSukVrCE6QY
 k45UcDsdDgENeUrR/jN1L/SJdbdzi6NZhb6/aXMTK1auPk6rhTCwLeRvww7ZkAQO
 n64fLsuG+gFv+qeqET+d2Voj9BvSNV0OtchOULfxM/hkr/Xw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40q232sph3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 01:10:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 46V1A9vq022130
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 01:10:09 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Jul 2024 18:10:08 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PATCH] target/hexagon: define a v66 CPU
Date: Tue, 30 Jul 2024 18:09:54 -0700
Message-ID: <20240731010954.1959253-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: esnl2YZ-RLKyWcH4m84M_y5GIJL4PUB_
X-Proofpoint-ORIG-GUID: esnl2YZ-RLKyWcH4m84M_y5GIJL4PUB_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_21,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 spamscore=0 adultscore=0
 mlxscore=0 mlxlogscore=870 clxscore=1011 suspectscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407310007
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
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

Rm9yIG5vdywgdjY2IGJlaGF2aW9yIGlzIHRoZSBzYW1lIGFzIG90aGVyIENQVXMuCgpTaWduZWQt
b2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdv
bi9jcHUtcW9tLmggfCAxICsKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8IDIgKysKIDIgZmls
ZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
Y3B1LXFvbS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LXFvbS5oCmluZGV4IGRhOTJmZTc0NjguLjBi
MTQ5YmQ1ZmUgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaAorKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUtcW9tLmgKQEAgLTE2LDYgKzE2LDcgQEAKICNkZWZpbmUgSEVYQUdPTl9D
UFVfVFlQRV9TVUZGSVggIi0iIFRZUEVfSEVYQUdPTl9DUFUKICNkZWZpbmUgSEVYQUdPTl9DUFVf
VFlQRV9OQU1FKG5hbWUpIChuYW1lIEhFWEFHT05fQ1BVX1RZUEVfU1VGRklYKQogCisjZGVmaW5l
IFRZUEVfSEVYQUdPTl9DUFVfVjY2IEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjY2IikKICNkZWZp
bmUgVFlQRV9IRVhBR09OX0NQVV9WNjcgSEVYQUdPTl9DUFVfVFlQRV9OQU1FKCJ2NjciKQogI2Rl
ZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y2OCBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY2OCIpCiAj
ZGVmaW5lIFRZUEVfSEVYQUdPTl9DUFVfVjY5IEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjY5IikK
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMK
aW5kZXggNjRjYzA1Y2NhNy4uODVmMWU5N2Q4ZiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24v
Y3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTI2LDYgKzI2LDcgQEAKICNpbmNs
dWRlICJ0Y2cvdGNnLmgiCiAjaW5jbHVkZSAiZXhlYy9nZGJzdHViLmgiCiAKK3N0YXRpYyB2b2lk
IGhleGFnb25fdjY2X2NwdV9pbml0KE9iamVjdCAqb2JqKSB7IH0KIHN0YXRpYyB2b2lkIGhleGFn
b25fdjY3X2NwdV9pbml0KE9iamVjdCAqb2JqKSB7IH0KIHN0YXRpYyB2b2lkIGhleGFnb25fdjY4
X2NwdV9pbml0KE9iamVjdCAqb2JqKSB7IH0KIHN0YXRpYyB2b2lkIGhleGFnb25fdjY5X2NwdV9p
bml0KE9iamVjdCAqb2JqKSB7IH0KQEAgLTM3Myw2ICszNzQsNyBAQCBzdGF0aWMgY29uc3QgVHlw
ZUluZm8gaGV4YWdvbl9jcHVfdHlwZV9pbmZvc1tdID0gewogICAgICAgICAuY2xhc3Nfc2l6ZSA9
IHNpemVvZihIZXhhZ29uQ1BVQ2xhc3MpLAogICAgICAgICAuY2xhc3NfaW5pdCA9IGhleGFnb25f
Y3B1X2NsYXNzX2luaXQsCiAgICAgfSwKKyAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVf
VjY2LCAgICAgICAgICAgICAgaGV4YWdvbl92NjZfY3B1X2luaXQpLAogICAgIERFRklORV9DUFUo
VFlQRV9IRVhBR09OX0NQVV9WNjcsICAgICAgICAgICAgICBoZXhhZ29uX3Y2N19jcHVfaW5pdCks
CiAgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y2OCwgICAgICAgICAgICAgIGhleGFn
b25fdjY4X2NwdV9pbml0KSwKICAgICBERUZJTkVfQ1BVKFRZUEVfSEVYQUdPTl9DUFVfVjY5LCAg
ICAgICAgICAgICAgaGV4YWdvbl92NjlfY3B1X2luaXQpLAotLSAKMi4zNC4xCgo=

