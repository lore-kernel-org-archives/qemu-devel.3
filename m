Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F50C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJi-0000bu-J4; Sun, 05 May 2024 22:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJd-0000XQ-Tw
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJc-0007Xf-3b
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:57 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4462InMf002623;
 Mon, 6 May 2024 02:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=aTmAnKpXy1Wr3odV6Gn1byt9s7SYzojb+hl1o143h64=; b=KP
 oD3Nf9rBEcpbje7WiXJR9vAI1gIMzDVUEhGxm/YNT17hOnIlNgGf+Cg1Vzq2Yyjr
 sET8aJxXkC2cZFwf/DSPOrf1jte5SP5G6W55kYIySnmBbzkSuc0vI5LRvQOfOIYD
 v08phYR43Ywnf+jGz6Y4OPdtzbL5W9lVMXtQO9Kee5PfHoMShL8QUDkswCk+nVbD
 J+shfSRsuHYbVLrcfqGtOeoDDbU4uUoKg52qQYIevj16u/3AzpRqArvcNTb1OPx2
 2xGFdn4L85hnd4K0Y3okfchu1d1I7l8Blrd/SHCjs3u2L0bNAEbtuNIwJPgftPbs
 pkmMJSxQZoSgvX18bu0Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwead2ckk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 02:42:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4462gpuc028569
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 6 May 2024 02:42:51 GMT
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
Subject: [PULL 11/15] Hexagon (tests/tcg/hexagon) Test HVX .new read from high
 half of pair
Date: Sun, 5 May 2024 19:42:23 -0700
Message-ID: <20240506024227.3345791-12-bcain@quicinc.com>
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
X-Proofpoint-GUID: vwHlOHUuRaYURqCJ5DrYej66pgQFsiN2
X-Proofpoint-ORIG-GUID: vwHlOHUuRaYURqCJ5DrYej66pgQFsiN2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 mlxlogscore=691 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060012
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCk1ha2Ugc3Vy
ZSB0aGUgZGVjb2Rpbmcgb2YgSFZYIC5uZXcgaXMgY29ycmVjdGx5IGhhbmRsaW5nIHRoaXMgY2Fz
ZQoKU2lnbmVkLW9mZi1ieTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNv
bT4KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPgpNZXNzYWdlLUlk
OiA8MjAyNDAzMDcwMzIzMjcuNDc5OS02LWx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVk
LW9mZi1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Ci0tLQogdGVzdHMvdGNnL2hl
eGFnb24vaHZ4X21pc2MuYyB8IDE2ICsrKysrKysrKysrKysrKy0KIDEgZmlsZSBjaGFuZ2VkLCAx
NSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGVzdHMvdGNnL2hl
eGFnb24vaHZ4X21pc2MuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMKaW5kZXggYjQ1
MTcwYWNkMS4uMWZlMTRiNTE1OCAxMDA2NDQKLS0tIGEvdGVzdHMvdGNnL2hleGFnb24vaHZ4X21p
c2MuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9odnhfbWlzYy5jCkBAIC0xLDUgKzEsNSBAQAog
LyoKLSAqICBDb3B5cmlnaHQoYykgMjAyMS0yMDIzIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVy
LCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisgKiAgQ29weXJpZ2h0KGMpIDIwMjEtMjAyNCBR
dWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgogICoK
ICAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUg
aXQgYW5kL29yIG1vZGlmeQogICogIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVy
YWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5CkBAIC0yMzEsNiArMjMxLDcgQEAgc3Rh
dGljIHZvaWQgdGVzdF9tYXNrZWRfc3RvcmUoYm9vbCBpbnZlcnQpCiBzdGF0aWMgdm9pZCB0ZXN0
X25ld192YWx1ZV9zdG9yZSh2b2lkKQogewogICAgIHZvaWQgKnAwID0gYnVmZmVyMDsKKyAgICB2
b2lkICpwMSA9IGJ1ZmZlcjE7CiAgICAgdm9pZCAqcG91dCA9IG91dHB1dDsKIAogICAgIGFzbSgi
e1xuXHQiCkBAIC0yNDIsNiArMjQzLDE5IEBAIHN0YXRpYyB2b2lkIHRlc3RfbmV3X3ZhbHVlX3N0
b3JlKHZvaWQpCiAgICAgZXhwZWN0WzBdID0gYnVmZmVyMFswXTsKIAogICAgIGNoZWNrX291dHB1
dF93KF9fTElORV9fLCAxKTsKKworICAgIC8qIFRlc3QgdGhlIC5uZXcgcmVhZCBmcm9tIHRoZSBo
aWdoIGhhbGYgb2YgYSBwYWlyICovCisgICAgYXNtKCJ2NyA9IHZtZW0oJTAgKyAjMClcblx0Igor
ICAgICAgICAidjEyID0gdm1lbSglMSArICMwKVxuXHQiCisgICAgICAgICJ7XG5cdCIKKyAgICAg
ICAgIiAgICB2NTo0ID0gdmNvbWJpbmUodjEyLCB2Nylcblx0IgorICAgICAgICAiICAgIHZtZW0o
JTIgKyAjMCkgPSB2NS5uZXdcblx0IgorICAgICAgICAifVxuXHQiCisgICAgICAgIDogOiAiciIo
cDApLCAiciIocDEpLCAiciIocG91dCkgOiAidjQiLCAidjUiLCAidjciLCAidjEyIiwgIm1lbW9y
eSIpOworCisgICAgZXhwZWN0WzBdID0gYnVmZmVyMVswXTsKKworICAgIGNoZWNrX291dHB1dF93
KF9fTElORV9fLCAxKTsKIH0KIAogc3RhdGljIHZvaWQgdGVzdF9tYXhfdGVtcHMoKQotLSAKMi4y
NS4xCgo=

