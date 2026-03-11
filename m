Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6596AFD88F5
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 04:09:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0Arv-0000lh-Nu; Wed, 11 Mar 2026 00:08:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arn-0000ke-1W
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0Arj-0008SL-FU
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 00:08:13 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B3KZKb303861
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Njn6MJ8QWqE3CW/SVKM0GnudCsF6t33VN9glUGFm1pM=; b=GLznXvrv7XvhEfsH
 Zk7Qlnj1jhEOAfbe9SvWKmpGxBlpujiFP4XLJuvGjrwelp8Km6uOPxxCBlacKHTY
 pLCgL7QrYVDz5XvSzCaYyeeSzmd6D5SP/M1fIHXx1m5oAVmvgb/kv8TgHaxr69eJ
 of+k3Xrt/Ekrc9jsYR9rb3MSAkPAloa+fECMyiCDICg6Le34jJKAflBr39VAZNAV
 fZtgOYH4OOjIRF5Uu6SqXudyuyZWSQCJeHcGDFRNnQI9SiLFHvUWnheIEgyeD3gY
 9J6wEot96eV5xS1jFCEgvtEOT/BvkXa0ZyDbkQUVgMOne739Vg4/cZK7lfsyuY3y
 /cltBw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cthjf3jjd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 04:08:09 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-417371eeb0bso10010346fac.2
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 21:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773202089; x=1773806889; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Njn6MJ8QWqE3CW/SVKM0GnudCsF6t33VN9glUGFm1pM=;
 b=P++SJ5ANqtbvtVN9CFrbiz50VhM59NhSNxCW+dJudMzlyLtoWcYbXD/kBiOnPFDKdv
 GXk7D4lbQnOYSek2QuBTf7cJy8u4ADZNhyJ/GW7DMEZAtiwlXHnOeW8koFRz4tO0VMI7
 y7StQnfiAHZYZqqQ/G2sxRwb/USm7hl3F7c7vNdmk7+FuzTI7AvLX/iLa9T2ubj45sXH
 ti4ZO4qY+5sDfVvrEnUucJcz3xb3L3MRB93jIXVtEhGW0o0/qERvuHt1KtdAoITtJIbK
 Z4UiuU9gBs5iTRnuCQMNqJTcP/lmMqOs6buk0VF9yPEKdwKDtqGfapr+7pB5QGBjDScJ
 QY9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773202089; x=1773806889;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Njn6MJ8QWqE3CW/SVKM0GnudCsF6t33VN9glUGFm1pM=;
 b=eiOul6Sa7L1UgBvDjP1qkgKv0iGmvIk7hCQD42ZfND92FmIq9afC9mgbEw6YoVKxlj
 hJPS9s3xchYbZcwXDZyVWMuQHRbC9RkgRLkUr02tkGtttO4VITfe/WevPKANDcARaHS/
 TD75OTATsgcY23080AuEZ7ZzgJx/Gfa+5y/KUbQbSJfwX+LpIQ/+NlDubNJDr4xDVCpY
 qRYBMbHNxMDad04JKNoMxHK77whqao2KEIzFNbZOptVObu8fdqNkaTEoMAW3+G37nYrZ
 8Kz3ThSmJ4VRRnpDYDwOK7JoxUCrRe5YnQ9plcQTuEN4lNcixe1roBLECFxfJKspVU51
 +2Qw==
X-Gm-Message-State: AOJu0YxCACOoJvzSa8Kai/ZL3SiLuMtLyDLQJsuSfZTaSMi/10vUaJW8
 Je8/uydWEDvUoCeTkYS/4Pp1PB8fMVqX7tr7MQLRVP4y4ap5683/d1JCkk3A0tRuRs/vD1WFxT1
 1sCjcnn6lgpKZnVJ7f1Ezw9JoLsXSlfnFr7poch87JTjZJolC1fugETEiuBeiEp0efA==
X-Gm-Gg: ATEYQzy9YhjC6O8+FFO8qMm8BCwBziTwddTCH5gJyGQSEPK2ZNmWkfZCEhbdzvBfUgZ
 zznSboBQUWaah96QBZ3TLLlFCKLfgxpXTFIv5AurytW3JUEMMg5uCJzRJoCG2v9jQtQec+XeVdG
 Uefiz0So9I3uul+Z6xCEG+0gcwr0U5E6NMKskpD1IRslTylvH48YeBzW7KGbAcF3oCdnAYjjQ74
 E0vi5DYICRQqewpEJq/AH3MJV4Kj8pSz5FQMy3JaLqjHlYOEXU+8F687kWTKnw842hfQ4aidOOM
 uBMK5LGUOdIke5ejGzZf04cbHjj9w70oChul1qDi/oR90qgSwivwkLqNZty05b8+tOUUPj/Kq1o
 XMK9cTeUZDXDeanlW7CYL0oQhprVA2NYRyLwgm93k4LmpBFylfe1OQ+KkGrv5cJ/Y7HjyRQ==
