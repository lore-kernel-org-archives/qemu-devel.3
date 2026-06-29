Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD29C43638
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:47:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCIR-0004TJ-U1; Mon, 29 Jun 2026 09:45:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHc-0003hN-Es
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1weCHa-0006GR-Qk
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 09:44:20 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASvtQ2601200
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=; b=JvHjBBW/c5NkgTTJ
 1lK+ikynRlwAwRYMjkHQ8rbuv7mF23PB9nM77PxlvGf1FS0JSTw78WccsPqWzdVw
 /bMlAnz8jMaXrmsgcUVOwRMM1qkm9u2qdurea4ORWurU/agEeHpXJOY9Dx0qT2o5
 IV7OOTgV+9fwYfJO64PoLRoZkir8u5DhIrD2QITU3n5L1BtNiST0cQQPYO7XH4vr
 3g2l/km85bi8ynZZDfpeUkZ2DM9w7WA3oQ2mxcfq7YYHX4AHiyRZRXd0B74hqEsP
 kLGrWDpDQ+KQG6wM7m6721BzQvup9dI+NmtMHX6zSxjAwhm67DTqxrzI7vamjuOE
 dU81Yg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3nnw939m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 13:44:07 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c804e38cb1so18544805ad.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 06:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782740647; x=1783345447; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=;
 b=gKpRjX2R3dc6HeRfm3bwE/gOCXBuATN/ihbf8URTtGOX19cImTPr+EMeXuee9TicJ+
 gTDTimaBT9aN7IbCLhalRcvM+51AtklY/OCG6fIaFyqeEkMluUGvwZahhYX+mW+S4c9n
 y1K/frsxLWC2Ozll1RP4F4lOamwcpY5DTFtx2DPuFHUd8is1WG3u2MYa36Xc/2Fff8DK
 DoD/+k4NIkgPItB9X3YHcC037YVWhz14e1F2ci34zESMG9LoyKtShrHYqpDKymzaZydF
 9bWO4MF+j0UoH9XlRtQDP5RTo+myykPBUVk7ma7Hmfsq09E8VOcxdYShX9kgMVWGwJI6
 l1Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782740647; x=1783345447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HRwBm1PEj4CfI6jfh+n9tz4eTBvdQkmFIGL8YkDQmso=;
 b=hhjll9q/dNucszomTCoIjBGP2QVM57yt1SI1jud1TaPqss4jZS5EH4X1u4VK/NCVKE
 88UqL0yqGOew21r7h+b1eP/QbC8TGvP48D+LuXeMbuAw/+OAk1kOLbRWnOz7Mv1MTpJY
 lattzP5TrY8qH9eqlxr8OJ26hgVBtCNPZjg4qPXcL4nZH3afxktz1xNUpiLgYKWU1Djh
 A4rd/O0mFP7flGdpad4DayyPV0RS7ljBfko+f8Gg8FY4rqirnGIsITF4kCnQVheRXih7
 W+UgUpBST8U92u0fjDlZ8ojz44SAu6KqD1Bqrw8BT/bL8KaEnwyhVcJlz69qZCo81jyP
 ciDA==
X-Gm-Message-State: AOJu0Yy3VPrDAKwYjfXwGIUX26H5SPsnWtpH6v3QkmF2KQRtKwHXK7jp
 MT9so55m0YLgoXzo8MCHJk/F4HSQjg1/Ffd+O2PV0YH3dATWf87nwcsMihfksG/r5Xu7SF8LuNl
 aZKTQgvBkSKPByZaTOwUgnBJonFzZoIwA1nCGkodufg+iYHYfjrenF0aDhuRK07HCvw==
X-Gm-Gg: AfdE7cnSMvV+EPr0SteBnwkqoQ7QmHGtkAWUyaMi6TpoBbW3h6PWjoJWNc+LtPi82ax
 iVInOgmmclGvHltcGT03gLUf6trQxmme2rNba9JUpKHUmRTi9EBkPWN+a9wzq9D8UVuSwKWxzuI
 xZ3k/4xCXAt5pdSUpgtYGSKO6AT2ryPpcCKV2GugUi93vB8ryKyXQ6XIEpW5Xuj4oeNQzsFmlH9
 OjI3fWovkaTOavJwcTu9lU2VCbcJIGv6hj0OVpeibOKSD3DuiM+tEl+5382ZimU+G2lGF/OzKVd
 JyOovaGUo/WqYtaGhqnJ32HaOYaWVzCk99jo/wH7z+SskGIxFPXc1Iit0h+WJgTl1APBdMMJxXr
 PwvTMruOlqixIQ1KJdPGH4jxL+nu28b9IdFMisoKu4vmGb15IYV2bAtEBNNc=
X-Received: by 2002:a17:903:185:b0:2c9:feea:4e4c with SMTP id
 d9443c01a7336-2c9feea50bcmr30514845ad.15.1782740646796; 
 Mon, 29 Jun 2026 06:44:06 -0700 (PDT)
