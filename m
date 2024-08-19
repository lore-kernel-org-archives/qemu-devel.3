Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C547EC5321D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 22:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgBGH-0008LZ-Ap; Mon, 19 Aug 2024 18:54:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEm-0001er-SW
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:37 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sgBEl-0000lV-0M
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 18:52:32 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3718e416297so2192366f8f.2
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 15:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724107949; x=1724712749; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLodpe9emd/ELJf5C6nKnsNO7KrpM2yyxOGgNuXlJKo=;
 b=HuP6PAhQ1CEo2lALJ/3qCnOhQoiX47grui/E/8RmnJf6VZtYK5UwyMVyRp7TdFy5M2
 MWRtC60+dy0hfpqHVDd71M1y/SvjDK8TiZDg7lkRfERcqJeVxoCd/lNyWhSJWJ8uEVFe
 kzveIRb1h2JR0QB236FDJenNdi4HgeqAlWVV6cbWnYlm0FIiaeOugGftyoe7dXIO07BC
 bYI8/l/nwfMlV+i8Um8QcrFjkIZ4LLiXk7a/Syhc+Dh6XR31BY1YUzttOuppYXegStm1
 HHvskCIpysMjKyBBApdHHhgzYNWlEzDlKsmMFRjljOvzvNs11Cu9bDlDNeTT9jqwb9dr
 Rw/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724107949; x=1724712749;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLodpe9emd/ELJf5C6nKnsNO7KrpM2yyxOGgNuXlJKo=;
 b=jX/Ux8ilF6+gl8dHgzJYPFfNT0EHa8lpbjHr3dmVWKuFfG/s3dSIKQMm66QoI81mpN
 ftDnkmmAXEK0vOzMouKbSZ4KtZZnpnCBok0morbNTcpPmTRSMEjLlmNAOBZ+aEuwUOaR
 Xq1avN8RHAJGt71DZqnQfbx6RH46H1HvC3fLfO9PgAcvTqAKC8J6NTHDKHtgP+LLrDix
 slMg8KmnQ9KbdOU+BH/JDPtrq51zUoeqKskgUPQjP2yuTofDBwUICSmY9ikOM6pyk+/F
 J2w1YgzUH8eQg7Nji4iGNKgo+sSwIux2GyAEl6BPw6zz2QtYVTyM4c3SVSKCN372444d
 ULPA==
X-Gm-Message-State: AOJu0YyWRGyMkAePi6P3s6NYNakjjid80TPHVra7VJO+24I1g0uA/igq
 6AMc8v2n7VT+8lknJRwrsSGj7IYz4OS8mBfKBJTDAAjv//RVLWiD0Papa3leyBG3x5jzRchSXqB
 SHkQ=
X-Google-Smtp-Source: AGHT+IH4QyNjHxSTCswrtiCsxg78C4gM8AFwE1pH3jIjZI4n+euGbm6aoq/O6alaOdiudfXfh1rp/Q==
X-Received: by 2002:a05:6000:1112:b0:371:728e:d000 with SMTP id
 ffacd0b85a97d-3719431768fmr7207896f8f.1.1724107948725; 
 Mon, 19 Aug 2024 15:52:28 -0700 (PDT)
Received: from localhost.localdomain (88-178-97-237.subs.proxad.net.
 [88.178.97.237]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371aa455abesm7173818f8f.111.2024.08.19.15.52.27
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Aug 2024 15:52:28 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 15/20] contrib/plugins/execlog: Fix shadowed declaration warning
Date: Tue, 20 Aug 2024 00:51:11 +0200
Message-ID: <20240819225116.17928-16-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240819225116.17928-1-philmd@linaro.org>
References: <20240819225116.17928-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Found on debian stable.

../contrib/plugins/execlog.c: In function ‘vcpu_tb_trans’:
../contrib/plugins/execlog.c:236:22: error: declaration of ‘n’ shadows a previous local [-Werror=shadow=local]
  236 |             for (int n = 0; n < all_reg_names->len; n++) {
      |                      ^
../contrib/plugins/execlog.c:184:12: note: shadowed declaration is here
  184 |     size_t n = qemu_plugin_tb_n_insns(tb);
      |

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240814233645.944327-2-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 contrib/plugins/execlog.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 1c1601cc0b..d67d010761 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -181,8 +181,8 @@ static void vcpu_tb_trans(qemu_plugin_id_t id, struct qemu_plugin_tb *tb)
     bool check_regs_this = rmatches;
     bool check_regs_next = false;
 
-    size_t n = qemu_plugin_tb_n_insns(tb);
-    for (size_t i = 0; i < n; i++) {
+    size_t n_insns = qemu_plugin_tb_n_insns(tb);
+    for (size_t i = 0; i < n_insns; i++) {
         char *insn_disas;
         uint64_t insn_vaddr;
 
-- 
2.45.2


