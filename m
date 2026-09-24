Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50329C98321
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9klv-0008Ul-C5; Thu, 24 Sep 2026 10:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klY-0008KO-CE
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:43 -0400
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x9klU-0005EE-J0
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 10:49:39 -0400
Received: by mail-pz2-x0f.google.com with SMTP id
 d2e1a72fcca58-8631d0023daso1172416b3a.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790261374; x=1790866174; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xjovDEJSNYjANL2FYe2ilo3Bs/RcIdWuQfxv9h97UtE=;
 b=QpY9TWNeFrQwuLszW4A0TIjQ+tJlMRTHSNQ9V2PUSLitz3C5o4oxhd96cPz+5sHCou
 V5LR+XQQK8vAazk34Ka1XF1Mo4i1FK0LTnWnPHWnDjjQTjdtNaVEuaVBGty/gZiUaud2
 hCXeodm6sG4YYtSKaDKP2GQuNcXsBG3k/qz1F7tsDPvmLmbB0m56vRC7mi1AqdasWSKr
 Nr+TwxjKK12w26nuXHaeWapwzbNOtvzF9nNFWdxLlCoViXgeJwtvNPJO5jQCOd0/Kkoa
 Ca0A+UdzzbDlTDKMuYJeDLOPSlZH9kSwUXkEuux1NaXyYS4/JkrlE6ovTxRB34jfh5DP
 wbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261374; x=1790866174;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xjovDEJSNYjANL2FYe2ilo3Bs/RcIdWuQfxv9h97UtE=;
 b=cx0T4Bksa8Jg6OL23cVATkmvL81ZQLfZW52G6LHDYNBtAoptDZUUEUWdt+uuJFZXed
 fHr7hkor+JNNxhPaLd6aRAzw4t/uscGALM57e8EgHADvYkTLR6CBkTUbWILVuWTQEZnR
 XnE/qgWRY0OChxo6BxW0XweCKkR6FJxEv2zhcPxSVzaEv7UEJtEww4Ck34agpX3y80MP
 RuTRzeagdo8raJanXH0aUP14h0233pW3Cjyiplod1MHHyohwn2EaBLGvRCuK+0+D6IsJ
 +pJVSNKRA64IRIX5gqyNgkPOqvTW1NaI8Yf0WX50HHKIl3hBhcI+Ap1ICa2VWKajBfPL
 lRtQ==
X-Gm-Message-State: AFuF++nCk9CIZAvK1XX3IFvkZ0DeYDO2ByR9slcXWszzdFc6o1JBOMVm
 8lKYSeOY+/jYbZtECPGIkEtkmdiJbfKHCqub/4++svXCC6AW6rwlQCULdQ9bt7vXNWPB6zMi0Ur
 KP0Lt
X-Gm-Gg: AYBFou1nqpQVkQFRxfJN4adLKR+IKWv0S+LiabK6CuZKuBB5c6+DlfjcV2wU8+hYiqL
 KmfeLL72dhNkHoDabiE38vshqIsuNF5RC/7IkPt+S3ReeSnCgSI/yh9/WZr3CBk7o9aC/TeT5Yp
 NqyWcU6ECNy7hm4Wj235MA2U86PGkXKa82vH2dHXY97UKlsk4Rpr2cmHJhhJoNRhGqCpxPmXyZm
 kY7WMKJuh6GzzoMVQNAc5DfdpMGxv+8QIjs7MXP5Ci2qsn4RXU6lDpx7pS+lIiQJMydscDHnLMh
 lW3Sn9+P5cE1ArD0pIKedYdhBSaSroabnvmPJNMYNXMUV7sp/ohIut0tilnDShlaMHPCxNCKVgj
 crQHG2RKwQEAOROY5/gRsPsQNjLh9z9Y+z6eenfkUE8FXalYzpn3aFok0m5r1vJqZxok1tZK0kN
 adyc4QRelCfy8ryAhNTuQ3vf76fnFrPpLSvkAgJjUHnT1Lf1+e5mZahC8IpOLN6X6lrrzkHPu2h
 N1JwLUMH8wNZ9sWoVG4wO3i+yS6U4EgDTLUkCnQ
X-Received: by 2002:a05:6a00:4650:b0:87c:e44e:5694 with SMTP id
 d2e1a72fcca58-87e98f91b9amr2173927b3a.21.1790261373983; 
 Thu, 24 Sep 2026 07:49:33 -0700 (PDT)
Received: from stoup (174-21-68-150.tukw.qwest.net. [174.21.68.150])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87d1dad3978sm3209818b3a.34.2026.09.24.07.49.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:49:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL 1/8] target/i386/tcg: Always initialize CCPrepare.reg
Date: Thu, 24 Sep 2026 07:49:24 -0700
Message-ID: <20260924144931.161335-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924144931.161335-1-richard.henderson@linaro.org>
References: <20260924144931.161335-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:3b::f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pz2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

Forthcoming tcg improvements will diagnose the passed
null pointer with --enable-ubsan:

../src/target/i386/tcg/translate.c:1177:5: runtime error: null pointer passed as argument 3, which is declared to never be null
    #0 ... in gen_setcc ../src/target/i386/tcg/translate.c:1177
    #1 ... in gen_compute_eflags_c ../src/target/i386/tcg/translate.c:1182
    #2 ... in prepare_update_cc_incdec ../src/target/i386/tcg/emit.c.inc:407
    #3 ... in gen_INC ../src/target/i386/tcg/emit.c.inc:2213
    #4 ... in disas_insn ../src/target/i386/tcg/decode-new.c.inc:3151
    #5 ... in i386_tr_translate_insn ../src/target/i386/tcg/translate.c:3514

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/i386/tcg/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index d8de290acb6..192cf43215e 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -891,7 +891,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
 
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_NEVER };
+        return (CCPrepare) { .cond = TCG_COND_NEVER, .reg = cpu_cc_dst };
 
     case CC_OP_INCB ... CC_OP_INCQ:
     case CC_OP_DECB ... CC_OP_DECQ:
@@ -965,7 +965,7 @@ static CCPrepare gen_prepare_eflags_s(DisasContext *s, TCGv reg)
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = cpu_cc_src,
                              .imm = CC_S };
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_NEVER };
+        return (CCPrepare) { .cond = TCG_COND_NEVER, .reg = cpu_cc_dst };
     default:
         return gen_prepare_sign_nz(cpu_cc_dst, cc_op_size(s->cc_op));
     }
@@ -982,7 +982,7 @@ static CCPrepare gen_prepare_eflags_o(DisasContext *s, TCGv reg)
     case CC_OP_SBB_SELF:
     case CC_OP_LOGICB ... CC_OP_LOGICQ:
     case CC_OP_POPCNT:
-        return (CCPrepare) { .cond = TCG_COND_NEVER };
+        return (CCPrepare) { .cond = TCG_COND_NEVER, .reg = cpu_cc_dst };
     case CC_OP_MULB ... CC_OP_MULQ:
         return (CCPrepare) { .cond = TCG_COND_NE, .reg = cpu_cc_src };
     default:
-- 
2.53.0


