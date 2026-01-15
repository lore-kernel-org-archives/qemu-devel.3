Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B477BD4660F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 18:56:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgSVk-0001F5-Au; Thu, 15 Jan 2026 13:56:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVN-0000hw-45
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:39 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vgSVC-0005uW-U9
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 13:55:29 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-42fed090e5fso668888f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 10:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768503321; x=1769108121; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JihJ9EjtCmXQJXv06egkSfCreOQAD+ZK24B5aK3jXDQ=;
 b=ncESgrMWVCqILhiJsTxkWVMOcUjbPquYn85HggJO4joFZ97tzf8T3I4lRGSL5e8cy2
 QHe+scKKY2OdNZaLhJ2CzYaOmBAKV8cKflH37VSBTicJctGQiypi0ILSqivMb0e/YgSL
 Ad1/lAEdZlaS1G2dWeSS/s14iaKFy6O4ozQsP0k7mwvvDyGjNARZyOlfgA/1k1X5R8MU
 l0tDwanaysGVNsgvcmCB2MSKam8WOqw1PKaAvFhxbf+5Q75MXm+nhhHZYFoalOBcJLjn
 pOwcP/2T44bUkIEUTTmLVZFeN3ozxV6YgUwHnjDX0lWrn9feOakvh8Uf5EufTWOa1DZT
 0eZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768503321; x=1769108121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JihJ9EjtCmXQJXv06egkSfCreOQAD+ZK24B5aK3jXDQ=;
 b=fnGvzArQf1hROsDhKZEFqcS0GTxQgxSkimnTDC2J11mqTTFParQR3WZHfwGlbo9y9h
 zUlZKhWZ1w4LdPfLddFWTiovjjQfoue5piEVQUa2cAb/uBxAFuIAvAlSN+NaZq1EWh3d
 EIu8ZewOovApM4fmbuqKC45Aojaa6hxturPR57yQjmQO5YzPz1wv+FLFyfY+VC057D+H
 LASv34WRXY6GLHtIz6FJTvkICELiPqIXVnkfnCVq1f6Tme3vNF8kUUnxOQMX6vJ11Cg5
 T6G5DqArkzi902IDDShTTHM7N6SdxCGpXuBSNLJuzopADwtH0n37sF24muglPRGbqqwh
 fzyA==
X-Gm-Message-State: AOJu0Yzd5gLBIpgU9Ag2L8C1iWzmHr/3xQsT6A17YEy1ixt3/lzGrJRK
 1QsvF8SMYjosK+Ww3lILEFJNKU9Rx2q3SmXx8ZdXYT4TMo3zaC6bTArfx3f67LeKYvmObbKR8Nt
 1O8oP
X-Gm-Gg: AY/fxX7UzRbbtEKo+M4YHR5/ButS0OekHqkZHUJJYhsTXEH9AygifP759l2LxK/+GlS
 8GvX/pJI5VYiavDiCNvhusYR6v1MfSXoCiN4XPORzdbDMZfxzmOxnr6sFOcphuPgjuDY1iLAwG3
 XTUQ1ckkNeR1c/ftY14SHxIDDXwfzhDWizVn8eBLP4ksTYn0aNXDc7cpQxEWYYWFQr5/LoYHueV
 gR7N4BRbmiyN8rgTJsq8D3sEWLvMePx3gt6vE2Lut84s46esQ2hhgukQoPW4Es2B5Md9/gFFs67
 F3nPLBT0PRCvW77Aot11+SwmQAmwpp0qz2IgkmsopCEGkC+4+JJKLHVFZ1r6LPZvIG6lXqkPLEK
 SQhIQzUYKISO3SPsYPzieEMqlrsBHN3wAY2wsU3j6BJ1+d4Wrf6ixFXzATC4HaHKaefdoJ4BeWc
 Xq/ICg25XXvxZ+h4k1SNTYXBWUe2QpHGOa+v47Ofwk+DtH2pUi3QFDUuUG13+96lB+7JLxQGMRO
 aWfeph7GHJn+tXA0Jn8XkMI/cAsPaYmvLsqIkK5ihXiag==
X-Received: by 2002:a05:6000:2910:b0:42f:b0ab:7b48 with SMTP id
 ffacd0b85a97d-43569979c52mr465136f8f.1.1768503321525; 
 Thu, 15 Jan 2026 10:55:21 -0800 (PST)
Received: from mnementh.archaic.org.uk
 (f.7.f.1.7.5.e.f.f.f.c.5.d.8.2.4.0.0.0.0.0.d.1.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:1d0:0:428d:5cff:fe57:1f7f])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cecasm514207f8f.26.2026.01.15.10.55.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 10:55:20 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/25] hw/dma/omap_dma: Remove omap_badwidth_* calls
Date: Thu, 15 Jan 2026 18:54:55 +0000
Message-ID: <20260115185508.786428-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260115185508.786428-1-peter.maydell@linaro.org>
References: <20260115185508.786428-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The omap_badwidth_read* and omap_badwidth_write* functions are
used by various OMAP devices when the guest makes an access
to registers with an invalid width; they do two things:
 - log a GUEST_ERROR for the access
 - call cpu_physical_memory_read() or cpu_physical_memory_write()
   with the offset they are passed in

The first of these produces an unhelpful log message because the
function name that is printed is that of the omap-badwidth_*
function, not that of the read or write function of the device that
called it; this means you can't tell what device is involved.

The second is wrong because the offset is an offset into the device
but we use it as an absolute physical address, so we will access
whatever is at low memory.  That happens to be the boot ROM, so we
will ignore a write and return random garbage on a read.  This bug
has been present since 2011, when we did the conversions to the
MemoryRegion APIs, which involved changing all devices from working
with absolute physical addresses to working with offsets within their
MemoryRegions.  We must have missed updating these functions.

Replace the uses of these functions in omap_dma.c with an
open-coded call to qemu_log_mask() and RAZ/WI behaviour.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/dma/omap_dma.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/dma/omap_dma.c b/hw/dma/omap_dma.c
index 963ce6fd10..784a3a4f7f 100644
--- a/hw/dma/omap_dma.c
+++ b/hw/dma/omap_dma.c
@@ -1455,7 +1455,9 @@ static uint64_t omap_dma_read(void *opaque, hwaddr addr, unsigned size)
     uint16_t ret;
 
     if (size != 2) {
-        return omap_badwidth_read16(opaque, addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: read at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
+        return 0;
     }
 
     switch (addr) {
@@ -1502,7 +1504,8 @@ static void omap_dma_write(void *opaque, hwaddr addr,
     int reg, ch;
 
     if (size != 2) {
-        omap_badwidth_write16(opaque, addr, value);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: write at offset 0x%" HWADDR_PRIx
+                      " with bad width %d\n", __func__, addr, size);
         return;
     }
 
-- 
2.47.3


