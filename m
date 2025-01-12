Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7B2E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:22:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6J4-0001sP-Dz; Sun, 12 Jan 2025 17:19:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Ie-0001CW-T8
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:17 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6Id-0006WX-9e
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:19:16 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-38789e5b6a7so2017194f8f.1
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720353; x=1737325153; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=axL74DBGZ6nBWb/u1b/AX04nS7YLLg7dL20DomACELE=;
 b=S7imJtZqEQHPLzqYCg/XFQ7VHfHveCO11DyAlBDPSrhn8P7Z30DKY70vXzQ0t+utfn
 uiLVendte4X84Am+e6Z7N+ak9S3XKZ31TqWO7e2u3nc2VKDscyqPS79A0d/9EspV3FrH
 k+gjyG6kIX5h92ppCL7GQ9tc/1lbAdOz+yQ6LR4o4Zm/pfF+jBk2OabzRj4yqJMLdyWb
 F+JYilcBTthwtyJAFs6s1vTmlpve4aqj1ssjRq4ygu0Or5pTWamv6Jp/N4QTxuUpkF0z
 YeuI21AKhHlaCeT6zUiYgCwn1yMJZtkw45HnSSwvpDACOoDhlA2YgV+TbRnR1heIU2JA
 eW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720353; x=1737325153;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=axL74DBGZ6nBWb/u1b/AX04nS7YLLg7dL20DomACELE=;
 b=juTEMbUSTIqoanbMmN1JGG9yx4DVnqKEdmnX8hFkRFvAZqBQ9RXJSuuhxqNtaPLP7x
 A7aoTmYG1XFUVTxiGQ5YvPmuHNn5FWqukggCizv0EkyjeaKWbH6pnrs5gP4mb9QpQ7bx
 5PA9VDM/ogueeBKToV4sQEFzvZNewNnif8RTc+KMKpqW2mL0GXvGpX62swAExSIol7MS
 asIAaWUEngq0imBAd6XE38QraMvQARXfdP2awSUQJoWks2LNTkAyFnYDvv23ZD1oAy3v
 hfewGIdzRS13j770L5VOY/dcVH6sjQQjGRrLKWJR/Jy/IWseizg0EVK4uKQrj+sGGrYn
 soXg==
X-Gm-Message-State: AOJu0YyIgXpCiskzCijnqd7uoZiY8DfwKvswWlL5oWuB+esJVMDVrvYG
 y8X9StgzPcyiimzxN1K5qP8Uzoj8HhG+9ckh5dl7eKU31XySZdoAo4PhZCIT2A8RfuU9mcSgOCA
 3bTY=
X-Gm-Gg: ASbGnctHvJ9EjgfidrxHNyui/A1qE8qfoegJ33wOf9XsEqUlRiuAbrKJtY6o20hQenV
 eQDEaigOZloDWIpcDNOf7HNgdIEdE5BKEwZknnL/5VslQ0MDDyq+zTg3Dz53rXn1qRM3UtuZEQQ
 ZZXPHlyWnaDZiPW0xrGeYdstw2ZRo4Rttfx8TkicJ0zow+vvDbRyIkWcYOGqWCCK68BFKPcGDMI
 0do3bcKkJ1Az9WR/3B4Ihf7nB+jzbjWTH3G7ehpMherY7dB/o4MZOuOC3yHfyTB5G7UPfpwc1pU
 GWBBkfG3JTf6n7owYeAjjNZI+mhRZVY=
X-Google-Smtp-Source: AGHT+IGFnhvxlPcYFIbq2Y7CbtZjDulvb4ZXsK9sSze1m/GYgHNG6bZQRWyuAT5BTrMCk4ZBC8EQAw==
X-Received: by 2002:a05:6000:402a:b0:385:fa20:658b with SMTP id
 ffacd0b85a97d-38a8730a17emr14616705f8f.24.1736720353110; 
 Sun, 12 Jan 2025 14:19:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4c1bebsm10626974f8f.95.2025.01.12.14.19.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:19:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>,
 Dorjoy Chowdhury <dorjoychy111@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 21/49] docs/nitro-enclave: Clarify Enclave and Firecracker
 relationship
Date: Sun, 12 Jan 2025 23:16:57 +0100
Message-ID: <20250112221726.30206-22-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

From: Alexander Graf <graf@amazon.com>

The documentation says that Nitro Enclaves are based on Firecracker.
AWS has never made that statement.

This patch nudges the wording to instead say it "looks like a
Firecracker microvm".

Signed-off-by: Alexander Graf <graf@amazon.com>
Reviewed-by: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Message-ID: <20241211222512.95660-1-graf@amazon.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/system/i386/nitro-enclave.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/system/i386/nitro-enclave.rst b/docs/system/i386/nitro-enclave.rst
index 48eda5bd9ec..7317f547dce 100644
--- a/docs/system/i386/nitro-enclave.rst
+++ b/docs/system/i386/nitro-enclave.rst
@@ -13,7 +13,7 @@ the enclave VM gets a dynamic CID. Enclaves use an EIF (`Enclave Image Format`_)
 file which contains the necessary kernel, cmdline and ramdisk(s) to boot.
 
 In QEMU, ``nitro-enclave`` is a machine type based on ``microvm`` similar to how
-AWS nitro enclaves are based on `Firecracker`_ microvm. This is useful for
+AWS nitro enclaves look like a `Firecracker`_ microvm. This is useful for
 local testing of EIF files using QEMU instead of running real AWS Nitro Enclaves
 which can be difficult for debugging due to its roots in security. The vsock
 device emulation is done using vhost-user-vsock which means another process that
-- 
2.47.1


