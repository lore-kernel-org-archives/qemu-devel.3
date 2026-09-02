Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D5DC624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 04:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1coy-0000i2-C7; Wed, 02 Sep 2026 00:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cow-0000fy-EB
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:34 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x1cou-0000Qh-Me
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 00:43:34 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681KTL0b3108772
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 04:43:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BXCn2/DAlW7fSNEp3PbSrMHkPZjLL4S2LpEYhBFGmRY=; b=civ8CBpbHHt3JeVO
 715Ohzqhpg6o8hk3K5wuVG4r8b7wjryPB0SDO0Bk3uIWIbMF2CDduPsX03LcMPuu
 TOINFhLbRLk1F70BlOxu7LWQ+zNZhn0gnYaj1hVlDgEPIaDo5adsaPOb+KwN64Ng
 bcMvBhNoEb/GyWXhFBDeMG5F8Xi0lehtl1SZj/W7KhC8dB5Ejs9H9Y/yipOL1JTA
 KLzvJRsnlDeKKC26Mk8djZgDDnW+v3Ajo2JnaNyNLp8+94EPo0aDjaMZzBQUGX8k
 9R7Nj9Ol4JfODWG19F47pWLaBMsa1eArYyaX5VWr+LTC8hUMp820veHhXO3BHDN5
 omINwQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge1wpan9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 04:43:21 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc1ca15334cso969778a12.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 21:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788324201; x=1788929001; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=BXCn2/DAlW7fSNEp3PbSrMHkPZjLL4S2LpEYhBFGmRY=;
 b=fMb/iTea5ho+d1LKjNTkFqg0ZC4x8gM11wj+kQlD0m2ULoD/ASuregC40n6Satr7dI
 2TkY5jLbdFAWsDdbe84koIWILLUcKK4TLgJPO5DLnCy+5wWGleAhqzqpAKNU5370wSDd
 fnEDhgr9hN7NFZrncLIFpRoo+yMnhTYdg43lj5m5JN7XD41e3asMdhtAXMg6Zi0QjlcS
 g6immO34mLRrfExPsHkXQHM3FhBUQg16ZG9DGcmFB2edkvhqquUBcyzOwFzltvgNbYYg
 RFUYNhc/ziz20oZCDgn069X5cBdaG/Z6gHcpr24QqssIEx08vkzDRoFBABxkKS0s7hrp
 7KNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788324201; x=1788929001;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BXCn2/DAlW7fSNEp3PbSrMHkPZjLL4S2LpEYhBFGmRY=;
 b=Uc4ADeruMq1BMgqXe/fQSWwp7awJb0tj2FjLGrGG8TQYdrSK1v61nLPZlwxoeuznGx
 xhOhF+AQt031Vf9AjkNjebrrhNfcbIf+V0KuQqDDaYM2MQMqJDlOVZuyMdasgGzBa+bf
 qiGZ7dQDij6GHEQrzAH7eE/q6EekCbHZSIZW0V1DyahjXL5TC+Pv34GVimdru/MMTZ6E
 An7zq+sIg99Gunqv/PBIE5Fpk+v3RrvbEv5M9rFNoy6+y3Ii1EZKt0oDzI7EZP3iLbmw
 n4jMyTrDT43touD8L8YYRYHT5iJIC9OKGHp58enY5zQQtkBCZLITB3ljEkVvekveRfmi
 B27g==
X-Gm-Message-State: AFuF++n16R5QDY88nlAvaJ+z7jzW65RSVKCtzWgnk64tWO6cSyQgyWiy
 NcO9FGrvCUozioobQcnnmZZltC28UYLzDVX+PeHUX/bMcRLvBzeT0R9gGoTW4zmTdsZrzfg3sca
 2fIjCZ8zoUfdgs85vwllfTRHSUAGec22XSmp6obHtTGwrb59eRda0LLdqdHnO6dxKEQ==
X-Gm-Gg: AYBFou0DV0RdCEIJ0qW1k6+YF9ZFajKHNe3zM9/kGdK2fILluWmZNrgCI3s+xYsy9CP
 E6ruErx8BpcBWaWMDBYGuRwOlKwWhfkQPUM3b+jBbBO3t0dR1jPAG01uYz/bZ9mjVtJr/gMPl48
 lO9dVU9mXJTGE9JKJ1sT69JqcyQ9vI9nj13D54PxoOrU4JpnQyGcfqKEVW9IzwRGgZBQJxwbVvb
 Bz3jdnIiBLlXK9M2Q83kvmoRJRqzXus/lTjCFIie4lRIBhbXH8IUelvlbVIsuE+3+c7BET0bK+P
 tw0fu9La8wX6Dd7iRRkF2yRSGgTLCLTyFMOWxLLjL+uRIe9VdpTwDa/SCOrKHSc3CEdYhKk7b1p
 prCOd3528RpcmDXiYglXgjsJSYRbbYpP8z8awbrpq+xPxfii2
