Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226E1CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:50:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclO7-00032B-K9; Thu, 25 Jun 2026 10:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNv-0002iY-4B
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wclNt-00009v-Ja
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:48:54 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9juBt1753995
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=; b=l1YxA+Ivm+kwMI38
 8wveSIFcPQEs5cAa7BVX4GhGUi7XBKHrUEhWtbYV1c7N7dM2uUdYcvVRsWcZITOn
 frt4WtVz0JNGmsPc9JguyM/deTbTN8n7tWb66hzbxjPMlGwn9EPbyA/M5/RzgFu3
 S/AkHuW1WTRw3wQEm6PcMNcQYYFEvsc/PBNDe1dSSSvPeLwFP0xmVUY0TyuSJ3VB
 YM/z2+RukMObobRNYpohtbROFI7mQISJ+GLM+dugAmIJKujDK78LwO5/Yj43qZMH
 3P5gwFYV9wPHyTu/hw4pUbP/au3q3ldVJmH9Kqu7+fe3GCcfoWAnKgP+OUVag+Is
 JyuuKQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0w0q2c0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 14:48:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c8d355dbcso1551537eec.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782398921; x=1783003721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=;
 b=EqSIO3IRVY0eET9bIpUPlKuJmoyuAUVC06t5trKuwT/xQ4qs39vjR0a+BK3GGdlUjj
 8gAOESQWkK0mS3/GWelSiI5NwkmDpN2E0SOxnhGuMBtoEl9BtXNPav6QjP8UGlFAe4H0
 HVHObBAITflNl2/h9zF3JgnVIjrr+yq7EfnAtozycSHdgEMP47BBjOj3SIq7I+WxH3Dv
 OljfZ6YLtKunSLM9cIxZ9r/4mlc2iyN81faQ3p50p3uXSA6rguWIn8RHNuPt8qVzWp/M
 yflGMOtbk4JVnwxQpl5AtPUG3Rr7tjBTewMkCxjoqjPa8ubIzQKS/5+MiH6+ydjdd1Dc
 hNKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782398921; x=1783003721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KQKd6wa9CP0Atn8b+uEkUcIK7E1HAQywunGjG1NtcJk=;
 b=UChazRa+YeSFzWXSTLLduXqI3WpGZZFtX3up0MQ7jYWDBK1Ayy8vQxtJTItbK7WqMB
 gv5biekk13V0jlN5UeNj4p0tCeJx38OtnNH6O9/eHHN67ZPZII0C3jyBmH41vAix66PN
 1LCjzoU8KN0NNlT/c4e3P81smdF7jKS+8ZLspAeC+BTK7r4VqgZDfjCCJuMo37LG7unP
 UfNK8Fz+LkNoJU65jtjLxFswjKZt8Z7qrdkdftep0SQ8VnKq5BBkPgpx6e3PERl/uOF/
 kmmkAL1jlzmCHwwoRRYLj4TKEa0TZIp1FmpK8NIGhoeqxMee0qA0vW3H9luydITOZzbt
 awgg==
X-Gm-Message-State: AOJu0YzMx13vNcRTBcUGSWuEw+mztCR5l+hhMYuHE2Rjw9wfga8c1nSO
 E/TVtJWIJfZW8IMCXSwwB8mvMuRvvGr3jXNuUvIo2yLs5mtnDJdOXlf2y0QBth1qbY1Y34AxSwU
 7Sdwb2su8GA+g8pbjwYviWFU2otONidkAG1TQJGDDWKCBFaguE+dZAarSLMz8josBrg==
