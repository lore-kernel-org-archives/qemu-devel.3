Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F345E77361
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 15:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYQae-0003TA-O9; Wed, 24 Dec 2025 10:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQZn-0002Ul-H5
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:14:59 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vYQZl-00035A-2b
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 10:14:59 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so4447863f8f.2
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 07:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766589295; x=1767194095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qSSsRmh/IQkwpJa4M1tD2tu2lq9WIQnOoGphHntAkAQ=;
 b=WJ21aNVgDuJSSp3q7jCAHeYA1Er2OP3ix0rNLaORUL7TaWq9DHmYCXYCNVE2Fn51Lm
 7qYvlo3dpfjg9n3SfX8jHqsO7L4zKASc8I+n/oLRXgd9Rld8caIargmZYkx+AignFmBF
 4bUYRXWvpjjTMuBgRmDDW6zQw9GiBkSc5cc1tt49jlfGC9ZrotDFpah4r97v5naWxYw2
 Icg10AQpybSyVMgOJgq25lClJEPzd8vyxEwJAm3l6Jh5dKs12uTQsNHdEQCbLn1OLNVb
 2bzyfUs04iYSS/NZHEB7egNnwPJtJHs6zrffXaDnh5a5OGffIR89gJF/19PgGqJABt+v
 bPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766589295; x=1767194095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qSSsRmh/IQkwpJa4M1tD2tu2lq9WIQnOoGphHntAkAQ=;
 b=cfG3fv4bVfEDPuCOyMiS5DX/vgMhRL7+2V96uAu5htliZeFE8OGjx/GdEXudD5dzLd
 eov/xW2e7qZf6Vl5IoqP+dYUADGJLu3oLfa3V93UQBNQMxrka0u7gILzy8EHF5zkEARu
 hf3d/ton5mL+6O8Ldr4R+uLljdCSjQMrqfxdxz2m/JfLAWNDYfNoJQvXbWLCXTP3UWmT
 ZVuLnLswdvPj6kdtIFiglaZvB/NoBvGcIcwAqz2qANisvWxpL7YyKiFAfdCcYJZ0kQBQ
 v5YYGKJpnYK7adfuyLC3PNs3vRtuJRM5wnZO2ScupRzBtz2FqLYgNEg2tqCbz13Zxg/O
 tvAQ==
X-Gm-Message-State: AOJu0Yyt5iyKrWSRKiZbA86m0v2ysL/W86Hde0kXfLYdf1w9EK85gu6o
 VAt18BHj65EmUQVjlcUaz+dpfAOKx+OpKWD4mhx7yESzvAHZDD/TDfTXxcUGEqhHDZc5t7cRZF3
 zZ8bO8/Q=
X-Gm-Gg: AY/fxX4f2ydw60aH5/cvLDINuGQeAfYLIFQw+TDhjQP7/Pb6YjIXM2FGkdSiC0VRENt
 oTr+V3Pana7OyTIHLRO1F1f+a8Nsi4dRKOCglvb30bY22slWp3I73UqbhuNbbbfXkKcbI15MHUS
 4zF8edi5dcfQ6KaOBhYfGaNbDhHHtQggl3waYi+Ja03Lj0sLfJyFWu/UIRvXdju/8o3mS41M8Wb
 JYCk350jb7ZbId5wCChkC76qJLlYIcQ+AfLnkbM1ZR/CseSD6ZKq3khU7gKhX3jI32bbPh5VxPm
 7/AIX5eyEDayfxH3Kwjvrkx17LF6dC7p4WKFC+kDIYVFBxT9dD3Sjhm9JfHcHNU3LgzpSWBHPXc
 65vt15jXnjKEWPbhQiXfeWVWv4iNPjI4WcIJE0+/tpUWkVPEFO8Sp0vL/PXPcwsOCgTV6fmt1ET
 u4EVPnXkGZAcBqE8B++EYVIsa/B2M4HifLH1BorccUdD01pz29+p9qax4=
X-Google-Smtp-Source: AGHT+IH/1qWHjLejlt1atDrHHy69+lHW4Qc4qS7vIzk9OOR+3COYvxQGXxooLC/KYi/aV2P/u2q0/A==
X-Received: by 2002:a05:6000:22c8:b0:42f:f627:3a90 with SMTP id
 ffacd0b85a97d-4324e4fd938mr21508015f8f.32.1766589294877; 
 Wed, 24 Dec 2025 07:14:54 -0800 (PST)
Received: from localhost.localdomain (188.171.88.92.rev.sfr.net.
 [92.88.171.188]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea1b1b1sm34391670f8f.3.2025.12.24.07.14.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Dec 2025 07:14:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Weiwei Li <liwei1518@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>,
 qemu-riscv@nongnu.org, Steven Lee <steven_lee@aspeedtech.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Troy Lee <leetroy@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Zhao Liu <zhao1.liu@intel.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Alistair Francis <alistair.francis@wdc.com>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/9] system/memory: Allow restricting legacy ldst_phys() API
 usage
Date: Wed, 24 Dec 2025 16:13:46 +0100
Message-ID: <20251224151351.86733-6-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251224151351.86733-1-philmd@linaro.org>
References: <20251224151351.86733-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Commit 500131154d6 ("exec.c: Add new address_space_ld*/st*
functions") added a new API to fix a shortcoming of the
ld/st*_phys() API, which does blind bus access, not reporting
failure (and it also allow to provide transaction attributes).

Later commit 42874d3a8c6 ("Switch non-CPU callers from ld/st*_phys
to address_space_ld/st*") automatically converted the legacy uses
to the new API, not precising transaction attributes
(MEMTXATTRS_UNSPECIFIED) and ignoring the transation result (passing
NULL pointer as MemTxResult).

While this is a faithful replacement, without any logical change,
we later realized better is to not use MEMTXATTRS_UNSPECIFIED or
NULL MemTxResult, and adapt each call site on a pair basis, looking
at the device model datasheet to do the correct behavior (which is
unlikely to ignore transaction failures).

Since this is quite some work, we defer that to device model
maintainers. Meanwhile we introduce a definition, to allow a
target which removed all legacy API call to prohibit further
legacy API uses, named "TARGET_NOT_USING_LEGACY_LDST_PHYS_API".

Since all targets should be able to check this definition, we
take care to not poison it.

Suggested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/memory.h       | 2 ++
 scripts/make-config-poison.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/system/memory.h b/include/system/memory.h
index e69171de05a..d5c248f1794 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -2850,10 +2850,12 @@ MemTxResult address_space_write_rom(AddressSpace *as, hwaddr addr,
 #define ARG1_DECL    AddressSpace *as
 #include "exec/memory_ldst.h.inc"
 
+#ifndef TARGET_NOT_USING_LEGACY_LDST_PHYS_API
 #define SUFFIX
 #define ARG1         as
 #define ARG1_DECL    AddressSpace *as
 #include "exec/memory_ldst_phys.h.inc"
+#endif
 
 struct MemoryRegionCache {
     uint8_t *ptr;
diff --git a/scripts/make-config-poison.sh b/scripts/make-config-poison.sh
index 2b36907e239..937357b3531 100755
--- a/scripts/make-config-poison.sh
+++ b/scripts/make-config-poison.sh
@@ -10,6 +10,7 @@ exec sed -n \
   -e' /CONFIG_TCG/d' \
   -e '/CONFIG_USER_ONLY/d' \
   -e '/CONFIG_SOFTMMU/d' \
+  -e '/TARGET_NOT_USING_LEGACY_LDST_PHYS_API/d' \
   -e '/^#define / {' \
   -e    's///' \
   -e    's/ .*//' \
-- 
2.52.0


