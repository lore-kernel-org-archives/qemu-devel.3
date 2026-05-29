Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D8C3CD6E49
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5CN-0005tR-LL; Fri, 29 May 2026 17:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CL-0005lJ-HL
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CJ-0000Xt-ML
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:57 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2Ove1862730
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1nETUVmoG15LzclZ3CW0OtvaR+9D1d/YulupG9ak02w=; b=o9Qxd9H4mX53QCri
 CUv2mBIdNUOCqHD/2qASDEvR0FcW5dW3DSqntdY+FEvwiz7cuIQZdYrGIuiE5lSi
 wwcTg0cqVvQHvAJpxBgQm4BXfm3sPHixhWSvcKefPetk7yrlfBYO5wfQR48OnM7U
 byLszpEmu1zXiI4rfoPw75XzARTRsL+ECKyOAQ3Fo2vS5MQO0BwmQcUxhmjAf7QV
 vHib/Dv7FJ15juzaipm/OdJ3Wt9YSTV3M8Jmds7vuILF6hkqE8YaGtM79wUZ4kgS
 xTciDGZso73GryCra3LR77qRCnQqCYJ6kwGNQGA8FNIERtwVPCb3BGZMQVlkmeHA
 rddr6w==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef3te4p9w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:54 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-304d8613efbso2825925eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091813; x=1780696613; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1nETUVmoG15LzclZ3CW0OtvaR+9D1d/YulupG9ak02w=;
 b=YOvW/Rlj+VOBmPVJ+UC5Rn4g1voOAAc/tkfv6inJNZnkxBal53ES7F/Aesjbir8H8S
 eeD+HSOEr0ETasGKvOD4h6Y/vfuFW/qxIcWItEIEldTRP2Wb8J5RzY4Fy2DzlEKrsVue
 QffG7BpYz4Li/CXus8dYhrzL+ejybSS1i7TCrUmnWK08StmkQQWDyPwuBmsOtFl7up57
 Qb/xo7lI7Na+vCeTI8YcqsEDH4ni6u8oO6hyX0papM7S+Us5SvNP1ufiTLHXhfUQ8idD
 3Vex9BNW0x5Qy8BatSSDtZHBUfdDhCm7MTEr+jAryRpDs34A5uzSRdfgaUejns1G/Pz4
 8wjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091813; x=1780696613;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1nETUVmoG15LzclZ3CW0OtvaR+9D1d/YulupG9ak02w=;
 b=dBkyRZ4H1aBm69IA3ixLuFSbSDNbQoER/HURUeGlulvLrTkqN9pkUs1d3fEPxnsnAL
 gZkYkfFWFR8oGjhCmMHK/8Pk82/pY3qQ8X6T5DvKmaSY4aE3Bh1ivwl5qQd2zZ5ls6SJ
 SeuoL0mYbuaci8DpUIIJNlnyk/yWSkkXYiZE5pDt5rBvoSdDuSp3hQI+K16HNawiGhGM
 2FArQfFnORtnf93La+sC+Z+G4S41GFgDsSd4+pXJ9ZKb5Rzdfriu3IsBrYGyaxSLc88w
 C/Gj7Zgsa02PJb/yK6a/lMNjqwzTNJrdUpofKUBPKMNYis3q6tLt4JfVCm7/Q4y3qMr5
 0Jvg==
X-Gm-Message-State: AOJu0YwGw3E1m2IRKPauViOiHxrMz9BIiOgVDwIvkpXAmojTajPZiUa2
 TxUbRJvwOQwahLJAzkcmF3CbBYoJBRC3v3fwf74Lz+M5Y9YwZrvkmA7uis188sTWPwprpU8GLGR
 iJaJMbaoOFJ8GvCdrLg5AvFMST+u93rXj7Ygh+m90ZPatTeEX2A6ARKqQwHBw+YoA1A==
X-Gm-Gg: Acq92OEAypWW9GTL9Z2I2lDL7R8mOmm2o27/O6fj2l3JXwT2Z9USqS084FKCAH5KDa2
 JZg5gf+5SXn6CUtkmzexmDLeDLxaZNj8MHiUfwICOEKx3XTMAF8ZPKJu3CBCP3cqg7y2CAQkhGb
 AphGS7Ai0ZmcX8zo3Tnex4wamrJwALV+0aVlrCoWZtl6Zh19v7oHk6nNlOIAau2+PlGc6c/VIzt
 sEVBR1G9H85S03wMRs78r0EwqhnAS4S188XT1535Hw5RxS8xG/cKrrteF27+3tkQQl8poxjCUzj
 9ByLFdTpFiirj6mbCACLQmjRQbLRHeOKFGZJFgp+rjaexMAm25rElFtIlfgP/0QziIEIzxn3rFs
 Lf51txcYC6BwELmZ9LVl/NQhyA225htKaccyuC8vJCeAh2MmOx8aMJ/dRR1GZNYdCPYdFJUDSa/
 fpUBAJ
X-Received: by 2002:a05:7301:60b:b0:304:d32e:65e7 with SMTP id
 5a478bee46e88-304fa2fc9e6mr882773eec.0.1780091813504; 
 Fri, 29 May 2026 14:56:53 -0700 (PDT)
X-Received: by 2002:a05:7301:60b:b0:304:d32e:65e7 with SMTP id
 5a478bee46e88-304fa2fc9e6mr882763eec.0.1780091812995; 
 Fri, 29 May 2026 14:56:52 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:52 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 33/38] target/hexagon: Add cpu modes, mmu indices,
 next_PC to state
