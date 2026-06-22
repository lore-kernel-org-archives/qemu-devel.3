Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CF9CDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndE-0002xp-45; Mon, 22 Jun 2026 19:00:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndC-0002tW-2h
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:42 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndA-0002TG-Ht
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:41 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJbh2W2206957
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=; b=pom8RrearaayRoSp
 6Q7XXJh0vWFqfV7+7W2P3TDKRIrQg/5JSPL9Xrre6drtw5z+USyemGvi4Jp0/lqC
 m7rUC61aZWYpPb+Guv34lVwihoaIb3F/3jNFyqi+wf45JRSqGSPyKxW5uDExWVJL
 1Xqv2fyS1yoI7w/g8BlY6tzoLjdL0wYXFs6FByBaRKK90JT2TafA/0t9/R6LU6C3
 8xa/0JSRxwCHtfViIG/14qD+5t3mMHMsPR3bga7GBw/CC6bKjUGgf6GIjRVi27lt
 Syz2Big5Owhm9y7MFpUF348+Msvwk4vmhbrO0CcJNezlD1htsOIgwUOD+HtDuSPh
 2hgKKw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey6tmsrfu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:29 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1394c3ee7f2so24364457c88.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169228; x=1782774028; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=;
 b=VqzhmTbGn9fDVv2GnPcNmqoJb3kkkw76YzS/tVx+f+INRRxcauIgpvzDxkpKpydvwK
 xz1M9iy+KOzHw6kSPW3hyyAYljSiBUUMHWy3lVsQix6Lpvac2x87UYvYvcPf7QujQsYo
 pPqMnqcXWg3n4q72GIb0p/wmV09L3LhDxMLpuL90SN/Okq0w2woPFrurDwSFK7BJHC43
 7OZq3fOLIiMWGQVI4TT9zDUtm46XrdeVdN+y8Lzv5jLhG7PJEirgYz44JxO4Mankt3RZ
 K+8Li4HvgreLY7+5cCSx0V1T0yjDQxFrtQLcIKYC/+5dOUkJv2IgN3SQ0Ok77ac4lsui
 9NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169228; x=1782774028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pn/yqs889jusoL8Cmra03kW8nABJmbmt9+r6zbgwxKs=;
 b=bcW2OgtgUSgLJA4FoI283MGS/rITFnj3pbE+T5QhF/grPonASyypvyyJBLmllAVAWc
 F+XAtA58NJY2psGTuQgluATSdsez4pdGEuYrBJSJqP0nOQ7iJse6mVw8ZifklgaTxtWz
 /sBZ4nRztm/SwfMKsixen1XE1BnIQGQA9sh1j5wHb0KvSbsYHUiApfnfWzjjzje4kO3h
 3QhyOr8cRv/mGxL8oZTbNn+gVT6cfwezJq4f7tRUe6BjyV3PgM36izzHpJWVT63fe4HR
 n9eUXE5lcn1RCge3El3X+SVT5E3EQbK3vtNUMhjOp2Z/MISO/rBYViCc1XQJh9Hky5HN
 /E3Q==
X-Gm-Message-State: AOJu0YwPeYA/cHYDPV8+gAReYNiGyLHUL8OtwmIxnhR9B82BeCZsLIzJ
 3OYuxiqFE9uc7sPbAPBrGvgbIOheCbDd7ngRFdQ6Y2i1L2MWShZp7vIpdAQhuTQnn0uwP1y6Yxc
 CZEURWNbAO83OKdp0hqypjCm/lywLhlmDMmT8VMi3tTGvIkUPXb/599LPjAmp/MNhJA==
X-Gm-Gg: AfdE7clBkZ4PpSRBVPBioJHxa4JMLC23OFTmX1q7fZEZFItnV4imeDeL/FB+S7oSVEA
 RoGUE0spbie5G9eQBzMYPaE4S3I4U1TLZ0UcApHR5fA9N3l3BNlF/vpA9dk1LMz4ScY1r3JJCIk
 LKGtvXTXOksdqnZYipcZDfIjVXojdBFZ54effc1NSSyK/cRUB4TxF5DkPfd+xaTa+zillo1HRcw
 aNpy5x+EG/cbOMw0RZeeXJhs+/wxIOH5aJCWeYlR4LnfQ8xvO+T1gfWOCBx34/uKS9Au3/3/Vcw
 7jD/usIZ/TqmJi4MFQBkjWI7DnAyvZysqBqOy7jju53cCR5zNRrCXscnBplf7O2yE93BuFI3NOR
 UBmSK13bpOYZcfuE/7iwy1X+cKbljQole8sNtlhsUGB8Jt51km1RmJ8E1f+o=
