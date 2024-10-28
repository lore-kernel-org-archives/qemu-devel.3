Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF647D33996
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 15:19:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5RWS-00087H-LT; Mon, 28 Oct 2024 11:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWP-00086h-K7
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5RWM-0000jV-Lr
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 11:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730128745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o5sg1ofJZAEmJb7UHkIAx7/U5KIn00yWoaP0I20s9hQ=;
 b=XGYGhn2scKbx/MfGFJ8JFiw6g/2700OE2WEN68uCBfEX7jVUai5mZ3xEpTK9ih1/zJM6CK
 1kGKcCmLMpPx7bS5CdjLcr0LOBQyllkUZkQYx2fWs9tpaUzs2H4MHTNWS9XGoNDLZ0PM+T
 xfBolIzvbRXpYtZ83iERQG8N8hWClqQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-AJRjnk7ON3-5ifFwPHAXqQ-1; Mon, 28 Oct 2024 11:19:03 -0400
X-MC-Unique: AJRjnk7ON3-5ifFwPHAXqQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-37d662dd3c8so2358224f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 08:19:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730128742; x=1730733542;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o5sg1ofJZAEmJb7UHkIAx7/U5KIn00yWoaP0I20s9hQ=;
 b=pRkI9cmLDnZ8XFGf8EjTwHXSn1bTzQFCe5LqcAi3StOIVz45ndBvswmKVfKjQ7P9Vc
 gERV4BDERuV+90yaw6qCsYxBvg5F0HsFU8Rni9SwvhZT4eb1r3bPGTdfpCy2A57xaTO2
 wHrdLEALZlDvFPyThRAS3rlx5YbwEwusDTQrYwmKnHOg7xAQWMUp242ll8UnjlWhhfMw
 zfDGfTl1T8L0IKTL039qXV3nMtzujPQR3zsth/FmVuwn47UdLKVmH9hJBCgo+4YlvskL
 kWSPw22jFwc5csSuieUx+fopP+drX/P2FKYFYVvcxV4XRAXVvd2J1Y1xFSg+qJkJmTFV
 e6Vg==
X-Gm-Message-State: AOJu0YyJJRnUNffbUeL/xM4/ySRjemmns8W6ujMTwSm4682FRuaOTcoa
 VPyg3QXtZBMBmHlqghUU0E/A4kSrvKweSFTaQhnLrH9GDUwQ6h8MV2QS7oTsNbKURlRusVaGPe+
 N/tgRhAnClO0xcrA7ba6zwAeiKaznv5Kvu7FkOcTBi59s0+GdjVGSbrCTZKKn9mA0xlaPtT5zS3
 OO669Vef76tm4QsVU65zeCA1bPSjACHrASFl5qtrw=
X-Received: by 2002:a05:6000:1a48:b0:37d:3e5b:feac with SMTP id
 ffacd0b85a97d-38061213262mr6609668f8f.59.1730128741878; 
 Mon, 28 Oct 2024 08:19:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF32n/Q6nOsPYGSMYib7uRTokRjrMOygZkCo4T68MpHJhsbp8sj+DkGdRAHHDpdqSgn3KKp3Q==
X-Received: by 2002:a05:6000:1a48:b0:37d:3e5b:feac with SMTP id
 ffacd0b85a97d-38061213262mr6609645f8f.59.1730128741375; 
 Mon, 28 Oct 2024 08:19:01 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b91f50sm9744049f8f.94.2024.10.28.08.18.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 08:18:59 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 01/14] target/i386: use tcg_gen_ext_tl when applicable
Date: Mon, 28 Oct 2024 16:18:38 +0100
Message-ID: <20241028151851.376355-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028151851.376355-1-pbonzini@redhat.com>
References: <20241028151851.376355-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Prefer it to gen_ext_tl in the common case where the destination is known.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/translate.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ef190416b49..dc308f31041 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -883,16 +883,16 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
     case CC_OP_SUBB ... CC_OP_SUBQ:
         /* (DATA_TYPE)CC_SRCT < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_SUBB;
-        gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = s->cc_srcT,
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
     case CC_OP_ADDB ... CC_OP_ADDQ:
         /* (DATA_TYPE)CC_DST < (DATA_TYPE)CC_SRC */
         size = s->cc_op - CC_OP_ADDB;
-        gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size, false);
-        gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+        tcg_gen_ext_tl(cpu_cc_dst, cpu_cc_dst, size);
+        tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
         return (CCPrepare) { .cond = TCG_COND_LTU, .reg = cpu_cc_dst,
                              .reg2 = cpu_cc_src, .use_reg2 = true };
 
@@ -1041,8 +1041,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         size = s->cc_op - CC_OP_SUBB;
         switch (jcc_op) {
         case JCC_BE:
-            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, false);
-            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, false);
+            tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size);
+            tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size);
             cc = (CCPrepare) { .cond = TCG_COND_LEU, .reg = s->cc_srcT,
                                .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
@@ -1052,8 +1052,8 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         case JCC_LE:
             cond = TCG_COND_LE;
         fast_jcc_l:
-            gen_ext_tl(s->cc_srcT, s->cc_srcT, size, true);
-            gen_ext_tl(cpu_cc_src, cpu_cc_src, size, true);
+            tcg_gen_ext_tl(s->cc_srcT, s->cc_srcT, size | MO_SIGN);
+            tcg_gen_ext_tl(cpu_cc_src, cpu_cc_src, size | MO_SIGN);
             cc = (CCPrepare) { .cond = cond, .reg = s->cc_srcT,
                                .reg2 = cpu_cc_src, .use_reg2 = true };
             break;
-- 
2.47.0


