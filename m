Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33CBE7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:25:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPSI-0000Pi-Sp; Wed, 11 Dec 2024 11:20:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSG-0000OH-5C
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:52 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLPSE-0007lh-Lj
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:20:51 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-435004228c0so31045765e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:20:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733934049; x=1734538849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+U+8i8q/4gXE3A3yYLQmyNCA5wUq2DI1uSwKXqmKO3k=;
 b=hJePzYhzrZ2M69iwOF+slc5pXWWiOjZNYiURPs6P2JXo0rvIJNtfkwhtxVlxcGql6d
 viync8E3ZniH53oqVqa9SYs4hIqV8Pqy/MRJNd0y1XGioFGUoZP929mk20CHQDm8kCt+
 7x2TAJeA48rWUzuSjO0o+dN/pE8JcUBxJ6iXyHjRB0hGHtGyHcMoFbfFIP/XUSWgw4l5
 3bigSZa9c8e2SMqhD9n8JHXHfSXHbwO8OHRWE41H7ivqgpkcsEHw8PcgPjEtY6s8E2VT
 OaJMQnh8NGvz8NP5Mjpbu2FT29cMplDao1FBvo1LnKx5PCaBw9oW12m6Jg1pCJzn9vh0
 NcvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934049; x=1734538849;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+U+8i8q/4gXE3A3yYLQmyNCA5wUq2DI1uSwKXqmKO3k=;
 b=LMBRoqo6OEGG3W4r/l2HukeiYPuuFgLgbVfgUsC6W8XnxNTmlnPOToLRMAScH4FYZv
 OSci2a3KbPzoksTE9CTKxUlYIBkHfuDRZTwyipTmbNbQs4o2pUjKx/CrT5tkV+Y16pc9
 waId/ow6/hxirrMrsmLg5XR5ZKeohfeUD8qjO+Eb0B5y7hHjWiPqaly0sMcwVePIhT4w
 swrhpdgX2V2tOxBlb/bfOXjxoUXwh92P62+Nt+AHpZ7jMmWjx9vUe9hr/bpn/tnwwznE
 ZXHHVG+WPEwtfeLwS45RmRGgtkFu0xVbdT+jfNSDspgXKsm4783Q3mi/gpWy3IMbJTIz
 OjmA==
X-Gm-Message-State: AOJu0YzuU0lRwnMHoHgZYANG5GgqdRxm0Ly6SPRn3BZG9ZDu8E5nptAb
 Ckz5GPtlMot2PRgpk9G8Dxxlbl46DWRiFGm8jTsD4LTz5DXfITIBzuXw9yCLz+F82X/4jqvGS6/
 m
X-Gm-Gg: ASbGnct90R9VMSxstj/mfri9UOem9udgL/LL6u/ZhWv6AZiZPH5Ua2NZiZCua5zZfHd
 IjlKz155VxrIbMVWimhb0HHA9BTBUsxNrgiWL2z0U9/gSV+A2y4nb5SN7F9nQXXlvsj5WaG83lj
 1ApnlV3f9do1iodnVQb8+4duNIA5ysa/0q2NeG5P3K9noEsFOClEWMhDssOShtQmhpvtVqlenGx
 LIHsluSC5MOpDYzMcs8Tqk6ytXE1blTAQ3kqpOmqBeA3S9OsIWVJUVsHGo9
X-Google-Smtp-Source: AGHT+IFKtzJvQ6sUnbqCaP1iE3nvgUiHFSPqtWzWWiUtqkXm1NudkNm8FI9ZrnNaxGumgI/nfj02nQ==
X-Received: by 2002:a05:600c:1f0d:b0:434:f753:6012 with SMTP id
 5b1f17b1804b1-4361c3c7155mr35342975e9.17.1733934049030; 
 Wed, 11 Dec 2024 08:20:49 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434f4dfdcdfsm121460595e9.39.2024.12.11.08.20.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:20:48 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 36/72] target/m68k: Init local float_status from env fp_status
 in gdb get/set reg
Date: Wed, 11 Dec 2024 16:19:28 +0000
Message-Id: <20241211162004.2795499-37-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211162004.2795499-1-peter.maydell@linaro.org>
References: <20241211162004.2795499-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

In cf_fpu_gdb_get_reg() and cf_fpu_gdb_set_reg() we do the conversion
from float64 to floatx80 using a scratch float_status, because we
don't want the conversion to affect the CPU's floating point exception
status. Currently we use a zero-initialized float_status. This will
get steadily more awkward as we add config knobs to float_status
that the target must initialize. Avoid having to add any of that
configuration here by instead initializing our local float_status
from the env->fp_status.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20241202131347.498124-32-peter.maydell@linaro.org
---
 target/m68k/helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 9bfc6ae97c0..beefeb7069c 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -36,7 +36,8 @@ static int cf_fpu_gdb_get_reg(CPUState *cs, GByteArray *mem_buf, int n)
     CPUM68KState *env = &cpu->env;
 
     if (n < 8) {
-        float_status s = {};
+        /* Use scratch float_status so any exceptions don't change CPU state */
+        float_status s = env->fp_status;
         return gdb_get_reg64(mem_buf, floatx80_to_float64(env->fregs[n].d, &s));
     }
     switch (n) {
@@ -56,7 +57,8 @@ static int cf_fpu_gdb_set_reg(CPUState *cs, uint8_t *mem_buf, int n)
     CPUM68KState *env = &cpu->env;
 
     if (n < 8) {
-        float_status s = {};
+        /* Use scratch float_status so any exceptions don't change CPU state */
+        float_status s = env->fp_status;
         env->fregs[n].d = float64_to_floatx80(ldq_be_p(mem_buf), &s);
         return 8;
     }
-- 
2.34.1


