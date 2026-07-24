Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E24A0C531D0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 00:11:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn3UP-0004ia-Kd; Thu, 23 Jul 2026 20:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UK-0004gt-3g
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:04 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wn3UI-0005u4-1u
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 20:10:03 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66NLeMkY955617
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=jU4c1dJaGN1
 hHm5c0+BF0y9mFme6YJCLvFRXXkYqwbc=; b=S6eqCS32l1AALRUwZzwb6r+VcWP
 8eZ+RZrC3Nhpr0qvNwQIdYMGShhmDDxUbYjYTVPlQa2mjEjLpM6CnM2vB/Q8DCRa
 pqphu9GnJx53YqhhvpUiEOMLmzk0tjioSkdOjaK2BwDHTjIt9Pdlj7dp7i4rZlBW
 1NsDSFZXAvMy23YeSYXMhFunBYJwx7FaxJaYu9M6DtJvLC/qCbYTAfFJpIMVlOVk
 qjru9fPVggmzqjJCoXFzoopK5ivflMqx1hVsCUrCg1HnkOPL5Qn4eftRuaeT/52u
 Z6iV/5q9Omb2MJcfuWaKjyCFx+T5myPHnEWYw+gIfdfvKq+noVRahNvahtA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkjnuau63-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 24 Jul 2026 00:10:00 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cbb20f82a0eso1705478a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 17:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784851799; x=1785456599; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jU4c1dJaGN1hHm5c0+BF0y9mFme6YJCLvFRXXkYqwbc=;
 b=gqq+Lx/LK2b1qrLhmd2YBJw3kHwckYE5pf4hVQxRBEIOIkHiSiOxTIXEVrJqBk4as+
 s0g7K2dyo8Pg79Bw0GXD03Xs8BMweAG4TIsvBf7D1RyiHALbC82qw0PzOA6cqgx7zA19
 sgAgwJ1GzGaPP5z8h2d3TO6lbObT1WmYTFlsHx420wuZ+EiLOu/XNqiZynRO3MeeWbTR
 uEnQz9sVdozybtrmPrtAJz3wu/amwmFxrYuno/kYpqgi6QqaRq0H9pYrQXtPdt6LIXV7
 IsWytxM4CXUCgG68738LK6fEDVNJkfJwY6simhk1QS9vLiL+g3yP1//JxXS/Nj432yFS
 9pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784851799; x=1785456599;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jU4c1dJaGN1hHm5c0+BF0y9mFme6YJCLvFRXXkYqwbc=;
 b=Y4hMmh1VCTDgcAzGx0wRlfSsEH1Pym1tSvqXb3z0l/T7RMY3q/s3YKgzyvIqjPk6f5
 53qSKor5gTHa13v3fvJoKqTAoSgar+UdLp5RbkOVSnRrymQ8Fv+6q4zb7P/MefEU35+B
 F4XQAEjiSm6uRG1eyQGGw7D2VcdqIEXHsQ/SDN8oMbSC9aFGfFmvsiFZLl0UqY57OlV+
 2B3pzw7i5hhEjNgnF/bryT69Bu07gT2twTgUvColWYqyjyTR+G13ZOLrN+SQ190tXCJU
 +gHB5nkjbey8tuFpYXRdZN4m149vDDJYX7F3Vmv9joRM62bX7sEd9oGdPdBK8LrgOgRZ
 rv4w==
X-Gm-Message-State: AOJu0YyKUwwrMooiFWfwhgMHu/1FXo6b4otQAAeJnkXM0QlNJUr2wudn
 /fppEFSxNkfa9SsLj3YbdpBeRVFtRpT8G2SJHCYXSwpCi0FrHb9AtUhAq2oTOg8+5dy6Ygs9WNl
 2KfQYcFZpumbBbHha57LV4/69vyfkI/GESEGnDUWbSXueuX8kj5xZpt8g3rIPQEjcug==
X-Gm-Gg: AR+sD13cVYC0S0nNYlmlNbT0ps/fYBIbUqJHwpGMGf/c6Tcuu7Ps66gduSsvAU6t1JL
 mPW/wa94xb5NeEJtpFqDSQXaeAKxwKPTsluIcxzS3KwU98nkOPlLsKpRl+xWwClB/daxFtBUs4j
 Nsy5Ibc5njioIIsiP0AsaL9m1CANmABc5VaowYhPV7HYjth1veHNCwcWR/sv7Lm4GU+qsi3StAZ
 4k5KcmEcG1kcFkIrOZIRiuHOU5vJrYTOWoo5nM/44P2QKUEXvqJRpiQ2v7mfK3nZlUJB0K87vrG
 mY7lvsixPpz2TeTbWlE1xdWAONqhA/y2Hk6VRo4oxjPRbBLCYiNsroKW/MGEZQIELnqr8miyFHq
 zkOZSr2eEC1iDQAbekPxt0LhXLU1y7VlVgY/JPmUYQIXIZV2oT0SL4Qsx/wUB6EM6BFAaVmg=
