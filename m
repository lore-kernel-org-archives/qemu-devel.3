Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EE1C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:11:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weAgP-0007Y7-NM; Mon, 29 Jun 2026 08:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg4-00074X-Aw
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:30 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1weAg2-0007cl-LA
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 08:01:28 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6983f8b0aebso2124070a12.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 05:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782734485; x=1783339285; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lbKUc78SBjPBQDAAy6fbdVLC9pJyuS2mliwq5Equ+IM=;
 b=mIV+qtf6xwfnNn0TiGrcVyAo6DzhJWfHs8lmwH3uVsOzmbUwf5zMei9Bv8SzX4oSVX
 BECHjOg8zBlp9oicZ0YqFnQVfR7nFBZYmVo1grtAyBNo1naiGVsFfe7ATcgTgzV44Dyu
 sYlwwETFFYTgnvGiIck4du+t5BT9ZGPcDOrp6nAmOcm5MD4vlrZv4Y+VZWY6ypenDPOJ
 WndZNpzQbouXtN+RnIRHXTPadEZ5O8TUNWhD+huo+qphZXv3qy48w5GeLZLQ8pnbw/tm
 NYJxTshjDUmWBVo38bvMxhfs1HYSwR33yzbPHfuOlGUTuab3cXEVMXhjEBrs36sROkZG
 Av0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782734485; x=1783339285;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lbKUc78SBjPBQDAAy6fbdVLC9pJyuS2mliwq5Equ+IM=;
 b=tRAk6+tFKUj3R3r+hvb2qNiP7j/qKYlZZtU8OQTqRBqjFhrGojkVXp/KFrZOCLArA1
 yRjpIQsVF7yJFszctxpT/7lGjGrevu/4gle307bEDIKbEJbWUSqZQMoscPkqiN/qETSx
 5uDNTJbrjwjOD4a5I+fpGDsmx50z3uty7xBq2Mq9WOq7mALfIfZSDaTaEQzWLlXMWjO+
 YXDAmYt8E+rhQ2vL9nuKkRJKjL/cGpskbZE5ldcNN4UHVm/eAYt3mHCbarCKhexTNnVy
 ytwdt+uxjND3bGTKReYz0qkAMfU3aAnGWzREp1QxOAwpx3kvxci+RSZSDNreYzs45LZt
 7lVQ==
X-Gm-Message-State: AOJu0YwF6or53QmXEcRj2uQeb2TPJZsD9D9LqmXmXOjwFNmuHcZn73rv
 gRnvVfeLZEUUVnYff0xABvOGb/lv5CNotSv7jf7zRmC/sOXDGOe8UGpmIj7oaUgSovqdLBVpvBv
 nZg1H
X-Gm-Gg: AfdE7clyWXHxxo3KE+t9OXFjbkn5xn9MN/iwDAnilTBj3aBSFXNCxunnKETZYrbBRJl
 uHH9asAe7XiGsG38KqjXnM2aVvJabCUbbSLQPZ8+2P75i5w7qh3xyAsnCHbHetfpdlQclG0WacJ
 FJMQoKx79ZN4+raszKM4d4gQGeTBZsqiQVuXXRAVRehBh4BQvIFtfTw7m1F1w1wBxvxNnqX0xAu
 yUwVYj5xlZsuMzQqnRJUTcBi9GIeF4RDxVQ2HhQN9OoQUiJP06IYQU2sofbh7ygZGlRmEg2840m
 ViDzit2E38vCxk0r9e7mO6YlqIUsNOl5eogORJunhJVve/0yhOeWMQdhXEgJqejC2LRLEV31zRA
 Mza4XYSalTm1d5zVbFC8nO6/XDnEu6RFaaX/u16YE+IwTnLwgEREknqlS9AlJ01b1ABxp6YgzMB
 8Qvbf2ng7o33pU2fjX4C2YK74T7CWCfXNNoEgV83mEN6DIHrXzByUhGL7v4nBvW+QoWEFVFClSO
 lZMmdjV9/GVcq2so7UtXg==
X-Received: by 2002:a05:6402:6d0:b0:698:3b7b:e487 with SMTP id
 4fb4d7f45d1cf-6983b7becf8mr3006518a12.19.1782734485039; 
 Mon, 29 Jun 2026 05:01:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-473dddcb295sm8753061f8f.35.2026.06.29.05.01.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 05:01:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 49/54] target/arm: Implement FDOT (multiple and indexed,
 FP8 to FP16)
Date: Mon, 29 Jun 2026 13:00:27 +0100
Message-ID: <20260629120032.1645265-50-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629120032.1645265-1-peter.maydell@linaro.org>
References: <20260629120032.1645265-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
[PMM: fixed subject line]
Message-id: 20260625015159.719300-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sme.decode      | 3 +++
 target/arm/tcg/translate-sme.c | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/target/arm/tcg/sme.decode b/target/arm/tcg/sme.decode
index fbf5f3720d..1dd3b7c8b2 100644
--- a/target/arm/tcg/sme.decode
+++ b/target/arm/tcg/sme.decode
@@ -810,6 +810,9 @@ FMLAL_nx_hb     11000001 1100 .... . .. 0.. ..... 0. ...    @azx_1x1_i4_o3x2
 FMLAL_nx_hb     11000001 1001 .... 0 .. 1.. ....1 1.. ..    @azx_2x2_i4_o3x2
 FMLAL_nx_hb     11000001 1001 .... 1 .. 1.. ...01 0.. ..    @azx_4x4_i4_o3x2
 
+FDOT_nx_hb      11000001 1101 .... 0 .. 0.. ....1 0. ...    @azx_2x1_i3_o3
+FDOT_nx_hb      11000001 0001 .... 1 .. 1.. ...10 0. ...    @azx_4x1_i3_o3
+
 %idx2_10_3      10:1 3:1
 @azx_4x2_i2_o3  ........ .... zm:4 . .. ... .... ... off:3 \
                 &azx_n n=4 rv=%mova_rv zn=%zn_ax2 idx=%idx2_10_3
diff --git a/target/arm/tcg/translate-sme.c b/target/arm/tcg/translate-sme.c
index 3174b10c30..197274d00e 100644
--- a/target/arm/tcg/translate-sme.c
+++ b/target/arm/tcg/translate-sme.c
@@ -1178,6 +1178,10 @@ TRANS_FEAT(FDOT_nx_b, aa64_sme_f8f32, do_azz_acc_fp8,
            a->n, 1, a->rv, a->off, a->zn, a->zm,
            a->idx, 0, false, gen_helper_gvec_fdot_idx_sb)
 
+TRANS_FEAT(FDOT_nx_hb, aa64_sme_f8f16, do_azz_acc_fp8,
+           a->n, 1, a->rv, a->off, a->zn, a->zm,
+           a->idx, 0, false, gen_helper_gvec_fdot_idx_hb)
+
 static bool do_fdot(DisasContext *s, arg_azz_n *a, bool multi)
 {
     return do_azz_acc_fp(s, a->n, 1, a->rv, a->off, a->zn, a->zm, 1, 0,
-- 
2.43.0


