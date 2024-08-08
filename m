Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20856C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 03:44:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbu3o-00009k-GD; Wed, 07 Aug 2024 23:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3l-0008Lq-2D
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3j-0006iz-B3
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477HjPF7007134;
 Thu, 8 Aug 2024 03:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ORAMsEchR23D3+A9t1VDq5EnVcz0SXycD2Y41v1aqDM=; b=m8cMnGO/FMTeiEia
 7K5USdDLify7IUa8dMYUs/HT14+TRR3QQ2e5wPy/k5YYjGcqeIpwew0mibs1RkK3
 M8V9mZ/i6xJW8+9VBMYKFmSDEBQcxBauMfcEoIY+mDSWBUFIor9sDi3e9oK1LwI+
 3yywh3yIFt5uECQh5K3evTr+1YS/Az6k2d5GUif5InG/CRbz5YEyiggIhZtLHH1e
 8fITjphIMtpjSh+xaUbXRRhErWQO8MO6i3Yf/EnUXDDnKV3GeeTN95Jwe0zapwQ+
 9P6Fpf320l8yIUSOtuov8QTobPKCdgnTpJmyhHiANMH149uVDi5gX6e6H1JQObGE
 bGtTpA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scx6vq09-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Aug 2024 03:43:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4783hLOf027843
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 Aug 2024 03:43:22 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 Aug 2024 20:43:21 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 6/6] target/hexagon: switch to dc set_props() list
Date: Wed, 7 Aug 2024 20:42:44 -0700
Message-ID: <20240808034244.4139757-7-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: yzv8QH_07ntrC3BpIZW3l6QxJANxDXXE
X-Proofpoint-GUID: yzv8QH_07ntrC3BpIZW3l6QxJANxDXXE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_03,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=997 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080024
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

RGVmaW5lIGEgaGV4YWdvbl9jcHVfcHJvcGVydGllcyBsaXN0IHRvIG1hdGNoIHRoZSBpZGlvbSB1
c2VkCmJ5IG90aGVyIHRhcmdldHMuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBx
dWljaW5jLmNvbT4KUmV2aWV3ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpIDxwaGlsbWRA
bGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBn
bWFpbC5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vY3B1LmMgfCAxOCArKysrKysrKy0tLS0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5k
ZXggODVmMWU5N2Q4Zi4uMDIwMDM4ZmM0OSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1
LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTQ4LDEzICs0OCwxMyBAQCBzdGF0aWMg
T2JqZWN0Q2xhc3MgKmhleGFnb25fY3B1X2NsYXNzX2J5X25hbWUoY29uc3QgY2hhciAqY3B1X21v
ZGVsKQogICAgIHJldHVybiBvYzsKIH0KIAotc3RhdGljIFByb3BlcnR5IGhleGFnb25fbGxkYl9j
b21wYXRfcHJvcGVydHkgPQotICAgIERFRklORV9QUk9QX0JPT0woImxsZGItY29tcGF0IiwgSGV4
YWdvbkNQVSwgbGxkYl9jb21wYXQsIGZhbHNlKTsKLXN0YXRpYyBQcm9wZXJ0eSBoZXhhZ29uX2xs
ZGJfc3RhY2tfYWRqdXN0X3Byb3BlcnR5ID0KLSAgICBERUZJTkVfUFJPUF9VTlNJR05FRCgibGxk
Yi1zdGFjay1hZGp1c3QiLCBIZXhhZ29uQ1BVLCBsbGRiX3N0YWNrX2FkanVzdCwKLSAgICAgICAg
ICAgICAgICAgICAgICAgICAwLCBxZGV2X3Byb3BfdWludDMyLCB0YXJnZXRfdWxvbmcpOwotc3Rh
dGljIFByb3BlcnR5IGhleGFnb25fc2hvcnRfY2lyY3VpdF9wcm9wZXJ0eSA9Ci0gICAgREVGSU5F
X1BST1BfQk9PTCgic2hvcnQtY2lyY3VpdCIsIEhleGFnb25DUFUsIHNob3J0X2NpcmN1aXQsIHRy
dWUpOworc3RhdGljIFByb3BlcnR5IGhleGFnb25fY3B1X3Byb3BlcnRpZXNbXSA9IHsKKyAgICBE
RUZJTkVfUFJPUF9CT09MKCJsbGRiLWNvbXBhdCIsIEhleGFnb25DUFUsIGxsZGJfY29tcGF0LCBm
YWxzZSksCisgICAgREVGSU5FX1BST1BfVU5TSUdORUQoImxsZGItc3RhY2stYWRqdXN0IiwgSGV4
YWdvbkNQVSwgbGxkYl9zdGFja19hZGp1c3QsIDAsCisgICAgICAgICAgICAgICAgICAgICAgICAg
cWRldl9wcm9wX3VpbnQzMiwgdGFyZ2V0X3Vsb25nKSwKKyAgICBERUZJTkVfUFJPUF9CT09MKCJz
aG9ydC1jaXJjdWl0IiwgSGV4YWdvbkNQVSwgc2hvcnRfY2lyY3VpdCwgdHJ1ZSksCisgICAgREVG
SU5FX1BST1BfRU5EX09GX0xJU1QoKQorfTsKIAogY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25f
cmVnbmFtZXNbVE9UQUxfUEVSX1RIUkVBRF9SRUdTXSA9IHsKICAgICJyMCIsICJyMSIsICAicjIi
LCAgInIzIiwgICJyNCIsICAgInI1IiwgICJyNiIsICAicjciLApAQCAtMzE3LDkgKzMxNyw2IEBA
IHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3Ig
KiplcnJwKQogCiBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9pbml0KE9iamVjdCAqb2JqKQogewot
ICAgIHFkZXZfcHJvcGVydHlfYWRkX3N0YXRpYyhERVZJQ0Uob2JqKSwgJmhleGFnb25fbGxkYl9j
b21wYXRfcHJvcGVydHkpOwotICAgIHFkZXZfcHJvcGVydHlfYWRkX3N0YXRpYyhERVZJQ0Uob2Jq
KSwgJmhleGFnb25fbGxkYl9zdGFja19hZGp1c3RfcHJvcGVydHkpOwotICAgIHFkZXZfcHJvcGVy
dHlfYWRkX3N0YXRpYyhERVZJQ0Uob2JqKSwgJmhleGFnb25fc2hvcnRfY2lyY3VpdF9wcm9wZXJ0
eSk7CiB9CiAKICNpbmNsdWRlICJody9jb3JlL3RjZy1jcHUtb3BzLmgiCkBAIC0zNDAsNiArMzM3
LDcgQEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfY2xhc3NfaW5pdChPYmplY3RDbGFzcyAqYywg
dm9pZCAqZGF0YSkKICAgICBkZXZpY2VfY2xhc3Nfc2V0X3BhcmVudF9yZWFsaXplKGRjLCBoZXhh
Z29uX2NwdV9yZWFsaXplLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm1j
Yy0+cGFyZW50X3JlYWxpemUpOwogCisgICAgZGV2aWNlX2NsYXNzX3NldF9wcm9wcyhkYywgaGV4
YWdvbl9jcHVfcHJvcGVydGllcyk7CiAgICAgcmVzZXR0YWJsZV9jbGFzc19zZXRfcGFyZW50X3Bo
YXNlcyhyYywgTlVMTCwgaGV4YWdvbl9jcHVfcmVzZXRfaG9sZCwgTlVMTCwKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZtY2MtPnBhcmVudF9waGFzZXMpOwogCi0tIAoy
LjM0LjEKCg==

