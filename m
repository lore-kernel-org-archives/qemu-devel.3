Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93263C98311
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:32:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9QpZ-0007QM-Rg; Wed, 23 Sep 2026 13:32:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qny-0006mw-Hp
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x9Qnw-0003jk-M1
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 13:30:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790184647;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/8iD7ZtOAW8EyUVp3GSUi7sOX1DaJh/ixaZwNIM96s=;
 b=ZenCfEVU3rl9Q1/la2WwzwEEOMMKWT6NkBr/wsyR0Y4n4nGoUF9pDUP/wodxb/gDgSj1Dq
 GpjwJ7+ZAIlrNrixZpbZAN72tgWN4lDK2//eIhAI2TDwzpGh2+vXkSnsCZbWfPqd/+IWYs
 yAt2TewbVMvrLzI0D3LAKbdNICsl9ko=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-283-YHo_9dH_Mmikcslcw2QkMw-1; Wed, 23 Sep 2026 13:30:46 -0400
X-MC-Unique: YHo_9dH_Mmikcslcw2QkMw-1
X-Mimecast-MFC-AGG-ID: YHo_9dH_Mmikcslcw2QkMw_1790184645
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49e735659b7so9155285e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Sep 2026 10:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790184645; x=1790789445; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4/8iD7ZtOAW8EyUVp3GSUi7sOX1DaJh/ixaZwNIM96s=;
 b=fg8m7vUZ7zI/QJy88aOuGz7nD0jRprTUl+NNhVaz8JVjE9SANQasM9F7EIc5HnvPQY
 RlPN/6svYCpmrPX3j0MIGkXAFpbOXyVH6uMPNeLuWSJvTt1uNYA2cHte/g+4lz/OU/ii
 3SklEgQ4lpz8O674xWw49roC75pO/+bvccQamhXROilGuVgWOJLejDMiWSTOxbhg0kSo
 ebQ2G2BVnWqfsj5pF+1JT72XGioRG1JFRnUeDei50DRZsQnvyjQC+w2ONnl+5ue1NTl2
 4QaHJIEclrvN7AjkjSg31Gcf6ew/A5JjOubg2plEO8ViqjWRRvXgYRuZ95M/KDLh1QEN
 WdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184645; x=1790789445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4/8iD7ZtOAW8EyUVp3GSUi7sOX1DaJh/ixaZwNIM96s=;
 b=0dShaDypWxRhGzS54IVAs3gKMwdRI8N+MaTLWbby+RFnYm7JOGuQFWxDJ2APQ+vcbS
 xLK5rxuI/u2974zFYEEgU1iLKN8/9kXdAvv6POUmW0ET+XvtCmBlp4uksMrnoJ3oSR05
 zYPbuQJJd1IwiI6ab58Hb5Ry+55SucFvJXBQIMhqKrHTmPMz1daY4rBuhoPm7aOJ9moE
 VGMF4m4+DZVwIeUgcQCiV1PQxczLvsPyM2YGIdhkqXxE+7rtc/sn0JcHmxID3400A9+c
 c3biO3KibbW6z+OCsatmV9wAcyoLMHb2KX3SQxGNHFl4q0gz45gxowHd0gJvMoZcebTg
 VJqg==
X-Gm-Message-State: AFuF++ma9o9iJjHmK7K+8IotZFT9hmNhyVlZE2bTce8X/X6NjqPT7Q/f
 8EqUa6znwnHc/0Mar9yrf8jnQ+JlgH2lmu1fJ4BxPjpPRtlLtalxZIem/0ZkP6AErXweo4SrTnl
 /7QNfiW9K3fXv6wPU4Jq7hT7JI6iU2E8n5vUsOJT0epXfbIoCkjrhu5krdyv0+3vVPk7eWT6CQW
 LYINLFmdd7RE/Jl9DUCnZN7LpOZ/ids8lfeDiM2zNB
X-Gm-Gg: AYBFou1Dv21LSfn0uJE/uyfaHkF4ZEpQvRU9GBiIo3S47juMyc673elkv5kf+zZONIY
 CVmOr/cpekXJf8WSFp5xl7vg+G+H+5kpQcMOfouYKWhHYO/FgaHNJ9v2lf3tMT3SPwkXVkiZ0Hq
 MLjVRCgyOFVRLNiH/ce4vfDy0lhEOOeu1H3yEtKNicVgTwsKUVZ6+4w9cc6ET9mfxjNFtSfhoVE
 y4loLNRCjNlvvR4Q3cJt8d+TqMNm4tfS/YSOrvlHy856d+Rcj8OFthYk0+hetusB+Zm6IeeA3wh
 JWPxdPCq+IltWpTdhIaqpLJtB1mOwSFR/FgQlWURqqJ9Nfe9zK6XqCRaScVzjDGplkWaEFURENO
 3wv7DVzjMnvbbn0LaACtET9CUlaNVzrBlJ36Q8nBjvNgbk3Nl+THVd8a7mrYBsXFdHVOsIgOnnU
 Cx6mPh
X-Received: by 2002:a05:600c:1d14:b0:49c:fc6e:a3dc with SMTP id
 5b1f17b1804b1-49fdf148cb6mr53264675e9.27.1790184645180; 
 Wed, 23 Sep 2026 10:30:45 -0700 (PDT)
X-Received: by 2002:a05:600c:1d14:b0:49c:fc6e:a3dc with SMTP id
 5b1f17b1804b1-49fdf148cb6mr53264145e9.27.1790184644722; 
 Wed, 23 Sep 2026 10:30:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5b44db6sm3113665e9.0.2026.09.23.10.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:30:44 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: chang.seok.bae@intel.com,
	zhao1.liu@intel.com
Subject: [PATCH 08/17] target/i386/tcg: treat 0x0F as a prefix
Date: Wed, 23 Sep 2026 19:30:12 +0200
Message-ID: <20260923173021.317809-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923173021.317809-1-pbonzini@redhat.com>
References: <20260923173021.317809-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Because 0x0F cannot come after REX2, pick the 0F opcode map
during prefix decoding instead of doing so via the root opcode map.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index c4f12ba6c13..bcb23c6fae1 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1848,7 +1848,6 @@ static const X86OpEntry opcodes_root[256] = {
     [0x0C] = X86_OP_ENTRY2(OR, 0,b, I,b, lock),   /* AL, Ib */
     [0x0D] = X86_OP_ENTRY2(OR, 0,v, I,z, lock),   /* rAX, Iz */
     [0x0E] = X86_OP_ENTRYr(PUSH, CS, w, chk(i64)),
-    [0x0F] = X86_OP_GROUP0(0F),
 
     [0x18] = X86_OP_ENTRY2(SBB, E,b, G,b, lock),
     [0x19] = X86_OP_ENTRY2(SBB, E,v, G,v, lock),
@@ -2824,6 +2823,9 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
 
     /* Collect prefixes.  */
     switch (b) {
+    case 0x0f:
+        decode_func = decode_0F;
+        break;
     case 0xf3:
         s->prefix |= PREFIX_REPZ;
         s->prefix &= ~PREFIX_REPNZ;
-- 
2.55.0


