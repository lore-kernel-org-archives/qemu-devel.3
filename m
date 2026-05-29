Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F27CCD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:01:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5CL-0005mD-Qw; Fri, 29 May 2026 17:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CK-0005e5-8T
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:56 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5CI-0000Xe-Hm
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:56:55 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TI2HPO589589
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=; b=XNXa5E4r1sItMmhE
 C5oPTIXX2YfeLmBZnpQDUuAqZCJk2akUpTUV98W3d0PMzky4tbhB8QHAzy6KXZnL
 aZyRbJHpdqUKa/xmYPGyZAfNnwMIHv3XfSkbC0REbfyIIQIZnR2I1YAI7cS54IyE
 N60kMvUufBk9KlatKbFR5Wj6R0bknViHauiCj5llt8qzk12oW1kt3lkOKtiG/2KK
 STb1MrKULqEzXYlpDwQYRMWOoztsmXq7bSuZO0663EjN8+WzRmSAzQhflahPTjOF
 v4PtWSq8ahLNFf8H8NVwMJcFPJKYBYe++BjrrwUCCKG4G6JkrkBHso2BO55llJel
 4cSXdw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ef8rckbs2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:56:53 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304d0d0b28eso2806167eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091812; x=1780696612; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=cnxcvf/p28ajnkQUANLKr1Tk8kCUWKt1ubDBaPC1G0ls6HQy9xctwK+o+T7XsH+5Gj
 GV4GZ2kKX0jSLKnfi2lhdP2T8yCtB9mZFkI4vDSv639ESya8Sju4Z+G6xvKaHohk0NZQ
 3l68J4Vx+L2Ni7/me6hRjBcXaWq/JhMyZG9qHOfbakHR8lmBf+G7Edr/uhkrfzwuI+yf
 UW7kK4W6xnR1l6k3uRV5yS7/it0obBAYwyiTbzNnhOvD+q2SVhUpEDBVr+DC0iIz7+Hb
 30onm421mnny2bdqAesBlrv5mLDM8W6xio6ZL294iHj56r7aZBoVN5ihscHWHR7q8do9
 laqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091812; x=1780696612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=MJ8/+FDOJNqMDA8jdSv8J3Gq53AU8KWD96+osoulp+Izs9ODc9k2kmywt+mvvo2FA2
 QkFfitwx+lZngedUWAwM4IOObTwHF2fS4op6l8cIUAFlAE5v77WAfpEe32li/YO/2y1h
 d4SQqR/e/n3BbtbmYxjtAqoCGTF0sVTBWCOVMsMaxrY3Uc4mUua9/UqO5amArt1QCvzY
 GYiccgU7AfSlw9Bx+oAAjuWnzf1c/PLDNuUl007R0YVns7ZB8XKH2ZMv5721CnBwDLXU
 2p4DQ1CU3GATfj1cXzZqAd8Ul86rk35DdXYLKQX3Kz3mPggG7zVAPSRvC4eL/vxgRpyA
 e24Q==
X-Gm-Message-State: AOJu0YzHlV3BHg0nV3Zxsh4eAsddJ7uLdf1FLGLpET2qxnEQSg7I9pd7
 0OdgG2ShBEwzmB0eHNpyIY8YJhncKYzbV1flMsu7tVyiFqIQNT9ZcRZuTO4891WExwCa0HOOUTF
 dqocmZcmQuwi48jspcnluNcOKUnuytSmT9/CZKrsMOFKwxJPInWSVd8zzKdYz3dWTqA==
X-Gm-Gg: Acq92OGSuwbFwOWwusq3Uwz+Ur8eIBcU2PXog22gZLuoyUJ2TDzoqE6VMd1nH7hUSs2
 DYENdkp9zzm+lxFdVa+fTvqWF3VuN0NEcL3ZsH7lKkS+ziLx4oYpL26nAJ7KtKBFV2p1IhRGz+C
 FNfnwNdxxJBlau6W2T15DAR6fwBKxJc+blgl2Ctll3PTuLNWnB0n4SoZm8MrtUrCmFK0J84o1N0
 eBaAZ8E16xDe/DSFLeXqdTgf1JDBGbRIWlc2HTVmucJNofmp/OSahcsdBr0nz3fh5Q9DO74gR+S
 mKy5guB8i5Qe9I4gfRr+Ib8mDhZxywEsnXhXGu7VBQe222mbu5IzxDHu6k1L0jFgUwcI3xNqhLr
 lKribLh9rEu+GUo3Yf+l/LqjhZHDKZ6PwAVeGFr7AOgz+kOpAYXJit7ZcC688YH49HcGAabngwu
 D9ltoE
