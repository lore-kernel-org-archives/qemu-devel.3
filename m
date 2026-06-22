Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C89ACDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndC-0002tS-0H; Mon, 22 Jun 2026 19:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnd8-0002sX-4s
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:38 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbnd6-0002SU-JS
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:37 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaDWN2101408
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=; b=Eu1k8H2zZHlfyYJX
 kw4dlxAdc5+kZ1jnhGwDQjTtyCIloRqfzcLKht1XJm2FyAGOLM2D3H7AgrIUmMlN
 cHtLgZ+kN0Pj+C64547LLZKg0kTXJdJSTlIynB+MxLDrZ8JHmqP+hvG69vz6kzMe
 5ONOuwt83LhGYEXWA1E+Jn32Yz+QKU7i7gFSDuT1QSjenMIhz+4esgtZfVdB4vxq
 qxwqcsyOmxeE8U27FdoC5UAPF4kAxP7YUJEo7aX8EJkWNc3iOcKUy8HAj7e1Xubq
 8gJzg2JI+H8L17MEexWPJysDOyf3FJRBOyuhS4XUcYq+hZWupdyMWWPBKyq7TCp3
 67R6OQ==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3ebah49-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:25 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-1383723dfddso7821026c88.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169225; x=1782774025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=;
 b=WQ87I3WhgmY4deYHnaY7tk7KXMjvUfAVm1MGTWC9qsm+uK/Q8ADwo5HWEzqrKPNKk4
 IhklDNvKYVXRRSJfN9t8bvthBJt1AOrUiSZI0NsqS5GtlmqySEUEJCGEqnzdmhAt+MxY
 /5yWCTy9RCHW0ne3081x0X2pXetRkk8SHpheGvkMbIVwOt66s6ODRUPY13nsmgoD+dDX
 ECafbrEBmHiWc0PEcVwu3rnDMlX8MnHymyUBu4yD24wr6a9bI/SY3MmodHREKxjpugIp
 3IB16ubD7ISpsQpeABrzVG5cH5WKKRmDGR+ZpaeK+zlbXYG0uCT+giCthFvEG73x5bDI
 5Z0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169225; x=1782774025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J1aA0AXcl1R5eWizmiiFdBlejhKxkpocBp47xOiaUuM=;
 b=My2Pio+AIeJpUMaYNODFXGEcg7s0TUzX3y/+L8gxcdv37y14mU8jJUo/HWXGYVU25m
 v5f7dd9fQUP9nYoaJNXu51l1IrBCRl26jkuEqr4vb/qnneBWqygutXt5GKXvGfaqcRyt
 IYBDtnfdfJPCewI5MAuf0BMTc326ttLBycqmTDdwLaln21WCzb3aghJ+1SODmy+1MssR
 JwCliaYw23j5hudsnLoh6kcY8mWK1pVHwBDFuF1md+dBQi5nNE6PzTBSSTDdPRGjtsX2
 8edtJA6MY+8yLpejQJFMrbClNly2L82t4zLnunMMDGfmmUBqLL5CFaf2PctW4XMpTtxy
 Q+5A==
X-Gm-Message-State: AOJu0YyBI1jQiCPKwECVofw+Q70N/bc/VbTclbiE5kdv+KwORCkpt3Du
 DCFHOsai3Z4Uy4K8vFA2DO2ot9jLFebpSoAFUXvmElRu2Q/MMrCF41I3Pm4oZKTOM3ogh7HWv+h
 KqeMWRnlhzD71bXSaJktEZz/+EA3nhHJ+RIZx3kAdiFirNCARKZzNKtH+Je2hA4UxRg==
