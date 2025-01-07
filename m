Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49793E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XV-0000bD-8R; Tue, 07 Jan 2025 03:02:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Ww-0000Hd-OC
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:39 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wr-0002vO-E8
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:38 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2166360285dso224233065ad.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236892; x=1736841692; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5u4Ibf52eRhWFgpH6xfa3HuYglr832aTXzxwmfxNhbo=;
 b=m18ZFPaGbGkgIo8XDHck1f8Dzr257h0iWQqXC3e1KduoyWLIK8l7gdLya1a76KpBLg
 YhTFL5X+mj0h21Oyx/lpwB5SNqK4yoX+Z1hv7XchggaamEkhJ8GIJd93fJVmh6iCYQKW
 QsvuVAszvRdSegEYib+FEkh82cDzUAphOV0O9STgpxW6SlyPROWgdTn9QkzdMKX4E22t
 SP0U1JTjkBHXZukEbI5V7741N+o23DXBEFeF4JHnZ/0YDoZa7OfaCa/Udd11QnCapFek
 n7EZRfdpF2Bozyfa9td/53izxcJZkqB31JYiB6G4fn8hhKBrVFhvqGBDMngeYB2ScvI9
 U6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236892; x=1736841692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5u4Ibf52eRhWFgpH6xfa3HuYglr832aTXzxwmfxNhbo=;
 b=e2zvCdASVOKSxM4QyOUi5YRDzKPHAzukRXOk9/tg1n0zr2gB1uLYwQW8SmL4Nfk0pE
 63isCDdaDKGjaURY+AtooC473ysVVAiyc0omeNMtfrEnvJPaKcHxrn0ObvoMsM/X8Y0v
 0qM0aY3+az5yy7K2UD+hzXGH/fRe8YwDU1WtHFOrg3KztBxk/3S0ZoUAc6AGZKusOyl6
 Gyuw7+/80rznOr2RNb+Z9whbhSsB+qsFz/ZDl+MkxqaJX3VDxi8ta7QdoGyOSu4kLPrl
 8wly+g0Qm9/5vbRASFkdEOVS/YGh4MpRos1MjT+8HGKeTP53aUUt4MvEKy7m4Yjnx5tf
 QqVQ==
X-Gm-Message-State: AOJu0YzTr+4sDtPTHizjoTqsgdyUvr3ayKhG5IgNlesSDOMaMro0ULea
 UST0APVWOxxatjliqcUsI4e04deQ71R0CokBzNNqBCLYV4/YNVKJlJnbigFGH+gs5pCqWB+7ZK1
 F
X-Gm-Gg: ASbGncsvMUYvELctb/T/4EYtSwJ86FkNdYkBUDjbilcECsbcjBwqlZqRQcHZ2Szo7I7
 YaszBrJegEaDzL/F9q/aYkEA4ZnyFN1c9u6WQACyk3IYk5yYYF54Xa8ojhIwcb7EqKpLMjHBbVe
 iTr/Zah40QBhNIC09tqd2Kygymbq50Xd4dfa9HhV3jYDZOaUOeKMHQ2sxZZfSd7uOGg2os98zHD
 jSzGrdMBCpojGkAoGpmxLan+QBViUoD1yzBu2Th8Cjw2xTJbFIXACivJQ7Z6Hz2RPk10k0VOrvd
 /IWh+H9V6fyoIM+97g==
X-Google-Smtp-Source: AGHT+IGA1TPy+Cw90ZLCJ7Lt7esSSeQsUqfj9jSdbnfaVcfnAq3IQPI/GtougKHyAgaQav0IknG8Xg==
X-Received: by 2002:a17:902:d2cc:b0:216:70b6:8723 with SMTP id
 d9443c01a7336-219e6f1090dmr836535395ad.44.1736236892134; 
 Tue, 07 Jan 2025 00:01:32 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 17/81] tcg: Move fallback tcg_can_emit_vec_op out of line
Date: Tue,  7 Jan 2025 00:00:08 -0800
Message-ID: <20250107080112.1175095-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

Don't reference TCG_TARGET_MAYBE_vec in a public header.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h | 7 -------
 tcg/tcg.c         | 4 ++++
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index 041c4aa455..57f5fda109 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -1020,17 +1020,10 @@ extern tcg_prologue_fn *tcg_qemu_tb_exec;
 
 void tcg_register_jit(const void *buf, size_t buf_size);
 
-#if TCG_TARGET_MAYBE_vec
 /* Return zero if the tuple (opc, type, vece) is unsupportable;
    return > 0 if it is directly supportable;
    return < 0 if we must call tcg_expand_vec_op.  */
 int tcg_can_emit_vec_op(TCGOpcode, TCGType, unsigned);
-#else
-static inline int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)
-{
-    return 0;
-}
-#endif
 
 /* Expand the tuple (opc, type, vece) on the given arguments.  */
 void tcg_expand_vec_op(TCGOpcode, TCGType, unsigned, TCGArg, ...);
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 7f5d014973..505e43c128 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -170,6 +170,10 @@ static inline void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
 {
     g_assert_not_reached();
 }
+int tcg_can_emit_vec_op(TCGOpcode o, TCGType t, unsigned ve)
+{
+    return 0;
+}
 #endif
 static void tcg_out_st(TCGContext *s, TCGType type, TCGReg arg, TCGReg arg1,
                        intptr_t arg2);
-- 
2.43.0