X-Received: by 2002:a05:7300:ad2d:b0:304:f582:c7f with SMTP id
 5a478bee46e88-304fa4c9127mr826749eec.9.1780091812382; 
 Fri, 29 May 2026 14:56:52 -0700 (PDT)
X-Received: by 2002:a05:7300:ad2d:b0:304:f582:c7f with SMTP id
 5a478bee46e88-304fa4c9127mr826728eec.9.1780091811900; 
 Fri, 29 May 2026 14:56:51 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd8e1sm3026279eec.21.2026.05.29.14.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:56:49 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org
Subject: [PATCH v7 32/38] target/hexagon: Add pcycle setting functionality
Date: Fri, 29 May 2026 14:55:48 -0700
Message-Id: <20260529215554.606133-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
References: <20260529215554.606133-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: pRlTb2O632oHHUbESaPATwF7cwucZZeR
X-Proofpoint-ORIG-GUID: pRlTb2O632oHHUbESaPATwF7cwucZZeR
X-Authority-Analysis: v=2.4 cv=DuNmPm/+ c=1 sm=1 tr=0 ts=6a1a0ba5 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OF6xqQKflNrgTLtdKXcA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX/cdQ/vaeNhf9
 J5pzRf1KkvLq94wgCImdcl0KaUi3y6nbfe5fq80EqFWteXfQmJuNSaOBUYUX3hpv7ayc4VHDrp8
 bM6VcpuDxAyOTGHQZJJIEbUOCJUPvGORurLbi6DcSgRyPgjnjobyIV3DrVvpA5cOfhgtmttF/CP
 gKrczmvJl6omYkYDNIh6ZSwM/Se1zFjYketyyIjfa15eyohfxGST+SJ9Xl72IlgeQLPZlRbrIed
 GKwBl0gLKmRkSVMtxTzmzR4X6hFMdjVwUgnDe+wZh3GsOiQU+NSk2xESYVuye62ssoG7Ks7RmjU
 h2WFIP/gtJlgV0gigdr5syH2CAarWS0rtWSsp67rOPZcCE1KOZ+gdjlvTvjghVrlAHpxQQZP6wq
 ezXYb8MN6hNZMOi40CiFj1xntnwpebefkxqrhroSuYg9Y2B+tIDXAgOgB5WvlrXiffD9ERr31UY
 A8ltXyh0i89G2YbJhIA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
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

