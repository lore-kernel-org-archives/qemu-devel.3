Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C97ACD6E51
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 21:56:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5Bd-0003Ga-PY; Fri, 29 May 2026 17:56:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5BZ-0003EN-VO
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5BX-0000L4-DK
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:09 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2LvK2998027
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HkjutCmYo3i/HXw/eTYFkcdwmqZY6fH2qYi/G3HdrHU=; b=ZwGcpYjblClu3ih8
 dXZo851VFUfoa8zneUbbQwTsuKfnYjFP4JH1UnOxxsdnx0VhlZz6HNx/zQUGY7kb
 Cf2NCJ+F6ae2zZa24Yg6YDenhT7W1J5a8obZoD41y4vC26mEDiC7CzcuOfQkR0q/
 LLwra5o11kYM4pqbJAVVTXinIUlTQTGfMfOKH2KEWPIb0mlSyj9WhapiiaGe+dzr
 G7OFdZ6g/FTQuyUImByHi/EzN606zCGzW9lN99nmgAvUO3rMkPveaPxLm2E4Hvns
 3Umun2gnTb4LjIrD83fba4fvMEnqqMwaUh9tjC9ntH2bPdTChOeK2b5LEX9rmCrZ
 VPwF7Q==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef4jj4ejp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:06 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304ec73b015so965209eec.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091765; x=1780696565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HkjutCmYo3i/HXw/eTYFkcdwmqZY6fH2qYi/G3HdrHU=;
 b=ckBFHZbViKkrwvBCvoEQt0xVQvuYZHV8BQI0Xmk3spnMfkxNMyB49mt2WO7NozOKN8
 4PKzMu1JX7agsMBpFeeb0wFDLj5+XSvUa6P2H6LLJDt2ALyA6OTdK7z0ad0vvON8w0oA
 9AvQ6Tl/Lg51GTeCJ3YfeeHt/aPWT2juTvDT9MZmYGs0Zew+XO5jVi29DoSEzmrTbuBH
 blFAXXJ5OxM/lHPsIkCQKAZaT2AKBeKvLjuJEfjTxN78Lvu1dSJrbjQFkQYueeN9zHsq
 IhtQnZetZYJ0kG6ELaT3sHhDhnfFARpbGBJcyevU9Dq7EeiqZ4rLw8kKCykVuZoHDl1m
 KTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091765; x=1780696565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HkjutCmYo3i/HXw/eTYFkcdwmqZY6fH2qYi/G3HdrHU=;
 b=Ap28rgggH5TguytCzlflyU0WB2nOfek2j2RGzFTgPKGTbVLCCVLQhMJZiOOvS9qhka
 ME+zB5+ZXaImVADwllHj0UIFhSBSk3oDqUTyZ1puwe9BtVe0hz3TM6dWpy1PF6F1vY61
 Gi+xWiM6+6c6r1b5MIZAZWPnhtb/NCKFJ98iGbjswJl6BEx/TpDBqyFaAmDn17QoMaSd
 lJZlo/bkTPfazoeZovmQDpgph5y6B1O1Vwz8PI7e5Wh4KGb6eel9PIHpN0jUOraVJtz+
 DrLXWngomiHiE6hhMqTS2rAfGuNGzZ85CHpTKxwSO7E2A7muFoYGTRmxPPdAOIkdt3Vu
 wSJg==
X-Gm-Message-State: AOJu0YxVdYt34hQ3/oCFytn1jPa6+pfMXfUqPmlYWaterZYB1m1fz3R5
 BIO5jmyNS7KpjNvXyVbmTa15CrhYaJhzBvgssoH9oxXJVCyAdNnH5ktur/WBlqGNtzDk/JKKG0Z
 WoQITnn9bYoz0X1Lto6JA8MOuXHtIItDLeFQbbE8nN1bw/QW6Iv0B+kLA06xtC4Cdgw==
