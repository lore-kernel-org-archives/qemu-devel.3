Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46046D3B982
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 16:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT0Zp-00063H-6L; Tue, 09 Dec 2025 11:28:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT0Zn-00062x-Pj
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:28:35 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vT0Zl-0001qR-Kj
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 11:28:35 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42f8e39cf89so1350546f8f.3
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765297712; x=1765902512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hURcpmqkbCFcPmhAhGcW/zQRFUca8xQqQdvvJWhvPMQ=;
 b=ssr/qKtVOpx5vvm7feAF2wu2TOvSXdrjpYNmtpW212wU3IVUx+8zRWzVUk2L4wEUoz
 NmjbsGLMDSpL6x8RLpXb1Agvj4UfHGv9sLrd1kKNTOL23D10wEhzeCvs9JZzA3m1CHNG
 qNn2JrilFmwzBU9qUGmCJmaNamfUnYtYsmjLTFuM1Vje5FQv9kItUt1NjtPq7vymcbmG
 MUYHZHSEJ5ZMBYwIx33+OS4yEJFSo9RUUSEs853suGHenFZbgFkTkls5MQCZyXZlNd/L
 FHloKXWnKaKedMIfBCXMgch8TWhw4GnLtGcFAmbMeoYtftwYaz17uv84z+9GCRdkxm2O
 Qqjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765297712; x=1765902512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hURcpmqkbCFcPmhAhGcW/zQRFUca8xQqQdvvJWhvPMQ=;
 b=uJuRPPNFus+C6TRl8SuVWfAin1/B9e3vbQACD0OBWP3ZHhclb+iD8ThkNjog9yu1pc
 gHiCgazVicHwnlXUTOQGZpEBu1dmgN/G4CesZ1rq3cghfGmy791lf79WnsWQ3157gKEg
 TuGZgpDvcOw8t16T7AX8bG13kBGf7apQou09lCd25A8wZZRo4lZA0U6+eWBMD8KtUq/Q
 NQQyGBkmBKGp/pFq0KQYWDC4QHl0XGNedziNaX7wAYOaEWkBrQX+uynjDPFxLZYed8LM
 mlM+h1Qnz5tjyRNsHlDyPUO5lNM9ULsf2yPjOAzBuAO/yQMbEyouVOoU8U3SXbjWnjAG
 9JGA==
X-Gm-Message-State: AOJu0YzqmZT/Wc4YgbF21G9pWlfcGceNxIsMILi+t+vxlz8oH6dseQo4
 99oideBGMwEmwu2CTW6SP/ZaL4/yjlXdB8zJ9L71j6DdIH6ojiHmWCQbg40r/Ajr+GM=
X-Gm-Gg: AY/fxX44lMkwdCnqSA9vL4BbJ/TY5pGbDq8OFQ3z8ERLX+ErxZ3u/6SVUmCIqfbotnr
 eKiOxptEhNmlWFg9dro/TBLmStP8ehtt6xKpwEsQ1fZkE6Y9iS3yF+3/VaUPa9YBvGVQQZ1kpir
 MfmCrd+9b0kbLZB1oMxfbIvg8j8eRuIuczX/YELNUho4jrZvfaOOLqvuCnFe8H6tiUoEgYS1URq
 +6ilJlUdK1d2WGqfZHpwfvtyWqsoiCBWrgWDSYYTwY8o2/45BMBq+1kakjSsPyZP6h+lnv26zmv
 eThXCimeqTFHiQ/8GoUyfTdqkoSNhpVUfMSaj9Kz6ozl3a8GAgiPvByV//O6R+qMH2x9Lg+1ShG
 kCQTfHc7XsTzPXODfsLDp7vz1W8myYe+neAdMEByCajxwv1nXkfag3czK877+ol3FZs+JSwhVRF
 ZhtD+X5AK8bDQ=
X-Google-Smtp-Source: AGHT+IGXLzRo6EB0uKlHvdGme8NY67B7eM3JOzJR1mzWbyWrPcwOqRNyF+42tXKBPyyj+GUrttyKpg==
X-Received: by 2002:a05:6000:4301:b0:3eb:d906:e553 with SMTP id
 ffacd0b85a97d-42f89f6ffaamr11221450f8f.55.1765297711638; 
 Tue, 09 Dec 2025 08:28:31 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d331aeasm32218092f8f.37.2025.12.09.08.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 08:28:30 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id F1B2E5F87D;
 Tue, 09 Dec 2025 16:28:29 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Stussak <christian.stussak@imaginary.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Mads Ynddal <mads@ynddal.dk>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 2/4] target/arm: ensure PSCI register updates are flushed
Date: Tue,  9 Dec 2025 16:28:27 +0000
Message-ID: <20251209162829.1328559-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209162829.1328559-1-alex.bennee@linaro.org>
References: <20251209162829.1328559-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

When we handle a host call we report state back to the caller via
registers. Set vcpu_dirty to indicate QEMU is currently the reference
and hoist the flush_cpu_state() and make the call unconditional.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3228
Tested-by: Christian Stussak <christian.stussak@imaginary.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251209092459.1058313-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 70d34063df8..8e2940217a6 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1942,6 +1942,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
             }
+            cpu->vcpu_dirty = true;
         } else {
             trace_hvf_unknown_hvc(env->pc, env->xregs[0]);
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
@@ -1958,6 +1959,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
                 /* SMCCC 1.3 section 5.2 says every unknown SMCCC call returns -1 */
                 env->xregs[0] = -1;
             }
+            cpu->vcpu_dirty = true;
         } else {
             trace_hvf_unknown_smc(env->xregs[0]);
             hvf_raise_exception(cpu, EXCP_UDEF, syn_uncategorized(), 1);
@@ -1980,10 +1982,12 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
         error_report("0x%llx: unhandled exception ec=0x%x", env->pc, ec);
     }
 
+    /* flush any changed cpu state back to HVF */
+    flush_cpu_state(cpu);
+
     if (advance_pc) {
         uint64_t pc;
 
-        flush_cpu_state(cpu);
 
         r = hv_vcpu_get_reg(cpu->accel->fd, HV_REG_PC, &pc);
         assert_hvf_ok(r);
-- 
2.47.3


