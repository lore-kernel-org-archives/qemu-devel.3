Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE54BCCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 10:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFsAu-0001fj-6d; Mon, 03 Nov 2025 05:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFsAs-0001fM-6c
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:52:34 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vFsAn-0002Vn-7f
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 05:52:33 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso1355119f8f.1
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 02:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762167143; x=1762771943; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gu1x2Jvo2cxOYeIuXySnlCfrmNhzmsl8WxpirL+tZl8=;
 b=Av+jWS6jcQJtLLI+RB9SwMdA4yAsJQiWRPgYXkAVF4DdC8VoEgOOrGfxYr6Ru3tiAD
 hd5vGKDVDDaFTMPNglu9zY7ADndN1/m8kPqbP2PffzwKiZKuF+KmVUtZmYUsRAdtoFs/
 dKKiuJ+q+CpsLqZ6fhwWajOmFAYN8dzb6NQzsClabQLoiGCkz+TTqT+A+R0ylswhVRDJ
 fzbo+U5uKRprsMjKIn8VFJQMeHMFhKzrPvRL6qqDyl3hQh/5AXeMdtOFJstNvG/DmWtv
 QylzozbwF5Z9GuAjzbSZlr186WGpZc96/XuIV/GUD44k3Tb3zRVtelm79VPyIwv7vNW9
 0EBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762167143; x=1762771943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gu1x2Jvo2cxOYeIuXySnlCfrmNhzmsl8WxpirL+tZl8=;
 b=NnoPO+EogFz+CKbTLWGRmaaKLTuiFK1mSgKRokWWQ7ckTYFWERzeHC8gzESL5bL8zj
 PMUZDEjYBU9IK+ZHnwIHeAWjJQdieceIzHP96WbpZA+v8gaUzwz9SSzQcNDfFKzI17CI
 I43EhhHUFe2mDsRqMywLkX0cndLbkv3hREGKiK26c5K176l0qnMJEBQqJv9qN5blEVcO
 vFHkhgJmiHf3LapwTMLByz7cP7qWtiCcwbnnFiORG71RVJqdXr/p+26fQnucpUpELf6L
 sGkv7fAzS/QEy5X9pKBfxRx1kM4oyfqnNte6/scgle+HRoBL3Ln9dnJBJ1hwNdImUSxK
 6+MQ==
X-Gm-Message-State: AOJu0YzmMR0hk7pioQioFeg7Uj5pCwtIKc5nnOwPnM2lmx3dkdSOaYES
 PDVrCLLeqRaZ8wh+AkQfNCRqLAls0f5XYkN7QPgZwoYrY/kWB9xpW0V73MibRkCU1vcgjSL9WvH
 gaBOUzyX76nlO
X-Gm-Gg: ASbGncv4l05onyWzR8sp1v3UhjBU5o3bKiOML0QcuWCpyh6wIt6RUoT1DLaZ8KVylML
 uquW9S574vrfcyQQxyn8/8waqwaoCyS6G5aXLv90fAM9SZ3pnz1EmeAnxTAmWdkm4TIFZLDutBG
 czsBiQ6vy72PvtxfXkD7ekSAw/NNokrFHGYWmWfxyQY9vRcAFO4z66rmLtN6T65W54/dpDKGHSa
 wzevZWZTHaw3olhWuUpU9cUMs6o2WSs3qb1anJXgGVWiqf5KY4Haekik3hEqT5FQwvDnwPUSP4E
 QiV4sf7NF2fZTTvmLREy6qRYOmzH2adTDFiBFomDnM9fdTqDLZmEkLtwE0z02IotuQc+ZKRhr8T
 jirVVTen7Vtuf3ZWqnYC8LwquW4JEWWdxOM2kUuVdqGgWwUKWGebNOWobQuG2n16POb9m0NoxG9
 KZ02aV/XvSCG0jQT05uTmR9iaM1EIiwZmcUmE8r/yEbyvZUeEA3T+ZjwuBH2KOC4DJ8/K3EQ==
X-Google-Smtp-Source: AGHT+IGnFhlkhUanAo8VERPEGec32NWhEKhShTS7RpNGOJHeZ6Er/vmAAuaOykCNOOtmUnTso766JA==
X-Received: by 2002:a5d:5d85:0:b0:429:bb77:5deb with SMTP id
 ffacd0b85a97d-429bb775fa9mr12350902f8f.31.1762167142789; 
 Mon, 03 Nov 2025 02:52:22 -0800 (PST)
Received: from localhost.localdomain (ip-185-104-138-122.ptr.icomera.net.
 [185.104.138.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4773c48daa0sm151530555e9.3.2025.11.03.02.52.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 03 Nov 2025 02:52:22 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] osdep: Cache getpagesize() call in
 qemu_real_host_page_size()
Date: Mon,  3 Nov 2025 11:51:10 +0100
Message-ID: <20251103105111.68294-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103105111.68294-1-philmd@linaro.org>
References: <20251103105111.68294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

Since we can not know whether a libc implementation of
getpagesize() calls syscalls -- potentially slow --, but
we know the host page size won't change during runtime,
we can cache its value.

Reported-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 util/osdep.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/util/osdep.c b/util/osdep.c
index 44fad13dcc7..9b50d00dbda 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -616,5 +616,11 @@ int qemu_fdatasync(int fd)
 
 uintptr_t qemu_real_host_page_size(void)
 {
-    return getpagesize();
+    static uintptr_t real_host_page_size;
+
+    if (!real_host_page_size) {
+        real_host_page_size = getpagesize();
+    }
+
+    return real_host_page_size;
 }
-- 
2.51.0


