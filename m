Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C529CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:12:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1Upd-0001XX-HE; Wed, 24 Sep 2025 15:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Um0-0006ww-Es
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:32 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujz-0007r3-Iv
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:26 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-33292adb180so155767a91.3
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740478; x=1759345278; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4zu8R6LKwQ6lOrIKQecK3A2J+NyHWCkSHewciWwmNMc=;
 b=qfuD3M7YRcOAqhnHWaki/MG6LGUd8PgNQLnupz9ryFonll9H+J7Vl8emGDUhm5zINq
 oJTSXlhnBmbFBvguhkE++7PpsvNmdl33nLxUGwPuFvcUK2G44hpcumvwgS7X/tSwMMDR
 09YAAS6rrNVpeIKRrurTnKq7kCPlRtZAOqzq1nSK6MitCvBHvYz1/bV/b50R+N2CEmQd
 jX4gnWSgevWsHFkKmL6zip+YHyS555nrhsnWw768dryLZ7kPc8bi6+pZCaUaSsHkQ5UH
 AJaichmyL7q1DHbX0BMpRrsuWUy6z0isKP4HP+qJi/SYie5kT+aQkJzxApSjQrEupqf/
 wt0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740478; x=1759345278;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4zu8R6LKwQ6lOrIKQecK3A2J+NyHWCkSHewciWwmNMc=;
 b=TjzuUWh0iSoYm8VT9U2xIbdSnDoVsnEh13idaMkZw+bfqPSBO3DXq9+fxhXlFWUsLt
 372JhBBJEADwfxq+DrW9FjYBvvswZLVkMjec2AD3Cu/gXgH7Hd3okejd9Z6cn50J1IzB
 cXbGstpSiUSrvVwbX56oAMA72I6uW+qHCwAZIB/sQiIapwCN/VDm5H/7TM9PBbzFvCIz
 vXMKRjnpDUCAM+Ez0XKktUCAB0d7kd2o2jzlmaossXkgTc1KR1W0fhPZZUbxGPAxAlhi
 EhUXWpFQ1HEjMXTblVvh5baxMPZCd1mgFToC2x3yurS9G06tuUnqq0zvPH7n5T/oinw/
 nR8A==
X-Gm-Message-State: AOJu0YyhZgvXHfFvvGt5lH2YYHPMXoPbeaRWAJ2zsU+xjqQRQEq0DO35
 ZzHyR+LdeeyfOTZapjhDoWzW5RxZi0CtR80CWiB4tmsT5RENPKJgTdsCEObyZ5qNA+vhx7jAiSX
 Ug/TF
X-Gm-Gg: ASbGncuYp+yP5tOT+Mg4U/CCXfty7j7RzMNDWDpTxMfh32AVUSLetuJshDyVjOLIjqy
 /oGWIHof5SqzcXd36FVYFThGPx8TUv/IQS5m6F8sYbLQgU2qGKUNJr9vyNMYUyGJL0oTQIpDa8v
 xaEUA4ytzS9E+7ElLd4FlPKLceAHgdV9BtXeHQ2KvQ9Zs0bk8B87+rUwARFcuOPwT4vH8p8h6kW
 SxkftrNeXpD9l56mAAMioCqkwe1g9X4pO+H/bNA9tK5tFe2so/H3PZSBiUD62U5iplDiBjj3+BO
 1Is4jaxT6+F5ZR7tF307sUyflG6QWSWZmofphHWiGTfojMEIRAyc4lEqvVjeZ68f+4IAQSdLwjn
 sKqV0rx9ImPySTVJjxS1KWTyL5LSdQDMMQCE47CA=
X-Google-Smtp-Source: AGHT+IEadd3X811FAaXgH/d96fYSTO/P7z296cG6vhNihw2ageBcE7u+w2Nf7YAvLJC/x+ynTwTf1Q==
X-Received: by 2002:a17:90b:380f:b0:32e:32e4:9789 with SMTP id
 98e67ed59e1d1-3342a257486mr797233a91.3.1758740477679; 
 Wed, 24 Sep 2025 12:01:17 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:17 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: WANG Rui <wangrui@loongson.cn>
Subject: [PULL 14/32] tcg/optimize: Fix folding of vector bitsel
Date: Wed, 24 Sep 2025 12:00:47 -0700
Message-ID: <20250924190106.7089-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

From: WANG Rui <wangrui@loongson.cn>

It looks like a typo. When the false value (C) is the constant -1, the
correct fold should be: R = B | ~A

Reproducer (LoongArch64 assembly):

     .text
     .globl  _start
 _start:
     vldi    $vr1, 3073
     vldi    $vr2, 1023
     vbitsel.v       $vr0, $vr2, $vr1, $vr2
     vpickve2gr.d    $a1, $vr0, 1
     xori    $a0, $a1, 1
     li.w    $a7, 93
     syscall 0

Fixes: e58b977238e3 ("tcg/optimize: Optimize bitsel_vec")
Link: https://github.com/llvm/llvm-project/issues/159610
Signed-off-by: WANG Rui <wangrui@loongson.cn>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250919124901.2756538-1-wangrui@loongson.cn>
---
 tcg/optimize.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3638ab9fea..f69702b26e 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -1568,9 +1568,10 @@ static bool fold_bitsel_vec(OptContext *ctx, TCGOp *op)
             return fold_and(ctx, op);
         }
         if (fv == -1 && TCG_TARGET_HAS_orc_vec) {
+            TCGArg ta = op->args[2];
             op->opc = INDEX_op_orc_vec;
             op->args[2] = op->args[1];
-            op->args[1] = op->args[3];
+            op->args[1] = ta;
             return fold_orc(ctx, op);
         }
     }
-- 
2.43.0


