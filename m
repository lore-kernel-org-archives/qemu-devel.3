Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C6ECDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:33:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9U-0003Y6-IB; Mon, 22 Jun 2026 18:30:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9L-0003Pl-KW
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9J-0006Vv-Ql
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:29:51 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJaxaC1902568
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=; b=AR1j7eo5heNnYurd
 6f2Pvaa/9WWjLHplBWFdWUbpMar/mRepe9zWNfpb6l/Kj5L33HnnWXjzTjUXgH16
 mWbqfr2kZzdV8GKUZCSSm36/T+KrNqMtRBPHYQFW92OwdcQeFKoA8YGp9yE3dnQK
 UwGAbI09Ol/KCPm1gLWXvaGOutecRAZ9ayFpzVInbRHKzuFn/3keelGpeWo8+K+V
 znh1EmyQ4a7A3cowppOBe1XlEXUI6uKwLWrvD+Pa/f5OJ2/RW6ARF0cCkOXLqEgt
 hQ/1MI+lgfXUbt+qDx1t5ZeFZkra0SGSEgy1d/vNs3++bdfhuONBC9fkmRK3qSOy
 1+EMwg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4exyn1ukau-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:38 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c1f6c5559so5827193eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167378; x=1782772178; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=;
 b=aFyPiqEbVl5AFPysfahTKZ9UMIUF4K/3yNWkr/40ZlpTRZwUPmS9pVTsuQu0Ff1i62
 Cj7xb90qSljHuiXKX+LQm4wIvcsAxdfEpZ4ImZEGqvWwc06aqlwafFeMNZXEe7hm9yVW
 04paN861dU6O3YbJyn+6IFlbLLlMs0xa0ItRVl2KsKT8on8oxnAcelwS09o4EFVXtLW3
 kwt2ztAO6ZGGIkqUKKCe9aQJMcpMEk8TaJGvMvV5eHY8qKDe8zb5RekIuCArlahwvcSr
 L51t89YOPIBoZgE4bc6b8gMfRHagm4IBjeEKnJUNt+pWh9a2JQraMoY2waMK8deAxqbP
 5QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167378; x=1782772178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wO8Hpccix22tZFHgyU0VgMmMK7ZQOufSmnr3QdC9JmM=;
 b=jNhz8wLNdAiSttC0XYU+565xKhboxTDhwzHlZwLrsXeJii1IwWULhbmnE1eHfpC8M+
 ULchbQTv7pMAl8Xyxw4JTxvdwOrewRdqWf31EZbInM/OTz6ANDUIIEedwPS+HxPWj/jl
 X6xPHOwsQfTZQfF4V6Xw5gFqAnnwRzUdlw4sNm5KB5SpG3Z0FoaqOBpDiXqbW4KVWGp2
 uo0iGhxgx7dHDPe/CfNtNLgolgnEXUIPq/IOIIAwHUR+EEVi87oqpLkJCxZQqderQsQM
 euBMu+kc3cnWTktkei4ge6yF9q6GnndHXfGEodBbfSGv/zxQYb8W+clpxbRo03rh9FsZ
 nyZw==
X-Gm-Message-State: AOJu0Yx36f72iXJkIvPp0mN+LudzymMpK7albOVcCsMsqckPWPaEr9VP
 vg5M2u55Rj5WUnFlX7j+fglhkaHVH2A8DGyb8xfpu4+4DvWCQelJNa4TsB5xG2XCn/C3rJz2RTZ
 bshabp6f8QErnIApP1XaVEy73u/beir5IFBGUy6Zj5E/wo8kPumjnReboXOvAk/9a6g==
X-Gm-Gg: AfdE7cm/PvEfcGkVx53zW+O5wG1+G0/q6RXYBXWxwgRrEBAcVihqCmJ5g1GsfiR3mH1
 zW4tGY4LoLkmS5ZsEqNwFAqOxYqGiHALq/CBEsAp31BTqCYXJ8VeDiB31f8RSA0/REhl5e+NxWF
 Vt7v5t2Cuz9bt1+UaQPBkAmBIzUXHHlllcY8oZ36OFO640JgMa7k/zLxV+o/sbsGVsOrlZJX4Co
 Er7qAu4AsPErDAmLnQ66btpB8QRAPpo12bMm25qFLB6Olh05wJ8aiffHFT6GyGZ6IODAxf/fAop
 X81i9wue5/f8NJGCn1ngPox38ATQbJcR4mSHoAkdqCsz6ioYDrYj/+LwOyRP5lMkcR6OCnKd6Jk
 5oCQ9hcqYMSEgSiuH1NCPVPxGHHF3u1OFZoBWJo1kITrelK1IiDLWUqzP/70=
X-Received: by 2002:a05:7300:6d08:b0:30c:52c5:6e48 with SMTP id
 5a478bee46e88-30c52c57d74mr1917320eec.18.1782167377941; 
 Mon, 22 Jun 2026 15:29:37 -0700 (PDT)
X-Received: by 2002:a05:7300:6d08:b0:30c:52c5:6e48 with SMTP id
 5a478bee46e88-30c52c57d74mr1917291eec.18.1782167377439; 
 Mon, 22 Jun 2026 15:29:37 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:36 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 18/75] target/hexagon: Add placeholder greg/sreg r/w helpers
Date: Mon, 22 Jun 2026 15:28:07 -0700
Message-Id: <20260622222904.607771-19-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: Cy5gSWGrqvDi4h_IVm3U3dZQ-1rC8I9w
X-Authority-Analysis: v=2.4 cv=EOU2FVZC c=1 sm=1 tr=0 ts=6a39b752 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=wA0rHRt5QP8iJxr38i8A:9
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXysc2cbaN1RDN
 2Ed2UbcF0+Ll/g9bl2oE56NENiuCxoQbI6hTN3dyHd2dFuzQATAeELKE0e8dt8TKswsTfXCcYHq
 p4vSsEDLcz0uUZ4SqZGKW7Iw4hT3/Ok=
