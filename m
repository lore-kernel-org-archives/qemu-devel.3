Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0D5E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:24:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSA-0000L4-D2; Wed, 11 Dec 2024 11:20:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS8-0000KV-Cw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:44 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPS6-0007k7-Tq
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:44 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43621d27adeso2074495e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934041; x=1734538841; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=klkjETkK46JGPy4cr1z4ranKH2QbJ9BDEJxJzYH0IXk=;
 b=q4qWPh94sCdPCFM4DBiNt1lhYJqFAAn4xD9CfEBrEpR5nKv0RtF8l4XgQKMiMZG/Nv
 ndpM1FkMZmZ3Dx3jBbe6/zZExI7dC7Hponu7bg3LI0jA3CPoAbPXP+3n/R416ftMrvbm
 /1u73rjqt54z0VW9VwbSkNdJHKJ/TM7omsStlCrr0EngZE6BFrWqNAay9SkkEwRuRTw8
 fh8eH+ucq0TpnELrGjdkwX/IlW3jpIHQp9C1YnL2FKllrPZWZrrKolSsJ2wx7avd8WI7
 YwbbqTQVf6kyfY57SzdM+TpT61sZI6Kq9tup5mfiOeQrAM/YE2MxHZSdnb2Hm/mq9JVG
 kYOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934041; x=1734538841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=klkjETkK46JGPy4cr1z4ranKH2QbJ9BDEJxJzYH0IXk=;
 b=TylJQ10qcWixTlbrEtjJ00FnTG/KPvrXnRQu4+XJy24bMQibnQgeJZ0cuDQbknCj5B
 meh4X6Wq0A9ELps5focMRhMcyiwKziFoWmwWtxgfM1b4a/oAEBxyFn3aZbSM9tx1GGtv
 j3JVY3VtQs5tKaiRZoKk/uNs2k/u3unJVFJb5hyJiGR/fPHfmfHvfejfsYH7mbc768SA
 DR7SvruLMEDxJjvcTXSCWnBb/nEbySWo5MQK5TLu/Zo+aYWFhZnjb1u0zUtRZ96LAG/h
 MMYyVKbwm/eobqG9grPYnSo6ATzGxUPhKGb7nM4XB3h82vlQli+3MZiJHia97HjCbXX4
 Ibgg==
X-Gm-Message-State: AOJu0YzDp2jSjgxh8D+iWTuioDDEA1kaIe69ZkjNuYEws/F8TPnXtyZt
 /qKh2I6Sd3tmCxbJzWZnS9AxnNBm4kwwL/2qxSbsG7TlpiEed329sF64yfioq+3UGF1gRfIN1m+
 B
X-Gm-Gg: ASbGnctTpj6jHaUXdrhp9K9xUXwtHdr6JxgR1Pjo3u+u1Js6C0DL51EdpXBmejNXg7k
 2gLbMjOIY9bPpmwynDjheP6TDOmmlQLJlxw4RtjayYcHb+/7IvfhZ5hq6FGuQDxmT3hCGcLIDw9
 aRMSnUQOngnoLj0M/l7b+8oU2cKN6BJ1SuY7Zl15n/05m0nl96PcPb8Y+fAGew+A9Vz8F/pGae8
 FcxtQTaQqNgc+vlI+UK9YSb2SDo4bVeW0/MTfPiRJ7qY4tzif/PfDTd3GEs
X-Google-Smtp-Source: AGHT+IFQE0RJDaztCcgLF64vEcbBGI9BO8Eo66BkUXxZ/4ZzeMrWkZw/u0ESYgGWRor+BQV1DgXttw==
X-Received: by 2002:a05:600c:3109:b0:434:f335:855 with SMTP id
 5b1f17b1804b1-4361c441e47mr21076895e9.28.1733934041313; 
 Wed, 11 Dec 2024 08:20:41 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:40 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/72] target/i386: Set Float3NaNPropRule explicitly
Date: Wed, 11 Dec 2024 16:19:21 +0000
Message-Id: <20241211162004.2795499-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Set the Float3NaNPropRule explicitly for i386.  We had no
i386-specific behaviour in the old ifdef ladder, so we were using the
default "prefer a then b then c" fallback; this is actually the
correct per-the-spec handling for i386.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-25-peter.maydell@linaro.org
---
 target/i386/tcg/fpu_helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/tcg/fpu_helper.c b/target/i386/tcg/fpu_helper.c
index 3295753e075..4303b3356aa 100644
--- a/target/i386/tcg/fpu_helper.c
+++ b/target/i386/tcg/fpu_helper.c
@@ -180,6 +180,7 @@ void cpu_init_fp_statuses(CPUX86State *env)
      * there are multiple input NaNs they are selected in the order a, b, c.
      */
     set_float_infzeronan_rule(float_infzeronan_dnan_never, &env->sse_status);
+    set_float_3nan_prop_rule(float_3nan_prop_abc, &env->sse_status);
 }
 
 static inline uint8_t save_exception_flags(CPUX86State *env)
-- 
2.34.1


