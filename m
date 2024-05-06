Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADEAC4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJc-0000Ub-3j; Sun, 05 May 2024 22:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJX-0000TI-9v
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJU-0007WD-Aq
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:51 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4462cMIs018275;
 Mon, 6 May 2024 02:42:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:mime-version:content-type
 :content-transfer-encoding; s=qcppdkim1; bh=SzfxfZ+EP7mQm5DFJHUL
 x2N71/qGZosU/COJLIqBw1U=; b=ELzzrF+3L54Nkf9jss0COVfVMfqmfRxufZbd
 sj937aSVTSOSb/5Jt0IM0DuqBXlRm+r6DJWgpleXff5A8H8TEP5c0CzzCJYPyv+o
 quaqmqRAgXj+DEwssCmMPKqFwBSfSsAUtN2jCbKSDpLEocZyY0z2EkoPjqF4QjTk
 LMNO05NQ9BdctAf/ynUvbwx/aEU2oA5ToYFvecYz3iUqpEK4epFDitjZxumXWBlX
 efQog/niM4L7aZQnpq4V2DihfLoz/2qJvkuy/xa3fMP6Cm6LedyiZwOmJDlSWLrB
 6QDUA6BT/ikKGG12vUow/MWn2iu3fFS3x5dLR/BQJFIHkHjOZA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwcm4jgbr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 02:42:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4462ghGO003975
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 6 May 2024 02:42:43 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 5 May 2024 19:42:42 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <armbru@redhat.com>, <richard.henderson@linaro.org>, 
 <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <stefanha@redhat.com>, <ale@rev.ng>,
 <anjo@rev.ng>, <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>
Subject: [PULL 00/15] Hexagon: simplify gen for packets w/o read-after-write
Date: Sun, 5 May 2024 19:42:12 -0700
Message-ID: <20240506024227.3345791-1-bcain@quicinc.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: dqjRemCWZFnxfaepzhir0mNqN5iSeiZP
X-Proofpoint-GUID: dqjRemCWZFnxfaepzhir0mNqN5iSeiZP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=684 impostorscore=0
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