X-Received: by 2002:a05:7022:689e:b0:137:f875:c1de with SMTP id
 a92af1059eb24-139a2116825mr12860771c88.22.1782169228284; 
 Mon, 22 Jun 2026 16:00:28 -0700 (PDT)
X-Received: by 2002:a05:7022:689e:b0:137:f875:c1de with SMTP id
 a92af1059eb24-139a2116825mr12860717c88.22.1782169227497; 
 Mon, 22 Jun 2026 16:00:27 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:26 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 54/75] target/hexagon: extend hexagon_cpu_mmu_index() for
 sysemu
Date: Mon, 22 Jun 2026 15:28:43 -0700
Message-Id: <20260622222904.607771-55-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX/DIyE6vrKETj
 dnob5SsjhpzcfuU8+FgH75TmFjLu9jySchvVCgEJ5+ExXXAQ2yLRUXrIf0jw1G248cBhXymG3uM
 A9iyjEq5odMPtMwceiv/wxlKrajrmOM=
X-Proofpoint-GUID: ehRd3umJPS9AbnFuTkcIkdzvbBBVshp-
X-Proofpoint-ORIG-GUID: ehRd3umJPS9AbnFuTkcIkdzvbBBVshp-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX6dTxNOMhq3Gx
 dLhFsg8GOJ8ah78++0d5A9ma45DpB1m6y+FSikDnI0xmdQ1kLUHWppsSGk+MX7h7ntlWbcqL5+W
 W7zEgF1NTAOhlutaM5M+771oNlwjWNvKtXWmvRdUX0v8iABY5qPst44sUp6xk9oqFgpTmi0PMux
 epqIri21KYj1y1RU4V0JmXgeL/RdH4QusJUTP4QXZk4kfsv38CnnKhsMd/89fBvq/IkCLEXjsjG
 ePDpilVTnrSNWPOLzJ9svb01zyWZ+Uj1Odfb9cxM2K29QXfXsF8jC6zzExV2oJfZUodp1GeRP/s
 zp8DUEEuMILCjiuqinxQHkEU1DqmgZOfzM/rNjIvAwI+6WUf5tG2XHF75MMGXOU0fQw8W+G7Zx0
 pjiaWJvZyMILpYXqF/VCO0XaZezL23ZUsmP+NpFQGO1IcxrKQuvA4QPRboLNVRUVKPZEC/SbOZg
 tzqGhuW5q0rUJjVZiTA==
