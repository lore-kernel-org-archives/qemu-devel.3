Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE7CCDB46B
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 23:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbndW-0003BC-PM; Mon, 22 Jun 2026 19:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndS-00038Z-HZ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbndR-0002bz-0l
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 19:00:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJa1X91542081
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=; b=YzOM4F1sWz57U4MG
 ljiaULtwZJnXGliG0h6cRvpivjU5N/1QR7KGcyt+AKKm9nE182xi5UozUnUrykKL
 2HAW1sh2mFFxtpmjjbrTu5f30gcPgipojAYfloOeajfdsXGKiJHHvjlJVCZI1QEm
 sP8pTPhDr/BAFSbrXu9L/HP/P4eda1UJYJBa3WEuF1k8tMNTyQlsQCPBoGg97JP0
 PRJTOC7dkAH6jJYVRDCp8JVopiYnItwN6R+r3pTvL4gb9t3EGDbsizyIRJx1dGWc
 H+HPWn1mTq1XAHsp2W6U5idtkIPZKw5OrZp4z3AVVR6Q1IUVZJCew9hdM6s3kTSh
 mMEKpg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0tjha-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 23:00:55 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-30c5319332eso1117030eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 16:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782169255; x=1782774055; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=;
 b=flniaPjswQ0LxTekHxMalMyXu2KMJEm6ARmjcSdhrlKmTnfU4dwVycNGmjCBIawuCX
 oVh0AgoxEkxYc3Q5ygzpn1p3oN2VATkT9RlPvaPJz/D8BYVzTH8BTuEbsVt4NW+LH47T
 887V2PVzGw7OouTRBDqkwQb0IN1uHpo1+JXCFvyEbPKvFIBIB1E/V4APR2s7pASqf7gn
 yMdNlNW5D1k5arptfm8vDZYUDKwP+ZfJW+04wZoVzIC+BAsrbFpvh8gdQM7zm2AaiC+/
 qY/FlHmafxjTFdp1z7kJiQHd/pZNeMg6DNGBmkwjlPNfckG/iA80J5K1g1zSh4Yn73v9
 A6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782169255; x=1782774055;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rn3nrXF+9M3gB0m5jL2ztn1CUMGQuvNbgLv/5EwohVs=;
 b=XrjWS1tSuwuEfXF6FYb7Djw4YLo169AV4xGME1tXtWwpWGWUwduTXO5DngvGd+fcTh
 I2JDUOLtxADoMHSlJXvsH6BAd95ZPhs3YSoT5GiGJZA7f3ZoVcxSFNwg4swg2HvLCIAS
 fYNyXVc1eBcezVzYGtj1+NPNTg5C3NpHwtMhqgBEieVAzaz/rgfaXQwCiHhp0IeRyeW9
 np+b12nHm+NnNQ7zBCT6rWSORCCiA/nWeY/InHmxm4GMpULQkOsW/IXI5WJD8LSpojdB
 YrTaUHQQixutkKeeFfgYJNmlBkb0ac58Gad1NLfDtwwC106pIGuKDznhbz3bjKBJdtTU
 y5vg==
X-Gm-Message-State: AOJu0Yx8xTV/W5STVyiOjNGGi8uBF/ixGvnuH1slso20F+q9WMAjmHcR
 1ryTeFaQp0iM5jQP2ne8x0pY1BRm0TBwSA+1P+alT6g+xSn99F7oA4krWe/4r1iq1laemAduQrg
 7mH39pCpyahuHR6pKuwvhUPTCMm/csVpND7ICufk3ScTIV1S/te4HFAR/QAXxsQOX2g==
X-Gm-Gg: AfdE7cnk0NiowDjYKcSU0R/30dOE7yH/h7lblE8nxh89zczHETeRP44W4MJ6U1rkun7
 U3n3Ve/W0eLPbR7n4L+nkZF6itt0bcnA3uJ6z+AVHsMyaq6dKPGcek6piaM/vQmU3TA2BARqXN7
 uCLja8zpyg9+8XsQJYOtT/pr+I4l1SvUg/+SFSKRVKRXXfJAExiNczdx1+rrqVvjVpiYOgk+6hz
 vohgymwV6ZwKG8S/Jm4NQ0ZuQquLxC9OyKK3qSUmbIyeOKQJRC1WRRHbSTNUC8/LAbefG2lw06R
 A6Lwo8lc/dUzGcAYb7AhBf/AWYJ++W5VuMga6arxskUKneXCsEnW5bl90rYX056URpDQAuE36hG
 OMmdonB+9jIMEzdRlv10EGdpQL+YEzPvoRnkethZXvx4+JoikOSAp04qXQXk=
X-Received: by 2002:a05:7022:e995:b0:137:fe07:8a2d with SMTP id
 a92af1059eb24-139a2035cf9mr10308002c88.6.1782169254839; 
 Mon, 22 Jun 2026 16:00:54 -0700 (PDT)
X-Received: by 2002:a05:7022:e995:b0:137:fe07:8a2d with SMTP id
 a92af1059eb24-139a2035cf9mr10307962c88.6.1782169254162; 
 Mon, 22 Jun 2026 16:00:54 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139add73a44sm9128726c88.13.2026.06.22.16.00.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 16:00:53 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Sid Manning <sidneym@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 71/75] hw/hexagon: Add support for cfgbase