X-Received: by 2002:a05:6a21:7a95:b0:3c3:9dc1:f4f8 with SMTP id
 adf61e73a8af0-3c44b2b9da3mr5554114637.76.1784851799397; 
 Thu, 23 Jul 2026 17:09:59 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a95:b0:3c3:9dc1:f4f8 with SMTP id
 adf61e73a8af0-3c44b2b9da3mr5554099637.76.1784851799020; 
 Thu, 23 Jul 2026 17:09:59 -0700 (PDT)
Received: from QCOM-qjMf8PBlDw.qualcomm.com (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1bc886sm24359478eec.26.2026.07.23.17.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 17:09:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 03/27] target-info: add target_riscv32 and target_base_riscv
Date: Fri, 24 Jul 2026 00:09:23 +0000
Message-ID: <20260724000948.234657-4-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OWgGuhZlfd-CMHHjO4Zh14Ig81gy7xFE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfX5C8ylTRFM2kY
 vmL+9Ppd3fgRBzTYpZdVo8MTQKZszG+2R2vTyFZMkzlN4utRitZ+MfKxqD+X/2mjGI7sCtBjokf
 yaXN8TWAcl9BD7pcN2WnMJDUyVJwnoE0PRehMyneezywCsoxGPRVJqsO5W68TSTNwZ/SoZ0uVM7
 CbKfw1R4V0ETz5Y62ZFYKoCuLUtiZEcLGI9hUiPC64OxP5OztuCW28L8e9Dxc42JRuKAAq4ti+R
 fONJe1Wb7STLBMUB0qfxogStGzJ2giqwJ2mZS3lMd9gNT9MnpiIX7oc2gGMCAJyj3whWL+23zvW
 mq72SKypaBtzJ6H6NI6utRTZloXcSDNp3PRarkeCZ1HgbqusnpuCEJgt7ruBbpaIYUaNRzrx5qE
 CRGSW0p9rafNhlvUkqTnpupp0aE+lgTY4HfSb+9a+dyzgM0Xh+UHxn1yLTBbfrRStVNpf7LBtaQ
 E77gMdx3vCqtD+3wF5Q==
X-Authority-Analysis: v=2.4 cv=Een4hvmC c=1 sm=1 tr=0 ts=6a62ad58 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=Drpi8JZk3zr7esNuAscA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDIzMyBTYWx0ZWRfXwC0eCISjjNKb
 ujUdeXslRsFmqFJz9Flr+s64qRQp5crLptOjJJaMLDMDIe34NqlFH7XHBQ+4WJNCmkfD8nv9d+o
 Qf07bJXq3PQ7isYB0bfqdVJI3+cuRlY=
X-Proofpoint-GUID: OWgGuhZlfd-CMHHjO4Zh14Ig81gy7xFE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_07,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230233
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/qemu/target-info.h | 16 +++++++++++++++-
 target-info.c              | 16 ++++++++++++++++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 6c5b714288e..88ccef2a988 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -99,10 +99,24 @@ bool target_ppc64(void);
  */
 bool target_s390x(void);
 
+/**
+ * target_base_riscv:
+ *
+ * Returns whether the target architecture is RISC-V 32-bit or 64-bit.
+ */
+bool target_base_riscv(void);
+
+/**
+ * target_riscv32:
+ *
+ * Returns whether the target architecture is RISC-V 32-bit.
+ */
+bool target_riscv32(void);
+
 /**
  * target_riscv64:
  *
- * Returns whether the target architecture is riscv64
+ * Returns whether the target architecture is RISC-V 64-bit.
  */
 bool target_riscv64(void);
 
diff --git a/target-info.c b/target-info.c
index 04c69c41f8a..7ac2260b182 100644
--- a/target-info.c
+++ b/target-info.c
@@ -94,6 +94,22 @@ bool target_s390x(void)
     return target_arch() == SYS_EMU_TARGET_S390X;
 }
 
+bool target_base_riscv(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_RISCV32:
+    case SYS_EMU_TARGET_RISCV64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_riscv32(void)
+{
+    return target_arch() == SYS_EMU_TARGET_RISCV32;
+}
+
 bool target_riscv64(void)
 {
     return target_arch() == SYS_EMU_TARGET_RISCV64;
-- 
2.43.0


