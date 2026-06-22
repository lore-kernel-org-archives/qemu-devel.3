Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46DD3CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 22:34:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbn9X-0003aV-0u; Mon, 22 Jun 2026 18:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9V-0003ZV-FT
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wbn9T-0006cB-ED
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 18:30:01 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65MJZxFF1542000
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=; b=dOw7Jdp7s50LIcJd
 knd5ozZ7CFrezmJNkm9+0O+fVyUTNGYJdzT5QvTjyxqrjSE0EupBVzoZSPwTBM6A
 sbKztPBZbeMlNzEpVo3ZhGU2/2tqSgudKXGCoROYz1kIXYeFrRTaChH7JFgpqQC7
 I0Wu+Swa1Y6Ry+I1p9U+Xt2YM4C1ltPfUZhu8L7MkolKGVagIVzmQziYyTh5qOtV
 U69PJzvifjLizBSCCJFIsRyu0MKStdqBKFk2tmrZMdkzS+Yozp0eeFhLw5tf2N9Z
 STZ4HNlTZ5KzWNshS0zSTrCSi3VClUvEKupGULms44LfzxFmEIAD/R0nQMDjQQ7L
 W0v/kQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3a0tgbj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 22:29:58 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c17f62afdso457288eec.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 15:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782167397; x=1782772197; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=ieQLkf2F0k0RdBtVBHpeCdPzV+Ci8Zzo/YG02FzFlg87KenBu68NKAKfLa9lTKwvdf
 zY4B6e7SvBPkoD8/i11aDb7vdOmosWazSSCvBxNmTlsciBmyAfYw8kf1RbgznfiMJFPr
 R5peyRtja75Rg4g8fzcxAt4HuTyDqEpKkiS5l7DNG+lAyFpLBv9gbbiKRgnpR2xxFLXH
 7QacqR4FYOv9rZKfWXwepsDjL+Ozf6glpP+TgSKDGv3uCJ2lO3ECG79klG5U8SWZ+wBp
 nuONchM465j6hD+XSMaOVk6jXJx+tZ4Gg/pDCoB6FNPDy35XhO9yReDcnY1U89go93W6
 7gKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782167397; x=1782772197;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MzvUFKvc+sUpWvc2016FnOxj5PhtBZkyxIiMWx3S09s=;
 b=qXFVbQaatWywdcS/0EWDzzkxEN4WvL9/e5qNEKzPTMX+dNlV7m2xcef75zBHi98QSO
 vgfUnXVYaYihaOYD5waAF0BzdZ0L9LpJHhCcB9xNLtvrb8+Y9dWerRtuvFTWyA1Vk7Fg
 1UTlLqjQqQ832P5Td6D7tbS3BN8VkIGUP02WxWFG7CrE302nNNjp3000UR+TWLq3EFmA
 p4NgR4kgq46Xdqn4NjfFOeRQUeISaIcKkmd4wRFLgyCavyWzRd/JuqUjriAAg0hJHVp3
 2E/HIXkTznvQeHpXiUYrNYrQHWeQKkzjCzOP81ZdWFPtCcpQmT2VyVzSEsFLCBu9IHwy
 GmwQ==
X-Gm-Message-State: AOJu0Yx+lm9S1NU2jUTTClSqPA0lBNMXLnpHhdQs53AOa8MWEpONqDtS
 Zbc7eSaeg+TzHzhU9h4rtoojYcrB9CbstIWeaR0EOjF/BbmY0KVgcXL9cuYcBpbseoC/Okij1Y3
 M08cAAMrCLMJzLpZ6gt5p4RNWmoGLhNemwmzIQX2Chssp0Iz4D3ce68Cqv/q/h6csFw==
X-Gm-Gg: AfdE7cmEt59CY/CYwA55k7BRoewCzBn08FETSC/82xS5WeVmq4lNqSqtSjoONqNZcgz
 jtXqed5CnehHZv6xjyl5sl9GUdo2OyZ6EHuV0ULPcoTm2SA+ZIzdDw2bReePxvt990l0apJdUR3
 EKLOaq2Yzvo4t3RjMIY53QI75ArWWOKGdwWcOOkZrHbuAI/6XzyzrWEvaFUKuXQuiexzYxJdCPf
 GjRHXy4IkMPKpH1s6PBG+UFiefCiEBkQTUpBO7C7j/loXcVSbw4W3lyTdX+iMU33oRaZ+V0Csh0
 wJzzERE5JRTw2jXXFmAcq+n29frGe6A7dzuDD7YZqvI3JfGCWnkLpGexwD9YNuSltYSx3AC83gR
 GzGGwtwOpdDY+4NRptzt6mL7cD7sYVq8UP7RZlgmej0Ic7e2AElPlesXVxrQ=
X-Received: by 2002:a05:7300:de07:b0:30c:46a:844d with SMTP id
 5a478bee46e88-30c556838e7mr642277eec.20.1782167397403; 
 Mon, 22 Jun 2026 15:29:57 -0700 (PDT)
X-Received: by 2002:a05:7300:de07:b0:30c:46a:844d with SMTP id
 5a478bee46e88-30c556838e7mr642265eec.20.1782167396861; 
 Mon, 22 Jun 2026 15:29:56 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1bd8d78esm10945995eec.18.2026.06.22.15.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 15:29:56 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: brian.cain@oss.qualcomm.com, Taylor Simpson <ltaylorsimpson@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 32/75] target/hexagon: Add pcycle setting functionality
Date: Mon, 22 Jun 2026 15:28:21 -0700
Message-Id: <20260622222904.607771-33-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
References: <20260622222904.607771-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX5X5u9FHo6Dg+
 DlXgRoSMvvA1tAoN638yALOSyiRH/OxTZBtwlupxMJJYsjJPgsXlLPUzAoBdzQIl2OT7phuaQJA
 x4c5wfGqZR1SJHIOUEBr/z9nS3ANjz0=
X-Proofpoint-GUID: NzGb7wuJZhE3GyXk587Km7P2c_yx3x_t
X-Authority-Analysis: v=2.4 cv=UJ7t2ify c=1 sm=1 tr=0 ts=6a39b766 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OF6xqQKflNrgTLtdKXcA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDIxNiBTYWx0ZWRfX/t863xLSD2qJ
 vvdA9J2o4fojrNEaGKtcB0xWJRALBF9tA/+Vp1sYft9ShVY6OeAYx2od89tp5w47i0N2PST6v6q
 RPh4+whsTpd1wD1J0JM0j6lvQdmLKIEuuVeUmingU1JxQVTsiJR8W0aAplrglOza7Az6JolTXYP
 UgBaA1CI3QpdmRTc8nM6D76q0RZQq7srqhkq/hJTFM81u3EVo5J/ADWLRz9f14bkThmLk+RVqsV
 aC4UI1LqNraDxlKCbHQH3lyIB/PRh2tgWNkBLF4BPlF68NdMro6JZedqQAwXRxrnc7RIY1mYe6I
 E+tKmTM9yDZM/SG00daJuGCuiuaMjwLi401WNnLsNjP1vIzefNpNPbpemrmJTsyoKBZGsPj/+2k
 +d0bkuBTxyLepMLVA1YMiw5Tv+BK/DrTYFPqZ2DidD00OYVk3vCkZzJkeHHQS9ZqnKq+NL8Bypj
 whF9LMdoOg36JDmDDVg==
X-Proofpoint-ORIG-GUID: NzGb7wuJZhE3GyXk587Km7P2c_yx3x_t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_04,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 malwarescore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220216
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