X-Gm-Gg: AfdE7cnHA2xe8eixqd4Q5AUsgTn6uFsbfO1KmCIzKNxv8s/yITXRKLha02KlfEIm5cg
 jajzYwT5Y9Q+QpVZ0SjjW49hFTZd/c0gmM5jMjeQgEap8y2cV1d1RhRiNFzyOc6N+wxsQhT6/U9
 /nWBtuLd8nqsR/J8EbQ1Z3IDdJhbgW8m5Fe37VaH4E1yO4W2Brrg/Rz/khPh731RZL79vOtbW2x
 q4dPd4tqhQ0V5cs3bDaGMJwdTHcGEFPG4NQjumxA1kGlugXqsb6HQaczI2UTAVY8ed7DDq+3HPK
 9XJHIuNxQGzIWaugz2EwjV3jBPLyqzIFlXDV3WCO+3it+Vplu5qCf3S+xjxk49mBYbcIThie63o
 02GNIVsulmZzC4SPFjZGggwzzLKxyQ8TISBVe7LecF/Ru50zM6e/BRA1ve2I=
X-Received: by 2002:a05:7023:b09:b0:138:1130:5fd3 with SMTP id
 a92af1059eb24-139a34ecd60mr8680494c88.10.1782169224619; 
 Mon, 22 Jun 2026 16:00:24 -0700 (PDT)
X-Received: by 2002:a05:7023:b09:b0:138:1130:5fd3 with SMTP id
 a92af1059eb24-139a34ecd60mr8680467c88.10.1782169223970; 
 Mon, 22 Jun 2026 16:00:23 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:23 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 52/75] target/hexagon: Implement setprio, resched
Date: Mon, 22 Jun 2026 15:28:41 -0700
Message-Id: <20260622222904.607771-53-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX1kbT7DIKlKoi
 pxHzfXuAKTP08fmaHG53rg8CRP60rELPyr5jSTshP4k5OoecP9DLf0dqbNfLMu+JPz4fqFIfrjV
 dYA4XlgZanAQZSr6cBuwc0+5+yAsTOU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfXxydMy9rNiKHc
 8E4gnHevO0oWYFGjE8/8XsGFULzfDIZ7ah2+/7eWspg+v3NNRhMeyxpY2hpnn/Xa/Kvd8DJxSGB
 cYbKX0k1MfyLI7zC6DBOyyNKpssxlz3w0Ria/7nifqbwSivHuC9adxWemWK3aKx8bXi8IT507cy
 g2sw4dBusIfkSFuHlYmh12/4/26rIrB+GfM0GqSHDjYMB1ddY/mnCvle7FhkAil1BLCabZ1slE9
 bWB0NGEKYVFpZlrUUk0bM1Ri/6YcygJxO0N1OTzur67lCK0xVnizuU00gwzcF1w9Tfr90UC3Pfv
 KtkFAd1b+6sa1ddr5AGOpA5HmwQMBPdOo9ILAQSRN+KOKAWXHs1O6Yeg868CQHfAlJwYL7stjuN
 0QoduF6WD5J+MFFfVTGlA6TmGUmHi65ab3QPRli2vTwxa3VkMzs0qEcCVAqHOUVYKpgzybDn+eQ
 lZqdn2X6umzP+M2uxHA==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a39be89 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=9hY_xzidxOicKg_qOOkA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: MT4pAa88YHhiKRm_9Nhlx7Gp11N3F2Uf
