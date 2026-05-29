Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0D07CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 22:01:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT5FC-0000JW-95; Fri, 29 May 2026 17:59:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5FA-00009P-Ov
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:52 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1wT5F8-0001FD-I7
 for qemu-devel@nongnu.org; Fri, 29 May 2026 17:59:52 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64TJZtNh4123957
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 qcppdkim1; bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=; b=g1
 AuTKjyR0WfNoS96pizeBy9GRbKVqCIZxi/UMhNAgbyWg4VuAk+04gucOXVnqoD4J
 kaD1yDhliROH0N42iyWN/RMnZ1WwsuLXFJMvcxFeOeWz3R67hEwtvk9UuCqfwFdV
 4uGlCwOXR88kcopWQv3MrRZE5JeYNIlx5V8+X0JyE0Di9nVkREbzJlIVYe5x4Vk6
 Hv1wABiIgwnteTiMmwVlSHJPOz9mZPtkeh1lBw39vyD/Jih/oojN4dJsulJ1nE29
 tlGtbR29wLTo38xJa67f9/+0cHoRsPg5Zn7ybGZLZXMGSXSy/uGWMgItZ3cwaC9r
 ynrvIOB/F/YoqZ4FvtSQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efh3n8g99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 21:59:49 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-135916eefa0so5179706c88.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 14:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780091988; x=1780696788; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=;
 b=a9dRgP38WJbQLmBHoL/qZfQ6EKEHyKXCEyVP1Zkxe07k/Z6hiEUv9Hp1VRRgYrXY4M
 GEpZO7Us4f/iTwpvuARzzq3J4OFPBeoFEXNQuRk6q2fV98RezumXBp2znLaIdomFMm2I
 CvyCVhLwmWbuPiEI+OmoipnvhATevtYCr7dqjPA2SixOfvQ6ti8IfREqYgoGRiGyUoQk
 TrE3zbt0oviPpDG2tud0n+7b+ANEX+ma331UbR/yohmvHAx92d8W2asRuf6G//obl6rp
 jU7JEcR1+TUUrfphq5dEqFtKSZXT+0X1DMVwu14RZUhMxfQHklZ94UgzDZUMmS4lFjh2
 sPvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780091988; x=1780696788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=H59yHYX/QB4nYfdzTuOV85Wghdkfd+Q1FyRwAv3AWf4=;
 b=I+q3q2SAAtkUtF+WevhTa2QBWmqp9NPTLynIxTGY1PxHoOQjNucT28E4TxmIiS6Tos
 alyIkJEyS3VdWtTzfFk8tEkktQeZ4ViuMk1RIvFELw8tclFNzM9oR3Yqm8djhcLz+cHW
 L1iQ49jTkUfNVHRQG2RbnWODAgsrif3oDesTF4aHdOckByrRIo81N/vcyD9KOnoRrf1n
 1cHrH5mH/mdsQCALazhE4HQeuM+SE9X87qrKMt5oejCeOOtKwHSbCn+F/KtmDd4VDaMM
 GSlSgtvksU0U68V+3N94WLTm0zzBoIFgjbHZzjxTekck3pxsBzRSY1n7GDSJi18GQUqg
 pXnA==
X-Gm-Message-State: AOJu0YxbYzBHnpbR1kPIWIA06NllAMlYCcAqebq1vuULSFUT4OBAY4gP
 Cu/NhN2XFRavZS0hQ8T4mzI0vtDTfRpdTwUD9ZSLVTkZvWCnGzzuWemxT0kEM9rWjKMU2bS7eAj
 FIrF3MrxFmZx6uH+3wBgZxFSIKN9/RrpNo7lq8EaXVNhX93xdy2tqXEJzzGPg0XqWGQ==
X-Gm-Gg: Acq92OGUvI0SqavWcflFRNbooFrFh+ZRzYVqouZdhwBP4Lk0uICX83eQKpn8ZhKw4AH
 0NfY9i2zCXSMxmUS3jEDRcdTJJBpSXN9JeVak4P/r3OUb777NCIHyABJffvQZVpqGFXu4FI5Mqf
 o93PTXpHh6BjWchtR/EFq+xGTpdDbHEH2nWOcvzApwcwnwmjlDUOaLaWmU5AeigJJrMxBQ3joh7
 wtW/ApHnXOnzHQ2d9ciNHNyQOxDZn+wiqsjs7R3X3VrWpkCAkduH4E3cpLuO6tb6aZGPqH+HEFa
 4D7ZU7QITmvsDrpR62ym/6TF7SBGleqvEv/OrAa//2tue6jIDUyaBR0VKpo/MVxDcnwanyIFgKN
 mteGjH9+FbUoak8KlvsKu/sR83ylBqbv/i5VaQxXO3jsb332AsOmPE4WLZbtoKXJKaiFPqZGFHV
 2V1Ljd
X-Received: by 2002:a05:7022:46:b0:12d:de3f:d844 with SMTP id
 a92af1059eb24-137d4250f0bmr748764c88.39.1780091988235; 
 Fri, 29 May 2026 14:59:48 -0700 (PDT)
X-Received: by 2002:a05:7022:46:b0:12d:de3f:d844 with SMTP id
 a92af1059eb24-137d4250f0bmr748745c88.39.1780091987639; 
 Fri, 29 May 2026 14:59:47 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137b3c69c0asm2101445c88.11.2026.05.29.14.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 14:59:46 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, ltaylorsimpson@gmail.com,
 philmd@linaro.org, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v6 5/9] hw/hexagon: Add v68, sa8775-cdsp0 defs
Date: Fri, 29 May 2026 14:59:33 -0700
Message-Id: <20260529215937.610229-6-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
References: <20260529215937.610229-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Authority-Analysis: v=2.4 cv=RcCgzVtv c=1 sm=1 tr=0 ts=6a1a0c55 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=G5se95cPlkO2hgD9IGUA:9 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
 a=TjNXssC_j7lpFel5tvFf:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDIxOSBTYWx0ZWRfX7Jow4hH98whU
 +ud6z53EBzm1Vck8KStMfCxd9Yrq5wvpsNX2GFxW3Xa6Ep/3NC61+cSrxbOxLru6QJX8JoYDXti
 FUJe9h4tIB0gr93Kkt7gEQ8jaPmvh8WH2H/tBXtkqdVAHPK3fteyPUJKpdURkEO0pbPqpHEeVMW
 lPXkjtakTvo0tjnSSjCnfZHnfZF4MT/QoL9eMOI31IzFYPjeAN3aEA8MrtnrVqsBs1anhAZYxIh
 EKFdK1RPDU4ms/5Zk77dWRTHuBFpNgi5Teib9r6jF2afS4vYmgNeM0HzLglokO/NkTRaQPBNt/k
 UiRF+QR4BMMpWFSPJzY/iPd/9hBeSGfTvqOrTO0FMz31gzRMgQFylrTO1sWNeCVFVWXWH3URAgE
 MKFSe7b4bnNkcdcuu9ngmiQ5UtfDPjFMNTVMDjHHRPkeWT49nWiMrYxmkyPn26Wfk1TFg9cxtbh
 hVIkBpY8XAnRdF+9KnQ==
X-Proofpoint-ORIG-GUID: _g78o4qXfP1WPAC9yddvvcMEuBH0musb
X-Proofpoint-GUID: _g78o4qXfP1WPAC9yddvvcMEuBH0musb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290219
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