X-Proofpoint-ORIG-GUID: Cy5gSWGrqvDi4h_IVm3U3dZQ-1rC8I9w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfXxqwa2bORz6JD
 Wx2Hs78TBUD+8mT+kW6LOH4/PAF8dYGnAuYgLg0X6riHZXMVLKok8+lRwx7H6xkUpXixo9IVsr6
 XN+9Zbz+A0qgVHxaoQVFQOJYrGVXp0V3F7Ox/D1Leb9lo6kwRM+XVCq1TZ3tPuGh/algmw7x87v
 +jK6oVFBPPbv1JV/NR56Uf9Ldw2zfbM748iph4eRVSgUwbL9IAK0fGc/GN7X5aV37niSK1usx76
 enmljUr4F7ukyPBHLwu5Gp2FWaN8xZzOnHi3oK8X4zz6RpcC+gR2Sf4qgUfq55FF9XFAd1NYDrQ
 Y2luZwJRYyyEKV3dI7Avpwt/iOMpMArTHdHR7q+y2uQn/7qGZc/JZY9BFGbP1IolY9vHxLtLQX8
 yJvK6Ers76HtG4vb4gAJJpmYBGGulRa7l6FzDTm4KhzXwy/yyiQz+9HfnDSvMGAfLmV53zG3BjK
 HYIqVAbyVvs5gW2Nntw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220216
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
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
bHBlci5oICAgIHwgIDggKysrKysrKysKIHRhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIHwgMjgg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAzNiBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGVscGVyLmggYi90YXJnZXQvaGV4
YWdvbi9oZWxwZXIuaAppbmRleCA2NDQ1NjgyMmJjMS4uMjhiOWI1OWUwZjIgMTAwNjQ0Ci0tLSBh
L3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCisrKyBiL3RhcmdldC9oZXhhZ29uL2hlbHBlci5oCkBA
IC0xMDcsMyArMTA3LDExIEBAIERFRl9IRUxQRVJfNChwcm9iZV9ub3NodWZfbG9hZCwgdm9pZCwg
ZW52LCBpMzIsIGludCwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfc3RvcmVf
czAsIHZvaWQsIGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX2h2eF9zdG9yZXMsIHZvaWQs
IGVudiwgaW50KQogREVGX0hFTFBFUl8yKHByb2JlX3BrdF9zY2FsYXJfaHZ4X3N0b3Jlcywgdm9p
ZCwgZW52LCBpbnQpCisKKyNpZiAhZGVmaW5lZChDT05GSUdfVVNFUl9PTkxZKQorREVGX0hFTFBF
Ul8yKHNyZWdfcmVhZCwgaTMyLCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihzcmVnX3JlYWRfcGFp
ciwgaTY0LCBlbnYsIGkzMikKK0RFRl9IRUxQRVJfMihncmVnX3JlYWQsIGkzMiwgZW52LCBpMzIp
CitERUZfSEVMUEVSXzIoZ3JlZ19yZWFkX3BhaXIsIGk2NCwgZW52LCBpMzIpCitERUZfSEVMUEVS
XzMoc3JlZ193cml0ZV9tYXNrZWQsIHZvaWQsIGVudiwgaTMyLCBpMzIpCisjZW5kaWYKZGlmZiAt
LWdpdCBhL3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jIGIvdGFyZ2V0L2hleGFnb24vb3BfaGVs
cGVyLmMKaW5kZXggNWI5YzI2NmQwMmYuLmNkMzI0YzE5YTlkIDEwMDY0NAotLS0gYS90YXJnZXQv
aGV4YWdvbi9vcF9oZWxwZXIuYworKysgYi90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYwpAQCAt
MTM3NCw2ICsxMzc0LDM0IEBAIHZvaWQgSEVMUEVSKHZ3aGlzdDEyOHFtKShDUFVIZXhhZ29uU3Rh
dGUgKmVudiwgaW50MzJfdCB1aVYpCiAgICAgfQogfQogCisjaWZuZGVmIENPTkZJR19VU0VSX09O
TFkKK3ZvaWQgSEVMUEVSKHNyZWdfd3JpdGVfbWFza2VkKShDUFVIZXhhZ29uU3RhdGUgKmVudiwg
dWludDMyX3QgcmVnLCB1aW50MzJfdCB2YWwpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQo
KTsKK30KKwordWludDMyX3QgSEVMUEVSKHNyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYs
IHVpbnQzMl90IHJlZykKK3sKKyAgICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50
NjRfdCBIRUxQRVIoc3JlZ19yZWFkX3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJf
dCByZWcpCit7CisgICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKK30KKwordWludDMyX3QgSEVM
UEVSKGdyZWdfcmVhZCkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IHJlZykKK3sKKyAg
ICBnX2Fzc2VydF9ub3RfcmVhY2hlZCgpOworfQorCit1aW50NjRfdCBIRUxQRVIoZ3JlZ19yZWFk
X3BhaXIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCByZWcpCit7CisgICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKK30KKyNlbmRpZgorCisKIC8qIFRoZXNlIG1hY3JvcyBjYW4gYmUg
cmVmZXJlbmNlZCBpbiB0aGUgZ2VuZXJhdGVkIGhlbHBlciBmdW5jdGlvbnMgKi8KICNkZWZpbmUg
d2FybiguLi4pIC8qIE5vdGhpbmcgKi8KICNkZWZpbmUgZmF0YWwoLi4uKSBnX2Fzc2VydF9ub3Rf
cmVhY2hlZCgpOwotLSAKMi4zNC4xCgo=

