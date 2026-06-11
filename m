Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF24CD98CF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 05:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXY8s-00084r-BW; Thu, 11 Jun 2026 01:39:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY8M-0007tE-Qf
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:39:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wXY8K-0004uL-Ui
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 01:39:18 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B5GGav3863232
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:39:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=; b=na
 nqqTEFLxTFv9YxAc6ikO+/v6s7eR5HPtqc3GvcKssIG91bIsSiHah/JvHyIKz4Fz
 2c28MUYb6PYcqB7NYx2pI9g1Ydexy+5bW0k+u5lGrMkhwjSwEQ1oVTta1K5RsjVF
 pgFJyChfLfeMiCwcwwWWLIHGUMGlXqQDoGR++5GUd/ncgPExUq3XU8yLPfQG/aGY
 /sdMa09WuV5UdU+fQ6837J/wPha6qPQzXkdYkab8o5ggNabyT6XgMRiFCA8zhMZm
 GctL+o8e0xJ+jcBa2YuT50ULdkCffovRDHVA/Zi+C5B68NaT2eR5uYLX8NL2pliL
 cI2ysSbCO1TtoztlbKpA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6shu8j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 05:39:15 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304b8d0ee63so10606599eec.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 22:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781156355; x=1781761155; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=;
 b=ajOrMROZ55L2trYEufRwl3vc1MmxcMUJgXlDZ3YNLMFwLrfdO4xBzLgYqLJYiA+8p6
 hECg8d1ZOTzFP9UQAvzwP5vl86PXCmMKWsocAOjlU6+6o9hNyF6v2jztVrHMMgKcZ64p
 j+NhdLJAYMHf3tKCo74SpfKckpbIgxlgOc4YD4LJtAPHLK50ZQcQGpURQCniNGM3YffY
 emNhafPwXHa30ez5gI3ElU+VLvh1Lkr+UAFZ0MVteEOErbcipZIOqU8fcjhHsn5yasMS
 M5G6znyCdjKhH7NvkHHQ3Emy077uL2wMj91h0RvHxfs0UzWkYWOVIoXf5/iX1m99ByUO
 c6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781156355; x=1781761155;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=;
 b=olIRS/1CRLtp3QLlfw83ox8HDtmGK7yYx5fWbPsrVtdaaubWK6bWSr5aSoAp5NjqKb
 M5IbEySPPtaHpXu70uELTwxene6xLjBc/Velb5KmyaX0jVTpI1U/O7TINdDTk6vQn/IC
 EICjwtn2EzF1Y64ulTX/Ab47GmOuvino1+pu3r+Tc5QmVYaw+cHVVJpQ6zhaegQ+Grt0
 xPCJdsjQllCx7MwxWp0VPEZ7703s/etFVsilG1Ek4Rg5EielQSgGC4Dh7lqIdSpC9eGc
 8WDn4n+WInwf5L1RTU2T09QUif3pE7k+9x7vZDcVCdTQywn+Zo+c5kajE2lP2UEIC4xG
 oaqg==
X-Gm-Message-State: AOJu0YzC1rEf3/eSRfNCWfGxYv4OIh3e+guIkO3Qki56+jCgb35tEI6u
 +T5ktgC5RU9tsuwSGlMT/cp/R/BRsA1e5xRsVfHsA6IDNcHf29Ph5nKtpikljWiKuAa5t8EQWpK
 JhtT21SYVUKW/sXRjSHvT2tre4zWPnnqDB/niwC8+1iyTQakxlM08dLPe+uYQrp9C1w==
X-Gm-Gg: Acq92OHktYa+s2PhGkOlCJqPGZo9jtkF4D1WmoZPUPixypn2tZWyOXNy2t+kV4aRN0g
 PItMk4c8ZTdP0JXIy3cZsNX+6Iy5mIiav803kAKm9CT3Sy7w9HhvcmPCtVVV6Djg4ig6fUi/aW5
 ElyV7jqGD2+21Ut8Wm4IraWs/zWvZUkkmm7y2D5vRZk55e/3SL8liLIgp43UKh6VtSgqlkrQAIk
 hqo7wa8Ixohwn5uxzKWNsI4DRMyH+k2NE5/IdNIstCKAThgA8Enf3q6BqK83Phs4P4AwQmqBQ7W
 hns89OzXVNmz5f40FFDQCSXPlOQ36iCBN4ip8cRlVDLTERWCDqrmIPExJJib2YTi6nrTg2ep9e2
 0Kr9YJEJL/KPNOYPtIriL1p8ugM+90DV8m+bU4O9sCZj4CcwmY00pk6xFl+1wocYNQPUMSGUZ6X
 Qg3ZSr
