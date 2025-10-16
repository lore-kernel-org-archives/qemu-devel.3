Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16074CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Mun-00078a-Oo; Thu, 16 Oct 2025 08:17:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Muh-0006r8-Vm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:17:00 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MuV-0008Fa-TU
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:16:58 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4270491e9easo45419f8f.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616997; x=1761221797; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s/VgKDi/AmTRxccR3mAlzawFNzbduYz91OdfcZBf1s8=;
 b=J3nbZ5UqJvcF7PR3fcibBM9sDif+ugh7PPKTRU6083y2+3WoHZVb7b4muedKDkw3cq
 qsKyyAd84wXYjcnyUN43bdLZeIMptIiWC+3jcRllIIYx/9vWy0Wlz0CilSve4RSappok
 4zSdxeFxBHRawwOISoO8fiTJeDMd0Dk5f5QUhyaS+jyGhpYPoRj0OG7AZY8hQyDuKI4l
 fPjYKqWWlnzS+Cq71AylNp1ZWYjihqWmBUlUWihaSMzkOtrK6qhCyV8HdO3CAy2Som8e
 Mu1lx0Rnq8gOKkGQ1fw2VpohG6uGFYYUG0mHjWu59WXSkIvzQXR727ERSnjd2kdt5szt
 4N4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616997; x=1761221797;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s/VgKDi/AmTRxccR3mAlzawFNzbduYz91OdfcZBf1s8=;
 b=V6H7BnNfr5N9vLQikBSFIGwYXNtfSoj5TJZVP6js9j4SpEI5XUnB9dzoHBOmRZzJX9
 K7GWfpi3jmUQk136fCztzQsU6/bbpZlhNhj/FMwD/bNzPBZuFI3ox5FRfl3IoAaBiuYL
 lrSfiSoyrlqcWYvcB124pr19caULtakBp4dxrbbomjknLMfYtkEpUMe7TSsFk078WOES
 DRTItK9d3vhjzY4QxNDF32gdFmDyC3CTV0ir7sqDB2xJWAMSLIUZit5LmeZXFSrPN74H
 265i+KhYm1oAkoz1J5aCYFtd4m5p+IWvsSG/rYn57WlE52jTSoczujuO3xpytLgRJjKG
 24Wg==
X-Gm-Message-State: AOJu0Yw+C/Yyr1wetsBRfxYbb3yZAGUtlJGF1gPfRVqkK+PJIx2xsSiC
 XDiaE79dxKsIksmLOHdB7qvsvsEpnXLTtk1WEcDYS0TDUNnYYT7Ka2ppWXSyM51BILGNV3KQeF2
 gqGWHXG4=
X-Gm-Gg: ASbGnctIeocNphbEotuM5FpEwkiAIvxPxc1W8iSLXKOsnImH9WxLAJs5rphDR3O3lsV
 RssjSY/zwVN97v+TDXUj41LXea602vEXHqQIE5+WN3VXX6l9C3BvktPEhy2vNWwS3Bh7KcKzM6M
 00WjvLCe5D2J0mZG0z9z9l8l7BSy3Lfg/U2MqkfVGTYHqfTM9uW/0funfQGdLFdcFOgqZNqpmm3
 pG+0WqQRBOV55StJPWaHHqqfYxi9tJiz6F6zJdO9lmIZnqN7oyfqt819qICb0QWj41OjVfJx7CS
 Yc6DW4QgeyhEq85TckWyxlP5HueJ+RwTZpYJHB9S+tJDK1Ua0Y8UYaVf2AYc5xoA566o8xsdv63
 MhQ5EGMB9Y/zzmtW4H1aCIXMVyR39FsD+usyQB5G0WuNIZSQjg804sAdfX+UeeVrQhEb7qAri5/
 wIeSRdMO24lUUjyG+yatVAcOfjgpwA5Z4Araxh8YuJCDp8n3eoeRy4gw==
X-Google-Smtp-Source: AGHT+IFvMlka1BC0GKosIwVxAwURgWiFsYaFDIwU1chkQBwATQ+ULGPGYAAgIpXMjNKKZEcVQJ/1aA==
X-Received: by 2002:a05:6000:2203:b0:425:57dd:58c4 with SMTP id
 ffacd0b85a97d-4266e7d7eb1mr23208997f8f.26.1760616996712; 
 Thu, 16 Oct 2025 05:16:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583664sm34770776f8f.22.2025.10.16.05.16.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 16 Oct 2025 05:16:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/75] target/hppa: correct size bit parity for fmpyadd
Date: Thu, 16 Oct 2025 14:14:29 +0200
Message-ID: <20251016121532.14042-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016121532.14042-1-philmd@linaro.org>
References: <20251016121532.14042-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

From: Gabriel Brookman <brookmangabriel@gmail.com>

For the fmpyadd instruction on the hppa architecture, there is a bit
used to specify whether the instruction is operating on a 32 bit or
64 bit floating point register. For most instructions, such a bit is 0
when operating on the smaller register and 1 when operating on the
larger register. However, according to page 6-57 of the PA-RISC 1.1
Architecture and Instruction Set Reference Manual, this convention is
reversed for the fmpyadd instruction specifically, meaning the bit is
1 for operations on 32 bit registers and 0 for 64 bit registers. See
also page 6-18 (fig. 6-8) and 6-19 (table 6-16), where the f field
for FMPYADD and FMPYSUB is documented. Previously, QEMU decoded this
operation as operating on the other size of register, leading to bugs
when translating the fmpyadd instruction. This patch fixes that issue.

Reported-by: Andreas Hüttel <andreas.huettel@ur.de>
Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3096
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-ID: <20251009-hppa-correct-fmpyadd-size-bit-decoding-v1-1-f63bb6c3290c@gmail.com>
[PMD: Add documentation refs mentioned by Andreas K. Huettel]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hppa/insns.decode | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/hppa/insns.decode b/target/hppa/insns.decode
index 4eaac750ea8..13c6a55bf2a 100644
--- a/target/hppa/insns.decode
+++ b/target/hppa/insns.decode
@@ -365,10 +365,10 @@ fstd            011100 ..... ..... .. ............1.    @ldstim11
 &mpyadd         rm1 rm2 ta ra tm
 @mpyadd         ...... rm1:5 rm2:5 ta:5 ra:5 . tm:5     &mpyadd
 
-fmpyadd_f       000110 ..... ..... ..... ..... 0 .....  @mpyadd
-fmpyadd_d       000110 ..... ..... ..... ..... 1 .....  @mpyadd
-fmpysub_f       100110 ..... ..... ..... ..... 0 .....  @mpyadd
-fmpysub_d       100110 ..... ..... ..... ..... 1 .....  @mpyadd
+fmpyadd_f       000110 ..... ..... ..... ..... 1 .....  @mpyadd
+fmpyadd_d       000110 ..... ..... ..... ..... 0 .....  @mpyadd
+fmpysub_f       100110 ..... ..... ..... ..... 1 .....  @mpyadd
+fmpysub_d       100110 ..... ..... ..... ..... 0 .....  @mpyadd
 
 ####
 # Conditional Branches
-- 
2.51.0


