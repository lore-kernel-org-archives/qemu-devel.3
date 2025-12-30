Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3BCEE01F6
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Dec 2025 21:09:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vagxk-0005tq-Tf; Tue, 30 Dec 2025 16:09:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxj-0005hx-15
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:03 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vagxg-0002H2-8T
 for qemu-devel@nongnu.org; Tue, 30 Dec 2025 16:09:02 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb2314eb0so7958246f8f.2
 for <qemu-devel@nongnu.org>; Tue, 30 Dec 2025 13:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767128938; x=1767733738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=g8lepc3JFLsk2Adb0qehzcmxR31oRBQl7MkEMoqLS7s=;
 b=PbKxCeZ7Ebyb/bigsKrt69m3GrmPKVwJ/9YkC4CGU3m+efSYAEzFHERxQBu8muZig+
 8xoJNaPed3H3ubyUthbof1dB9alteRhvUWmToG/nCFm8lewYwoLpDdhZRupEnmYygKqH
 GDtlvflvS/1AWpDOV2PGOTZOH2N25M+zH9N9Lfo8oRtT965cHc/17/FG492Sv+diiXTR
 n7ffcvCE1SttiuJOVRO8fcpV/7Y94yjpaxmAFHqkve2dyq1D/XnMw3/bUlOGVwwOm+jr
 Q9+mf2u6/lYEpcNqhr5qpjohebVH3AONx9DctvykbaoAkdrrCzkYIHs+IeaoE+hHdDi/
 qQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767128938; x=1767733738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=g8lepc3JFLsk2Adb0qehzcmxR31oRBQl7MkEMoqLS7s=;
 b=Wx2pYe635bjw/cC8tiVo0lKGn/fV0l2K6FsrTStmFhmCd084Pt5+6PfFV462KDfHmr
 p4YaoWOV62wFFPb/OjVuv/XNEJvVrQZphI7qZre1JC/GrKgmoE6JRFeuUrwtZcX+zKlt
 MP3JpZGhg6fvXGuIYAHUqs75nZvqKSsbL5ftnLgNaDKwYkJt1oUu5Ok8xx2mdsvqjXBK
 3Oyj91WoMSI7QY9y7fK79fFj8encTcEGK4G74hxKoleCZ8z7JXedgOsBOnxZoT0yG/34
 /3Em/NoxC6gLurYhv+UAwRDy1RSuS0RSgzivoPdg8j3RsWyrT/MdtOdtn3NpN/ryjj1P
 odRQ==
X-Gm-Message-State: AOJu0YxDybtfNuF8I2ukSUPFOFFlkHApuSvzskOiosQLlU+5OsBHCkQL
 tNwc8lMxwpH4bwTbvuJyPFZIHoXBlF3GYVqRve2Z3oXIIDNLn1+o8FEDS+eo6MWkGkvBJ78e0D+
 HBJA4rj0=
X-Gm-Gg: AY/fxX6hDuvrii7iPVPonmnLZk+I+a7diNJbn1WBUkmsPXpFpaCRJRNVCWKHb1Weao0
 UZm9v/Ep4YQs2dMFiS0GHN5h9e+9/5iiuJtt1yf7c84Idvms8neIYeN/k+HU21+MlhcvzKONSaT
 12BXsUaOkfRoaN2dxfth4ihmlELI+6nTIAKlopX2+Demk38gdiyM1Gd5OtodwJVrJE+buBxsuu5
 W5FaPz4qGLU2izo1sxq6iDEhnraFjekVsfctAXym7f8lWCyEwseOwX6qnVjYHOD4eNdP12EWIil
 SuL5jAwTzY2WFItx2RP2tb6drf+cg/aS8Eip+dO0IFMTv3Q4VNa//N4wGzcBpY/zvymLHieug+o
 DQdw3bqx9Wwr/jfchO7WTkutqXmMsWWl6Ke6kMjS15aq4kze60dSqjfYGa/PI8VihfBOl7c5Nhu
 V7Dq1FNK+Kh3WmSWawxvaeIkMB6bNOmCfXPHikwdXaPA1ZgcJndE/p7tU1z3iSznIQ70TWUvg=
X-Google-Smtp-Source: AGHT+IGJ8jxsIWiIgLvMXHSYh6YyQ+HUR3Nwasxe1g/pkPtMo96KB28WRpRk5l/PNuLZuySgeymByA==
X-Received: by 2002:a05:6000:288b:b0:430:f718:23a2 with SMTP id
 ffacd0b85a97d-4324e4d2cd8mr41655391f8f.28.1767128938286; 
 Tue, 30 Dec 2025 13:08:58 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eaa08d9sm70768590f8f.30.2025.12.30.13.08.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Dec 2025 13:08:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/34] monitor/hmp: Inline ld[uw, l,
 q]_p() calls in memory_dump()
Date: Tue, 30 Dec 2025 22:07:31 +0100
Message-ID: <20251230210757.13803-10-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230210757.13803-1-philmd@linaro.org>
References: <20251230210757.13803-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

Remove the last target-specificity in this file.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20251229231546.50604-6-philmd@linaro.org>
---
 monitor/hmp-cmds-target.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
index 7c8bddabbac..e782259c3e6 100644
--- a/monitor/hmp-cmds-target.c
+++ b/monitor/hmp-cmds-target.c
@@ -129,6 +129,7 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
     uint64_t v;
     CPUState *cs = mon_get_cpu(mon);
     const unsigned int addr_width = is_physical ? 8 : (target_long_bits() * 2);
+    const bool big_endian = target_big_endian();
 
     if (!cs && (format == 'i' || !is_physical)) {
         monitor_printf(mon, "Can not dump without CPU\n");
@@ -192,13 +193,13 @@ static void memory_dump(Monitor *mon, int count, int format, int wsize,
                 v = ldub_p(buf + i);
                 break;
             case 2:
-                v = lduw_p(buf + i);
+                v = (big_endian ? lduw_be_p : lduw_le_p)(buf + i);
                 break;
             case 4:
-                v = (uint32_t)ldl_p(buf + i);
+                v = (uint32_t)(big_endian ? ldl_be_p : ldl_le_p)(buf + i);
                 break;
             case 8:
-                v = ldq_p(buf + i);
+                v = (big_endian ? ldq_be_p : ldq_le_p)(buf + i);
                 break;
             }
             monitor_printf(mon, " ");
-- 
2.52.0