X-Received: by 2002:a17:903:185:b0:2c9:feea:4e4c with SMTP id
 d9443c01a7336-2c9feea50bcmr30514585ad.15.1782740646333; 
 Mon, 29 Jun 2026 06:44:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b0992227sm48968555ad.37.2026.06.29.06.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:44:05 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com, peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v5 56/77] target/hexagon: Add sysemu_ops,
 cpu_get_phys_page_debug()
Date: Mon, 29 Jun 2026 06:12:11 -0700
Message-Id: <20260629131232.2487780-57-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX7/Ay4d6lNmwx
 iW+aJnanFLjgZj+QpbtC0LL5nlCbTwWIoc/1ycBhhsDL87xOnd0foaDW8lj/w7kQAqMFgBMrX79
 3LnI3WzLYyRIO9b+Puu+HVzY0fVmFQ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExNCBTYWx0ZWRfX4heCPCizgpkd
 o4TH4Rnd+KQA38iRYnU0Fih8HP2l7lk5NIe9rJ0d4cyFJe0dWrBaL3E96xUX2PVxt249nztKs6q
 pmzzJYloQ6vjD7Fdp/ftAYwO8UUnZ7itWK0caCgORFQa4uqDPuTDJhZaHML32l+9w8CW5wric2h
 DtCAxYbk3ChepMMtRjcwpFW3jnJaV/TiTCVOCegVkasJI3byuu+v9XuEZB9uE+7zqBCR6QKmYl5
 ZdOeb4barhka8irlJPW8XCDYTbXhtaKG/NP/fkqejCfM1bJQg7EHX+CAv24CpCoqz43xXXPX5qO
 vru1jd78rWjrQYvPxrmsppVRdznpmCLavbHlYJCSGDE/nvXB6sD6chlAY5wwJne53sAwc4xRkis
 CkjB42OFPhRtSiy6NwG703Is1NFNifGUmcAHQXcb21mDm6vXYE6SAPOQ6NXlRLu2wiMJlaq7Gv/
 z3IX4EQh0ae06PPhO2Q==
