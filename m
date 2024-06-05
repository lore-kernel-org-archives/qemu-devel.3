Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38731C27C65
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEydh-0001kC-Sb; Wed, 05 Jun 2024 17:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydg-0001jR-TF
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:48 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sEydf-0003qZ-Cj
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:57:48 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-702508bf0a9so240124b3a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717624666; x=1718229466; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s+cDoZ/Z/Fl9ZwgY0g7zYp6SY7qoD7tDcn18rcDzdj8=;
 b=LXr/qzz02fbLrothqC9lFHllvvJb3QK6oXL3d1ClwhqgL0QqsmI/F11YzR/n0W3k5f
 nu0sZpKYcKOqmTYhGfFufhNlRdkQIt0en+H5rELzr4DrbAiqozvH8VQBvCzbfn4r4BZQ
 8aoWSBTIkME+/l4tJyRPYhaf67mLDbF+IrVXCMtdETO9YRyIPvU+CaFwKtC5Vmp9DQmR
 GJ14QImyCJi1F7AeJ8vSJ3fR9ivZ1JkzvYDbfjz+d2vMJbQa6nl/oXzsI651qhs/540e
 qNcoHoKT3D0hzgdrlE12nFCk4MZVtsN2n6pWQ/PgWhBKkwrCXmEnCYuDVAFfN03rU2kj
 PCcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717624666; x=1718229466;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s+cDoZ/Z/Fl9ZwgY0g7zYp6SY7qoD7tDcn18rcDzdj8=;
 b=E4jrF5AsqM0ZzYot98KAyoG+3PFr2uZMB49zoQc+pnLAyvG/UsBSVRftgV4IfqIXCX
 YCFNLMlx0h8Rae5BMFKfzE21YuveoaH0dGnpiN3IcnVIiQtty8secoDtM1yeCXvM61zK
 c4XjWQDYLORHtTmVCTW07MehLWEmaXKv2De9LysN+UG+SsC3Wq+1HFLRH3cxVusBRfts
 c4bj1LYAfzSqlKunQOsIWV1Ur8+udNgYQtCerzrZv34teSxUsvHLVvtAqT/2GRqIgunx
 sPbJdoL5DiStsdedPp1fSvwrBwWyQzWd67SOHC2hlVEx+zNyJXvitMlEPoMBzSTNFEH0
 wQ7g==
X-Gm-Message-State: AOJu0YxP1NsOniSUYadOygGb8XQKTL0SuA+VODONX99i8l4BenmVLdGm
 iUafcdP+ET/9mTVtHxXMdVOhL2yEFKj1kF03dklSVlwJiP3MMi3fHiTknc3iBRxyIteZByxVx42
 a
X-Google-Smtp-Source: AGHT+IHe5RE+EwKTf6Ecni7Cr62sPe4PVsz/dZeyL58kcIPc3ScHUkjtxTHoZkX/fkFYGhQu1JSbZw==
X-Received: by 2002:a05:6a20:1015:b0:1b2:844a:eade with SMTP id
 adf61e73a8af0-1b2b71930c6mr3419358637.62.1717624665961; 
 Wed, 05 Jun 2024 14:57:45 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242b2ff9dsm9091509b3a.212.2024.06.05.14.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:57:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: [PATCH v2 05/10] target/s390x: Use gen_psw_addr_disp in save_link_info
Date: Wed,  5 Jun 2024 14:57:34 -0700
Message-Id: <20240605215739.4758-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605215739.4758-1-richard.henderson@linaro.org>
References: <20240605215739.4758-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Trivial but non-mechanical conversion away from pc_tmp.

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/tcg/translate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/s390x/tcg/translate.c b/target/s390x/tcg/translate.c
index 2d611da8af..2654c85a8e 100644
--- a/target/s390x/tcg/translate.c
+++ b/target/s390x/tcg/translate.c
@@ -1425,9 +1425,11 @@ static void save_link_info(DisasContext *s, DisasOps *o)
         return;
     }
     gen_op_calc_cc(s);
-    tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
-    tcg_gen_ori_i64(o->out, o->out, ((s->ilen / 2) << 30) | s->pc_tmp);
     t = tcg_temp_new_i64();
+    tcg_gen_andi_i64(o->out, o->out, 0xffffffff00000000ull);
+    gen_psw_addr_disp(s, t, s->ilen);
+    tcg_gen_or_i64(o->out, o->out, t);
+    tcg_gen_ori_i64(o->out, o->out, (s->ilen / 2) << 30);
     tcg_gen_shri_i64(t, psw_mask, 16);
     tcg_gen_andi_i64(t, t, 0x0f000000);
     tcg_gen_or_i64(o->out, o->out, t);
-- 
2.34.1


