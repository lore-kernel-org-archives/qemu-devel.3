Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EF0C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 04:04:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we39z-0002Wg-PW; Sun, 28 Jun 2026 23:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39u-00022Z-86
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1we39q-0006M8-8K
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 23:59:44 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65T2ctfC1545696
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=; b=LdpjrWDbrDUXzAGa
 X2SvYYQEvk49oTXCYGUY6d1dnnHq7wlcNwe9629IGHHtFBe7s1uH9AqDkRZ6546J
 KXJXQkhIPSi/f4AmMNWKRWBEDAPv0/c1sxBHlqEPBjSZQCnSNqVZR7G/LYBAwUPi
 lMsp7e47X5rns5FNrhZpUyvgsGnfz9KAKvhTAdZlFvHPVYNNSmr2Y1EBbAJkjnUm
 jVqjkTDXUkrA+BpoaHrWwJN1IBpUSE6iaKuEhKJ49wicFE3ACkueE9wE7u+GbZ7F
 1cMlspHGM/I4BGgK7X4U+YAkiSXs/atSCQOfo4Jo+zloDBhfVNqRL9lV8E+Z2n8G
 g7Y35g==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27084b0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 03:59:30 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-139b70ca7e5so5903863c88.1
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 20:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782705570; x=1783310370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=IzshDc6Y6yYElydzS6e7y3e80u/ul5RKAW4YWDIkxhQ78GrjyRtO0KLWWRzQkBG0sJ
 CyFLtPUdSdFyjKXhUQ3WYRKpO6b1ED6CypPiGScGb2xnD7EBkebM9SJFCDGsiCOq7IFU
 qJDzA8kaq4hn0irQ9lifmJpN2qcuCKhL4StDGmG5p+8nE5T8h3ZuL4DIpx56BFdM+zSy
 P3KYWHfTG+ndXkNQHYD9Foo8RUB7b4I7F3U5LxsCUBhODs8OJfgQ5IMTL7zuDCFYYTzy
 k4F6ppQ4wv0sdJ0RrKKe084yYGFsYdpM7yO0JG+iZEczgl7tICQhyroDPUw2GR5DlRui
 t/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705570; x=1783310370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xnSW3oZuwood08ngSSOR1Dm8XpJbybm5vIaVrHhZrro=;
 b=I87pYRO7eIsEVOAKJoYJqc5KfCZ/NAstG5MfasvYjFlVFTGr85O1XLwO559D3+m+i+
 bDdb9tnK5LZqtY/FNz6i2MHP1EDQx6YmEMxRRFp/lkLSRPhhc8srvfz9sK46h7yit+4v
 fDxinj7GXFBT9fQVmMSnYsy57B8q38d9c09MdSkCROfXBMjwWLKynv4ZE3Jg7hbnveoV
 XS8L+dijuEiKhI8AE/ca7fqsOglezm5KsPv1P6H1T7zbt6WvPr4UzQCPTJ+zCJcBVJ46
 ByNP66A7uqnjsVImPwAo7KPlpRPO/7FU0VQugqSiqXE2TFXeWJ2chYrX/Ql9oK8F3faC
 sHyQ==
X-Gm-Message-State: AOJu0Yz6TEvpmH0UrxslpdUHon8jM4E6xumlRYYHVaCYeWaQKRWJfzOp
 HABEQisiFwcYvAyDAzDfnsDRFkTGBrFa/3TxGYv2uHW3IdV0PPvP3dSgMCjXl6FFvGmn13mAKos
 NMuStvctyCZLXpjRWTfTHLrxzyqERbGu7FvrRh5mK9S8ucmHdeU/srW7T35sXvCsnlA==
X-Gm-Gg: AfdE7cl/aqykPzavjXPCDSDRWMXnElTXhnuXpPeVKaJO/MbcbROA5wCTaDhNKcF4ySE
 E1kYvMRSR4QDiyQkeIQeTEXJLV6aNo6SF7Hv3MTW2LYkTVyjFfXlOkF6hGKepOelb8VgBLejEfD
 KvGjGYIyTJvOupJHIfOJeZx2rd3+/BhGP7VInMugFFMvf43KoUVYZ/pqpuYNbPdk/BcYD1bqTRY
 EYJbnOeUqZIu1BDP9+7glCD3rdhj46/PbAx4MA5ueH37+HUtxZNzeV3Ch6M/VPW314NcDfEijkc
 Ru0Nr6L9BloP06vHVAFCT0DECMBhClDsUebBSix72eLUPF6Y9UShIG3wjYBPGTecNiHNCdf1BQ+
 HvS1dF8zJLJtj7edFxq+jcXmqARclxqyNsF3tm10NtZTn/yuJOyFday83hFk=
