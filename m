Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECC3C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag3C-0002u1-O5; Thu, 15 Feb 2024 13:01:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2y-0002Yb-6q
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:24 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag2v-0002TG-VO
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:01:19 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-55ad2a47b7aso1689590a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020075; x=1708624875; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k1XGzrffCcMjvoN7zlMmx6bS790MXe4X9nuc6CTe+o8=;
 b=sHt9HgiAQpzX7eJs1ZoUh99I9nr8gaImXAQIb9xnNzoLzgOgj5wZpEBIwmkoWQ18o4
 hVla+BJdVxTv1khjmX3CVka6weZJ0sfAAOL0wgbSqciE2vPeO5orO+qypeCaIP1qiY65
 PqDs/b5FPbnTJXkAhE1hpvb0+77c0AAHJLt1pgmkB+3NiMGxVulwT3N3yIGentbkhMo8
 2iJNRdYQxdxfuUjvxKbFr/tOgf8LSNOLDRHf9g/6D2HqEbMypYRYufwoBpbZcJnaUsfh
 RC8jEGZ6CVBzA7G43e1CMRR/i5h8SLmkFGDz2qZ0I7wzfVqJrQLRVg44ctx3DbuWkHAv
 LOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020075; x=1708624875;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1XGzrffCcMjvoN7zlMmx6bS790MXe4X9nuc6CTe+o8=;
 b=cOVlcxAzH0m0bYdKByU2f0bl997QaJ9OqfnRrhjpS2XQnbg0+ynFK4ptPXcrE0q65P
 PiVsZnqt3SA0b86UFFBaZcrNmMWiAeSSti8b0BUYjhxTO2izQZ6txxQMpCKRH+KShhvc
 8LBc6bhLVTxqYPGstJ7P49LdGvMkJYVF+wNrA8DNIfl0w3pnqBWzHP+fLlaI18vPNEp5
 tsJdTmgho7UTmV2eqTNlEwim8UO8f9+I2wULpI9a8TBTVXGoMr/4ADIwCw+22JkKgfMi
 1QsqGdC9YNVI1w9knLQO3ElO8fuxOocwqvDKBRRqqDGwpd28+5mmVI2dortIhq9aY/p4
 eJ+w==
X-Gm-Message-State: AOJu0YyWSZGENhLzPJrqP4cPbIkeO6qKoxmXDJ0chYE9o85CEdO1pKOI
 lMrGS556uf9SI8wMJbBK4KMTwGeY50KSfL6MV8h5TlKn0+ygUjCb5cRMo5Sn8uMIZ1pzhclPhgW
 oOj4=
X-Google-Smtp-Source: AGHT+IEa4kdqJXxc8uhXxbM/UKeq0kuNnYm9CERkEulyQmRYMz7yb69kgeYceB34SjvhHmBQ9uH6Sg==
X-Received: by 2002:aa7:dd08:0:b0:563:d32f:5442 with SMTP id
 i8-20020aa7dd08000000b00563d32f5442mr493928edv.5.1708020075205; 
 Thu, 15 Feb 2024 10:01:15 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 et5-20020a056402378500b00563c63e0a13sm400264edb.49.2024.02.15.10.01.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:01:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PULL 30/56] hw/sparc/leon3: Remove duplicate code
Date: Thu, 15 Feb 2024 18:57:24 +0100
Message-ID: <20240215175752.82828-31-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since commit b04d989054 ("SPARC: Emulation of Leon3") the
main_cpu_reset() handler sets both pc/npc when the CPU is
reset, after the machine is realized. It is pointless to
set it in leon3_generic_hw_init().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Clément Chigot <chigot@adacore.com>
Message-Id: <20240130113102.6732-3-philmd@linaro.org>
---
 hw/sparc/leon3.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/sparc/leon3.c b/hw/sparc/leon3.c
index 2dfb742566..1ae9a37583 100644
--- a/hw/sparc/leon3.c
+++ b/hw/sparc/leon3.c
@@ -343,8 +343,6 @@ static void leon3_generic_hw_init(MachineState *machine)
 
             bootloader_entry = memory_region_get_ram_ptr(prom);
             write_bootloader(env, bootloader_entry, entry);
-            env->pc = LEON3_PROM_OFFSET;
-            env->npc = LEON3_PROM_OFFSET + 4;
             reset_info->entry = LEON3_PROM_OFFSET;
         }
     }
-- 
2.41.0


