Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBC2C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:28:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgAE-0002y8-AK; Mon, 23 Jun 2025 08:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgA3-0002es-U4
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTgA0-0000zn-7X
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 08:20:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-453426170b6so30287035e9.1
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 05:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750681225; x=1751286025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jKb7+45W8wr+DNWypSxWBKVEj0bAIAzVgg/1Er2vy8s=;
 b=Vy6VQW1vnIP8en4NO/ga28+qONobaoTesil20hsfXcPhmt/uLwA7MdO1dhmhMO7wS0
 20hfqwgP+MV4ttN3JD9osbCCIBVVc+VNjcLgORgKltw12vgpEI1xB2hcAGh1cXpNQuzO
 /YePmIPdf9U8Qx1ohIdBxNlEUfjU7hxjOdtecFylzO38OmyvNMQ1TqakXU9DK//rQ00X
 kbb8LNRXgKFLnyolFQrHcDfoYLnTwWHBEsQAgA+8Xps9UAZ6eGbLgTVeW7B630I97pRQ
 +aq1rncp7pBwSCvMNEOJGSTMihOZ4n6VEpeNjCkxY80RimDkGOaRwebsjI8vwrBWy0ik
 PbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750681225; x=1751286025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKb7+45W8wr+DNWypSxWBKVEj0bAIAzVgg/1Er2vy8s=;
 b=tHxGZb6M7n4WR1c4SGyevL5uZZGjfRmZyGaCAl/TdhTokbJUcQZV7sgF+yni76ddms
 vCqhBaGTvcoDs5URHe+/HCHo9E+DmsboZEQe1ANDJiJjp7ZvnSlFYLjUQuehdIaqhKur
 MSGjlPJF+WQb+yQVZJ4u+uMZB/1ICzEqAuXRb06ceWv5oXKuuUs53Bosdrd48LFskUn2
 iTRteVJbezg1pOgiJQs/01EBi7DuTc1z1FGbWt5Awt7Z4KHigP3prYPtJcKg22RMgPCx
 hPpeS6bW7cVtTshMWnQjqIKDbu0fNkO21OlRnsuVSGSEBjEWJNFGW75zHHCvbkqCJ07u
 EZMQ==
X-Gm-Message-State: AOJu0YxoJR0K8IqX5u0plyM6xK8k/FGB+5sSn7SAH6+lbEWhVUYa0XXc
 w6gc7X0lo9vZTC4u8qpQDOFssJgpOny5S+L443dXBOnNJipuxaLsN3zdoKLZQ5zMrTcnwKqxcor
 S+GQ4
X-Gm-Gg: ASbGncvR73OFW7ixgoo6QKSj/T/KaUjBwGPkxWkHAEQd0N/lKMIJuSN1WJx/XHSKV5r
 0L26YIi+hNql3m30vrTFwHKt+sMLkKQF89FOUn02JFr2WHwWCHUcalRSrvQRyjDK2yEX28dQjDh
 c0elYW6hg9hXISrWZVEW6L/R08pQ/MH62X/nsdba9Db0c2WP1UsJ61HO6uD05tHDPLml2+6AlxQ
 SknLN/okLQ5KqvKonSfGi12lhJAthDtWBsFxWazewb9rOrTQF1D6tb1BfqZGtkOlpYvk1kaZZH+
 bmvNvkhNfLMcPDLDRRPn8MTlgbuwXolARg4c0LsyA+VztUzwSftgK0S6SlNt3RpULcHtCnTFIM7
 2e8ziuwVsXrZWsurcnXCK3e2TfDq4VNZKvJMghcCazG8nPVM=
X-Google-Smtp-Source: AGHT+IFKeCPKvJTY1oRMd774pzSdTPhl9ZbHhi8QfaLesPsg0MuI5svGt7VJgysSnyjP9cXdhnmSyw==
X-Received: by 2002:a05:600c:848e:b0:450:d79d:3b16 with SMTP id
 5b1f17b1804b1-4537a7e5111mr3528625e9.14.1750681224860; 
 Mon, 23 Jun 2025 05:20:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d0f189cdsm9446171f8f.35.2025.06.23.05.20.23
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 23 Jun 2025 05:20:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v3 19/26] hw/arm/virt: Only require TCG || QTest to use
 virtualization extension
Date: Mon, 23 Jun 2025 14:18:38 +0200
Message-ID: <20250623121845.7214-20-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623121845.7214-1-philmd@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

We can not start in EL2 / EL3 with anything but TCG (or QTest);
whether KVM or HVF are used is not relevant.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/arm/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index b49d8579161..a9099570faa 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2210,7 +2210,7 @@ static void machvirt_init(MachineState *machine)
         exit(1);
     }
 
-    if (vms->virt && (kvm_enabled() || hvf_enabled())) {
+    if (vms->virt && !tcg_enabled() && !qtest_enabled()) {
         error_report("mach-virt: %s does not support providing "
                      "Virtualization extensions to the guest CPU",
                      current_accel_name());
-- 
2.49.0


