Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75883C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pX-0002A3-7W; Mon, 17 Feb 2025 14:30:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ow-0001ua-Be
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6ou-0008Lj-Eu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:22 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2fc0026eb79so8738460a91.0
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820618; x=1740425418; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qBwpUjrpRy3DP9hoK1GLQ8GO+p0lkCqNn69gucYO0P8=;
 b=px07RPkaOXNtP8tenxaiCEW4LiWNmO9Wfat5fz2KlMT6OnWMfvQAYgfIXVgOTAt1ON
 j6Q+sp7syfA0TZJwlGvXcH0tYya87lyd+G3V/w/+AlzlFSePldFJjR7mrQX/x3Lfiba9
 Zp0FfVTlSgnFG6QAsV6r+NE+qUXgn9JuL8U8ZjInu9M+8qcbWzJ4626wKaRtTS+utJtu
 CvIxw6d2barlwFeRcWrEfV0fCStyWOkTAHjTYKAnr+8v4FR4PLeILiOZGQyMcMEEyM18
 s5Rq+sR18vGK6JDELKeISa05apdoC1XvpKoGvL0DR8tX2iGMC6Z60eTH3HXOoeBxOQnI
 wcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820618; x=1740425418;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qBwpUjrpRy3DP9hoK1GLQ8GO+p0lkCqNn69gucYO0P8=;
 b=Wjr12EY5M+orbKIy27yda6JapLs1S4f4Po/0c3IuNcbKMflZGJdPDnz+siCyqRVjce
 toeOjzxFVTDRIm2U6L7CB9fk6YjqqqWWH7r6TWGkU5HvIcmWGc/gJxaMDNjkznAmI9p9
 O4+t7hZ0acSn1k3s2XJ8TEpW5K4+ZHmuf3LiL54xkHkhl8XcwHAw6QND81BhI0D0NV3K
 CU9bWByjk8gWnqShtQf2SuBdncpnkgreQhwA9WOq95wBk31MyvRxdIjH//wtqiQPsmG6
 NbzZ056EUuEwCzFmJ2Vqi0TaXG5HHWe6T/LUlPyViK1mzVNZno3FMPnAWzDhElbyFvBK
 dkyQ==
X-Gm-Message-State: AOJu0Yx5vPLWQJbIWJvmEbQnPej3S17ny3vpZlx84wpKtK/DHBdGuURx
 o41Y/7KU5UkJwCg7O6GmPGFmkYpwKwcCZiWn0t/yr9BCjqcZiglGFcJzuIwY+3hDSKTALHFlm7H
 7
X-Gm-Gg: ASbGnct5ygpwFuVgSa7fN8I20+5SND94qCFJu9RzQoGKnyBbxKbWSEU945EII/8MQ7o
 71tNwh+EUK6B6AGy3vsH7nphtFTrZ/Iw5Gq0WplNW4GLrjNNJmLkrFGAfsGt96PBuiMc0aBtQo9
 TWnSXGlgQKo7pnunuxMLwb9GoYuSi52MydVy95I8NAr7k276WuowagCbGhcAukQsZKIj54RAa7F
 cOpTU4bKHR2q7wAhDPj73+JxUgs8Pzlh0WnBbIJvlcz8JQ0SIqacK2CUMwQCvhi1fiIoijywyHJ
 cVAJ0ttxydqkmcwpqxE6/tEuxhCm/xQKXX7b/iLE/t55gTI=
X-Google-Smtp-Source: AGHT+IEt6eezSndiz5usoA/WWFi19VrFU/wIhn9aW/B8MvbY4+rFzpk1BoWh3Jgg5Mi+owZpeQLftA==
X-Received: by 2002:a05:6a00:2d9d:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-7326177e484mr20681206b3a.3.1739820618236; 
 Mon, 17 Feb 2025 11:30:18 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL v2 10/27] plugins: Fix qemu_plugin_read_memory_vaddr parameters
Date: Mon, 17 Feb 2025 11:29:51 -0800
Message-ID: <20250217193009.2873875-11-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

The declaration uses uint64_t for addr.

Fixes: 595cd9ce2ec ("plugins: add plugin API to read guest memory")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 plugins/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api.c b/plugins/api.c
index 4110cfaa23..cf8cdf076a 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -561,7 +561,7 @@ GArray *qemu_plugin_get_registers(void)
     return create_register_handles(regs);
 }
 
-bool qemu_plugin_read_memory_vaddr(vaddr addr, GByteArray *data, size_t len)
+bool qemu_plugin_read_memory_vaddr(uint64_t addr, GByteArray *data, size_t len)
 {
     g_assert(current_cpu);
 
-- 
2.43.0


