Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0701ECA0EE6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Aug 2025 09:03:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umqJX-0003ex-Bh; Fri, 15 Aug 2025 05:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJQ-0003ZP-4c; Fri, 15 Aug 2025 05:01:24 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1umqJO-0005cl-IT; Fri, 15 Aug 2025 05:01:23 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45a1ac7c066so10096855e9.1; 
 Fri, 15 Aug 2025 02:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755248479; x=1755853279; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzrN4JQXtZ2ZB3mC3v/OE6qFemrSPSXXjsrAC6BF420=;
 b=O71QLXN9kSeTBuj9OmS1CTTy1NObx2Ix1GKztcx1AdZ3W0Pp3aZC7tfSSIIeXCuGuJ
 kNjJ9SuYBdI77CHfTdyp5MF/xxnvI57ZcGJaYgglgCcjvOheb1kv0WtOLz8dy+b4l7rR
 fnI0gCZvjNf73w4Ow5GgFi0Ffh5G/trPg9MlKZ8oAj6svKDNl+Un4bLeiUZt9bClaqJi
 3zyQNkosb8rbemc2R2wk1j0wB6zo3tu1VUswBZmkIPjiQ3ZbSMvlf/Cc0rSkJG+EZyCt
 cd+6Mr18aCxNIFtzYGQkLharO13HFFc4Jm37kuzalmSwiHfMj5D1DGD20Z6cDpr8qgiw
 mFiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755248479; x=1755853279;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xzrN4JQXtZ2ZB3mC3v/OE6qFemrSPSXXjsrAC6BF420=;
 b=wmt4kMe0yIiQKr+tU6+JWTRzkyq5xfh1pNz1CJqCJLbZ0QgP/V4Ukf/xxADzPXnnuB
 Or06jya0Nma0i6Ygmmp5L+vE8IehAItuOeMJsAuczewlm8xRsQnW7+h/93gPhDkXsy6t
 JO3uhVvi33+QvOD0HLsZHxlfaHgiPggHwTB1yDHEaIF4Dg365mIk6oSUNwDJmbG7TmAs
 mNWl/xRF4udj+yX0JyN9L6jVJ3wyrhqSVSNeS9bskLvvkohTpxrHS9RvaBrvq1RQfGQn
 A3vt4mG36VbdEOAV1N9WtCO/noFvhXXj4ZVv2r+Y/sFZukQgh1l3ZRiw8BXXdBpcusWH
 +A7g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlowokfkrM9ukjhsO569WZ/v3CpTeoi+jAdhLeJxsw84Q0cVHdlKJcpRcMzxInWQO0r8JsT08cpeuRIw==@nongnu.org,
 AJvYcCVDYanbyRns6QyGBLz5rgqQSZ4WrMLiY3ZeYnheRs3WBE+vf4hXIzjHeDNfOF7qtf+HPzuAw6CLww==@nongnu.org
X-Gm-Message-State: AOJu0YyPk57sVBM41dmTEzsdxNLadwHDe2tcvVcx8fmgOeN3vafw7Fgb
 1mA7ZcM/eXNyyheI2r2OaDKCaooqcidyoqg08lWYS0UWWjAS6QUCmNm5xrgAv9BS
X-Gm-Gg: ASbGncslc5zS5RqN2HzQ3b0wEoxfQcRU9Yq5mySgW4fWSFSeP96mFejtJPo+pF6TlsL
 5Oi5cRC+l9yg5ZeKeARiimmGErz1Z18USi8S0WV7S0i79x58P7cy3c1/07epH0NREnYskLubt70
 uBG0XXjGxYvRb683HhjA6o+btP3LwGJbdB8Oomml0x8XaSB5nEJyBWKlGzPW8sbsNKGpjl/qv7M
 xk2JhcF0m4i5coYBhyYWa2VLAAOgoIFdjx3kgC34NXYs90FpcsxVYsELzOcs2FWvtI39wAunEos
 3VF6cfm2ywY0bgdoymKvlNTb5Ts3z3I9ewwAyFjG7z6hiiQcVhVQ3o3o0ZOK3LWe/eRA6u/b3sA
 yqeutVfJGi3eJPvVVbG8tC3RFQSyMJGEe9Xupx0HWl6mC+g==
X-Google-Smtp-Source: AGHT+IF/Y/srYJuhQGL35zSkQ0shzVw6j+XD50SJI8yIH1Yn5+vYH4laj8+TI7ccwZcnC3cRisN7gg==
X-Received: by 2002:a05:600c:3f16:b0:459:d577:bd24 with SMTP id
 5b1f17b1804b1-45a1b677a70mr45487975e9.7.1755248479346; 
 Fri, 15 Aug 2025 02:01:19 -0700 (PDT)
Received: from corvink-nb.beckhoff.com
 ([2001:9e8:dc31:6500:43b3:5eac:8d91:b512])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a22321a54sm10964045e9.18.2025.08.15.02.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 02:01:19 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 qemu-arm@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 YannickV <Y.Vossen@beckhoff.com>
Subject: [PATCH v2 05/14] hw/dma/zynq: Ensure PCFG_DONE bit remains set to
 indicate PL is in user mode
Date: Fri, 15 Aug 2025 11:01:03 +0200
Message-ID: <20250815090113.141641-6-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815090113.141641-1-corvin.koehne@gmail.com>
References: <20250815090113.141641-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: YannickV <Y.Vossen@beckhoff.com>

All register bits are clear on write by writing 1s to those bits, however
the register bits will only be cleared if the condition that sets the
interrupt flag is no longer true. Since we can assume that programming
is always done, the `PCFG_DONE` flag is always set to 1, so it will not
never be cleared.

Signed-off-by: Yannick Voßen <y.vossen@beckhoff.com>
---
 hw/dma/xlnx-zynq-devcfg.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index f28d0015e6..60ea351494 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -188,6 +188,8 @@ static void r_ixr_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
 
+    s->regs[R_INT_STS] |= R_INT_STS_PCFG_DONE_MASK;
+    
     xlnx_zynq_devcfg_update_ixr(s);
 }
 
-- 
2.50.1


