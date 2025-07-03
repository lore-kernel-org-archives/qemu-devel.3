Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C53CC83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 11:17:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHht-00024K-IN; Thu, 03 Jul 2025 07:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHfb-0006iv-S3
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 07:00:04 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHez-0003Ry-O0
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:59:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-454aaade1fbso8456825e9.3
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540360; x=1752145160; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zOj2l0QjwiOWVtDmZos93I73sy6okOj775eGXYWLug4=;
 b=oQrUm4pb+LdDuXdN0ImGJFQ+HIUc2rpf6No8bO9+WUv0KCWZMjoc9WABML+P7bmhGH
 hRJ/tSpgDiXWI+xRpcm6/lUEdxuCIbUZY2s0tq1DCGJMT9eUTGsCioxNOv+P9BVSt8pi
 fbgyZvOnzZ0piPuotyKXOoXWRWwYbVK3SjS/3/Nwon0RMT2L2hYdtGGSG2s5wMe0rirV
 pk6TM9deLlEASgCkB0E6sqxisYR+qh9Lq8JRTcAptrU8L9hTlPZ7vJpsVpu4cKeGDiIo
 4/0jS0QapwVf33MiXQcsNhcjRee9tjN9LseYzU+iZCu7+FI/UwRf/Scr/cOzCPOxAckr
 7cEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540360; x=1752145160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zOj2l0QjwiOWVtDmZos93I73sy6okOj775eGXYWLug4=;
 b=rB3fP43MJ1ZA8coRSS+0X909K0GBUTanUr+2y2Gkhof2pQV5UxaHqRkUWudxcaVfyK
 DkyOol0vtf/MQ+B05U19Ly5PZSxUQyTV+AAuhwvr7JUWAZ7d8fDUfy6MarXmU6zzgGEt
 +yGm7o6OJyutiKrnCbFCzWNxtuAD8QJm9moGrR6NLXJRtB/L3j9JVSEqVYARcbN+JPKp
 L1hCH+1/5SKgBaHkkmGjRRZLh+pd7Q+YMLblVkUQVsxl5lN0svKKs7BJ1qakZo967GKu
 0w/JmV3fPBmI+aS2IrC4I12tojZ3IsqGOsrEiPsETcfJYq7jNIANT26TNxT8c0xwLsLr
 QKYg==
X-Gm-Message-State: AOJu0YxLLVZXKuo6+SzmUPN81HmcHwuM3nwuRSkSzANsMdH2wYrY3adJ
 XVkZ6yLfgpYDdNJhWfvVvwbI4aLizo43dDEpZ59rO8nI/mCWELlJpzKJfFNqz13c8p1eIhLOLEv
 WcU+V74E=
X-Gm-Gg: ASbGncsfXU2dPoZzSTwpRjxKzDQ5tNC0uDq7rGNJeYAQT2OQQbakweE9egayqQ8Cd1s
 cQfiSv+Lmx7OlkNOIb5CRvzKg+rwBuC+2garHiRTVACKoXQ79cC3hdn5LGhVV0JYyKwhvcRqX0T
 3L2Q7zxP2b7K6Gju4q2O7a9L+Ax2u07QEqeQL3E5rx89FN9zjj7kWWTXMmAK+554CiteUiTaWdt
 2pNXhPUkPaoM6OhUP2Uwj44mk3u6nsj1cqjqDF4tkvgkqlVmAYyQqH/x/tCVt9+Fvai5beu796y
 zWNtyIlURaobqsk2kccPoSwpny0EofpIRwoC0+h+93a/qK74ZTHUPcLnZc9qz4n/hQFWNWXO+X4
 LEoMdEeoGnyM=
X-Google-Smtp-Source: AGHT+IHoayANiPOkuTLi8ug1zCVOH/mAiXBkNOtM7bZ4tNPWn87D4+AzaCT/cMsJ55dAh9k4I6N40Q==
X-Received: by 2002:a05:600c:548e:b0:453:5c30:a1d0 with SMTP id
 5b1f17b1804b1-454acdecbf0mr15392135e9.21.1751540359747; 
 Thu, 03 Jul 2025 03:59:19 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c8013fesm18582853f8f.38.2025.07.03.03.59.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:59:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 41/69] accel/kvm: Remove kvm_cpu_synchronize_state() stub
Date: Thu,  3 Jul 2025 12:55:07 +0200
Message-ID: <20250703105540.67664-42-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Since commit 57038a92bb0 ("cpus: extract out kvm-specific code
to accel/kvm") the kvm_cpu_synchronize_state() stub is not
necessary.

Fixes: e0715f6abce ("kvm: remove kvm specific functions from global includes")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/stubs/kvm-stub.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/accel/stubs/kvm-stub.c b/accel/stubs/kvm-stub.c
index b9b4427c919..68cd33ba973 100644
--- a/accel/stubs/kvm-stub.c
+++ b/accel/stubs/kvm-stub.c
@@ -29,10 +29,6 @@ void kvm_flush_coalesced_mmio_buffer(void)
 {
 }
 
-void kvm_cpu_synchronize_state(CPUState *cpu)
-{
-}
-
 bool kvm_has_sync_mmu(void)
 {
     return false;
-- 
2.49.0


