Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D49CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:34:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXXzK-000804-8L; Thu, 11 Jun 2026 01:29:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzH-0007ww-86
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXXzE-0000rx-BC
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:29:54 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GBG73815511
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=; b=pgd4uJO7Odr3nRJi
 0LRfc558yaEdlbRNPnQ2hy4Hmeh3+xek2QspjYt+26VNcF+w+sB5kMpvpgXEIAR3
 v2lPRnIn/ieVvuHxJy75LAm2SCqHr4twY5ypjSINxrf528KnsF2hMLvZV/cLiHyk
 brpiSQf2AbJZDvqvVcW9tdCI8/0rsXmxhknGTRdUifV7/BAph78E0tUgxWVHzOIj
 LdPtK8Ew8mAtplsCIeOhXZ793RlyeBIAHLAHQttRFBlEoJJmRQrmsSV43mctzDI4
 Dw6q9DGasn6AvIA1+Oy/Rfi+zfU1WcgTFpoKZguC+0cpfIOB6cnEBWWjk4/Fuj8y
 FwFczw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6u1rrd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:29:40 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-304f23c55b2so8211366eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781155780; x=1781760580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=CKHkcTUGIs8hR1j1Bv+TCRgS187GggFph5W5WBYW10uhTauH4o1Ecd2uCPQVSKItq8
 0Idwwz5r96BGeutSmyDTL5amqMXz2kRTl/M/mxsEK/gJyiADn8mv/HxldVBloiO+aOW0
 5xtB4I0SThyRRFHUPszJ0M+cn/Qvx/BOPuVdiShDKKz9xCSmFirBdlYbQD7FTGDFIHfC
 g+GyuAJq83jUy7JUMofZ10DGlucQYRvqLpcbtTUIGr9sss7S4dPtosNhk9fTIS3n1vMv
 rbJxPIc2fuCtYbahy7mruWCDxsEj0R+cBzvZhdQgsNtIJTiyjlXFyeWFL+ilfUSF7VBi
 QTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781155780; x=1781760580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A6hX7dXQXO1+fIeZgKUska/ZVbxUwMZyizq5wXsBD70=;
 b=Gt96FDmerNielLu2kJBtPoqfTHbYExe+BIXSLpAMjIedsrFgCG4/ai0OdhIgSGQlRN
 xNQf99erSkzx0ZBqBkJo6UAVCFiZxC6+Xz6umzqyX44pBpuKpeU+KJckP7E1H/SpkDbQ
 Xi71Nq6TYFUCjEPubaijoDb6Gl0W5vsrGrh7L6+1USsEN4mVOrRmmrj7jQ66Oyk+/cCf
 ZpRKS+129hYB09SiFOLOh8tBu4DbKKh0A6EAUdLX0hkLqYlCNgEgStQ8zec8+g2r3A1F
 8SRW2eSm0pvIzYw9hx0/F67UXP+BUgR/DL8yWvdWmuu9kwUKu+sMjQXxpSixFQdX/m4B
 EuWw==
X-Gm-Message-State: AOJu0YzmWOTc4sOId4bdTg9OYcDOS6G2RHlPexzJ4pdWoQ7uIw0XjarB
 +yiCUt9hBVmrwBFgNkTn1cLz49Mhh8PgSSz5RsjkZ/tIPQMpiOUuvj+0poexajfG2UwGxvLkB0o
 BnZQcQzYfFKp+p4lXrfPUhPzM39+p0jvQmEV5jnyfuo0CmfxwA0hRDpIDHGZ5ymNQbg==
X-Gm-Gg: Acq92OF4S64faVhmIVkqmXdttulFzSRkjGT1VmRvRRlGfWBPThL5l1+CT+EUa6FApcJ
 eIzex8flp6rQTO4rLbnMs4ouF0VaF2qyE8NPmMNlo1trwsqoeenWJf1SijFb697ZVljoOdeSEmU
 PVzvpI9bPU0DX2Y9jUKHyKaAcO5VInlafIn2aGCqxxZv3rNUK2Geb7v+Jw3X14hVmnDhHBLxyNS
 PV8bNPuHRD12VI/IKt/Rf8TS41zVH9EBsMc3hmP32kDZiY2IrOtO7OaohWm3u//nQWZxGyttAyy
 AFSRUvBoORwPftFNi2fnjdMx5t1NUngYi5uzdNlG7gtlIwmGrIzCnI4FT4pxmEWmZGU/Nv8462k
 hVx+rfKHOo14/L+cq7x9zd+chBChR29XI7zqXn18Slhef1Cn0lIMY7yw27XRCm3AiLEGGmXpSDP
 7kSf2n
X-Received: by 2002:a05:7300:d4ce:b0:303:f2dc:8ab4 with SMTP id
 5a478bee46e88-30804607394mr996384eec.2.1781155780368; 
 Wed, 10 Jun 2026 22:29:40 -0700 (PDT)
