Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F8E9EB104C
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:46:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzuab-00070Z-QA; Tue, 10 Mar 2026 06:45:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuaa-00070F-2O
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:24 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzuaY-0005lU-HC
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 06:45:23 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-439cd6b0aedso4715280f8f.1
 for <qemu-devel@nongnu.org>; Tue, 10 Mar 2026 03:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773139520; x=1773744320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qw0e1BsVz/+1pNHiRmvLy0a6vY8j9BXsvSZSxO4C5KE=;
 b=InrXhdcMXiW+UHJrhtWRv0I4nJe6azms5ZU2xbWr1M6s040hd4WlQYuQEQf2RU5eTe
 /RV9q5HG9EvU4xEuS2/GzW/BwWtvybTOnMMlTsFoF+ZE6E7MGVFGDss9viC53aqOZEpa
 8cjviIHbvPDJc0fOSbpXk4IIeM0bmcA6U2GDI0nottODwyQ2ms0hYqGkzLO4FLHj4L7d
 JNj43QQJ7zmvYmdpt4HdQOrCAP7xFLZT8YbySnhXggzf3nmFyq1tb9DM0R2Sm6NPtz6P
 YVbj3ICBtf8wIknFBPQuRj5SDnDNCjG51s+Aho242cxKoXZ8r3RIEJJbvE0BqrtsDAKi
 57HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773139520; x=1773744320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qw0e1BsVz/+1pNHiRmvLy0a6vY8j9BXsvSZSxO4C5KE=;
 b=L3ASUZ2CjAQD9eVSp1W7UQb9CW2z1rml1cxRjMKiAPSRgdyyms0IHHzD2qE+TDvd2g
 Nm1OpaCcCo7elpPwTKCypNKFVvZVE/b1l6atw1qxLq4GawmpSg41iixCquFouwQClWDi
 ItqrULAgbSEgj7DjMKuMZ+ofMtdo57aDpvji2h/eN9wK/8y9m4OdZmpPgujZ7R8fhapv
 o9tcB7Arer5PpK6l0O8ksm6ueWkonDc+AAHdRX7ZfTyYJj7l1AsLzc0GYbh16Z+2k1u/
 UwEg2arLw4wSxSWRO8kk1KckDUDX5tEPL0AXg8hWarMOkL19Bmw1hWLRQKgYChEYV3FX
 8l5g==
X-Gm-Message-State: AOJu0YywqPl9g/m0k8hih6mbRbIHmiuvDILRJgCnbSKlA5vq5YGwk62F
 uIcNpCBKzREfmgQCCc7iwSo7X57C26Ljz7huDNWAkKuJ5XHKOGJunyDVh/GnSYBd+hwdHX3w7lf
 7aRtqbIU=
X-Gm-Gg: ATEYQzz3kFwUxZ8xVGcdSxqzj/Je0iuJbBOyri36wJonuDq0tc3vP2nymjlkixiT0qH
 YYgVEV2qms1fMzZAszaslMj8eOEJQ9usrcjNLwb/XGVD/dCh5KM2AxHdgbQVCNE2AZ17qbS2gtM
 UHVASO+//bz2m/Qx5F8UVA3fU6Gn4Uq4/8qrw0sjwFrGKFPRHLsrjQblqWoKqrvnhHoki9WsDZ9
 wTUSVsMCXOgvoxzWGvqRt7xSxxfCo60TBUjCeA/+HbZ2y3r28SJvB8q2D39p+EO1GWb4Imm98yU
 o27JTzTH7/alhVpp8lurQAGakcu891fwRCVnNN68bEZDTMp2gq/Vyqr+yN/DdwBdf7TlTEM53U2
 +jxiY3Mh3xzpFUUHxXlH1jRyrLX68UThCHsgfE/bVzd8gJolYuvFZ5eBidywiM3qJKfKHz6cYhZ
 22AIw4Xlk3Qv90q/PwZ8lom5BnBQW2e7myvA0b0mcwd+ZxCY8ZT9KLHlvrDw7cYv/86rXu36eu
X-Received: by 2002:a05:6000:2003:b0:437:6d8c:c08a with SMTP id
 ffacd0b85a97d-439da8942d3mr24542322f8f.45.1773139520246; 
 Tue, 10 Mar 2026 03:45:20 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dae2ba66sm30678880f8f.20.2026.03.10.03.45.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Mar 2026 03:45:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/16] tcg: Drop extract+shl expansions in tcg_gen_deposit_z_*
Date: Tue, 10 Mar 2026 11:44:56 +0100
Message-ID: <20260310104511.12670-2-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310104511.12670-1-philmd@linaro.org>
References: <20260310104511.12670-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

The extract+shl expansion is handled in tcg_gen_andi_*
by preferring supported extract.

The shl+extract expansion is simply removed for now; it was
only present for slightly smaller code generation on x86.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260303010833.1115741-2-richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 tcg/tcg-op.c | 30 ------------------------------
 1 file changed, 30 deletions(-)

diff --git a/tcg/tcg-op.c b/tcg/tcg-op.c
index 8d67acc4fce..b95b07efb57 100644
--- a/tcg/tcg-op.c
+++ b/tcg/tcg-op.c
@@ -937,21 +937,6 @@ void tcg_gen_deposit_z_i32(TCGv_i32 ret, TCGv_i32 arg,
         TCGv_i32 zero = tcg_constant_i32(0);
         tcg_gen_op5ii_i32(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
-        /*
-         * To help two-operand hosts we prefer to zero-extend first,
-         * which allows ARG to stay live.
-         */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, len)) {
-            tcg_gen_extract_i32(ret, arg, 0, len);
-            tcg_gen_shli_i32(ret, ret, ofs);
-            return;
-        }
-        /* Otherwise prefer zero-extension over AND for code size.  */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I32, 0, ofs + len)) {
-            tcg_gen_shli_i32(ret, arg, ofs);
-            tcg_gen_extract_i32(ret, ret, 0, ofs + len);
-            return;
-        }
         tcg_gen_andi_i32(ret, arg, (1u << len) - 1);
         tcg_gen_shli_i32(ret, ret, ofs);
     }
@@ -2210,21 +2195,6 @@ void tcg_gen_deposit_z_i64(TCGv_i64 ret, TCGv_i64 arg,
         TCGv_i64 zero = tcg_constant_i64(0);
         tcg_gen_op5ii_i64(INDEX_op_deposit, ret, zero, arg, ofs, len);
     } else {
-        /*
-         * To help two-operand hosts we prefer to zero-extend first,
-         * which allows ARG to stay live.
-         */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, len)) {
-            tcg_gen_extract_i64(ret, arg, 0, len);
-            tcg_gen_shli_i64(ret, ret, ofs);
-            return;
-        }
-        /* Otherwise prefer zero-extension over AND for code size.  */
-        if (TCG_TARGET_extract_valid(TCG_TYPE_I64, 0, ofs + len)) {
-            tcg_gen_shli_i64(ret, arg, ofs);
-            tcg_gen_extract_i64(ret, ret, 0, ofs + len);
-            return;
-        }
         tcg_gen_andi_i64(ret, arg, (1ull << len) - 1);
         tcg_gen_shli_i64(ret, ret, ofs);
     }
-- 
2.53.0