X-Received: by 2002:a05:7022:318:b0:139:89ad:8de6 with SMTP id
 a92af1059eb24-139dbac9ceemr10949916c88.35.1782705570150; 
 Sun, 28 Jun 2026 20:59:30 -0700 (PDT)
X-Received: by 2002:a05:7022:318:b0:139:89ad:8de6 with SMTP id
 a92af1059eb24-139dbac9ceemr10949897c88.35.1782705569514; 
 Sun, 28 Jun 2026 20:59:29 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139fc2ebcc0sm8367088c88.14.2026.06.28.20.59.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 20:59:28 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v4 33/77] target/hexagon: Add representation to count cycles
Date: Sun, 28 Jun 2026 20:57:46 -0700
Message-Id: <20260629035830.1520296-34-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
References: <20260629035830.1520296-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=ObKoyBTY c=1 sm=1 tr=0 ts=6a41eda2 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=gmA5YO3DfmenxuRff1QA:9
 a=tsLLKIjAKpJP5df9:21 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX3x4k7t3xZhRQ
 atQV3vVo0ycnIUHBTqXollZmUoBYre1O4m7LvPzQRTxI3d/xUgfjBHVoYTGkscwD6hJDkpjwT5A
 fLoPUUeWRRfN6gli2cZ3zf4pZTg47F1PF6JzCZzXADSmjnvJsGQwsTI0JIOy0u06qt4TeF5DAmM
 Vj/DfJff23G2ookAdAo4kLsyfIOkwjHxUc0n7ODJfVgxgwvOrYN9M0E3mpJ8WOt5FGRo3iicHPU
 vhOHqXI/HbnseQlh1A8DUTLAfLDdndJoTcYVWwZxEMskUwLGm2J0R/grCJwjTprkI4QrOCYwidG
 2k40fT9iC2o9CFu/Sg8UjqDXuC4mgaQ4c4Jfy7QMGHsNJZ2FBC/PuENPZgzsAuIekAFR2uGml9X
 gmj2TnUpsv7CuJiZS48pX7Uf16rmO59rVmCQVNhyCkVJXEO/bvbiSQ2XepuY1zb7tj3v10Y1dGo
 oi6O+9FDCpNrCVSwPCg==
X-Proofpoint-ORIG-GUID: UUFCQ69KJclWLaUvZeBZ3u51GmUN0d2H
X-Proofpoint-GUID: UUFCQ69KJclWLaUvZeBZ3u51GmUN0d2H
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDAzMSBTYWx0ZWRfX3EJTOQ72ffTV
 0FGzaKgQEty91XR8yDykDmy1M5gpHjQB64x1K1oGUrDf2G7MiQ2DsLRwqJztDkWu7DgQ9qUV6dv
 SNNpULWCrNUSLSjVzCInBF6OlEJ/tLs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290031
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

QWRkIHRfY3ljbGVfY291bnQgdG8gQ1BVQXJjaFN0YXRlIGZvciB0cmFja2luZyBwcm9jZXNzb3IK
Y3ljbGUgY291bnRzIGluIHN5c3RlbSBlbXVsYXRpb24uCgpSZXZpZXdlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4gQ2Fp
biA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2NwdS5o
IHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS1naXQgYS90YXJn
ZXQvaGV4YWdvbi9jcHUuaCBiL3RhcmdldC9oZXhhZ29uL2NwdS5oCmluZGV4IDRiZWE5NTNhYzcz
Li4yNTQwNDU4YjM3MCAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1LmgKKysrIGIvdGFy
Z2V0L2hleGFnb24vY3B1LmgKQEAgLTExMCw2ICsxMTAsNyBAQCB0eXBlZGVmIHN0cnVjdCBDUFVB
cmNoU3RhdGUgewogCiAgICAgLyogVGhpcyBhbGlhcyBvZiBDUFVTdGF0ZS5jcHVfaW5kZXggaXMg
dXNlZCBieSBpbXBvcnRlZCBzb3VyY2VzOiAqLwogICAgIHVpbnQzMl90IHRocmVhZElkOworICAg
IHVpbnQ2NF90IHRfY3ljbGVfY291bnQ7CiAjZW5kaWYKICAgICB0YXJnZXRfdWxvbmcgbmV3X3Zh
bHVlX3VzcjsKIAotLSAKMi4zNC4xCgo=

