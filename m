Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689E9C98318
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 01:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9v9s-0005DH-NH; Thu, 24 Sep 2026 21:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9m-0005Be-GL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1x9v9j-000661-Mc
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 21:55:21 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P1l9XD3885452
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 guMuSpkJh4ywaheNw4BuJpOegoZiRuIVSSULtLUUsTY=; b=ZZa2ArxiL6E+oCby
 mvNoDEY/us3dr9g0QTTImnZLK1YjQlL98WB02TO7RDxydZEzne6Cb5Oy8AOQ2PcV
 GIWPK+KAQtEag7yjNr4djGf8oV6acW1Y9gRkfv7E0pNsMldSvp0hRdq3avYYsq8k
 fBV0Wgr0tDrB4EkWvMN7BrV9lg7+MycRr8EbjjtmkcbhbnbEeGOR9Z8GhwZPtL01
 ILm1RzJL7RWysHumA8UIMl7UA/CE0w2Lj3cvZXtOMpMLqmEWyBFM6c+iSevyepwV
 BDkCXRIvMmzGqPXg2ul/m7LifAz+91pwu8OI41jY9Mvgw6nY0/MkgUMC2ihj1ngT
 a0w0KA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw4652s2s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 01:55:08 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33baaba6371so1434781eec.1
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 18:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790301307; x=1790906107; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=guMuSpkJh4ywaheNw4BuJpOegoZiRuIVSSULtLUUsTY=;
 b=Y2i60TrNIpj8HTY6WJiqEb9+9l6nXCxPKi/oLMKi9YW9lmgsoMnuC0qxJH7jGWVEQY
 vTR0gQZtFfr8RhoJ9uj534IOGS0AmAKySozlE+xlXW2zTGuwe9xrrueCtwREMPFZkoaX
 bsh91SVix7mqoNIXnxygY6F+xCfJq7w1zEM018fkD79TKrZFoLgWN/T7gq8uAbl3Fn2L
 ixwFCXwyPFKVcHbUbV8ivvBRnHE70/z3ToGqwMXDSfwG3JgLgv3TVI8vQq1y7YSMySYy
 FQGbfuUGQ3jtpcgfwtBBrsCbczP29kFnM18x3ExZfSdFjmjTUxjWBS3ClHrClXQ//8wI
 8HXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790301307; x=1790906107;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=guMuSpkJh4ywaheNw4BuJpOegoZiRuIVSSULtLUUsTY=;
 b=eRE/q2i6D+E68YNuQiKJQMAokqWW8l2Oitzk8SEeXQni/HYik9Xe2v9kVKnUAz/e7r
 lFi4P8E4E3bM5j1rykvc8KrfeMU6knzjhjzAbEsK2Tt9z9Vl9/D2cueGF+w5MoaPi6zO
 n+hLlsRmRjOHKkhlKHV0bWmEBRro0DsDgSxycpRuOEXwvFNTMLnvyxA7ZfZhircFLhzT
 gngrkewPIaq3SC05PimIrkJMT48wfvtFBv4qei2uUg/xz8u+9RXdNTcw3rXdL8nZ+bJ6
 b+uUC+LkOLCaKEeJehaDLc2PwqmUqx/y6r6Aynu9l9s76Vno+tDT8V/TizFoeQPyow3d
 PSGg==
X-Gm-Message-State: AFuF++luUlxgvjW95ec5BOBtJ3IHATc2i0nUJOPQbXgtRnbxphXG39Qf
 zdTDf8Uw2oYFlTZzxUjyI5M49ZvT0MNoWRayEvp5Xsc/RTM8KOuqz+EIkc12MmcwFTwwJU5z6YG
 6Uc7Okvt9Dj27IGXDltaSyJr/oNoiT6NaKt3r+0J0Q9ysHoqc7j5+7y7vieuxAfti4g==
