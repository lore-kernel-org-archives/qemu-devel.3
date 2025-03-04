Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81FEC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpahP-0005bC-J1; Tue, 04 Mar 2025 17:25:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah2-0005PT-Oc
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:53 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah0-0006Vf-NV
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:52 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-abf518748cbso663490866b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127088; x=1741731888; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kU8wMZNvEzgPbmwhpM6JkBirf3HCpj8nA5DxvL7UJOA=;
 b=DSBgLkYMBgHQIT7ghy2tn9YarNkeA4X7JmKOfeOMeav9yM4wJhlP3WQx03PDe3CcXm
 iZFoZk7Y+dOPSdDURpjVP6DpmRtQOvQOgVduZ0dpckZAmQpKUq3dsvS3T4AzZnLZKE4c
 JtceniQ6fKAwdT7O2qXqCxdDxVv/yOUn6BDuieY01dDsyNrgP7gHdCCJde2VTPjWyKAq
 PzUHdiEpYWGBzLwL3J7kCMxfiWKLDnWT2Pfm4d8r3hcJ2Hh5QkpKAIZKAhSdphoAn0B/
 3nZ9w4J49+S0LDiKhMuiKHjBszxzT6gfxWQk93osgd4iQaBbc43Zt7uy0jYZxZaF2Hx2
 L/DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127088; x=1741731888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kU8wMZNvEzgPbmwhpM6JkBirf3HCpj8nA5DxvL7UJOA=;
 b=BPwx28k2+dscs/qSCbwCAcI+USUCYhw3AaPPavffFyCiwqdf+KwXs2zawMtUXOGnKb
 KTYz9nu5Em/+jJyTmiQXyxwLu09bXAfHmqN/oaoqZs5Q3138IGLWgUSdK7Yyncf/UzY7
 RcpxaNIlc90FP80Yg77fypI9aneUPKMrrkHYXQ8mg62+AzkE6DSLKmDcMQbnQcWCe3KA
 YvmrDABgf3EmEnYBA5MoKehDZcV56yeTlM1ztvSTZTljM5GuSkCl00nam4XfYwTZbAi5
 tkNxHhO7vgQDZtDb8YbTG9nZAFjJ1bU6yAGoRdKxDpsXVWvvphqjY5fgZtm85QSIpa8K
 iU1g==
X-Gm-Message-State: AOJu0YyZvVuqNzZn1TtUdoB2i9G3jhQlfAbL0ZVMbc55I7cNkQBXYY3p
 MrO/tJTlIJqIs2ZkaTfj6r1m5fciZSJmPM2VpleQ/6xEfO4eWQGo1iAZUd/JU2E=
X-Gm-Gg: ASbGncsCUuGE8ftRVriH9rEQPMxhLfR9TeHKaEoHtIyoMP37XEfFUmKqz/xxWJkP9Kh
 x9uMa08N+YTsVeIp6KsCTUUyA+RooAwZNZ2DXgQr//2b1/bB688kmNlSnwgrgIVMWHqyfH4rINz
 ZUxIlRoePTL9a7QPUJKLNVBd6+BkNBEJ0vZXGsy55OjYxf+F5fZ3LnWUb1b83YLAQvbuhuU1JJG
 miFkihehGbdB/R9DruL7D1FuweuV0naTIc5KCs0rN9EYvtWRe57NmiMug32ZezkVXEvrH2/EZ5+
 MvHT9qE3B4JuhT8Yn8+sauQxcbuimpQ5377nhuzwhajc30k=
X-Google-Smtp-Source: AGHT+IGfbmf9+7XS7F+SL5+TYvKZ5+ecSkv3uYZewFzRDszMnhO/LR7/tEd+M4U+oGWEtgUPzNCHFA==
X-Received: by 2002:a17:907:728d:b0:abf:6e3b:4b4 with SMTP id
 a640c23a62f3a-ac20d8bce38mr75190466b.22.1741127088015; 
 Tue, 04 Mar 2025 14:24:48 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac0e1fb5588sm357045766b.18.2025.03.04.14.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A1D5D5FE0C;
 Tue,  4 Mar 2025 22:24:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 12/32] tests/vm: bump timeout for shutdown
Date: Tue,  4 Mar 2025 22:24:19 +0000
Message-Id: <20250304222439.2035603-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On my fairly beefy machine the timeout was triggering leaving a
corrupted disk image due to power being pulled before the disk had
synced. Triple the timeout to avoid this.

Message-Id: <20250226140343.3907080-11-alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 6d41ac7574..9e879e966a 100644
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -83,7 +83,7 @@ class BaseVM(object):
     # command to halt the guest, can be overridden by subclasses
     poweroff = "poweroff"
     # Time to wait for shutdown to finish.
-    shutdown_timeout_default = 30
+    shutdown_timeout_default = 90
     # enable IPv6 networking
     ipv6 = True
     # This is the timeout on the wait for console bytes.
-- 
2.39.5


