Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9605EC369D7
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:45:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JMG-0001b1-EU; Tue, 22 Apr 2025 15:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLV-000072-SH
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JLT-0006aj-39
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:31:53 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2264aefc45dso90085445ad.0
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350309; x=1745955109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5QmVx49VUNvE0VebpWYF9vpR8W6QUfLccSgTbYDwMAs=;
 b=XTjFjOYrF0TTEUtMXqSPdyV5MatrWTtbyNyrm0zpaqKzFNJ5Hw7DRRKZUCSUrDhW9t
 gEjuCDh7C5CAKSs4sA1Txlq9Oyib8bjBJnrB8h4/5Zsm9LE9byF1Ng0jb/mJdEwgE3rn
 c/TYF3sQ+TxGMNzVBgSw3lpqWyuQBBCcZdEKQCqjWA7+EXAJSBvBLjBT4TlUN/t/Noit
 /8skuSX+AEaptKnDFkQOWRBYrOt6cQobIzeZqvlhGKBKh/XwKCkYMdBVPaP840CnA30a
 IeJn9zkKe9vb/QXpXc168lwgPM2bWt/zJbn/VF5h5WLtlW5MB9Wo4f5g235it6ugkkcT
 mCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350309; x=1745955109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5QmVx49VUNvE0VebpWYF9vpR8W6QUfLccSgTbYDwMAs=;
 b=ntBMrXzo5xB3bBfBgEp3uaQ0wL2j1avi7HD99S+Ibk+ZpYUox8TFURQJ8sIuLuquvR
 s+4SUsDMezJ7f0pevEnzeue+W54nhljT0m9olB6xhvEEpm02YZMZcZeKC/Uqc37zWfqM
 xjZgQZ+CsWZW6w8lP2Oz2XF78PT04cUl+nzggJCkJOyzMpiHiaXsHbY8JU3RK3tHpXhP
 WTl+bfj5q2LR5kyM6HlUzJ7e/zSXb1gIW0t0H68oXyN1aTQFxHWqCKcAdBov6YuTyzNF
 NeDQW2DX8zR1MLaS9BwJ1ucKdPacPRnEGSNMmbbR5Bt2ZygWice2DSUtJyMWOX7IkO6M
 UAgw==
X-Gm-Message-State: AOJu0YzpVmRZrysMZVhjlO/18bG3GE+F3FS9TtYRJ+SSdM0iPPLQfwcU
 rOBocPRf+5sfujGv7zp5j2rKgJyZQuYATay4/9ZPf+Pkg0WC199i7tHeL9Ekz7faaVViJwf8o0p
 4
X-Gm-Gg: ASbGncuL54vU02xTGtL7bOQuy2K4JTflCNlyRp4doIF9bdLtp0sBT21sITdIMz+3xuk
 1qWrpNk+rt0W65xVZ07csW6Ggxw6fkixmG5doe5rkobtImze2cUF7Fm6Wrju4Mc0QNRGgLr++pJ
 Lqs4aX8wAEIKGUrepHC243td6qBrCjrELycLwgRscc0UHbexIuPjk58XqHyQEdMCGNUYpefglRx
 HgPrEIH1z6uC7vWkzLnxj4++8FeH5TKKqH7FZwqQ3EktlGLUkcBSbZuzVHue60teykr5kmuBu4b
 NH6Bp5dk/3Lxs6p4zwAPG6euf65fkh/KpENC8GZmuEts95lea05KteXmWHNbUtd6HVA+aRS6Vl9
 9PX+oARKbMQ==
X-Google-Smtp-Source: AGHT+IHgIlU2jOE1JIp3ZgCabMdGT83i/Iv7dsXOgmBGXqZTvuAYzSjmy6AMP6gg5Z7iatqQjzV3jw==
X-Received: by 2002:a17:903:40cc:b0:223:5c33:56b4 with SMTP id
 d9443c01a7336-22c53583807mr215595545ad.20.1745350309537; 
 Tue, 22 Apr 2025 12:31:49 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bdda3bsm89312635ad.27.2025.04.22.12.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:31:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 043/147] accel/tcg: Use libuser_ss and libsystem_ss
Date: Tue, 22 Apr 2025 12:26:32 -0700
Message-ID: <20250422192819.302784-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

While some of these files are built exactly once, due
to being in only libuser_ss or libsystem_ss, some of
the includes that they depend on require CONFIG_USER_ONLY.
So make use of the common infrastructure to allow that.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 185830d0f5..72d4acfe5e 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -1,12 +1,21 @@
-common_ss.add(when: 'CONFIG_TCG', if_true: files(
+if not get_option('tcg').allowed()
+   subdir_done()
+endif
+
+tcg_ss = ss.source_set()
+
+tcg_ss.add(files(
   'cpu-exec-common.c',
   'tcg-runtime.c',
   'tcg-runtime-gvec.c',
 ))
 if get_option('plugins')
-  common_ss.add(when: 'CONFIG_TCG', if_true: files('plugin-gen.c'))
+  tcg_ss.add(files('plugin-gen.c'))
 endif
 
+libuser_ss.add_all(tcg_ss)
+libsystem_ss.add_all(tcg_ss)
+
 tcg_specific_ss = ss.source_set()
 tcg_specific_ss.add(files(
   'tcg-all.c',
@@ -22,11 +31,11 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
 ))
 
-user_ss.add(when: ['CONFIG_TCG'], if_true: files(
+libuser_ss.add(files(
   'user-exec-stub.c',
 ))
 
-system_ss.add(when: ['CONFIG_TCG'], if_true: files(
+libsystem_ss.add(files(
   'icount-common.c',
   'monitor.c',
   'tcg-accel-ops.c',
-- 
2.43.0


