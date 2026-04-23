Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71A35F99367
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFqtd-0006Pv-Cm; Thu, 23 Apr 2026 06:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqtc-0006PL-1M
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:56 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wFqta-00024S-DC
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:02:55 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so4469540f8f.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776938573; x=1777543373; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EflB/oHnlLOLha8xDj4O1hwidCsSLWOS91ihDs9A7d8=;
 b=fhTyBFO/G5inGegSrRj4O4EB5n8fO/Lv4oAzs2GEzgqkT2WjYbAYtfQflgh1wEEEKC
 3M2qV/s1FkDgR1Gr9giIbdIvgFBSQi5LOD0rrrxUUTXK1f3y/xDuasL4nvHHIWWk+hHN
 05V7k2yh76A4KtWaNNY1K7yKnQrRm9khnY1Ia3LA7wAxV8K9UTgVsSR2I3+5EER6u33h
 LVv0vWR76O0eXWRUEC7qbzQjYRKjCU8jjJrQWUhel5ZxMZalP85X/H+uzUpkEIB5zRyt
 Jlg8zxwM1n6dA+OP1PrCwGO7+enQmYJUJmvoohAEFVVXHEqM4NCMtmleCIcq/g1Pt2dQ
 uC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776938573; x=1777543373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EflB/oHnlLOLha8xDj4O1hwidCsSLWOS91ihDs9A7d8=;
 b=DLUkTTG2ybT+6A8RwM6+uPec3M4w/l6o/nEYQEunI3m/D6PS2PZhNS/6ixnKqpMihf
 tCJ1Ic1YuZ4N2S4LPfmeYnaaYCoaiCveKDveFfP6asaQdraBhC+9+LeqVOMkuH5T7OC2
 o8iFeE1SQGryrAxVBS+KdBNyYUU1hkFun6MQNw0MYDBQMtogakiTzvPUQ2lrpDVHPhLZ
 /itY4nH/05Gq90ebmVb6f1moW9Hqyc8Q5Yf/na050hv7v1wD9bDe2eiwAMdw73jrZvts
 ywvj5EEw7ywz2DZ+XhwGMtqeifjWiq035TNp28dIRdjvRAcV62g6+XJTdL2LNOchp4lb
 ZeHA==
X-Gm-Message-State: AOJu0YzoVBi7nqgrgpWEfYdNbmqKarACc825gqUFOWtHNbBKskHP6w8A
 s+FXhtMVHt7gYlpjX16CNFbIMb22Zo+2HcILO0OvDeuHRAi0R9juoXVQlJjPfGRzQJ6WMVqhf9p
 L/BtB
X-Gm-Gg: AeBDieu3jsVanptte6tYDeSJnOuxTyQaW4jqS4b7GQg+LcjgDa3HRpyA2RzqThHwI7V
 7j9mY4eQMoM2f0aNrc9TFVXQB3UwfaHbSb43LyQZigjFgTj4m/9yAoVziyz5mqm55IH1HharyTl
 ve6zgQgG1yDVEgzV5X2xATMzG/eOKJfsSvmNjZWVXqtoERg2LcSWUWP0Y9wfwS3ghzaZnh/gCy8
 IT7rsbkMeFKCeBXoCsaCQ8d/c+4Tacjl4NsyPvll6MHsh9ZiA7B8Rzb6NN89iKqmmVvjGT00gbX
 wYr7vXD1AuBvIeCY4bFDMqJJtY1ak8rMszcxVFtaonMJOZka8iQE+YSD5Sm1W/WR9cFkfv3N0oL
 E0777keYgCIBFSX7c5L+tAPKXCZuqzUVFo/OgsmpN6CA+WUoCcpfbKT2MaaHOxMmdLBBlUJj/Oi
 lUqnjM81/f+A7+NdPxMFnJ1ohIj+7BWKYU9a7rWJlhqIuzYRavY8c7p8vcAzHD8jakUjbtcD/NE
 XmYNptMMdXUu/n/D97f3k0COIKbctXYmLkRSUPr1w==
X-Received: by 2002:a05:6000:186c:b0:43b:4136:1e6f with SMTP id
 ffacd0b85a97d-43fe3e0af4amr41777990f8f.38.1776938572729; 
 Thu, 23 Apr 2026 03:02:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4eec9sm49323930f8f.34.2026.04.23.03.02.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:02:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/59] target/arm/tcg/translate.c: remove MO_TE usage
Date: Thu, 23 Apr 2026 11:01:50 +0100
Message-ID: <20260423100229.2941820-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423100229.2941820-1-peter.maydell@linaro.org>
References: <20260423100229.2941820-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x433.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

dc->be_data is already set just above in the same function:
```
    dc->be_data = EX_TBFLAG_ANY(tb_flags, BE_DATA) ? MO_BE : MO_LE;
```

Cc: qemu-stable@nongnu.org
Fixes: a729a46b05a ("target/arm: Add wrapper macros for accessing tbflags")
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20260407222208.271838-12-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/translate.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/tcg/translate.c b/target/arm/tcg/translate.c
index 56ef1e0eb5..4546bbeeef 100644
--- a/target/arm/tcg/translate.c
+++ b/target/arm/tcg/translate.c
@@ -6344,7 +6344,6 @@ static void arm_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
 
     if (arm_feature(env, ARM_FEATURE_M)) {
         dc->vfp_enabled = 1;
-        dc->be_data = MO_TE;
         dc->v7m_handler_mode = EX_TBFLAG_M32(tb_flags, HANDLER);
         dc->v8m_secure = EX_TBFLAG_M32(tb_flags, SECURE);
         dc->v8m_stackcheck = EX_TBFLAG_M32(tb_flags, STACKCHECK);
-- 
2.43.0


