Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4270FD88F2
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 03:53:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0AaZ-0002PU-OY; Tue, 10 Mar 2026 23:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaW-0002L5-Fp
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w0AaU-0005rP-CP
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 23:50:23 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62B2SDb82179907
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6ZZDuz6n4mV1vg7UyXtzywWZTFyf36zcYE/3mP+wDMo=; b=MAZyH1wSSTFt64sQ
 b5Wv5kOOwMw6jvt3BI3WF38SrFdmqoeROiYUM0O1UmNDklvT1q6fVJ4rtGzHbrip
 6mJQmL+b25zxAE9au4O4Mn1N5hYknbom+z9jf5h/ddyT/0gQTu13pR2FXhOZW+4M
 qlyDJ/eBBXVj/MWW5vEaHwfH3FdX6hFhI/EvR3v6VKinxv4n6PMPFlsESyWrqnJu
 Q2CQNaGUMh+aF51VteX52+S7bVmVvxyIJMMvxmI+FxyfLTWUydqeYnft5NAzGRE9
 x5GDQxPt0qrL8SIKQvYlP+cJssOPwy7NVckrG+XkpBm9aUpPk03YrQtmVSh48HSh
 77caZQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ctqvsss1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2026 03:50:11 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d73c71f9faso29749493a34.3
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 20:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773201010; x=1773805810; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ZZDuz6n4mV1vg7UyXtzywWZTFyf36zcYE/3mP+wDMo=;
 b=PNxz5lo69QA8Q0cKUc678rBm7xN2s/Pm3QmTEhqtogzcWxRYe0GXzMjyVZ6jkNQsa/
 v+cLD0mHO3NiYwokhgbWkfUMPPkXL39g/XldCHfPV3DVTCYHkcn6QGPhpDyu7nCXw+P3
 O/Tr9t09ygeUT7aUd0BPw0w+giazG1TbZlDY3trcDAUEMmId1eA5v5y2M2SWiZMkg5u5
 2fJIuUG4bVGd6O1PHQRO94GoTegFDeQyBjo8MOIVllxo0h7aweVccBY0Q0S+cN/di71y
 vIvss8+QDsBPDm/VtBw6+cRLcgplK3YvvOZow1LOhMxCYwjLoxvdUuei+YuAFDa4KSyE
 s9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773201010; x=1773805810;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6ZZDuz6n4mV1vg7UyXtzywWZTFyf36zcYE/3mP+wDMo=;
 b=DMxKwtoXkp/13VY/z6gb1HQ2XacTDtrEJwlwUONybmboiEBe45MAZdgvNtDisDwG+i
 0I4HDCk9iMywrBcKNlCjhgewi8EkkmotvKCN7a9cidqj6HBvS76qTFlTiOCwgrHY34a3
 YBlxR7EcJM9GHnczc1QPG0uX0csZoNFoyJsHPdQCPpuuAfLOiAfKeeKvNUd5VSu+6KHx
 Cue7AIX49ZzPwDB0dipntv3MhPYNAU2VzrPpz8NWm0RsZdKjL2A5bY9s+cXCMLf4kh2P
 WfbwlIo25RtDvvvDmi9gQk/U6diluMTcG6MJjwAEA0ChmRVNPZJZbowS4ArAnSkx4U6f
 klcg==
X-Gm-Message-State: AOJu0Yxk9KYf2D5Y5pAAhz4yR6NNgJW8jHc6XT8cL1xQFuDhqcOA4EtG
 ngdhWb10x46hY/X1yOWa56S9H3toYK2ZU0mOe6VF4nmEQCIfkM69FrVUGyGEV0yPd/qp8VgDmue
 mRGMrLjhNf511H0BiQOLGNralJOtiQEBx7+00jym98vNylBsYomi4WakBIrFTYRnTPg==
X-Gm-Gg: ATEYQzxIhx7nr8QYPoj8Yo+e5eqh8PguaVGzPu3dHXrLtOAlcH864WrKO+C1Q2+sTaf
 vKIhOUO1d8q+UriS03cvXExDZUYwsR1NHVVBj2GXm6aJWJ/M1Ebo6VncDkZcK2Ob2MtDMh3KTyh
 YSQVK4OtopvwZ3+voZfWLZQ1xmhFEdN+QeV0B+cxVRehi9AUAIOmvS+GKyhGjL3tEqAmcAEZzaR
 rS8Ke6ktkhsbkYEIUx32iYurT3aqxBP9B2sS/s0W7qyxDskPkuDWGljINXteN+JYMd6yPSup9nS
 GlzHpbYmN+BxfOyZGxnAOQc4Z+6EMb/1Xj3jB1K474EjC05oetknjGfYqB2Oy0kFdncqW7DlF66
 9pXAf+KtsQ4g95k9us1K/ye+ESqs9u+PtxFwBOLB/EuTVmO9EEvaqvdlKM30A28cfd341VQ==
X-Received: by 2002:a05:6830:828d:b0:7d5:96a3:f7a5 with SMTP id
 46e09a7af769-7d76a6887b4mr1060161a34.18.1773201010513; 
 Tue, 10 Mar 2026 20:50:10 -0700 (PDT)
