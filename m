Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8CF5C3DA5D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:11:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTme9-0005ix-9n; Tue, 16 Jul 2024 14:11:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdo-0003Uy-Qf
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:11:11 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmdc-0001Ke-Qs
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:11:01 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-426717a2d12so133635e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153455; x=1721758255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AsnfcUgakDS94yBAG2Ho01nyvEXdce5IphgHAtL+bDo=;
 b=jQ/J/e57ZkWb2u+iznDsi7Hwza7A0P1ONiJoEL4NOXtEdv+/RkhgUoKndP43vRNjwY
 club/9CJGHVfZ+O0tTU9LMG6MaCI8RGLbGsr6NH07j3IqR57eAprqelv5mzEB3hhK7vX
 wkcVRkfC+s2Tbh8/y4uHvjfF9CNHyCYtU3rBvSpkfFYzkLo0+j0Ab/+CLI09PWLiup+/
 bjJLcKRXrBBDASxSVctJOKOsann/2uubKWc9GULJ2dc2D3h8V9Dl3nKUs7sjcR5Lx84E
 9eR5R0vKo/GJ0iDpoo74/CSARMFzoBJ3XsqKB8xFK7+zYVtJ7SljGYynI/HWPRIQdOUw
 J9RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153455; x=1721758255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AsnfcUgakDS94yBAG2Ho01nyvEXdce5IphgHAtL+bDo=;
 b=Fb1HlIovQVlcwTYshwgh+nGQzfWWYmDUmnnMss1238Lrio+4St0UQuVTsKIZM497WW
 mkV4ce8su3u6lbRwePazw0syzfSLBUz9zEXnJvMtzFauavVHS/WSHhwhWDvmuJsVigG6
 AKoTjjhPf0JJkrqPy3BMNW0R7BuslyeQkBYpck5YE79G4ar21l7Kr45eZ9f0VOvzSNhJ
 SAD86+O40fdbHAJf4qc8FcoSh5phYxIsvC2BB1sYNOCnEGgtvl3aSer7SkkOw27R1eb9
 SpcdQ8P2XamQewevenKTobzZVb4bB/boOmMvso1egEzpB61/E651nyiRnDMuL4Ksqyvb
 zIfQ==
X-Gm-Message-State: AOJu0Yzl+dImQxdzDGPNyzm8YDvCWZaHUV1fwhnJTpK4P61GyYl7G8xb
 VrmP/IlH+QJCLkf0uH5HHE9wDsG+Sei0cf3GQHTt3uwuPi6Bx3UwWsiyuJ4KSmTgGlE5idB5L+Q
 FAokV/g==
X-Google-Smtp-Source: AGHT+IGsWjI4bffQMS8jcbjj/iNJDtSZUvrxC6RhdJvMS4SRpvdIV8AbAr1WGK6/uZSOCWmlmNRP9w==
X-Received: by 2002:a05:600c:444c:b0:426:5c36:f57a with SMTP id
 5b1f17b1804b1-427bb8c508dmr20281685e9.14.1721153454921; 
 Tue, 16 Jul 2024 11:10:54 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-427a5edb489sm137531985e9.37.2024.07.16.11.10.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:10:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 13/13] system/physmem: use return value of
 ram_block_discard_require() as errno
Date: Tue, 16 Jul 2024 20:09:40 +0200
Message-ID: <20240716180941.40211-14-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Zhenzhong Duan <zhenzhong.duan@intel.com>

When ram_block_discard_require() fails, errno is passed to error_setg_errno().
It's a stale value or 0 which is unrelated to ram_block_discard_require().

As ram_block_discard_require() already returns -EBUSY in failure case,
use it as errno for error_setg_errno().

Fixes: 852f0048f3ea ("make guest_memfd require uncoordinated discard")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Message-ID: <20240716064213.290696-1-zhenzhong.duan@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/system/physmem.c b/system/physmem.c
index 2154432cb6..9a3b3a7636 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -1845,11 +1845,14 @@ static void ram_block_add(RAMBlock *new_block, Error **errp)
     }
 
     if (new_block->flags & RAM_GUEST_MEMFD) {
+        int ret;
+
         assert(kvm_enabled());
         assert(new_block->guest_memfd < 0);
 
-        if (ram_block_discard_require(true) < 0) {
-            error_setg_errno(errp, errno,
+        ret = ram_block_discard_require(true);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret,
                              "cannot set up private guest memory: discard currently blocked");
             error_append_hint(errp, "Are you using assigned devices?\n");
             goto out_free;
-- 
2.41.0


