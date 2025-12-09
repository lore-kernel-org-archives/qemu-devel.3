Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 885E6D3B992
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 20:06:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vT3yU-000151-Fb; Tue, 09 Dec 2025 15:06:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yR-00013D-E4
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:15 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vT3yP-0001JL-Tq
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 15:06:15 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42b47f662a0so97715f8f.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 12:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765310772; x=1765915572; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=c+XhViGePU7FVlwUFzwVc9jH+z21suBf3LC87dmzJlc=;
 b=w13Tu4tK8PuWEcRVtwPhkaFJEM8ikWbt6hSg+E6zPY75DIV4TSzlPx7HE7NbxWVYH3
 c8rjnqVzrdLT8SifGiMaA69hH7SlVxWds0J3Byrk4H6FYOO8nObYhfjr49/6/Aq2ycci
 eZCEWp+qLHWJAZJhKnaXxoT302GVp2vIYNOrRu5SU5T6ED9NTh8Xjw51moViNp9UOOxK
 /nP/HJrkCj2QvgIWp5rGQFQ6CDY915PlAI8irL6I8b8a1aMI79Isfb0x+XzZ/jZ7sR65
 KOa6VJ/5A6/eVFZNFNxKyi1IOOzC8OGSOgHcoS/Hyb4NDN1XrCPCjBHiPqLlnOqFLiLv
 Ly9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765310772; x=1765915572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=c+XhViGePU7FVlwUFzwVc9jH+z21suBf3LC87dmzJlc=;
 b=JWoAhtVWc2iwM55AO3/dA5W1VO6FaM6/RFC6OTL53kJD/15sgP4jVVZn6RZFLF9yNr
 mADB5TjRTXcvrDVD2GKq+KpIl8r7XR5Vr2bC5OmeKEOMwYayYtKbfg/JISWSmVG5hFbm
 kJQ0mZBfBOku6r54sZU2k5YJDEnHhqBKqEuLwUQe76Fy/MEgJ2ZACJBXikgAb7G3EmcJ
 p7sDzxzjjBpiUZvK/Hc6rciHu9uqa++VJ09juNxsKM+XDsoGAjTgSf84BSo8P79VZfxy
 gUzW2L43VyUPrLOHQyqlfw+hQm+fmFhByhhHEpz3MPoibvKL46JN1pP7OlYEZKpNDtfs
 /6Qw==
X-Gm-Message-State: AOJu0YzM72KbWu0fn+2JhcKV6ILwemGPWUnkJEna0n35HhgPYQLr0P0C
 2nqPcn8FbHVIJthkeT9U9X5AYWVuTy9vdIPQV10H+EufqXPUmacNdcnFeEvu0ISH0gHRNLB47M0
 J7320cek=
X-Gm-Gg: AY/fxX62d5l6TQ0/F1A3OuVD+AI5vGQrhechLgW4luoe5YWxU3tKvK8WrVvBMVPBQKz
 hzht88JEa7r+ju3VsyniEo9w+wKp6oXhlGlwUSrl/VNvyzIUhjvI0CHWSbTHSo0pChBCZhNXLDl
 ATdBQaEb4ZzBAH1jYwA0uZu2Psc1Nnjqw8RLrGYt+vVKJqmkZ8gugnOdgXEZX4ZpCkBEe1yJAzC
 dMqTV4ghRAhTFjtMkmA6rw1CJsln5/QQge6VPHmSGgghUBM9nUVl8eLcVEO31XPj6h5C1MRFCNM
 02ew/Fzw7FxWK5Ec2eHxep1YcY9hYdLiOvYPPMcXvySNvYz1Lm8NpmhHJncPLHnEzJ5Hlg+n1wF
 yDWXnvynKINdAbJk6QMAF6rTb76/17vZXktdOqUB0/Nzt4R8Tx/vfej+oFz4HQX3phoniI9G7Z7
 ynSXyEZwHdsHNG9ND/xsoLipOZk8F+yd/rp6ZgdA/LG1LbNeD6tbYxqEFWCQ5ADRm51Md52ws=
X-Google-Smtp-Source: AGHT+IF68cz2tJEYTPejxUXhpefjvTppK7MvtvwBwc64fE9WIGCZu9QmP31Ud0GJDrQgsbohPimqFw==
X-Received: by 2002:a05:6000:1a86:b0:429:d253:8619 with SMTP id
 ffacd0b85a97d-42fa071b78fmr3645039f8f.5.1765310771909; 
 Tue, 09 Dec 2025 12:06:11 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d222506sm35630666f8f.28.2025.12.09.12.06.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Dec 2025 12:06:11 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] migration: Fix order of function arguments
Date: Tue,  9 Dec 2025 21:05:32 +0100
Message-ID: <20251209200537.84097-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209200537.84097-1-philmd@linaro.org>
References: <20251209200537.84097-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Stefan Weil <sw@weilnetz.de>

This fixes a compiler error when higher warning levels are enabled:

../migration/postcopy-ram.c: In function ‘postcopy_temp_pages_setup’:
../migration/postcopy-ram.c:1483:50: error: ‘g_malloc0_n’ sizes specified with ‘sizeof’ in the earlier argument and not in the later argument [-Werror=calloc-transposed-args]
 1483 |     mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
      |                                                  ^~~~~~~~~~~~~~~
../migration/postcopy-ram.c:1483:50: note: earlier argument should specify number of elements, later size of each element

Avoid also a related int/unsigned mismatch by fixing the type of
two local variables.

Signed-off-by: Stefan Weil <sw@weilnetz.de>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251209125049.764095-1-sw@weilnetz.de>
[PMD: Replace g_malloc0_n() by g_new0()]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Peter Xu <peterx@redhat.com>
Message-Id: <20251209195010.83219-1-philmd@linaro.org>
---
 migration/postcopy-ram.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 7c9fe61041f..715ef021a91 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -1467,7 +1467,8 @@ retry:
 static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
 {
     PostcopyTmpPage *tmp_page;
-    int err, i, channels;
+    int err;
+    unsigned i, channels;
     void *temp_page;
 
     if (migrate_postcopy_preempt()) {
@@ -1479,7 +1480,7 @@ static int postcopy_temp_pages_setup(MigrationIncomingState *mis)
     }
 
     channels = mis->postcopy_channels;
-    mis->postcopy_tmp_pages = g_malloc0_n(sizeof(PostcopyTmpPage), channels);
+    mis->postcopy_tmp_pages = g_new0(PostcopyTmpPage, channels);
 
     for (i = 0; i < channels; i++) {
         tmp_page = &mis->postcopy_tmp_pages[i];
-- 
2.51.0