X-Received: by 2002:a05:7300:3213:b0:307:393a:8f1d with SMTP id
 5a478bee46e88-3080479b326mr1327505eec.14.1781156354898; 
 Wed, 10 Jun 2026 22:39:14 -0700 (PDT)
X-Received: by 2002:a05:7300:3213:b0:307:393a:8f1d with SMTP id
 5a478bee46e88-3080479b326mr1327475eec.14.1781156354375; 
 Wed, 10 Jun 2026 22:39:14 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30806e8a9fesm735778eec.16.2026.06.10.22.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 22:39:13 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@mailo.org, philmd@oss.qualcomm.com, Brian Cain <bcain@quicinc.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v7] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Wed, 10 Jun 2026 22:38:58 -0700
Message-Id: <20260611053902.3927367-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611053902.3927367-1-brian.cain@oss.qualcomm.com>
References: <20260611053902.3927367-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-GUID: EvVbOCXHCx30TRIQs4hG_ieBC4cdE0P_
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA1MyBTYWx0ZWRfX8ct6X5M67ZX4
 4sumgn73jn/U1rsyP3Pr/Hwx3G2SlsNyGjQekoFxsADJsvGzseSkR3rFZGGwxA7N2C9OsA/5BQc
 NXkTp7uILl+XiS3i0ivLU7rtNBSMh8s=