X-Proofpoint-ORIG-GUID: MT4pAa88YHhiKRm_9Nhlx7Gp11N3F2Uf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220221
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpUaGUgaGFyZHdhcmUtYXNzaXN0
ZWQgc2NoZWR1bGVyIGhlbHBzIG1hbmFnZSB0YXNrcyBvbiB0aGUgcnVuIHF1ZXVlCmFuZCBpbnRl
cnJ1cHQgc3RlZXJpbmcuCgpSZXZpZXdlZC1ieTogUGllcnJpY2sgQm91dmllciA8cGllcnJpY2su
Ym91dmllckBvc3MucXVhbGNvbW0uY29tPgpTaWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlh
bi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0tLQogdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMg
fCA3NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5n
ZWQsIDc3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxw
ZXIuYyBiL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDM0YzU1YjU2MGNhLi4zYzI1
M2IzOTFlNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFy
Z2V0L2hleGFnb24vb3BfaGVscGVyLmMKQEAgLTE1OTAsNiArMTU5MCw2NCBAQCBzdGF0aWMgdm9p
ZCBoZXhhZ29uX3dhaXRfdGhyZWFkKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBQQykK
ICAgICBjcHVfaW50ZXJydXB0KGNzLCBDUFVfSU5URVJSVVBUX0hBTFQpOwogfQogCitzdGF0aWMg
aW5saW5lIFFFTVVfQUxXQVlTX0lOTElORSB2b2lkIHJlc2NoZWQoQ1BVSGV4YWdvblN0YXRlICpl
bnYpCit7CisgICAgdWludDMyX3Qgc2NoZWRjZmc7CisgICAgdWludDMyX3Qgc2NoZWRjZmdfZW47
CisgICAgaW50IGludF9udW1iZXI7CisgICAgQ1BVU3RhdGUgKmNzOworICAgIHVpbnQzMl90IGxv
d2VzdF90aF9wcmlvID0gMDsgLyogMCBpcyBoaWdoZXN0IHByaW8gKi8KKyAgICB1aW50MzJfdCBi
ZXN0d2FpdF9yZWc7CisgICAgdWludDMyX3QgYmVzdF9wcmlvOworICAgIEhleGFnb25DUFUgKmNw
dTsKKworICAgIEJRTF9MT0NLX0dVQVJEKCk7CisgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX0lO
VCwgIiVzOiBjaGVjayByZXNjaGVkXG4iLCBfX2Z1bmNfXyk7CisgICAgY3B1ID0gZW52X2FyY2hj
cHUoZW52KTsKKyAgICBzY2hlZGNmZyA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAgICAgIGhleGFn
b25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19TQ0hFRENGRywKKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7CisgICAgc2No
ZWRjZmdfZW4gPSBHRVRfRklFTEQoU0NIRURDRkdfRU4sIHNjaGVkY2ZnKTsKKyAgICBpbnRfbnVt
YmVyID0gR0VUX0ZJRUxEKFNDSEVEQ0ZHX0lOVE5PLCBzY2hlZGNmZyk7CisKKyAgICBpZiAoIXNj
aGVkY2ZnX2VuKSB7CisgICAgICAgIHJldHVybjsKKyAgICB9CisKKyAgICBDUFVfRk9SRUFDSChj
cykgeworICAgICAgICBIZXhhZ29uQ1BVICp0aHJlYWQgPSBIRVhBR09OX0NQVShjcyk7CisgICAg
ICAgIENQVUhleGFnb25TdGF0ZSAqdGhyZWFkX2VudiA9ICYodGhyZWFkLT5lbnYpOworICAgICAg
ICB1aW50MzJfdCB0aF9wcmlvID0gR0VUX0ZJRUxEKAorICAgICAgICAgICAgU1RJRF9QUklPLCB0
aHJlYWRfZW52LT50X3NyZWdbSEVYX1NSRUdfU1RJRF0pOworICAgICAgICBpZiAoIWhleGFnb25f
dGhyZWFkX2lzX2VuYWJsZWQodGhyZWFkX2VudikpIHsKKyAgICAgICAgICAgIGNvbnRpbnVlOwor
ICAgICAgICB9CisKKyAgICAgICAgbG93ZXN0X3RoX3ByaW8gPSAobG93ZXN0X3RoX3ByaW8gPiB0
aF9wcmlvKQorICAgICAgICAgICAgPyBsb3dlc3RfdGhfcHJpbworICAgICAgICAgICAgOiB0aF9w
cmlvOworICAgIH0KKworICAgIGJlc3R3YWl0X3JlZyA9IGNwdS0+Z2xvYmFscmVncyA/CisgICAg
ICAgIGhleGFnb25fZ2xvYmFscmVnX3JlYWQoY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19CRVNU
V0FJVCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbnYtPnRocmVhZElkKSA6IDA7
CisgICAgYmVzdF9wcmlvID0gR0VUX0ZJRUxEKEJFU1RXQUlUX1BSSU8sIGJlc3R3YWl0X3JlZyk7
CisKKyAgICAvKgorICAgICAqIElmIHRoZSBsb3dlc3QgcHJpb3JpdHkgdGhyZWFkIGlzIGxvd2Vy
IHByaW9yaXR5IHRoYW4gdGhlCisgICAgICogdmFsdWUgaW4gdGhlIEJFU1RXQUlUIHJlZ2lzdGVy
LCB3ZSBtdXN0IHJhaXNlIHRoZSByZXNjaGVkdWxlCisgICAgICogaW50ZXJydXB0IG9uIHRoZSBs
b3dlc3QgcHJpb3JpdHkgdGhyZWFkLgorICAgICAqLworICAgIGlmIChsb3dlc3RfdGhfcHJpbyA+
IGJlc3RfcHJpbykgeworICAgICAgICBxZW11X2xvZ19tYXNrKENQVV9MT0dfSU5ULAorICAgICAg
ICAgICAgICAgICIlczogcmFpc2luZyByZXNjaGVkIGludCAldSwiCisgICAgICAgICAgICAgICAg
IiBjdXIgUEMgMHglIiBQUkl4MzIgIlxuIiwKKyAgICAgICAgICAgICAgICBfX2Z1bmNfXywgKHVu
c2lnbmVkKWludF9udW1iZXIsIGVudi0+Z3ByW0hFWF9SRUdfUENdKTsKKyAgICAgICAgU0VUX1NZ
U1RFTV9GSUVMRChlbnYsIEhFWF9TUkVHX0JFU1RXQUlULCBCRVNUV0FJVF9QUklPLCB+MCk7Cisg
ICAgICAgIGhleF9yYWlzZV9pbnRlcnJ1cHRzKGVudiwgMSA8PCBpbnRfbnVtYmVyLCBDUFVfSU5U
RVJSVVBUX1NXSSk7CisgICAgfQorfQorCiB2b2lkIEhFTFBFUih3YWl0KShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgdWludDMyX3QgUEMpCiB7CiAgICAgQlFMX0xPQ0tfR1VBUkQoKTsKQEAgLTE2OTgs
OCArMTc1NiwyNyBAQCB1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25T
dGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCiAgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0K
IAorLyoKKyAqIHNldHByaW8vcmVzY2hlZCAtIGhhcmR3YXJlLWFzc2lzdGVkIHNjaGVkdWxlciBo
ZWxwZXJzIGZvciBtYW5hZ2luZworICogdGhlIHJ1biBxdWV1ZSBhbmQgaW50ZXJydXB0IHN0ZWVy
aW5nLgorICovCiB2b2lkIEhFTFBFUihzZXRwcmlvKShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWlu
dDMyX3QgdGhyZWFkLCB1aW50MzJfdCBwcmlvKQogeworICAgIENQVVN0YXRlICpjczsKKworICAg
IEJRTF9MT0NLX0dVQVJEKCk7CisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgSGV4YWdv
bkNQVSAqZm91bmRfY3B1ID0gSEVYQUdPTl9DUFUoY3MpOworICAgICAgICBDUFVIZXhhZ29uU3Rh
dGUgKmZvdW5kX2VudiA9ICZmb3VuZF9jcHUtPmVudjsKKyAgICAgICAgaWYgKHRocmVhZCA9PSBm
b3VuZF9lbnYtPnRocmVhZElkKSB7CisgICAgICAgICAgICBTRVRfU1lTVEVNX0ZJRUxEKGZvdW5k
X2VudiwgSEVYX1NSRUdfU1RJRCwgU1RJRF9QUklPLCBwcmlvKTsKKyAgICAgICAgICAgIHFlbXVf
bG9nX21hc2soQ1BVX0xPR19JTlQsCisgICAgICAgICAgICAgICAgICAgICAgICAgICIlczogdGlk
ICUiIFBSSXUzMiAiIHByaW8gPSAweCUiIFBSSXgzMiAiXG4iLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICBfX2Z1bmNfXywgZm91bmRfZW52LT50aHJlYWRJZCwgcHJpbyk7CisgICAgICAgICAg
ICByZXNjaGVkKGVudik7CisgICAgICAgICAgICByZXR1cm47CisgICAgICAgIH0KKyAgICB9CiAg
ICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKIH0KIAotLSAKMi4zNC4xCgo=