X-Proofpoint-GUID: 32N_mex2Qdn6AQzcBiankn5WomguDEOs
X-Authority-Analysis: v=2.4 cv=cefiaHDM c=1 sm=1 tr=0 ts=6a4276a7 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=fg0LxJQkbHe3Ved8Rg4A:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 32N_mex2Qdn6AQzcBiankn5WomguDEOs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290114
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dS5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2Vk
LCAzMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1LmMgYi90
YXJnZXQvaGV4YWdvbi9jcHUuYwppbmRleCA0ZTVhMjU3NDRhMS4uNjcwNjY4ODA4YTggMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdS5jCisrKyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCkBA
IC0yMCw2ICsyMCw3IEBACiAjaW5jbHVkZSAicWVtdS9xZW11LXByaW50LmgiCiAjaW5jbHVkZSAi
Y3B1LmgiCiAjaW5jbHVkZSAiaW50ZXJuYWwuaCIKKyNpbmNsdWRlICJleGVjL2NwdXRsYi5oIgog
I2luY2x1ZGUgImV4ZWMvdHJhbnNsYXRpb24tYmxvY2suaCIKICNpbmNsdWRlICJxYXBpL2Vycm9y
LmgiCiAjaW5jbHVkZSAiaHcvY29yZS9xZGV2LXByb3BlcnRpZXMuaCIKQEAgLTM3LDYgKzM4LDcg
QEAKICNpbmNsdWRlICJhY2NlbC90Y2cvY3B1LWxkc3QuaCIKICNpbmNsdWRlICJxZW11L21haW4t
bG9vcC5oIgogI2luY2x1ZGUgImhleF9pbnRlcnJ1cHRzLmgiCisjaW5jbHVkZSAiaGV4c3dpLmgi
CiAjaW5jbHVkZSAiZXhlYy9jcHUtaW50ZXJydXB0LmgiCiAjaW5jbHVkZSAiZXhlYy9wYWdlLXBy
b3RlY3Rpb24uaCIKICNpbmNsdWRlICJleGVjL3RhcmdldF9wYWdlLmgiCkBAIC01MDQsNiArNTA2
LDI0IEBAIHN0YXRpYyB2b2lkIGZpbmRfcWVtdV9zdWJwYWdlKHZhZGRyICphZGRyLCBod2FkZHIg
KnBoeXMsIHVpbnQ2NF90IHBhZ2Vfc2l6ZSkKICAgICAqcGh5cyArPSBvZmZzZXQ7CiB9CiAKK3N0
YXRpYyBod2FkZHIgaGV4YWdvbl9jcHVfZ2V0X3BoeXNfYWRkcl9kZWJ1ZyhDUFVTdGF0ZSAqY3Ms
IHZhZGRyIGFkZHIpCit7CisgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsK
KyAgICBod2FkZHIgcGh5c19hZGRyOworICAgIGludCBwcm90OworICAgIHVpbnQ2NF90IHBhZ2Vf
c2l6ZSA9IDA7CisgICAgaW50MzJfdCBleGNwID0gMDsKKyAgICBpbnQgbW11X2lkeCA9IE1NVV9L
RVJORUxfSURYOworCisgICAgaWYgKGdldF9waHlzaWNhbF9hZGRyZXNzKGVudiwgJnBoeXNfYWRk
ciwgJnByb3QsICZwYWdlX3NpemUsICZleGNwLAorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBhZGRyLCAwLCBtbXVfaWR4KSkgeworICAgICAgICBmaW5kX3FlbXVfc3VicGFnZSgmYWRkciwg
JnBoeXNfYWRkciwgcGFnZV9zaXplKTsKKyAgICAgICAgcmV0dXJuIHBoeXNfYWRkcjsKKyAgICB9
CisKKyAgICByZXR1cm4gLTE7Cit9CisKIAogI2RlZmluZSBJTlZBTElEX0JBRFZBIDB4YmFkYWJh
ZGEKIApAQCAtNjExLDYgKzYzMSwxMyBAQCBzdGF0aWMgYm9vbCBoZXhhZ29uX3RsYl9maWxsKENQ
VVN0YXRlICpjcywgdmFkZHIgYWRkcmVzcywgaW50IHNpemUsCiAgICAgZG9fcmFpc2VfZXhjZXB0
aW9uKGVudiwgY3MtPmV4Y2VwdGlvbl9pbmRleCwgZW52LT5ncHJbSEVYX1JFR19QQ10sIHJldGFk
ZHIpOwogfQogCisjaW5jbHVkZSAiaHcvY29yZS9zeXNlbXUtY3B1LW9wcy5oIgorCitzdGF0aWMg
Y29uc3Qgc3RydWN0IFN5c2VtdUNQVU9wcyBoZXhhZ29uX3N5c2VtdV9vcHMgPSB7CisgICAgLmhh
c193b3JrID0gaGV4YWdvbl9jcHVfaGFzX3dvcmssCisgICAgLmdldF9waHlzX2FkZHJfZGVidWcg
PSBoZXhhZ29uX2NwdV9nZXRfcGh5c19hZGRyX2RlYnVnLAorfTsKKwogc3RhdGljIGJvb2wgaGV4
YWdvbl9jcHVfZXhlY19pbnRlcnJ1cHQoQ1BVU3RhdGUgKmNzLCBpbnQgaW50ZXJydXB0X3JlcXVl
c3QpCiB7CiAgICAgQ1BVSGV4YWdvblN0YXRlICplbnYgPSBjcHVfZW52KGNzKTsKQEAgLTY1Myw2
ICs2ODAsOCBAQCBzdGF0aWMgY29uc3QgVENHQ1BVT3BzIGhleGFnb25fdGNnX29wcyA9IHsKICAg
ICAucG9pbnRlcl93cmFwID0gaGV4YWdvbl9wb2ludGVyX3dyYXAsCiAgICAgLmNwdV9leGVjX3Jl
c2V0ID0gY3B1X3Jlc2V0LAogICAgIC50bGJfZmlsbCA9IGhleGFnb25fdGxiX2ZpbGwsCisgICAg
LmNwdV9leGVjX2hhbHQgPSBoZXhhZ29uX2NwdV9oYXNfd29yaywKKyAgICAuZG9faW50ZXJydXB0
ID0gaGV4YWdvbl9jcHVfZG9faW50ZXJydXB0LAogI2VuZGlmIC8qICFDT05GSUdfVVNFUl9PTkxZ
ICovCiB9OwogCkBAIC02ODAsOSArNzA5LDEyIEBAIHN0YXRpYyB2b2lkIGhleGFnb25fY3B1X2Ns
YXNzX2luaXQoT2JqZWN0Q2xhc3MgKmMsIGNvbnN0IHZvaWQgKmRhdGEpCiAgICAgY2MtPmdkYl9j
b3JlX3htbF9maWxlID0gImhleGFnb24tY29yZS54bWwiOwogICAgIGNjLT5kaXNhc19zZXRfaW5m
byA9IGhleGFnb25fY3B1X2Rpc2FzX3NldF9pbmZvOwogI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZ
CisgICAgY2MtPnN5c2VtdV9vcHMgPSAmaGV4YWdvbl9zeXNlbXVfb3BzOwogICAgIGRjLT52bXNk
ID0gJnZtc3RhdGVfaGV4YWdvbl9jcHU7CiAjZW5kaWYKKyNpZmRlZiBDT05GSUdfVENHCiAgICAg
Y2MtPnRjZ19vcHMgPSAmaGV4YWdvbl90Y2dfb3BzOworI2VuZGlmCiB9CiAKIHN0YXRpYyB2b2lk
IGhleGFnb25fY3B1X2NsYXNzX2Jhc2VfaW5pdChPYmplY3RDbGFzcyAqYywgY29uc3Qgdm9pZCAq
ZGF0YSkKLS0gCjIuMzQuMQoK

