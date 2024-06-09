Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BEDC25B76
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 01:00:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG6sL-0007nc-5o; Sat, 08 Jun 2024 20:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sG-0007lJ-4q
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sC-0003te-9Y
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:30 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4590knpY015215;
 Sun, 9 Jun 2024 00:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W0hv18PH1zmmBiXV+tTS7ii6GGPMv6F2fMonOX/sww4=; b=LhoXGF+B0RbBhz3C
 P+i1+UlaKfbyqdfn20wqVc102EeDvyn9yn7dtfKbfnkRkZDzMzIJpee8TCcZMdis
 DxCnPSKkkgO6cPARfZEEYGmYqnVmFRbWOw1IKvRftVjcMhZWwQCygcyUWbo3MFsX
 R4rYFZYYINHdaju5lVscBDPRmTrdUTVnFxMzexIlqy5G/LWlrZXg8gBODrZTwG+g
 +MGn9LuBwKm0xtIlRzY6QJ1sJ0LDCoMKuNuenDQERwFNN+jTsYa9IQZbTGi6LB+K
 xM6qxWS3bAcfUc54Njh9vBlQDWktx4qQ2OrPAN3Cu/ghdgq77Qcttvvl66W7fg19
 2XrU+Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yme8rs9wt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 00:57:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4590vLrr024413
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 9 Jun 2024 00:57:21 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 8 Jun 2024 17:57:21 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 5/6] target/hexagon: idef-parser fix leak of init_list
Date: Sat, 8 Jun 2024 17:57:04 -0700
Message-ID: <20240609005705.2809037-6-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: vrSY73g2d8-8e49uHa_X2dqb4PO-7nhl
X-Proofpoint-GUID: vrSY73g2d8-8e49uHa_X2dqb4PO-7nhl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=832 impostorscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090006
Received-SPF: pass client-ip=205.220.168.131; envelope-from=bcain@quicinc.com;
 helo=mx0a-0031df01.pphosted.com
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

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KCmdlbl9pbnN0X2luaXRfYXJncygp
IGlzIGNhbGxlZCBmb3IgaW5zdHJ1Y3Rpb25zIHVzaW5nIGEgcHJlZGljYXRlIGFzIGFuCnJ2YWx1
ZS4gVXBvbiBmaXJzdCBjYWxsLCB0aGUgbGlzdCBvZiBhcmd1bWVudHMgd2hpY2ggbWlnaHQgbmVl
ZAppbml0aWFsaXphdGlvbiBpbml0X2xpc3QgaXMgZnJlZWQgdG8gaW5kaWNhdGUgdGhhdCB0aGV5
IGhhdmUgYmVlbgpwcm9jZXNzZWQuIEZvciBpbnN0cnVjdGlvbnMgd2l0aG91dCBhbiBydmFsdWUg
cHJlZGljYXRlLApnZW5faW5zdF9pbml0X2FyZ3MoKSBpc24ndCBjYWxsZWQgYW5kIGluaXRfbGlz
dCB3aWxsIG5ldmVyIGJlIGZyZWVkLgoKRnJlZSBpbml0X2xpc3QgZnJvbSBmcmVlX2luc3RydWN0
aW9uKCkgaWYgaXQgaGFzbid0IGFscmVhZHkgYmVlbiBmcmVlZC4KQSBjb21tZW50IGluIGZyZWVf
aW5zdHJ1Y3Rpb24gaXMgYWxzbyB1cGRhdGVkLgoKU2lnbmVkLW9mZi1ieTogQW50b24gSm9oYW5z
c29uIDxhbmpvQHJldi5uZz4KUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2lt
cHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNv
bT4KTWVzc2FnZS1JZDogPDIwMjQwNTIzMTI1OTAxLjI3Nzk3LTQtYW5qb0ByZXYubmc+ClNpZ25l
ZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJjYWluQHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhh
Z29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMgfCA5ICsrKysrKysrLQogMSBmaWxlIGNo
YW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMgYi90YXJnZXQvaGV4YWdvbi9p
ZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jCmluZGV4IDk1ZjJiNDMwNzYuLmMxNTBjMzA4YmUg
MTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMK
KysrIGIvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYwpAQCAtMjEy
MSw5ICsyMTIxLDE2IEBAIHZvaWQgZnJlZV9pbnN0cnVjdGlvbihDb250ZXh0ICpjKQogICAgICAg
ICBnX3N0cmluZ19mcmVlKGdfYXJyYXlfaW5kZXgoYy0+aW5zdC5zdHJpbmdzLCBHU3RyaW5nKiwg
aSksIFRSVUUpOwogICAgIH0KICAgICBnX2FycmF5X2ZyZWUoYy0+aW5zdC5zdHJpbmdzLCBUUlVF
KTsKKyAgICAvKgorICAgICAqIEZyZWUgbGlzdCBvZiBhcmd1bWVudHMgdGhhdCBtaWdodCBuZWVk
IGluaXRpYWxpemF0aW9uLCBpZiB0aGV5IGhhdmVuJ3QKKyAgICAgKiBhbHJlYWR5IGJlZW4gZnJl
ZWQuCisgICAgICovCisgICAgaWYgKGMtPmluc3QuaW5pdF9saXN0KSB7CisgICAgICAgIGdfYXJy
YXlfZnJlZShjLT5pbnN0LmluaXRfbGlzdCwgVFJVRSk7CisgICAgfQogICAgIC8qIEZyZWUgSU5B
TUUgdG9rZW4gdmFsdWUgKi8KICAgICBnX3N0cmluZ19mcmVlKGMtPmluc3QubmFtZSwgVFJVRSk7
Ci0gICAgLyogRnJlZSB2YXJpYWJsZXMgYW5kIHJlZ2lzdGVycyAqLworICAgIC8qIEZyZWUgZGVj
bGFyZWQgVENHdiB2YXJpYWJsZXMgKi8KICAgICBnX2FycmF5X2ZyZWUoYy0+aW5zdC5hbGxvY2F0
ZWQsIFRSVUUpOwogICAgIC8qIEluaXRpYWxpemUgaW5zdHJ1Y3Rpb24tc3BlY2lmaWMgcG9ydGlv
biBvZiB0aGUgY29udGV4dCAqLwogICAgIG1lbXNldCgmKGMtPmluc3QpLCAwLCBzaXplb2YoSW5z
dCkpOwotLSAKMi4yNS4xCgo=

