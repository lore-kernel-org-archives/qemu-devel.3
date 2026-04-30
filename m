Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACD6CD13D3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 20:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIYA5-0002s8-Sy; Thu, 30 Apr 2026 16:39:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9z-0002mn-Mh
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:39:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wIY9v-0000sw-DR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 16:38:58 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UIjQ5b563970
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=MuMGZIyU8Es
 EucXeveARFZ0iuXjJOtWKT+BHVswZ9As=; b=eFFknTZ4QdZWsWNSE0MgBZlXSdo
 MWbamA42y17e10GH2WTHr7hGDCz8fs0SBQI9Em57gy3boDcuFz8iuXxP1nTaJMuR
 OZLY1fhsWJXDTh4W2kfcDhdiRuHXhSGrJSdEVR3n5fxjIyFkMVEh+BECPU/lQwpR
 1yoXehTwp2zE3fMyoscfMg28CMg39KIBqQrNfPMB8Q+2QrTpJ7Ftckl1JvkW+SvA
 rm5hciR/G0FSy8NwPIlEAfpK6STkmEZfafW7C0+2Lee4SEIxRJ7887r5JO86I1Wv
 qj6rHZsF5563r+XlLLN3bcCdyvHtCpFAF9M2q7OotkM5K0/fPe9MOscnP0g==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dv7wut3rv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 20:38:52 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ee34588671so599175eec.0
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 13:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777581532; x=1778186332; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MuMGZIyU8EsEucXeveARFZ0iuXjJOtWKT+BHVswZ9As=;
 b=Dzbbv0P8kVEbGBAfDQiJccgNEmz5g+ImImdyp25Af1OcYkHjtrPdH/JzFIPRPPzw0a
 8xmkBTWlXZotiWssmQK/1UFaGonc4pTt12zKZ1VzPKTJbxsZh0H2YNMkmjX9di4TQxeC
 6JocXSuNmV9Mb8xDMnOQ4jM7bN4kxvv6epp6a/Z1CYfdB4wxvordb3Oxu3LI2TpBAuws
 RZNx8avDDJcaKOS1jx+cP+WNV4dp8sgrfNYeTyilAA33/QAqxlNv6/ytM9OvubJcI6yy
 993TJezRuwDCLhRgU6iE8EckhhjqnlCFK9qldsWgtkp2m09M8fhSCPvht8zmdipwueCJ
 flSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777581532; x=1778186332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MuMGZIyU8EsEucXeveARFZ0iuXjJOtWKT+BHVswZ9As=;
 b=oibY2dx4IRVCK+UMfykl1uyipD3wLEVgQT2XUj1t9pc0KcCw/xnYTLq1u9mPXr6VBa
 U8d3yEyfuek4Le5vf9bbA5P54bUDQQQmRp9aUPQb4XvTX8GRTuI1uPhxU+Oimf2Y7MPi
 ssUOcdQt+pqhzoyajgQaG/dmhY4witp3UVQjWoqUKyOIqWP/YpFqVKPxOVGy7V1R4UwF
 OpU7lgl69BMFJjFQ4EPawTOxyMf4pELkKXxx9caxEPqJOH8euVY1lKpGvHsjR5mEhVLl
 V0lzUkOEDakovK6FJd+0Thaye71PbaB6mpWNG+ywQI1+qOn8Ua/qaPJ3fSLgzKNRG19g
 dQyg==
X-Gm-Message-State: AOJu0Ywx+Ldm3pJFhK4tKjCnv+4xd5zu2aFY2VSap9u2K4AmBhGKLtuz
 ObPRhLzEeq6oXexfJgpFku4rM5w91m2wlvLssgCgBp+ZH/xClRqwuLJhp2k4KbYynHBtVZsh4oa
 gD7KmWaR1JpBTZOsSw2H3cNUgLdQ7jDtGxvV+HJiqVPUsaKmCkyf2yzXzL8TY9mGiTZTr
