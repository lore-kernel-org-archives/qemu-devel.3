Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95BCBC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:44:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJe-0000XR-16; Sun, 05 May 2024 22:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJb-0000Ug-LR
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJY-0007Wp-IB
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4462MwXE030634;
 Mon, 6 May 2024 02:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=xVgTLkVTVXp3q3vMrtH14e8nji9tO7XMr/eLIK/nlMc=; b=Ya
 f7K5QHRotpkyU+BGIF/0OYmShfVrAJ+8Vx3DqBiWks/yhEZmSKMyL/FttB6SIBQc
 oWf0IKI+WwrFluDeCheIZdO+rIOU7eF8PWyKi+si/4xovwPggfzfZBUgwISmm0Ex
 imHWQH0tzVSnFEtbuWSvPx1dfOb38nX53eIwT4I4H8ctK0zuWub6Zg2iSfpCfwnY
 uMBNiis69d3K6y2RSvswtJfDoTUmsIfBaQPDWavzViS2oCGPk/186n1qH4blRKx5
 dBNhTT7+oGskHsSaOsf6afZIUExyFnmXrWIkRUvh1yG+pNN/OBtMi7SU8YuVFeep
 JQ6g2flb5EEPC6oquDCQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwc1c2gy7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 02:42:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4462gnLK011024
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 6 May 2024 02:42:49 GMT
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
Subject: [PULL 05/15] Hexagon (target/hexagon) Pass SP explicitly to helpers
 that need it
