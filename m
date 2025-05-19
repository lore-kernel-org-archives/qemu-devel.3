Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC48AC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGrnQ-0005Hj-Du; Mon, 19 May 2025 00:08:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnN-0005DL-8F; Mon, 19 May 2025 00:08:09 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnL-0004Bo-KG; Mon, 19 May 2025 00:08:08 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b07d607dc83so3083894a12.1; 
 Sun, 18 May 2025 21:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627685; x=1748232485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G78cIS/PHCPYMAvVVMMp56jlLZJ95JW7Zc/OeF+uzTE=;
 b=PusYFZCjnwE3zNz8hHzTs/uAdTr7Zcx/TKotXZhTvvb9jaDEAmf4VvC4nfe8/Ak0FC
 b7gn9Fgqv6zU79oFJinXmyamKkivwhxsX1L0A2HxNGdOgrvcNPqvm14BCS5GRdMyEas3
 S4BuIBSLE14PBURbC+HK8KNGPJCGOh+nzCbJIREsZ1B7Zt9Jn+YmAph0zQoZ/R0DAVZi
 nmEzcb09IhgwsrzubEy2a7HxBAwVs4xeNBUX7sjrQe5GHZd5a5b73bdBKoWzCt/6dsW+
 jRvG+6U+tw0UFzEINVgqOE+klAxZD6aUPeYvRSpukqZGWyw+jQnFOrQE6oHTCIcqg78W
 aqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627685; x=1748232485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G78cIS/PHCPYMAvVVMMp56jlLZJ95JW7Zc/OeF+uzTE=;
 b=LiVt6pNg1joehb/4AYEG+B4aT0fX1EeVFcgUJRXpZtViQD/4mCCFaJ9fEClRI0G1y8
 8Q/rb6edHj7apoQgNHntP0x0vEtAwM5W8j0daoPDtUmpe/75vnivJRTHunOSzcQj0BMZ
 w4GUWFTqN9jfRDxjQOzPWVoASq7zfLBUh5Ikq+sF9aKNsgqCDLWL46zbBhLWNDkyLYpm
 ptynPEets0mhDMRwCvLQgNORn4sJ+ZznvBaD+7377eGaO2gVjjkvSZEmcIz6S7QKpQTF
 nM0bJX2pi/awgS03wWUwwdXcOBzd7Jnv5BmWHSfj9wF0RDzG+Fv6H1R9izgkaFU3vdXT
 5I7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCX37IsK967fiSDzozmk9LZbi5C6qZACEy4g6k+61bDMVAquFTxtflCk3ochC5pmISxyL0xY+Q9BS1MfKA==@nongnu.org
X-Gm-Message-State: AOJu0YztQWm6xkmqrz3vKVUOz76Fo2zantODDGp+Uap1EmD16ydjDsrp
 HZyjAenswiDbh7aHw4MX1D85M6MbgFKXen5jgrdCVNX5YDh4ge7Y9k5/dihMXw==
X-Gm-Gg: ASbGnct03Iwb4XN+GMuUp/RY5tyStvB+cw0Cso3vbzKPTytaQQKRt0H9gjinWXLYgsZ
 or3vmVn+wVOhZi71MpEv0krpIEO4Y3CJ3D3qZudDzJxWpAPZZ/sKx8C88o+RjvtH2D0cEi2rSeu
 g5Y70byQ20Mn0HV1gtqx7PEGdxxX7QKwdZmAWp57JK6qSoDcNd2yWW9yzLzuBfxmDrhS6yR2zIO
 L6+XnRtuevNpnfCnWVuT02KspRbTL+DzwOr/25R6/B/WG0RRZvidMXGJLOL1sFNi4jdwrgZy/DB
 xs90WeRzRC1cD89ehUK4HCP9U6O06Pneu9wt9Vg40oZQTagsRx3UuBaq5lL14CxQsI+mv2rD6o6
 HtQHtG1DRuGF3CGuBbTL0VewnU0tdAPSxsKhSSfTCRAgLwsilTw0rK26C
X-Google-Smtp-Source: AGHT+IHB+Ofrx8ARrqHW2iD0d3Y3jP13tQeXYnOb+o4Kq9gf4twLVwdvNeVxUkH1ttNpT7qpU/D86Q==
X-Received: by 2002:a17:902:cf12:b0:223:669f:ca2d with SMTP id
 d9443c01a7336-231d45a9adamr188926235ad.35.1747627685479; 
 Sun, 18 May 2025 21:08:05 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:04 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Icenowy Zheng <uwu@icenowy.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 19/56] common-user/host/riscv: use tail pseudoinstruction for
 calling tail
Date: Mon, 19 May 2025 14:05:16 +1000
Message-ID: <20250519040555.3797167-20-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x532.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Icenowy Zheng <uwu@icenowy.me>

The j pseudoinstruction maps to a JAL instruction, which can only handle
a jump to somewhere with a signed 20-bit destination. In case of static
linking and LTO'ing this easily leads to "relocation truncated to fit"
error.

Switch to use tail pseudoinstruction, which is the standard way to
tail-call a function in medium code model (emits AUIPC+JALR).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250417072206.364008-1-uwu@icenowy.me>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 common-user/host/riscv/safe-syscall.inc.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common-user/host/riscv/safe-syscall.inc.S b/common-user/host/riscv/safe-syscall.inc.S
index dfe83c300e..c8b81e33d0 100644
--- a/common-user/host/riscv/safe-syscall.inc.S
+++ b/common-user/host/riscv/safe-syscall.inc.S
@@ -69,11 +69,11 @@ safe_syscall_end:
 
         /* code path setting errno */
 0:      neg     a0, a0
-        j       safe_syscall_set_errno_tail
+        tail    safe_syscall_set_errno_tail
 
         /* code path when we didn't execute the syscall */
 2:      li      a0, QEMU_ERESTARTSYS
-        j       safe_syscall_set_errno_tail
+        tail    safe_syscall_set_errno_tail
 
         .cfi_endproc
         .size   safe_syscall_base, .-safe_syscall_base
-- 
2.49.0