X-Gm-Gg: AeBDieuo6dBZXbvZJBGKISW0bQ+8FWUA8m7pSZZQVxsdWo7P3JOfpQQmJYxgTMEVVaX
 YVnXHZ95X1d8ubb4FoDu+vTjffzucp9bHuy2M/UYSVR3qv3hk4Q4VRYjmFqD+jMvhxezvRZccHV
 OqFv/+zDnRCwBgr7X3l+UH0GWqvqA/zKh0uudCppFCLj1ygY8qrarOF9ZDgBlntdzBhD7J1wsQd
 YdCaNrS7+KEgrM/HrVBn1ZAFZCYsravBBy6cgRN0ubqGbqdrEFpkxSTHqg1rbFAZllihwjYjmjp
 4l5naLOtmOtRPcFlN/fJepsA+mn//RZm5ALWQdFxAZ05DqMeibVIZ75lpHP647eaUkblwaQ0ISe
 OIa5kOJ+sBDSnpz0+Weq4WIsP4bD1qXiIqPuMQllR4ezGHf2Pb617Jh442Ju/xPvUui74G9neDT
 V5ycO5GGDtwnI071aM
X-Received: by 2002:a05:7300:4341:b0:2da:d4b4:c85a with SMTP id
 5a478bee46e88-2ed3d8b85a3mr1866212eec.11.1777581531688; 
 Thu, 30 Apr 2026 13:38:51 -0700 (PDT)
X-Received: by 2002:a05:7300:4341:b0:2da:d4b4:c85a with SMTP id
 5a478bee46e88-2ed3d8b85a3mr1866192eec.11.1777581531148; 
 Thu, 30 Apr 2026 13:38:51 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3889d628sm2202341eec.6.2026.04.30.13.38.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 13:38:50 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 marcandre.lureau@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 2/8] qom/object: init OBJECT and INTERFACE type early
Date: Thu, 30 Apr 2026 13:38:36 -0700
Message-ID: <20260430203842.29156-3-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260430203842.29156-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDIxMyBTYWx0ZWRfXxernYMwufFnF
 S5sXIaqq58SM5KOETAQg8SdWeuhx3+5Qrrvccn3Imf/cZS8Hk4qBwE8WtQVWfCzJZM6lAd/jkYE
 z5KkpMlk2f4DN3m8hQt6Wb8fROfhvYULc6VoqBGJVGbhMdbAgUwSxnrMPDCD5xqsoYK5MUQuoq1
 gQS9Iv2Luy5jTVnWNV9G1IQn3Uk7umR+Z1299Hqx54WbODWDS81S/0S/07Tn9DmyWk7QH4Ga/5V
 mDHCPZyfjKevsdArzBsgJSx07ORLUI9tLvQBnpHdIz8fgRaocf0ttLgLbJMF6Qy3AyyTuCfAdfV
 k/dfJQe5pSwMWugpp+/TqUPk8CgBZyDUFBjjx0ZXGPYVMqJUFXPYiLab5f7ATsv0GBUz5dIKuTF
 eClLReQztMkoPVf0gpW7qMzFs8CZKi9sV3aXfPPu+uZhSQOzQ4vUkJ0rYVmSmIX8L8m9X0DYHIf
 2joKl/n4QMoeuhL8yxA==
X-Proofpoint-ORIG-GUID: 1RXWK3j505hNlt9xQmhUSeAWh1TijFEu
X-Proofpoint-GUID: 1RXWK3j505hNlt9xQmhUSeAWh1TijFEu
X-Authority-Analysis: v=2.4 cv=GMk41ONK c=1 sm=1 tr=0 ts=69f3bddc cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=5SPJjbiQiQb8vRSH_4UA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604300213
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

We need to make those fundamental types available during QOM early setup
phase.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index f981e270440..2f92b2249e7 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2858,4 +2858,4 @@ static void register_types(void)
     type_register_internal(&object_info);
 }
 
-type_init(register_types)
+type_init_early(register_types)
-- 
2.43.0