X-Authority-Analysis: v=2.4 cv=H4HrBeYi c=1 sm=1 tr=0 ts=6a39be8d cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=hUoHZ09r4jABJgGRQWAA:9
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2Nw
dV9oZWxwZXIuaCB8ICA4ICsrKysrKysrCiB0YXJnZXQvaGV4YWdvbi9jcHUuYyAgICAgICAgfCAy
NCArKysrKysrKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaCBiL3RhcmdldC9o
ZXhhZ29uL2NwdV9oZWxwZXIuaAppbmRleCA3NWEyOGZjMTBmOS4uZDE3Njc1MDMxNTYgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL2NwdV9oZWxwZXIuaAorKysgYi90YXJnZXQvaGV4YWdvbi9j
cHVfaGVscGVyLmgKQEAgLTgsNiArOCwxNCBAQAogI2RlZmluZSBIRVhBR09OX0NQVV9IRUxQRVJf
SAogCiB1aW50MzJfdCBoZXhhZ29uX2dldF9wbXVfY291bnRlcihDUFVIZXhhZ29uU3RhdGUgKmN1
cl9lbnYsIGludCBpbmRleCk7Cit2b2lkIGhleGFnb25fbW9kaWZ5X3NzcihDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgbmV3LCB1aW50MzJfdCBvbGQpOworaW50IGdldF9jcHVfbW9kZShD
UFVIZXhhZ29uU3RhdGUgKmVudik7CitpbnQgZ2V0X2V4ZV9tb2RlKENQVUhleGFnb25TdGF0ZSAq
ZW52KTsKK3ZvaWQgY2xlYXJfd2FpdF9tb2RlKENQVUhleGFnb25TdGF0ZSAqZW52KTsKK3ZvaWQg
aGV4YWdvbl9zc3Jfc2V0X2NhdXNlKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBjYXVz
ZSk7Cit2b2lkIGhleGFnb25fc3RhcnRfdGhyZWFkcyhDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgbWFzayk7Cit2b2lkIGhleGFnb25fc3RvcF90aHJlYWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpOwordm9pZCBoZXhhZ29uX3Jlc3VtZV90aHJlYWRzKENQVUhleGFnb25TdGF0ZSAqZW52LCB1
aW50MzJfdCBtYXNrKTsKIHVpbnQ2NF90IGhleGFnb25fZ2V0X3N5c19wY3ljbGVfY291bnQoQ1BV
SGV4YWdvblN0YXRlICplbnYpOwogdWludDMyX3QgaGV4YWdvbl9nZXRfc3lzX3BjeWNsZV9jb3Vu
dF9oaWdoKENQVUhleGFnb25TdGF0ZSAqZW52KTsKIHVpbnQzMl90IGhleGFnb25fZ2V0X3N5c19w
Y3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KTsKZGlmZiAtLWdpdCBhL3Rhcmdl
dC9oZXhhZ29uL2NwdS5jIGIvdGFyZ2V0L2hleGFnb24vY3B1LmMKaW5kZXggNjcwNjY4ODA4YTgu
LjNhZjkwZTMwYjBmIDEwMDY0NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuYworKysgYi90YXJn
ZXQvaGV4YWdvbi9jcHUuYwpAQCAtNDQ3LDYgKzQ0NywzMCBAQCBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZWFsaXplKERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkKIAogc3RhdGljIGlu
dCBoZXhhZ29uX2NwdV9tbXVfaW5kZXgoQ1BVU3RhdGUgKmNzLCBib29sIGlmZXRjaCkKIHsKKyNp
Zm5kZWYgQ09ORklHX1VTRVJfT05MWQorICAgIENQVUhleGFnb25TdGF0ZSAqZW52ID0gY3B1X2Vu
dihjcyk7CisgICAgSGV4YWdvbkNQVSAqY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgIGludCBj
cHVfbW9kZTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgaWYgKGNwdS0+Z2xvYmFscmVn
cykgeworICAgICAgICB1aW50MzJfdCBzeXNjZmcgPQorICAgICAgICAgICAgaGV4YWdvbl9nbG9i
YWxyZWdfcmVhZChjcHUtPmdsb2JhbHJlZ3MsIEhFWF9TUkVHX1NZU0NGRywKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZW52LT50aHJlYWRJZCk7CisgICAgICAgIHVpbnQ4X3Qg
bW11ZW4gPSBHRVRfU1lTQ0ZHX0ZJRUxEKFNZU0NGR19NTVVFTiwgc3lzY2ZnKTsKKyAgICAgICAg
aWYgKCFtbXVlbikgeworICAgICAgICAgICAgcmV0dXJuIE1NVV9LRVJORUxfSURYOworICAgICAg
ICB9CisgICAgfQorCisgICAgY3B1X21vZGUgPSBnZXRfY3B1X21vZGUoZW52KTsKKyAgICBpZiAo
Y3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX01PTklUT1IpIHsKKyAgICAgICAgcmV0dXJuIE1NVV9L
RVJORUxfSURYOworICAgIH0gZWxzZSBpZiAoY3B1X21vZGUgPT0gSEVYX0NQVV9NT0RFX0dVRVNU
KSB7CisgICAgICAgIHJldHVybiBNTVVfR1VFU1RfSURYOworICAgIH0KKyNlbmRpZgorCiAgICAg
cmV0dXJuIE1NVV9VU0VSX0lEWDsKIH0KIAotLSAKMi4zNC4xCgo=

