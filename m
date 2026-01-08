Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91961D148A0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdibl-0005FJ-AU; Thu, 08 Jan 2026 00:30:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdibe-00057d-8v
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:47 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdiba-0005Jb-8r
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:30:45 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-bd1ce1b35e7so1778383a12.0
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850238; x=1768455038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Jx3+JmsW/FzhhflfU5FCyyF06GpTtbOzQWX6MVGifb4=;
 b=S2ABaItuoC25uDuoT14c7CHeRXWlxEBkgXM58OQ0PO9rMjGk9h7BCemXINFWoxNoKx
 rQroQPJtdk+ZkNqTfvPQL+sXTmwumvjArgMzpAT6Xdk8i5RkurhtMvSUKsNfwAJop9WQ
 /szZ9zSEv/5AovSdR7m25ihmU4QEkJ0aGPnNy786MmgWPK+ya7Q3VKc944j+YAMoB1YD
 DwEcgC2gSVXy5iCpMzE6YmONHV2DpNyOS+vlwKw9N1MAaQ6iNwncsChCcJ0WFG5XsEpu
 xpw6DX6j/M8lVCffbHLhX4/wIlIolPMcMQQQvzqBrJvN7UOv7u5aBF6YBR7tDtvAEZxR
 HWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850238; x=1768455038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Jx3+JmsW/FzhhflfU5FCyyF06GpTtbOzQWX6MVGifb4=;
 b=w2mdSo+doecTYdnx0MLdaikMskT5zP/kC4LGll4eLUsFpQ3OG8XyYI/vRYWdVOJdNJ
 GZr13V0cecoig8m6LrF3exjSOd7CHnho9D4dbFDtr2LtpX2VsDjCHgHoAb7WeNtoiiNm
 X/PCfibwUo/3zZBrzSTlat2GPfDl3msjIvit5ksR124qP6lPZWsoWmUmiskEHKvCcZ/V
 DVnDGYuhTpB927bFu3mk3RfHMZ4FrZMjRl4Qt4edZaQRLPQMMJ0LLyOxxyxnoHD/90eo
 LyMrbr5rgpXk13mDOO/z3ugcm8KODnrTROxldyyfpwQOD2jEXN2R7Sb/Ko6QDHWZgxOC
 pwrg==
X-Gm-Message-State: AOJu0YykX/ve6Fs1Q4fhUdJIugWxed4n6ADn830r0CV9q/J72c0lWX42
 IJm5nmCoaSLjIvA5hNVRy7XS/g5RoB12mIePw56qqIrQhkZFdsqhrjoDz6QfMXcqNaq5iZz/MDQ
 J4jAEDg0=
X-Gm-Gg: AY/fxX7+DkYN5Wg+EZWsAZUhRGJtP8CM3i0JKjpjWhEm8FQUzsBdVchPExtMWUNXfXf
 tjJL7wM1DpVw7vFnNRJrKg50OWqY5Wo1+jpwdyDZajJd2qSN2p8RzzjL35OwsJOyiz8jpcC4DTS
 QXUYHNozzGh+77y/Bt8tPQzMwmNJg7U9q5Y8EOj8KObfsOMIsgdShwwYgVeKKGrpA8JoGZcd0vN
 uDISYILo4GhoTfOVv5RHUbRaBBSZI2t5dRG2xpu6Co2XTJJBlMGpRpR85cI3ltFaW/7HjE02nAP
 KL+n7r0pqsnlFXa7G+NugUwg1MCYL6cogUM93i0p4vp1rydGYx62j3AAqK+RVRZ5RC+U84CwfVR
 c1XpnArv0X5Lc51qwm5VfEWRPnluwWMYgscTPCmGbJpFnX0J9i5P1PXvnmuoCoZ5uuUVcE0s45H
 3cUz/vcZsO7MOJ35LeTw==
X-Google-Smtp-Source: AGHT+IGssL652wY39js2GzoyZoJS6e2axyPZvY/IeSlC5K6wnhFOPosNC3akmaX8aACcwyC6ldgwPA==
X-Received: by 2002:a05:6a20:72a0:b0:364:13aa:a526 with SMTP id
 adf61e73a8af0-3898f9bde7emr4605035637.60.1767850238268; 
 Wed, 07 Jan 2026 21:30:38 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c4cc05cd9d9sm7036552a12.16.2026.01.07.21.30.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:30:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/50] host/include/x86_64/bufferiszero: Remove no SSE2
 fallback
Date: Thu,  8 Jan 2026 16:29:35 +1100
Message-ID: <20260108053018.626690-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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

Since x86_64 always has SSE2, we can remove the fallback
that was present for i686.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 host/include/x86_64/host/bufferiszero.c.inc | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/host/include/x86_64/host/bufferiszero.c.inc b/host/include/x86_64/host/bufferiszero.c.inc
index 74ae98580f..7e9d896a8d 100644
--- a/host/include/x86_64/host/bufferiszero.c.inc
+++ b/host/include/x86_64/host/bufferiszero.c.inc
@@ -3,7 +3,6 @@
  * buffer_is_zero acceleration, x86 version.
  */
 
-#if defined(CONFIG_AVX2_OPT) || defined(__SSE2__)
 #include <immintrin.h>
 
 /* Helper for preventing the compiler from reassociating
@@ -119,7 +118,3 @@ static unsigned best_accel(void)
 #endif
     return info & CPUINFO_SSE2 ? 1 : 0;
 }
-
-#else
-# include "host/include/generic/host/bufferiszero.c.inc"
-#endif
-- 
2.43.0


