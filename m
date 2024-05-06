Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA22C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:43:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJd-0000XP-Vx; Sun, 05 May 2024 22:42:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJb-0000Uf-Kd
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJY-0007Ws-Lq
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:55 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4462gXhJ030265;
 Mon, 6 May 2024 02:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=C46CCXhrAqmwBloP58/XD043/zAMDXMfBVh/bcykWlk=; b=AV
 VttEdDn4AcNJKmxYedSLq+tAG7YPcR0XUrzIKSaSX3rOry6LWXOoxU4CXUcg2QtM
 WyiIB8Rhq4wmQzy3/hEqL93uOmw2PXBwJoNTnBZgUH8CjNjh3tSoEM98yZExiT6B
 zfSqeko6fc5myuom9mWBDRQP8gp/31orU6Q6wO3J5CgqxNxJ7w2eB3nwWw7oPJsF
 ZtHhHV0DhCnME+08blDOKCVLvP2GfaxiHwAco/aTveyNnSAamKd/kx55Yo8nrv3L
 Km7i17/TKhPWhKa2+Hy7xSZ+bJPNncMDR958k4OKH48NCRsE7gkPo9lSaJDnCRln
 u0+zSjjKRm6C8msYEbyg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwcbpjg47-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 02:42:50 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4462gnkR028304
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
Subject: [PULL 06/15] Hexagon (target/hexagon) Only pass env to generated
 helper when needed
