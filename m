Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 371D410F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:31:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYTz-0008PP-0Z; Wed, 08 Apr 2026 15:22:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAY4j-0006WO-8k
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:56:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wAKOl-0005Yg-9f
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:20:17 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 637KP4Q8251791
 for <qemu-devel@nongnu.org>; Wed, 8 Apr 2026 04:20:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7jxkk2sWTnge936nkYK0El/Q5cgEUJH6TW4dEtKN/20=; b=Dt+uLGyAjgAXxMNz
 MAcEa2zFpHQWcHjkubwKs7C4Esk0o+lVm2VGYOEW//K0DJPbYb+M+jBXIvcvDVl3
 yeoy+SZ9CtLySeD173kJBm2K2CrGiO7iWQB+tLnFc/R0VLVQ7W4qqgIxBKenZH86
 vWLJwTf8XMzqEkgl+e8FZLk+WtGpr0l5uZBLZqrLegwNz9walMT+uzcl01/OVxIG
 Z4bR+SeLSkec4IiNbilE32TOr8oBD35zIqqWgXSZg88i6D7cnoYpHybogOUV9cQY
 5erJ0XdqcMBr27k3lU4RFBxTANY45UKvtLZPlJw8zVbx7sXiFSYBtkmZhMXjhX8E
 zgbr3w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd8x996w4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2026 04:20:10 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-127133794b6so9493071c88.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 21:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775622010; x=1776226810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jxkk2sWTnge936nkYK0El/Q5cgEUJH6TW4dEtKN/20=;
 b=iyczIh/sIWjLIIKUBBLizE4iSYgS9KQ2r2x0UkMu4rAfy01YG0VUU6ZwsIEzPJqhoS
 /qv3xYZ1Ga68zKfdK8Zdj1fmp1kvyTvYntf+56pxg6wGkeCDTydPw0W5mNebSDNO7ZZk
 0PCYP2QfjQ5ckTg6sKvj8N8Q0gpBO/OLBl7/siEhXO3O+3QoSGgqtH+gmka3TKfJunzq
 VvvBv67HWdcrQhf8wLJwE4l5hWqLg5e7hEc5fsqf8gj4NwRQsLqnNfLFZbnRN+dcmQMu
 BbIX9RIqWbwshRA413hrAeAN47dqqRSriPqWZFFAyW+vIJ0MDhh/wiU6QhhlgXm2POhC
 QzEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775622010; x=1776226810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7jxkk2sWTnge936nkYK0El/Q5cgEUJH6TW4dEtKN/20=;
 b=kK/D4mhFAh83iI9fcCkOHtVzuo/m7nJq+2QB1DacmvbtxIFlx6L5GtSQbYZNNkn4Il
 nEiqL3LhrosYGEMWmsIKd6t/ewZp4oSCOzh/OPZwpqk8biXSlyh0jRvWVYPmCV+/6GiQ
 TtT2/bOaR6c1lkQ3tPAzcqH674xXSs22yimId0asQcE8TjiK8mkZ/in5Hd6Bfen/cH2k
 aMX2bx2fkujydr3bKPk9wB4vtXbe+vqmPjHvtW0hXVD6uVgCUfuyPLZiv6HvAa/Uh47A
 pP8GDwy70qv39KXGOcHE5HY70oOeF7br/SDaJ0whYdrhk/sC5PmG3P0wW/zWdi0iimN4
 9w0g==
X-Gm-Message-State: AOJu0Yz6tKD8z0bqLDRytcN2WIvmfcg43yr8uIkD1sB4V+FtEkVkFG1A
 TK7IGF1GSdfOsWjdvLO/QYruMnEanw+b3KOfIkmqfjJMV1KHny2yIp8qLUIer90KnH3ijkDhciX
 knm5U9GcHS+s6rUxx5DPSjTdcyCn/ZZAbR6jI939C38tD4boiGXPnTyVktFzb5E2xMQ==
X-Gm-Gg: AeBDietf3xeT93XuolyGNMo3E48n7kwTlRBlgnVllEAw2FGFVJkPDlnuhBrKbPR8LVk
 8YYZgU7vr4t5refGMfnA1ohPexTbFtYLNASiGiDrKn/sL4FPIBSy3RmLa+/m4ovbK9x5kMm3n3W
 8hMVCe2Ej/GNpPq/j/hHSNRp7sO+vIMQrFIK2CKiT1rrapWxV4CWGq2I3Y/vyA4OAU+/RR9qhu3
 snpurUhJ/buo6LpMsOfafO6N7unkqva1UNh2Cn/UDySFFsGwBdJ5B7dnAlenxrnLfWnHLvh3rGo
 8XelyXUY/J2X/MMjj5uSABvEdOAd8L8o+sIpYnaCdY3CT5FPTOf2doUQkAk0l79zZi17aAbMFH7
 9IntGmpzY5XwzvdcYmXs1fZ+OiS8jYMeSMfhcQUAARklVeYITjMEiNv47rNicZnFXMmrtTA==
