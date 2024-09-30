Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA94CCF6497
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Sep 2024 08:45:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svAzl-0004Ra-Oe; Mon, 30 Sep 2024 03:39:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svAzG-0004Av-8J
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:38:32 -0400
Received: from [2a00:1450:4864:20::436] (helo=mail-wr1-x436.google.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1svAyV-00009T-5d
 for qemu-devel@nongnu.org; Mon, 30 Sep 2024 03:38:19 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-37cdac05af9so2062353f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Sep 2024 00:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727681762; x=1728286562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zn1QOBKpxwHC7pwp1nDkwIemv7qUJthxbF0WBocU5ZE=;
 b=vbqqrfJsm9kB5r/lSvVVwyyqRkJpsM4GtfPs4XpiHI1pmBjjZsQae8l8q8nLZSTPFE
 L0PwIn4O097hCvRm0KzpZY2ZGbTeCu2WmXBo6RzEvU9cX+z7Z3DKo7PqjKwtOtEJWfjo
 Iuhwg7X1NtJiTe+LPmMMeL82cUFZIvWmxcS4RBa58QVSixjlycgzRr5fo+rzo/5i00WE
 CWKJaShmXxDuP4AjFe/KEKE9XfjOVG8e9nxPhpgFfdXCYOti9PO18TuhRSPW+a2lrD0o
 MgVyyrUZvOnzUYPF4DKj2M8N54HHMqrT+K1lzKJcbzsKnENJJLP5d+n8iIWzDCQhih/E
 hbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727681762; x=1728286562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zn1QOBKpxwHC7pwp1nDkwIemv7qUJthxbF0WBocU5ZE=;
 b=CPKlBAIo+bzZsd+7EFaqqvBKAXhahijdThC6wMzDpjnsEx/KQHs4wstaQ18E7rTClv
 RhK/js2Xu/s/snQnuWLe6jzCrChWm1VHSTbz/35fyj8gZQabqyBIwZxbR91WiglBYJDQ
 4GAg9iAIBkj3fwnXprAeDQwvl2giVZRuF8yVbhpIB0L28YnWVK0L9DkcwvxqJAOwIjH/
 SioRpsNqRRru9j2dOKs56rI0xaEiW7jRdZVTzahqsowbTfZLVmgMuWSb338k556ea3EU
 xEbN5LnF6D0MNroSVsRCXZYk35QC13L6OrEuANDMRzDRMDHHeZH2+tplbGghYYee4RkB
 fQGQ==
X-Gm-Message-State: AOJu0YyeOmM3n1JNdjWfNbDMWH1J9QjhIpyngfljJktaMEWGHHJ6LnAL
 Qaetq9xBxJZafen6iISs7bA827hlFtfyxMqgqTIzbTZQfcUfm80fOa0hNcDuOpA3FZPKdJzJPWi
 DnMY=
X-Google-Smtp-Source: AGHT+IF/2ju8dp/hlgQNQQYphCSWWra4wcESmtISLsZng/9+YCPMt/FRqGKyK9eINYIKLWFa++fX7A==
X-Received: by 2002:a5d:414c:0:b0:37c:cfbb:d357 with SMTP id
 ffacd0b85a97d-37cd5aa681cmr10399551f8f.30.1727681762102; 
 Mon, 30 Sep 2024 00:36:02 -0700 (PDT)
Received: from localhost.localdomain (186.red-88-28-13.dynamicip.rima-tde.net.
 [88.28.13.186]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd565e881sm8323063f8f.44.2024.09.30.00.35.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Sep 2024 00:36:01 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Jason Wang <jasowang@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Peter Maydell <peter.maydell@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Sven Schnelle <svens@stackframe.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-arm@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Paul Burton <paulburton@kernel.org>
Subject: [PATCH 08/13] hw/xtensa/xtfpga: Replace memcpy()+tswap32() by
 stl_endian_p()
Date: Mon, 30 Sep 2024 09:34:45 +0200
Message-ID: <20240930073450.33195-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930073450.33195-1-philmd@linaro.org>
References: <20240930073450.33195-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a00:1450:4864:20::436
 (deferred)
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RDNS_NONE=0.793,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

Replace a pair of memcpy() + tswap32() by stl_endian_p(),
which also swap the value using target endianness.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/xtensa/xtfpga.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 228f00b045..521fe84b01 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -438,11 +438,9 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             const size_t boot_sz = TARGET_BIG_ENDIAN ? sizeof(boot_be)
                                                      : sizeof(boot_le);
             uint8_t *boot = TARGET_BIG_ENDIAN ? boot_be : boot_le;
-            uint32_t entry_pc = tswap32(entry_point);
-            uint32_t entry_a2 = tswap32(tagptr);
 
-            memcpy(boot + 4, &entry_pc, sizeof(entry_pc));
-            memcpy(boot + 8, &entry_a2, sizeof(entry_a2));
+            stl_endian_p(TARGET_BIG_ENDIAN, boot + 4, entry_point);
+            stl_endian_p(TARGET_BIG_ENDIAN, boot + 8, tagptr);
             cpu_physical_memory_write(env->pc, boot, boot_sz);
         }
     } else {
-- 
2.45.2


