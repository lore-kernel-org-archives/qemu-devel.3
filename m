Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C168FC3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 01:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYxtw-0005Tl-8d; Tue, 30 Jul 2024 21:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sYxtt-0005Sh-Tn
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:13:10 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sYxts-0003AK-5x
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 21:13:09 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UGeY2R024584;
 Wed, 31 Jul 2024 01:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=qnkj30JtBqY4PL7TGozoN7
 jILssjNDOaNPYOrIb65uc=; b=pu2mlCWHnp2+dobiZGAwi2arCxJRqoNZlZS4jB
 uhxjmnDeoOZq0YIXsl890QH8EBDfV/Q9WS16Ky2vQ6kJLz4qTM6MK4SVI1iTy40f
 QR0fEkk/Tgi3bTBTE2P6d2etVDDaIdUhDjwshNTtsn6THHqHoTb34zjLkTiIItrm
 3vr/Ei1/cjAZwJ6C2S7rNV/aDGGq3qYKdA2LsPf+EkmlpM+otu2oG3XkFDq/sTkf
 211mVuNkV4BHRBYorLVWA501Enfar235kQLbYi7RMU9SbQ5xaTE2rvRu+x5evktB
 KzFTXocwwFwQd0n0Y5uFGjmtFJ+9j8eTgWw4i6MQxFc/eXWQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40ms439d5v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 01:13:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 46V1D47u032072
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 31 Jul 2024 01:13:04 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 30 Jul 2024 18:13:04 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <quic_mathbern@quicinc.com>, <sidneym@quicinc.com>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PATCH] target/hexagon: switch to dc set_props() list
Date: Tue, 30 Jul 2024 18:12:54 -0700
Message-ID: <20240731011254.1961048-1-bcain@quicinc.com>
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
X-Proofpoint-GUID: nidkpw6Ew8PjJWECHSOxY7Wp-AcWruqI
X-Proofpoint-ORIG-GUID: nidkpw6Ew8PjJWECHSOxY7Wp-AcWruqI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_21,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0
 impostorscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=968 suspectscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407310007
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

