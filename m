Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF878C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjMwF-0005iR-Bb; Mon, 13 Jul 2026 16:07:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwC-0005gY-UX
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wjMwA-0006QN-S9
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 16:07:36 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJ9jXn2461288
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=oigHGWTP6a+
 NaIv/poYxQToMY1Wet6qxAv59+TKTXw0=; b=jBDFYDJ30TAnCEUsfScPgdDYQjA
 4rYKSY0/gPtI25a4qazT8NiWDmaCSNPJy7BDMAblQhLGYcS4jiu6mdxV9fWz675G
 rU3koRDPc0R15uVI9e299TPQDMCE32687MCjC5l+IG7RECbxBEIKLeLb5R48JjsX
 iJ4m7Nrc1w0GJ6yqpCpRFNA9Y/CYhRyhob93KLbC3B5BczdCzK0HEtC57ygvgQpA
 x8GgHHs69c2biRhO5owHbdeLmaZGW65sxC2OBYGr9TlNLyOOW8M+g3SAB8qo+bGv
 +t+QfJaD7T3fjpjvnJ8MhK0PXeZJS/DQtumzYiGcn2F4qX3NgKXs55jD0xA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwda2fj6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 20:07:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38dc085b0a7so4609076a91.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 13:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783973253; x=1784578053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oigHGWTP6a+NaIv/poYxQToMY1Wet6qxAv59+TKTXw0=;
 b=N7Ltw8/5eq0h8mC8ZOjN1xt8IaevJiB3XFauVr6qfspMcYxKGnJ88tSspgP/2YieiR
 68kGd/kGXhDTF5zf/cl9wUGZOUOpvGQAspBCfbp3IwdNyie8+QwmgtntzZQwt+xg4uux
 JfW1IeZt0uqfr7W0nThhy+pNOooXU+V3EQsIPxaJqXmaHjmBW/XWudO5GcFOeyqGTGhg
 fAV0RjMiGbu0emg8BapdzZaiWcVMK8daaPvDb42guZZlPyK6O7inUkBOqu6BBUKRV4MQ
 AcyRla+BEk0Q7rd5lmrxrF7mFnfloLGBgZVxJujCw6Fcc+Tal7qlNKmW5kFveCQ5jcyA
 9Wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783973253; x=1784578053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oigHGWTP6a+NaIv/poYxQToMY1Wet6qxAv59+TKTXw0=;
 b=UhGOE4LfpNMOdOQFEdxVRlx9XMx+WKwqqYC918XY/BA0taAk4BUBYGXUlsJqE+9jTZ
 Mv+LydHEcSKXvPbLQfF1U3DhTgFQDe9JB4jo3bqd3vdibU+VcPRI4LP0SwLsTMNejUC5
 WPnphDqDLgSgcLo9u6XPfJFOG/zeS3A1YDwkXy02oSgKpPf0NkCqoCavMtyuAbrMABah
 EYCp7l7gwGeW0ArmRmVZ0L7OuPSAzqBdZrXfMFUpYAjQsI8yvmoLBQwi4sYlO5bHUNlG
 2zhLfdbtCMsOP4lvJXP1ufSP+OnH9a6U2LQlFBH6tNFhaRsokVa+OP+ErSamsPU0uRl9
 gvEA==
X-Gm-Message-State: AOJu0YwiyjlODMUa4FCk6Bc4Y8VRDXqVlqphxZproNdlSXhdlGT5NqS2
 ni1h79kb6Ugxvj0ZvzLslBjGBZWD3lm3tUTYxVt9lR5UMlPBtK5xsvUUcyvPBOFPhsEG/bv6GFO
 0Td53gYo1YLM6hhZzGrykTFmNeKcOlGnJny2m8v/4l52V147eHUoFHcZzUdl8KW6C2usf
