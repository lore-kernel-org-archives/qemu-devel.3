Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F395C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJf-0000Yc-9K; Sun, 05 May 2024 22:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJb-0000Uc-9D
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJY-0007Wh-5b
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:54 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4461OFaS023882;
 Mon, 6 May 2024 02:42:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=ZMrZ3pPY0M+WRPKWpUFcsyAeBrjHP/yXCaHrFadxfJo=; b=P2
 95UwBtQeYms1fppYxOzHhy52Er4pQ6bOMsxLj6x9sq0raMPYKl+BKc+V0prdMQz1
 No44B+1LlQDmSyOX6nPwS4jJDZK+YYyN4GQhv6SQF8QvsdS/3nghH2lqAoFyeKTv
 8ghpRXPMnfNy5S53aWfv8yd9F9h21cATF4bUE3iu2C3aVNWIAqOz/dYKjt3/IOdc
 7/d/DuMrdqAsZZPUe3TlDpY2kOXzqELyxF0SBBvhaZI+yeV4mTGdn/ibRfQElKo0
 ZuiIkN/7uauT4vejoN792txkU8XEUu2i4zikDv15tHrb3LAgAqHlA4UV+lmMkJxx
 /AFzu9nquQhvn9LkPabg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwddc2end-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 02:42:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4462gmsw012887
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 6 May 2024 02:42:48 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 5 May 2024 19:42:48 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 04/15] Hexagon (target/hexagon) Pass P0 explicitly to helpers
 that need it
Date: Sun, 5 May 2024 19:42:16 -0700
Message-ID: <20240506024227.3345791-5-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: MqQH1IGRjpS61vKbDxUPVGZFnGWmIBJ3
X-Proofpoint-GUID: MqQH1IGRjpS61vKbDxUPVGZFnGWmIBJ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=320
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405060011
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClJhdGhlciB0
aGFuIHJlYWRpbmcgUDAgZnJvbSB0aGUgZW52LCBwYXNzIGl0IGV4cGxpY2l0bHkKClNpZ25lZC1v
ZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2Vk
LWJ5OiBBbnRvbiBKb2hhbnNzb24gPGFuam9AcmV2Lm5nPgpUZXN0ZWQtYnk6IEFudG9uIEpvaGFu
c3NvbiA8YW5qb0ByZXYubmc+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5j
LmNvbT4KTWVzc2FnZS1JZDogPDIwMjQwMjE0MDQyNzI2LjE5MjkwLTItbHRheWxvcnNpbXBzb25A
Z21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5IHwgMTAgKysrKysrKysrKwogdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmggICAgICB8ICA0ICsrLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5z
ZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5IGIvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQppbmRleCA5ZTdmNjEz
ZTNjLi42M2QxOGY3M2FkIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5
CisrKyBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKQEAgLTE5Nyw2ICsxOTcsMTAgQEAg
ZGVmIGdldF90YWdpbW1zKCk6CiAgICAgcmV0dXJuIGRpY3QoemlwKHRhZ3MsIGxpc3QobWFwKGNv
bXB1dGVfdGFnX2ltbWVkaWF0ZXMsIHRhZ3MpKSkpCiAKIAorZGVmIG5lZWRfcDAodGFnKToKKyAg
ICByZXR1cm4gIkFfSU1QTElDSVRfUkVBRFNfUDAiIGluIGF0dHJpYmRpY3RbdGFnXQorCisKIGRl
ZiBuZWVkX3Nsb3QodGFnKToKICAgICBpZiAoCiAgICAgICAgICJBX0NWSV9TQ0FUVEVSIiBub3Qg
aW4gYXR0cmliZGljdFt0YWddCkBAIC0xMTM0LDYgKzExMzgsMTIgQEAgZGVmIGhlbHBlcl9hcmdz
KHRhZywgcmVncywgaW1tcyk6CiAgICAgICAgICAgICAidGNnX2NvbnN0YW50X3RsKGN0eC0+bmV4
dF9QQykiLAogICAgICAgICAgICAgInRhcmdldF91bG9uZyBuZXh0X1BDIgogICAgICAgICApKQor
ICAgIGlmIG5lZWRfcDAodGFnKToKKyAgICAgICAgYXJncy5hcHBlbmQoSGVscGVyQXJnKAorICAg
ICAgICAgICAgImkzMiIsCisgICAgICAgICAgICAiaGV4X3ByZWRbMF0iLAorICAgICAgICAgICAg
InVpbnQzMl90IFAwIgorICAgICAgICApKQogICAgIGlmIG5lZWRfc2xvdCh0YWcpOgogICAgICAg
ICBhcmdzLmFwcGVuZChIZWxwZXJBcmcoCiAgICAgICAgICAgICAiaTMyIiwKZGlmZiAtLWdpdCBh
L3RhcmdldC9oZXhhZ29uL21hY3Jvcy5oIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKaW5kZXgg
MTM3NmQ2Y2NjMS4uYWVkYzg2M2ZhYiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vbWFjcm9z
LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTEsNSArMSw1IEBACiAvKgotICog
IENvcHlyaWdodChjKSAyMDE5LTIwMjMgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4g
QWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAqICBDb3B5cmlnaHQoYykgMjAxOS0yMDI0IFF1YWxjb21t
IElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCiAgKgogICogIFRo
aXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQv
b3IgbW9kaWZ5CiAgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJs
aWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKQEAgLTM1OCw3ICszNTgsNyBAQCBzdGF0aWMgaW5s
aW5lIFRDR3YgZ2VuX3JlYWRfaXJlZyhUQ0d2IHJlc3VsdCwgVENHdiB2YWwsIGludCBzaGlmdCkK
ICNlbmRpZgogI2RlZmluZSBmUkVBRF9QQygpIChQQykKIAotI2RlZmluZSBmUkVBRF9QMCgpIChl
bnYtPnByZWRbMF0pCisjZGVmaW5lIGZSRUFEX1AwKCkgKFAwKQogCiAjZGVmaW5lIGZDSEVDS19Q
Q0FMSUdOKEEpCiAKLS0gCjIuMjUuMQoK

