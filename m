Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D39C54754
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 04:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGs3Q-0000di-0s; Mon, 19 May 2025 00:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnz-0006iB-Jk; Mon, 19 May 2025 00:08:48 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGrnx-0004G5-OP; Mon, 19 May 2025 00:08:47 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-231e8553248so18886255ad.1; 
 Sun, 18 May 2025 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747627724; x=1748232524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2v44lGfcQYNx/2ewSOTljM6U7tlQBnMtbr3WCiqvH6Q=;
 b=ILZu8U6gZ/qQ4CFPEm4DRliC0gAChkwrO50aUvG0BHEERbrYwnofbiVCNu+UK4bjTL
 TFFHEbY2CJQijsVRgX4963y8WwAQn69qJzzWI087UBY81a9IG7HLD08VIuYnQxhVybNc
 h296pg8tbZFRyUhgCCioawUTfSt66mEd16kSQ0xy6rT96PfWbzoo6Tkzs6nR8EDBoIj3
 bd6i+PbZBwePOBOioMKA1DzImA4nBeKaejfAnkRYE5gNj8v7pYYDSzfGWWzDsTuLCcQX
 LdneiYKyei/V/hcQ3ksUZGnjBryKtKlXdj+bGum2WHIPY9iicYNx02aiCQNeJqpSYyfH
 hIeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747627724; x=1748232524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2v44lGfcQYNx/2ewSOTljM6U7tlQBnMtbr3WCiqvH6Q=;
 b=sBnMzgdXEQIbIr2gccRFqvgLfNC2RnesTwiGwemTpjM9HSTT6uQ/3vWqe0OM82ZFRZ
 RfTR3ZouC7t+bT51wMIqBgTZtFisiNLtBPXDscTJwxEP4BE8P5/BVsnsJUsNs4wDTbeK
 seHtVG3481vsUUlo16VfaOpWskhgGqjDQ0/9qtg3hq/uxxU92smlP6Lc8GD7ZYBdWVzw
 O36A4cx7lCgnQ/IM0jXnBJYSQhEHKfHQmlqGjGQrBhGU0pN1gUoXlkigOZ67q70nH7bz
 bopk37dDekG53VKCwu6pDmRzcMY64OKstMgD2yiiRfi03qIUsmWaWraT4vq+rCH7Uy0H
 tDDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4Gr1qSnHgzTUQxswo48Fx3prEZGKo7lsc+xdroGY2wrxJdY9XwO1VCXijrtUKVo9zsFRni1gBfKW1jA==@nongnu.org
X-Gm-Message-State: AOJu0YyZQmSvNg46FYZuYrdlMefdyVrdekEJEt0YpZ4UVjuptS+VHJKp
 UTnoBPtx1CWwQWGGWXRMFFbXHRuoGP8AjFneaCpKKVHUDs50i+kuSve6z7w7aA==
X-Gm-Gg: ASbGncsic/AXd3A1TYEfukFVCB1iijPn9svHAeYy+2QAURGm7ESG64O7NzeKdAbuzL7
 yXmlALRM4fHQrCbwcYod0/cuk+LhqBYqXbC9u4smtwNuPD2CDimuZ4A31LRb8hyCSVAHD7TyZNB
 iTzKcWwitLf5NDLsuRWiGSVdUc2Z0YyA+hfWFdgDxXbaw9+a4vKgFmPLYRP/405uXRnwoGH2B3z
 U68LrSVjB9XM8uCkArISVZ5t15o0Vw+WfhxObhECL4Ig6iR0x/JW88YYtChDLvHz1XyLLKv7QYm
 5k1UA/Lmq00JtmGA7CYhA21AkVClnD3U7RqYswII0iYiEbcuZtn5/JtbqNaEOvqvzSNAQr0lJuE
 TNT/6vS3XRgTM0BSgD8JERzpHVn3XLh6aH3uXpud35vTw+D/1q6H7treqBl9YW/hnmOE=
X-Google-Smtp-Source: AGHT+IHLzNx9Gjc+mecwkbBKycz3Y8iCQijzhrjCeeIvf8/phq9s7L+lDwJoDXfxzJHtn/VShQLXsA==
X-Received: by 2002:a17:903:2f44:b0:223:88af:2c30 with SMTP id
 d9443c01a7336-231de30281bmr141448685ad.16.1747627723900; 
 Sun, 18 May 2025 21:08:43 -0700 (PDT)
Received: from toolbx.alistair23.me
 (2403-580b-97e8-0-82ce-f179-8a79-69f4.ip6.aussiebb.net.
 [2403:580b:97e8:0:82ce:f179:8a79:69f4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231ecd5ea41sm41750035ad.228.2025.05.18.21.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 May 2025 21:08:43 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: qemu-devel@nongnu.org
Cc: alistair23@gmail.com, Anton Blanchard <antonb@tenstorrent.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-stable@nongnu.org
Subject: [PULL 30/56] target/riscv: Fix vslidedown with rvv_ta_all_1s
Date: Mon, 19 May 2025 14:05:27 +1000
Message-ID: <20250519040555.3797167-31-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519040555.3797167-1-alistair.francis@wdc.com>
References: <20250519040555.3797167-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

From: Anton Blanchard <antonb@tenstorrent.com>

vslidedown always zeroes elements past vl, where it should use the
tail policy.

Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-ID: <20250414213006.3509058-1-antonb@tenstorrent.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Cc: qemu-stable@nongnu.org
---
 target/riscv/vector_helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/riscv/vector_helper.c b/target/riscv/vector_helper.c
index 3aec9a7731..5dc1c10012 100644
--- a/target/riscv/vector_helper.c
+++ b/target/riscv/vector_helper.c
@@ -5133,9 +5133,11 @@ void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
     }                                                                     \
                                                                           \
     for (i = i_max; i < vl; ++i) {                                        \
-        if (vm || vext_elem_mask(v0, i)) {                                \
-            *((ETYPE *)vd + H(i)) = 0;                                    \
+        if (!vm && !vext_elem_mask(v0, i)) {                              \
+            vext_set_elems_1s(vd, vma, i * esz, (i + 1) * esz);           \
+            continue;                                                     \
         }                                                                 \
+        *((ETYPE *)vd + H(i)) = 0;                                        \
     }                                                                     \
                                                                           \
     env->vstart = 0;                                                      \
-- 
2.49.0