X-Received: by 2002:a05:6830:828d:b0:7d5:96a3:f7a5 with SMTP id
 46e09a7af769-7d76a6887b4mr1060152a34.18.1773201010225; 
 Tue, 10 Mar 2026 20:50:10 -0700 (PDT)
Received: from hu-bcain-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae39b39sm946430a34.15.2026.03.10.20.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 20:50:09 -0700 (PDT)
From: Brian Cain <brian.cain@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, philmd@linaro.org, ltaylorsimpson@gmail.com, 
 matheus.bernardino@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, Brian Cain <bcain@quicinc.com>
Subject: [PATCH v5 34/35] target/hexagon: Define f{S,G}ET_FIELD macros
Date: Tue, 10 Mar 2026 20:49:22 -0700
Message-Id: <20260311034923.1044737-35-brian.cain@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
References: <20260311034923.1044737-1-brian.cain@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDAyOSBTYWx0ZWRfXw8BFzZ9zx6z+
 dXzu8yZwCH/aRE0vVMI3cYuLFm5V1RUdxgQWGrklwmXVHs1Bsm8yKHrsf2VY9ySdg/ExDrgzTaN
 YjcMN6Zu1f0j7EK40ltDoIMORplIHqbQY5OfKieHLAtCz1TEXevjmnIlZ/5HLvrDZu8w42RYNEW
 RQrDNZkpYnjUFNQE4B7fujxqIcMCuNQFEGkfEPZFfrPHxny7/a0I/43NUdVvb7pAKwOiS/Iy13o
 jyR0dX6cqjkOzPBsj3yyqkoFq6iQ3GrwhxrY4ul/M0qQi2o1owDSglwelMeZ+eBY2h/bmX2T9wk
 1F6e50kmEqoPrH2XnC/9v7+trNG5HHMewmCAphTqf9CoGaTNB1dPqVdZkWI6dK2F55KfAQ2T500
 d4u9PQY8QNENfw0aMGFs1waDcfpRiySgFvhhJLcXTJuiGC0x5fQAuWcJB0giDlFeT0Ha4KQs8TW
 jnYJbFuXZrgX0kr7/hA==
X-Proofpoint-ORIG-GUID: cOXrE3jxfSuhxjyH3dDD-5KY0MtN8cdh
X-Authority-Analysis: v=2.4 cv=Lo2fC3dc c=1 sm=1 tr=0 ts=69b0e673 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=COk6AnOGAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=OC-ZKJ6AczBSh3OnBRYA:9
 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: cOXrE3jxfSuhxjyH3dDD-5KY0MtN8cdh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110029
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

RnJvbTogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+CgpSZXZpZXdlZC1ieTogVGF5bG9y
IFNpbXBzb24gPGx0YXlsb3JzaW1wc29uQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1ieTogQnJpYW4g
Q2FpbiA8YnJpYW4uY2FpbkBvc3MucXVhbGNvbW0uY29tPgotLS0KIHRhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi9tYWNyb3MuaCBiL3RhcmdldC9oZXhhZ29uL21h
Y3Jvcy5oCmluZGV4IGU0YmZlYTQ5MjNmLi4yNmQzZjdkOGE0YiAxMDA2NDQKLS0tIGEvdGFyZ2V0
L2hleGFnb24vbWFjcm9zLmgKKysrIGIvdGFyZ2V0L2hleGFnb24vbWFjcm9zLmgKQEAgLTY1Myw2
ICs2NTMsMTYgQEAgc3RhdGljIGlubGluZSBUQ0d2IGdlbl9yZWFkX2lyZWcoVENHdiByZXN1bHQs
IFRDR3YgdmFsLCBpbnQgc2hpZnQpCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9b
RklFTERdLndpZHRoLCBcCiAgICAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERd
Lm9mZnNldCkKIAorI2RlZmluZSBmR0VUX0ZJRUxEKFZBTCwgRklFTEQpIFwKKyAgICBmRVhUUkFD
VFVfQklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0u
d2lkdGgsIFwKKyAgICAgICAgICAgICAgICAgICByZWdfZmllbGRfaW5mb1tGSUVMRF0ub2Zmc2V0
KQorI2RlZmluZSBmU0VUX0ZJRUxEKFZBTCwgRklFTEQsIE5FV1ZBTCkgXAorICAgIGZJTlNFUlRf
QklUUyhWQUwsIFwKKyAgICAgICAgICAgICAgICAgcmVnX2ZpZWxkX2luZm9bRklFTERdLndpZHRo
LCBcCisgICAgICAgICAgICAgICAgIHJlZ19maWVsZF9pbmZvW0ZJRUxEXS5vZmZzZXQsIFwKKyAg
ICAgICAgICAgICAgICAgKE5FV1ZBTCkpCisKICNpZmRlZiBRRU1VX0dFTkVSQVRFCiAjZGVmaW5l
IGZEQ1pFUk9BKFJFRykgXAogICAgIGRvIHsgXAotLSAKMi4zNC4xCgo=

