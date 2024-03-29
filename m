Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD268CD1292
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKl7-0002Zq-27; Fri, 29 Mar 2024 18:31:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKkv-0002W3-3V
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:25 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rqKks-0003VH-1p
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 18:31:24 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5d4d15ec7c5so1734906a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Mar 2024 15:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711751480; x=1712356280; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iCXMa8NXK4SslxAJzO8oJ4YsLhlZ/FlXinB3WAZag7c=;
 b=tLImgu+58HnflaRw5SS2lfQQZs06avrVcNc9Burbqh84B3sRVJoiAzumDMW6zeQJMV
 jJ8dbVdV+ezqCjF2Sb8BQHpGmN7z/wYbqMj1VvT/Xsc8QUglzjKIITxbg2RRzDhTni3x
 UFZaJNoBsmwAxE/+mwNvfFEdZPmQm85C4FC5FRyFIj+/M0OKTat8dnpaZOp0RHxMNwuo
 R69SRPeXKGyZLEBjVg2RqZkDBlupj9rj4oYI7oWLUVJGtmQFo7LoLyEeBc+DS7G5I7l4
 DHGUw695U/zpx1s2Q8QeZv2FMLDi/TtmnAmyptMRJSiZeQvXifwsHnlw0iNUu6SDqbYS
 JP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751480; x=1712356280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iCXMa8NXK4SslxAJzO8oJ4YsLhlZ/FlXinB3WAZag7c=;
 b=Yy6vtj98HtZPCqo3l/86cEbqjI/tQ2XZGkl+WK9bBg0Lmw5dT0/wdk8BvmbMoGpgpZ
 527zHqsRUXuBPGX3NC48cHKDRnRYj9nsWAFuT1PH58cE2wegU73dqYhQdyL4khyYsi06
 42BHupxEqhZuTfIav8CHc9Ma0P38QN5XAaMa27VFFIk4CQYi/ApkDJZPElzxheFq+Qa4
 oqrEbQgAEPxdz99DTHNq0M+fbi1ycGKZ9yhvwMmuDUEPwJTbwWpcXyuzGHmDmhwQlrVX
 BOjKUTiuRsoutOiFpsD3jLqyDBc9m8r13XXJQZgMzpQKsCzYQJBKrg7Jp1MCHpHjCskS
 W4hQ==
X-Gm-Message-State: AOJu0Yyt+7ECMJaMieK/eAmCMNrfVjgwWPq7iqF6YinLlGYk2JA6elFj
 s3ROXNpoC1oQvRcy6O5nPMBVOYs2i9+POno2BdNCJ0QmpMpa0JpwNPh+Uzh09d7xP2Dd1p13DG9
 x
X-Google-Smtp-Source: AGHT+IFQjIqPyEOKv8xWalwOwxsuCGQlqPv7NbrQhcjSlhCvUvsPHctVqPGMoXLd/AlTzfWPo6ywRA==
X-Received: by 2002:a17:902:6506:b0:1e2:1dda:262f with SMTP id
 b6-20020a170902650600b001e21dda262fmr3552634plk.32.1711751480562; 
 Fri, 29 Mar 2024 15:31:20 -0700 (PDT)
Received: from stoup.. (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 f8-20020a170902684800b001e09b636cafsm4000955pln.287.2024.03.29.15.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:31:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Sven Schnelle <svens@stackframe.org>
Subject: [PULL 04/18] target/hppa: Fix ADD/SUB trap on overflow for narrow mode
Date: Fri, 29 Mar 2024 12:30:57 -1000
Message-Id: <20240329223111.1735826-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240329223111.1735826-1-richard.henderson@linaro.org>
References: <20240329223111.1735826-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
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

From: Sven Schnelle <svens@stackframe.org>

Fixes: c53e401ed9ff ("target/hppa: Remove TARGET_REGISTER_BITS")
Signed-off-by: Sven Schnelle <svens@stackframe.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240321184228.611897-2-svens@stackframe.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/hppa/translate.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 2cb91956da..ceb739c54a 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -1126,6 +1126,9 @@ static void do_add(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_add_sv(ctx, dest, in1, in2);
         if (is_tsv) {
+            if (!d) {
+                tcg_gen_ext32s_i64(sv, sv);
+            }
             /* ??? Need to include overflow from shift.  */
             gen_helper_tsv(tcg_env, sv);
         }
@@ -1217,6 +1220,9 @@ static void do_sub(DisasContext *ctx, unsigned rt, TCGv_i64 in1,
     if (is_tsv || cond_need_sv(c)) {
         sv = do_sub_sv(ctx, dest, in1, in2);
         if (is_tsv) {
+            if (!d) {
+                tcg_gen_ext32s_i64(sv, sv);
+            }
             gen_helper_tsv(tcg_env, sv);
         }
     }
-- 
2.34.1


