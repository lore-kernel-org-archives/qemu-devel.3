Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236F7C3ABB7
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 21:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBhLM-0007QO-Ba; Sun, 04 May 2025 17:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLJ-0007PJ-Fo
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:49 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uBhLI-0005Ay-04
 for qemu-devel@nongnu.org; Sun, 04 May 2025 17:57:49 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-225477548e1so38453785ad.0
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 14:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746395866; x=1747000666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=70eq9g6WHBoTjhXQzmX0KiM0KlARnQpKuNIYy55yJxM=;
 b=lcTyW13cMyMAJMDOaoejvAAXrLtOHiObyA4CWnphunjA4KwTBUaSEypQJa2TjJvf3s
 AV0caAfzni2BMTWA+HqVadLWtSTGlhmMC6nSNckRo1llm/Oi6GO6dQub9TmOtRWSf50Q
 eya3I00gY6GaxQrrHcki/opqDGWj/kzM9zcLmUZESnGaEjQAvRmFwsVgoJWabsZ3Ws9B
 SUXqgiYfzjB1ENoOjaAPK/9POcAemk1Ds2mTvwVISAsWaC53L6JDeYy2vgmURTrjFE8O
 8vdPXAo2PNlvC4Ns+Tu69oeDKWf2Bek+5WUkxbwT/bnev/aDXbfptB0LokYqovirZVGL
 bR2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746395866; x=1747000666;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=70eq9g6WHBoTjhXQzmX0KiM0KlARnQpKuNIYy55yJxM=;
 b=oUaeLSEyAZJ9kiJ8a5A+8AEgX3QXG/eZ1l/9oUGAlbDeVs6foSJ3a5SC61kR3O2M7z
 yNdRldOmh7Cn4PvxN2B6VDr3c1moyAC7yJ5hnabNW3pgTUd7eMvevUOM4IvGZ9WjZdG2
 dxck4Oi68jEQKV5/pUshjdQR/K40coJzamJJX2/F8N6+kA8XC+S8xoD5yeZFv8i5JfbB
 5QF7amjY7y7kk73RsyXnpgr6KaYKwQbVYnBLCd1klFKouKxOBPKotkstN8nlNEu+bvvf
 NUMMXec2WN3Y46md87G9IfrX2aSxN0V6r/TQIHvwcNHgQspgwwqR7Ss07Iw18j/s/Zdn
 Ol2w==
X-Gm-Message-State: AOJu0YxFaeddy/zMax76ZxpG+tsp/rD6mLowflqoCEE1DSaUHWEWsT0I
 ZI9KcNgKGNCvHqbCm22Ux8IN2BWVLwjBjC2Um7p/UUlEl2RGf0kSvWanCguSE8Xz7iTb/WPCkCY
 h+5Y=
X-Gm-Gg: ASbGncvZkz478Td4zRchzg6/EfTG+jHZ/eg3c+D92/nO5D9ZUU9BVr4bia8oK5t6aD1
 swE9MV4mrfzX5WaI6NlZQWK1cz8CVmi0UdRJSkqlRcH8zcxk2AMZfTTusZLXo8mDOvBKmI7ikHd
 OaMn22MTAwSgY81HtHHoRaG/UOA7GU1NcAjUTysUmsO/n772bHwcHbfVi1h/7oQATv3jOM5+sFn
 iMSeRBO0PwsaF+ZqtVF2oVBFjcYt20atqb1FjFAcdBQxsJvZvUaGVNnIM6BS9P8qNj2BlawgP34
 1SLgXQ+1SvkDyW2uAR8fiP5RCpuQOQBbsQmAkdUMGHLH5LiL
X-Google-Smtp-Source: AGHT+IH8qtHtLj8WpGKYcYxJcW8v5JenW5jMtdxO9YS6Ha1A7cnpPdznd6vRtZLIj+Z+zaK9MBxQyQ==
X-Received: by 2002:a17:903:2f07:b0:21a:8300:b9d5 with SMTP id
 d9443c01a7336-22e1e918571mr73488125ad.23.1746395866010; 
 Sun, 04 May 2025 14:57:46 -0700 (PDT)
Received: from gromero0.. ([200.150.181.215]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e152204fesm41664875ad.137.2025.05.04.14.57.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 14:57:45 -0700 (PDT)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 gustavo.romero@linaro.org
Subject: [PATCH] hw/isa/ich9: Remove stray empty comment
Date: Sun,  4 May 2025 21:56:31 +0000
Message-Id: <20250504215639.54860-3-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pl1-x634.google.com
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

Remove stray empty comment in IRQ routing function.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 hw/isa/lpc_ich9.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index 71afb45b63..304dffac32 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -182,7 +182,6 @@ static uint64_t ich9_cc_read(void *opaque, hwaddr addr,
 }
 
 /* IRQ routing */
-/* */
 static void ich9_lpc_rout(uint8_t pirq_rout, int *pic_irq, int *pic_dis)
 {
     *pic_irq = pirq_rout & ICH9_LPC_PIRQ_ROUT_MASK;
-- 
2.34.1