X-Received: by 2002:a05:7300:d4ce:b0:303:f2dc:8ab4 with SMTP id
 5a478bee46e88-30804607394mr996366eec.2.1781155779878; 
 Wed, 10 Jun 2026 22:29:39 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a402sm880475eec.17.2026.06.10.22.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:29:39 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v8] target/hexagon: Add implicit attributes to sysemu macros
Date: Wed, 10 Jun 2026 22:28:45 -0700
Message-Id: <20260611052857.3911981-25-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
References: <20260611052857.3911981-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: ORfuBbQP3DRcUgvdw816mkwN5ybT_CMa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX0PIJSukKSnGK
 CEz5yxwea8uS3j0Py+7EAfnnrCFwhO/+M0TUxmBfMJQB/hi6dw0w3elIKMk1rZY2efrx9Brttc/
 T4seoPhE8ArJqsFNz0JczDEBbpcLvJo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MSBTYWx0ZWRfX1LcjdpiAuqdF
 zGHk6lw96QVP8B4BFajLsJOhHRNM6B7uLTeq23FYDzve134kZ5ahyV525uhPlcBaFRvyKIDngsR
 MZeZ8tWeJPp6wqLOzzlsELcogrlFyhTEusKOlmNVdO4RBEcBBGiOlQgNu4mmLHPtghGvxFMCtK2
 5O6cYmAjyVoSeT2TIKn04wj9ooTRVJDxv+4XHB+/V5ViiTLPgIjznT6HREBHzMvnQCeMVcAp6gA
 2KQnB1jb/u3bf4XL5g4PVNIkg5NDqDx+cAaV6d2HaspU8OiAUcA9f6+xw6rmJqagaBc0TOAP7Xv
 em38aDO0Tug3HNT2pi766tC0tnja2i2EYZJsCloXf/HsM1zaqXTqTOa0ErTDbOEyiN92whKrj6n
 Zl5xjtTR5mlEnJhBBqaKGhrkXGWXqCXiaG0QLSBfTYKL8/9IFOSy6/GMrHW5NMahXUZ9dRxWMK7
 PJLdMbQJ0NKNaB1556Q==
X-Authority-Analysis: v=2.4 cv=F5lnsKhN c=1 sm=1 tr=0 ts=6a2a47c4 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=jiUnMIOmsb6gMTORg9AA:9
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: ORfuBbQP3DRcUgvdw816mkwN5ybT_CMa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110051
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL2hl
eF9jb21tb24ucHkgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlm
ZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL2hleF9jb21tb24ucHkgYi90YXJnZXQvaGV4YWdvbi9o
ZXhfY29tbW9uLnB5CmluZGV4IDhjNmEwNTg5Zjg4Li5hY2FhYTNjOTQ0YSAxMDA3NTUKLS0tIGEv
dGFyZ2V0L2hleGFnb24vaGV4X2NvbW1vbi5weQorKysgYi90YXJnZXQvaGV4YWdvbi9oZXhfY29t
bW9uLnB5CkBAIC0xMjgsOCArMTI4LDExIEBAIGRlZiBjYWxjdWxhdGVfYXR0cmlicygpOgogICAg
IGFkZF9xZW11X21hY3JvX2F0dHJpYigiZlRSQVAiLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCiAg
ICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX09WRVJGTE9XIiwgIkFfSU1QTElDSVRfV1JJ
VEVTX1VTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VUX0xQQ0ZHIiwgIkFfSU1Q
TElDSVRfV1JJVEVTX1VTUiIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmQ0xFQVJfUlRF
X0VYIiwgIkFfSU1QTElDSVRfV1JJVEVTX1NTUiIpCiAgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmli
KCJmTE9BRCIsICJBX1NDQUxBUl9MT0FEIikKICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoImZT
VE9SRSIsICJBX1NDQUxBUl9TVE9SRSIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0cmliKCJmU0VU
X0swX0xPQ0siLCAiQV9JTVBMSUNJVF9SRUFEU19QQyIpCisgICAgYWRkX3FlbXVfbWFjcm9fYXR0
cmliKCJmU0VUX1RMQl9MT0NLIiwgIkFfSU1QTElDSVRfUkVBRFNfUEMiKQogICAgIGFkZF9xZW11
X21hY3JvX2F0dHJpYignZkxTQk5FVzAnLCAnQV9JTVBMSUNJVF9SRUFEU19QMCcpCiAgICAgYWRk
X3FlbXVfbWFjcm9fYXR0cmliKCdmTFNCTkVXME5PVCcsICdBX0lNUExJQ0lUX1JFQURTX1AwJykK
ICAgICBhZGRfcWVtdV9tYWNyb19hdHRyaWIoJ2ZSRUFEX1AwJywgJ0FfSU1QTElDSVRfUkVBRFNf
UDAnKQotLSAKMi4zNC4xCgo=