X-Received: by 2002:a17:90b:3949:b0:398:9c00:29ee with SMTP id
 98e67ed59e1d1-39aee208a63mr3307734a91.22.1788324200636; 
 Tue, 01 Sep 2026 21:43:20 -0700 (PDT)
X-Received: by 2002:a17:90b:3949:b0:398:9c00:29ee with SMTP id
 98e67ed59e1d1-39aee208a63mr3307686a91.22.1788324200200; 
 Tue, 01 Sep 2026 21:43:20 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm2933984eec.4.2026.09.01.21.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 21:43:19 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 25/28] target/hexagon: invalidate translated code for user
 icinva
Date: Tue,  1 Sep 2026 21:42:28 -0700
Message-Id: <20260902044231.843004-26-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
References: <20260902044231.843004-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=F8JnsKhN c=1 sm=1 tr=0 ts=6a97a969 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=ooCGj4RZbTp4S4j5W-YA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: eOCKQqqFCLjdVHa0B2aFHt_6DcmuhYoY
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfX0bd6cBPP2R8X
 Z6XDGEC1Wpk76uk8xnn6fvNmqBzfBw/Ui7CzeTG1bA/S54x8Gl7/hl01JRKv2bOryiLW5fpREmi
 Fg2k2NVNQrtwXh93oD8/Uc40/bZE8GM=