Date: Fri, 29 May 2026 14:55:49 -0700
Message-Id: <20260529215554.606133-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-ORIG-GUID: 6epifKHzBd6YOXmWU8bcMrB-b8FKiaPX
X-Proofpoint-GUID: 6epifKHzBd6YOXmWU8bcMrB-b8FKiaPX
X-Authority-Analysis: v=2.4 cv=daSwG3Xe c=1 sm=1 tr=0 ts=6a1a0ba6 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=6d93uPKVDIcG5a3x7xMA:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX905Bs7pcXSqS
 EScu8YYuIp7vUDrEnFlo0qeyi/FstK1TBwN5Q2ne76USo4S6LuMb39rAB7oanQPM5YSlWnUXf6P
 5x2kJdAE68JrNHXN1BQqGhx3fo3PGxcevraWGmB3TQ2iIbv1uNaJFNiHNX4Wm8W6aB3FpJKLqdL
 Z8gjWNf+QksDdVusvjdX0y+lP5x/vkWjZptW65f++s9COnCGXEuwJBECC1L4m5qHj0Crpfelemi
 nS5+SV7GGGaDQoFpQQK/0ML97D0j8RLkiPMfq2NbQMgU20DGYAoQ7W1Zn3Pu5mu8TmwCOw0xPJk
 yE5hkWCew9TBB7qxn0UKxggT81ZItYRRnIrvCg4kVLgDDkeZOQ/CWgt6VLjm9Rh0VMcvFpBC5DA
 r4nvWkHMZXPFy+1J7Yyrj8nTTG8rLrUl0BEE2AayocbVKwdCEyxwltL7P7Ix8583oJt2nus9JE9
 E0YlGYasNt4+xG6hq0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290219
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
dS5oIHwgMjEgKysrKysrKysrKysrKysrKysrKystCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyB8ICAx
ICsKIDIgZmlsZXMgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdS5oIGIvdGFyZ2V0L2hleGFnb24vY3B1LmgKaW5k
ZXggZGRmNmRhNzhjMTguLjU1ZGFkYjNiOTY0IDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9j
cHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApAQCAtNDksOCArNDksMjYgQEAKICNkZWZp
bmUgVlNUT1JFU19NQVggMgogCiAjZGVmaW5lIENQVV9SRVNPTFZJTkdfVFlQRSBUWVBFX0hFWEFH
T05fQ1BVCisjaWZuZGVmIENPTkZJR19VU0VSX09OTFkKKyNkZWZpbmUgQ1BVX0lOVEVSUlVQVF9T
V0kgICAgICBDUFVfSU5URVJSVVBUX1RHVF9JTlRfMAorCisjZGVmaW5lIEhFWF9DUFVfTU9ERV9V
U0VSICAgIDEKKyNkZWZpbmUgSEVYX0NQVV9NT0RFX0dVRVNUICAgMgorI2RlZmluZSBIRVhfQ1BV
X01PREVfTU9OSVRPUiAzCisKKyNkZWZpbmUgSEVYX0VYRV9NT0RFX09GRiAgICAgMQorI2RlZmlu
ZSBIRVhfRVhFX01PREVfUlVOICAgICAyCisjZGVmaW5lIEhFWF9FWEVfTU9ERV9XQUlUICAgIDMK
KyNkZWZpbmUgSEVYX0VYRV9NT0RFX0RFQlVHICAgNAorI2VuZGlmCisKKyNkZWZpbmUgTU1VX1VT
RVJfSURYICAgICAgICAgMAorI2lmbmRlZiBDT05GSUdfVVNFUl9PTkxZCisjZGVmaW5lIE1NVV9H
VUVTVF9JRFggICAgICAgIDEKKyNkZWZpbmUgTU1VX0tFUk5FTF9JRFggICAgICAgMgorCisjZW5k
aWYKIAotI2RlZmluZSBNTVVfVVNFUl9JRFggMAogCiAjZGVmaW5lIEhFWEFHT05fQ1BVX0lSUV8w
IDAKICNkZWZpbmUgSEVYQUdPTl9DUFVfSVJRXzEgMQpAQCAtMTEyLDYgKzEzMCw3IEBAIHR5cGVk
ZWYgc3RydWN0IENQVUFyY2hTdGF0ZSB7CiAgICAgdWludDMyX3QgdGhyZWFkSWQ7CiAgICAgdWlu
dDY0X3QgdF9jeWNsZV9jb3VudDsKICNlbmRpZgorICAgIHVpbnQzMl90IG5leHRfUEM7CiAgICAg
dGFyZ2V0X3Vsb25nIG5ld192YWx1ZV91c3I7CiAKICAgICBNZW1Mb2cgbWVtX2xvZ19zdG9yZXNb
U1RPUkVTX01BWF07CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9jcHUuYyBiL3RhcmdldC9o
ZXhhZ29uL2NwdS5jCmluZGV4IDA3NzNlZjhmZTc5Li42MjYxMDBkNDNmZCAxMDA2NDQKLS0tIGEv
dGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKQEAgLTMwNyw2
ICszMDcsNyBAQCBzdGF0aWMgdm9pZCBoZXhhZ29uX2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2Jq
LCBSZXNldFR5cGUgdHlwZSkKICAgICBtZW1zZXQoZW52LT50X3NyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fU1JFR1MpOwogICAgIG1lbXNldChlbnYtPmdyZWcsIDAsIHNpemVvZih1aW50
MzJfdCkgKiBOVU1fR1JFR1MpOwogICAgIGVudi0+d2FpdF9uZXh0X3BjID0gMDsKKyAgICBlbnYt
Pm5leHRfUEMgPSAwOwogI2VuZGlmCiAgICAgZW52LT5jYXVzZV9jb2RlID0gSEVYX0VWRU5UX05P
TkU7CiB9Ci0tIAoyLjM0LjEKCg==

