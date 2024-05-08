Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512BBC04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 17:56:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4lVr-0001Bl-On; Wed, 08 May 2024 13:55:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVn-0001Am-OM
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:28 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1s4lVh-00027i-10
 for qemu-devel@nongnu.org; Wed, 08 May 2024 13:55:26 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a59c5c9c6aeso306366b.2
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715190917; x=1715795717; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EU56KqxsaM/0HEsRCm8u8nVsVnVRC1FhJWxFNu5K1Wg=;
 b=ThrVwvUDsNMFMihZG35qCNfLsvH0/XDzYelLJ2oaWT1Xfxst4OSjpvuqaQy8QkT7Iz
 yyf07m82XExEBe55Z0pVOJ44Z26IC5glTCyXMMDdp2tGyN6Cde4SAYtWsAPHGWfkH3ah
 RkmWEMErZQVntyBphaISsayyNCiTpuu7nJ8VLavln9s+zhzcy0TVcGLg7kUGv7VqXcpU
 394eaz2M9fLUQqqx3M/3kf/dnxypZrgxlR05VfdTzMFMDv/ojOnpSnm9hOX6/u591E89
 E7dnYVyzgudG4t5aOPJXaeNCi4aUK+sqHyEsujW7p6S1Cq+KZiRh2ulBTYPYthuE9B+H
 Q2/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715190917; x=1715795717;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EU56KqxsaM/0HEsRCm8u8nVsVnVRC1FhJWxFNu5K1Wg=;
 b=Zltf5TdezuitE49zf/fcR8/TqeB70sfbO+a6jfFtkhPKKM/yX0ni984BEn60tqkpy+
 oIZ8cIOzmCbsWBOosoVcxVqqTWLwz1hQ4puiDfhkA6NdFZE/IgCML0GVDt1seZkY0/ki
 enG2/JRfMQ8uDYtv6ta9eOovCDyv1QoMVz7yft1DSWLf4wvHjPWbvc71jYaXK3QdS+nx
 hIBglSi8vhrOjGIiNtNJMNG5WAcEyueAopLX7VYFoKeplTy0G/mU5JwX1+6B//FJW8GE
 aichgTOvf7CzbuY/8K9E2FYETrkUF2VZ+OG3OUHAiKThlOeyg4edKl7rt9sg+fAsOuuE
 JmKg==
X-Gm-Message-State: AOJu0Ywc/eDnbAynS9FWTphyM3mg5ph7dRHpNOm9ZYHEYlGFn+9OxgAo
 fuTXLEElccgAmneeKRMhG5C+09Un9Q5sPNdkZgENR8vM00+hUQJd1MbNDw==
X-Google-Smtp-Source: AGHT+IFcLY8yA/vCzjycEdYGohWoZCib+pffxSmvqqoekHDpezhZ0FmuLQ+UDi5WlaeK0cUBkl9Djw==
X-Received: by 2002:a17:906:4956:b0:a59:d39a:8d65 with SMTP id
 a640c23a62f3a-a59fb95556dmr222797466b.21.1715190916911; 
 Wed, 08 May 2024 10:55:16 -0700 (PDT)
Received: from archlinux.. (dynamic-077-013-167-103.77.13.pool.telefonica.de.
 [77.13.167.103]) by smtp.gmail.com with ESMTPSA id
 a24-20020a170906671800b00a59c5a129basm4483821ejp.80.2024.05.08.10.55.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 May 2024 10:55:16 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v3 1/6] hw/i386/x86: Eliminate two if statements in
 x86_bios_rom_init()
Date: Wed,  8 May 2024 19:55:02 +0200
Message-ID: <20240508175507.22270-2-shentey@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240508175507.22270-1-shentey@gmail.com>
References: <20240508175507.22270-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62f.google.com
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

Given that memory_region_set_readonly() is a no-op when the readonlyness is
already as requested it is possible to simplify the pattern

  if (condition) {
    foo(true);
  }

to

  foo(condition);

which is shorter and allows to see the invariant of the code more easily.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/x86.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/hw/i386/x86.c b/hw/i386/x86.c
index 3d5b51e92d..2a4f3ee285 100644
--- a/hw/i386/x86.c
+++ b/hw/i386/x86.c
@@ -1163,9 +1163,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
         load_image_size(filename, ptr, bios_size);
         x86_firmware_configure(ptr, bios_size);
     } else {
-        if (!isapc_ram_fw) {
-            memory_region_set_readonly(bios, true);
-        }
+        memory_region_set_readonly(bios, !isapc_ram_fw);
         ret = rom_add_file_fixed(bios_name, (uint32_t)(-bios_size), -1);
         if (ret != 0) {
             goto bios_error;
@@ -1182,9 +1180,7 @@ void x86_bios_rom_init(MachineState *ms, const char *default_firmware,
                                         0x100000 - isa_bios_size,
                                         isa_bios,
                                         1);
-    if (!isapc_ram_fw) {
-        memory_region_set_readonly(isa_bios, true);
-    }
+    memory_region_set_readonly(isa_bios, !isapc_ram_fw);
 
     /* map all the bios at the top of memory */
     memory_region_add_subregion(rom_memory,
-- 
2.45.0


