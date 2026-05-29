Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8334CCD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:02:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5ER-00068h-2V; Fri, 29 May 2026 17:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5EH-0005yM-P6
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:59 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5ED-0000xZ-M0
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:58:55 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2NJF518485
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bZXJa7rP2+xRK15e1oQsfns0S5yQa74ONGCk2N9ymEM=; b=UqYgS14XC8XdPSKF
 xfPAVHdGL/P6tre9PJ9/JD2JkIAuD1stl4uURD3xLjWJWQCyBZXjqC8U0GCmUsT4
 jsm9phQy2uGpz7aiTIYaoNHBOpU/mPbbk3k0T8sOE/18rrvLtBGA1jjyR0Dh9GcL
 7R2APk9xvw+XUUPdfftr9ljvO73O80WPecFTYh6qkFYeKuBZifh3fpCRqGqutkA+
 uW2Snbi+Pp5t5XxgmROisxNa/CKoc4LM6idIEVBwZaGAGJUODUGZKw7DxDanqiY/
 oRU1vAJVTMeSAfoegXg1RNDbgHA+OlegSoXeDtPaKySRWqokTIaqdKlnDK5jUtMA
 lBgj8w==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efechhm0a-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:58:42 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304e7fbfaf5so5110708eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091922; x=1780696722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZXJa7rP2+xRK15e1oQsfns0S5yQa74ONGCk2N9ymEM=;
 b=YIBkLzgVUF5qgB3aqUmffGcrwBCU461HWJKUm5pa+uVRitLuT62aN3GwlOPiXuB0y3
 Cl7Ock+kP1TMzdIVuIBxtuGueAOxdkqDxV5TLdG7WNAfnM7cb8TY9p1vu1VF+nVtRi17
 uYFt1heySe12wJ62DRjUXjIFDr+VXktPog2rnqh3Ath9NoZdfHb1Cl7UnVBbbOYVOxE+
 7bMa13qjJSfg6t+pVd4My0ZojlBk9wqsNuhKMfBkB0lRKdRSoePj9QG6u99Ykle2BPPb
 3cU1r4hwsUTwyTN+B7zbJVRIDjQgBwyC4c1RrM9Y1YfnklyW6ciUb/fOE2JeUWVvyKrd
 e39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091922; x=1780696722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bZXJa7rP2+xRK15e1oQsfns0S5yQa74ONGCk2N9ymEM=;
 b=eGvAXGoytUuu6+dW7xMC4PQDScmVUei3Db5w2TQjY0HpviUicZ8q4Bsy0qXA4SanFM
 qYCaBd2MzNQQyECQpR8yIyZMkLqVXnBq5ZweH8bor7BkxVkgh+4ID4VlHRwZ6AKiKq4G
 eJVhfjlxL0JdCPlmOXqTKPdHb9sVENQGcFz0646I2PetbqkvnXc2BCEelIwcpcgJPecb
 WOfbkE5feXwBnzc7bRS+40yBM/Fau+zVcZj/FZRQEY/VpZXXQIiU7ZahEATx6lsy7guC
 dnx67KWDmCXGaz5mZDrhlab5igqizIYpFSB6kaxNqfndlmYu4x+aeWcIaGbf/r4VuxzI
 JckA==
X-Gm-Message-State: AOJu0YzdhpnYYBkt53tlwLBIKkAjxDuLZPG11a7A+NfN2DVQLhDXktfw
 gnqPUd5gRlhLgViKoGMX8AhLKK0C4NNAOIJsNwlidPqdKDaLCPPeJSBPfxtyrafCJDG5smt/7Or
 0Yv7EbVlM2IBiU1skTHLxWon6fW0IcEbgNDX34oT+s8rxrY3BynnCZ5owB6XWrk0bdg==
X-Gm-Gg: Acq92OGIA1C/oMfFRl9ilOlq64lEi8mgbjeRHjfFSUIX7Gf2XFawtzPudZApjpsUrJn
 6CmXcyPqngk74iQWiPcrMO+6P/vQ0rdPNSIQA4Dw9j3DqLP7/RewDBdbs7r0iPW5EUc1fX/He7f
 8NFqtepdDE5s8hJ8D3vT6WzPTGBe1oU84DCYE+G8gb9svGaucU0O8T5ZZCp+XAVAAjzc3ZSnTOX
 fvtBhXn0A3BYKPhFqPWLJBLHTUGkR8HegzC2FQ1xXawAw4f9zN7VFcpQ7xCE9dDSegTu4FFtGbh
 A4pJej44SPFGA8FSddQZbeCsT5RUs4Lul2CISnirKWhY8lzOigNyBG6g2q8hXHkpypS0Cx+gJp2
 KRmivWyLFJm3Hr5eGAvpFoamXs2P0/OWwCU464XtHVyCEOg8YYOiZ1tB8CL5j83SxTRG53EF7ea
 kvcraE