X-Gm-Gg: AYBFou0/YLmPYqg/tnCg81AqLgjrIodV9i/kdhEFJGqfuTto7LOx3DB+tEoO7/3ASMF
 4LuNCOqLWsTXFwe2yWaaJin7kWRAO26KZbFYJ7P12sYOx0hscDZYFkpLXCrJnYVya82KNNzUMrY
 cKJeT6Q/ScKoLJzGVHPZR/jQKKNU0WiIopB714mgwe/lVPNam9ImqEpDflnzoqMGpm+SKGpro30
 Lmm6sA/3RLMQ2d/Z84auZ/A7XJ/hfbbhISIhd3ixyX+p/e/1BwoYdxgov8QIsqlyAoviPrbKNqS
 rIDruVKSFbEamyfSmq9tpypBoRQqCHQ6hnRsAu8Tlc+9NIQJaG5UtE/UgpQa4TymCRX760m+xKw
 QH1ohhWKEvpQ21EzLzA/T9boxGgNf/Vo+BhvPL9XFsR4jBXU=
X-Received: by 2002:a05:7300:8189:b0:33c:3515:daf4 with SMTP id
 5a478bee46e88-340034c1e5amr5311847eec.27.1790301307370; 
 Thu, 24 Sep 2026 18:55:07 -0700 (PDT)
X-Received: by 2002:a05:7300:8189:b0:33c:3515:daf4 with SMTP id
 5a478bee46e88-340034c1e5amr5311815eec.27.1790301306816; 
 Thu, 24 Sep 2026 18:55:06 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3416e4c2f50sm1873720eec.27.2026.09.24.18.55.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 18:55:06 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 peter.maydell@linaro.org
Cc: brian.cain@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL 22/40] tests/tcg/hexagon: add dfmpyhh
Date: Thu, 24 Sep 2026 18:54:11 -0700
Message-Id: <20260925015429.2579174-23-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
References: <20260925015429.2579174-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=Wrq+otfv c=1 sm=1 tr=0 ts=6ab5d47c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=7ev5N2rqXU9IWHHYf1oA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: 8ChbBH8rImO4Nz9zOxjI6BNy9lx0vwiN
X-Proofpoint-GUID: 8ChbBH8rImO4Nz9zOxjI6BNy9lx0vwiN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX/KQ5bN8n624G
 uKIvgQUSbxVfJAqVPk6DQtq05pfN0wCDl5fooFByL2HjpcQe3yNy522bj0HaalfwYVKLv5k53Tp
 yrw2xLnW3ha4cUj6RisofGcR96cSvwzee0nOi2Dkh3aQeRpP6y99pUbsiZ28KFGPPRbi0Bv5k+V
 H+UwWr9hE1oGO/NAC28XdYQ9bZN3aSpM2RoJCZvib4Y876MR8fo2wwedjhRdYfAhx4x0cYXFX3c
 Akb7a+idUKc2wpEJtVz4N7b1QNTnqYE7H96fzaPbNVL1ZyY2ufHHg0KOZg1LvtBO2yg9Nz5PCYo
 /iWLANAoqlxNAjq90JWflyz4aJDF/fJi8+d80JiKhIHrMf5VO3KHuu/HhA7SO1qp+1rPrVMcZGC
 tEdLFp7pYxMhlxVsC2wGQMhOq5ERQ1/nMtDRwqVolETeNqSZOR7W/cW9hqgECk9jm+k9Qp7MHne
 MT3SWMa1MTyIT1afm7A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAwNyBTYWx0ZWRfX+LNBsAy8BE0F
 9MO41HNRIenix3+S0Xw3fsqpZ0EPx5fgp1jOtYefgOIDzFZ1wObrhCj2WCcMJ5gNc1bMZuteabE
 cf/oj8qtbrtCM+dBfDD5eb3MViT9An0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250007
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

