Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 196DCD5C0F3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:49:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R9h-0004kt-0n; Fri, 08 Nov 2024 10:44:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9J-0003Aq-Eo
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:52 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t9R9G-0005Tm-OD
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:43:49 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-37d8901cb98so2046590f8f.0
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731080624; x=1731685424; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uljKpTWKHfIbJ0MtlmY9PWC2nyD8V11sN9kOWSbXIe4=;
 b=jNiSK+B+ol6C+dqCcQiyAoqgAqDGQHqvWlv+Zw1XMNegjM6DqodZxkKLzEVDwhJZ3f
 2gfFdLMkMrvuyqemBqc/tWhPTd1p5W40X4y0BE+aj46kIlf/yktjEB/R2CsM/2WeFVCG
 cAM1DxizECc6Y6bWBvfa70Uy1pqdhIGRWLIEzaHDlkj7auj/JaWb8EZyeab9yF9Vc5oq
 4zHghJBFcTJMgA0kv4g+UhaTKbGJV2PSvMyhIHAFI0wBtNxaPMK81BYZtSAckTw9hPFu
 wOMXhKzVUjWOlg3oh0/+Z+h55ZTACUtAP28kO36IZ/2afxLNea/NDn232ZwCBTDMqvq2
 9U5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080624; x=1731685424;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uljKpTWKHfIbJ0MtlmY9PWC2nyD8V11sN9kOWSbXIe4=;
 b=Dle9PzceZCa9DcZTJAvLyb4JbjvTN/NQ14SmU3UeqX3a8Lx/VdEkIEmpgL8J7ou0IG
 qvr2dPivNzLFFXn/mxLtHmuARdnEXDTNx4fe/m8eEwJOHE+m8uE+h4tFyKq/FzdUAWMB
 +Jspjuk2EnTSOBdtR0kPnESD44E5jG0380CLmUpjR0DnoxgOegWXuRetblZbYJJemhsH
 SOLXN4CpsHqVRBX0rf+OWPYn2W3wriYlxQ8UnYVB6gVJlcdDLmF552WwuR5sbnyAFpTg
 jHelpE+27zA+5RcAfVkTo+KFsWuWRiOlYLICC58MNDF2X4BKVbTkDVSL/ksvYrSYQtOL
 FIvA==
X-Gm-Message-State: AOJu0YwZaWAgvjkA9ep9gkm/NJgcXXxPuDns3dd0Lx370/IuJQABYWDn
 iPMbXfIa1JboRTfM12qh3WcpIOW4e4qsNGeTY2Qvx3V3TMZrFZsaiu70L79JYeZ8TOQhAK+JjgV
 8
X-Google-Smtp-Source: AGHT+IGGEfF/rUyqe5DFJJORPox6p+y0DDitfZCJPKPsvIOyG37YnM05K5XRC0GsGdbfvvWeW/M6oQ==
X-Received: by 2002:a5d:59a7:0:b0:37d:2d6f:3284 with SMTP id
 ffacd0b85a97d-381f1a6ca9bmr2971832f8f.9.1731080624624; 
 Fri, 08 Nov 2024 07:43:44 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381eda04ad0sm5235518f8f.100.2024.11.08.07.43.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 08 Nov 2024 07:43:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Anton Johansson <anjo@rev.ng>
Cc: Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [RFC PATCH v3 05/17] hw/timer/xilinx_timer: Allow down to 8-bit
 memory access
Date: Fri,  8 Nov 2024 15:43:05 +0000
Message-ID: <20241108154317.12129-6-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154317.12129-1-philmd@linaro.org>
References: <20241108154317.12129-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Allow down to 8-bit access, per the datasheet (reference added
in previous commit):

 "Timer Counter registers are accessed as one of the following types:
  • Byte (8 bits)
  • Half word (2 bytes)
  • Word (4 bytes)"

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
RFC: This breaks the UART qtest, instead of having TX register
receiving 'T' = 0x54, it receives 0x54000000, converted to '\0'
char. It works if we use SWI instead of SBI (storing 32-bit).
---
 hw/timer/xilinx_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
index 383fc8b3c8..c117bff225 100644
--- a/hw/timer/xilinx_timer.c
+++ b/hw/timer/xilinx_timer.c
@@ -198,7 +198,7 @@ static const MemoryRegionOps timer_ops = {
         .max_access_size = 4,
     },
     .valid = {
-        .min_access_size = 4,
+        .min_access_size = 1,
         .max_access_size = 4
     }
 };
-- 
2.45.2


