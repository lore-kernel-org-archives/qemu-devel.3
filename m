Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC7F5C3814E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 08:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPeV8-0008WR-2V; Fri, 05 Jul 2024 04:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeV2-0008UV-LR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:00 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPeUv-0003BH-UX
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 04:41:00 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-58f9874aeb4so577454a12.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 01:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720168852; x=1720773652; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mE9NVMNgeMpdIBYLHPdIh0Aogurvyr2VaxgmAxGfLmI=;
 b=G1CCYvkluMc7MQspvClMYeqWFpbSeBpFY8c+csuObflsApuFr4ulIdMLt8ZbqlaSJ4
 lyTYIgBBwu10G2DnMSMVyjhN85Us3bkgU8we2Heb4z+iW3in9WGwecpc3Z5mTi4mt3Oz
 A6tR0c32r/G1hU2as75ceCAVVhPwurkq73QJbvJcWBn6XYLcPw7gaB19/P+sDW3YSGBi
 rOdyZdiGV8y4BqzjqeBoCaolrQJvaogSB5JX7B+5/s1w6+/+Uk2LTOnzJx2pj+QDV05K
 xUW5Z+GUORuU5fgo7qVMT82L4T5qeNzK1Yc0gjn8/nDJ63BPuCeqGy2bWvQg+9sO6Cpy
 Ua5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720168852; x=1720773652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mE9NVMNgeMpdIBYLHPdIh0Aogurvyr2VaxgmAxGfLmI=;
 b=EwjRX9TT8apUvDAJOFEHhmYVlOuI3jJ3+Gq4S2r0nxoSi5nJml1ObNcfoTckjOKL29
 sWZ1v14FEwJa2a/iWkcyklsh/P507PyvQHHrD4k9trE/QFzL7MJFP1/0XbbtNpqHuE8i
 pVgikAF+O8bUg4y/jTBzrneHmOaLWU3Y39XOyyBW8VNJONGVfVSHtKexnxPhdgWdeA13
 krkbVTPHTrjqpHBwaEU/jHi5O9WnCy6XIOf1AVAqyTlogGdXPIGNed6MGC1KUnCs3+AN
 1zbUR2kzWcQ7Qa74JwX3SZnF3tdnIqB4EYTNOupaSPWSltIxq/UbR9cjCvO8etfQjT7s
 Movw==
X-Gm-Message-State: AOJu0YxMRVjD57OX5tqekZVSeMNDPHZUheiZ0F2oqWmO0eGMJvp6yEII
 nwd89EFqLl988DbgIkOi+PW9Bjb8aH3V67+pqLEYpBtZ5EGAEk2f/uKe/eqawwA=
X-Google-Smtp-Source: AGHT+IEeO1/sqUuuC8SZJQjdD45rKtJMDlDVFybbCtYFEltmJ4hvWjwoT48+3pL0h/SFkNCRkNu6Ag==
X-Received: by 2002:a17:906:13db:b0:a77:cca9:b21c with SMTP id
 a640c23a62f3a-a77cca9b865mr68617566b.34.1720168852016; 
 Fri, 05 Jul 2024 01:40:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab08cab4sm676033266b.144.2024.07.05.01.40.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 01:40:49 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 12DF15F931;
 Fri,  5 Jul 2024 09:40:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Thomas Huth <thuth@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Aleksandar Rikalo <arikalo@gmail.com>, Mads Ynddal <mads@ynddal.dk>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paul Burton <paulburton@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v2 04/40] hw/core: ensure kernel_end never gets used undefined
Date: Fri,  5 Jul 2024 09:40:11 +0100
Message-Id: <20240705084047.857176-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705084047.857176-1-alex.bennee@linaro.org>
References: <20240705084047.857176-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52b.google.com
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

Really the problem here is the return values of fit_load_[kernel|fdt]() are a
little all over the place. However we don't want to somehow get
through not having set kernel_end and having it just be random unused
data.

The compiler complained on an --enable-gcov build:

  In file included from ../../hw/core/loader-fit.c:20:
  /home/alex/lsrc/qemu.git/include/qemu/osdep.h: In function ‘load_fit’:
  /home/alex/lsrc/qemu.git/include/qemu/osdep.h:486:45: error: ‘kernel_end’ may be used uninitialized [-Werror=maybe-uninitialized]
    486 | #define ROUND_UP(n, d) ROUND_DOWN((n) + (d) - 1, (d))
        |                                             ^
  ../../hw/core/loader-fit.c:270:12: note: ‘kernel_end’ was declared here
    270 |     hwaddr kernel_end;
        |            ^~~~~~~~~~

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/loader-fit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/core/loader-fit.c b/hw/core/loader-fit.c
index 9f20007dbb..7ccc9d5fbc 100644
--- a/hw/core/loader-fit.c
+++ b/hw/core/loader-fit.c
@@ -267,7 +267,7 @@ int load_fit(const struct fit_loader *ldr, const char *filename, void *opaque)
     const char *def_cfg_name;
     char path[FIT_LOADER_MAX_PATH];
     int itb_size, configs, cfg_off, off;
-    hwaddr kernel_end;
+    hwaddr kernel_end = 0;
     int ret;
 
     itb = load_device_tree(filename, &itb_size);
-- 
2.39.2