X-Proofpoint-ORIG-GUID: EvVbOCXHCx30TRIQs4hG_ieBC4cdE0P_
X-Authority-Analysis: v=2.4 cv=Kux9H2WN c=1 sm=1 tr=0 ts=6a2a4a04 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=G5se95cPlkO2hgD9IGUA:9 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA1MyBTYWx0ZWRfX85ONyzNpXOez
 b6PRbWznSEWIH+gJ7OuQ8K8xcrHAlFDRWzjtWI7O4Y5yu5VPBclhO0w9vV++UawAWGrkBG/rD6q
 IHRAWeosF3TcHfD56yIOj18x543iBz/BNneD9XLjubEJbW+55QsBqURETg6KexelWwhTvSOMSXQ
 gkSr9IF4Uwq5q+IJIEQfmg5JXfS0CrQXyFzz5oz+BcSI1bXX5PLtT46E8iO52OUQUN58j2OG5ik
 Wnr38g3GSX0SgaXu9UMVKluZB1l1Jd565dWknKxFLS1DuECWoS0FIYSXDOXzWvNgQXQO5MSTCo6
 KfDDLe9Lu5XQLvJooBY6p5DuZJgFLdL87PBIRRTPia/ZWsWb+NMowstQhQeGm384mCHcVUy566s
 h8i/SBiRZ2qra5yTWOYblbJRpOXgZLDD2jBMv23SjiNkodVVasww3z2POYmHAZVU5tIZc8NlcTH
 jd/n6V3M6uef4lFM3AQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606110053
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpBY2tlZC1ieTogVGF5bG9yIFNp
bXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KQWNrZWQtYnk6IFBoaWxpcHBlIE1hdGhp
ZXUtRGF1ZMOpIDxwaGlsbWRAbGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFBpZXJyaWNrIEJvdXZp
ZXIgPHBpZXJyaWNrLmJvdXZpZXJAb3NzLnF1YWxjb21tLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJp
YW4gQ2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIGh3L2hleGFnb24vbWFj
aGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jIHwgNjQgKysrKysrKysrKysrKysrKysrKysrKwog
aHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMgICAgfCA2NSArKysrKysrKysr
KysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMjkgaW5zZXJ0aW9ucygrKQogY3JlYXRl
IG1vZGUgMTAwNjQ0IGh3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMK
CmRpZmYgLS1naXQgYS9ody9oZXhhZ29uL21hY2hpbmVfY2ZnX3NhODc3NV9jZHNwMC5oLmluYyBi
L2h3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCm5ldyBmaWxlIG1vZGUg
MTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwLi40NDJjYmUzYmUzMQotLS0gL2Rldi9udWxsCisrKyBi
L2h3L2hleGFnb24vbWFjaGluZV9jZmdfc2E4Nzc1X2Nkc3AwLmguaW5jCkBAIC0wLDAgKzEsNjQg
QEAKKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyICovCisKK3N0
YXRpYyBjb25zdCBzdHJ1Y3QgaGV4YWdvbl9tYWNoaW5lX2NvbmZpZyBTQTg3NzVQX2Nkc3AwID0g
eworICAgIC5jZmdiYXNlID0gICAgICAgICAweDI0MDAwMDAwICsgMHgxODAwMDAsCisgICAgLmwy
dGNtX3NpemUgPSAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwydmljX2Jhc2UgPSAgICAgIDB4MjYz
MDAwMDAgKyAweDkwMDAwLAorICAgIC5sMnZpY19zaXplID0gICAgICAweDAwMDAxMDAwLAorICAg
IC5jc3JfYmFzZSA9ICAgICAgICAweDI2MzAwMDAwLAorICAgIC5xdG1yX3JlZ2lvbiA9ICAgICAw
eDI2MzAwMDAwICsgMHhBMTAwMCwKKyAgICAuY2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRjbV9i
YXNlID0gMHgwMDAwMjQwMCwKKyAgICAgICAgLnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisgICAg
ICAgIC5zdWJzeXN0ZW1fYmFzZSA9IDB4MDAwMDI2MzgsCisgICAgICAgIC5ldG1fYmFzZSA9IDB4
MDAwMDI0MTksCisgICAgICAgIC5sMmNmZ19iYXNlID0gMHgwMDAwMjQxYSwKKyAgICAgICAgLnJl
c2VydmVkMSA9IDB4MDAwMDI0MWIsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDAyNTAwLAor
ICAgICAgICAuYXhpMl9sb3dhZGRyID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLnN0cmVhbWVyX2Jh
c2UgPSAweDAwMDAwMDAwLAorICAgICAgICAucmVzZXJ2ZWQyID0gMHgwMDAwMDAwMCwKKyAgICAg
ICAgLmZhc3RsMnZpY19iYXNlID0gMHgwMDAwMjQxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9lbnRy
aWVzID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAwMSwK
KyAgICAgICAgLmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jhc2Ug
PSAweDAwMDAyNTAwLAorICAgICAgICAudnRjbV9zaXplX2tiID0gMHgwMDAwMjAwMCwKKyAgICAg
ICAgLmwydGFnX3NpemUgPSAweDAwMDAwNDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4
MDAwMDAwMDAsCisgICAgICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAorICAg
ICAgICAuZWNjcmVnX2Jhc2UgPSAweDAwMDAyNDFmLAorICAgICAgICAubDJsaW5lX3NpemUgPSAw
eDAwMDAwMDgwLAorICAgICAgICAudGlueV9jb3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwy
aXRjbV9zaXplID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAwMjQw
MCwKKyAgICAgICAgLnJlc2VydmVkMyA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJlc2Vu
dCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDMsCisgICAg
ICAgIC5odnhfdmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LAorICAgICAgICAuY29yZV9pZCA9
IDB4MDAwMDAwMDAsCisgICAgICAgIC5jb3JlX2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAgICAg
LmNvcHJvYzJfcmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAw
MDAwMDIwLAorICAgICAgICAudjJ4X21vZGUgPSAweDAwMDAwMDAxLAorICAgICAgICAuY29wcm9j
Ml9yZWcyID0gMHgwMDAwMDAwOCwKKyAgICAgICAgLmNvcHJvYzJfcmVnMyA9IDB4MDAwMDAwMjAs
CisgICAgICAgIC5jb3Byb2MyX3JlZzQgPSAweDAwMDAwMDAwLAorICAgICAgICAuY29wcm9jMl9y
ZWc1ID0gMHgwMDAwMDAwMiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNiA9IDB4MDAwMDAwMTYsCisg
ICAgICAgIC5jb3Byb2MyX3JlZzcgPSAweDAwMDAwMDA2LAorICAgICAgICAuYWNkX3ByZXNldCA9
IDB4MDAwMDAwMDEsCisgICAgICAgIC5tbmRfcHJlc2V0ID0gMHgwMDAwMDAwMCwKKyAgICAgICAg
LmwxZF9zaXplX2tiID0gMHgwMDAwMDAxMCwKKyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgwMDAw
MDAyMCwKKyAgICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDAwMDAwMDAyLAorICAgICAgICAu
dnRjbV9iYW5rX3dpZHRoID0gMHgwMDAwMDA4MCwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MDAw
MDAwMDEsCisgICAgICAgIC5yZXNlcnZlZDUgPSAweDAwMDAwMDAwLAorICAgICAgICAucmVzZXJ2
ZWQ2ID0gMHgwMDAwMDAwMywKKyAgICAgICAgLmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgwMDAw
MDAwYSwKKyAgICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4MDAwMDAwZTAsCisgICAgICAg
IC5jYXBhY2l0eV9kb21haW4gPSAweDAwMDAwMDgwLAorICAgICAgICAuYXhpM19sb3dhZGRyID0g
MHgwMDAwMDAwMCwKKyAgICB9LAorfTsKZGlmZiAtLWdpdCBhL2h3L2hleGFnb24vbWFjaGluZV9j
ZmdfdjY4bl8xMDI0LmguaW5jIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5p
bmMKbmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMDAwMDAuLjgyNjE5YzQyYWMxCi0t
LSAvZGV2L251bGwKKysrIGIvaHcvaGV4YWdvbi9tYWNoaW5lX2NmZ192NjhuXzEwMjQuaC5pbmMK
QEAgLTAsMCArMSw2NSBAQAorLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3It
bGF0ZXIgKi8KKworc3RhdGljIGNvbnN0IHN0cnVjdCBoZXhhZ29uX21hY2hpbmVfY29uZmlnIHY2
OG5fMTAyNCA9IHsKKyAgICAuY2ZnYmFzZSA9ICAgICAgICAgICAweGRlMDAwMDAwLAorICAgIC5s
MnRjbV9zaXplID0gICAgICAgIDB4MDAwMDAwMDAsCisgICAgLmwydmljX2Jhc2UgPSAgICAgICAg
MHhmYzkxMDAwMCwKKyAgICAubDJ2aWNfc2l6ZSA9ICAgICAgICAweDAwMDAxMDAwLAorICAgIC5j
c3JfYmFzZSA9ICAgICAgICAgIDB4ZmM5MDAwMDAsCisgICAgLnF0bXJfcmVnaW9uID0gICAgICAg
MHhmYzkyMTAwMCwKKyAgICAuY2ZndGFibGUgPSB7CisgICAgICAgIC5sMnRjbV9iYXNlID0gMHgw
MDAwZDgwMCwKKyAgICAgICAgLnJlc2VydmVkMCA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5zdWJz
eXN0ZW1fYmFzZSA9IDB4MDAwMGZjOTAsCisgICAgICAgIC5ldG1fYmFzZSA9IDB4MDAwMGQ4MTks
CisgICAgICAgIC5sMmNmZ19iYXNlID0gMHgwMDAwZDgxYSwKKyAgICAgICAgLnJlc2VydmVkMSA9
IDB4MDAwMDAwMDAsCisgICAgICAgIC5sMXMwX2Jhc2UgPSAweDAwMDBkODQwLAorICAgICAgICAu
YXhpMl9sb3dhZGRyID0gMHgwMDAwMzAwMCwKKyAgICAgICAgLnN0cmVhbWVyX2Jhc2UgPSAweDAw
MDBkODFjLAorICAgICAgICAucmVzZXJ2ZWQyID0gMHgwMDAwZDgxZCwKKyAgICAgICAgLmZhc3Rs
MnZpY19iYXNlID0gMHgwMDAwZDgxZSwKKyAgICAgICAgLmp0bGJfc2l6ZV9lbnRyaWVzID0gMHgw
MDAwMDA4MCwKKyAgICAgICAgLmNvcHJvY19wcmVzZW50ID0gMHgwMDAwMDAwMSwKKyAgICAgICAg
LmV4dF9jb250ZXh0cyA9IDB4MDAwMDAwMDQsCisgICAgICAgIC52dGNtX2Jhc2UgPSAweDAwMDBk
ODQwLAorICAgICAgICAudnRjbV9zaXplX2tiID0gMHgwMDAwMTAwMCwKKyAgICAgICAgLmwydGFn
X3NpemUgPSAweDAwMDAwNDAwLAorICAgICAgICAubDJlY29tZW1fc2l6ZSA9IDB4MDAwMDA0MDAs
CisgICAgICAgIC50aHJlYWRfZW5hYmxlX21hc2sgPSAweDAwMDAwMDNmLAorICAgICAgICAuZWNj
cmVnX2Jhc2UgPSAweDAwMDBkODFmLAorICAgICAgICAubDJsaW5lX3NpemUgPSAweDAwMDAwMDgw
LAorICAgICAgICAudGlueV9jb3JlID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9zaXpl
ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmwyaXRjbV9iYXNlID0gMHgwMDAwZDgyMCwKKyAgICAg
ICAgLnJlc2VydmVkMyA9IDB4MDAwMDAwMDAsCisgICAgICAgIC5kdG1fcHJlc2VudCA9IDB4MDAw
MDAwMDAsCisgICAgICAgIC5kbWFfdmVyc2lvbiA9IDB4MDAwMDAwMDEsCisgICAgICAgIC5odnhf
dmVjX2xvZ19sZW5ndGggPSAweDAwMDAwMDA3LAorICAgICAgICAuY29yZV9pZCA9IDB4MDAwMDAw
MDAsCisgICAgICAgIC5jb3JlX2NvdW50ID0gMHgwMDAwMDAwMCwKKyAgICAgICAgLmNvcHJvYzJf
cmVnMCA9IDB4MDAwMDAwNDAsCisgICAgICAgIC5jb3Byb2MyX3JlZzEgPSAweDAwMDAwMDIwLAor
ICAgICAgICAudjJ4X21vZGUgPSAweDFmMWYxZjFmLAorICAgICAgICAuY29wcm9jMl9yZWcyID0g
MHgxZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnMyA9IDB4MWYxZjFmMWYsCisgICAgICAg
IC5jb3Byb2MyX3JlZzQgPSAweDFmMWYxZjFmLAorICAgICAgICAuY29wcm9jMl9yZWc1ID0gMHgx
ZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfcmVnNiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5j
b3Byb2MyX3JlZzcgPSAweDFmMWYxZjFmLAorICAgICAgICAuYWNkX3ByZXNldCA9IDB4MWYxZjFm
MWYsCisgICAgICAgIC5tbmRfcHJlc2V0ID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmwxZF9zaXpl
X2tiID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLmwxaV9zaXplX2tiID0gMHgxZjFmMWYxZiwKKyAg
ICAgICAgLmwxZF93cml0ZV9wb2xpY3kgPSAweDFmMWYxZjFmLAorICAgICAgICAudnRjbV9iYW5r
X3dpZHRoID0gMHgxZjFmMWYxZiwKKyAgICAgICAgLnJlc2VydmVkNCA9IDB4MWYxZjFmMWYsCisg
ICAgICAgIC5yZXNlcnZlZDUgPSAweDFmMWYxZjFmLAorICAgICAgICAucmVzZXJ2ZWQ2ID0gMHgx
ZjFmMWYxZiwKKyAgICAgICAgLmNvcHJvYzJfY3Z0X21weV9zaXplID0gMHgxZjFmMWYxZiwKKyAg
ICAgICAgLmNvbnNpc3RlbmN5X2RvbWFpbiA9IDB4MWYxZjFmMWYsCisgICAgICAgIC5jYXBhY2l0
eV9kb21haW4gPSAweDFmMWYxZjFmLAorICAgICAgICAuYXhpM19sb3dhZGRyID0gMHgxZjFmMWYx
ZiwKKyAgICB9LAorfTsKKwotLSAKMi4zNC4xCgo=

