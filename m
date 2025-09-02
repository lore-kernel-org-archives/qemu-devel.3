Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2886CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:11:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQmw-0000U1-I2; Tue, 02 Sep 2025 09:11:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmg-0000NN-Np
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:53 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQmZ-0004R1-Ld
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:10:50 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-45b8b1a104cso21156105e9.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818641; x=1757423441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IlCl1/WInAIaChnH1MrrsVEavnomBomGF3IqQHxPkXY=;
 b=UxvG76hEOedzc6/vYxvNk2h8U1EQ3a7niYZs+d67N+yVn0JHTjQaLuWmLdnUtI9SUN
 e6mtlRLkTzteW85pKrcLxkaD0QPDdax7X4NlvtOvmG5ESiVFxwqk4tTYSKMUAzwmg6pz
 z2GZjSHg3S+1Qogv3xsuPLCWQ1sQTlkOAWmSpuvzjcgGZ7WVNlHWcwuWlRl9ZxAHw09T
 kjUnf3MyEnAcUWh7ZnyrqXRKgGrm90HFHFIe+bHf3SRTE3zqAkxOxjtBCZdue4tDeHaW
 GCRhH403mq+RZ9NnpA0HwdObZ8ewahhJ+kIAqnJqIzM/c5lzm1MmDjrTIKZrrC2fvloo
 Pn9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818641; x=1757423441;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IlCl1/WInAIaChnH1MrrsVEavnomBomGF3IqQHxPkXY=;
 b=Fld9/LjiyPCUx6ADbqzF0emfQdF7g4m4Dg7nsbB2wrXpffnUEFXyUaeq3v6y3ZwjXC
 VGlmnbFCWlJsFpBDlRrBzjYnSm9dLeyo9OoZZNC8XOHGPLCv6LMAU2oiIMs4LLiX1U8f
 utmvGx+lz3L8qgDiiYpmZz2oEE68hGo4NlYspfUvTsovGjRB/RXJY+sUfPEznJjtL8JJ
 wLXFem+Z8jsLMDumtbUMq1FjG+NvoJmNlYcirQdyAy8NAXint1mJ1prG3qHagFTgFpxV
 JWnttPfoThSGt8WFmvJHA6h6cTdooR9og8pEWlFw1e2GGHCD0pJ+tm+2M/ps+6U7BRSN
 DSyw==
X-Gm-Message-State: AOJu0YwgZyyK9K/lD3rPjHQMKn8TRpZ368rZFOo5hFKYNio8Z/2Nchqm
 A9e2u4tkjfOm0xDfSxTUfREIo1GQ6FTxZjiIrHJzmmvGBZg4lROB8kIS+GY/l5m877CjCvh+x+1
 Ur3qV
X-Gm-Gg: ASbGncuCZ5PXePg/IinlMzrX4UeHLRSQXRcBcGvC0Fs1c05cQASpYwV2N3rKcxqm8+9
 IXIIiQBnK5KWoEy1UP5qYVkpBD1ol5xoCch2CPZOLowpqdtPzNXrvudEC+TPFSogH4iJPP0MA+d
 swkMOxhS6jvqBBbak0/hh49IMbj9rRhkY9z85btEK1tWaECznn60bxoymLAiUWLYxX1iOq3ITlp
 Ruo5LWrW//z8/Rrny3/fWk31BBw3vE5dhVMuD6xs4RLV6nT+B9VEyzz9LxGtm+mte0FqDxdlova
 ntK58BKPjkdw0GUHW+3Cu4Lm0OdDMYxxu2ORxLLJ0s3jgVlnkvrkzvX4kG6XXFLIY5LyzOC4b2I
 gCbpHOjTgrPIjF6YBs6af2IpHYHrssaC/zN5bzjtivgktEtqAKxt19F3eSM3KlHZsz3iVl48j5T
 yJ+UAH9R0=
X-Google-Smtp-Source: AGHT+IHKmYytacJpgYckzyJGgV5T29HadHdvpBRz3DtGPjA23ez7MN9ABHicBTvxjwQvZUnfo4SThA==
X-Received: by 2002:a05:600c:1c0d:b0:45b:9a76:ebea with SMTP id
 5b1f17b1804b1-45b9a76ed12mr13421205e9.20.1756818641017; 
 Tue, 02 Sep 2025 06:10:41 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e50e30asm198479935e9.24.2025.09.02.06.10.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:10:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/39] migration: compile migration/ram.c once
Date: Tue,  2 Sep 2025 15:09:42 +0200
Message-ID: <20250902131016.84968-6-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250730220435.1139101-2-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 migration/meson.build | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/meson.build b/migration/meson.build
index 276da3be5a3..45e9445f97d 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -31,6 +31,7 @@ system_ss.add(files(
   'multifd-zero-page.c',
   'options.c',
   'postcopy-ram.c',
+  'ram.c',
   'savevm.c',
   'socket.c',
   'tls.c',
@@ -50,5 +51,4 @@ system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
 system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: files('ram.c',
-                               'vfio.c'))
+                if_true: files('vfio.c'))
-- 
2.51.0


