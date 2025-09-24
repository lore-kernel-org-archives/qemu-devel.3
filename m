Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7817CAC5A5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 19:05:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1UnN-0007sx-I3; Wed, 24 Sep 2025 15:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Uly-0006wF-1f
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:29 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1Ujz-0007tI-Mo
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 15:03:24 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-77f38a9de0bso214652b3a.0
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758740482; x=1759345282; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vltAWZSqvesV3ZE5+hWwklFe75NLCLedOuJYJPed2R8=;
 b=lfXryQ9VdT5e4OKfvlubYGLuSFZ8B+OfrKHthWqFRH3deg3HHBOCcLoLIuWwX7/pgN
 8OhVM0UuCzqW0KbNXeJxg0rj4Bumq26VMCuAPievbIF8JiCsa+HbyXLyQMfJc4lz0c1V
 piVWLJZT1sFQW5RYbP4h3Q5etKOtX26ATItxTMZhZn0fB4rSOeHdizYDROOTop38Ss0x
 5P5eCZk786NYJBfIW9gg7kEJrziX7uru9DarRB8i+izbnyvEg1GvyRBzbW2F5lwU1QKZ
 cZNxh/jFK/TmDiwYdSJmlSB9Os8RG18BhybOYXm1RBSck424yMliNxsiKrTBAK8Qnwhb
 cmCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758740482; x=1759345282;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vltAWZSqvesV3ZE5+hWwklFe75NLCLedOuJYJPed2R8=;
 b=PiKUJw7JlMYJwKy5lEjG0jr39d9V/NOlGbckynkK7hLA04IM8IX9ZRGatTApDpt6H1
 8iryvCyvNP4OPhIDlJHJYolAM5PAo7q8cBR/e6IYz5scRch8msBzM4jc9TBdI0IA1RtF
 NAODjpGtCNWSU2okC/zd7VCHhCqOSoXJux+uHk6FSl3cwo5pkJfFoSsECJKoQCXHN09A
 hdp81Zub/aBVejGhX8yyQt8DqxPTrxm6+TW0Ms/sisCwO93g/whc+U7oAezkYb82hJuX
 hvBb6XbBqV5Or9f7RJzyu9JjCHkZEcWZGzDexztymeYLeOF/qw3nVmVbLSfpzCZTsa41
 aCCQ==
X-Gm-Message-State: AOJu0YwW06yFt2EPOPAWnrL1CQHXDsgr6qtA8fiEQ5UEc/zY12jTGQs+
 /l4tggClYg/SpcX4lzKQSAw+8hQHnNszPPcpRcd0MRJx/QR2OgQUNXnkGV9k9mSr0CfyxyQn5NM
 gY2M3
X-Gm-Gg: ASbGnctKhDGZvRctYuKX5zipqmEbGBZqpPpC+xAwrtWIsuNuMQQOe3DHnKR0bYl8K+v
 iu4JEQboWrTD3QMw0isqZ9o3Y1w3q0NDoM+UJPLptj/eTrcebmoOCzikv4BZCUwvpvc7zeatGO1
 Uwev584BVUzH2YHDM4vAH2kMwQZl88NW03Y0FqZeAflyprUjo761ae0u7hlqgFTNgN7CpKpbKQh
 iFPK/4LsdPWlI7VxhztPyLvOhagbh5qdrGtdcJN2L934OSZUsASTQOQnayVIQZ01OBeGOXWE6Rj
 c7NIBIM0Zbux1TijGcTcytoeAxaEUuLo818QSqhewQImfhL+PbsNPO+ZP6EzRTYSp6HdE5wpyOh
 Ec/6eCrWpN++E78HMYNUfaT9Truon
X-Google-Smtp-Source: AGHT+IEXqN87d40gqw1SuokRexTIT2BhOh/CnniN/YmapQOj3QM8LvDaxhgJVYLGTzafwAQ1uxI0ug==
X-Received: by 2002:a17:90b:4d0a:b0:32e:a54a:be53 with SMTP id
 98e67ed59e1d1-3342a2608eamr688704a91.16.1758740481810; 
 Wed, 24 Sep 2025 12:01:21 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33439103461sm63221a91.8.2025.09.24.12.01.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 12:01:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?=E6=9D=8E=E5=A8=81=E5=A8=81?= <liweiwei@kubuds.cn>,
 Anton Johansson <anjo@rev.ng>
Subject: [PULL 19/32] accel/tcg: Properly unlink a TB linked to itself
Date: Wed, 24 Sep 2025 12:00:52 -0700
Message-ID: <20250924190106.7089-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250924190106.7089-1-richard.henderson@linaro.org>
References: <20250924190106.7089-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

When we remove dest from orig's links, we lose the link
that we rely on later to reset links.  This can lead to
failure to release from spinlock with self-modifying code.

Cc: qemu-stable@nongnu.org
Reported-by: 李威威 <liweiwei@kubuds.cn>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Tested-by: Anton Johansson <anjo@rev.ng>
---
 accel/tcg/tb-maint.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/accel/tcg/tb-maint.c b/accel/tcg/tb-maint.c
index 0048316f99..e6d45c9c12 100644
--- a/accel/tcg/tb-maint.c
+++ b/accel/tcg/tb-maint.c
@@ -836,6 +836,14 @@ static inline void tb_remove_from_jmp_list(TranslationBlock *orig, int n_orig)
      * We first acquired the lock, and since the destination pointer matches,
      * we know for sure that @orig is in the jmp list.
      */
+    if (dest == orig) {
+        /*
+         * In the case of a TB that links to itself, removing the entry
+         * from the list means that it won't be present later during
+         * tb_jmp_unlink -- unlink now.
+         */
+        tb_reset_jump(orig, n_orig);
+    }
     pprev = &dest->jmp_list_head;
     TB_FOR_EACH_JMP(dest, tb, n) {
         if (tb == orig && n == n_orig) {
-- 
2.43.0