X-Proofpoint-ORIG-GUID: eOCKQqqFCLjdVHa0B2aFHt_6DcmuhYoY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA0MCBTYWx0ZWRfXwJ/XAYExjTuN
 GxVdMi2KddrPQf6mNJREMZ6DiJRnUxUbNJurYh0I+HuFibSzMHWpvPAtnTsAHZWzZi5DngL0zyP
 WYuKdai0Ve5TPmVEd7+FqPlu9Fkmfmv/Nwl2zGDBveV8MW11TXP7TBEuwJKFjq7yx6OUn9OPfuF
 wZJQYB7GXYswnHLrlDOjyGij2g6ivvNmyHkxjUnClwFbCYbHYNlcarUqa+ATRTdOz8Snlq/Y/uY
 HCG4lPUoj7+OlsK2h5EkDX6k6pr3cd/ZZeHEE+3TkVbj7P+BvqfDbD0rzOnXbjXpWWpe7goVSt5
 6cJpntttWejMtdH7quU/MWwGYM6wCSFiB0yP/NTfqBJyJkQTYZJ0TVuYtICTHmgxo4JL518rBcP
 2vfjzuCT5itmeErUzpV6xTYBTqPxDd9LA3WYB6uFmmAW5VvEEPKz/b4kjQvx53QHsMI4Q99vzUG
 nLUs1CCyqAxGpFcUNHg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_06,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020040
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Um91dGUgbGludXgtdXNlciBpY2ludmEgdGhyb3VnaCBhIGhlbHBlciB0aGF0IGludmFsaWRhdGVz
IHRoZSBhZGRyZXNzZWQKaWNhY2hlIGxpbmUgdW5kZXIgbW1hcF9sb2NrCgpGb3Igc3lzdGVtIG1v
ZGUgaWNpbnZhIGhhcyBub3RoaW5nIGxlZnQgdG8gZG8sIHNvIGl0IHN0YXlzIGEgbm9wLgoKUmV2
aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZpZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21t
LmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0u
Y29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2dlbl90Y2cuaCAgIHwgIDkgKysrKysrKysrCiB0YXJn
ZXQvaGV4YWdvbi9oZWxwZXIuaCAgICB8ICAxICsKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5j
IHwgMTUgKysrKysrKysrKysrKysrCiB0YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuYyB8ICAzICsr
KwogNCBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0
L2hleGFnb24vZ2VuX3RjZy5oIGIvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5oCmluZGV4IDQwZTAz
NzgxZDM2Li4xZDI1MzkxMjgyYSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vZ2VuX3RjZy5o
CisrKyBiL3RhcmdldC9oZXhhZ29uL2dlbl90Y2cuaApAQCAtNDk3LDggKzQ5NywxNyBAQAogICAg
IGRvIHsgUnNWID0gUnNWOyB9IHdoaWxlICgwKQogI2RlZmluZSBmR0VOX1RDR19ZMl9kY2NsZWFu
YShTSE9SVENPREUpIFwKICAgICBkbyB7IFJzViA9IFJzVjsgfSB3aGlsZSAoMCkKKworI2lmZGVm
IENPTkZJR19VU0VSX09OTFkKKyNkZWZpbmUgZkdFTl9UQ0dfWTJfaWNpbnZhKFNIT1JUQ09ERSkg
XAorICAgIGdlbl9oZWxwZXJfaW5zbl9jYWNoZV9vcCh0Y2dfZW52LCBSc1YsIFwKKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdGNnX2NvbnN0YW50X3RsKGluc24tPnNsb3QpLCBcCisgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF90bChjdHgtPm1lbV9pZHgpLCBc
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRjZ19jb25zdGFudF90bChjdHgtPnBrdC5w
YykpCisjZWxzZQogI2RlZmluZSBmR0VOX1RDR19ZMl9pY2ludmEoU0hPUlRDT0RFKSBcCiAgICAg
ZG8geyBSc1YgPSBSc1Y7IH0gd2hpbGUgKDApCisjZW5kaWYKIAogLyoKICAqIGFsbG9jZnJhbWUo
I3VpVikKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oIGIvdGFyZ2V0L2hleGFn
b24vaGVscGVyLmgKaW5kZXggZTM5YWZkNjIzYjUuLjcxYzhkYTRjNDZkIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9oZWxwZXIuaApAQCAt
MTE1LDYgKzExNSw3IEBAIERFRl9IRUxQRVJfRkxBR1NfNChndmVjX3VhYnNkaWZmX2gsIFRDR19D
QUxMX05PX1JXRywgdm9pZCwgcHRyLCBwdHIsIHB0ciwgaTMyKQogCiAjaWYgZGVmaW5lZChDT05G
SUdfVVNFUl9PTkxZKQogREVGX0hFTFBFUl9GTEFHU18wKHV0aW1lciwgVENHX0NBTExfTk9fUldH
LCBpNjQpCitERUZfSEVMUEVSXzUoaW5zbl9jYWNoZV9vcCwgdm9pZCwgZW52LCBpMzIsIGludCwg
aW50LCBpMzIpCiAjZW5kaWYKIAogI2lmICFkZWZpbmVkKENPTkZJR19VU0VSX09OTFkpCmRpZmYg
LS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hl
bHBlci5jCmluZGV4IDIxNjhjNjM2MWQ5Li43MTU1NWE3YmEzNiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAg
LTIzLDYgKzIzLDkgQEAKICNpbmNsdWRlICJxZW11L21haW4tbG9vcC5oIgogI2luY2x1ZGUgImNw
dS5oIgogI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiCisjaW5jbHVkZSAiZXhlYy9tbWFw
LWxvY2suaCIKKyNpbmNsdWRlICJleGVjL3RhcmdldF9wYWdlLmgiCisjaW5jbHVkZSAiZXhlYy90
cmFuc2xhdGlvbi1ibG9jay5oIgogI2luY2x1ZGUgImZwdS9zb2Z0ZmxvYXQuaCIKICNpbmNsdWRl
ICJleGVjL2NwdS1pbnRlcnJ1cHQuaCIKICNpbmNsdWRlICJpbnRlcm5hbC5oIgpAQCAtMzMwLDYg
KzMzMywxOCBAQCBpbnQzMl90IEhFTFBFUih2YWNzaF9wcmVkKShDUFVIZXhhZ29uU3RhdGUgKmVu
diwKICAgICByZXR1cm4gUGVWOwogfQogCisjaWZkZWYgQ09ORklHX1VTRVJfT05MWQordm9pZCBI
RUxQRVIoaW5zbl9jYWNoZV9vcCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHRhcmdldF91bG9uZyBS
c1YsCisgICAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgc2xvdCwgaW50IG1tdV9pZHgsIHRh
cmdldF91bG9uZyBQQykKK3sKKyAgICB0YXJnZXRfdWxvbmcgc3RhcnQgPSBSc1YgJiB+MzE7CisK
KyAgICBtbWFwX2xvY2soKTsKKyAgICB0Yl9pbnZhbGlkYXRlX3BoeXNfcmFuZ2UoZW52X2NwdShl
bnYpLCBzdGFydCwgc3RhcnQgKyAzMSk7CisgICAgbW1hcF91bmxvY2soKTsKK30KKyNlbmRpZgor
CiBpbnQ2NF90IEhFTFBFUihjYWJhY2RlY2Jpbl92YWwpKGludDY0X3QgUnNzViwgaW50NjRfdCBS
dHRWKQogewogICAgIGludDY0X3QgUmRkViA9IDA7CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi90cmFuc2xhdGUuYyBiL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5jCmluZGV4IGJiYzI3MzJl
OTk0Li5iZTc1ZTVmZGViOCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMK
KysrIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTM1NCw2ICszNTQsOSBAQCBzdGF0
aWMgYm9vbCBwa3RfZW5kc190YihQYWNrZXQgKnBrdCkKICAgICBpZiAocGt0LT5wa3RfaGFzX2Nv
ZikgewogICAgICAgICByZXR1cm4gdHJ1ZTsKICAgICB9CisgICAgaWYgKGNoZWNrX2Zvcl9hdHRy
aWIocGt0LCBBX0lDRkxVU0hPUCkpIHsKKyAgICAgICAgcmV0dXJuIHRydWU7CisgICAgfQogI2lm
bmRlZiBDT05GSUdfVVNFUl9PTkxZCiAgICAgLyogU3lzdGVtIG1vZGUgaW5zdHJ1Y3Rpb25zIHRo
YXQgZW5kIFRMQiAqLwogICAgIGlmIChjaGVja19mb3Jfb3Bjb2RlKHBrdCwgWTJfc3dpKSB8fAot
LSAKMi4zNC4xCgo=

