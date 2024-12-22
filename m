Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BE1EE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 16:31:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPOpW-0005L5-62; Sun, 22 Dec 2024 11:29:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoa-0004xY-3Z
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:24 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tPOoX-0003jr-5x
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 11:28:22 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-725abf74334so2918551b3a.3
 for <qemu-devel@nongnu.org>; Sun, 22 Dec 2024 08:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734884900; x=1735489700; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OyI7W7fnkDxR10eAmkTI0DbupaxplDdtdBvj4WSj0sQ=;
 b=H5k795EQlwdYr9CSkQr/eFB+MFwSUDgKT5y2g1ZpgteeA5tQ+LyNGulgC2wPfr81nc
 dQusNauNnMgkft+Xm8BHxg+oSorTjwmC7ArDwGXNCnnpCvZ/VFH4WqsGL7punvYA6vqo
 wd9JFRL4K8LJ1EKdhMJ7wDOu5/mV5AdioAcL2A1DH93SzODF15NIujehVDa4Pq/6xWHo
 OZ0WXzdUqQnGhPn4cCBzjLgnqaY3lajlRnd07zcDPkHC3YRle6ShID+MW662O4fJ/rl7
 RKjTqijH9EwfEGlK9PSKK4E08HDkQgEEj6/9DG4XcWbYkpWAQqUwDKQo6MSsa730PITU
 Zt+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734884900; x=1735489700;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OyI7W7fnkDxR10eAmkTI0DbupaxplDdtdBvj4WSj0sQ=;
 b=DNDTXwYnhCBi0YeOeRyQb3HXbH+ryXkgaCJTNGeny7aywjndxZWpkxZhVhuXtTysJu
 98JtYun2UMxVSDDtvwnVXvBQ8mh/ZF2a+jt80IrMuEcIAtcUUAgR63uGU/AxF8P8cTke
 TEDh7XdFYdVCboTXSgpdi39I5Zv+eWEbtd6dAONYgmOmNG8YWsf4btPKmTCyJ6wlfkEL
 J1d1eSEpO+Wcc1Ejwe7M5oRs3Iyn3jaNG11PbKhV0AdhZDfdFQ3JweuLZaJTXU2VTdd7
 9OJhJrNovhY130L6ddsPi1MSrVpEJtm1EgiA7McKfvvrlRtmR8jczckNkMOoQtLdfjqE
 kXuw==
X-Gm-Message-State: AOJu0YyWFO5idDAgPpve7grWJLVrmJJUOfFV0mrc7PM9lhFkR/OlZBdx
 zOpBfuxH9B7z2kzBC1vbDrOWOMnwaK8vo/OM+IvjXb55yCMYVxj/dC0jVJ3f9KKNMDfGhOWhVf9
 BgOc=
X-Gm-Gg: ASbGnctCyOyFXrgE97grdYQVkinBmR+uws4jnS6JPCJ/axVpdX/jo9wPNTYFaqqZ17v
 lU2Mena//t87IqQe7bWzzuSM0XXPWZOOTd3M79Tv8uoYe5RnEHo+O1a7eTtiGNPFLXikugInMBX
 j9XKLlHbWju14ijTaddFsycYRiL58u/cNmkl2lYFMeyNoFuU2mV06x2pSkrvCd/FKdU+IRTWdo9
 1qGgFsAXBWNvQPdINuMC9sDwobtJen2hsZwPoxNlu43SD47q7w/+UJI2wegI50=
X-Google-Smtp-Source: AGHT+IE1NT1qm6O78znsSQwxVHaUoPmHIkxoWPVnkN/JZlPK4TM42sq7jFHcHvBw0FaM6rjlhMjS8A==
X-Received: by 2002:a05:6a00:1809:b0:724:f8d4:2b6e with SMTP id
 d2e1a72fcca58-72abdd2ec01mr14669158b3a.4.1734884899898; 
 Sun, 22 Dec 2024 08:28:19 -0800 (PST)
Received: from stoup.. ([71.212.144.252]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-842dcaca43bsm5848808a12.66.2024.12.22.08.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Dec 2024 08:28:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 47/51] tcg/optimize: Use finish_folding as default in
 tcg_optimize
Date: Sun, 22 Dec 2024 08:24:42 -0800
Message-ID: <20241222162446.2415717-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241222162446.2415717-1-richard.henderson@linaro.org>
References: <20241222162446.2415717-1-richard.henderson@linaro.org>
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

All non-default cases now finish folding within each function.
Do the same with the default case and assert it is done after.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index 3bb208d6e9..7481b59d59 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -3079,11 +3079,9 @@ void tcg_optimize(TCGContext *s)
             done = true;
             break;
         default:
+            done = finish_folding(&ctx, op);
             break;
         }
-
-        if (!done) {
-            finish_folding(&ctx, op);
-        }
+        tcg_debug_assert(done);
     }
 }
-- 
2.43.0