UmVwbGFjZSBwY3ljbGUgc2V0IHN0dWJzIHdpdGggcmVhbCBpbXBsZW1lbnRhdGlvbnMgdGhhdApk
aXN0cmlidXRlIGN5Y2xlIGNvdW50IGNoYW5nZXMgYWNyb3NzIGFsbCBhY3RpdmUgdGhyZWFkcy4K
ClJldmlld2VkLWJ5OiBUYXlsb3IgU2ltcHNvbiA8bHRheWxvcnNpbXBzb25AZ21haWwuY29tPgpT
aWduZWQtb2ZmLWJ5OiBCcmlhbiBDYWluIDxicmlhbi5jYWluQG9zcy5xdWFsY29tbS5jb20+Ci0t
LQogdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIHwgNDMgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLQogMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jIGIvdGFy
Z2V0L2hleGFnb24vY3B1X2hlbHBlci5jCmluZGV4IGJiOTkxYTY3MWU4Li42NGM1NzQ2YzZkOSAx
MDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vY3B1X2hlbHBlci5jCisrKyBiL3RhcmdldC9oZXhh
Z29uL2NwdV9oZWxwZXIuYwpAQCAtNTYsMTcgKzU2LDU0IEBAIHVpbnQzMl90IGhleGFnb25fZ2V0
X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52KQogCiB2b2lkIGhleGFn
b25fc2V0X3N5c19wY3ljbGVfY291bnRfaGlnaChDUFVIZXhhZ29uU3RhdGUgKmVudiwgdWludDMy
X3QgdmFsKQogewotICAgIGdfYXNzZXJ0X25vdF9yZWFjaGVkKCk7CisgICAgdWludDY0X3Qgb2xk
OworCisgICAgZ19hc3NlcnQoYnFsX2xvY2tlZCgpKTsKKyAgICBvbGQgPSBoZXhhZ29uX2dldF9z
eXNfcGN5Y2xlX2NvdW50KGVudik7CisgICAgb2xkID0gZGVwb3NpdDY0KG9sZCwgMzIsIDMyLCB2
YWwpOworICAgIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnQoZW52LCBvbGQpOwogfQogCiB2
b2lkIGhleGFnb25fc2V0X3N5c19wY3ljbGVfY291bnRfbG93KENQVUhleGFnb25TdGF0ZSAqZW52
LCB1aW50MzJfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICB1aW50
NjRfdCBvbGQ7CisKKyAgICBnX2Fzc2VydChicWxfbG9ja2VkKCkpOworICAgIG9sZCA9IGhleGFn
b25fZ2V0X3N5c19wY3ljbGVfY291bnQoZW52KTsKKyAgICBvbGQgPSBkZXBvc2l0NjQob2xkLCAw
LCAzMiwgdmFsKTsKKyAgICBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KGVudiwgb2xkKTsK
IH0KIAogdm9pZCBoZXhhZ29uX3NldF9zeXNfcGN5Y2xlX2NvdW50KENQVUhleGFnb25TdGF0ZSAq
ZW52LCB1aW50NjRfdCB2YWwpCiB7Ci0gICAgZ19hc3NlcnRfbm90X3JlYWNoZWQoKTsKKyAgICBD
UFVTdGF0ZSAqY3M7CisgICAgdWludDY0X3QgdG90YWw7CisgICAgaW50IG51bV90aHJlYWRzOwor
ICAgIGludDY0X3QgZGVsdGEsIHBlcl90aHJlYWQsIHJlbWFpbmRlcjsKKworICAgIGdfYXNzZXJ0
KGJxbF9sb2NrZWQoKSk7CisgICAgdG90YWwgPSBoZXhhZ29uX2dldF9zeXNfcGN5Y2xlX2NvdW50
KGVudik7CisKKyAgICAvKiBDb3VudCBhY3RpdmUgdGhyZWFkcyAqLworICAgIG51bV90aHJlYWRz
ID0gMDsKKyAgICBDUFVfRk9SRUFDSChjcykgeworICAgICAgICBudW1fdGhyZWFkcysrOworICAg
IH0KKyAgICBnX2Fzc2VydChudW1fdGhyZWFkcyA+IDApOworCisgICAgLyoKKyAgICAgKiBEaXN0
cmlidXRlIHRoZSBkZWx0YSBldmVubHkgYWNyb3NzIGFsbCB0aHJlYWRzLgorICAgICAqIEFueSBy
ZW1haW5kZXIgZ29lcyB0byB0aGUgY2FsbGluZyB0aHJlYWQuCisgICAgICovCisgICAgZGVsdGEg
PSAoaW50NjRfdCkodmFsIC0gdG90YWwpOworICAgIHBlcl90aHJlYWQgPSBkZWx0YSAvIG51bV90
aHJlYWRzOworICAgIHJlbWFpbmRlciA9IGRlbHRhIC0gcGVyX3RocmVhZCAqIG51bV90aHJlYWRz
OworCisgICAgQ1BVX0ZPUkVBQ0goY3MpIHsKKyAgICAgICAgQ1BVSGV4YWdvblN0YXRlICp0aHJl
YWRfZW52ID0gY3B1X2Vudihjcyk7CisgICAgICAgIHRocmVhZF9lbnYtPnRfY3ljbGVfY291bnQg
Kz0gcGVyX3RocmVhZDsKKyAgICB9CisgICAgZW52LT50X2N5Y2xlX2NvdW50ICs9IHJlbWFpbmRl
cjsKIH0KIAogc3RhdGljIHZvaWQgaGV4YWdvbl9yZXN1bWVfdGhyZWFkKENQVUhleGFnb25TdGF0
ZSAqZW52KQotLSAKMi4zNC4xCgo=

