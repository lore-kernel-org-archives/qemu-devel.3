Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2370BD116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 16:10:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ6Tk-0003Oe-S7; Mon, 01 Dec 2025 11:10:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQ6TI-0003CI-At
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 11:09:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vQ6TF-00084e-Pw
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 11:09:51 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-429ce7e79f8so2839653f8f.0
 for <qemu-devel@nongnu.org>; Mon, 01 Dec 2025 08:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764605386; x=1765210186; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=/LOGL1isCmnOMpv3xXu016IY7Q0CQM8bBCYX/KB4fXM=;
 b=jffLIJR3elvDqPJrHH5HjyOCD2R159KoR/4ABdyJWXTisMdU37NxXdonyLReH5a70Y
 dUPzQvm2QRYZkamvbbTM485eKoRn7erSDEQGTHGcCTj1OuRhXCrXQ9d3vTchDPtgQ1v3
 3kDDpsjgzx9TlGVc92GZ6bHlvOoZuuWrKWtTxYVPy+1+QurQzMzoyqoFskELEosWsioR
 C//OskvtT6lraWAmw8iJ/8rbNxQQ8v30VbxkE6VEpC1SAbouMH/gZhY6qdUER5NYiHAR
 Lrwy0UzOy6U04FAkbageMuQhDcO0EzdKPH3R83IoEpNavrkw8JbccLkjlVVBNWjtwXpD
 TT2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764605386; x=1765210186;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/LOGL1isCmnOMpv3xXu016IY7Q0CQM8bBCYX/KB4fXM=;
 b=hHg00pspOwmlXbEfUqcPatmU4Lny7+sdAmoU9VYh8OD6uxGhDgDRYNSJFfBPhf7EQA
 YMf6BU3t9lpa760MRSIBgU3RIhrot5OKAN3AUkoR9crYienPNs4sX0WLqyN3npA0jmDD
 DzToJ2ZLf/ojCgx1raSFZhB50ROeEcKQAMXT/xObentWv3BRJDG1+JZwdHt8d7fRxJRp
 TM1GDpzCdSIVVNMXHSfU/3aMo0njdjG5anba+MFQ+HtnKN/6AS/iGAhH58Mhh28m+5JH
 dIf0jQlQSmq0t6p5kf81wZ6DZk3J1F4X1xtSg8DFS2yom8cKruPGMziaQUbR7YEov4NF
 lnSQ==
X-Gm-Message-State: AOJu0YxNtJhJ1sx86qC3YIg4OaXzSmLuApdvYyKG6pIiyHY7F/PL4MFi
 ibpxCPh/I1B+a5uJy7eAtMyG2mtGk14JlW3lgNJHqBEE7gzJecRoxmILI6yooEz3JBTWH9w1JAH
 Xkw3W
X-Gm-Gg: ASbGncsqAY7WJHj+jMBpZLcTjcMzd1ka7wQIVJ1R18102EO9aQfYHCM4M0EhxmnzTNz
 JziIGVdRp3nsSBJD2814IcIeSCTRvgf0tYgIKCo814ctica1G25uZ5jnDnhvlt/fTtMtelxgx0j
 BJwuup4tdsS3kIZd6278tZdu0+e/uSEOAqWihrSR216VLd3xzWwI46flHjkTYaCuFGwx93SMF8V
 zEPCi0hVSlYlfokj1MripfPunw9/C0OMK/uCvW7FANkMBYDtjr7phAQgsKEZVH+AuyT+guD+taA
 DZHaMk+HmKzh1M4G335MeShfwN8je9kX4TAaKv4TddCuc0SAzQ/2kOUUtfi1xT7SB0/AkliUJ5N
 LgJmvxUO668fFMdXctQomHjDYwkPfFKBjOlj4cY/jNt5XSJVxLFJY4gd+HlLtYdzx22QAN5p074
 59Ypfg2JDlmrySKpvP
X-Google-Smtp-Source: AGHT+IEsgbsdCpivhsstHp+cPw7KBJnmJnn41GfPmKXripxdnZ2Ga9G/aO7PfGqcPwtYtQBB/didFw==
X-Received: by 2002:a05:6000:1886:b0:42b:3867:b3a7 with SMTP id
 ffacd0b85a97d-42e0f1d59d1mr24993234f8f.8.1764605386451; 
 Mon, 01 Dec 2025 08:09:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5d618csm26682796f8f.14.2025.12.01.08.09.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 08:09:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 1/2] target/arm: Fix assert on BRA.
Date: Mon,  1 Dec 2025 16:09:42 +0000
Message-ID: <20251201160943.1342099-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251201160943.1342099-1-peter.maydell@linaro.org>
References: <20251201160943.1342099-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Harald van Dijk <hdijk@accesssoftek.com>

trans_BRA does

    gen_a64_set_pc(s, dst);
    set_btype_for_br(s, a->rn);

gen_a64_set_pc does

    s->pc_save = -1;

set_btype_for_br (if aa64_bti is enabled and the register is not x16 or
x17) does

    gen_pc_plus_diff(s, pc, 0);

gen_pc_plus_diff does

    assert(s->pc_save != -1);

Hence, this assert is getting hit. We need to call set_btype_for_br
before gen_a64_set_pc, and there is nothing in set_btype_for_br that
depends on gen_a64_set_pc having already been called, so this commit
simply swaps the calls.

(The commit message for 64678fc45d8f6 says that set_brtype_for_br()
must be "moved after" get_a64_set_pc(), but this is a mistake in
the commit message -- the actual changes in that commit move
set_brtype_for_br() *before* get_a64_set_pc() and this is necessary
to avoid the assert.)

Cc: qemu-stable@nongnu.org
Fixes: 64678fc45d8f6 ("target/arm: Fix BTI versus CF_PCREL")
Signed-off-by: Harald van Dijk <hdijk@accesssoftek.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: d2265ebb-84bc-41b7-a2d7-05dc9a5a2055@accesssoftek.com
[PMM: added note about 64678fc45d8f6 to commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index 08b21d7dbfa..cde22a5cca7 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1916,8 +1916,8 @@ static bool trans_BRA(DisasContext *s, arg_bra *a)
         return false;
     }
     dst = auth_branch_target(s, cpu_reg(s,a->rn), cpu_reg_sp(s, a->rm), !a->m);
-    gen_a64_set_pc(s, dst);
     set_btype_for_br(s, a->rn);
+    gen_a64_set_pc(s, dst);
     s->base.is_jmp = DISAS_JUMP;
     return true;
 }
-- 
2.43.0


