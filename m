Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FFD7C54E65
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:19:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7h9-0005a4-EI; Thu, 22 May 2025 11:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7gW-0005HQ-9z
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:23 -0400
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7gT-0007ix-8i
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:15 -0400
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-b26df8f44e6so7737822a12.2
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747927090; x=1748531890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Go/jatOKtlAjZefV0JEAoAPDqQyoCGHsk+o50Hmjd5k=;
 b=Fudb3mpALPQJ2pbI3FLHcigX4NzbkFgkU+E8EfOeVGoavX8aAeZAW8IflxUHtZJZ4F
 NdJcG7YBYUs5L5jDOFUMmPMK8uo9vcL2hNfDVt7QywlYYWOqlVI/o2sp81Tl7eYTXSt1
 wbC2UhwVsWIB01M8ZT1rDxWv0g4w1K7M7ZCPgBpzCja0PbXHKLdieG2NX6u273qjkDa7
 oPezGf5egZF0GEDpHSzPbw+fyo3vckFBjktsKYiHEpTN8HhQRd5awE45tlpLfqtnZt6f
 8Ib560Ev2WzXmOz5PH8UAbf09TVdhuuiNPK/f0pK7MWeyz1S8nMJaR8RscVBx69EfH5V
 wBYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747927090; x=1748531890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Go/jatOKtlAjZefV0JEAoAPDqQyoCGHsk+o50Hmjd5k=;
 b=g2VOhv2JoiBV34t7+wjtwSQzTYih70P6Ill2i6rs9n7776biSv1M/RbXHI0sJv9gHL
 JhGg1pMQ7rSSRHeTZAmspiRZKD+8qonKLF7fd7q/SdNYm5TTkOfpvBjXAKVifVEalaLd
 YgL8SwDo2ZT7RQs0n476+1U7jp0wZsIlM7FhAREbaaFDIo52n53BfmpmOtKNGW5mj36/
 HhhmQosi1H07bbvA78xp9mnQWHLX09W7u7TBsZth8LVcqtj9x06GmGshYXTby2ikeZSx
 OVWcdHA8tBDSqa+a1GkhiJ1VzrKX8P3Dmmumj6H5pESTIjuSxPlzouofWDNXdZ+Cr1AF
 kAkw==
X-Gm-Message-State: AOJu0YyTZAdoZSr0wRiESpV1hooL3zdOaU3fS/Syk0E5ATDJAyDTxW4p
 Q8xUu1WGc/aDVMI5pHjpuWbps6dzAsfGQaXjC5j3a1LFpK/9e8ar4lr2TTXX0g==
X-Gm-Gg: ASbGncv3oGCD/IrpAV5Cjl9n0lo3I7Mqg/q+hQidpBlOYyh7pWPiVkF/zrF/Z3GsbhW
 vlxAPjcPz3vpuyl9iymtqZe4a8tdLG5VXgzR0JyIZ2DwvJ7MgAGiQGH5uKnLMcIbW1v8UAMsvuz
 yDRKTxlmunChtXc8XyU0cQJZ2zp/0uKlnAAyFUANidtg/PNcV/DdT+mmCM+6OQhPqbBKDpL7uxx
 Bn+6hpOZhSjqE8kbFJue8v8kBazRvnqwqAPROjInz5ZGv6F3pHsqSEdUv9nHkmheIHHjxnuelPe
 99hwwoTPZb4QiehCiaWv72E+4H0HsqZYDBx1JV3ax0uBwIry6Ys=
X-Google-Smtp-Source: AGHT+IFmVcLBoWWpigk2FYgdlvz4Uxp6os1f7Ol3kCTog8B8OBZl3ImoywrnKjRR+BEOgjN/GxQF8A==
X-Received: by 2002:a17:903:17cb:b0:229:1cef:4c83 with SMTP id
 d9443c01a7336-231d438b415mr364805865ad.4.1747927090423; 
 Thu, 22 May 2025 08:18:10 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:c732:a88c:b916:8b9f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4b017dasm110443555ad.98.2025.05.22.08.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:18:09 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 ktokunaga.mail@gmail.com
Subject: [PATCH 1/5] meson.build: add TCG_VADDR_BITS for defining the vaddr
 size
Date: Fri, 23 May 2025 00:17:26 +0900
Message-ID: <d3cfe67f43b61ff00ecb35a9e8fc6ba609ee4e00.1747922170.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747922170.git.ktokunaga.mail@gmail.com>
References: <cover.1747922170.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit introduces TCG_VADDR_BITS in meson.build to explicitly define
the vaddr size. For non-wasm hosts, this is set to the value of
host_long_bits, preserving the original behaviour of the check in the target
loop. For the wasm host, it's explicitly set to 64 to enable support for
64bit guests.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index ad2053f968..185ec96149 100644
--- a/meson.build
+++ b/meson.build
@@ -3229,6 +3229,9 @@ endif
 
 # Detect host pointer size for the target configuration loop.
 host_long_bits = cc.sizeof('void *') * 8
+tcg_vaddr_bits = host_arch == 'wasm32' ? 64 : host_long_bits
+
+config_host_data.set('TCG_VADDR_BITS', tcg_vaddr_bits)
 
 ########################
 # Target configuration #
@@ -3327,7 +3330,7 @@ foreach target : target_dirs
   target_kconfig = []
   foreach sym: accelerators
     # Disallow 64-bit on 32-bit emulation and virtualization
-    if host_long_bits < config_target['TARGET_LONG_BITS'].to_int()
+    if tcg_vaddr_bits < config_target['TARGET_LONG_BITS'].to_int()
       continue
     endif
     if sym == 'CONFIG_TCG' or target in accelerator_targets.get(sym, [])
-- 
2.43.0