Date: Sun, 5 May 2024 19:42:17 -0700
Message-ID: <20240506024227.3345791-6-bcain@quicinc.com>
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
X-Proofpoint-GUID: xRAZXUvlyBuNBMAFq5WUlV4-JOtqv7S1
X-Proofpoint-ORIG-GUID: xRAZXUvlyBuNBMAFq5WUlV4-JOtqv7S1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=408 adultscore=0 bulkscore=0 impostorscore=0
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KClJhdGhlciB0
aGFuIHJlYWRpbmcgU1AgZnJvbSB0aGUgZW52LCBwYXNzIGl0IGV4cGxpY2l0bHkKClNpZ25lZC1v
ZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2Vk
LWJ5OiBBbnRvbiBKb2hhbnNzb24gPGFuam9AcmV2Lm5nPgpUZXN0ZWQtYnk6IEFudG9uIEpvaGFu
c3NvbiA8YW5qb0ByZXYubmc+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5j
LmNvbT4KTWVzc2FnZS1JZDogPDIwMjQwMjE0MDQyNzI2LjE5MjkwLTMtbHRheWxvcnNpbXBzb25A
Z21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyB8ICAzICsrLQogdGFyZ2V0L2hl
eGFnb24vaGV4X2NvbW1vbi5weSAgICAgfCAxMSArKysrKysrKysrKwogdGFyZ2V0L2hleGFnb24v
bWFjcm9zLmggICAgICAgICAgfCAgMiArLQogMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2F0dHJpYnNf
ZGVmLmguaW5jIGIvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMKaW5kZXggODc5NDJk
NDZmNC4uOWUzYTA1Zjg4MiAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYu
aC5pbmMKKysrIGIvdGFyZ2V0L2hleGFnb24vYXR0cmlic19kZWYuaC5pbmMKQEAgLTEsNSArMSw1
IEBACiAvKgotICogIENvcHlyaWdodChjKSAyMDE5LTIwMjMgUXVhbGNvbW0gSW5ub3ZhdGlvbiBD
ZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KKyAqICBDb3B5cmlnaHQoYykgMjAxOS0y
MDI0IFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQu
CiAgKgogICogIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJp
YnV0ZSBpdCBhbmQvb3IgbW9kaWZ5CiAgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUg
R2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKQEAgLTExNyw2ICsxMTcsNyBA
QCBERUZfQVRUUklCKElNUExJQ0lUX1JFQURTX1AxLCAiUmVhZHMgdGhlIFAxIHJlZ2lzdGVyIiwg
IiIsICIiKQogREVGX0FUVFJJQihJTVBMSUNJVF9SRUFEU19QMiwgIlJlYWRzIHRoZSBQMiByZWdp
c3RlciIsICIiLCAiIikKIERFRl9BVFRSSUIoSU1QTElDSVRfUkVBRFNfUDMsICJSZWFkcyB0aGUg
UDMgcmVnaXN0ZXIiLCAiIiwgIiIpCiBERUZfQVRUUklCKElNUExJQ0lUX1dSSVRFU19VU1IsICJN
YXkgd3JpdGUgVVNSIiwgIiIsICIiKQorREVGX0FUVFJJQihJTVBMSUNJVF9SRUFEU19TUCwgIlJl
YWRzIHRoZSBTUCByZWdpc3RlciIsICIiLCAiIikKIERFRl9BVFRSSUIoQ09NTVVURVMsICJUaGUg
b3BlcmF0aW9uIGlzIGNvbW11bml0aXZlIiwgIiIsICIiKQogREVGX0FUVFJJQihERUFMTE9DUkVU
LCAiZGVhbGxvY19yZXR1cm4iLCAiIiwgIiIpCiBERUZfQVRUUklCKERFQUxMT0NGUkFNRSwgImRl
YWxsb2NmcmFtZSIsICIiLCAiIikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21t
b24ucHkgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CmluZGV4IDYzZDE4ZjczYWQuLjAz
YzljZTFkOGEgMTAwNzU1Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKKysrIGIv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQpAQCAtMTAxLDYgKzEwMSw3IEBAIGRlZiBjYWxj
dWxhdGVfYXR0cmlicygpOgogICAgIGFkZF9xZW11X21hY3JvX2F0dHJpYignZkxTQk5FVzEnLCAn
QV9JTVBMSUNJVF9SRUFEU19QMScpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCdmTFNCTkVX
MU5PVCcsICdBX0lNUExJQ0lUX1JFQURTX1AxJykKICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIo
J2ZSRUFEX1AzJywgJ0FfSU1QTElDSVRfUkVBRFNfUDMnKQorICAgIGFkZF9xZW11X21hY3JvX2F0
dHJpYignZlJFQURfU1AnLCAnQV9JTVBMSUNJVF9SRUFEU19TUCcpCiAKICAgICAjIFJlY3Vyc2Ug
ZG93biBtYWNyb3MsIGZpbmQgYXR0cmlidXRlcyBmcm9tIHN1Yi1tYWNyb3MKICAgICBtYWNyb1Zh
bHVlcyA9IGxpc3QobWFjcm9zLnZhbHVlcygpKQpAQCAtMjAxLDYgKzIwMiwxMCBAQCBkZWYgbmVl
ZF9wMCh0YWcpOgogICAgIHJldHVybiAiQV9JTVBMSUNJVF9SRUFEU19QMCIgaW4gYXR0cmliZGlj
dFt0YWddCiAKIAorZGVmIG5lZWRfc3AodGFnKToKKyAgICByZXR1cm4gIkFfSU1QTElDSVRfUkVB
RFNfU1AiIGluIGF0dHJpYmRpY3RbdGFnXQorCisKIGRlZiBuZWVkX3Nsb3QodGFnKToKICAgICBp
ZiAoCiAgICAgICAgICJBX0NWSV9TQ0FUVEVSIiBub3QgaW4gYXR0cmliZGljdFt0YWddCkBAIC0x
MTQ0LDYgKzExNDksMTIgQEAgZGVmIGhlbHBlcl9hcmdzKHRhZywgcmVncywgaW1tcyk6CiAgICAg
ICAgICAgICAiaGV4X3ByZWRbMF0iLAogICAgICAgICAgICAgInVpbnQzMl90IFAwIgogICAgICAg
ICApKQorICAgIGlmIG5lZWRfc3AodGFnKToKKyAgICAgICAgYXJncy5hcHBlbmQoSGVscGVyQXJn
KAorICAgICAgICAgICAgImkzMiIsCisgICAgICAgICAgICAiaGV4X2dwcltIRVhfUkVHX1NQXSIs
CisgICAgICAgICAgICAidWludDMyX3QgU1AiCisgICAgICAgICkpCiAgICAgaWYgbmVlZF9zbG90
KHRhZyk6CiAgICAgICAgIGFyZ3MuYXBwZW5kKEhlbHBlckFyZygKICAgICAgICAgICAgICJpMzIi
LApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmggYi90YXJnZXQvaGV4YWdvbi9t
YWNyb3MuaAppbmRleCBhZWRjODYzZmFiLi5mZWI3OThjNmMwIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9tYWNyb3MuaAorKysgYi90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaApAQCAtMzQzLDcg
KzM0Myw3IEBAIHN0YXRpYyBpbmxpbmUgVENHdiBnZW5fcmVhZF9pcmVnKFRDR3YgcmVzdWx0LCBU
Q0d2IHZhbCwgaW50IHNoaWZ0KQogCiAjZGVmaW5lIGZSRUFEX0xSKCkgKGVudi0+Z3ByW0hFWF9S
RUdfTFJdKQogCi0jZGVmaW5lIGZSRUFEX1NQKCkgKGVudi0+Z3ByW0hFWF9SRUdfU1BdKQorI2Rl
ZmluZSBmUkVBRF9TUCgpIChTUCkKICNkZWZpbmUgZlJFQURfTEMwIChlbnYtPmdwcltIRVhfUkVH
X0xDMF0pCiAjZGVmaW5lIGZSRUFEX0xDMSAoZW52LT5ncHJbSEVYX1JFR19MQzFdKQogI2RlZmlu
ZSBmUkVBRF9TQTAgKGVudi0+Z3ByW0hFWF9SRUdfU0EwXSkKLS0gCjIuMjUuMQoK

