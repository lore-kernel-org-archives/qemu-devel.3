Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3636C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:43:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJg-0000ZL-2F; Sun, 05 May 2024 22:43:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJb-0000Up-UJ
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJY-0007Wx-RM
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:55 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4461wgA5003497;
 Mon, 6 May 2024 02:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=KryhH6uCdG/vHyLQi21gMTCplESIqqdxn/91VfBq1us=; b=Mn
 4EuQCKIqRa7vPiGGsOfNGPDhGjJ9JMjOfsy5SvAfpiJGFw97r5aoBT9avOPDYz6J
 O+91VpmksYbWc26byWuM5M9WFU1mcMHWLmff8HCKq5cfrnTA+yeNGWwH0HtNEKV0
 Dwwwh0/M8wJj9YoxHNLZX/cSL2xlCPvo8jcvc0EkPilhPG6nQXPR48AJiZORIGEW
 4haHT4Wow0ve8zvM0WQlUzEq/V3y+kA/5zPmpwyBi37RXFSMGPTSV5Awf/pcADnB
 NwsZcErK43hW/1GVm+RLKhAuYUhIKVgrLSNq0XwqYwf1UNutRVGcr990VQ4BlDy9
 rDuCR00s1MfVP7r/T0lA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwcm4jgby-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 02:42:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4462gnU5007709
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 6 May 2024 02:42:49 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 5 May 2024 19:42:49 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 07/15] Hexagon (target/hexagon) Add is_old/is_new to Register
 class
Date: Sun, 5 May 2024 19:42:19 -0700
Message-ID: <20240506024227.3345791-8-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: lnOLCRTW3b4pSVf7Foe0imI3sa8d6qFP
X-Proofpoint-GUID: lnOLCRTW3b4pSVf7Foe0imI3sa8d6qFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=619 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClNpZ25lZC1v
ZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2Vk
LWJ5OiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQGxpbmFyby5vcmc+ClJldmlld2Vk
LWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KTWVzc2FnZS1JZDogPDIwMjQwMzA3
MDMyMzI3LjQ3OTktMi1sdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hleF9jb21t
b24ucHkgfCAxMiArKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBiL3RhcmdldC9oZXhh
Z29uL2hleF9jb21tb24ucHkKaW5kZXggYzA5YjQ4YmIzNi4uZjZmMTg3OTY4YSAxMDA3NTUKLS0t
IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhf
Y29tbW9uLnB5CkBAIC00MjgsMTAgKzQyOCwxOCBAQCBkZWYgaXNfcmVhZHdyaXRlKHNlbGYpOgog
Y2xhc3MgT2xkU291cmNlKFNvdXJjZSk6CiAgICAgZGVmIHJlZ190Y2coc2VsZik6CiAgICAgICAg
IHJldHVybiBmIntzZWxmLnJlZ3R5cGV9e3NlbGYucmVnaWR9ViIKKyAgICBkZWYgaXNfb2xkKHNl
bGYpOgorICAgICAgICByZXR1cm4gVHJ1ZQorICAgIGRlZiBpc19uZXcoc2VsZik6CisgICAgICAg
IHJldHVybiBGYWxzZQogCiBjbGFzcyBOZXdTb3VyY2UoU291cmNlKToKICAgICBkZWYgcmVnX3Rj
ZyhzZWxmKToKICAgICAgICAgcmV0dXJuIGYie3NlbGYucmVndHlwZX17c2VsZi5yZWdpZH1OIgor
ICAgIGRlZiBpc19vbGQoc2VsZik6CisgICAgICAgIHJldHVybiBGYWxzZQorICAgIGRlZiBpc19u
ZXcoc2VsZik6CisgICAgICAgIHJldHVybiBUcnVlCiAKIGNsYXNzIFJlYWRXcml0ZToKICAgICBk
ZWYgcmVnX3RjZyhzZWxmKToKQEAgLTQ0NCw2ICs0NTIsMTAgQEAgZGVmIGlzX3JlYWQoc2VsZik6
CiAgICAgICAgIHJldHVybiBUcnVlCiAgICAgZGVmIGlzX3JlYWR3cml0ZShzZWxmKToKICAgICAg
ICAgcmV0dXJuIFRydWUKKyAgICBkZWYgaXNfb2xkKHNlbGYpOgorICAgICAgICByZXR1cm4gVHJ1
ZQorICAgIGRlZiBpc19uZXcoc2VsZik6CisgICAgICAgIHJldHVybiBGYWxzZQogCiBjbGFzcyBH
cHJEZXN0KFJlZ2lzdGVyLCBTaW5nbGUsIERlc3QpOgogICAgIGRlZiBkZWNsX3RjZyhzZWxmLCBm
LCB0YWcsIHJlZ25vKToKLS0gCjIuMjUuMQoK

