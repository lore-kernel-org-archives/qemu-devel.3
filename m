Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53EFD0E6E5
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 14:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNu5H-0006qn-Ou; Tue, 25 Nov 2025 09:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNu56-0006io-Hm
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:31:51 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vNu54-0004f2-Al
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 09:31:48 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42b3c965ca9so3143713f8f.1
 for <qemu-devel@nongnu.org>; Tue, 25 Nov 2025 06:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764081105; x=1764685905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DWwkc7P1P2x5hJJOffakgpCfxVVLmumC32Dz9Go0Kvc=;
 b=Nwy3W/ofhXfbBE+ZxxW6pntOdV9BUv3ZcwDIzdHNn+JCQBMrEWK9Ht/vgnCoWPlZEO
 SDWytvzmNDyU7y6PDCuOT/5FZy0USLEaqTfe9q0xVPQtUVipmtobRo3UApp3SK2LxbFD
 PGhl7kEGDrnmZAv02P3Cb8KoCoR0QgL10XfKZkzJm3GvhleWtfJosQvjrH/Vta9L7fzr
 6OQdRimalVKdnXFEx4zUVbfUjIuTGgSQ5/6gXFFLQyKaGXicwmPyJLk0s+rtbLZOs7Sa
 VEcQt44/rjKrymVi6yY2xFnrGXaIbVALT2AsZhjID4Zeml0AdGC2CMFuvWD9yzW2e7Zo
 XIHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764081105; x=1764685905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DWwkc7P1P2x5hJJOffakgpCfxVVLmumC32Dz9Go0Kvc=;
 b=dd0XAa2fwBcnA7v64Y5TD3CZHppniQDtotMXWSsDhX591c6MvAVYFc86P0tBzD5pNc
 Cy1hEd7LGcaFEOrrcHiv3/5R82fTtR3O1OQj3swVOWYU0QsxuRbKYcys5rAmPygERgiW
 skgLgTLrdpc9iH7YLdKZGeTCSdyUwNTDmUXQlZ8+YBuqZXkXlwwu+mM8/+jk005nDCQM
 jRWJNJy5QLOLitYiEI+5l7FRuekYV3bMQmXgce9Q0SIqj+XDEkZznx2umklMnRD3fitb
 knpAVO4Pmoljt6BlTABS3AoCkQ/pGOfXQLkVxpoBjziL50wfHZt2cBPXBVsx5cthW5j0
 bi4A==
X-Gm-Message-State: AOJu0YwIWh+qRuSPNX1ssDgsmZGe++R0/3WpJamvBMVzahius/hvIWhO
 LZZhGo64TvhXQMUy8c50yY1Pp78y3uP+WeiswHB9dRFYIQX5ti4vDG7jWzKwMf7FlIc7ckWqhvD
 a3ljq
X-Gm-Gg: ASbGncsVrZXXD2WPL92x6UmK2mk8gqY2YaRzf/eSnOKpbqK+KyKalDPQ9hdDnwZFZfx
 LVYzbjUskFBU8a0Qa7l8IpBkyxa8dnqsYJBcKV+ufVcMpSeaJuf8yghAdZmS3ffCgr8R98xpPcS
 RdRi/EG4vPN4Kj2/mJWtm071W9YtiISVHmsmO8LV62y+o7gbj0TeorTd14Z2IfjcWDpxfVsYQOF
 gNe04FhsQI2O7dIJSxkPD8v4XGOJCc2LXBEMq38Qcz/RqzUCdjb7KwG1hY0DVtpGR9+Gmn+Caji
 bKyI90Lg33ZxydOywMbqhDYUcdWYwJtah/xkJH9+ch5WdG0jNzqDsLDQv74LUTFUMNuuJj1PRQr
 58Dr8Sz8K3LP76XZuF1qt2K2CfAnrBhk0a91RfNYe1lRCTr6s6LSrJBXbO1bF1TbGABAM7UafEr
 BuB50x5G4RoEu7LYEn
X-Google-Smtp-Source: AGHT+IFWQJttGqRDvjOAqcvmJlWMtA3gb0QNckwIaXDg+zrQ3b3ZcKareLkul4DMZUai1T4h2lqzvg==
X-Received: by 2002:a05:6000:228a:b0:42b:3e20:f1b2 with SMTP id
 ffacd0b85a97d-42cc1cd9221mr17788880f8f.4.1764081104841; 
 Tue, 25 Nov 2025 06:31:44 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb919bsm34485434f8f.34.2025.11.25.06.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 06:31:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>
Subject: [PATCH 1/3] docs/system/generic-loader: Clarify behaviour of cpu-num
Date: Tue, 25 Nov 2025 14:31:39 +0000
Message-ID: <20251125143141.216056-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251125143141.216056-1-peter.maydell@linaro.org>
References: <20251125143141.216056-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

The cpu-num suboption to the generic loader has two effects when
it is used with -device loader,file=<file>:
 * it specifies which CPU to load the data through
 * it specifies which CPU gets its PC set to the file's entry point

Our documentation is not very clear about what happens if you don't
pass this suboption.  The default is that we pick the first CPU to
load the data, but we don't set the PC for any CPU, so the "If not
specified, the default is CPU 0" is confusing: it applies for loading
but not for the PC setting.

Clarify the text to make it clearer that the option has two effects
and the default behaviour is different for the two effects.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/generic-loader.rst | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/docs/system/generic-loader.rst b/docs/system/generic-loader.rst
index 4f9fb005f1d..3ac39cfbbe2 100644
--- a/docs/system/generic-loader.rst
+++ b/docs/system/generic-loader.rst
@@ -87,12 +87,17 @@ shown below:
 
 ``<cpu-num>``
   This specifies the CPU that should be used. This is an
-  optional argument and will cause the CPU's PC to be set to the
-  memory address where the raw file is loaded or the entry point
-  specified in the executable format header. This option should only
-  be used for the boot image. This will also cause the image to be
-  written to the specified CPU's address space. If not specified, the
-  default is CPU 0.
+  optional argument with two effects:
+
+  * this CPU's address space is used to load the data
+  * this CPU's PC will be set to the address where the raw file is loaded
+    or the entry point specified in the executable format header
+
+  If this option is not specified, then the data will be loaded via
+  the address space of the first CPU, and no CPU will have its PC set.
+
+  Since it sets the starting PC, this option should only be used for the boot
+  image.
 
 ``<force-raw>``
   Setting 'force-raw=on' forces the file to be treated as a raw image.
-- 
2.43.0


