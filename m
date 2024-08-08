Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7560C52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 03:44:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbu3m-0008U2-VX; Wed, 07 Aug 2024 23:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3l-0008M2-3q
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bcain@quicinc.com>) id 1sbu3j-0006io-An
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 23:43:28 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477IOm64007179;
 Thu, 8 Aug 2024 03:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 knwdgsDYfcvowLQKonLL9ba/DKIZx5Uz9KJ1ezP4D2c=; b=jwMmNEkX4YHTi9fd
 MsAYqqZbpodfF46LHi/viy/l35MIBHUlZ4HEy1Grr9108r/8pQoybNIEfJntWOAE
 g6+3mHvWifGQgLBWtBIW3a154NHvxZyKmjadzNgYdv47m744G6/PswKHyvRrtasf
 ESdK7Pm1gQG37CgOynQHGcFkK5+WIAXucsv0Px5W6ofqDwdO9oWfKLmqz4OaX3I6
 gv8nkfmQVFxk5VVg9VKsftpHimlqLNEtKyeETV7VV1TJwpebSecB6raubSgYCeNH
 OKP+FisVwWu1U+uPghwJ9OYjOo7AJlqaWAGJzWBfCb3HoS9QgOOJWZnxvBHH5GfT
 iARVwg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40scx6vq08-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Aug 2024 03:43:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com
 [10.47.209.196])
 by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id
 4783hKlY000618
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 8 Aug 2024 03:43:20 GMT
Received: from hu-bcain-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 7 Aug 2024 20:43:20 -0700
From: Brian Cain <bcain@quicinc.com>
To: <qemu-devel@nongnu.org>
CC: <bcain@quicinc.com>, <philmd@linaro.org>, <peter.maydell@linaro.org>,
 <quic_mathbern@quicinc.com>, <ale@rev.ng>, <anjo@rev.ng>,
 <quic_mliebel@quicinc.com>, <ltaylorsimpson@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/6] Hexagon: lldb read/write predicate registers p0/p1/p2/p3
Date: Wed, 7 Aug 2024 20:42:40 -0700
Message-ID: <20240808034244.4139757-3-bcain@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240808034244.4139757-1-bcain@quicinc.com>
References: <20240808034244.4139757-1-bcain@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800
 signatures=585085
X-Proofpoint-ORIG-GUID: 4Qb_wsRdJoFJ4ZjaulEaS0VyHUUapOjO
X-Proofpoint-GUID: 4Qb_wsRdJoFJ4ZjaulEaS0VyHUUapOjO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-08_03,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 phishscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408080024
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

