Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3BE5C44536
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 08:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viqTK-0000GO-8C; Thu, 22 Jan 2026 03:55:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTI-00009B-TB
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:20 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1viqTF-0006EK-Qz
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 03:55:20 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so7007165e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 00:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769072116; x=1769676916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JuUfx+y6OuCiabH5jy3bbyweJaTYApNAgj7UULpRRAA=;
 b=fczXYn50hGNC/M5KAvGIHyFIml/TQlzYplZzexrl8KfH3+JJk3/qxe9Njg2XpreeHU
 ImUX6iiMEgaEXBHcJzU3kRqE7GyuevnEwfB8/VCQUHKhJRYfY1+PcehiazttXYXpEYRH
 UdvqPOrZFnzA8KocW7o/Wmh/gX6Dq9lisIRVlYr6esGn8Tesfpb5aHwW1CMuBR+DCNjj
 U3wCtneCQz6BtOB6gNuX4rkmhVErRNic+0xNJBlRyhPgNcutbg0TEFkHjhN2E59IrHQz
 88VXLsVm8aw1nIXKte/TrUYu2AQuUBotHohG7GYwdAnvFCRMlUBx7k8kpP/LZpXrhKH6
 6VAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769072116; x=1769676916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JuUfx+y6OuCiabH5jy3bbyweJaTYApNAgj7UULpRRAA=;
 b=H9xWaqnIvBbCVNSlyFXmlL0ybbJfh6DGBDCDCWBJ0u1/NBNbyk1dQqo0RryIHbbvrI
 TpH6J+GuO8qICTub4IOMMEegb+Zz8FJ1GFAU1a0SPebfJWuzs85ykXESzdMnWAMBE1fp
 IOcwmOvlAYfzT4TLdtzxuv0Ygy0aNss8XfOSgHKeFzokvFApdmeH//icvmtGI1IwSI3a
 a++kSKTMUIrK4BdW50pFkzAvADRsXBqovY8Y/TEoWG2X/6jhsbd6/kO69yRg76bm/vMY
 KywN/G0MFwtNuyt0Y2q4CpoFHnvmsvFQ15GPssev77SarIR1QBFyaZnrg5Yj9KaT0YZk
 yZ+w==
X-Gm-Message-State: AOJu0YzjNQ289mQcrbI2rodF+J9s5KOlKO53UTYdMGTU9YbIHKZBjITp
 6mH0MHeFivy3lyjXKrIQquGSRFYCj4OR/7VSnKbvC4CsDVDgl47ztu7KBKHGfIN6X3mStYjJCN2
 T/OdagMI=
X-Gm-Gg: AZuq6aJ8SShutqXR65OQArTrqj22Zds5Qz6IUqBTPGvhk0wsNAQMOt1rDUZOQWy9j32
 YzjvpZKRKw96+Cc76tldzR0/Px/omDadkpYWrIpEdDx+iBU1K5cMfe7ctgB3nkIPXI4w3zeOZw8
 OK7VhT70UmSNaz0XdPUHsGtwUV/tUhtYPJQzhg1yCiQFs9RHR6gTcfoNtcvU60NPJUPnvNldiPk
 m+cXoQzqArAg9ELiXPPSfLXvoIAZjkyeETsEdeleH9tQB8Uh4zJlTg8vCZC9Cy+lxlR94lF/qCq
 CQHm+bC38F+tqW1foLAgKdPjr+kMEYFjtFdpafhGK4vCamk4OEL5d2n1eDi8SOK0/en6fgq8Qb8
 5JtTJEJ+fnfUhTIJ/QA2qe/qQVfyxGRSwtLGakBzYoRbEPrHE7PEJPsfwWRIp+GsMdU3VlrhULs
 UjcyENpEPreyMlRdEl5MBVOoX34zh9Iks7nLqRAXDKE2PFKPXVBJfSX7tgGoa7
X-Received: by 2002:a05:600c:4692:b0:480:3338:2939 with SMTP id
 5b1f17b1804b1-480349dfa7dmr189483925e9.26.1769072115627; 
 Thu, 22 Jan 2026 00:55:15 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992c6f2sm41490928f8f.19.2026.01.22.00.55.14
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 00:55:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/31] configs/targets: Forbid LoongArch to use legacy native
 endianness APIs
Date: Thu, 22 Jan 2026 09:52:44 +0100
Message-ID: <20260122085255.95035-22-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122085255.95035-1-philmd@linaro.org>
References: <20260122085255.95035-1-philmd@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

All LoongArch-related binaries are buildable without a single
use of the legacy "native endian" API. Set the transitional
TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API definition to forbid
further uses of the legacy API.

Preliminary commits allowing this final change:

 . 6b4c30465c0 target/loongarch: Inline translator_ldl()
 . f9a03787c7f target/loongarch: Use explicit little-endian LD/ST API
 . 91312a6d046 target/loongarch: Inline cpu_ldl_code() call in cpu_do_interrupt()
 . 492b2799c64 target/loongarch: Replace MO_TE -> MO_LE

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
Message-Id: <20251224161456.89707-9-philmd@linaro.org>
---
 configs/targets/loongarch64-linux-user.mak | 1 +
 configs/targets/loongarch64-softmmu.mak    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/configs/targets/loongarch64-linux-user.mak b/configs/targets/loongarch64-linux-user.mak
index 249a26a798c..4ea12794705 100644
--- a/configs/targets/loongarch64-linux-user.mak
+++ b/configs/targets/loongarch64-linux-user.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES=gdb-xml/loongarch-base64.xml gdb-xml/loongarch-fpu.xml gdb-xml/
 TARGET_SYSTBL=syscall.tbl
 TARGET_SYSTBL_ABI=common,64
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
diff --git a/configs/targets/loongarch64-softmmu.mak b/configs/targets/loongarch64-softmmu.mak
index fc44c54233d..38c0f68ddbc 100644
--- a/configs/targets/loongarch64-softmmu.mak
+++ b/configs/targets/loongarch64-softmmu.mak
@@ -5,3 +5,4 @@ TARGET_XML_FILES= gdb-xml/loongarch-base32.xml gdb-xml/loongarch-base64.xml gdb-
 # all boards require libfdt
 TARGET_NEED_FDT=y
 TARGET_LONG_BITS=64
+TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API=y
-- 
2.52.0


