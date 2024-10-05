Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF90DCF8878
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 10:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sx1cd-000338-GZ; Sat, 05 Oct 2024 06:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sx1cb-00032N-P4; Sat, 05 Oct 2024 06:02:45 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sx1ca-00083Y-Av; Sat, 05 Oct 2024 06:02:45 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a98f6f777f1so379816266b.2; 
 Sat, 05 Oct 2024 03:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728122561; x=1728727361; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FlfgCRHqAC/sEcezeJf213JA2EVz0YP8aKw5zprtiRw=;
 b=An68K5E5MWnx8hw1I0/UtOhS5DAV9EkIf6rGjkxX2bdww8hh87r+zpAwGkZXtSNT+o
 J5tuOomhQeLlBO5jaRWWxwa6Kmpj4M6T83u3x6eRWTHk63VtaAt+VOUi0ZUh+3NoTboO
 K2m5XaqETYozRDJFqgB8W6QjVrEQaCEJL1ImGjXvsW/Y/FN4hqD8TXTbpgMHyzEM29ax
 CtA1pPFCpWV1XbKGdol2VGq7lzuiTCnni/Wbo9ycmbfwVh8a12GjSAHbUtXAG+onT2Lc
 fZuuBc3AweQIXVN7YCa/sshUlo+9swVeliTWyMM9WT2B6zS05vs5R3JXVHGwAwGzN9JA
 Orlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728122561; x=1728727361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FlfgCRHqAC/sEcezeJf213JA2EVz0YP8aKw5zprtiRw=;
 b=i6jUWBDVx1/lddPes4rfdE0Ezy4zY3JCIzTnCuwSzKRmElUEH4eJXMBGP9vZrYD9a2
 CHpNKhWY9t9yUAjTNspdrIA4iSBCwuN5H+dpmBamksiOYDXas8BVGxjJDRoV6ODVkKQA
 JByitJgNO0bJxgZ8Xw7aCrRs4d2sZX3c9DauiIlaKz5ixZoslg2QbtC70qDJDSe+h5Mv
 8tG/VlOqAnlG6Tox4SKNwYmeDPZQKQL2WZyYC82k+pZdr7O4hV+3/j98p82yjZPF43zl
 NCP5bbWGYUtpDNJglijSjGEk5xCEfFO1ZpBxib3lfLxsDgSYlhhJe2q2u+E+sAIFkGek
 h88g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUokoj8zlCYlx/Ml5mQLCgMoJH6cpQzL1sbUaDnHcFqxLz7KUgj0XarF2WiBuVMkTJQIABxNGe6Iw==@nongnu.org,
 AJvYcCXe/b1+Gym2LYuPt5kIxTj6GmSZa0apnOvdKkyoJezLfTLuTpTqjYGtiglzAuAAUpByVUUMDSSivPw=@nongnu.org
X-Gm-Message-State: AOJu0YxUcajQILwQTPxLELii/mf5zk3qqQ/U4c4aS/FLiGR/rtMUwdB+
 tW7Fs9wgMvI0uEtpjzF1cU5nBJZ6gsIfwwNiUKMaXyRQT4XsfKCppYwjUQ==
X-Google-Smtp-Source: AGHT+IHMoQ9v8Rkvx69V8iYHI9rane4ll62Z0YagJtFVZ7CePkpdFVrJZfJyfZjxUZG680y1TjWroA==
X-Received: by 2002:a17:906:c151:b0:a93:9996:fb16 with SMTP id
 a640c23a62f3a-a991c077de7mr569751366b.64.1728122560810; 
 Sat, 05 Oct 2024 03:02:40 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9932bf8a90sm99894166b.50.2024.10.05.03.02.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 03:02:40 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH v2 1/2] MAINTAINERS: Add hw/gpio/gpio_pwr.c
Date: Sat,  5 Oct 2024 12:02:27 +0200
Message-ID: <20241005100228.28094-2-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005100228.28094-1-shentey@gmail.com>
References: <20241005100228.28094-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x636.google.com
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

The device is only used in the ARM virt machine and designed to be used on top
of pl061 for use cases such as ARM Trusted Firmware. Add it to the same section
as hw/gpio/pl061.c.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 34fffcb5be..104264f04f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -656,6 +656,7 @@ F: hw/display/pl110*
 F: hw/dma/pl080.c
 F: include/hw/dma/pl080.h
 F: hw/dma/pl330.c
+F: hw/gpio/gpio_pwr.c
 F: hw/gpio/pl061.c
 F: hw/input/pl050.c
 F: include/hw/input/pl050.h
-- 
2.46.2


