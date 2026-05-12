Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 856C4CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 10:43:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMkZ9-00008m-Mt; Tue, 12 May 2026 06:42:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMkZ6-000074-OV
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:42:16 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wMkZ5-0004wH-3f
 for qemu-devel@nongnu.org; Tue, 12 May 2026 06:42:16 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso3317770f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 03:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778582534; x=1779187334; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cHnURK1d/0RKJMXdvYyWDAz5N4wMTvzm1l9ySj3ZS1I=;
 b=LRhlm5jQfRm2m5rplOwlbDpvSoTRDhP6ZKhSxoFNAWdam0t6BqCBPKbTOgcr4sNmCn
 wvrBwo7etkAAenh7bWKYiIjGqzyaVGs2Sxttw84CLMel3LckxmnNmtvK2mTmO/w1/vQ4
 6URLAbuzS12hwNsBbFjBm3/henMmIOnh5ahwIkq9AfBVb5jshgPdxo7j1Jovg+e0kDhM
 XhFFgas/hxnlHdgC4E/ia8pw5TJYIP0g0nV18vVdN/cvUpMhi+kQSAX6VkjPTBkVCM/y
 ap+/+kFeLF4HHc1txFPBNVuZY0O0oU8Wm8CHe+KuSV/CxzYu0VtYtYdLi38KE8roaVpP
 IXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778582534; x=1779187334;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cHnURK1d/0RKJMXdvYyWDAz5N4wMTvzm1l9ySj3ZS1I=;
 b=N1j8P9GHlfyLBPB1Yv5ewXbIKL9m5CfzhgGcsDnDUsem76XPD1N30bM1ye06riU3G2
 9hronMyGeFPTm+cekQgM3CWko0EsOfD0XHh+E8Qdz+bNKkt3jqcQ5xJQ8SbpALMKR11S
 mFeE0GC2eT2s2wQnOdg4kke/3dLrfAuZ/0gKYifzowTLHAhqnfqXe48XtHwmW8mv6Eec
 IKyDnVJ4kHy9YXYcKotsP0JVy27T5Y9eLBnQ35i05FzeoQSkgw5So9b/gS3bNR1UC34m
 VaIWU2cGUsACEvKBdP0BYqjcMnSKChkJMAtHys/xS09EC/MMuohFd1XZfMbBsqvjZFVF
 MpPw==
X-Gm-Message-State: AOJu0YwG62HmVea6B1GPnc2GWccsaKQVGo0ft1aBWXqanhVctzY8uLY1
 F0be0dBOGyWCq/nI13pSugRFDv2l84LD3T2eX0jANtdK24blI4eujaD9aDaS8K+uVPGQWhaRNtk
 kMF8D
X-Gm-Gg: Acq92OHeAa+6Dv2o3te4SoqPb/+KjLMOi7Y11QghSMCX/60gSJNDmcAe2JYQjcEtt1m
 4rD4/nvItGQqK20woyaguCOoZL8xcODo1CfcwlF5UTsBAZtWvMoNmbK1rFnEzr22A1VVj02onWp
 1J/b4FUrD7XFEUZIp6VdKFD5QNi2XTiPuV6aXMGs5zBKIOi5Px1sV+vfotAt+XC/kySEBH5xzT3
 XS4I/eV1Tb4+/sujG19PhLEI8H65HxadfjWsdqkj33GhGnkBjYL5/4fp7nc4HCRL0r4ekgtLyVx
 IyZ+eUK7ArVt2ZF3qeBfwBsmS0Ei6wE9AUqKBHiGLp7murQkxyvrY+VvOlGn8WbvCtZ/4m5p+vv
 7/zElEjXEZr7drTHu3y0JuTbKhTFucmktvimlL2oHvYfXuXcvqZfF9NGqjPP+Nuo8S+WJ3bSHWw
 XPn6oXbBGD6nQC+3fl5mkSjw67vWlowcnJ7HEcCNHjulZR9H+HthB8k0iLJ7+T1WDK8HIxP4cJW
 LQjJpmKmF1PuHn/qrWGPAJs4mTyx1g=
X-Received: by 2002:a5d:5d85:0:b0:43c:fb48:6856 with SMTP id
 ffacd0b85a97d-45b12fd27bamr3669145f8f.13.1778582533728; 
 Tue, 12 May 2026 03:42:13 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491f8d4c3sm31481680f8f.34.2026.05.12.03.42.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 03:42:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/2] ui/vt100: Standardize on uint8_t for "ch" byte variables
Date: Tue, 12 May 2026 11:42:09 +0100
Message-ID: <20260512104210.3330835-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512104210.3330835-1-peter.maydell@linaro.org>
References: <20260512104210.3330835-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

The vt100 code is rather confused about how it handles bytes of data
to be sent to the terminal:
 * vt100_input() takes a buffer of uint8_t
 * each byte is passed to vt100_putchar(), which takes "int ch"
 * that calls vt100_put_one(), which also takes "int ch"
 * vt100_put_one() sets TextCell::ch, which is uint8_t again
 * various places pass the TextCell:ch value to vt100_putcharxy(),
   which takes "int ch" again, but uses it unchecked as an
   index into a 256-entry array

This confuses Coverity (e.g. CID 1659590) and the reader, who may be
unsure whether the "int" variable really does hold only valid byte
values 0..255 and whether we need to bounds-check before doing array
dereferences.

Standardize on keeping known-byte data in uint8_t all the way
through.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 ui/vt100.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/ui/vt100.c b/ui/vt100.c
index e2fba82252..7e373766bc 100644
--- a/ui/vt100.c
+++ b/ui/vt100.c
@@ -61,7 +61,7 @@ static void image_bitblt(pixman_image_t *image,
                            xs, ys, 0, 0, xd, yd, w, h);
 }
 
-static void vt100_putcharxy(QemuVT100 *vt, int x, int y, int ch,
+static void vt100_putcharxy(QemuVT100 *vt, int x, int y, uint8_t ch,
                             TextAttributes *t_attrib)
 {
     static pixman_image_t *glyphs[256];
@@ -468,7 +468,7 @@ static uint32_t bh_utf8_decode(uint32_t *state, uint32_t *codep, uint32_t byte)
     return *state;
 }
 
-static void vt100_put_one(QemuVT100 *vt, int ch)
+static void vt100_put_one(QemuVT100 *vt, uint8_t ch)
 {
     TextCell *c;
     int y1;
@@ -606,7 +606,7 @@ static void vt100_restore_cursor(QemuVT100 *vt)
     vt->t_attrib = vt->t_attrib_saved;
 }
 
-static void vt100_putchar(QemuVT100 *vt, int ch)
+static void vt100_putchar(QemuVT100 *vt, uint8_t ch)
 {
     int i;
     int x, y;
-- 
2.43.0