X-Gm-Gg: AfdE7clKEH6VziJJB8o47+5ItuEnhTpxlbvw7BMOxAXeIPZmS/QM6AMzZhZVuk4k/Zv
 tSdzH3GN9KIUKurUk0fPJzx5OlrCUWEYvIF7UrbYPZ8rJbunigqL05Qh6Jzlk7QK0YIK0J2pR0l
 UAkR4ILFYJX3I08qGU0f3/hDepn9FoJnjnpBHBpPEjiSpXCD23P38HnoFQ8tnCAXsrPaod+8k9q
 XUcZO1Bri3GU1ITMAwAbRqp1MoQdacpnHBGqokrj20ILWTYLfgj2rK/8H+GUl3JN01wxo8BP7Zf
 V9XguNNYzvhmdaJavm5H++JkxUsY0T0/uVxAdk3HzEHdTBVQWQblAnk3MsrdD4rPw6Nph/ejSSC
 8BNHd5tvcB7F91rgpVefSDCnF2mtnMIB+XPYWrCu9Mg1b9M8O16bPxJeJ+T0=
X-Received: by 2002:a05:7300:b586:b0:304:18be:55a5 with SMTP id
 5a478bee46e88-30c84d15d55mr3129508eec.22.1782398921389; 
 Thu, 25 Jun 2026 07:48:41 -0700 (PDT)
X-Received: by 2002:a05:7300:b586:b0:304:18be:55a5 with SMTP id
 5a478bee46e88-30c84d15d55mr3129461eec.22.1782398920702; 
 Thu, 25 Jun 2026 07:48:40 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8afca8sm8999209eec.17.2026.06.25.07.48.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:48:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v3 62/76] target/hexagon: Define system, guest reg names
Date: Thu, 25 Jun 2026 07:16:19 -0700
Message-Id: <20260625141633.449487-63-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
References: <20260625141633.449487-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 9-3yGPxdQKBJt8iYCa7kYel4QTshUJS0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfX/eZcvkn+QaWl
 W/zMlG9ignV/U47XsMf1bE633WJsQ+j9eyQGTVpqnlf6vQzJcKLaraq46ip5n9zHw/0x0x0LLTm
 h035s7ZpoF+KQrqk/9cnegCckET7vtA=
X-Proofpoint-GUID: 9-3yGPxdQKBJt8iYCa7kYel4QTshUJS0
X-Authority-Analysis: v=2.4 cv=R6Ez39RX c=1 sm=1 tr=0 ts=6a3d3fca cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Y3CEZXcnQwYgoNz55sMA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDEyNyBTYWx0ZWRfXzjEHLginhK5x
 DbjEAoDAed8t8Z5cj5N89j04fko4pC5m+9/URdAy9bnIgRzJ0ydEcX3P5SYwN1HyjZ6bl980YDe
 TdsUsLT5q5tbYEn/Mok03XXOSTdF9+Cc+HqA5unLGXX6KIxyTt6+1iZt4Ft554jZPUs04wyDDLm
 tY7V+8uQwmUy+dSgD0rVooJmpex1AwNdOyu1DlLwjDGyQoJ9wgOU33rlZqkSnN6su85wdRHhcm2
 wStBEaVCCDuggYLXAWgXE7Vqlb1Nq/Td5vKt6V2HTvhkzJblsFG+gZHMkZBBWTFrkkYizMBCtBT
 WdblpevrkUKQnBBVMXTKO1/ROCxuiMFMFTuDwE8XzMSvErYUDBsZF8oCpYvhnS2GxHbve5m230g
 qhqeRhjZpEDgMZA2vndtD0etVngryOSGsqcQXOOxZYrBsxgIVSy+xzzKsXsCQeMLuPcmk1B0P4N
 S2ovgSuRXqNOY36q9+Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 suspectscore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250127
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
eGFnb24vY3B1LmMKaW5kZXggM2FmOTBlMzBiMGYuLmIzNWNhYWVjZmFlIDEwMDY0NAotLS0gYS90
YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuYwpAQCAtODYsNiAr
ODYsMzUgQEAgY29uc3QgY2hhciAqIGNvbnN0IGhleGFnb25fcmVnbmFtZXNbVE9UQUxfUEVSX1RI
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