RnJvbTogVGF5bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KCmhleGFnb24t
Y29yZS54bWwgb25seSBleHBvc2VzIHJlZ2lzdGVyIHAzXzAgd2hpY2ggaXMgYW4gYWxpYXMgdGhh
dAphZ2dyZWdhdGVzIHRoZSBwcmVkaWNhdGUgcmVnaXN0ZXJzLiAgSXQgaXMgbW9yZSBjb252ZW5p
ZW50IGZvciB1c2Vycwp0byBpbnRlcmFjdCBkaXJlY3RseSB3aXRoIHRoZSBwcmVkaWNhdGUgcmVn
aXN0ZXJzLgoKVGVzdGVkIHdpdGggbGxkYiBkb3dubG9hZGVkIGZyb20gdGhpcyBsb2NhdGlvbgpo
dHRwczovL2dpdGh1Yi5jb20vbGx2bS9sbHZtLXByb2plY3QvcmVsZWFzZXMvZG93bmxvYWQvbGx2
bW9yZy0xOC4xLjQvY2xhbmcrbGx2bS0xOC4xLjQteDg2XzY0LWxpbnV4LWdudS11YnVudHUtMTgu
MDQudGFyLnh6CgpCRUZPUkU6CihsbGRiKSByZWcgcmVhZCBwM18wCiAgICBwM18wID0gMHgwMDAw
MDAwMAoobGxkYikgcmVnIHJlYWQgcDAKZXJyb3I6IEludmFsaWQgcmVnaXN0ZXIgbmFtZSAncDAn
LgoobGxkYikgcmVnIHdyaXRlIHAxIDB4ZgplcnJvcjogUmVnaXN0ZXIgbm90IGZvdW5kIGZvciAn
cDEnLgoKQUZURVI6CihsbGRiKSByZWcgcmVhZCBwM18wCiAgICBwM18wID0gMHgwMDAwMDAwMAoo
bGxkYikgcmVnIHJlYWQgcDAKICAgICAgcDAgPSAweDAwCihsbGRiKSByZWcgcmVhZCAtcyAxClBy
ZWRpY2F0ZSBSZWdpc3RlcnM6CiAgICAgICAgcDAgPSAweDAwCiAgICAgICAgcDEgPSAweDAwCiAg
ICAgICAgcDIgPSAweDAwCiAgICAgICAgcDMgPSAweDAwCgoobGxkYikgcmVnIHdyaXRlIHAxIDB4
ZgoobGxkYikgcmVnIHJlYWQgcDNfMAogICAgcDNfMCA9IDB4MDAwMDBmMDAKKGxsZGIpIHJlZyB3
cml0ZSBwM18wIDB4ZmYwMGZmMDAKKGxsZGIpIHJlZyByZWFkIC1zIDEKUHJlZGljYXRlIFJlZ2lz
dGVyczoKICAgICAgICBwMCA9IDB4MDAKICAgICAgICBwMSA9IDB4ZmYKICAgICAgICBwMiA9IDB4
MDAKICAgICAgICBwMyA9IDB4ZmYKClNpZ25lZC1vZmYtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5
bG9yc2ltcHNvbkBnbWFpbC5jb20+ClJldmlld2VkLWJ5OiBCcmlhbiBDYWluIDxiY2FpbkBxdWlj
aW5jLmNvbT4KUmV2aWV3ZWQtYnk6IE1hdGhldXMgVGF2YXJlcyBCZXJuYXJkaW5vIDxxdWljX21h
dGhiZXJuQHF1aWNpbmMuY29tPgpNZXNzYWdlLUlkOiA8MjAyNDA2MTMxODIyMDkuMTQwMDgyLTEt
bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxiY2Fp
bkBxdWljaW5jLmNvbT4KLS0tCiBnZGIteG1sL2hleGFnb24tY29yZS54bWwgfCAgNiArKysrKy0K
IHRhcmdldC9oZXhhZ29uL2dkYnN0dWIuYyB8IDE5ICsrKysrKysrKysrKysrKysrKy0KIDIgZmls
ZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9nZGIteG1sL2hleGFnb24tY29yZS54bWwgYi9nZGIteG1sL2hleGFnb24tY29yZS54bWwKaW5k
ZXggZTE4MTE2M2NmZi4uYjk0Mzc4MTEyYSAxMDA2NDQKLS0tIGEvZ2RiLXhtbC9oZXhhZ29uLWNv
cmUueG1sCisrKyBiL2dkYi14bWwvaGV4YWdvbi1jb3JlLnhtbApAQCAtMSw2ICsxLDYgQEAKIDw/
eG1sIHZlcnNpb249IjEuMCI/PgogPCEtLQotICBDb3B5cmlnaHQoYykgMjAyMyBRdWFsY29tbSBJ
bm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmlnaHRzIFJlc2VydmVkLgorICBDb3B5cmlnaHQo
YykgMjAyMy0yMDI0IFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIEFsbCBSaWdodHMg
UmVzZXJ2ZWQuCiAKICAgVGhpcyB3b3JrIGlzIGxpY2Vuc2VkIHVuZGVyIHRoZSB0ZXJtcyBvZiB0
aGUgR05VIEdQTCwgdmVyc2lvbiAyIG9yCiAgIChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZl
cnNpb24uIFNlZSB0aGUgQ09QWUlORyBmaWxlIGluIHRoZQpAQCAtODAsNSArODAsOSBAQAogICA8
cmVnIG5hbWU9ImMyOSIgICAgICAgICAgICAgIGJpdHNpemU9IjMyIiBvZmZzZXQ9IjI0NCIgZW5j
b2Rpbmc9InVpbnQiIGZvcm1hdD0iaGV4IiBncm91cD0iVGhyZWFkIFJlZ2lzdGVycyIgZHdhcmZf
cmVnbnVtPSI2MSIvPgogICA8cmVnIG5hbWU9InV0aW1lcmxvIiAgICAgICAgIGJpdHNpemU9IjMy
IiBvZmZzZXQ9IjI0OCIgZW5jb2Rpbmc9InVpbnQiIGZvcm1hdD0iaGV4IiBncm91cD0iVGhyZWFk
IFJlZ2lzdGVycyIgZHdhcmZfcmVnbnVtPSI2MiIvPgogICA8cmVnIG5hbWU9InV0aW1lcmhpIiAg
ICAgICAgIGJpdHNpemU9IjMyIiBvZmZzZXQ9IjI1MiIgZW5jb2Rpbmc9InVpbnQiIGZvcm1hdD0i
aGV4IiBncm91cD0iVGhyZWFkIFJlZ2lzdGVycyIgZHdhcmZfcmVnbnVtPSI2MyIvPgorICA8cmVn
IG5hbWU9InAwIiAgICAgICAgICAgICAgIGJpdHNpemU9IjgiICBvZmZzZXQ9IjI1NiIgZW5jb2Rp
bmc9InVpbnQiIGZvcm1hdD0iaGV4IiBncm91cD0iUHJlZGljYXRlIFJlZ2lzdGVycyIgZHdhcmZf
cmVnbnVtPSI2NCIvPgorICA8cmVnIG5hbWU9InAxIiAgICAgICAgICAgICAgIGJpdHNpemU9Ijgi
ICBvZmZzZXQ9IjI1NyIgZW5jb2Rpbmc9InVpbnQiIGZvcm1hdD0iaGV4IiBncm91cD0iUHJlZGlj
YXRlIFJlZ2lzdGVycyIgZHdhcmZfcmVnbnVtPSI2NSIvPgorICA8cmVnIG5hbWU9InAyIiAgICAg
ICAgICAgICAgIGJpdHNpemU9IjgiICBvZmZzZXQ9IjI1OCIgZW5jb2Rpbmc9InVpbnQiIGZvcm1h
dD0iaGV4IiBncm91cD0iUHJlZGljYXRlIFJlZ2lzdGVycyIgZHdhcmZfcmVnbnVtPSI2NiIvPgor
ICA8cmVnIG5hbWU9InAzIiAgICAgICAgICAgICAgIGJpdHNpemU9IjgiICBvZmZzZXQ9IjI1OSIg
ZW5jb2Rpbmc9InVpbnQiIGZvcm1hdD0iaGV4IiBncm91cD0iUHJlZGljYXRlIFJlZ2lzdGVycyIg
ZHdhcmZfcmVnbnVtPSI2NyIvPgogCiA8L2ZlYXR1cmU+CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4
YWdvbi9nZGJzdHViLmMgYi90YXJnZXQvaGV4YWdvbi9nZGJzdHViLmMKaW5kZXggNTAyYzY5ODdm
MC4uOTRlMWRiOGVmOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2Ric3R1Yi5jCisrKyBi
L3RhcmdldC9oZXhhZ29uL2dkYnN0dWIuYwpAQCAtMSw1ICsxLDUgQEAKIC8qCi0gKiAgQ29weXJp
Z2h0KGMpIDIwMTktMjAyMSBRdWFsY29tbSBJbm5vdmF0aW9uIENlbnRlciwgSW5jLiBBbGwgUmln
aHRzIFJlc2VydmVkLgorICogIENvcHlyaWdodChjKSAyMDE5LTIwMjQgUXVhbGNvbW0gSW5ub3Zh
dGlvbiBDZW50ZXIsIEluYy4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KICAqCiAgKiAgVGhpcyBwcm9n
cmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2Rp
ZnkKICAqICBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNl
bnNlIGFzIHB1Ymxpc2hlZCBieQpAQCAtMzYsNiArMzYsMTQgQEAgaW50IGhleGFnb25fZ2RiX3Jl
YWRfcmVnaXN0ZXIoQ1BVU3RhdGUgKmNzLCBHQnl0ZUFycmF5ICptZW1fYnVmLCBpbnQgbikKICAg
ICAgICAgcmV0dXJuIGdkYl9nZXRfcmVnbChtZW1fYnVmLCBlbnYtPmdwcltuXSk7CiAgICAgfQog
CisgICAgbiAtPSBUT1RBTF9QRVJfVEhSRUFEX1JFR1M7CisKKyAgICBpZiAobiA8IE5VTV9QUkVH
UykgeworICAgICAgICByZXR1cm4gZ2RiX2dldF9yZWc4KG1lbV9idWYsIGVudi0+cHJlZFtuXSk7
CisgICAgfQorCisgICAgbiAtPSBOVU1fUFJFR1M7CisKICAgICBnX2Fzc2VydF9ub3RfcmVhY2hl
ZCgpOwogfQogCkBAIC01Niw2ICs2NCwxNSBAQCBpbnQgaGV4YWdvbl9nZGJfd3JpdGVfcmVnaXN0
ZXIoQ1BVU3RhdGUgKmNzLCB1aW50OF90ICptZW1fYnVmLCBpbnQgbikKICAgICAgICAgcmV0dXJu
IHNpemVvZih0YXJnZXRfdWxvbmcpOwogICAgIH0KIAorICAgIG4gLT0gVE9UQUxfUEVSX1RIUkVB
RF9SRUdTOworCisgICAgaWYgKG4gPCBOVU1fUFJFR1MpIHsKKyAgICAgICAgZW52LT5wcmVkW25d
ID0gbGR0dWxfcChtZW1fYnVmKSAmIDB4ZmY7CisgICAgICAgIHJldHVybiBzaXplb2YodWludDhf
dCk7CisgICAgfQorCisgICAgbiAtPSBOVU1fUFJFR1M7CisKICAgICBnX2Fzc2VydF9ub3RfcmVh
Y2hlZCgpOwogfQogCi0tIAoyLjM0LjEKCg==

