Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8126DD3E77C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:50:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SLE-0004y4-LV; Tue, 05 Nov 2024 17:48:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SL0-0004xU-DY
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:47:52 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SKy-00048S-Ps
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:47:50 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43155afca99so1430765e9.1
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846867; x=1731451667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XJjfe10RbbrTnprCzmUrG8sh9BThAlZuJ9ZOYJUBh1Y=;
 b=EPk5RF3H3XagipFCtIj2cs3zn4kQwhmSHpwc2UqVGZ68VEtqb0EqZP+5hAU/WIbXeS
 Zm/VVYANp2tAk0MCKW9RVmB82Xe0h2dydCqfbzsmhzypi5lp6Sl87mdGbPh0I12jR8pj
 9Of9p14eEBpMqeHJpr6LxSZ4LJixFk3sVQFezULkJIHsm+EZpOvz0VCKOLw03+NCS6yl
 AtZebjA4A56tIkBUJjozmdP6knDYZ2dZ9ZeFFtuVywjsgK4mp8FVHcr7TZOdruBIl1/0
 zinxprZpJeJ0N1q6js7xqaYhh+zPNOCJbWr8Z1X0B3Za8+msmzL/mxqWwZ9G0Iq6t0GL
 IuBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846867; x=1731451667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XJjfe10RbbrTnprCzmUrG8sh9BThAlZuJ9ZOYJUBh1Y=;
 b=epIMuJLyCJ7dXLHYYi0Laq8lZfuzClx0M+gA/8SekxZD4B6kyfwhezQDn5EGexyXm/
 KenPQ+0dCO9tIMPXzg6LKgydfTYI6+B+VpUvQxFIqM7j8C2lUk8GlvB+S+yM/zywmBIx
 CvRg86aYHWPYeWUu5u76877mqCWdLldpvdEC3M7zSKxRRZSsF5i/MvYia30Z2Qc+5yEx
 j/MLQQi3J9uboyngXF8eJkg2TwoK/JQNqUJQtK0liNFn7HYe8NmTyfkh1yirY0RQ7pQu
 Ut5KSdPrRgSiSzwkJzZewUFLYd9Ole1v4Req1G01t1Qq9Jjcqimb4XUfHBXdYO3pwmPm
 0r2Q==
X-Gm-Message-State: AOJu0YyhHEmfWaHCNHQRISHvZVf7pViLvSqvJfLrf9JFiVl/118oEV8t
 HOLQnm4ILIbzDj3UWY/SsnzeDigkPNnMqpK5Vm+xTaNDu2LJOEBmoQdv/wQfM3gaYmu2Y+gz6ip
 9Nr19yw==
X-Google-Smtp-Source: AGHT+IGJivpiSWoUl7bN9neGOL6vZM8QQo5o+E7dXvTrURTUcEn4+UZcQOoP8vub7lB1GGuXUZA/mg==
X-Received: by 2002:a05:600c:354f:b0:42c:b67b:816b with SMTP id
 5b1f17b1804b1-432a9a67904mr3179805e9.1.1730846866924; 
 Tue, 05 Nov 2024 14:47:46 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6da94fsm1010815e9.29.2024.11.05.14.47.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:47:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PULL 03/29] hw/microblaze/s3adsp1800: Explicit CPU endianness
Date: Tue,  5 Nov 2024 22:47:01 +0000
Message-ID: <20241105224727.53059-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

By default the machine's CPU endianness is 'big' order
('little-endian' property set to %false).

This corresponds to the default when this machine was added;
see commits 6a8b1ae2020 "microblaze: Add petalogix s3a1800dsp
MMU linux ref-design." and 72b675caacf "microblaze: Hook into
the build-system." which added:

  [ "$target_cpu" = "microblaze" ] && target_bigendian=yes

Later commit 877fdc12b1a ("microblaze: Allow targeting
little-endian mb") added little-endian support, forgetting
to set the CPU endianness to little-endian. Not an issue
since this property was never used, but we will use it soon,
so explicit the endianness to get the expected behavior.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Message-Id: <20241105130431.22564-4-philmd@linaro.org>
---
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/petalogix_s3adsp1800_mmu.c
index dad46bd7f98..37e9a05a62a 100644
--- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
+++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
@@ -71,6 +71,8 @@ petalogix_s3adsp1800_init(MachineState *machine)
 
     cpu = MICROBLAZE_CPU(object_new(TYPE_MICROBLAZE_CPU));
     object_property_set_str(OBJECT(cpu), "version", "7.10.d", &error_abort);
+    object_property_set_bool(OBJECT(cpu), "little-endian",
+                             !TARGET_BIG_ENDIAN, &error_abort);
     qdev_realize(DEVICE(cpu), NULL, &error_abort);
 
     /* Attach emulated BRAM through the LMB.  */
-- 
2.45.2


