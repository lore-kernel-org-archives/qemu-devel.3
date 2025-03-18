Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF41AC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Mar 2025 21:37:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tueZf-0003lG-4w; Tue, 18 Mar 2025 17:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY6-0001LM-KV
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:34 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tueY5-0000pj-2Y
 for qemu-devel@nongnu.org; Tue, 18 Mar 2025 17:32:34 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-223fb0f619dso104391095ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Mar 2025 14:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742333552; x=1742938352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRqDXJHX2zGNybTG6x2KjIY6H1Iy34YPBBK1EJX6qfI=;
 b=QpB3E9a02mEUtWGdAEnqzzG2d2OfmGDCLy33/SSVPoyAa82N/sO2z8A0rDID8Jexjy
 j+150I+yNk2Mf2PTWBuHFq3rFejO70VBBm0ip7A234Z/CTz1F57SivnlmZgp0Vc/VdLn
 KCS16c70PpA5uWQ0MMoGckOymyIhF3JfxyONbVS8NvPVJWZBCDxtco4DC/q7USZUHRo1
 yVsjrQhWiVhB6jiDrnlABlZbC+mYuOmDW6JZBi1GNLbRK/Qd000innNHh+D2Jh9/fIB1
 5DXjRniRk/0eE406fVzjptd9xeSw54vZYFvsMJreGUWvBamz6eTaGkDnggI6eA4yWAf8
 OUiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742333552; x=1742938352;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRqDXJHX2zGNybTG6x2KjIY6H1Iy34YPBBK1EJX6qfI=;
 b=Vwog0dbyPQsNpDxngQ7ePS1OIOCA2K2BSos795Ha7wznZD7cP/gscwmP2DQP1/+reQ
 U8aNL5NTaCucu7dEl3nPMKbShAwpqbB92VC/O+uEMVMFUbcL4e5+dAXvBGuVj+tO/hzK
 2g/Ww9vQGQmyAc3uMR8xay0JHA7JE2KjzckGJV1xpUcOGv6fx/7Tsq3MLozYx6/bDqvh
 9goUKTSehxaReuZ10tB2ixMdbFN3UU1c5Sedmjm5xUdvd3I5MBF3Ys1ANj97i5DYxrka
 baL1OSSt3I7TTJ7RMtkbdBhYVnKig0DFktc1BPRb5cvkWqq3/EQz8SR+NP8A8bXu93BK
 t7rw==
X-Gm-Message-State: AOJu0YylMIW4eD3+cbaUv+S/qPR2S/hhioerb5HvH6zGKnogbR7VhYuE
 j4zeGjahWbcKoCKpctimSc5EHpxfdX0QeZJn5rce7CEvKggudHbFnvDJV2sZvo/UdimlDByHaVY
 A
X-Gm-Gg: ASbGncsFpZzypYhNS9ey4vlM+8ZPiOD+rgdBeR6CiJ5xUUdrioTXIkmjE2k8nKD/Rd/
 i/+jxeBlMpeIxQG8xS/+t28Wps0hh/13H2S/envFBFAMCKA1Gfwi8pY0iNwMbYPN5LV29BtvpDs
 JR0Hhrfg42fS9EvwQzc/wpjXIsLSE6qrxRREokShJ2oX7V8bvHVj5YKkIE7KzftHQWD9nUoYTx7
 UVXSmZKrIBGwkDKgbanDm8nIjSOnkK/iWFfj0UUdnwQDvH0KLhByvV3BnwlqrwIwPA1iB7Sp/bl
 JmWGlJKyzlfon0PYG2UeNZO52iV/eqBA2pp73pGxT6uvf8YcKfvBRGmbX/GEUWLbkKyjPJsEz3z
 5eRmyETNdfLs=
X-Google-Smtp-Source: AGHT+IGENmE9U1pUE7GwbzM9lKhF/LZGANjlHY+kneBx6gK12jfTELfimZdotsGetx6HfCjVznQlEw==
X-Received: by 2002:a05:6a20:c908:b0:1f5:8a1d:38fd with SMTP id
 adf61e73a8af0-1fbeb3911c3mr366794637.2.1742333551789; 
 Tue, 18 Mar 2025 14:32:31 -0700 (PDT)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9ddf4fsm9473854a12.21.2025.03.18.14.32.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Mar 2025 14:32:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	philmd@linaro.org
Subject: [PATCH v2 30/42] hw/core: Move unconditional files to libsystem_ss,
 libuser_ss
Date: Tue, 18 Mar 2025 14:31:55 -0700
Message-ID: <20250318213209.2579218-31-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250318213209.2579218-1-richard.henderson@linaro.org>
References: <20250318213209.2579218-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

Many of the headers used by these require CONFIG_USER_ONLY.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/core/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/core/meson.build b/hw/core/meson.build
index b5a545a0ed..547de6527c 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -26,7 +26,7 @@ system_ss.add(when: 'CONFIG_XILINX_AXI', if_true: files('stream.c'))
 system_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
 system_ss.add(when: 'CONFIG_EIF', if_true: [files('eif.c'), zlib, libcbor, gnutls])
 
-system_ss.add(files(
+libsystem_ss.add(files(
   'cpu-system.c',
   'fw-path-provider.c',
   'gpio.c',
@@ -46,7 +46,7 @@ system_ss.add(files(
   'vm-change-state-handler.c',
   'clock-vmstate.c',
 ))
-user_ss.add(files(
+libuser_ss.add(files(
   'cpu-user.c',
   'qdev-user.c',
 ))
-- 
2.43.0


