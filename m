Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976C7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 02:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3oJh-0000Ze-0O; Sun, 05 May 2024 22:43:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJc-0000Wi-ON
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1s3oJZ-0007X5-9K
 for qemu-devel@nongnu.org; Sun, 05 May 2024 22:42:56 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4462O4ja017170;
 Mon, 6 May 2024 02:42:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-type:content-transfer-encoding; s=
 qcppdkim1; bh=/qlw2Exdr5gIEqiWCXd2tV4j+ovhDuZuczeNXenVSKU=; b=nb
 uClz1FJBrea+79ImuQVLfT42Bs0WgejqFeviC7kQ3C77Nz5sshBXmgW5jOj7cNZ0
 uzCDCEuxBZxLto41+SZDRm34nmvoFeVIkKjZghf5K0jEIgjbWM6eLAqk05arHIYH
 6CR9z4YzFj3GWvUC7aaFHf4uW0JdWJsuZv/NhBmAXiJ0utBP257fdpmb04XdPkbf
 oIQNYvO9QGOMW6ViFQtiojcgaF86uM/zU7OvE1vMz41XfpXmsfIvnJBuJAT5d6DC
 GT6Q77O94qv1LaF8CT9/G2df6LxhgUrb5foTbH04ZgBfyJ5C7aYO04WA9LxA5t7Y
 c7vTUB7Irhnk0QfY+W7g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xwd3yafan-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 May 2024 02:42:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4462goFA011029
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
Subject: [PULL 08/15] Hexagon (target/hexagon) Mark new_read_idx in trans
 functions
