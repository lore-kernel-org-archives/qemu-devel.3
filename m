Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94451C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJn-0000eM-N8; Sun, 05 May 2024 22:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJl-0000da-Vq
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:43:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJj-0007X7-Vs
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:43:05 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4462P10C018844;
 Mon, 6 May 2024 02:42:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=i+K7SQbnEieqAjQCPgOu+mISG9Rz6wC6U6KPRoQm58s=; b=o9
 btj3NF8InPgmQ0ZnwTuI+JnOfpcnf2W1cb/uEd77f51wdY3QlPDx6thlxfLDPe/n
 3BEfEnjD7wT+YXnFfYPbnLEvnCONh/GbfrjLzAoUbtk2HxCqcebOG8ogg00poEO8
 7R/qrQ53vhdCoEOAaak+BHEVw9Gr9nOhWJrWplcBTSf99s1xnO3eCutCvAOBXTD2
 pB6IXr1A9qHrPEzwXA+eaR4AzaUP1lQ9Lg15m9rl6vxCfbqbU1/4TTUqeNefD7Pv
 sRwOk7WZ5ukircDXYQdONCjEA7WKXQk+sFhPjKoAICQEEzmhDJ5G8/2k3dWaFrqZ
 U3BtT7QVYfy3SjNZMW8Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwd3yafaq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 02:42:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4462gocQ007728
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 6 May 2024 02:42:50 GMT
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
Subject: [PULL 09/15] Hexagon (target/hexagon) Mark dest_idx in trans functions
Date: Sun, 5 May 2024 19:42:21 -0700
Message-ID: <20240506024227.3345791-10-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: wpn_gMCstbfnqXkhWGgjb3C3cYPiF5qJ
X-Proofpoint-GUID: wpn_gMCstbfnqXkhWGgjb3C3cYPiF5qJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=572 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCkNoZWNrIHRo
YXQgdGhlIHZhbHVlIG1hdGNoZXMgb3Bjb2RlX3JlZ2luZm8vb3Bjb2RlX3dyZWdzCgpTaWduZWQt
b2ZmLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpSZXZpZXdl
ZC1ieTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Ck1lc3NhZ2UtSWQ6IDwyMDI0MDMw
NzAzMjMyNy40Nzk5LTQtbHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBC
cmlhbiBDYWluIDxiY2FpbkBxdWljaW5jLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9kZWNvZGUu
YyAgICAgICAgICAgICAgICAgfCAyICsrCiB0YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3Mu
cHkgICAgICAgfCA2ICsrKysrKwogdGFyZ2V0L2hleGFnb24vaW5zbi5oICAgICAgICAgICAgICAg
ICAgIHwgMSArCiB0YXJnZXQvaGV4YWdvbi9tbXZlYy9kZWNvZGVfZXh0X21tdmVjLmMgfCAyICsr
CiA0IGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQv
aGV4YWdvbi9kZWNvZGUuYyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCmluZGV4IDQ1OTVlMzAz
ODQuLmE0ZDg1MDBmZWEgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCisrKyBi
L3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCkBAIC0xODQsNiArMTg0LDggQEAgZGVjb2RlX2ZpbGxf
bmV3dmFsdWVfcmVnbm8oUGFja2V0ICpwYWNrZXQpCiAKICAgICAgICAgICAgIC8qIE5vdyBwYXRj
aCB1cCB0aGUgY29uc3VtZXIgd2l0aCB0aGUgcmVnaXN0ZXIgbnVtYmVyICovCiAgICAgICAgICAg
ICBkc3RfaWR4ID0gZHN0c3RyIC0gb3Bjb2RlX3JlZ2luZm9bZGVmX29wY29kZV07CisgICAgICAg
ICAgICBnX2Fzc2VydChwYWNrZXQtPmluc25bZGVmX2lkeF0uZGVzdF9pZHggIT0gLTEgJiYKKyAg
ICAgICAgICAgICAgICAgICAgIHBhY2tldC0+aW5zbltkZWZfaWR4XS5kZXN0X2lkeCA9PSBkc3Rf
aWR4KTsKICAgICAgICAgICAgIHBhY2tldC0+aW5zbltpXS5yZWdub1t1c2VfcmVnaWR4XSA9CiAg
ICAgICAgICAgICAgICAgcGFja2V0LT5pbnNuW2RlZl9pZHhdLnJlZ25vW2RzdF9pZHhdOwogICAg
ICAgICAgICAgLyoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2dlbl90cmFuc19mdW5jcy5w
eSBiL3RhcmdldC9oZXhhZ29uL2dlbl90cmFuc19mdW5jcy5weQppbmRleCA4YWNlY2RiOTkzLi4x
MjAxMTcyZGRhIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3MucHkK
KysrIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5CkBAIC02OSw2ICs2OSw3IEBA
IGRlZiBtYXJrX3doaWNoX2ltbV9leHRlbmRlZChmLCB0YWcpOgogIyMgICAgICAgICBpbnNuLT5y
ZWdub1sxXSA9IGFyZ3MtPlJzOwogIyMgICAgICAgICBpbnNuLT5yZWdub1syXSA9IGFyZ3MtPlJ0
OwogIyMgICAgICAgICBpbnNuLT5uZXdfcmVhZF9pZHggPSAtMTsKKyMjICAgICAgICAgaW5zbi0+
ZGVzdF9pZHggPSAwOwogIyMgICAgICAgICByZXR1cm4gdHJ1ZTsKICMjICAgICB9CiAjIwpAQCAt
ODYsNiArODcsNyBAQCBkZWYgZ2VuX3RyYW5zX2Z1bmNzKGYpOgogICAgICAgICAiIiIpKQogCiAg
ICAgICAgIG5ld19yZWFkX2lkeCA9IC0xCisgICAgICAgIGRlc3RfaWR4ID0gLTEKICAgICAgICAg
Zm9yIHJlZ25vLCAocmVnX3R5cGUsIHJlZ19pZCwgKl8pIGluIGVudW1lcmF0ZShyZWdzKToKICAg
ICAgICAgICAgIHJlZyA9IGhleF9jb21tb24uZ2V0X3JlZ2lzdGVyKHRhZywgcmVnX3R5cGUsIHJl
Z19pZCkKICAgICAgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKQEAgLTkzLDYgKzk1LDkg
QEAgZGVmIGdlbl90cmFuc19mdW5jcyhmKToKICAgICAgICAgICAgICIiIikpCiAgICAgICAgICAg
ICBpZiByZWcuaXNfcmVhZCgpIGFuZCByZWcuaXNfbmV3KCk6CiAgICAgICAgICAgICAgICAgbmV3
X3JlYWRfaWR4ID0gcmVnbm8KKyAgICAgICAgICAgICMgZGVzdF9pZHggc2hvdWxkIGJlIHRoZSBm
aXJzdCBkZXN0aW5hdGlvbiwgc28gY2hlY2sgZm9yIC0xCisgICAgICAgICAgICBpZiByZWcuaXNf
d3JpdHRlbigpIGFuZCBkZXN0X2lkeCA9PSAtMToKKyAgICAgICAgICAgICAgICBkZXN0X2lkeCA9
IHJlZ25vCiAKICAgICAgICAgaWYgbGVuKGltbXMpICE9IDA6CiAgICAgICAgICAgICBtYXJrX3do
aWNoX2ltbV9leHRlbmRlZChmLCB0YWcpCkBAIC0xMTUsNiArMTIwLDcgQEAgZGVmIGdlbl90cmFu
c19mdW5jcyhmKToKIAogICAgICAgICBmLndyaXRlKGNvZGVfZm10KGYiIiJcCiAgICAgICAgICAg
ICBpbnNuLT5uZXdfcmVhZF9pZHggPSB7bmV3X3JlYWRfaWR4fTsKKyAgICAgICAgICAgIGluc24t
PmRlc3RfaWR4ID0ge2Rlc3RfaWR4fTsKICAgICAgICAgIiIiKSkKICAgICAgICAgZi53cml0ZSh0
ZXh0d3JhcC5kZWRlbnQoZiIiIlwKICAgICAgICAgICAgICAgICByZXR1cm4gdHJ1ZTsKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL2luc24uaCBiL3RhcmdldC9oZXhhZ29uL2luc24uaAppbmRl
eCAzNjUwMmJmMDU2Li5hNzcwMzc5OTU4IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbnNu
LmgKKysrIGIvdGFyZ2V0L2hleGFnb24vaW5zbi5oCkBAIC00MCw2ICs0MCw3IEBAIHN0cnVjdCBJ
bnN0cnVjdGlvbiB7CiAgICAgdWludDMyX3Qgd2hpY2hfZXh0ZW5kZWQ6MTsgICAgLyogSWYgaGFz
IGFuIGV4dGVuZGVyLCB3aGljaCBpbW1lZGlhdGUgKi8KICAgICB1aW50MzJfdCBuZXdfdmFsdWVf
cHJvZHVjZXJfc2xvdDo0OwogICAgIGludDMyX3QgbmV3X3JlYWRfaWR4OworICAgIGludDMyX3Qg
ZGVzdF9pZHg7CiAKICAgICBib29sIHBhcnQxOyAgICAgICAgICAgICAgLyoKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICogY21wLWp1bXBzIGFyZSBzcGxpdCBpbnRvIHR3byBpbnNucy4K
ZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMuYyBiL3Rh
cmdldC9oZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMuYwppbmRleCBlOTAwN2Y1ZDcxLi5j
MTMyMDQwNmRmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9tbXZlYy9kZWNvZGVfZXh0X21t
dmVjLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vbW12ZWMvZGVjb2RlX2V4dF9tbXZlYy5jCkBAIC04
Niw2ICs4Niw4IEBAIGNoZWNrX25ld192YWx1ZShQYWNrZXQgKnBrdCkKICAgICAgICAgICAgICAg
ICAgICAgLyogc3RpbGwgbm90IHRoZXJlLCB3ZSBoYXZlIGEgYmFkIHBhY2tldCAqLwogICAgICAg
ICAgICAgICAgICAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOwogICAgICAgICAgICAgICAgIH0K
KyAgICAgICAgICAgICAgICBnX2Fzc2VydChwa3QtPmluc25bZGVmX2lkeF0uZGVzdF9pZHggIT0g
LTEgJiYKKyAgICAgICAgICAgICAgICAgICAgICAgICBwa3QtPmluc25bZGVmX2lkeF0uZGVzdF9p
ZHggPT0gZHN0c3RyIC0gcmVnaW5mbyk7CiAgICAgICAgICAgICAgICAgaW50IGRlZl9yZWdudW0g
PSBwa3QtPmluc25bZGVmX2lkeF0ucmVnbm9bZHN0c3RyIC0gcmVnaW5mb107CiAgICAgICAgICAg
ICAgICAgLyogTm93IHBhdGNoIHVwIHRoZSBjb25zdW1lciB3aXRoIHRoZSByZWdpc3RlciBudW1i
ZXIgKi8KICAgICAgICAgICAgICAgICBwa3QtPmluc25baV0ucmVnbm9bdXNlX3JlZ2lkeF0gPSBk
ZWZfcmVnbnVtIF4gZGVmX29yZWc7Ci0tIAoyLjI1LjEKCg==

