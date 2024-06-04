Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF4EC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 09:59:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEQvk-0002Ae-EC; Tue, 04 Jun 2024 05:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvh-0001yA-5R
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:09 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sEQvf-0002IA-IJ
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 05:58:08 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-35dc1d8867eso4586640f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 02:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717495086; x=1718099886; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EzcgxKBZLi25ReeoipJxRQhlgzmQ34yT5acRrJVoGcE=;
 b=t+ZvpSx6qgJu3ED/DV2fWT0biIqpcOuJhlQgafd6ojqnMkClXtMmVvRkta4mqKjMk9
 f3Pemt9qzscPdMJNIlAVJ6oi1xY0yaxoOrZfldjT1mp3BIX4z7S02ggpi0ngzX8pQAHK
 oYvpYxYa673LPP9uudfQrLJ8Qp9yJqWKPoMqs1bc9N8E+1zshwR86cVVuqH8PnPO+Qrr
 IiMzNMVaQYMqBzbs6NpQIVe9LoBNCE8iKd9GJynXdFisQbf+lCzf0jFqRg/XXBH/PE9g
 HmpTRbbOYoFAlQ47D1IdYhRo+HVszDP+sVPCj+OPF6LtyELJmOfR3hFHJyLZ1OlW1rzx
 MRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717495086; x=1718099886;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EzcgxKBZLi25ReeoipJxRQhlgzmQ34yT5acRrJVoGcE=;
 b=gpMXivvgCEeOhbCxxfM745R6o9AwXpgB3v7ZSn7znuXJpJjlbmXt1hoR7tqoNBecot
 qwfGTpUAy1pTClIJESJhFKHwgz91HLHX+eexdkwrWXJQHvb21rct+tvHsiB6YSYT1mAN
 0iW81xEiDO79BW3wMElo4lWcgj5ijR1gVB4LqwmolZLXCS7Te+2IiGspqGaukaKN5msx
 yg6aAjWyGgmdLCynfuz3qC9VwVmKqZ2cjLTL8wifXY9j4REghAmMa8Tz2hKHmj/L5b45
 C771KUhHBcNN++74xhtoLngzktr8gvXePfC746YfqCveFlHtvJWB9BmOHDay8ZPrW9x7
 KQ1Q==
X-Gm-Message-State: AOJu0YzQfSJdJnszK1zdjjwK6Trx+E+jgy/9VqO1K8aVbihjdW1H7j7s
 hftEBgbN9P8T9n6QMT8bMpIvCpXFTPJCc//xC2G4oZZ4WUlO5lHCRip8RTTJcXsJEba9RkmXOOB
 t
X-Google-Smtp-Source: AGHT+IEUm9fBDg4Kslt2mW3Mzccqzt+Wmlaj0QsdjnC/1eN1V8dDWzeponpQmbJdsTb+vPMYrEY9vA==
X-Received: by 2002:a5d:5186:0:b0:354:f467:c149 with SMTP id
 ffacd0b85a97d-35e0f36dca9mr7275991f8f.59.1717495085822; 
 Tue, 04 Jun 2024 02:58:05 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.159.34])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd066d317sm10999710f8f.113.2024.06.04.02.58.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jun 2024 02:58:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/32] physmem: Always pass offset + addr to xen_map_cache
Date: Tue,  4 Jun 2024 11:55:57 +0200
Message-ID: <20240604095609.12285-22-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240604095609.12285-1-philmd@linaro.org>
References: <20240604095609.12285-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Always pass address with offset to xen_map_cache().
This is in preparation for support for grant mappings.

Since this is within a block that checks for offset == 0,
this has no functional changes.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240529140739.1387692-5-edgar.iglesias@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/physmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/system/physmem.c b/system/physmem.c
index 342b7a8fd4..5e6257ef65 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -2230,7 +2230,8 @@ static void *qemu_ram_ptr_length(RAMBlock *block, ram_addr_t addr,
          * In that case just map the requested area.
          */
         if (block->offset == 0) {
-            return xen_map_cache(block->mr, addr, len, lock, lock,
+            return xen_map_cache(block->mr, block->offset + addr,
+                                 len, lock, lock,
                                  is_write);
         }
 
-- 
2.41.0


