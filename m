Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0225EC5516F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:21:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wppzI-0005Cm-VJ; Fri, 31 Jul 2026 12:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wppyg-0004wk-Sk
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:21:02 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wppyd-0000U9-7Q
 for qemu-devel@nongnu.org; Fri, 31 Jul 2026 12:20:53 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4aa99bdso616670a12.1
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2026 09:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785514848; x=1786119648; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FzYn4ydpkQH/vA7lgT61nvjD89r5G2v3Ua1oapSYA24=;
 b=G+KfNdJmjH0nqw3uK7WO+PSqvu8EgW2cx+dA2q4e/C/s+cwi7sQjHS0a9nmp/riynC
 om18VA5fyWbjeMdJ2wmqYxUjxJMPNrpgCuQ/q/WqNs0elbKrEMzxvApUUitMUpHheunu
 EOPYUOZWhYesmOaYWHcXN0BCvLusbqi/+/PovT1WCF8ddTuo89O/TN40byBipPG00zhj
 92WtU98Ze22wp7J2nMIYDpDmY8Nl7bXGhp++Yh8lQwTLvVWPFNjkhKPPUUFRzUA/kS0K
 QLxXHU5BM+2Z5nGctxWZSoT9kH/3LOGyjtQ4hA0PxoT4N1ppkQg8t1P5493imWI+v45V
 j/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785514848; x=1786119648;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FzYn4ydpkQH/vA7lgT61nvjD89r5G2v3Ua1oapSYA24=;
 b=TWuUtx3ONvX1YAHf9O+Tzx/HP5mAQSImkxABYwfgZRRcOgiN+S4jwTtiXdSHzoVVuE
 XEzJ8yfNOF2EibR8BDgC9CJN06nlIRXF1WPA+a0WfzxHWm5goOaSstD6LXwTbQkjx4xw
 g9cR5DAYufLWbLE94YWwLb18egpZBKkGZuseJmyHARBuP1PmRi7jwG3jusOjDEUCbxAx
 Bme9b9M+DcwYG9MlAGvdKjFHQA4HXPV7vbviZmy2z5/iJOv+6mObRJUtOHeeIGK1xZDD
 KtSeGiWV4DFKRP0D2vbbP/g1Kg27PrVJoAFX6rh4/HxIdVBmY7/mQN2zn8R2R3nUDY3V
 701A==
X-Gm-Message-State: AOJu0YzK194XEI15XxIZ2zeAI6CIiqBucBVD/JUeLjwRYvtYaYm8peJi
 B04zLa6XIbab7QIonK6ztAsaO3d+Dnc/EA3T0m9SVrrUQ+s9JfMvvBSCMy9cx9UZ35/K5IjBu+e
 SyI6I
X-Gm-Gg: AR+sD10mT2rvMiVxqf6uiXdIP0Q2KBz17pgxc3eFG1uy+Y2R4f9Tw09HbtSEGgDHyi8
 i2XHSRA/103+7M7tL7DEKfH0LSunNIT++BUJmtIbr8GoHvD5AYC1rLVpWaXmPF3ggF56TFuBax6
 4YFiCixJJikdc9utPkSWrCBjbq03C14pAV9N5h3SqRG5evvGNAJhPVyxdBwLgtsaeXkV81Br+Pn
 OpzgBXrAWBEgUn/07W69QWKmmtOigzgnkzBgFzgW0KY3NnNoZ1Hp2Xx0pRogjHb4BEbjd9PBlWJ
 TRlDgXyNoF162h31mIOor1bO7eio2Gw9a3G0Ex7qdbAoTMMZ8iu9DGrA2RJWvCsz831gChhiT5f
 29CtgFd4J3iy309KUQmCqCwbkKCtTv2OtPVyephiUZqA9A1Z6VZEteN7x3YzddU9GAdHgyboBPW
 ot2FcSKZlF1kl4Jc1721GQJxqZmfc988sLwtOE40tb9B3XdkzvqS3z+9jOQCuB+vuUy7U/DxERi
 eONLmQr2o6J1ufMsNvMUa+V9li0DpVDjbxOYPuK3KM4nzRU+V67imb/M8Jvyvku82G1SDxyPOFU
 vwth
X-Received: by 2002:a17:906:882:b0:c0e:e136:5dc9 with SMTP id
 a640c23a62f3a-c1fe8250f26mr15638166b.37.1785514833103; 
 Fri, 31 Jul 2026 09:20:33 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm6328593f8f.34.2026.07.31.09.20.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 09:20:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] target/arm: Remove stale comment about WFE/SEV
 implementation
Date: Fri, 31 Jul 2026 17:20:24 +0100
Message-ID: <20260731162024.3097467-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731162024.3097467-1-peter.maydell@linaro.org>
References: <20260731162024.3097467-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

We forgot to remove a comment about WFE/SEV only being implemented
for M-profile when we added the A-profile support for this; delete
the stale text.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260728111629.1705308-4-peter.maydell@linaro.org
---
 target/arm/cpu.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 03a30afcbe..c0492c8dfb 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -766,7 +766,6 @@ typedef struct CPUArchState {
     /*
      * The event register is shared by all ARM profiles (A/R/M),
      * so it is stored in the top-level CPU state.
-     * WFE/SEV handling is currently implemented only for M-profile.
      */
     bool event_register;
 
-- 
2.43.0