X-Received: by 2002:a05:6870:524:b0:417:369f:4dee with SMTP id
 586e51a60fabf-4177ca529b0mr918352fac.31.1773202088846; 
 Tue, 10 Mar 2026 21:08:08 -0700 (PDT)
X-Received: by 2002:a05:6870:524:b0:417:369f:4dee with SMTP id
 586e51a60fabf-4177ca529b0mr918341fac.31.1773202088468; 
 Tue, 10 Mar 2026 21:08:08 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4177e5ea30asm998656fac.10.2026.03.10.21.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 21:08:08 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v3 02/32] target/hexagon: Implement iassign{r,w} helpers
Date: Tue, 10 Mar 2026 21:07:28 -0700
Message-Id: <20260311040758.1068731-3-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
References: <20260311040758.1068731-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: -YrllAoCJ5cLXTPQjyTMt9TWBGqTs6fN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAzMiBTYWx0ZWRfX0USQMohAe+LJ
 2XOeXFQ2BccocCwDJ9t0KYiRl5WPCnBHyq+SKI8zBsd0FIza+IF0+OpHd5CPPM5kITR2yBcFA2M
 3GbS/LjJ5Qh0URNavnOE18uJdcHcYhB013Rnv8pLJjMefBIr82NWoG4TM4lINPU5C6Y6HusXfbB
 NrSofYkZaGQ3cjsXWApJDNwjXcN7gt/RtsvYK+nAGonEBlYyowcoL4aBJz6fPHmw3JGLQF1pcCA
 mvwzITTsA4Xr7ppG9BzYMYikwvyXftwAOR42opDJn7k2C316rSxUhje0oiq7QGbVc4G7IHxkIzF
 FR8zKLhSQ14/VtJQ3bv3aS2V0h2DgeM5L8SAjrwSZ74RWfGl7bbovApsBKpI4uteQqMtJ5NU+H/
 ELwe2PA12u5fNJNHQ1OfriYzOBFiQ/TbTu+JVu1bGHg2ZFBYVh9bm0rWtSnauynleKp3z++UuF5
 qGRdR5bBEp+KFw4oltg==