X-Gm-Gg: AfdE7ckB25rUgQpDLElqoQi5DyNznFBek7EKSn3M0PIXwOqBESXIv9MKbVx0z5cw4vi
 5nnJfZ5oRrzBfQWokiXVNDgJn7YURyldJ9asZsuOpkjR05DXQughe45AjmCygmNbX8Jcrj5EktW
 Oyai8GFcVAP/9fJQLS/XK0GR5YUZZAM5zUf8t2ExdUEUqjrMHYgqGGBHY2YVixX8bX737PsDPbH
 lYJ9NB/lfCEhU+FTAoDK5vfnPf421oUya5e0tRVYLPFdX8WXma3tqTSTQKR62eexhRkMxODMy9a
 1LXYOt0LYHlVdUj79cXonmUL5ojOyDHRHlTG0DLLvQa83gLVTQ7UMXa//n6UyyZ3WIFa54EtgKX
 K0twNpHX1dp4xFC3xs3FaFcoRSsn4Io14H2s8RwbRxzGCGQLUEUOGRcRh1E0m7OJu9xaAN+JQxw
 ==
X-Received: by 2002:a17:90b:1fc4:b0:381:23d5:693f with SMTP id
 98e67ed59e1d1-38dc777c375mr9978794a91.28.1783973252924; 
 Mon, 13 Jul 2026 13:07:32 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc4:b0:381:23d5:693f with SMTP id
 98e67ed59e1d1-38dc777c375mr9978763a91.28.1783973252505; 
 Mon, 13 Jul 2026 13:07:32 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313cb804197sm24106543eec.13.2026.07.13.13.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 13:07:31 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, pierrick.bouvier@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org
Subject: [PATCH 05/14] semihosting: add callback to set error
Date: Mon, 13 Jul 2026 13:07:13 -0700
Message-Id: <df1607f5ee373a1ecaa6f88bb56fc64101d818f8.1783973054.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1783973054.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX2/3uIolBvtb8
 oGEJH+B+Jd4LJ+nkj1sjTAGjvrMJd3ssG1uIsUBebdgfZ5fgQRjnkwN8bY4YC0/PwO7EWauGp0F
 IiIUe4GRRhDaICpRE8TosTLSEfBhAGg=
X-Authority-Analysis: v=2.4 cv=cNbQdFeN c=1 sm=1 tr=0 ts=6a554585 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=8ndNYmkutmpv_8xOvXsA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: lwwHOwW1tTcYbBuwdrwHuSv__IcFeBDU
X-Proofpoint-ORIG-GUID: lwwHOwW1tTcYbBuwdrwHuSv__IcFeBDU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIwOCBTYWx0ZWRfX6Z+l5S6tknpI
 3U9tkdmeXgD5W0NJNIg8guQPxCElBifUq3dT+XifoxISXEyn6chXTyOPKhS/t1dJ+9tjkJcJWPG
 MJz/NCMxhKIDDVFyhLKQlSN22gVT0T8Us+7E+aWmWqKQrDNxWUo2yCeDc3OYuzQVDs7ofXo3kfY
 BKuussXkxInqVjVGUhvdfyBhNxPnYnLkqBEDn76M5bb7DDpeFXtnZpI50lgjA7PJJIUSupIGIO5
 TOyt5gP1JDEVixtOeRyZ8Mx8FXG0Sl7JRwI0IgoHFQzzINnHcJg84036jBHn02g+i7XUMWIP3Sq
 lCfhwlghxV+K5n2sD7VU3sItuePVPLYkM8akeL07sIx3HYIehMWQRPAn54eJt94QhpMNSOM7I2C
 hfQAj1BVUv9WTTt8EAbXGtuKQJgyofwGDW+KMCRr3Uk+xPyAoQeWN1EQZW7LHqVlBQ3e3LBzrk6
 gJIZKoSQzbt2nZemF7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130208
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
used by hexagon.

Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
---
 include/semihosting/common-semi.h | 1 +
 semihosting/arm-compat-semi.c     | 1 +
 target/arm/common-semi-target.c   | 4 ++++
 target/riscv/common-semi-target.c | 4 ++++
 4 files changed, 10 insertions(+)

diff --git a/include/semihosting/common-semi.h b/include/semihosting/common-semi.h
index aa511a46f42..a11905ef4ef 100644
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
index 5e5f181b908..c54753f696f 100644
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
index 2b77ce9c17b..38d52deb3d6 100644
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
index aeaeb88d536..38a00e160c3 100644
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


