Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB61CD98E2
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 19:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZD6n-0002hp-V9; Mon, 15 Jun 2026 15:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6C-0002TZ-QZ
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:59 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wZD6A-0001U4-Sw
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 15:35:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FIx0Io881748
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=8tWIfs0FLwh
 3dMhzjFESsMzes2YJYF5xtbWGWvC15s0=; b=Kk0215jM6E7VaVB9EHZwe48D8xZ
 whoqCtJSSakuUvjhPamxKha6LOgrpFAv7+DTEcJGmc6+b4nW4IxIliE1S3YFVWyf
 hfwM6syl21WaMhkf5YIkXc43P25T3Z910ERf2NboFy6A8dFT8rLbtvcgmBDFsmv7
 Rzo3WewLgdOP7qKJIDkEj8PgU0fklwz7J34Y0peFdnL7849l/jjmahAga9RobP/z
 W7uH4FZiZiJ6iaDCYqZ3zObarXMh7F11yELO/8kWXQHMIQPdR1C7aLDYkG0zccyG
 fgPjv21l9KuArgX3dgsyVEqUaTawzadi7rmiR57fXjCidofN4+X2AEUYn7A==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0jn7s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 19:35:53 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-13980b6561dso3843446c88.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 12:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781552153; x=1782156953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8tWIfs0FLwh3dMhzjFESsMzes2YJYF5xtbWGWvC15s0=;
 b=WQquOHUtFhakU+H8tRK4XFOGIQ38jSzUXSOWIa5z6NaRbCF5THsWoiWY+DO3xv84x8
 RywtqmdcYaYyww80Hn1OxPLlQ9pDgeYtyV8LXI+VDyJqtT21jjeB4ui7Vy2qRYBzWyX4
 sYhWjfUOluPq5UBqZIlQgHTpgEn9AdORgBS9usi/OZER0EGk37pYUfXFbxdtcLjN0kwN
 8z3fahktU8mXqa9ydMupMjhyhoX+v2ErPw5Y8BFyNQ/uuXgFtfrIvzTJzT1Y9Oy+1HKK
 JBs/4E1fTWteaIc32dL3vLw7qDjaU3LhSxGo7KS8k0uNRbz5tsrZ8MmEgFop1U5LVwKo
 ReOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781552153; x=1782156953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8tWIfs0FLwh3dMhzjFESsMzes2YJYF5xtbWGWvC15s0=;
 b=goqdL01zEo1B5NQdUrj+O3d1TYIdXHj47Jy9F/ZUb7aXJjsQjAi0btDB+7lMMeTPaN
 Fand/AU6Q5QehPJHZHB/1wvCb4V4qdHeY2y3larDUMmqY9nsdaZ78Jh3OlZWGsC8Bh/i
 iYoHKBZqD2qiT1ZkJyMoYfTc0AVaeZdGUwlkrn0QkmdMZAkI7/JRoY7s6E+tWoGHugwi
 5ECsOlkfCiHpgDoUAJTvIpHX2zVZsWzekfDfowxd9A4YtkkZY5r/h0u4amdHE7Q4UCZn
 f/syrgVBD4UoK2AYJ+N6gxWGweYQLC2pDQcgC1CnbdpU7nxdX111drv1RBmpzQ+GX8QU
 iKNg==
X-Gm-Message-State: AOJu0Yw/7WV6bT0uwVoCSifLcSZn0bWoonJnf6oTIrHGStN62j2t4SvF
 ztZxuEqPscnrjHQXCtCz5u1gbREfAL8lwNT2B6NeWkjVLpxT+N6C9HmCAqSm0p3OTNYmM1t90ph
 cAMSY9dv2k7M8UUdGCmO20lYp0OHZrzKKyq7XpSvD7nMd4KJO2GEVnqh0ivah/+1wlDMQ
X-Gm-Gg: Acq92OFQKavHvUZPBhV1lOThHio3ymooGNcK9L4eUL5NfBTN+pR1oYoijHsVBQ7fJ9z
 GDF2tuz9F0KCZD6DB5puoQj3iNk9aH8i3ulmxL2yAFpFYh1OApW1l236tIdoSvIgA0obqx/7wx/
 YBHSEKyn6YgjxvW3ly0WUCkw9MxL72OaBQyGBXFBZb8psAYcqnyMKPWmHGGGT01mNgLHiB5gduz
 j6DKheNF0GexD6fed2KLw++2rnEwHSLa2STzCKR9w5yz0UqCfhqNzkVGxSQFDWlp1ES0ZjdHjmw
 00fH0Jdv715Fpu6FXiD1b6Ywjg5VawzpuuHgcqEK/kIpF7/+bAtZJERNxRPKy7BDtV+xqHhRFQe
 12DZ21DkXV0zIOHAYnj9YYhTzH0eV//mFFNkgmlKp5i8T3PP3YgVu8AUMW0ABHYBrP5l02MX1oJ
 JyEj9GHQ==
X-Received: by 2002:a05:7022:6b9c:b0:136:90d9:f1f6 with SMTP id
 a92af1059eb24-13985f1eb7cmr221099c88.25.1781552152852; 
 Mon, 15 Jun 2026 12:35:52 -0700 (PDT)
