Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15195C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 03:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbu3l-0008My-BA; Wed, 07 Aug 2024 23:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3k-0008IN-82
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3h-0006j1-Qx
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4781Mt0H020983;
 Thu, 8 Aug 2024 03:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d7CcppmNIfzsfZJMuFGWRxYFeuZ7ENq4UlYkCr03RoI=; b=Gi/Gphd68VAZ1GH6
 x1Jh7PneeG1QD0VbC3M8e7y7r/3iZBE2qS9hFqkq/kdYcYTpVMsrYjlxKf9ecQoX
 VJX9bV+cGb2aQZVrFPYrKAmVxqpWyuaX25bmfBdVuSlDMtdD/vN1rIJ9f05k+x7q
 Q3e+lyqFi+4s58liKZV+z9bGc1NmVHya69ZZhtRWTlT1ceSZAvIah5yaG+Cz4qCB
 +arDjTa0wsN65S3BLO5ihdGtEnii/t8wveOAy9P+JhEyAbUuf5GLKgzXTBP+WRmC
 qdIPtpq9CQSqFMFtQ7aX1rqIXV5CD8MKZE3m9x8VErUgkYQqPd9s0kh21v2GlNuQ
 lJJesQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40v79ja4p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Aug 2024 03:43:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4783hLTf022323
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 Aug 2024 03:43:21 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 Aug 2024 20:43:21 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 5/6] target/hexagon: define a v66 CPU
Date: Wed, 7 Aug 2024 20:42:43 -0700
Message-ID: <20240808034244.4139757-6-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808034244.4139757-1-bcain@quicinc.com>
References: <20240808034244.4139757-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-GUID: YolMbfqSDZ3RHYO_f8YqyDhS5SWTo4un
X-Proofpoint-ORIG-GUID: YolMbfqSDZ3RHYO_f8YqyDhS5SWTo4un
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_03,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 mlxlogscore=882
 suspectscore=0 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408080024
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
b2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxp
cHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFRheWxv
ciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24v
Y3B1LXFvbS5oIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgfCAyICsrCiAyIGZpbGVz
IGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2Nw
dS1xb20uaCBiL3RhcmdldC9oZXhhZ29uL2NwdS1xb20uaAppbmRleCBkYTkyZmU3NDY4Li4wYjE0
OWJkNWZlIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUtcW9tLmgKKysrIGIvdGFyZ2V0
L2hleGFnb24vY3B1LXFvbS5oCkBAIC0xNiw2ICsxNiw3IEBACiAjZGVmaW5lIEhFWEFHT05fQ1BV
X1RZUEVfU1VGRklYICItIiBUWVBFX0hFWEFHT05fQ1BVCiAjZGVmaW5lIEhFWEFHT05fQ1BVX1RZ
UEVfTkFNRShuYW1lKSAobmFtZSBIRVhBR09OX0NQVV9UWVBFX1NVRkZJWCkKIAorI2RlZmluZSBU
WVBFX0hFWEFHT05fQ1BVX1Y2NiBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY2NiIpCiAjZGVmaW5l
IFRZUEVfSEVYQUdPTl9DUFVfVjY3IEhFWEFHT05fQ1BVX1RZUEVfTkFNRSgidjY3IikKICNkZWZp
bmUgVFlQRV9IRVhBR09OX0NQVV9WNjggSEVYQUdPTl9DUFVfVFlQRV9OQU1FKCJ2NjgiKQogI2Rl
ZmluZSBUWVBFX0hFWEFHT05fQ1BVX1Y2OSBIRVhBR09OX0NQVV9UWVBFX05BTUUoInY2OSIpCmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmlu
ZGV4IDY0Y2MwNWNjYTcuLjg1ZjFlOTdkOGYgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2Nw
dS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBAIC0yNiw2ICsyNiw3IEBACiAjaW5jbHVk
ZSAidGNnL3RjZy5oIgogI2luY2x1ZGUgImV4ZWMvZ2Ric3R1Yi5oIgogCitzdGF0aWMgdm9pZCBo
ZXhhZ29uX3Y2Nl9jcHVfaW5pdChPYmplY3QgKm9iaikgeyB9CiBzdGF0aWMgdm9pZCBoZXhhZ29u
X3Y2N19jcHVfaW5pdChPYmplY3QgKm9iaikgeyB9CiBzdGF0aWMgdm9pZCBoZXhhZ29uX3Y2OF9j
cHVfaW5pdChPYmplY3QgKm9iaikgeyB9CiBzdGF0aWMgdm9pZCBoZXhhZ29uX3Y2OV9jcHVfaW5p
dChPYmplY3QgKm9iaikgeyB9CkBAIC0zNzMsNiArMzc0LDcgQEAgc3RhdGljIGNvbnN0IFR5cGVJ
bmZvIGhleGFnb25fY3B1X3R5cGVfaW5mb3NbXSA9IHsKICAgICAgICAgLmNsYXNzX3NpemUgPSBz
aXplb2YoSGV4YWdvbkNQVUNsYXNzKSwKICAgICAgICAgLmNsYXNzX2luaXQgPSBoZXhhZ29uX2Nw
dV9jbGFzc19pbml0LAogICAgIH0sCisgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y2
NiwgICAgICAgICAgICAgIGhleGFnb25fdjY2X2NwdV9pbml0KSwKICAgICBERUZJTkVfQ1BVKFRZ
UEVfSEVYQUdPTl9DUFVfVjY3LCAgICAgICAgICAgICAgaGV4YWdvbl92NjdfY3B1X2luaXQpLAog
ICAgIERFRklORV9DUFUoVFlQRV9IRVhBR09OX0NQVV9WNjgsICAgICAgICAgICAgICBoZXhhZ29u
X3Y2OF9jcHVfaW5pdCksCiAgICAgREVGSU5FX0NQVShUWVBFX0hFWEFHT05fQ1BVX1Y2OSwgICAg
ICAgICAgICAgIGhleGFnb25fdjY5X2NwdV9pbml0KSwKLS0gCjIuMzQuMQoK

