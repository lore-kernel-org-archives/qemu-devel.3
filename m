Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1491FCA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQmU-0000Hn-PV; Tue, 02 Sep 2025 09:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmQ-0000Fy-Ng
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmM-0004OV-19
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:34 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3dad6252eacso264915f8f.1
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818627; x=1757423427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GPee0txgZJCRwPW5GCHfm4cEZQr/K6Xo/55H9PnDEgg=;
 b=X+MvMEvdTe3FG2ji8xXr17lNfZBPpA/koAPiW2Ir/3iBydw087fnfQRg4iOax44qgR
 uxMxMKEMzCeMoelx0TbkjJxlMxY17bdhAJnzUYDazgxPkI61g881SPtYSp05omc4+xyb
 En4JCWHjk03cG7a8efJD/uoPxkwHCSVxyGGbX90T/LJwzc/nRYkiC9TGW4m68KNCkSdG
 CiSd4XKc4yFICLx0x52Gj5Ya4qa47ENin6h0OiFAOs2TVZdb4oV4kv4NakiuZcJXQ+to
 P9L6vsf0On/vVxMAcWw2qbMWGd72qY9h45TYKaP8caH3Q5tcpoBjGQNaI855BjoU3N0V
 VuFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818627; x=1757423427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GPee0txgZJCRwPW5GCHfm4cEZQr/K6Xo/55H9PnDEgg=;
 b=MH8iKTBD5zNv5HODAMymo+V2bFgB+wsHnkaiqKv9+fgxtL7Y/4jCVy3VMZ+NZYYMIy
 j1Yra6vmfIbduzQ4kZhM/V+HShxc5ARWBZIBoEJ0KJbw5k9MJTWogw/XcIkyhOtJedHI
 eyp8AGnOtnyy7ikJ04raEEqv4UicTYdQZlVjQvL7Uug64Cb2J/ireqXsezNXx72qiWBR
 BniY2pUgu3GJ7JmBqPobPiiRPkzk7p2pjgM2TziesKIwsuu7qWMzb3laJnZMz0oA7io1
 IuRMiEk/C8Q0JYl/3zE1KVNRnVszukjSQUGiMiY8Y6CAFgn78Bpye31IFnRe8UPJqRoX
 iOUw==
X-Gm-Message-State: AOJu0YzDXsxd0RonWmGCVTRqp/Jv7nM77hM4InOjNom6OYHvTIOi7dfN
 +Vl7ngOp/G0GZjNMrF3YQZ/59aY1oVc5b3FPSCjXDK+cfaMTrhkME0kCqBxxoNhqPq8qmHKyd2R
 78qRS
X-Gm-Gg: ASbGnctmgkT7aQGJagP04pevpB+crHf5GAIox9rox2rGBfGscxIiObWPLDaEX2RMZo7
 O+sIpzsr5BS5BKdfOOkphaIfH8Bf5ilkMxDbl+eD6yhUm7GPKXbct4oKcfdvceTFf10sHUwdhlQ
 3YAoBtlyzcrh1K8PGWW8YaYt9sWpyu1c4C/yWK2O3T8cLx/47e4yabVqabLX4vlhDqQ0Al9QXGR
 3j86AzLyVf7rGB3kpGD7KtVy8VgsZNw1BmwjFUXi/2o2BW9ZrI4DRzvR5MR06syk+1YwcBpr/Sz
 YzP4RtMtCrswvw4b2CGdBIy0hfufRA4VBqhI2vZ4wVyInnMw3nhTb67iMTcMFWAYrZr7TKHZzkA
 ItMnmcJ2UI0PpKf5Oz4HWbnQ2KQzHTBuovgJhBvJxKy1iv3e3I+wyh4uutK0gFaslqEvIhQuW+v
 W6Emi2R8dPlQ/RzqCNeQ==
X-Google-Smtp-Source: AGHT+IEIiVm1e17TkmkfQID/V++xhZwZF5wEPciowS03Y0lEDojUh88IZxrt4P4S50VYwWaMYhE6EA==
X-Received: by 2002:a05:6000:1786:b0:3d1:4c3d:1933 with SMTP id
 ffacd0b85a97d-3d1dea8c5e9mr8976976f8f.43.1756818627324; 
 Tue, 02 Sep 2025 06:10:27 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fb9db4sm19733791f8f.47.2025.09.02.06.10.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:10:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/39] target/ppc/kvm: Avoid using alloca()
Date: Tue,  2 Sep 2025 15:09:39 +0200
Message-ID: <20250902131016.84968-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

kvmppc_load_htab_chunk() is used for migration, thus is not
a hot path. Use the heap instead of the stack, removing the
alloca() call.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Message-Id: <20250901132626.28639-2-philmd@linaro.org>
---
 target/ppc/kvm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index d145774b09a..2521ff65c6c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2760,11 +2760,11 @@ int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns)
 int kvmppc_load_htab_chunk(QEMUFile *f, int fd, uint32_t index,
                            uint16_t n_valid, uint16_t n_invalid, Error **errp)
 {
-    struct kvm_get_htab_header *buf;
-    size_t chunksize = sizeof(*buf) + n_valid * HASH_PTE_SIZE_64;
+    size_t chunksize = sizeof(struct kvm_get_htab_header)
+                       + n_valid * HASH_PTE_SIZE_64;
+    g_autofree struct kvm_get_htab_header *buf = g_malloc(chunksize);
     ssize_t rc;
 
-    buf = alloca(chunksize);
     buf->index = index;
     buf->n_valid = n_valid;
     buf->n_invalid = n_invalid;
-- 
2.51.0