X-Authority-Analysis: v=2.4 cv=A71h/qWG c=1 sm=1 tr=0 ts=69b0eaa9 cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=VnV9S1Uu6eltRR5mmX4A:9
 a=QEXdDO2ut3YA:10 a=1zu1i0D7hVQfj8NKfPKu:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -YrllAoCJ5cLXTPQjyTMt9TWBGqTs6fN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110032
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgppYXNzaWdue3Isd30gYXJlIHRo
ZSAiSW50ZXJydXB0IHRvIHRocmVhZCBhc3NpZ25tZW50IHtyZWFkLHdyaXRlfSIKaW5zdHJ1Y3Rp
b25zLgoKUmV2aWV3ZWQtYnk6IFRheWxvciBTaW1wc29uIDxsdGF5bG9yc2ltcHNvbkBnbWFpbC5j
b20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4gPGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNv
bT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyB8IDU0ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9vcF9oZWxwZXIuYyBi
L3RhcmdldC9oZXhhZ29uL29wX2hlbHBlci5jCmluZGV4IDcxMjYzOGRlZmNmLi42YWUwN2NjNjhl
NSAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vb3BfaGVscGVyLmMKKysrIGIvdGFyZ2V0L2hl
eGFnb24vb3BfaGVscGVyLmMKQEAgLTE0MTYsMTIgKzE0MTYsNjIgQEAgdm9pZCBIRUxQRVIoY3N3
aSkoQ1BVSGV4YWdvblN0YXRlICplbnYsIHVpbnQzMl90IG1hc2spCiAKIHZvaWQgSEVMUEVSKGlh
c3NpZ253KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qgc3JjKQogewotICAgIGdfYXNz
ZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDMyX3QgbW9kZWN0bDsKKyAgICB1aW50MzJfdCB0
aHJlYWRfZW5hYmxlZF9tYXNrOworICAgIENQVVN0YXRlICpjcHU7CisKKyAgICBCUUxfTE9DS19H
VUFSRCgpOworICAgIEhleGFnb25DUFUgKmhleF9jcHUgPSBlbnZfYXJjaGNwdShlbnYpOworICAg
IG1vZGVjdGwgPSBoZXhfY3B1LT5nbG9iYWxyZWdzID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxy
ZWdfcmVhZChoZXhfY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19NT0RFQ1RMLAorICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpIDogMDsKKyAgICB0aHJlYWRfZW5h
YmxlZF9tYXNrID0gR0VUX0ZJRUxEKE1PREVDVExfRSwgbW9kZWN0bCk7CisKKyAgICBDUFVfRk9S
RUFDSChjcHUpIHsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICp0aHJlYWRfZW52ID0gJihIRVhB
R09OX0NQVShjcHUpLT5lbnYpOworICAgICAgICB1aW50MzJfdCB0aHJlYWRfaWRfbWFzayA9IDB4
MSA8PCB0aHJlYWRfZW52LT50aHJlYWRJZDsKKyAgICAgICAgaWYgKHRocmVhZF9lbmFibGVkX21h
c2sgJiB0aHJlYWRfaWRfbWFzaykgeworICAgICAgICAgICAgdWludDMyX3QgaW1hc2sgPSB0aHJl
YWRfZW52LT50X3NyZWdbSEVYX1NSRUdfSU1BU0tdOworICAgICAgICAgICAgdWludDMyX3QgaW50
Yml0cG9zID0gKHNyYyA+PiAxNikgJiAweEY7CisgICAgICAgICAgICB1aW50MzJfdCB2YWwgPSAo
c3JjID4+IHRocmVhZF9lbnYtPnRocmVhZElkKSAmIDB4MTsKKyAgICAgICAgICAgIGltYXNrID0g
ZGVwb3NpdDMyKGltYXNrLCBpbnRiaXRwb3MsIDEsIHZhbCk7CisgICAgICAgICAgICB0aHJlYWRf
ZW52LT50X3NyZWdbSEVYX1NSRUdfSU1BU0tdID0gaW1hc2s7CisKKyAgICAgICAgICAgIHFlbXVf
bG9nX21hc2soQ1BVX0xPR19JTlQsICIlczogdGhyZWFkICIgVEFSR0VUX0ZNVF9sZAorICAgICAg
ICAgICAgICAgIiwgbmV3IGltYXNrIDB4JSIgUFJJeDMyICJcbiIsIF9fZnVuY19fLAorICAgICAg
ICAgICAgICAgdGhyZWFkX2Vudi0+dGhyZWFkSWQsIGltYXNrKTsKKyAgICAgICAgfQorICAgIH0K
KyAgICBoZXhfaW50ZXJydXB0X3VwZGF0ZShlbnYpOwogfQogCiB1aW50MzJfdCBIRUxQRVIoaWFz
c2lnbnIpKENQVUhleGFnb25TdGF0ZSAqZW52LCB1aW50MzJfdCBzcmMpCiB7Ci0gICAgZ19hc3Nl
cnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50MzJfdCBtb2RlY3RsOworICAgIHVpbnQzMl90IHRo
cmVhZF9lbmFibGVkX21hc2s7CisgICAgdWludDMyX3QgaW50Yml0cG9zOworICAgIHVpbnQzMl90
IGRlc3RfcmVnOworICAgIENQVVN0YXRlICpjcHU7CisKKyAgICBCUUxfTE9DS19HVUFSRCgpOwor
ICAgIEhleGFnb25DUFUgKmhleF9jcHUgPSBlbnZfYXJjaGNwdShlbnYpOworICAgIG1vZGVjdGwg
PSBoZXhfY3B1LT5nbG9iYWxyZWdzID8KKyAgICAgICAgaGV4YWdvbl9nbG9iYWxyZWdfcmVhZCho
ZXhfY3B1LT5nbG9iYWxyZWdzLCBIRVhfU1JFR19NT0RFQ1RMLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGVudi0+dGhyZWFkSWQpIDogMDsKKyAgICB0aHJlYWRfZW5hYmxlZF9tYXNr
ID0gR0VUX0ZJRUxEKE1PREVDVExfRSwgbW9kZWN0bCk7CisgICAgLyogc3JjIGZpZWxkcyBhcmUg
aW4gc2FtZSBwb3NpdGlvbiBhcyBtb2RlY3RsLCBidXQgbWVhbiBkaWZmZXJlbnQgdGhpbmdzICov
CisgICAgaW50Yml0cG9zID0gR0VUX0ZJRUxEKE1PREVDVExfVywgc3JjKTsKKyAgICBkZXN0X3Jl
ZyA9IDA7CisgICAgQ1BVX0ZPUkVBQ0goY3B1KSB7CisgICAgICAgIENQVUhleGFnb25TdGF0ZSAq
dGhyZWFkX2VudiA9ICYoSEVYQUdPTl9DUFUoY3B1KS0+ZW52KTsKKyAgICAgICAgdWludDMyX3Qg
dGhyZWFkX2lkX21hc2sgPSAweDEgPDwgdGhyZWFkX2Vudi0+dGhyZWFkSWQ7CisgICAgICAgIGlm
ICh0aHJlYWRfZW5hYmxlZF9tYXNrICYgdGhyZWFkX2lkX21hc2spIHsKKyAgICAgICAgICAgIHVp
bnQzMl90IGltYXNrID0gdGhyZWFkX2Vudi0+dF9zcmVnW0hFWF9TUkVHX0lNQVNLXTsKKyAgICAg
ICAgICAgIGRlc3RfcmVnIHw9ICgoaW1hc2sgPj4gaW50Yml0cG9zKSAmIDB4MSkgPDwgdGhyZWFk
X2Vudi0+dGhyZWFkSWQ7CisgICAgICAgIH0KKyAgICB9CisKKyAgICByZXR1cm4gZGVzdF9yZWc7
CiB9CiAKIHZvaWQgSEVMUEVSKHN0YXJ0KShDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMyX3Qg
aW1hc2spCi0tIAoyLjM0LjEKCg==