X-Gm-Gg: Acq92OEPV7y5H+bIEzbYyiO7m8rSAU6CHAaPjggLHt0zLWwltUna0y0X2txXduflK1n
 VkOQD2+mIGRA8rfDO6WQplgBJFwEsIWBxt2Nb3F4jIU481+R5qtaDEheEl8EsKm+bti4jb+vu1U
 tYNKnd2Wq3OPLUIfVkZtD6bZFJ1j3rJo/N6gOkr5L1rKKauxZpDmFvJZmUh9HCK+ZWgqlygKELS
 IljDqQ5QfTYK6VMYPOI1taDETk69QBu/iZ4FvN+mkjA451DMwkoX6iouiXfGFKyAnusZJ3/hfXD
 J4W98HMNYQGUK4m99L2uqcLTy/b80h6KHyWzQB+9Y8wSrd1Pg9in9oB0QrLvWBdmaLXiFqzGCyC
 G8GZUQ1Kl1RYeg/TrreGJRceLdsurdKFqEJtYHJEJF3dHDFhQbVMh8gturwnoCviREyiY8hT8YE
 4rmcGW
X-Received: by 2002:a05:693c:2c0e:b0:2ea:b7a9:580d with SMTP id
 5a478bee46e88-304fa4df21dmr839371eec.9.1780091765310; 
 Fri, 29 May 2026 14:56:05 -0700 (PDT)
X-Received: by 2002:a05:693c:2c0e:b0:2ea:b7a9:580d with SMTP id
 5a478bee46e88-304fa4df21dmr839358eec.9.1780091764299; 
 Fri, 29 May 2026 14:56:04 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:03 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v7 04/38] target/hexagon: Add missing A_CALL attr,
 hintjumpr to multi_cof
Date: Fri, 29 May 2026 14:55:20 -0700
Message-Id: <20260529215554.606133-5-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOCBTYWx0ZWRfX6/buaXmspYoV
 baykJb01x/RGLvEecAiC+wwO0TzGscuiuFOca8zNAUGPvcu79K/JbdxBxQJb468Ws7fD1NAZDTt
 nn45bqJxQGRSGXYgmd4E4nhd9QmfhBRMMx7wSsoynblaxWlRVLranblndxpNNSWg6o2Dhrcd7MB
 PMIldO5DbR2r3D6Xtm0ol7oXMzExbfXNsXloY5VgpL6drLt/ej9PpSavlkXNKEmFqYr7vNYvaXa
 D1bkJvlRWFXJKGG38jOsxeZK0IPPgjeCAgf1QoYOO7ZeJBdI+n7oAbPi4UkGgE2ZOOVgysvgPzr
 uI5XV6QiYe6vFLRWMbBnJuo1AuSO5HIdsrEj2bIdkYFn0ZN6MbBf288elESYIdJlMDMSve+0aIm
 HXCH+VPkoxF+5YUAXRZR9I0s/tAkz9z+L0c9EetX4ETrigiF+U10+rVviTRXHhGTQTCVLsXCzDb
 1o10bVEfWWrQEhN7lmg==
X-Proofpoint-ORIG-GUID: WbFYvOM841g0VzY1-HkQEiBVpRTF02oJ
X-Authority-Analysis: v=2.4 cv=Tt7WQjXh c=1 sm=1 tr=0 ts=6a1a0b76 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=ZLKCIdW5I75hk_SXmpcA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: WbFYvOM841g0VzY1-HkQEiBVpRTF02oJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290218
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpTaWduZWQtb2ZmLWJ5OiBCcmlh
biBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KLS0tCiB0YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5IHwgNCArKystCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weSBi
L3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkKaW5kZXggZTM3ZDVhNTE0ZjAuLjI4MGFlZjBk
ZjNmIDEwMDc1NQotLS0gYS90YXJnZXQvaGV4YWdvbi9oZXhfY29tbW9uLnB5CisrKyBiL3Rhcmdl
dC9oZXhhZ29uL2hleF9jb21tb24ucHkKQEAgLTI0Nyw3ICsyNDcsOSBAQCBkZWYgbmVlZF9uZXh0
X1BDKHRhZyk6CiAKIAogZGVmIG5lZWRfcGt0X2hhc19tdWx0aV9jb2YodGFnKToKLSAgICByZXR1
cm4gIkFfQ09GIiBpbiBhdHRyaWJkaWN0W3RhZ10KKyAgICBpZiBhdHRyaWJkaWN0W3RhZ10gJiB7
IkFfSlVNUCIsICJBX0NBTEwifToKKyAgICAgICAgcmV0dXJuIHRhZyAhPSAiSjRfaGludGp1bXBy
IgorICAgIHJldHVybiBGYWxzZQogCiAKIGRlZiBuZWVkX3BrdF9uZWVkX2NvbW1pdCh0YWcpOgot
LSAKMi4zNC4xCgo=

