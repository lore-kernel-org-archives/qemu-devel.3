Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E31F433CD
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 21:57:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD8Di-0002S2-5a; Wed, 15 Apr 2026 17:56:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8Dd-0002OS-Tm
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:56:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wD8Db-0002me-7n
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 17:56:21 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-48374014a77so96838505e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 14:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776290176; x=1776894976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J61p27Quk4EZorcOVqxk0jX5dP0dgc/X3RVLAwpYOiA=;
 b=kpInVKQGAMeTNalefhpPzZAscPAh/ks+gblWUXCFG1YP97XLsf2INUBFOVR5sgEXCA
 c+HxmMNDNasWdtHAC7eK92y23t5H7UHjQeRaJYGczoxL8qvnHNcXS1CSuJ0LB/4l2txO
 zcYG0X30Q4v6mUXvlK+bsR5CJ6nc4YI28fvgcsuosgaxV7hC8Kwpg8uZD96WpG1/w2P7
 01P/6Jql6Zil/MurgeQYn7g9nvkqbzzJQD6d6Gt1oOh6Bowqoi+eP5q3UmkAdwFOxfBR
 ekscZO70tDNooZi9fhbCyjZwSPKwawIJ9TSYSms8HOJImT5i55vhr3zxblEnV8AKHTEq
 r98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776290176; x=1776894976;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J61p27Quk4EZorcOVqxk0jX5dP0dgc/X3RVLAwpYOiA=;
 b=f1nIyzEDARbqIYdB0lsnDhzi0ACbQbogHCZVu1+mCgITjJTdWqtXDgrTGFBMYUS7G2
 LfZaOXMfHAhL2r+lTDJoJO1y+zrRMza/iPGfBbTnHSIaeh1z2dV+nH2toDHFSNGz7EFi
 ex/Sr1+7AOnY9j0Kflx+q55VLN3gDCxDqfi6U0zo6cJJr/Mq9Sxls5qcWUClel+Ry0hx
 e+glyBPSZxssrRVtyVzCSryhDBeVOtoSnOatjbooA8bKjIQWCn23drfEfSy7cOUEJ1AX
 5nkMy3z1BNthfn1Hxw9ETUnMYzgtHmAlXLxm++xY39Zzt555Q6137HN61fbwCtACMK20
 s5vQ==
X-Gm-Message-State: AOJu0Yw+BZ289YPDjcFS8f4la1q7ijBm/5jNxnmKAUiSR+1DgxPApJF/
 tsfVBC74IclgmW7V16aNChZZCwH7uaHkyYMZYe/S0nJcLmMkFZVJyHnjnjdsphxqmprHHFFrZgo
 Me6PPCeU=
X-Gm-Gg: AeBDieuPn4AlqFFhmDBv075p5rbH5byGFgpGTI3SVj1HwpYdz/AgJ487KRjruCVFFbF
 u3wDvBiY44ctgayr/9/1bbq0K1v8xjiXd5SuTdo8ZJaZyzmllhdKa+dHoVuLJjpVeGSam9hsjEH
 2uSiL3CNYQeowC/iNI88+iIcDYxG1wFXsj42N6GkZJ4O91uFKZH7Y9HJgXWln+qsUdvuiM41ux+
 B7/WULLl/PVawnQIS9AGPp1n2WlriALKTMrF5Cs1ZEThcRGwlvYXP3jwyvwvxaHz2EMVIDcvGAw
 R1LS5aaK1N0HnMm/K7fl/GUBRVfiFbDb/iQZ0XJJCRHGEt3kVASIClATlMOF7FcXb6jGqvhWzgJ
 Zcb4ShQCHQdKHR+xF40+L807vuU4iMMIVsWov7C/ZBm/MmYLS1qmgNpE14Z+W3yW8DkzhbHQmao
 JP7KR7ih7FX1RrXGZRFEA5aIDj02brqXay5gdNzbaZsrl5WWNS8xZEJuc37UmNOD1L97KcnLMO
X-Received: by 2002:a05:600c:a105:b0:486:d76c:fa57 with SMTP id
 5b1f17b1804b1-488d685b75emr226950265e9.17.1776290175874; 
 Wed, 15 Apr 2026 14:56:15 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488f5818da1sm651695e9.6.2026.04.15.14.56.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Apr 2026 14:56:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-s390x@nongnu.org, qemu-riscv@nongnu.org,
 qemu-block@nongnu.org
Subject: [PATCH 5/8] cocci: Do not initialize variable used by
 RAMBLOCK_FOREACH* macro
Date: Wed, 15 Apr 2026 23:55:36 +0200
Message-ID: <20260415215539.92629-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415215539.92629-1-philmd@linaro.org>
References: <20260415215539.92629-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

The RAMBLOCK_FOREACH_MIGRATABLE() macro, defined in
migration/ram.h, ends up calling QLIST_FOREACH_RCU()
which always assigns its iterator variable when entering
the loop. Remove the pointless and possibly misleading
assignment.

Mechanical patch using the following coccinelle spatch:

  @@
  type T;
  identifier e;
  iterator FOREACH_MACRO =~ ".*_FOREACH.*";
  statement S;
  @@
  -    T *e = ...;
  +    T *e;
       ... when != e
       FOREACH_MACRO(e, ...) S

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 migration/dirtyrate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
index 58f04670629..b360f49efea 100644
--- a/migration/dirtyrate.c
+++ b/migration/dirtyrate.c
@@ -485,7 +485,7 @@ static bool record_ramblock_hash_info(struct RamblockDirtyInfo **block_dinfo,
 {
     struct RamblockDirtyInfo *info = NULL;
     struct RamblockDirtyInfo *dinfo = NULL;
-    RAMBlock *block = NULL;
+    RAMBlock *block;
     int total_count = 0;
     int index = 0;
     bool ret = false;
@@ -568,7 +568,7 @@ static bool compare_page_hash_info(struct RamblockDirtyInfo *info,
                                   int block_count)
 {
     struct RamblockDirtyInfo *block_dinfo = NULL;
-    RAMBlock *block = NULL;
+    RAMBlock *block;
 
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
         if (skip_sample_ramblock(block)) {
-- 
2.53.0


