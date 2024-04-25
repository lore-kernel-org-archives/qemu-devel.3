Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325C4C19F4F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 11:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzwuJ-0002rz-CK; Thu, 25 Apr 2024 07:04:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtN-0000Du-M8
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:04:03 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzwtH-0000Jz-Lk
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 07:03:52 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-41b3692b508so6091645e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 04:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714043022; x=1714647822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3jM66TtA9+JPWnnaJ/wdkFyoBPGKJrTnB7XlYnSXjfw=;
 b=q67tICheuqQtUFBIwqS8xdmp9ZjCnwej4ObCq0rfBW0NnQ5jxQfOibhMOdM4cS/LZO
 7uEqp3eN7KJ/f6mHWt0GgKd4kvOj8bCevQQIsTWS4PDAgRVEmw/JWezo/nUIlZCDleWp
 lPlHGABqys96bi7bcWl/Baf6f5EW3jNOhUcNwmrFBj/pLdJ+BcS+V4RB8VTY4X/b+ti5
 a4ZNF4Sc7vaIwUXU7DedWrG1qF9SG8ty02pFOLgjKUZnkecwOxCWWJ5Y5jQlgRwxFcYG
 uUQhoPrnbf3PSDWRrSG/RhlgDYK5kXAhZvVj86moZEn003H0yMemIislAARfYsVmG8uR
 Hbkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714043022; x=1714647822;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3jM66TtA9+JPWnnaJ/wdkFyoBPGKJrTnB7XlYnSXjfw=;
 b=MBvshvN+3TEyZF207hQSpIV0u134DHOj7jYMY1DdMGrCEcZplqMr1JDa9HDpHTpEix
 91G2qoA7ZyNGjplMh3GHLkGFUgRKfs89xzXo0BPW4XYfoJRMmvxFe/1O1dgx/M/12Yeq
 6bN4kvXgCA1pxc/eC24RwGHhZfUw/zKLufwbwwYbV65wZa0NpzIrl8q2xIJeSA7O1B95
 UrkWgF8vANrvcHCcEI2uLvQy4JPPdjTv4L8BIZQyEpZw+AHfarH81kDav1JN8LIo2BzN
 05q6tca96Sn40riTTtMa0B/ozODxJliuhdmrciQICpShj4EuG4qnoIgTg9Mr2PIE6SNQ
 E9xA==
X-Gm-Message-State: AOJu0YzyhRznqnFYNgylpA8NuOG5Xl/+tb0+rsUBsnIaGlx6M1xUtIlp
 ag7sQJ77fjere6oQDtk1jmlGm1G6JdPB41hmV6M92M8esr1yFxFH3Ml2ktUsJNuIIZISBu02nRi
 k
X-Google-Smtp-Source: AGHT+IFep8mayYoTqo1tEoWaxYRBNnZQKy6JlVbPvXcPmoksWBiLC7hipxkwT32wWx0hqDlaV9VWvQ==
X-Received: by 2002:a05:600c:4ecb:b0:419:ed35:e312 with SMTP id
 g11-20020a05600c4ecb00b00419ed35e312mr4210635wmq.21.1714043022268; 
 Thu, 25 Apr 2024 04:03:42 -0700 (PDT)
Received: from localhost.localdomain ([92.88.170.77])
 by smtp.gmail.com with ESMTPSA id
 u11-20020a05600c138b00b004187450e4cesm30787552wmf.29.2024.04.25.04.03.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 25 Apr 2024 04:03:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-arm@nongnu.org,
 Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 18/22] hw/i386/pc_sysfw: Remove unused parameter from
 pc_isa_bios_init()
Date: Thu, 25 Apr 2024 13:01:51 +0200
Message-ID: <20240425110157.20328-19-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240425110157.20328-1-philmd@linaro.org>
References: <20240425110157.20328-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240422200625.2768-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_sysfw.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index 3efabbbab2..87b5bf59d6 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -41,8 +41,7 @@
 #define FLASH_SECTOR_SIZE 4096
 
 static void pc_isa_bios_init(MemoryRegion *rom_memory,
-                             MemoryRegion *flash_mem,
-                             int ram_size)
+                             MemoryRegion *flash_mem)
 {
     int isa_bios_size;
     MemoryRegion *isa_bios;
@@ -186,7 +185,7 @@ static void pc_system_flash_map(PCMachineState *pcms,
 
         if (i == 0) {
             flash_mem = pflash_cfi01_get_memory(system_flash);
-            pc_isa_bios_init(rom_memory, flash_mem, size);
+            pc_isa_bios_init(rom_memory, flash_mem);
 
             /* Encrypt the pflash boot ROM */
             if (sev_enabled()) {
-- 
2.41.0