Date: Sun, 5 May 2024 19:42:18 -0700
Message-ID: <20240506024227.3345791-7-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: Ut-7WK8VN5YtiSHO6wYqddP9W10XQ6CA
X-Proofpoint-GUID: Ut-7WK8VN5YtiSHO6wYqddP9W10XQ6CA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 malwarescore=0 adultscore=0 impostorscore=0 mlxscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 mlxlogscore=698 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkN1cnJlbnRs
eSwgd2UgcGFzcyBlbnYgdG8gZXZlcnkgZ2VuZXJhdGVkIGhlbHBlci4gIFdoZW4gdGhlIHNlbWFu
dGljcyBvZgp0aGUgaW5zdHJ1Y3Rpb24gb25seSBkZXBlbmQgb24gdGhlIGFyZ3VtZW50cywgdGhp
cyBpcyB1bm5lY2Vzc2FyeSBhbmQKYWRkcyBleHRyYSBvdmVyaGVhZCB0byB0aGUgaGVscGVyIGNh
bGwuCgpXZSBhZGQgdGhlIFRDR19DQUxMX05PX1JXR19TRSBmbGFnIHRvIGFueSBub24tSFZYIGhl
bHBlcnMgdGhhdCBkb24ndCBnZXQKdGhlIHB0ciB0byBlbnYuCgpUaGUgQTJfbm9wIGFuZCBTQTFf
c2V0aW4xIGluc3RydWN0aW9ucyBlbmQgdXAgd2l0aCBubyBhcmd1bWVudHMuICBUaGlzCnJlc3Vs
dHMgaW4gYSAib2xkLXN0eWxlIGZ1bmN0aW9uIGRlZmluaXRpb24iIGVycm9yIGZyb20gdGhlIGNv
bXBpbGVyLCBzbwp3ZSB3cml0ZSBvdmVycmlkZXMgZm9yIHRoZW0uCgpXaXRoIHRoaXMgY2hhbmdl
LCB0aGUgbnVtYmVyIG9mIGhlbHBlcnMgd2l0aCBlbnYgYXJndW1lbnQgaXMKICAgIGlkZWYtcGFy
c2VyIGVuYWJsZWQ6ICAgIDMyOSB0b3RhbCwgMjMgd2l0aCBlbnYKICAgIGlkZWYtcGFyc2VyIGRp
c2FibGVkOiAgIDE1NDMgdG90YWwsIDU1MCB3aXRoIGVudgoKU2lnbmVkLW9mZi1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KUmV2aWV3ZWQtYnk6IEFudG9uIEpv
aGFuc3NvbiA8YW5qb0ByZXYubmc+ClRlc3RlZC1ieTogQW50b24gSm9oYW5zc29uIDxhbmpvQHJl
di5uZz4KTWVzc2FnZS1JZDogPDIwMjQwMjE0MDQyNzI2LjE5MjkwLTQtbHRheWxvcnNpbXBzb25A
Z21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4K
LS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5faGVscGVyX3Byb3Rvcy5weSB8IDEyICsrKysrKysrKyst
LQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oICAgICAgICAgICAgfCAgNSArKysrLQogdGFyZ2V0
L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgfCAyMyArKysrKysrKysrKysrKysrKystLS0t
LQogMyBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl9oZWxwZXJfcHJvdG9zLnB5IGIvdGFyZ2V0L2hl
eGFnb24vZ2VuX2hlbHBlcl9wcm90b3MucHkKaW5kZXggYzgyYjBmNTRlNC4uZjg1NzhkNTAzMyAx
MDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX2hlbHBlcl9wcm90b3MucHkKKysrIGIvdGFy
Z2V0L2hleGFnb24vZ2VuX2hlbHBlcl9wcm90b3MucHkKQEAgLTEsNyArMSw3IEBACiAjIS91c3Iv
YmluL2VudiBweXRob24zCiAKICMjCi0jIyAgQ29weXJpZ2h0KGMpIDIwMTktMjAyMyBRdWFsY29t
bSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorIyMgIENvcHly
aWdodChjKSAyMDE5LTIwMjQgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxsIFJp
Z2h0cyBSZXNlcnZlZC4KICMjCiAjIyAgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlv
dSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKICMjICBpdCB1bmRlciB0aGUgdGVy
bXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBieQpAQCAt
NDAsNyArNDAsMTUgQEAgZGVmIGdlbl9oZWxwZXJfcHJvdG90eXBlKGYsIHRhZywgdGFncmVncywg
dGFnaW1tcyk6CiAgICAgICAgIGRlY2xhcmVkLmFwcGVuZChhcmcucHJvdG9fYXJnKQogCiAgICAg
YXJndW1lbnRzID0gIiwgIi5qb2luKGRlY2xhcmVkKQotICAgIGYud3JpdGUoZiJERUZfSEVMUEVS
X3tsZW4oZGVjbGFyZWQpIC0gMX0oe3RhZ30sIHthcmd1bWVudHN9KVxuIikKKworICAgICMjIEFk
ZCB0aGUgVENHX0NBTExfTk9fUldHX1NFIGZsYWcgdG8gaGVscGVycyB0aGF0IGRvbid0IHRha2Ug
dGhlIGVudgorICAgICMjIGFyZ3VtZW50IGFuZCBhcmVuJ3QgSFZYIGluc3RydWN0aW9ucy4gIFNp
bmNlIEhWWCBpbnN0cnVjdGlvbnMgdGFrZQorICAgICMjIHBvaW50ZXJzIHRvIHRoZWlyIGFyZ3Vt
ZW50cywgdGhleSB3aWxsIGhhdmUgc2lkZSBlZmZlY3RzLgorICAgIGlmIGhleF9jb21tb24ubmVl
ZF9lbnYodGFnKSBvciBoZXhfY29tbW9uLmlzX2h2eF9pbnNuKHRhZyk6CisgICAgICAgIGYud3Jp
dGUoZiJERUZfSEVMUEVSX3tsZW4oZGVjbGFyZWQpIC0gMX0oe3RhZ30sIHthcmd1bWVudHN9KVxu
IikKKyAgICBlbHNlOgorICAgICAgICBmLndyaXRlKGYiREVGX0hFTFBFUl9GTEFHU197bGVuKGRl
Y2xhcmVkKSAtIDF9KHt0YWd9LCAiCisgICAgICAgICAgICAgICAgZiJUQ0dfQ0FMTF9OT19SV0df
U0UsIHthcmd1bWVudHN9KVxuIikKIAogCiBkZWYgbWFpbigpOgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oCmluZGV4IDFjNDM5
MWI0MTUuLjNmYzFmNGUyODEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaAor
KysgYi90YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmgKQEAgLTEsNSArMSw1IEBACiAvKgotICogIENv
cHlyaWdodChjKSAyMDE5LTIwMjMgUXVhbGNvbW0gSW5ub3ZhdGlvbiBDZW50ZXIsIEluYy4gQWxs
IFJpZ2h0cyBSZXNlcnZlZC4KKyAqICBDb3B5cmlnaHQoYykgMjAxOS0yMDI0IFF1YWxjb21tIElu
bm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCiAgKgogICogIFRoaXMg
cHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3Ig
bW9kaWZ5CiAgKiAgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMg
TGljZW5zZSBhcyBwdWJsaXNoZWQgYnkKQEAgLTEzNjksMyArMTM2OSw2IEBACiAgICAgICAgIGdl
bl9oZWxwZXJfcmFpc2VfZXhjZXB0aW9uKHRjZ19lbnYsIGV4Y3ApOyBcCiAgICAgfSB3aGlsZSAo
MCkKICNlbmRpZgorCisjZGVmaW5lIGZHRU5fVENHX0EyX25vcChTSE9SVENPREUpIGRvIHsgfSB3
aGlsZSAoMCkKKyNkZWZpbmUgZkdFTl9UQ0dfU0ExX3NldGluMShTSE9SVENPREUpIHRjZ19nZW5f
bW92aV90bChSZFYsIC0xKQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5w
eSBiL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKaW5kZXggMDNjOWNlMWQ4YS4uYzA5YjQ4
YmIzNiAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90YXJn
ZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CkBAIC0yMDYsNiArMjA2LDE4IEBAIGRlZiBuZWVkX3Nw
KHRhZyk6CiAgICAgcmV0dXJuICJBX0lNUExJQ0lUX1JFQURTX1NQIiBpbiBhdHRyaWJkaWN0W3Rh
Z10KIAogCitkZWYgaXNfaHZ4X2luc24odGFnKToKKyAgICByZXR1cm4gIkFfQ1ZJIiBpbiBhdHRy
aWJkaWN0W3RhZ10KKworCitkZWYgbmVlZF9lbnYodGFnKToKKyAgICByZXR1cm4gKCJBX1NUT1JF
IiBpbiBhdHRyaWJkaWN0W3RhZ10gb3IKKyAgICAgICAgICAgICJBX0xPQUQiIGluIGF0dHJpYmRp
Y3RbdGFnXSBvcgorICAgICAgICAgICAgIkFfQ1ZJX0dBVEhFUiIgaW4gYXR0cmliZGljdFt0YWdd
IG9yCisgICAgICAgICAgICAiQV9DVklfU0NBVFRFUiIgaW4gYXR0cmliZGljdFt0YWddIG9yCisg
ICAgICAgICAgICAiQV9JTVBMSUNJVF9XUklURVNfVVNSIiBpbiBhdHRyaWJkaWN0W3RhZ10pCisK
KwogZGVmIG5lZWRfc2xvdCh0YWcpOgogICAgIGlmICgKICAgICAgICAgIkFfQ1ZJX1NDQVRURVIi
IG5vdCBpbiBhdHRyaWJkaWN0W3RhZ10KQEAgLTEwODUsMTEgKzEwOTcsMTIgQEAgZGVmIGhlbHBl
cl9hcmdzKHRhZywgcmVncywgaW1tcyk6CiAgICAgYXJncyA9IFtdCiAKICAgICAjIyBGaXJzdCBh
cmd1bWVudCBpcyB0aGUgQ1BVIHN0YXRlCi0gICAgYXJncy5hcHBlbmQoSGVscGVyQXJnKAotICAg
ICAgICAiZW52IiwKLSAgICAgICAgInRjZ19lbnYiLAotICAgICAgICAiQ1BVSGV4YWdvblN0YXRl
ICplbnYiCi0gICAgKSkKKyAgICBpZiBuZWVkX2Vudih0YWcpOgorICAgICAgICBhcmdzLmFwcGVu
ZChIZWxwZXJBcmcoCisgICAgICAgICAgICAiZW52IiwKKyAgICAgICAgICAgICJ0Y2dfZW52IiwK
KyAgICAgICAgICAgICJDUFVIZXhhZ29uU3RhdGUgKmVudiIKKyAgICAgICAgKSkKIAogICAgICMj
IEZvciBwcmVkaWNhdGVkIGluc3RydWN0aW9ucywgd2UgcGFzcyBpbiB0aGUgZGVzdGluYXRpb24g
cmVnaXN0ZXIKICAgICBpZiBpc19wcmVkaWNhdGVkKHRhZyk6Ci0tIAoyLjI1LjEKCg==