X-Received: by 2002:a05:7022:b9c:b0:128:e0dc:6428 with SMTP id
 a92af1059eb24-12bfb760ba4mr10001403c88.17.1775622010150; 
 Tue, 07 Apr 2026 21:20:10 -0700 (PDT)
X-Received: by 2002:a05:7022:b9c:b0:128:e0dc:6428 with SMTP id
 a92af1059eb24-12bfb760ba4mr10001389c88.17.1775622009606; 
 Tue, 07 Apr 2026 21:20:09 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-12c14a371b1sm6480362c88.13.2026.04.07.21.20.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 21:20:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v4 01/28] target/hexagon: Implement {c,}swi helpers
Date: Tue,  7 Apr 2026 21:19:26 -0700
Message-Id: <20260408041953.1899532-2-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
References: <20260408041953.1899532-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Rr716imK c=1 sm=1 tr=0 ts=69d5d77a cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=KN34Fzpn9o_w8YhA2GgA:9
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDAzNiBTYWx0ZWRfXyo9K0stYF9Pu
 3Qir9MoYEn4KLRi0ClfSWZWn3ZZZ9YJM3qn/3eh0TxC04cYsSeHCsLsuBlxZJEs0ijqBWYO7q6O
 f759Fnr3e1dAyEA+Igz8+ViAR4+ossLiBcGhiSSaUSby8+kRZNDOhLc7Oad/RxappOt7estT8EO
 p3R3FNfo2EYy5en23hztkeYhpW7KMVAcGW/uu5Ir7HFV26gnxIma3xgF9XpUgjbCZha2ilxj8lM
 mcz7Vaz5rlDEMONQeyJfOhHSJwP08FLWGxTCqTACyAHY3Jw+ODuxqEsk9xeKvNhLfwb5CpNKiPJ
 CAsyrVsu5AerLImyC+ObFIr3wsCrE87iuvilUQvvqOJivWO5JxQRjvnWT/RmhimznHg6h1bJOGn
 X8leDYGFwgjmSCiJvMM4vL2HzYdBj/hz6grm/zjVqJitYHL6HEM+4gMFL9gkdQJJSl67Ulnn+tM
 Xxgmr0u9tDI+z66jQhw==
X-Proofpoint-ORIG-GUID: sY_W95dmiN7R9bK_Doz45wVmEd9WiC-Y
X-Proofpoint-GUID: sY_W95dmiN7R9bK_Doz45wVmEd9WiC-Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_02,2026-04-07_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604080036
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+Cgp7Yyx9c3dpIGFyZSB0aGUgInNv
ZnR3YXJlIGludGVycnVwdCIvIkNhbmNlbCBwZW5kaW5nIGludGVycnVwdHMiIGluc3RydWN0aW9u
cy4KClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29t
PgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+
Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKaW5kZXgg
OTQ3OTg4ZDI0NTYuLjA0ZDlmMTI4NmM5IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9vcF9o
ZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAtMjMsNiArMjMsNyBA
QAogI2luY2x1ZGUgImNwdS5oIgogI2luY2x1ZGUgImV4ZWMvaGVscGVyLXByb3RvLmgiCiAjaW5j
bHVkZSAiZnB1L3NvZnRmbG9hdC5oIgorI2luY2x1ZGUgImV4ZWMvY3B1LWludGVycnVwdC5oIgog
I2luY2x1ZGUgImludGVybmFsLmgiCiAjaW5jbHVkZSAibWFjcm9zLmgiCiAjaW5jbHVkZSAic3lz
X21hY3Jvcy5oIgpAQCAtMzUsNiArMzYsNyBAQAogI2luY2x1ZGUgImNwdV9oZWxwZXIuaCIKICNp
bmNsdWRlICJ0cmFuc2xhdGUuaCIKICNpZm5kZWYgQ09ORklHX1VTRVJfT05MWQorI2luY2x1ZGUg
ImhleF9pbnRlcnJ1cHRzLmgiCiAjaW5jbHVkZSAiaGV4c3dpLmgiCiAjZW5kaWYKIApAQCAtMTQw
MiwxMiArMTQwNCwxNCBAQCB2b2lkIEhFTFBFUihzaWFkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIAogdm9pZCBIRUxQRVIoc3dpKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgbWFzaykKIHsKLSAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworICAgIEJRTF9M
T0NLX0dVQVJEKCk7CisgICAgaGV4X3JhaXNlX2ludGVycnVwdHMoZW52LCBtYXNrLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CiB9CiAKIHZvaWQgSEVMUEVSKGNzd2kpKENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCBtYXNrKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgQlFM
X0xPQ0tfR1VBUkQoKTsKKyAgICBoZXhfY2xlYXJfaW50ZXJydXB0cyhlbnYsIG1hc2ssIENQVV9J
TlRFUlJVUFRfU1dJKTsKIH0KIAogdm9pZCBIRUxQRVIoaWFzc2lnbncpKENQVUhleGFnb25TdGF0
ZSAqZW52LCB1aW50MzJfdCBzcmMpCi0tIAoyLjM0LjEKCg==

