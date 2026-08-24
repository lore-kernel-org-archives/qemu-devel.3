Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD58C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4O-00058u-1G; Mon, 24 Aug 2026 11:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4J-00057m-D0
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4G-0001l3-6t
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:39 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFnBtL3329769
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=nnFxmkUXSdu
 WUIyum6POa3vyphYaCWoT2qAoNMjzXm0=; b=kvGaP3sBbR86PNlWtGtYwS8JyeG
 81aPe7lUINkqDI4YPMfJo4NHvcVfyg8qLlnLDAQcOkDE4LR18HATbERk/dBFe7It
 YlddhXM8cViEWaMheHsf7cZUVkjIIZlwKSl8KPieC1Gl2wNpOn1kqo0TcGMlrnpe
 wDPEsRu2Mvu8e0NZP1hJEI5nuX9E8uafgbn/GTLfAyLnTUIxLE3w53M+ovtpKs8l
 5Kk/1Z4gJzhP2NjQCbzYbreRq6KtrLdagZw8mCMIVvi7Lw5M+WcQTa2ONMIFa7Dj
 5p1ny3o+9BQA6SsICKLfXeOo6l7pV9vUV0LvlsMhydzD9SNZ+Qdj7re3g7Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8j7r1xy8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:35 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ccb6823efcso29703495ad.0
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587114; x=1788191914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nnFxmkUXSduWUIyum6POa3vyphYaCWoT2qAoNMjzXm0=;
 b=LeoI487j+lVMkgBBbgwx9x/25tNvAmVjrFAAmgHy+asqWGoTNiaTv0OZdO2oO7vB/V
 wdBKpG7GO6smG0Z9MuLy5dPsF0ZQceM7xlez+4n5lnC/uci9oNh3P06gjnyvhxfTHE2j
 OLDEW7HicYYMjfjAx7zG7s0arPq3JJIFz1j8d+VeXBgrOtr0t4BbMZsPA27OzAytpXca
 1vBa7WrXPeV52OqDnxZtU/oizy9oThYOoKwkMbvjdu8VXwfmImKbuLAaSQtJZ/zkiNJd
 2OCDVBd01x++Ieh8CAeBXhKhELQtGVXc+Oj61s92R605Gcccym0WgQKcltBc9SZ5xYAx
 wr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587114; x=1788191914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nnFxmkUXSduWUIyum6POa3vyphYaCWoT2qAoNMjzXm0=;
 b=btTSH+GE0hei7ODNCO45sPbDZezyXHjhliqUjP/kEVE6agc+I6iQeIXIkISESSSNuA
 hBPHw9erWxJOaODOFDu2wAmSn9qm5+LqngwjGrhhfm5dT8d80rvWRPE617/W39mqhA3G
 N3L/bJYs9VsQA9wyRnYz+XlTQ7iQH9wWxF0kFZwf24jA2IQO8X8lR7bMTBM7HrI+H7A7
 fXo037F6XtezDc8pgPHN4OxZecro4kINJmcFAIMRl3mLggCMRQtT3YTkcxx3iy9sr8mX
 DSZD8keGevIKmLWEEAa6t4pxkKWXUoColFaCc/mCokTV1P04DxD5KIk3VHmuoPcEYonA
 LUDQ==
X-Gm-Message-State: AFuF++n1YkjPJ8LGMADQxinXXy/ZKtP/hKnlx0eFhAVyB18wCuhmkjfg
 DaIZiV1Vtm7JF+GmVYs/Qi+ifmkeNCnRuzYgy/sBW923T2QiHL0SqBAtEwuhyqWVcpSUDNcUsHb
 pwvHdf27bgw5JEev4Mdvy29CD3fByn+0mfEABOj5y8k3wJ8kaQUvKOefleyXZaspPvY81
X-Gm-Gg: AR+sD122MdL8x0hz2xFr4/ZSXvRd+iD/87lgPIQofpTPaG0dcnW2pQXojWzPC4s5dpS
 RUgCbeZ1442IE2/X8fg1PI9RPNb7l5uCtr1sGq+6424oHUyrsyk3dpEto5c3UyjpxJ6a848ATMt
 PniC9pSQ74JEaDgF71Oc102cny0glOvh5vjR4qwNKnKD4ZI4kU9+4SabbDnXZqSdb3al9exY/xb
 C3WNA9hQdoeU4VMGO23BMrnK4Q62wH1oQm1Y1Iv2qDmwLuecUz8D6zUtB/UdZ6EZAGIpgboTkIG
 9EJE/d1PBFqMSGUuVZ69nCmZ8XBKnVXX115OrmwDPJi3/LMuhTFvMNcWDuS9jpNzNW0/ReziOmH
 XMzYrQQ6r1/iUwnDdP0sBWzVtQkeFSbABARFJft9vYSafj3JbQzDDsYpynNAdHKo=
X-Received: by 2002:a05:6a20:2d0b:b0:3cc:51ff:c2e7 with SMTP id
 adf61e73a8af0-3cd4bbdbd2emr37029127637.10.1787587114256; 
 Mon, 24 Aug 2026 08:58:34 -0700 (PDT)
