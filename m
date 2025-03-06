Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9459FC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 16:00:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqDTq-0001W8-M1; Thu, 06 Mar 2025 10:49:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTa-0000ZL-80
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:36 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqDTY-0006O9-JD
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 10:49:34 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso5094825e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 07:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741276171; x=1741880971; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=T9ZPZ0rakYtLgiZY4tLzbdV2MvyXhoEkkzhYQQC1PVU=;
 b=dizTG2Hw5hOdlo0VKskexGG1KZnz5SUV9KdddhvOY02ShohnqGtfHDKPjSypEqXQ66
 OmhRWP5+sk0u33LAPPIS5fVVAhI+lmmzC0fZBuTU4gUwx4FnFBSnpVoLJtzbeJNo1X48
 61ryBsD9iF59VXDZ4WTwgQYXfUId5fM0itIXbpJaPXT9K+xZG3eILC8IwcbjDFztbcSK
 nrRhaqg0IekpeXD5zsb1ycNK+lT63GvIZ7CQtpzz8zi0oXd2hfBaVApyXhPPJHoW+Gm2
 Amx3W7QN3sbXc26V2HeOvY+t+Zzs60AZerINnw8UhmY2SOp47biMS9p/S6MxHY3gDpjY
 1sVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741276171; x=1741880971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T9ZPZ0rakYtLgiZY4tLzbdV2MvyXhoEkkzhYQQC1PVU=;
 b=obhx2vdwLcc+SJMmcToAu3kJR3K16mOxcmqWJkOa+rfgjpb172Rg6Dsz1rvL7kwqhx
 ZXtIpPoCiR/JmKtCXFrXm8f/VSixMmjJ69b/WfDMprMxE/m0Z627fARWMmSOLtpoOuFF
 e0dwRhmCzKuL2k0iGmOZ3oJbmlSO10HcMPTUcnjrvHh71Ids16PdsupkJwEKBU2tfiti
 I9xJ57RDdGG97W3iEvwDWR5sgefTC0ZzpIV7Nm1/WhL4mmOTeuBj/N7FxDLdMriinHFY
 bmxWTJss/lLb/kDCrgGKV8gPzLaK6z+PtMRjeYOViZ5dvNC+6ROQW4QMjxymZvBHZ5aq
 +7+A==
X-Gm-Message-State: AOJu0Yx7soqqK7+dfDHh9RG2614K4MoJ9Vs4f2WIGG6mHkQWeeN7Y2vo
 fHn3kfUhU5m3ahNJG3GgeH3q3mY67w+TeQAgXxUAD2Lm75WsSzmFuvvjnVCTxGql6EbTKx4dz3/
 pouM=
X-Gm-Gg: ASbGncsYyvX3ODE9+45ElvrL9nM1mrWQz9drQBRE92j+44o2nMbUFs0VVaeXC+porp0
 BxEeP0IQ73yldv3nV4ktzLCJLMdnFkbAy9m5q1C7ns0J+FV+OY4h9tFPvU8SOzy/ePoEFQrrMjY
 314X/9oL/dkzL1TsHnwo/PTnvxBppVXefQhXHH0LELeMEmKieMkX34Pd64Q7t5NNwpIWh2SH5mk
 0Us1HnemNxljJrgS0F9H1aXrBfqK9r+84r8/MDlrlQ//TFQHiTJuZDP6ceIV0ZVAUHVx+FpbZQV
 QD8glAlGiZ1Z1IkJBh+sjMbLx0e1fwsyTCIcK9xCeSFaG144pZJstB0fd/S2itYipdJkcPPgQgH
 TMAvSYOcJEcReVieLVgQ=
X-Google-Smtp-Source: AGHT+IFcD8DdxOAZn6AlSsTmuprTRVG4W42cw4E0uk0tVfkokEngaK5WldIA9pRUCwmxJeXNdlW/BA==
X-Received: by 2002:a05:600c:314c:b0:43b:bf6f:6eef with SMTP id
 5b1f17b1804b1-43bd29c9b7emr55241845e9.26.1741276170827; 
 Thu, 06 Mar 2025 07:49:30 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd91338cesm41488605e9.7.2025.03.06.07.49.30
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 06 Mar 2025 07:49:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/54] hw/core/generic-loader: Do not open-code cpu_set_pc()
Date: Thu,  6 Mar 2025 16:47:07 +0100
Message-ID: <20250306154737.70886-26-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250306154737.70886-1-philmd@linaro.org>
References: <20250306154737.70886-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Directly call cpu_set_pc() instead of open-coding it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250122093028.52416-2-philmd@linaro.org>
---
 hw/core/generic-loader.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/core/generic-loader.c b/hw/core/generic-loader.c
index d9f5c2e8325..d3a426a1a26 100644
--- a/hw/core/generic-loader.c
+++ b/hw/core/generic-loader.c
@@ -47,11 +47,8 @@ static void generic_loader_reset(void *opaque)
     GenericLoaderState *s = GENERIC_LOADER(opaque);
 
     if (s->set_pc) {
-        CPUClass *cc = CPU_GET_CLASS(s->cpu);
         cpu_reset(s->cpu);
-        if (cc) {
-            cc->set_pc(s->cpu, s->addr);
-        }
+        cpu_set_pc(s->cpu, s->addr);
     }
 
     if (s->data_len) {
-- 
2.47.1