VGhlIGZvbGxvd2luZyBjaGFuZ2VzIHNpbmNlIGNvbW1pdCAyNDhmNmY2MmRmMDczYTNiNDE1OGZk
MDA5Mzg2M2FiODg1ZmVhYmI1OgoKICBNZXJnZSB0YWcgJ3B1bGwtYXhwLTIwMjQwNTA0JyBvZiBo
dHRwczovL2dpdGxhYi5jb20vcnRoNzY4MC9xZW11IGludG8gc3RhZ2luZyAoMjAyNC0wNS0wNCAw
ODozOTo0NiAtMDcwMCkKCmFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0OgoK
ICBodHRwczovL2dpdGh1Yi5jb20vcXVpYy9xZW11IHRhZ3MvcHVsbC1oZXgtMjAyNDA1MDUKCmZv
ciB5b3UgdG8gZmV0Y2ggY2hhbmdlcyB1cCB0byBhNDY5NjY2MTQ5MWNhYzhjMWMwOGU3ZDQ4MmQ3
NTFmODA4Y2UzMTQzOgoKICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgUmVtb3ZlIGhleF9jb21t
b24ucmVhZF9hdHRyaWJzX2ZpbGUgKDIwMjQtMDUtMDUgMTY6MjI6MDcgLTA3MDApCgotLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
ClNob3J0LWNpcmN1aXQgZm9yIHBhY2tldHMgdy9vIHJlYWQtYWZ0ZXItd3JpdGUKQ2xlYW51cCB1
bnVzZWQgY29kZSBpbiBnZW5fKi5weSBzY3JpcHRzCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tClRheWxvciBTaW1wc29uICgx
NSk6CiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBBbmFseXplIHJlYWRzIGJlZm9yZSB3
cml0ZXMKICAgICAgSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIEVuYWJsZSBtb3JlIHNob3J0LWNp
cmN1aXQgcGFja2V0cyAoc2NhbGFyIGNvcmUpCiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29u
KSBFbmFibGUgbW9yZSBzaG9ydC1jaXJjdWl0IHBhY2tldHMgKEhWWCkKICAgICAgSGV4YWdvbiAo
dGFyZ2V0L2hleGFnb24pIFBhc3MgUDAgZXhwbGljaXRseSB0byBoZWxwZXJzIHRoYXQgbmVlZCBp
dAogICAgICBIZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgUGFzcyBTUCBleHBsaWNpdGx5IHRvIGhl
bHBlcnMgdGhhdCBuZWVkIGl0CiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBPbmx5IHBh
c3MgZW52IHRvIGdlbmVyYXRlZCBoZWxwZXIgd2hlbiBuZWVkZWQKICAgICAgSGV4YWdvbiAodGFy
Z2V0L2hleGFnb24pIEFkZCBpc19vbGQvaXNfbmV3IHRvIFJlZ2lzdGVyIGNsYXNzCiAgICAgIEhl
eGFnb24gKHRhcmdldC9oZXhhZ29uKSBNYXJrIG5ld19yZWFkX2lkeCBpbiB0cmFucyBmdW5jdGlv
bnMKICAgICAgSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIE1hcmsgZGVzdF9pZHggaW4gdHJhbnMg
ZnVuY3Rpb25zCiAgICAgIEhleGFnb24gKHRhcmdldC9oZXhhZ29uKSBNYXJrIGhhc19wcmVkX2Rl
c3QgaW4gdHJhbnMgZnVuY3Rpb25zCiAgICAgIEhleGFnb24gKHRlc3RzL3RjZy9oZXhhZ29uKSBU
ZXN0IEhWWCAubmV3IHJlYWQgZnJvbSBoaWdoIGhhbGYgb2YgcGFpcgogICAgICBIZXhhZ29uICh0
YXJnZXQvaGV4YWdvbikgUmVtb3ZlIHVzZXMgb2Ygb3BfcmVnc19nZW5lcmF0ZWQuaC5pbmMKICAg
ICAgSGV4YWdvbiAodGFyZ2V0L2hleGFnb24pIFJlbW92ZSBnZW5fb3BfcmVncy5weQogICAgICBI
ZXhhZ29uICh0YXJnZXQvaGV4YWdvbikgUmVtb3ZlIGdlbl9zaG9ydGNvZGUucHkKICAgICAgSGV4
YWdvbiAodGFyZ2V0L2hleGFnb24pIFJlbW92ZSBoZXhfY29tbW9uLnJlYWRfYXR0cmlic19maWxl
CgogdGFyZ2V0L2hleGFnb24vUkVBRE1FICAgICAgICAgICAgICAgICAgIHwgIDExICstCiB0YXJn
ZXQvaGV4YWdvbi9hdHRyaWJzX2RlZi5oLmluYyAgICAgICAgfCAgIDMgKy0KIHRhcmdldC9oZXhh
Z29uL2RlY29kZS5jICAgICAgICAgICAgICAgICB8ICA0OCArLS0tLS0tLQogdGFyZ2V0L2hleGFn
b24vZ2VuX2FuYWx5emVfZnVuY3MucHkgICAgIHwgIDcwICsrKysrKy0tLS0tLQogdGFyZ2V0L2hl
eGFnb24vZ2VuX2hlbHBlcl9mdW5jcy5weSAgICAgIHwgIDIxICstLS0KIHRhcmdldC9oZXhhZ29u
L2dlbl9oZWxwZXJfcHJvdG9zLnB5ICAgICB8ICAzMSArKy0tLS0KIHRhcmdldC9oZXhhZ29uL2dl
bl9pZGVmX3BhcnNlcl9mdW5jcy5weSB8ICAgNSArLQogdGFyZ2V0L2hleGFnb24vZ2VuX29wX2F0
dHJpYnMucHkgICAgICAgIHwgICA1ICstCiB0YXJnZXQvaGV4YWdvbi9nZW5fb3BfcmVncy5weSAg
ICAgICAgICAgfCAxMjUgLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5f
b3Bjb2Rlc19kZWYucHkgICAgICAgfCAgIDQgKy0KIHRhcmdldC9oZXhhZ29uL2dlbl9wcmludGlu
c24ucHkgICAgICAgICB8ICAgNSArLQogdGFyZ2V0L2hleGFnb24vZ2VuX3Nob3J0Y29kZS5weSAg
ICAgICAgIHwgIDYzIC0tLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9nZW5fdGNnLmggICAgICAg
ICAgICAgICAgfCAgIDUgKy0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2dfZnVuY190YWJsZS5weSAg
ICB8ICAgNSArLQogdGFyZ2V0L2hleGFnb24vZ2VuX3RjZ19mdW5jcy5weSAgICAgICAgIHwgIDIx
ICstLS0KIHRhcmdldC9oZXhhZ29uL2dlbl90cmFuc19mdW5jcy5weSAgICAgICB8ICAyNiArKysr
LQogdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSAgICAgICAgICAgIHwgMTg5ICsrKysrKysr
KysrKysrKysrKysrKystLS0tLS0tLS0tCiB0YXJnZXQvaGV4YWdvbi9pbnNuLmggICAgICAgICAg
ICAgICAgICAgfCAgIDUgKy0KIHRhcmdldC9oZXhhZ29uL21hY3Jvcy5oICAgICAgICAgICAgICAg
ICB8ICAgNiArLQogdGFyZ2V0L2hleGFnb24vbWVzb24uYnVpbGQgICAgICAgICAgICAgIHwgIDU1
ICsrKy0tLS0tLS0KIHRhcmdldC9oZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMuYyB8ICAz
MCArKy0tLQogdGFyZ2V0L2hleGFnb24vb3Bjb2Rlcy5jICAgICAgICAgICAgICAgIHwgIDM1IC0t
LS0tLQogdGFyZ2V0L2hleGFnb24vb3Bjb2Rlcy5oICAgICAgICAgICAgICAgIHwgICA0IC0KIHRh
cmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jICAgICAgICAgICAgICB8ICA3NyArKy0tLS0tLS0tLS0t
CiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCAgICAgICAgICAgICAgfCAxMTkgKysrKysrKysr
KysrKysrKy0tLS0KIHRlc3RzL3RjZy9oZXhhZ29uL2h2eF9taXNjLmMgICAgICAgICAgICB8ICAx
NiArKy0KIDI2IGZpbGVzIGNoYW5nZWQsIDM3NCBpbnNlcnRpb25zKCspLCA2MTAgZGVsZXRpb25z
KC0pCiBkZWxldGUgbW9kZSAxMDA3NTUgdGFyZ2V0L2hleGFnb24vZ2VuX29wX3JlZ3MucHkKIGRl
bGV0ZSBtb2RlIDEwMDc1NSB0YXJnZXQvaGV4YWdvbi9nZW5fc2hvcnRjb2RlLnB5Cg==