X-Received: by 2002:a05:6a20:2d0b:b0:3cc:51ff:c2e7 with SMTP id
 adf61e73a8af0-3cd4bbdbd2emr37029028637.10.1787587113852; 
 Mon, 24 Aug 2026 08:58:33 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:33 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Subject: [PATCH v4 07/14] semihosting: add callback to set error
Date: Mon, 24 Aug 2026 08:58:16 -0700
Message-Id: <a37971603c4704876c6f34c0377fc88a427e8f6b.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX6KpYXHaZhc0k
 QbJZg1pXrWAQOrMFbwjoZ3EgSQn5OhMjRteaUIA0cXcceBu3ZrvxmeBm+DOCqZ4myOVugcDUZZi
 17ovIXKChgXKHJ3fv2Ffke6KxSBDdc8jv22yBpjUfGvnX0ZDEgVA1i4geh1Sjh84FYpmPqEi+Mi
 fEJzldHz5EZhEK+SQsSEqFQkoN4iHJFxr6TyxCBs3SX1gmqkkG1vS/pH86rMCymgLpVRwpgDvc9
 pJFDdaZvzlgNmcy24aVyKghMXIgo5WZntJw1jG3owIH8B4r0QNDPwJ1H0hFhAq9dxnXuMYKjJ1U
 7Q9BK98Az/7ZPJ0YkkMkdRq7VDD043sgIG0fIcuyn5A6YnZLXcoaoWUO1H94poES15xlRSDFo23
 /bPYOeE+MI//2+GJEM7rP83Ot7HcvsDJOWKq2NRuGU0AGiuimpNdll5a/xZmRj1P41eq3uIeGB2
 47cVUdB2TI8pip/nzEQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXzjnHRk+Rd04z
 zEPgQDhXW1/JlP/kZTNswu4Eyk070VVENpveKCChFmRWmWV74rN/XcEKa4Tgq1Fvzy0R6wvOjVe
 Z3x6nJEDkBsYZuK6jQmRlJsZWTgUhU8=
X-Proofpoint-GUID: slCNRGvfEn_rWOpiS10XSrQe_evIdYhu
X-Authority-Analysis: v=2.4 cv=IL8yzAvG c=1 sm=1 tr=0 ts=6a8c6a2b cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=8ndNYmkutmpv_8xOvXsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: slCNRGvfEn_rWOpiS10XSrQe_evIdYhu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
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

This is currently unused by existing semihosting targets, but it will be
used by hexagon in the following commit.

Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 include/semihosting/common-semi.h | 1 +
 semihosting/arm-compat-semi.c     | 1 +
 target/arm/common-semi-target.c   | 4 ++++
 target/riscv/common-semi-target.c | 4 ++++
 4 files changed, 10 insertions(+)

diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index aa511a46f4..a11905ef4e 100644
--- a/include/semihosting/common-semi.h
+++ b/include/semihosting/common-semi.h
@@ -37,6 +37,7 @@
 void do_common_semihosting(CPUState *cs);
 uint64_t common_semi_arg(CPUState *cs, int argno);
 void common_semi_set_ret(CPUState *cs, uint64_t ret);
+void common_semi_set_err(CPUState *cs, int err);
 bool is_64bit_semihosting(CPUArchState *env);
 bool common_semi_sys_exit_is_extended(CPUState *cs);
 uint64_t common_semi_stack_bottom(CPUState *cs);
diff --git a/semihosting/arm-compat-semi.c b/semihosting/arm-compat-semi.c
index 5e5f181b90..c54753f696 100644
--- a/semihosting/arm-compat-semi.c
+++ b/semihosting/arm-compat-semi.c
@@ -237,6 +237,7 @@ static void common_semi_cb(CPUState *cs, uint64_t ret, int err)
         ts->swi_errno = err;
 #else
         syscall_err = err;
+        common_semi_set_err(cs, err);
 #endif
     }
     common_semi_set_ret(cs, ret);
diff --git a/target/arm/common-semi-target.c b/target/arm/common-semi-target.c
index 2b77ce9c17..38d52deb3d 100644
--- a/target/arm/common-semi-target.c
+++ b/target/arm/common-semi-target.c
@@ -34,6 +34,10 @@ void common_semi_set_ret(CPUState *cs, uint64_t ret)
     }
 }
 
+void common_semi_set_err(CPUState *cs, int err)
+{
+}
+
 bool common_semi_sys_exit_is_extended(CPUState *cs)
 {
     return is_a64(cpu_env(cs));
diff --git a/target/riscv/common-semi-target.c b/target/riscv/common-semi-target.c
index aeaeb88d53..38a00e160c 100644
--- a/target/riscv/common-semi-target.c
+++ b/target/riscv/common-semi-target.c
@@ -26,6 +26,10 @@ void common_semi_set_ret(CPUState *cs, uint64_t ret)
     env->gpr[xA0] = ret;
 }
 
+void common_semi_set_err(CPUState *cs, int err)
+{
+}
+
 bool is_64bit_semihosting(CPUArchState *env)
 {
     return riscv_cpu_mxl(env) != MXL_RV32;
-- 
2.37.2