Date: Mon, 22 Jun 2026 15:29:00 -0700
Message-Id: <20260622222904.607771-72-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX35udEXzKReum
 TBfQU8BOJNOBNk64U0fxAzW/45zL/zQSNVylNhzCVYL4Jr01VkvCb4VWvabFg7K2++6PthGbW/E
 GjjsSppVbC1tTDKc3BiI5OGONXpMeZQ=
X-Proofpoint-GUID: z0fgKZYyfGrZJgoHHxbp96vtnbQ_6cEJ
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a39bea7 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=7umkzkyUMl8fFcUskJ4A:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIyMSBTYWx0ZWRfX3srmF1b69qb8
 a2DcgK72a1CMNHLg0WnFlhI80/RD02F5MWHcU0LdNzhDD02UllAMkrF+WgZBbsdLJqGcOhTitdO
 2UtUJd8xuJExqw4qG0fwNDijwf+o4SpaXEBP0BzzIPysWXS8uiuUJqNFPzbJ2P2yb6GkVi/AioZ
 +8CnaF18jjWWS2Spyy9VGDmrFpLn4n4hhN/HSishGb2oov5P4n/9jYCXIIxJ/yaexBDiyojGiph
 MRL7/PE8Z3kSEbgRtjd4qaJ+q827uTUAAXCQodMIXyH65nTBpUpqq+BUJ20KTCyj4nwzenx5VYd
 zIK9b1hvZUnjUeVAo/egdVpm4lJ9stZMgBN4TXQk5pm4DTsc5ZFPCTaTs4vyOnW1kmp4YIk83ot
 lZ8AkmgOvHF84CytDwVdmDcRkqy+2wpH/ymf7pdQJaODKYDAcanuzS6sTrgviuAIueydcjODkWC
 5RI2Dhl222qJ/utJU3g==
X-Proofpoint-ORIG-GUID: z0fgKZYyfGrZJgoHHxbp96vtnbQ_6cEJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220221
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

RnJvbTogU2lkIE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5
bG9yIFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogU2lk
IE1hbm5pbmcgPHNpZG5leW1AcXVpY2luYy5jb20+ClNpZ25lZC1vZmYtYnk6IEJyaWFuIENhaW4g
PGJyaWFuLmNhaW5Ab3NzLnF1YWxjb21tLmNvbT4KLS0tCiBody9oZXhhZ29uL2hleGFnb25fZHNw
LmMgfCA0ICsrKysKIHRhcmdldC9oZXhhZ29uL2NwdS5jICAgICB8IDEgLQogMiBmaWxlcyBjaGFu
Z2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9ody9oZXhh
Z29uL2hleGFnb25fZHNwLmMgYi9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMKaW5kZXggYWMwMWQz
NTk5MjguLmFhNDkzOTkzMjI5IDEwMDY0NAotLS0gYS9ody9oZXhhZ29uL2hleGFnb25fZHNwLmMK
KysrIGIvaHcvaGV4YWdvbi9oZXhhZ29uX2RzcC5jCkBAIC0xNjIsNiArMTYyLDEwIEBAIHN0YXRp
YyB2b2lkIGhleGFnb25fY29tbW9uX2luaXQoTWFjaGluZVN0YXRlICptYWNoaW5lLCBSZXZfdCBy
ZXYsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBPQkpFQ1QodGxiX2RldiksICZl
cnJvcl9mYXRhbCk7CiAgICAgICAgIHFkZXZfcmVhbGl6ZV9hbmRfdW5yZWYoREVWSUNFKGNwdSks
IE5VTEwsICZlcnJvcl9mYXRhbCk7CiAgICAgfQorCisgICAgcm9tX2FkZF9ibG9iX2ZpeGVkX2Fz
KCJjb25maWdfdGFibGUucm9tIiwgJm1fY2ZnLT5jZmd0YWJsZSwKKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgc2l6ZW9mKG1fY2ZnLT5jZmd0YWJsZSksIG1fY2ZnLT5jZmdiYXNlLAorICAgICAg
ICAgICAgICAgICAgICAgICAgICAmYWRkcmVzc19zcGFjZV9tZW1vcnkpOwogfQogCiBzdGF0aWMg
dm9pZCBpbml0X21jKE1hY2hpbmVDbGFzcyAqbWMpCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdv
bi9jcHUuYyBiL3RhcmdldC9oZXhhZ29uL2NwdS5jCmluZGV4IDA2YmU1YzhkNDk4Li40MmQ5M2U1
ZGE0NyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmMKKysrIGIvdGFyZ2V0L2hleGFn
b24vY3B1LmMKQEAgLTQwMCw3ICs0MDAsNiBAQCB2b2lkIGhleGFnb25fY3B1X3NvZnRfcmVzZXQo
Q1BVSGV4YWdvblN0YXRlICplbnYpCiB9CiAjZW5kaWYKIAotCiBzdGF0aWMgdm9pZCBoZXhhZ29u
X2NwdV9yZXNldF9ob2xkKE9iamVjdCAqb2JqLCBSZXNldFR5cGUgdHlwZSkKIHsKICAgICBDUFVT
dGF0ZSAqY3MgPSBDUFUob2JqKTsKLS0gCjIuMzQuMQoK