X-Received: by 2002:a05:7022:6b9c:b0:136:90d9:f1f6 with SMTP id
 a92af1059eb24-13985f1eb7cmr221076c88.25.1781552152288; 
 Mon, 15 Jun 2026 12:35:52 -0700 (PDT)
Received: from hu-pbouvier-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1384b97bf09sm11498007c88.14.2026.06.15.12.35.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 12:35:48 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 17/26] plugins: remove qemu_plugin_id from
 qemu_plugin_vcpu_syscall_cb_t
Date: Mon, 15 Jun 2026 12:35:16 -0700
Message-ID: <20260615193526.2883349-18-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260615193526.2883349-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfXwhu/CMXX/yPW
 yklr+F1irdE7psA0BFWlL3a/DR1SGWr2wMaW2zqXRFjlssLt4+QM3Z4XfCnmKp1WPiPtKz8S3OA
 YHS9v2YB1JC6/zV4pRmthADoiQP2tpQ=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a305419 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=XHT7D-x7ZMtFmikgfWMA:9 a=vr4QvYf-bLy2KjpDp97w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDIwNyBTYWx0ZWRfX0gz1ty28InG2
 JMdjwIgZepe0rZfFUoOpdREFOeSU19YbkwCOPi0ygr3bfll/xMN7UUxJaGksxevvcfpKptIeQad
 iiAWct7WeMUc2CWG5D00mXLpLu7qVo2wZAX2J4294LbvvgCNf01625ijt4iY5OInThDzgS1Fbvs
 ebmvbsr7l8bH46n5JrHpXVJIdDZFSJXaU/WQxVodKPPVYa4En4WIeWQSVjYFOklAdvqc64Jn9qt
 sk5+HLJqy+p3ZNlOoGyy1a1LH1BUrJuh3tj2Jkqp0rxO1U7J1nKNxrqDDRRDp6Fuen/MJa3nA0Y
 Q6AtZZ9I9hd7jb45veCd8SwVOiFJVq/SfFYcewazqY387ol3ShLWRF/VpAn/da3w3Wzv5er8MtA
 mAonc/dwToqgB4rQhVogoNVjU/Bti0rJpJqwfiE4JrWbdReDsXJvjR/tKGVUzOmSGvegxSIUzm9
 Vh+mxwi30KRbZgTO0kg==
X-Proofpoint-GUID: 4YHyBa6adTtu3RN77uSWJ_IPOkcxsvC4
X-Proofpoint-ORIG-GUID: 4YHyBa6adTtu3RN77uSWJ_IPOkcxsvC4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_05,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150207
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/plugins/qemu-plugin.h | 3 +--
 plugins/core.c                | 2 +-
 tests/tcg/plugins/syscall.c   | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/plugins/qemu-plugin.h b/include/plugins/qemu-plugin.h
index 53daa09fc72..d82d996bce6 100644
--- a/include/plugins/qemu-plugin.h
+++ b/include/plugins/qemu-plugin.h
@@ -830,7 +830,6 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
 
 /**
  * typedef qemu_plugin_vcpu_syscall_cb_t - vCPU syscall callback function type
- * @id: plugin id
  * @vcpu_index: the executing vCPU
  * @num: the syscall number
  * @a1: the 1st syscall argument
@@ -843,7 +842,7 @@ void qemu_plugin_update_ns(const void *handle, int64_t time);
  * @a8: the 8th syscall argument
  */
 typedef void
-(*qemu_plugin_vcpu_syscall_cb_t)(qemu_plugin_id_t id, unsigned int vcpu_index,
+(*qemu_plugin_vcpu_syscall_cb_t)(unsigned int vcpu_index,
                                  int64_t num, uint64_t a1, uint64_t a2,
                                  uint64_t a3, uint64_t a4, uint64_t a5,
                                  uint64_t a6, uint64_t a7, uint64_t a8);
diff --git a/plugins/core.c b/plugins/core.c
index f30009d50dd..c272f47b642 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -534,7 +534,7 @@ qemu_plugin_vcpu_syscall(CPUState *cpu, int64_t num, uint64_t a1, uint64_t a2,
         qemu_plugin_vcpu_syscall_cb_t func = cb->f.vcpu_syscall;
 
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_RW_REGS_PC);
-        func(cb->ctx->id, cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
+        func(cpu->cpu_index, num, a1, a2, a3, a4, a5, a6, a7, a8);
         qemu_plugin_set_cb_flags(cpu, QEMU_PLUGIN_CB_NO_REGS);
     }
 }
diff --git a/tests/tcg/plugins/syscall.c b/tests/tcg/plugins/syscall.c
index 938646f9359..bfe12ad5558 100644
--- a/tests/tcg/plugins/syscall.c
+++ b/tests/tcg/plugins/syscall.c
@@ -125,7 +125,7 @@ static void hexdump(const GByteArray *data)
     qemu_plugin_outs(out->str);
 }
 
-static void vcpu_syscall(qemu_plugin_id_t id, unsigned int vcpu_index,
+static void vcpu_syscall(unsigned int vcpu_index,
                          int64_t num, uint64_t a1, uint64_t a2,
                          uint64_t a3, uint64_t a4, uint64_t a5,
                          uint64_t a6, uint64_t a7, uint64_t a8)
-- 
2.43.0


