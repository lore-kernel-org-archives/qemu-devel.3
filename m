Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F30BC27C55
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Jun 2024 00:59:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG6sH-0007mN-Iu; Sat, 08 Jun 2024 20:57:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sG-0007lU-BG
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:32 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sG6sC-0003td-9j
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 20:57:30 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 458N0TQ1006317;
 Sun, 9 Jun 2024 00:57:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /hTHLZvz4KGUdCEfcRHQa8TgJ5Q7rjuwuSRnIqOb6gA=; b=HoAmb10DlPMCarxJ
 dCX51KCV7tcjb0lW7Mu7ifcZhuD/zc8+LdqeZXSb13UR72kVaFkls+cxMdns1eQA
 s7A44pzrP0+1D8xf/MMMDrmFJF1D1lEBCbpJe+dZfYkABSwDfCkxEhCl2pjos5P9
 E+eaf07nAJ3AqcPxrfdO9bbFu7Hq9M3XWmS2o3EYzyGkE+WrYV88Tpls1YJ8sWk3
 Ng3jKi6SYilv0TC2XNIzMIVxQnYDClFlnNsDHvhKO3W423wxscKFeFrccUCE93nC
 bwasqUU9/KqbKJnnqJznXsRDf8ynBCaeiY+lSYuAIEg8pAH/h5snPs/hiqHkv8fB
 bv4pfA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymgfk14yr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 09 Jun 2024 00:57:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4590vLrs024413
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 9 Jun 2024 00:57:22 GMT
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
Subject: [PULL 6/6] target/hexagon: idef-parser simplify predicate init
Date: Sat, 8 Jun 2024 17:57:05 -0700
Message-ID: <20240609005705.2809037-7-bcain@quicinc.com>
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
X-Proofpoint-GUID: GdiOYVNkpe8YoHmL5MW-oW94XVJEFROp
X-Proofpoint-ORIG-GUID: GdiOYVNkpe8YoHmL5MW-oW94XVJEFROp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=729 suspectscore=0 impostorscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJldi5uZz4KCk9ubHkgcHJlZGljYXRlIGluc3Ry
dWN0aW9uIGFyZ3VtZW50cyBuZWVkIHRvIGJlIGluaXRpYWxpemVkIGJ5CmlkZWYtcGFyc2VyLiBU
aGlzIGNvbW1pdCByZW1vdmVzIHJlZ2lzdGVycyBmcm9tIHRoZSBpbml0X2xpc3QgYW5kCnNpbXBs
aWZpZXMgZ2VuX2luc3RfaW5pdF9hcmdzKCkgc2xpZ2h0bHkuCgpTaWduZWQtb2ZmLWJ5OiBBbnRv
biBKb2hhbnNzb24gPGFuam9AcmV2Lm5nPgpSZXZpZXdlZC1ieTogVGF5bG9yIFNpbXBzb24gPGx0
YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IEJyaWFuIENhaW4gPGJjYWluQHF1
aWNpbmMuY29tPgpNZXNzYWdlLUlkOiA8MjAyNDA1MjMxMjU5MDEuMjc3OTctNS1hbmpvQHJldi5u
Zz4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Ci0tLQogdGFy
Z2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRlZi1wYXJzZXIueSAgICB8ICAyIC0tCiB0YXJnZXQv
aGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jIHwgMjYgKysrKysrKysrKystLS0t
LS0tLS0tCiAyIGZpbGVzIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lkZWYtcGFyc2VyLnkg
Yi90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9pZGVmLXBhcnNlci55CmluZGV4IGNkMjYxMmVi
OGMuLjlmZmI5Zjk2OTkgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL2lk
ZWYtcGFyc2VyLnkKKysrIGIvdGFyZ2V0L2hleGFnb24vaWRlZi1wYXJzZXIvaWRlZi1wYXJzZXIu
eQpAQCAtMjMzLDggKzIzMyw2IEBAIGNvZGUgOiAneycgc3RhdGVtZW50cyAnfScKIGFyZ3VtZW50
X2RlY2wgOiBSRUcKICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgIGVtaXRf
YXJnKGMsICZAMSwgJiQxKTsKLSAgICAgICAgICAgICAgICAgICAgLyogRW5xdWV1ZSByZWdpc3Rl
ciBpbnRvIGluaXRpYWxpemF0aW9uIGxpc3QgKi8KLSAgICAgICAgICAgICAgICAgICAgZ19hcnJh
eV9hcHBlbmRfdmFsKGMtPmluc3QuaW5pdF9saXN0LCAkMSk7CiAgICAgICAgICAgICAgICAgfQog
ICAgICAgICAgICAgICB8IFBSRUQKICAgICAgICAgICAgICAgICB7CmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5jIGIvdGFyZ2V0L2hleGFnb24v
aWRlZi1wYXJzZXIvcGFyc2VyLWhlbHBlcnMuYwppbmRleCBjMTUwYzMwOGJlLi5hN2RjZDg1ZmU0
IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pZGVmLXBhcnNlci9wYXJzZXItaGVscGVycy5j
CisrKyBiL3RhcmdldC9oZXhhZ29uL2lkZWYtcGFyc2VyL3BhcnNlci1oZWxwZXJzLmMKQEAgLTE2
NTIsMjYgKzE2NTIsMjggQEAgdm9pZCBnZW5faW5zdChDb250ZXh0ICpjLCBHU3RyaW5nICppbmFt
ZSkKIAogCiAvKgotICogSW5pdGlhbGl6ZSBkZWNsYXJlZCBidXQgdW5pbml0aWFsaXplZCByZWdp
c3RlcnMsIGJ1dCBvbmx5IGZvcgotICogbm9uLWNvbmRpdGlvbmFsIGluc3RydWN0aW9ucworICog
SW5pdGlhbGl6ZSBkZWNsYXJlZCBidXQgdW5pbml0aWFsaXplZCBpbnN0cnVjdGlvbiBhcmd1bWVu
dHMuIE9ubHkgbmVlZGVkIGZvcgorICogcHJlZGljYXRlIGFyZ3VtZW50cywgaW5pdGlhbGl6YXRp
b24gb2YgcmVnaXN0ZXJzIGlzIGhhbmRsZWQgYnkgdGhlIEhleGFnb24KKyAqIGZyb250ZW5kLgog
ICovCiB2b2lkIGdlbl9pbnN0X2luaXRfYXJncyhDb250ZXh0ICpjLCBZWUxUWVBFICpsb2NwKQog
eworICAgIEhleFZhbHVlICp2YWwgPSBOVUxMOworICAgIGNoYXIgc3VmZml4OworCisgICAgLyog
SWYgaW5pdF9saXN0IGlzIE5VTEwgYXJndW1lbnRzIGhhdmUgYWxyZWFkeSBiZWVuIGluaXRpYWxp
emVkICovCiAgICAgaWYgKCFjLT5pbnN0LmluaXRfbGlzdCkgewogICAgICAgICByZXR1cm47CiAg
ICAgfQogCiAgICAgZm9yICh1bnNpZ25lZCBpID0gMDsgaSA8IGMtPmluc3QuaW5pdF9saXN0LT5s
ZW47IGkrKykgewotICAgICAgICBIZXhWYWx1ZSAqdmFsID0gJmdfYXJyYXlfaW5kZXgoYy0+aW5z
dC5pbml0X2xpc3QsIEhleFZhbHVlLCBpKTsKLSAgICAgICAgaWYgKHZhbC0+dHlwZSA9PSBSRUdJ
U1RFUl9BUkcpIHsKLSAgICAgICAgICAgIC8qIE5vdGhpbmcgdG8gZG8gaGVyZSAqLwotICAgICAg
ICB9IGVsc2UgaWYgKHZhbC0+dHlwZSA9PSBQUkVESUNBVEUpIHsKLSAgICAgICAgICAgIGNoYXIg
c3VmZml4ID0gdmFsLT5pc19kb3RuZXcgPyAnTicgOiAnVic7Ci0gICAgICAgICAgICBFTUlUX0hF
QUQoYywgInRjZ19nZW5fbW92aV9pJXUoUCVjJWMsIDApO1xuIiwgdmFsLT5iaXRfd2lkdGgsCi0g
ICAgICAgICAgICAgICAgICAgICAgdmFsLT5wcmVkLmlkLCBzdWZmaXgpOwotICAgICAgICB9IGVs
c2UgewotICAgICAgICAgICAgeXlhc3NlcnQoYywgbG9jcCwgZmFsc2UsICJJbnZhbGlkIGFyZyB0
eXBlISIpOwotICAgICAgICB9CisgICAgICAgIHZhbCA9ICZnX2FycmF5X2luZGV4KGMtPmluc3Qu
aW5pdF9saXN0LCBIZXhWYWx1ZSwgaSk7CisgICAgICAgIHN1ZmZpeCA9IHZhbC0+aXNfZG90bmV3
ID8gJ04nIDogJ1YnOworICAgICAgICB5eWFzc2VydChjLCBsb2NwLCB2YWwtPnR5cGUgPT0gUFJF
RElDQVRFLAorICAgICAgICAgICAgICAgICAiT25seSBwcmVkaWNhdGVzIG5lZWQgdG8gYmUgaW5p
dGlhbGl6ZWQhIik7CisgICAgICAgIHl5YXNzZXJ0KGMsIGxvY3AsIHZhbC0+Yml0X3dpZHRoID09
IDMyLAorICAgICAgICAgICAgICAgICAiUHJlZGljYXRlcyBzaG91bGQgYWx3YXlzIGJlIDMyIGJp
dHMiKTsKKyAgICAgICAgRU1JVF9IRUFEKGMsICJ0Y2dfZ2VuX21vdmlfaTMyKFAlYyVjLCAwKTtc
biIsIHZhbC0+cHJlZC5pZCwgc3VmZml4KTsKICAgICB9CiAKICAgICAvKiBGcmVlIGFyZ3VtZW50
IGluaXQgbGlzdCBvbmNlIHdlIGhhdmUgaW5pdGlhbGl6ZWQgZXZlcnl0aGluZyAqLwotLSAKMi4y
NS4xCgo=

