Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E346C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:05:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr3I-00020O-G3; Fri, 05 Jul 2024 18:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3D-0001vC-K7
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:07 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr3B-0007Pj-IW
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:05:07 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52ea952ce70so357139e87.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720217103; x=1720821903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/s1ufWIHKbT/k12bZcQ9O/yldWRsZCWWOQ+K9vyl63I=;
 b=OKTOQm8f2OqHyH9Kf4dIkaW/dN+MHFMBTtJ0NlCcLZ9vwtincgrW9OLAZZ0ohcocA6
 7gTI2NFgO4QsrRuh7el9kSTtMl+Zjx0xnl7YozoSEhJbr5iK17ilRNmPlzOPFzjgOZ2B
 jiElmbaxAtpKLZ1Dd9r0RMRwH8fuNR2nnI854NYRGwD+Je6AKKlS4vqQ+w0Gbe89QxMm
 cTmibziqKb2w++vZTFHxljuyoFTrchUHV5aG9FR0VJRhmmjNh51cpxHRwS0mWV9fVN72
 z7BuzFc02vusln4Tm9G7sPwC7aDt6ZaaLKOYX9zIpJ57Chm4mabCL9bwA/gOph1OnwzM
 OPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720217103; x=1720821903;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/s1ufWIHKbT/k12bZcQ9O/yldWRsZCWWOQ+K9vyl63I=;
 b=HHjQk2xolyOdx0AyXHekTwYLQgMWSsolPM4Hp5uMDjneT2clq6hcAPOjAWogeMH9bZ
 pbl7X8RVsdY+u7MTAUCzXJI5k2kBVmT8YfJc6sdjMy8hiriCnBzPXlm4IORugBMD5DhE
 +RCsimLf9AVPcvad+BNoSLAmPFuj/OldZboSbPoftgqr25QNXHRQ/WPonGusWCCtvQvF
 3hddGaaqg0+QNc40Sf6O/EaX4k+8BMfVa0dmU7mUAE65C4WrAhqE+QMSO+Gp1MirKEww
 sAYi4trJGjKMaQ0JHmbnR2uBrL9/wn9dRL8T7xndAhKte+3yQ2wBJrDKA6LKRvPoAp9l
 UZBA==
X-Gm-Message-State: AOJu0YzJsL/E9jcmCgWp+2WTzAD2BJJamaC/80AjmD8hh1HcJ5mxdmEX
 jTB14JsRoxhRUly/Nx2gF8yJyKHrwT7Aq64nv0Ftgr95kx0flujUfvBeT/o5eMBzpCh/4Bh6+hf
 R
X-Google-Smtp-Source: AGHT+IHNSntyZsqizL1mH+Y9UuQzruccU2mp2CKSBO2zj87sSh1l25grNJlHdChv1TkDhBRdvcoE5w==
X-Received: by 2002:a19:ca19:0:b0:52e:9ad2:a311 with SMTP id
 2adb3069b0e04-52ea0628a8dmr4084315e87.19.1720217103253; 
 Fri, 05 Jul 2024 15:05:03 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a28d3dasm76262025e9.46.2024.07.05.15.05.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 15:05:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Subject: [PULL 05/16] hw/sd/sdcard: Remove leftover comment about removed
 'spi' Property
Date: Sat,  6 Jul 2024 00:04:23 +0200
Message-ID: <20240705220435.15415-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705220435.15415-1-philmd@linaro.org>
References: <20240705220435.15415-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12a.google.com
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

Commit c3287c0f70 ("hw/sd: Introduce a "sd-card" SPI variant
model") removed the 'spi' property. Remove the comment left
over.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
Message-Id: <20240703085907.66775-2-philmd@linaro.org>
---
 hw/sd/sd.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b158402704..53767beaf8 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2473,10 +2473,6 @@ static Property sd_properties[] = {
     DEFINE_PROP_UINT8("spec_version", SDState,
                       spec_version, SD_PHY_SPECv2_00_VERS),
     DEFINE_PROP_DRIVE("drive", SDState, blk),
-    /* We do not model the chip select pin, so allow the board to select
-     * whether card should be in SSI or MMC/SD mode.  It is also up to the
-     * board to ensure that ssi transfers only occur when the chip select
-     * is asserted.  */
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.41.0