X-Received: by 2002:a05:7300:641c:b0:2c5:b23e:48a6 with SMTP id
 5a478bee46e88-304fa6197dfmr886522eec.23.1780091921756; 
 Fri, 29 May 2026 14:58:41 -0700 (PDT)
X-Received: by 2002:a05:7300:641c:b0:2c5:b23e:48a6 with SMTP id
 5a478bee46e88-304fa6197dfmr886509eec.23.1780091921257; 
 Fri, 29 May 2026 14:58:41 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5a9d27sm2428313eec.25.2026.05.29.14.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:58:40 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 23/28] target/hexagon: Define system, guest reg names
Date: Fri, 29 May 2026 14:58:01 -0700
Message-Id: <20260529215806.608770-24-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
References: <20260529215806.608770-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 59gfQStqCHt94Xq0vXvjiUrTMrWdOYbL
X-Proofpoint-GUID: 59gfQStqCHt94Xq0vXvjiUrTMrWdOYbL
X-Authority-Analysis: v=2.4 cv=U6Siy+ru c=1 sm=1 tr=0 ts=6a1a0c12 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y3CEZXcnQwYgoNz55sMA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX0UpxPkoN3wpJ
 Z9w3XCjp/xfecKLJIEH7ZJvYcq3gAixBfpj1xLMFg1WoWrsnsDGbji9rq4YaazoH9hMfulLjUbX
 19bhHZZP4MV0UdBiN/I1q2YNaSx4qGxf6WIEaPCgJ5XqDJ758XWjXjCzbrLQNtdX9KgJPmgGrNR
 A+pXBF/KPTdEGHqIr+CVnbFUiUCduILYSjafyJzlnZVzpErD4UFAUprrJMqmAWDRZiGIm0GwHRX
 sP/kh0t9ve/SRkiPSJyFSuetKR0ZXTwndOlDnIJDvbAdtYNo3+53h+Mr5MfMC3hQ1lhF35LcJYy
 Q6KEJDA9YhMibD1Le+KavjOtXXp7mcg3+YIL5Orckq4NGO0T4wQjCE3HrC8QIJklkVJQizMiKW2
 7zogWnC/0zWvchv0C19EGe6TELwuO52F+923vAyFCbjJfjSnFPZljS+gdl6k/W3l8K9fUzo5cLn
 1TbJ7smqWQX1gaFJCUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2lu
dGVybmFsLmggfCAgNCArKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgIHwgMjkgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzMgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2ludGVybmFsLmggYi90YXJnZXQvaGV4YWdv
bi9pbnRlcm5hbC5oCmluZGV4IDQzMzg5MTRlZmI1Li4wMGIzN2FlYTdhZiAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaW50ZXJuYWwuaAorKysgYi90YXJnZXQvaGV4YWdvbi9pbnRlcm5hbC5o
CkBAIC0zMCw2ICszMCwxMCBAQCB2b2lkIGhleGFnb25fZGVidWdfcXJlZyhDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50IHJlZ251bSk7CiB2b2lkIGhleGFnb25fZGVidWcoQ1BVSGV4YWdvblN0YXRl
ICplbnYpOwogCiBleHRlcm4gY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9U
QUxfUEVSX1RIUkVBRF9SRUdTXTsKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorZXh0ZXJuIGNv
bnN0IGNoYXIgKiBjb25zdCBoZXhhZ29uX3NyZWduYW1lc1tdOworZXh0ZXJuIGNvbnN0IGNoYXIg
KiBjb25zdCBoZXhhZ29uX2dyZWduYW1lc1tdOworI2VuZGlmCiAKIHZvaWQgR19OT1JFVFVSTiBk
b19yYWlzZV9leGNlcHRpb24oQ1BVSGV4YWdvblN0YXRlICplbnYsCiAgICAgICAgIHVpbnQzMl90
IGV4Y2VwdGlvbiwKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hl
eGFnb24vY3B1LmMKaW5kZXggNGJmZmRhMDNmOGMuLjQ3OGE4OWMyMzVhIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtODUsNiAr
ODUsMzUgQEAgY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RI
UkVBRF9SRUdTXSA9IHsKICAgImMyNCIsICJjMjUiLCAiYzI2IiwgImMyNyIsICJjMjgiLCAgImMy
OSIsICJjMzAiLCAiYzMxIiwKIH07CiAKKyNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorY29uc3Qg
Y2hhciAqIGNvbnN0IGhleGFnb25fc3JlZ25hbWVzW10gPSB7CisgICAgInNncDAiLCAgICAgICAi
c2dwMSIsICAgICAgICJzdGlkIiwgICAgICAgImVsciIsICAgICAgICAiYmFkdmEwIiwKKyAgICAi
YmFkdmExIiwgICAgICJzc3IiLCAgICAgICAgImNjciIsICAgICAgICAiaHRpZCIsICAgICAgICJi
YWR2YSIsCisgICAgImltYXNrIiwgICAgICAiZ2V2YiIsICAgICAgICJ2d2N0cmwiLCAgICAgInMx
MyIsICAgICAgICAiczE0IiwKKyAgICAiczE1IiwgICAgICAgICJldmIiLCAgICAgICAgIm1vZGVj
dGwiLCAgICAic3lzY2ZnIiwgICAgICJzZWdtZW50IiwKKyAgICAiaXBlbmRhZCIsICAgICJ2aWQi
LCAgICAgICAgInZpZDEiLCAgICAgICAiYmVzdHdhaXQiLCAgICJzMjQiLAorICAgICJzY2hlZGNm
ZyIsICAgInMyNiIsICAgICAgICAiY2ZnYmFzZSIsICAgICJkaWFnIiwgICAgICAgInJldiIsCisg
ICAgInBjeWNsZWxvIiwgICAicGN5Y2xlaGkiLCAgICJpc2Ric3QiLCAgICAgImlzZGJjZmcwIiwg
ICAiaXNkYmNmZzEiLAorICAgICJsaXZlbG9jayIsICAgImJya3B0cGMwIiwgICAiYnJrcHRjZmcw
IiwgICJicmtwdHBjMSIsICAgImJya3B0Y2ZnMSIsCisgICAgImlzZGJtYnhpbiIsICAiaXNkYm1i
eG91dCIsICJpc2RiZW4iLCAgICAgImlzZGJncHIiLCAgICAicG11Y250NCIsCisgICAgInBtdWNu
dDUiLCAgICAicG11Y250NiIsICAgICJwbXVjbnQ3IiwgICAgInBtdWNudDAiLCAgICAicG11Y250
MSIsCisgICAgInBtdWNudDIiLCAgICAicG11Y250MyIsICAgICJwbXVldnRjZmciLCAgInBtdXN0
aWQwIiwgICAicG11ZXZ0Y2ZnMSIsCisgICAgInBtdXN0aWQxIiwgICAidGltZXJsbyIsICAgICJ0
aW1lcmhpIiwgICAgInBtdWNmZyIsICAgICAiczU5IiwKKyAgICAiczYwIiwgICAgICAgICJzNjEi
LCAgICAgICAgInM2MiIsICAgICAgICAiczYzIiwKK307CisKK0dfU1RBVElDX0FTU0VSVChOVU1f
U1JFR1MgPT0gQVJSQVlfU0laRShoZXhhZ29uX3NyZWduYW1lcykpOworCitjb25zdCBjaGFyICog
Y29uc3QgaGV4YWdvbl9ncmVnbmFtZXNbXSA9IHsKKyAgICAiZ2VsciIsICAgICAgICJnc3IiLCAg
ICAgICAiZ29zcCIsICAgICAgImdiYWR2YSIsICAgICJnY29tbWl0MXQiLAorICAgICJnY29tbWl0
MnQiLCAgImdjb21taXQzdCIsICJnY29tbWl0NHQiLCAiZ2NvbW1pdDV0IiwgImdjb21taXQ2dCIs
CisgICAgImdwY3ljbGUxdCIsICAiZ3BjeWNsZTJ0IiwgImdwY3ljbGUzdCIsICJncGN5Y2xlNHQi
LCAiZ3BjeWNsZTV0IiwKKyAgICAiZ3BjeWNsZTZ0IiwgICJncG11Y250NCIsICAiZ3BtdWNudDUi
LCAgImdwbXVjbnQ2IiwgICJncG11Y250NyIsCisgICAgImdjb21taXQ3dCIsICAiZ2NvbW1pdDh0
IiwgImdwY3ljbGU3dCIsICJncGN5Y2xlOHQiLCAiZ3BjeWNsZWxvIiwKKyAgICAiZ3BjeWNsZWhp
IiwgICJncG11Y250MCIsICAiZ3BtdWNudDEiLCAgImdwbXVjbnQyIiwgICJncG11Y250MyIsCisg
ICAgImczMCIsICAgICAgICAiZzMxIiwKK307CisjZW5kaWYKIC8qCiAgKiBPbmUgb2YgdGhlIG1h
aW4gZGVidWdnaW5nIHRlY2huaXF1ZXMgaXMgdG8gdXNlICItZCBjcHUiIGFuZCBjb21wYXJlIGFn
YWluc3QKICAqIExMREIgb3V0cHV0IHdoZW4gc2luZ2xlIHN0ZXBwaW5nLiAgSG93ZXZlciwgdGhl
IHRhcmdldCBhbmQgcWVtdSBwdXQgdGhlCi0tIAoyLjM0LjEKCg==

