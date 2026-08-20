Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B8CC5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 03:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwtk0-0002TM-3n; Wed, 19 Aug 2026 23:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjy-0002R0-OA
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:54 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wwtjx-00047F-3L
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 23:46:54 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c9b373d5af0so1122024a12.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 20:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787197612; x=1787802412; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fQDgWJg7DF9eHEdRBw/5L4zK1k6fMkTJXubxOKeqz3Y=;
 b=VKqKMb2TaFCG70GPcHb+VTp/sTFss25qiYRrBbGCstrV/Hdljtn0cewR75TcWVuvwx
 eDYgUmWwjAvyCsNWuhee47jTKWZPpOfmJhFHxCHMiayLve0CvqO7VOZYBhn/Zj5uC0tN
 dkOeoirYrxjmjcbF2Pu+3oCcn3KVn4aYlnrCv38aBxQOaS9VP4YnZmuWg8TbKXq7U2a0
 hfhlG7ze8JXFPe6A715fIz6bLSN5H8xEWqGaoYJ+HSfqO0g6NiroYUIqkykLt5JyXroP
 FhdnQdRjuGuQPnXdyf1zXDflpxklXOAiMMrqlHRFcihmFUBVC6sS8kOe364zDUxpN1bw
 jgyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787197612; x=1787802412;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fQDgWJg7DF9eHEdRBw/5L4zK1k6fMkTJXubxOKeqz3Y=;
 b=YlqTxlMbCJatI8PTK555kL1D+YRlbEyaJBmFzh4ECv6zv3e5mdVyS3wKrkFpAZeeEr
 jRSMKX/yAGSzunM4uqIisoYlni5vS+R5Lh9dMHITcmYF5H/Yof4qR4MKqV37/uPXZPbx
 czZRLJj/SoBdfLzj+EAQaxWFQf3ej2RE8mOYv+9wjKG5xWp5Y/iW45+Tw0nE08hexiem
 ddoEFBCYbzC9L6rilXwm6v1dVK2vZZb7PPxj4yLVF5nQ6CS3Yqdn4+HUMmpytNZKgO9/
 VC9pCSNspgN/k7h9KWBwqE1YPjgIWSqmGQHdVk7Kvd15igvIsnrAz6IXGy+gI6YXAFR+
 LYbw==
X-Gm-Message-State: AOJu0YzGxLgarsm9wA5KN/50xKow1C3d7mstiX1kr3CHi+gpmPowkIxe
 hhkNXGgv1YiC6860erEFaULo/LnUhCEPf1teB90KHLEJSr/a9Wn613a4WNP8pQ==
X-Gm-Gg: AR+sD12yKCmTG0RjqHdO+NuJMl1i0dtASlfjVkBLtxOggKZQSdcXCgSMJPY9b2pXWoM
 BcBlXHN2xchkCz5GigYt3p1ttAyrwB8m4pfsphG0nRpDTakRfsfzHuUTc4b127P/3gV2k1HPCH4
 eTWYo/c1xlmnanI1CRDZIA8CZA54rDCC4yOtSLTXqAibwvPQSKU2NWaEgl/fKmJH7HN9HHca9na
 iXxlDj869F21O1CfOBXCoNjwcOe6vsTvJZjVwvmt69RFZ7h/toiFejaVkP7QHyYWTGhe/OLnCO0
 zdlJLzVhrhxsbf0ucyDO2cQ+pjGq5YPuv9QUes+wS+z2rClYLYschIQTWRFtgmfOU+E1v8m6KY7
 m+Gm5TRTnB37JhmVP875xWh0BZce0mXX8SEqWGdwMlR/6/1IIekpJ9Ak09V2HCdRFndW0thui2k
 UV8EzwqV6o9FbLVmxlhqGBrsVIq+MsymhmQTComEPz+rTdyOo4QRNz2BLwq2iIFHnlyUINXSl7J
 6DuMyVG2vZJ679TzPi9GzkB7i/0
X-Received: by 2002:a05:6a21:4cc2:b0:3cc:f008:8123 with SMTP id
 adf61e73a8af0-3cd010d38c4mr17724926637.8.1787197611580; 
 Wed, 19 Aug 2026 20:46:51 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:13b2:851f:d9cb:44c5])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1416ad6060asm19506735c88.6.2026.08.19.20.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 20:46:51 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 43/93] disas/riscv: Pass rv_opcode_data pointer to format_inst
Date: Thu, 20 Aug 2026 13:43:40 +1000
Message-ID: <20260820034430.1186695-44-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260820034430.1186695-1-alistair.francis@wdc.com>
References: <20260820034430.1186695-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-pg1-x52e.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20260812223142.349142-8-richard.henderson@linaro.org>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 disas/riscv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 0be2f07612..70ea41f125 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -5111,17 +5111,16 @@ static size_t inst_length(rv_inst inst)
 
 /* format instruction */
 
-static GString *format_inst(size_t tab, rv_decode *dec)
+static GString *format_inst(size_t tab, rv_decode *dec,
+                            const rv_opcode_data *op)
 {
-    const rv_opcode_data *opcode_data = dec->opcode_data;
     GString *buf = g_string_sized_new(64);
-    const char *fmt;
+    const char *fmt = op->format;
 
-    fmt = opcode_data[dec->op].format;
     while (*fmt) {
         switch (*fmt) {
         case 'O':
-            g_string_append(buf, opcode_data[dec->op].name);
+            g_string_append(buf, op->name);
             break;
         case '(':
         case ',':
@@ -5466,7 +5465,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
     decode_inst_operands(&dec, isa, op);
     op = decode_inst_decompress(&dec, isa, op);
     op = decode_inst_lift_pseudo(&dec, op);
-    return format_inst(24, &dec);
+    return format_inst(24, &dec, op);
 }
 
 #define INST_FMT_2 "%04x              "
-- 
2.54.0


