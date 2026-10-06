Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1FF1CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENDz-0003oR-Nv; Wed, 07 Oct 2026 04:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xEIgK-0006G6-IL
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:51:20 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.macarthur@linaro.org>)
 id 1xEIgE-0002r4-L4
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:51:02 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a601ba6870so6039112a12.0
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1791345031; x=1791949831; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jdzfazKBDl41kEYsQiuUPHfelqpsDS1ycyL8waKcjvw=;
 b=GYtvLhuW1SwVqfVEYsaua5E9bjrSm/YVu4i6fhjIphGUxQU4lK+QU6GYp5dgcpjohy
 Td1IcZoEyYmyY0Bcue0lUNrD6lrJuR13mQ3kvhThZqZKdOGVTuNQyC7GFKwHlRreEw5b
 RXwqtR0ZF+rBMQWyVnoaJZBmdDUJPRQH/SVqKsA8gmOYo9CdR9EH/j3qjOVlGH73rHVM
 GdRLSQQ5xF89KZbO5Mb/qwJKRZq+rJBnt+mEisYLf5Etutru3MabWrYhzgfhD4CxUWWH
 vYe10mpShK/uN4/3aqpRe7FNd/Y1gfWyS2GqTHliINlbVDZ3XmxJ5HqeA9kah32xb/AB
 s5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791345031; x=1791949831;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=jdzfazKBDl41kEYsQiuUPHfelqpsDS1ycyL8waKcjvw=;
 b=MI4D1YBtwTz2CO9IxPJratOr/lZHNu6D08k+WdOFwfI7CG+ItUv/vvGaLJf92HsXB6
 AUe8Zz0GHp8+8w+PNOBp0aHhTdbuDkOKN2h6NlLAUYn9SuBlPet0ix8DY03xbqKXZz68
 VpNeB4rqBtL6dnC9J6xI96Jb53qgVxmFX63ESv84sJ5nWLHiRpEcvG3g9n5tTAzxH1de
 Csl2cUCjEAde5y0cqpYcLUyL2HXKXKzFVMLFT/bQwAhq7GN6hmsyidMZk91HLte7Bbj7
 VzyXfdypTkm4GTqGlNFB+9POn6RgYyPMIkO1hnrsKU0wZTa7YDBsDiUm+npENMb8IbIX
 XGOQ==
X-Gm-Message-State: AFq9FYI36NDf1Wod3uCmOcsX20egTtjoZfYjV/ztmRFoik6buJZ+W2LS
 uc8uYPfPL14mR9Up9AUV6UKRz91fz8m18W/yipb72pRC0iN5PW43cp0UQ3LSZ3nGyDFwBneVv3w
 ImKma09M=
X-Gm-Gg: AYBFou01N6TXGSsHpzgG+9JDhiqgGNhRa0b1IKnXxRJWRPFEQKvAHpG+bZEY6O+h9vi
 SiYmLb2DwIYmpS2rNOd3WAUcQmV+c7goaTl22eykHBIen40isLq+knX+wi6ZO9Z7EI37OEF0j1o
 jsSlHHIr3DgMVa8az31w4SgUK0XsiG8U1vGvelrFqHxidsPX/aGnFCVDmBsktfjBi3foaSUitW8
 IP0SiMzHP6wweTZjbIROihDH3ngmxbsABJiEEHctED+4PoXmVIBau27GaApetmEWujaqyMLaWH6
 gAJoVpQb5bCQl5HYqzMCqCX25sU+MpkgTmMfU7NipzuJmJemOp77hCvZ7Scdfu8Ys0px0EVXXQg
 EXAs4kgaY2LOAONChxppnhKzjex6g4m5Q9AsUNnPX29Q7Z1UOI3wKtV4QUMmmkil98mUtPkJZSZ
 rTCYhL+x4RO5EhR/fsjqYmiE3A4dwjtIxnLuvlYprkxwDToeTMqvKhpO7TPANgUZOov0qVl08uI
 g==
X-Received: by 2002:a05:6000:2210:b0:488:641b:2dfa with SMTP id
 ffacd0b85a97d-48c726f4887mr880037f8f.2.1791318021381; 
 Tue, 06 Oct 2026 13:20:21 -0700 (PDT)
Received: from [127.0.1.1] ([2a10:d582:31e:0:7318:ac57:7d1a:6aa9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71bd7644sm1535709f8f.7.2026.10.06.13.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 13:20:20 -0700 (PDT)
From: Jim MacArthur <jim.macarthur@linaro.org>
Date: Tue, 06 Oct 2026 21:19:12 +0100
Subject: [PATCH] tcg/aarch64/tcg-target.c.inc: Correct register MIN/MAX
 instuctions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-jmac-4609-cssc-fixes-v1-1-798505d4a4a5@linaro.org>
X-B4-Tracking: v=1; b=H4sIAL9XxWoC/x3LQQqEMAxA0atI1gbSotXOVcRFrVEzMDo0IIL07
 haXj8+/QTkJK3yqGxKfonLsBaauIG5hXxllLgZL1hkih99fiNg48hhVIy5ysaINkzdk2fddC2X
 9J35DOYcx5weI06ZvZgAAAA==
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org, 
 qemu-stable@nongnu.org, Jim MacArthur <jim.macarthur@linaro.org>
X-Mailer: b4 0.13.0
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=jim.macarthur@linaro.org; helo=mail-ed1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Some digits for these were one position off.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4609
Reported-by: Ayoub Bourjilat <https://gitlab.com/Bourjilat>
Signed-off-by: Jim MacArthur <jim.macarthur@linaro.org>
---
 tcg/aarch64/tcg-target.c.inc | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 4ebdef7e07..273462ca61 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -549,10 +549,10 @@ typedef enum {
     Irrr_UMULH         = 0x9bc07c00,
     Irrr_UDIV          = 0x1ac00800,
     Irrr_SDIV          = 0x1ac00c00,
-    Irrr_SMAX          = 0x1ac00600,
-    Irrr_UMAX          = 0x1ac00640,
-    Irrr_SMIN          = 0x1ac00680,
-    Irrr_UMIN          = 0x1ac006c0,
+    Irrr_SMAX          = 0x1ac06000,
+    Irrr_UMAX          = 0x1ac06400,
+    Irrr_SMIN          = 0x1ac06800,
+    Irrr_UMIN          = 0x1ac06c00,
 
     /* Data-processing (3 source) instructions.  */
     Irrrr_MADD         = 0x1b000000,

---
base-commit: 8e021b85cc06caec24a24302aa68f040a0970c12
change-id: 20261006-jmac-4609-cssc-fixes-2ab9102e9875

Best regards,
-- 
Jim MacArthur <jim.macarthur@linaro.org>


