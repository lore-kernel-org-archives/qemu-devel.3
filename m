Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA4F610F9975
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:24:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYK8-0002As-HE; Wed, 08 Apr 2026 15:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAYHO-0005qm-Qx
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 15:09:36 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1wAEoU-0000ok-W4
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 18:22:28 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b24fede2acso30678065ad.3
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 15:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775600546; x=1776205346; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BgMYgINs/yOfuuVgzjug5JMD/7kH4ZvROycWlRvKO9k=;
 b=nUdxEtrI8/1koy7mY+rPz4bKYquCi/Yw0nmrxZlTboF7irP+ebjrd+JGw9MPqgnXh1
 xmEt3v+Y9E21jRQA17uRFVAZECXuYxs7iY/LEZ/TLzlL1VU/FMd4Oge+zoIBwqOns52l
 5PYQi3e4lPxhjdT6aZUybHqkT6QJmn/Z8oDMoTnQjpv2BxVNJBf6f9MnqY3NAw/hTtXZ
 g7Nq14L+zekplhB8CJafpbcDWItc1p0a2RmS0pF9MiS1iGzxcUbAAfKr2ZD7uDVYLlvt
 hmknRnZ7dC3Lfg131ZMPXibmUKzcNdpAnaLNXk/4GnEQoE+hJyUUq3bJAga8fecEbMbc
 W5Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775600546; x=1776205346;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BgMYgINs/yOfuuVgzjug5JMD/7kH4ZvROycWlRvKO9k=;
 b=bLzFFoC6ft2DV8dU099XZSBps2E5BJCOpPTmTifsUnoHydiXJJVtY4x6Dx5gVeX75b
 kaAKwPgIN+OE6qAkoepBVnDiIWwzu6IbI12nYyXpXP7zjFoGapynqN0jkekFF6JOiAP4
 MGktUwQxSpS3wUVuKJiY2CQ748RVl+wmHHC1372EwFOkVGZhMvVZ8j8I5Z5V7pWWli5b
 tJuW5J/CExiWekASNcohBPoTd6FIqc1DLzL7myMUgDO0HXskNO8x1gz6Wx1CCCrl0Tya
 KJ46aj7K9u+QtucfFfHFmEiPao9JKgBBggnMYbVPTyu0y0Tjm3Y3e3rql1RruHd6pJ4w
 1M6g==
X-Gm-Message-State: AOJu0YyeyF2E8JfKGecxZfELA6tr5Ow91fwPL5oEIdhtvxpUaF48oeAx
 uC69Bx+92EPbv4lE+3I5YqM2vW015jHRZdiv2+0fhTiYd8Kb9xirZEGymXgBy9Cx5Cubz2u9HsM
 bLmCTSIA=
X-Gm-Gg: AeBDiesD7Dt6VR1XwgbcnamorbxuxXTPJrALzarFZ/5fcH9etUMJ9AaXXRJlsIL5Mc7
 eNNWchoyoFHkt7p6vorOTrW7X0cUgzTxGvqVPlESUngUTCEWxHZhEWkkr9D5Ci5cOwSfP+NQQLe
 bIiv0UYmm0WnnHgxGqDiRNu4BhIXfLYIJ4hrbkhYyEMlm9Kc/dwE6LHOvCfzsG4oKwphiV1gPQZ
 JD+R5oPRY16lO0vkyt1YBPLZLxHLijSS3n2ZlccwFf+mN+O2lUX9wxjkoHP1hx07uUbl39oijLW
 gc9YYOU/cgkGGtaDOROcKfaK0RawkRcGc4N5aXFkTMULC7cZXkpZnCN5NfxgwYoiHWtXXydprNv
 dz2bkc7zK65Pa8ohTONXwDHq6kkAmDID/qei7wrYeSA+PlxxmIm3QevqyH7sLYngE/wD0tb0ked
 GYzM/g1FrGOIsl4v1PI6orhzPw+Esc6DtfVSy2Spyki/VR4UDm6dthOIO8A3yLguxInTkZKXAuN
 poK
X-Received: by 2002:a17:902:e551:b0:2b0:67cc:adc3 with SMTP id
 d9443c01a7336-2b28180aff8mr206878795ad.14.1775600545548; 
 Tue, 07 Apr 2026 15:22:25 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274979d5csm180412065ad.38.2026.04.07.15.22.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 15:22:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, jim.macarthur@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v11 10/21] target/arm/tcg/gengvec.c: make compilation unit
 common
Date: Tue,  7 Apr 2026 15:21:57 -0700
Message-ID: <20260407222208.271838-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
References: <20260407222208.271838-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index 1fa26670587..0740de92c1a 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -33,7 +33,6 @@ arm_ss.add(when: 'TARGET_AARCH64', if_false: files('stubs32.c'))
 
 arm_ss.add(files(
   'cpu32.c',
-  'gengvec.c',
   'translate.c',
   'm_helper.c',
   'mve_helper.c',
@@ -72,6 +71,7 @@ arm_common_system_ss.add(
   'cpregs-at.c',
   'debug.c',
   'hflags.c',
+  'gengvec.c',
   'neon_helper.c',
   'op_helper.c',
   'psci.c',
@@ -91,6 +91,7 @@ arm_user_ss.add(
   vfp_d,
   files(
   'debug.c',
+  'gengvec.c',
   'hflags.c',
   'neon_helper.c',
   'op_helper.c',
-- 
2.47.3


