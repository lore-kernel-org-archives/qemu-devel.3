Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 078B5C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 13:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seaH0-0002gz-Px; Thu, 15 Aug 2024 09:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seaGy-0002YL-Jm
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:12:12 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seaGw-0001JL-2m
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 09:12:12 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-37189d8e637so365467f8f.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 06:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723727528; x=1724332328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dUYdiSB91Owjfbe3qfsRkuZlpaUqKUBYcIWMaFHQa1k=;
 b=xoZ43qJpRQz7i5GaOSfZ18gslGYgRUkp8nhrn6NWbZF8fh0PV7O0FejOd4NyMxyADx
 D+YiZUcsrhIUNzIwi2QxWkNbaIGR+IjpJGkl8fiWiv74hKNjBuaFElXTThIjCr4ViMAj
 KpTNQeA3eHbx8zqx3axUZfe0F8BZ0YDC2gkcpuVmp+9UOhC3h1YAUUY45VX9HkhvE7Lx
 Qvom/MJjq2DxxOoiAzBsRmyY60N2htjen/6zGRVBI9LdF3MHaIUpJiHUTqR5Px6SS6Xf
 Fg7u0aiUFuqvGhizKu0KpIHObSAgryr8izYlS76flY9sZAJS8gpAAVF5ZaTbeov8LfQx
 Fhhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723727528; x=1724332328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUYdiSB91Owjfbe3qfsRkuZlpaUqKUBYcIWMaFHQa1k=;
 b=UPpyrwPHE5rHLCoHpTyA/C0J/K1EMF7DpvrrWHVkgWO4tJfBrYXatPiNqXLiV2xQnE
 28R7VEww8Wp83CPoYnjlfkOLWHtDQirFrO8uyrOND4fEHgd6TpCS7g63VnL8DFeyHUKy
 wTEZH+nNJTczViBDI8n5OcFTBAJojB29uh1EDjTFyEN+KBs8SDMJz/w4cixEwpcWmNAe
 99Xn2XMY/BDmPN94aUqDHMXh/PqV/z9fd7ajsBlQeleQr0tFFYCewvsDkSLS+wBBNAyo
 ha/Ft/pb+JwQqdAnNBA9dswCpNXyZWFXrS3Ts1bsoa5iaWYwwYRHoc2/NKdooFGN33+M
 Poww==
X-Gm-Message-State: AOJu0YzCnyHgWukpkwNhiJ4Nwg/8i0r+aGrxy0Ulq5H86haLiIz8YPFK
 8akIDJ8fFOhwKSphMQMd0ZcSBmdjoskwyMfcUb+2BInz6zddJQUnHlrCs/6MRGMUacqgQEskTbk
 u
X-Google-Smtp-Source: AGHT+IEDnD3X5IwvbW3u4gle1NP3s9fF8xxrWbTaUPppzRXMeeVLeC+UvMFtph4uek9nXigeN5VimA==
X-Received: by 2002:a05:6000:4008:b0:368:3b1f:fe40 with SMTP id
 ffacd0b85a97d-3717778b7bdmr5878939f8f.20.1723727528438; 
 Thu, 15 Aug 2024 06:12:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-429ded19627sm48269935e9.5.2024.08.15.06.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Aug 2024 06:12:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH for-9.2 2/2] kvm: Remove unreachable code in
 kvm_dirty_ring_reaper_thread()
Date: Thu, 15 Aug 2024 14:12:06 +0100
Message-Id: <20240815131206.3231819-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815131206.3231819-1-peter.maydell@linaro.org>
References: <20240815131206.3231819-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

The code at the tail end of the loop in kvm_dirty_ring_reaper_thread()
is unreachable, because there is no way for execution to leave the
loop. Replace it with a g_assert_not_reached().

(The code has always been unreachable, right from the start
when the function was added in commit b4420f198dd8.)

Resolves: Coverity CID 1547687
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/kvm/kvm-all.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 6c4cb263ba3..fe4cd721d9b 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1525,11 +1525,7 @@ static void *kvm_dirty_ring_reaper_thread(void *data)
         r->reaper_iteration++;
     }
 
-    trace_kvm_dirty_ring_reaper("exit");
-
-    rcu_unregister_thread();
-
-    return NULL;
+    g_assert_not_reached();
 }
 
 static void kvm_dirty_ring_reaper_init(KVMState *s)
-- 
2.34.1