Date: Sun, 5 May 2024 19:42:20 -0700
Message-ID: <20240506024227.3345791-9-bcain@quicinc.com>
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
X-Proofpoint-ORIG-GUID: S0xfpNQPNeZZlL5JYfHbog97piDSm-58
X-Proofpoint-GUID: S0xfpNQPNeZZlL5JYfHbog97piDSm-58
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-05_17,2024-05-03_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 mlxlogscore=557 adultscore=0 clxscore=1015
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
YXQgdGhlIHZhbHVlIG1hdGNoZXMgb3Bjb2RlX3JlZ2luZm8KClNpZ25lZC1vZmYtYnk6IFRheWxv
ciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBCcmlhbiBD
YWluIDxiY2FpbkBxdWljaW5jLmNvbT4KTWVzc2FnZS1JZDogPDIwMjQwMzA3MDMyMzI3LjQ3OTkt
My1sdGF5bG9yc2ltcHNvbkBnbWFpbC5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJj
YWluQHF1aWNpbmMuY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2RlY29kZS5jICAgICAgICAgICAg
ICAgICB8ICAyICsrCiB0YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3MucHkgICAgICAgfCAx
NSArKysrKysrKysrLS0tLS0KIHRhcmdldC9oZXhhZ29uL2luc24uaCAgICAgICAgICAgICAgICAg
ICB8ICAzICsrLQogdGFyZ2V0L2hleGFnb24vbW12ZWMvZGVjb2RlX2V4dF9tbXZlYy5jIHwgIDIg
KysKIDQgZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9kZWNvZGUuYyBiL3RhcmdldC9oZXhhZ29uL2RlY29k
ZS5jCmluZGV4IGE0MDIxMGNhMWUuLjQ1OTVlMzAzODQgMTAwNjQ0Ci0tLSBhL3RhcmdldC9oZXhh
Z29uL2RlY29kZS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2RlY29kZS5jCkBAIC0xMzEsNiArMTMx
LDggQEAgZGVjb2RlX2ZpbGxfbmV3dmFsdWVfcmVnbm8oUGFja2V0ICpwYWNrZXQpCiAgICAgICAg
ICAgICAgICAgdXNlX3JlZ2lkeCA9IHN0cmNocihvcGNvZGVfcmVnaW5mb1t1c2Vfb3Bjb2RlXSwg
J3MnKSAtCiAgICAgICAgICAgICAgICAgICAgIG9wY29kZV9yZWdpbmZvW3VzZV9vcGNvZGVdOwog
ICAgICAgICAgICAgfQorICAgICAgICAgICAgZ19hc3NlcnQocGFja2V0LT5pbnNuW2ldLm5ld19y
ZWFkX2lkeCAhPSAtMSAmJgorICAgICAgICAgICAgICAgICAgICAgcGFja2V0LT5pbnNuW2ldLm5l
d19yZWFkX2lkeCA9PSB1c2VfcmVnaWR4KTsKIAogICAgICAgICAgICAgLyoKICAgICAgICAgICAg
ICAqIFdoYXQncyBlbmNvZGVkIGF0IHRoZSBOLWZpZWxkIGlzIHRoZSBvZmZzZXQgdG8gd2hvJ3Mg
cHJvZHVjaW5nCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3MucHkg
Yi90YXJnZXQvaGV4YWdvbi9nZW5fdHJhbnNfZnVuY3MucHkKaW5kZXggNTNlODQ0YTQ0Yi4uOGFj
ZWNkYjk5MyAxMDA3NTUKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RyYW5zX2Z1bmNzLnB5Cisr
KyBiL3RhcmdldC9oZXhhZ29uL2dlbl90cmFuc19mdW5jcy5weQpAQCAtNjgsNiArNjgsNyBAQCBk
ZWYgbWFya193aGljaF9pbW1fZXh0ZW5kZWQoZiwgdGFnKToKICMjICAgICAgICAgaW5zbi0+cmVn
bm9bMF0gPSBhcmdzLT5SZDsKICMjICAgICAgICAgaW5zbi0+cmVnbm9bMV0gPSBhcmdzLT5SczsK
ICMjICAgICAgICAgaW5zbi0+cmVnbm9bMl0gPSBhcmdzLT5SdDsKKyMjICAgICAgICAgaW5zbi0+
bmV3X3JlYWRfaWR4ID0gLTE7CiAjIyAgICAgICAgIHJldHVybiB0cnVlOwogIyMgICAgIH0KICMj
CkBAIC04NCwxNCArODUsMTQgQEAgZGVmIGdlbl90cmFuc19mdW5jcyhmKToKICAgICAgICAgICAg
ICAgICBpbnNuLT5vcGNvZGUgPSB7dGFnfTsKICAgICAgICAgIiIiKSkKIAotICAgICAgICByZWdu
byA9IDAKLSAgICAgICAgZm9yIHJlZyBpbiByZWdzOgotICAgICAgICAgICAgcmVnX3R5cGUgPSBy
ZWdbMF0KLSAgICAgICAgICAgIHJlZ19pZCA9IHJlZ1sxXQorICAgICAgICBuZXdfcmVhZF9pZHgg
PSAtMQorICAgICAgICBmb3IgcmVnbm8sIChyZWdfdHlwZSwgcmVnX2lkLCAqXykgaW4gZW51bWVy
YXRlKHJlZ3MpOgorICAgICAgICAgICAgcmVnID0gaGV4X2NvbW1vbi5nZXRfcmVnaXN0ZXIodGFn
LCByZWdfdHlwZSwgcmVnX2lkKQogICAgICAgICAgICAgZi53cml0ZShjb2RlX2ZtdChmIiIiXAog
ICAgICAgICAgICAgICAgIGluc24tPnJlZ25vW3tyZWdub31dID0gYXJncy0+e3JlZ190eXBlfXty
ZWdfaWR9OwogICAgICAgICAgICAgIiIiKSkKLSAgICAgICAgICAgIHJlZ25vICs9IDEKKyAgICAg
ICAgICAgIGlmIHJlZy5pc19yZWFkKCkgYW5kIHJlZy5pc19uZXcoKToKKyAgICAgICAgICAgICAg
ICBuZXdfcmVhZF9pZHggPSByZWdubwogCiAgICAgICAgIGlmIGxlbihpbW1zKSAhPSAwOgogICAg
ICAgICAgICAgbWFya193aGljaF9pbW1fZXh0ZW5kZWQoZiwgdGFnKQpAQCAtMTEyLDYgKzExMyw5
IEBAIGRlZiBnZW5fdHJhbnNfZnVuY3MoZik6CiAgICAgICAgICAgICAgICAgICAgIGluc24tPmlt
bWVkW3tpbW1ub31dID0gYXJncy0+e2ltbV90eXBlfXtpbW1fbGV0dGVyfTsKICAgICAgICAgICAg
ICAgICAiIiIpKQogCisgICAgICAgIGYud3JpdGUoY29kZV9mbXQoZiIiIlwKKyAgICAgICAgICAg
IGluc24tPm5ld19yZWFkX2lkeCA9IHtuZXdfcmVhZF9pZHh9OworICAgICAgICAiIiIpKQogICAg
ICAgICBmLndyaXRlKHRleHR3cmFwLmRlZGVudChmIiIiXAogICAgICAgICAgICAgICAgIHJldHVy
biB0cnVlOwogICAgICAgICAgICAge2Nsb3NlX2N1cmx5fQpAQCAtMTIwLDUgKzEyNCw2IEBAIGRl
ZiBnZW5fdHJhbnNfZnVuY3MoZik6CiAKIGlmIF9fbmFtZV9fID09ICJfX21haW5fXyI6CiAgICAg
aGV4X2NvbW1vbi5yZWFkX3NlbWFudGljc19maWxlKHN5cy5hcmd2WzFdKQorICAgIGhleF9jb21t
b24uaW5pdF9yZWdpc3RlcnMoKQogICAgIHdpdGggb3BlbihzeXMuYXJndlsyXSwgInciKSBhcyBm
OgogICAgICAgICBnZW5fdHJhbnNfZnVuY3MoZikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29u
L2luc24uaCBiL3RhcmdldC9oZXhhZ29uL2luc24uaAppbmRleCAzZTdhMjJjOTFlLi4zNjUwMmJm
MDU2IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9pbnNuLmgKKysrIGIvdGFyZ2V0L2hleGFn
b24vaW5zbi5oCkBAIC0xLDUgKzEsNSBAQAogLyoKLSAqICBDb3B5cmlnaHQoYykgMjAxOS0yMDIy
IFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCisg
KiAgQ29weXJpZ2h0KGMpIDIwMTktMjAyNCBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5j
LiBBbGwgUmlnaHRzIFJlc2VydmVkLgogICoKICAqICBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0
d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1vZGlmeQogICogIGl0IHVuZGVy
IHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVk
IGJ5CkBAIC0zOSw2ICszOSw3IEBAIHN0cnVjdCBJbnN0cnVjdGlvbiB7CiAgICAgdWludDMyX3Qg
c2xvdDozOwogICAgIHVpbnQzMl90IHdoaWNoX2V4dGVuZGVkOjE7ICAgIC8qIElmIGhhcyBhbiBl
eHRlbmRlciwgd2hpY2ggaW1tZWRpYXRlICovCiAgICAgdWludDMyX3QgbmV3X3ZhbHVlX3Byb2R1
Y2VyX3Nsb3Q6NDsKKyAgICBpbnQzMl90IG5ld19yZWFkX2lkeDsKIAogICAgIGJvb2wgcGFydDE7
ICAgICAgICAgICAgICAvKgogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBjbXAtanVt
cHMgYXJlIHNwbGl0IGludG8gdHdvIGluc25zLgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24v
bW12ZWMvZGVjb2RlX2V4dF9tbXZlYy5jIGIvdGFyZ2V0L2hleGFnb24vbW12ZWMvZGVjb2RlX2V4
dF9tbXZlYy5jCmluZGV4IDIwMmQ4NGM3YzAuLmU5MDA3ZjVkNzEgMTAwNjQ0Ci0tLSBhL3Rhcmdl
dC9oZXhhZ29uL21tdmVjL2RlY29kZV9leHRfbW12ZWMuYworKysgYi90YXJnZXQvaGV4YWdvbi9t
bXZlYy9kZWNvZGVfZXh0X21tdmVjLmMKQEAgLTQxLDYgKzQxLDggQEAgY2hlY2tfbmV3X3ZhbHVl
KFBhY2tldCAqcGt0KQogICAgICAgICAgICAgR0VUX0FUVFJJQih1c2Vfb3Bjb2RlLCBBX1NUT1JF
KSkgewogICAgICAgICAgICAgaW50IHVzZV9yZWdpZHggPSBzdHJjaHIob3Bjb2RlX3JlZ2luZm9b
dXNlX29wY29kZV0sICdzJykgLQogICAgICAgICAgICAgICAgIG9wY29kZV9yZWdpbmZvW3VzZV9v
cGNvZGVdOworICAgICAgICAgICAgZ19hc3NlcnQocGt0LT5pbnNuW2ldLm5ld19yZWFkX2lkeCAh
PSAtMSAmJgorICAgICAgICAgICAgICAgICAgICAgcGt0LT5pbnNuW2ldLm5ld19yZWFkX2lkeCA9
PSB1c2VfcmVnaWR4KTsKICAgICAgICAgICAgIC8qCiAgICAgICAgICAgICAgKiBXaGF0J3MgZW5j
b2RlZCBhdCB0aGUgTi1maWVsZCBpcyB0aGUgb2Zmc2V0IHRvIHdobydzIHByb2R1Y2luZwogICAg
ICAgICAgICAgICogdGhlIHZhbHVlLgotLSAKMi4yNS4xCgo=

