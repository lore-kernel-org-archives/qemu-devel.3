Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E86C369BA
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:15:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mCB-0001pB-2z; Tue, 15 Apr 2025 15:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5y-0000Ju-DT
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:23 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4m5E-0004dx-2Q
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:37:21 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so5132536b3a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744745783; x=1745350583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=G5p4RrMxMzkElyyDPf3cSqhdor+xqKIkZ6v+B4qONE8=;
 b=bPdt0P5QuIQv0/FDHxIFAhqY3ABtgEB4WF/m5jlhMfY5MFpYAE/2q3RerYOGVEPcQk
 96liHwm40RGAs3JisgXjuRQvHgokaLQotgz2/b6PU5Aj19qr/bPn+3jBR49sbq8H23+l
 R7HZirXjjk/fKgBX1q2giFVV8QalbKjT7RgqFxxsDyXDaQqa5sCe/nU7OhZ2xcpJy3HF
 LZX1NTWCVSUvIlVyArWXxkdHpxoi9ndV/6WaewSgmNj66PXFaxFQpddYgylwqRCLx/bh
 nU/DMudIP8mV9CgSMtWGEHmKXziqgAKUDE6LdkIGyO+2c1tr3EzoWP+6DJlDERB68cj8
 1NYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744745783; x=1745350583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5p4RrMxMzkElyyDPf3cSqhdor+xqKIkZ6v+B4qONE8=;
 b=sPodP4w5hTxHC8dNako/xgq+tH508kwiHOfbxv/+bChMXTJ6RKymafwe+gyVftTsHX
 lo593qrVh/R2kBbkmzR3jc1yh+/InqHp86xWHdiYfacxLyH8bWHOr1/7OE76Qy4T3yqF
 /Xq6YVn6EZuYvqpKvouCFWUpFxCjO+OWtmg9COOW7AdaVfiswAbgwEqCxyiEKnPorwg8
 bPxoyHDloSEJHH8R8tSZ8qktFxDFXlSw+OPNzT3Vug/8d+5A+tMjEPY5gzNUzwJHm+dP
 555FahRwJkcEwA3fOwDijrO/ZWruHVsaIEifC3zGygGS5XkRm5kbGq8wX8xa+Mepp790
 lzMg==
X-Gm-Message-State: AOJu0YxOTIj/b/jPmXVomAEoizpoQdqif8qnnvd56gwXrLe6nQYizWEh
 +ltTaBEVEEh1yIzkze/yrJR52fOEo/6dk/F6R2nUEizYjz6hAF/Do8YFVmjGqCBfmGuYcK0Kh6g
 a
X-Gm-Gg: ASbGnct9xdK9NoO8QzQZsyyQI0LxQuF+YqDTiWvOpfJVSAkrPZM9WXaEshqaM8t/YmC
 rKLJNepnjgwzGU0zYa74OA3nzwPTLxEfYdjrzPmKiWRT3FXRztGdFnvhbL3gVHW+LV/WZuaayrq
 kvE4DlL1labcslMwqLMoEqabNjaB+HID4CAnfWXadYmCpzRUgR9TQQbAo/ylA6/L8ncw0E1RPb1
 AbWiUc90YeYDLfWFIkvk1xyCG5LR8S75sQowNN9ntemgzn1zrashkMqif+cSQg/X3SLVO8LLh7h
 c/YPG2BOOF6vqn5EQrbKl57YKm5BzfYcd1VHp1NzbFbfjtzK/simcbO01waHSn85/OoxoWEIcGw
 =
X-Google-Smtp-Source: AGHT+IGkvuLCioZh0mxzoQtobEC+vhf3/av02zBSvLqv8kwPwAJaWvzFuxZjlEhMQ0hv35tDyKSeWg==
X-Received: by 2002:a05:6a21:9185:b0:1f5:8a03:ea22 with SMTP id
 adf61e73a8af0-203ae05c6a6mr318261637.33.1744745782671; 
 Tue, 15 Apr 2025 12:36:22 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 153/163] tcg: Assign TCGOP_TYPE in liveness_pass_2
Date: Tue, 15 Apr 2025 12:25:04 -0700
Message-ID: <20250415192515.232910-154-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Here we cannot rely on the default copied from
tcg_op_insert_{after,before}, because the relevant
op could be typeless, such as INDEX_op_call.

Fixes: ...
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tcg/tcg.c b/tcg/tcg.c
index 05604d122a..3c80ad086c 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -4408,6 +4408,7 @@ liveness_pass_2(TCGContext *s)
                                   : INDEX_op_ld_i64);
                 TCGOp *lop = tcg_op_insert_before(s, op, lopc, 3);
 
+                TCGOP_TYPE(lop) = arg_ts->type;
                 lop->args[0] = temp_arg(dir_ts);
                 lop->args[1] = temp_arg(arg_ts->mem_base);
                 lop->args[2] = arg_ts->mem_offset;
@@ -4480,6 +4481,7 @@ liveness_pass_2(TCGContext *s)
                         arg_ts->state = TS_MEM;
                     }
 
+                    TCGOP_TYPE(sop) = arg_ts->type;
                     sop->args[0] = temp_arg(out_ts);
                     sop->args[1] = temp_arg(arg_ts->mem_base);
                     sop->args[2] = arg_ts->mem_offset;
@@ -4507,6 +4509,7 @@ liveness_pass_2(TCGContext *s)
                                       : INDEX_op_st_i64);
                     TCGOp *sop = tcg_op_insert_after(s, op, sopc, 3);
 
+                    TCGOP_TYPE(sop) = arg_ts->type;
                     sop->args[0] = temp_arg(dir_ts);
                     sop->args[1] = temp_arg(arg_ts->mem_base);
                     sop->args[2] = arg_ts->mem_offset;
-- 
2.43.0