RGVmaW5lIGEgaGV4YWdvbl9jcHVfcHJvcGVydGllcyBsaXN0IHRvIG1hdGNoIHRoZSBpZGlvbSB1
c2VkCmJ5IG90aGVyIHRhcmdldHMuCgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBx
dWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8IDE4ICsrKysrKysrLS0tLS0t
LS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpk
aWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpp
bmRleCA2NGNjMDVjY2E3Li45MzU3OWZiYjE1IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9j
cHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDcsMTMgKzQ3LDEzIEBAIHN0YXRp
YyBPYmplY3RDbGFzcyAqaGV4YWdvbl9jcHVfY2xhc3NfYnlfbmFtZShjb25zdCBjaGFyICpjcHVf
bW9kZWwpCiAgICAgcmV0dXJuIG9jOwogfQogCi1zdGF0aWMgUHJvcGVydHkgaGV4YWdvbl9sbGRi
X2NvbXBhdF9wcm9wZXJ0eSA9Ci0gICAgREVGSU5FX1BST1BfQk9PTCgibGxkYi1jb21wYXQiLCBI
ZXhhZ29uQ1BVLCBsbGRiX2NvbXBhdCwgZmFsc2UpOwotc3RhdGljIFByb3BlcnR5IGhleGFnb25f
bGxkYl9zdGFja19hZGp1c3RfcHJvcGVydHkgPQotICAgIERFRklORV9QUk9QX1VOU0lHTkVEKCJs
bGRiLXN0YWNrLWFkanVzdCIsIEhleGFnb25DUFUsIGxsZGJfc3RhY2tfYWRqdXN0LAotICAgICAg
ICAgICAgICAgICAgICAgICAgIDAsIHFkZXZfcHJvcF91aW50MzIsIHRhcmdldF91bG9uZyk7Ci1z
dGF0aWMgUHJvcGVydHkgaGV4YWdvbl9zaG9ydF9jaXJjdWl0X3Byb3BlcnR5ID0KLSAgICBERUZJ
TkVfUFJPUF9CT09MKCJzaG9ydC1jaXJjdWl0IiwgSGV4YWdvbkNQVSwgc2hvcnRfY2lyY3VpdCwg
dHJ1ZSk7CitzdGF0aWMgUHJvcGVydHkgaGV4YWdvbl9jcHVfcHJvcGVydGllc1tdID0geworICAg
IERFRklORV9QUk9QX0JPT0woImxsZGItY29tcGF0IiwgSGV4YWdvbkNQVSwgbGxkYl9jb21wYXQs
IGZhbHNlKSwKKyAgICBERUZJTkVfUFJPUF9VTlNJR05FRCgibGxkYi1zdGFjay1hZGp1c3QiLCBI
ZXhhZ29uQ1BVLCBsbGRiX3N0YWNrX2FkanVzdCwgMCwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICBxZGV2X3Byb3BfdWludDMyLCB0YXJnZXRfdWxvbmcpLAorICAgIERFRklORV9QUk9QX0JPT0wo
InNob3J0LWNpcmN1aXQiLCBIZXhhZ29uQ1BVLCBzaG9ydF9jaXJjdWl0LCB0cnVlKSwKKyAgICBE
RUZJTkVfUFJPUF9FTkRfT0ZfTElTVCgpCit9OwogCiBjb25zdCBjaGFyICogY29uc3QgaGV4YWdv
bl9yZWduYW1lc1tUT1RBTF9QRVJfVEhSRUFEX1JFR1NdID0gewogICAgInIwIiwgInIxIiwgICJy
MiIsICAicjMiLCAgInI0IiwgICAicjUiLCAgInI2IiwgICJyNyIsCkBAIC0zMTYsOSArMzE2LDYg
QEAgc3RhdGljIHZvaWQgaGV4YWdvbl9jcHVfcmVhbGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJv
ciAqKmVycnApCiAKIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2luaXQoT2JqZWN0ICpvYmopCiB7
Ci0gICAgcWRldl9wcm9wZXJ0eV9hZGRfc3RhdGljKERFVklDRShvYmopLCAmaGV4YWdvbl9sbGRi
X2NvbXBhdF9wcm9wZXJ0eSk7Ci0gICAgcWRldl9wcm9wZXJ0eV9hZGRfc3RhdGljKERFVklDRShv
YmopLCAmaGV4YWdvbl9sbGRiX3N0YWNrX2FkanVzdF9wcm9wZXJ0eSk7Ci0gICAgcWRldl9wcm9w
ZXJ0eV9hZGRfc3RhdGljKERFVklDRShvYmopLCAmaGV4YWdvbl9zaG9ydF9jaXJjdWl0X3Byb3Bl
cnR5KTsKIH0KIAogI2luY2x1ZGUgImh3L2NvcmUvdGNnLWNwdS1vcHMuaCIKQEAgLTMzOSw2ICsz
MzYsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9jbGFzc19pbml0KE9iamVjdENsYXNzICpj
LCB2b2lkICpkYXRhKQogICAgIGRldmljZV9jbGFzc19zZXRfcGFyZW50X3JlYWxpemUoZGMsIGhl
eGFnb25fY3B1X3JlYWxpemUsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAm
bWNjLT5wYXJlbnRfcmVhbGl6ZSk7CiAKKyAgICBkZXZpY2VfY2xhc3Nfc2V0X3Byb3BzKGRjLCBo
ZXhhZ29uX2NwdV9wcm9wZXJ0aWVzKTsKICAgICByZXNldHRhYmxlX2NsYXNzX3NldF9wYXJlbnRf
cGhhc2VzKHJjLCBOVUxMLCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkLCBOVUxMLAogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJm1jYy0+cGFyZW50X3BoYXNlcyk7CiAKLS0g
CjIuMzQuMQoK