VGVzdCB0aGUgZGZtcHloaCBpbnN0cnVjdGlvbi4KClJldmlld2VkLWJ5OiBQaWVycmljayBCb3V2
aWVyIDxwaWVycmljay5ib3V2aWVyQG9zcy5xdWFsY29tbS5jb20+ClNpZ25lZC1vZmYtYnk6IEJy
aWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiB0ZXN0cy90Y2cvaGV4
YWdvbi9mcHN0dWZmLmMgfCA1NyArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
CiAxIGZpbGUgY2hhbmdlZCwgNTcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rlc3RzL3Rj
Zy9oZXhhZ29uL2Zwc3R1ZmYuYyBiL3Rlc3RzL3RjZy9oZXhhZ29uL2Zwc3R1ZmYuYwppbmRleCBm
ODIyNjJhYjRhYy4uMGYyOGEyMThkODQgMTAwNjQ0Ci0tLSBhL3Rlc3RzL3RjZy9oZXhhZ29uL2Zw
c3R1ZmYuYworKysgYi90ZXN0cy90Y2cvaGV4YWdvbi9mcHN0dWZmLmMKQEAgLTkzNSw2ICs5MzUs
MTYgQEAgc3RhdGljIHVpbnQ2NF90IGRvX2RmbXB5Zml4KHVpbnQ2NF90IGEsIHVpbnQ2NF90IGIp
CiAgICAgcmV0dXJuIHJlc3VsdDsKIH0KIAorc3RhdGljIHVpbnQ2NF90IGRvX2RmbXB5aGgodWlu
dDY0X3QgYSwgdWludDY0X3QgYiwgdWludDY0X3QgYWNjKQoreworICAgIHVpbnQ2NF90IHJlc3Vs
dCA9IGFjYzsKKworICAgIGFzbSgiJVtyZXNdICs9IGRmbXB5aGgoJVthXSwgJVtiXSlcblx0Igor
ICAgICAgICA6IFtyZXNdICIrciIocmVzdWx0KQorICAgICAgICA6IFthXSAiciIoYSksIFtiXSAi
ciIoYikpOworICAgIHJldHVybiByZXN1bHQ7Cit9CisKIHN0YXRpYyB2b2lkIGNoZWNrX2RmbXB5
Zml4KHZvaWQpCiB7CiAgICAgLyoKQEAgLTk2MSw2ICs5NzEsNTIgQEAgc3RhdGljIHZvaWQgY2hl
Y2tfZGZtcHlmaXgodm9pZCkKICAgICAgICAgICAgIDB4MDAxMDAwMDAwMDAwMDAwMFVMTCk7CiB9
CiAKKy8qCisgKiBUZXN0IGRmbXB5aGggKGRvdWJsZS1wcmVjaXNpb24gRlAgbXVsdGlwbHkgaGln
aCpoaWdoIGFuZCBhY2N1bXVsYXRlKToKKyAqICAgLSBub3JtYWwgaW5wdXRzCisgKiAgIC0gZGVu
b3JtYWwgaW5wdXRzIChjcnVzaGVkIHRvIGluZXhhY3QgemVybykKKyAqICAgLSB6ZXJvL05hTi9p
bmZpbml0eSBpbnB1dHMKKyAqICAgLSBub256ZXJvIGFjY3VtdWxhdG9yCisgKi8KK3N0YXRpYyBp
bmxpbmUgdWludDY0X3QgZGZfYWJzKHVpbnQ2NF90IHYpIHsgcmV0dXJuIHYgJiAweDdGRkZGRkZG
RkZGRkZGRkZVTEw7IH0KK3N0YXRpYyBpbmxpbmUgdWludDY0X3QgZGZfZXhwKHVpbnQ2NF90IHYp
IHsgcmV0dXJuIHYgJiAweDdGRjAwMDAwMDAwMDAwMDBVTEw7IH0KK3N0YXRpYyBpbmxpbmUgdWlu
dDY0X3QgZGZfbWFudCh1aW50NjRfdCB2KSB7IHJldHVybiB2ICYgMHgwMDBGRkZGRkZGRkZGRkZG
VUxMOyB9CisKK3N0YXRpYyB2b2lkIGNoZWNrX2RmbXB5aGgodm9pZCkKK3sKKyAgICB1aW50NjRf
dCByZXN1bHQ7CisKKyAgICAvKiBOb3JtYWwgKiBub3JtYWw6IDEuMCAqIDEuMCArIDAgLT4gbm9u
emVybyBmaW5pdGUgKi8KKyAgICByZXN1bHQgPSBkb19kZm1weWhoKERGX29uZSwgREZfb25lLCAw
VUxMKTsKKyAgICBjaGVjazY0X25lKGRmX2FicyhyZXN1bHQpLCAwVUxMKTsKKworICAgIC8qIERl
bm9ybWFsIGlucHV0IGE6IGNydXNoZWQgdG8gemVybyAqLworICAgIHJlc3VsdCA9IGRvX2RmbXB5
aGgoMHgwMDA4MDAwMDAwMDAwMDAwVUxMLCBERl9vbmUsIDBVTEwpOworICAgIGNoZWNrNjQoZGZf
YWJzKHJlc3VsdCksIDBVTEwpOworCisgICAgLyogRGVub3JtYWwgaW5wdXQgYjogY3J1c2hlZCB0
byB6ZXJvICovCisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChERl9vbmUsIDB4MDAwODAwMDAwMDAw
MDAwMFVMTCwgMFVMTCk7CisgICAgY2hlY2s2NChkZl9hYnMocmVzdWx0KSwgMFVMTCk7CisKKyAg
ICAvKiBaZXJvIGlucHV0OiBlYXJseSBleGl0ICovCisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChE
Rl96ZXJvLCBERl9vbmUsIDBVTEwpOworICAgIGNoZWNrNjQoZGZfYWJzKHJlc3VsdCksIDBVTEwp
OworCisgICAgLyogSW5maW5pdHkgaW5wdXQ6IGVhcmx5IGV4aXQsIHJlc3VsdCBjb250YWlucyBp
bmYgKi8KKyAgICByZXN1bHQgPSBkb19kZm1weWhoKDB4N0ZGMDAwMDAwMDAwMDAwMFVMTCwgREZf
b25lLCAwVUxMKTsKKyAgICBjaGVjazY0KGRmX2V4cChyZXN1bHQpLCAweDdGRjAwMDAwMDAwMDAw
MDBVTEwpOworCisgICAgLyogTmFOIGlucHV0OiBlYXJseSBleGl0LCByZXN1bHQgaXMgTmFOICov
CisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChERl9RTmFOLCBERl9vbmUsIDBVTEwpOworICAgIGNo
ZWNrNjQoZGZfZXhwKHJlc3VsdCksIDB4N0ZGMDAwMDAwMDAwMDAwMFVMTCk7CisgICAgY2hlY2s2
NF9uZShkZl9tYW50KHJlc3VsdCksIDBVTEwpOworCisgICAgLyogTm9uemVybyBhY2N1bXVsYXRv
cjogbm9uemVybyBmaW5pdGUgcmVzdWx0ICovCisgICAgcmVzdWx0ID0gZG9fZGZtcHloaChERl9v
bmUsIERGX29uZSwgREZfb25lKTsKKyAgICBjaGVjazY0X25lKGRmX2FicyhyZXN1bHQpLCAwVUxM
KTsKKyAgICBjaGVjazY0X25lKGRmX2V4cChyZXN1bHQpLCAweDdGRjAwMDAwMDAwMDAwMDBVTEwp
OworfQorCiBpbnQgbWFpbigpCiB7CiAgICAgY2hlY2tfY29tcGFyZV9leGNlcHRpb24oKTsKQEAg
LTk4MSw2ICsxMDM3LDcgQEAgaW50IG1haW4oKQogICAgIGNoZWNrX2NvbnZfdXcyZGYoKTsKICAg
ICBjaGVja19jb252X3VkMmRmKCk7CiAgICAgY2hlY2tfZGZtcHlmaXgoKTsKKyAgICBjaGVja19k
Zm1weWhoKCk7CiAKICAgICBwdXRzKGVyciA/ICJGQUlMIiA6ICJQQVNTIik7CiAgICAgcmV0dXJu
IGVyciA/IDEgOiAwOwotLSAKMi4zNC4xCgo=

