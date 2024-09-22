Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F04CF9C64
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Sep 2024 12:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssLHf-0001e7-F3; Sun, 22 Sep 2024 08:01:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHP-0000x7-VS
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:37 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ssLHM-0002P1-6K
 for qemu-devel@nongnu.org; Sun, 22 Sep 2024 08:01:31 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a8d60e23b33so440197266b.0
 for <qemu-devel@nongnu.org>; Sun, 22 Sep 2024 05:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727006487; x=1727611287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iOGLN+zm8mGiA4+i5QuWHNFagj04fy3fGZDQcrAHPyk=;
 b=y5QqlDYmvdteTw5Dlsk/0kjpJwd/ftQzADiMsSZ0SDXZUvVfzfSNwio+Pc1GL2L6fT
 6a/51g/rvsJceYXFOu4ezyqrJPrExE55Z9ygY6nJiC/snNt8MinLf86mKnSShweMb0Or
 T9Iq54/7K546fYXTAIQxop7ZDShLjsjQaJyUIN2fTeUCSBhR0TvSRfF2rViGBeVuOqcE
 mGwlsGbm+N2KgZU44RUFKyDfZ2oZocjmo18NGJnyiL0DGYtEhtdn6y8k9L109ZWd4EXh
 hatFGw8yoZnORdSuuLlSpoX4lWkBm79AdjEPkvUHHUBVyllp3/ovFv3f7SvdKc4CapR7
 Mb3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727006487; x=1727611287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iOGLN+zm8mGiA4+i5QuWHNFagj04fy3fGZDQcrAHPyk=;
 b=SrUWNDAb6Xte/lFC0MrKt/jdSpOZv96FFXoGo1K8QaJanABeCSIzKF2z3H39OdSQph
 KHp928e54gQSZCNPLO5y1rhdUo8K3L/I132FWQRRkAkM0Y0lv9TYbUwNR3M0scSInLiT
 SzsaZnQBWZLM06aPwwnpWm1uObVqKRVUGtu4MJPV5cRItHKQPEEzifrTrn/Hq54wooVX
 thf1fK8b33zGOhOjW476kAuFzJDP0Jvpw1n/zUo17WfboQwDCRDl9lzwsKpSTk3TXQfF
 ScaVZQm43zNSeZsita2oBksVIPGPycS6/GBd2yadOvd2Xj5KzfpwkrA19Qxrn6ihFDMq
 7JpQ==
X-Gm-Message-State: AOJu0YxBSUJRphiXXWRI/Ebp6W7vxVKfmUgHLr2aeAg8xeV2Tn6F5uqv
 pJQMNHCu3h2avjdix3HLt5ZrovUGfenzxto5S+ekLP/uqVl9WJQHhDPUC93HjcZH2oxy/2XreAx
 vqB0=
X-Google-Smtp-Source: AGHT+IEZilWYOctO4hdhhSb5hqu971mYWdZBfK1ALylhIxHwJ55pUiDhpjyjBUO24TahNqMwuE3Tfg==
X-Received: by 2002:a17:906:7949:b0:a8d:128a:cc49 with SMTP id
 a640c23a62f3a-a90d57793f4mr777587766b.52.1727006486822; 
 Sun, 22 Sep 2024 05:01:26 -0700 (PDT)
Received: from stoup.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612df525sm1067909966b.159.2024.09.22.05.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Sep 2024 05:01:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Fabiano Rosas <farosas@suse.de>,
 qemu-stable@nongnu.org, Claudio Fontana <cfontana@suse.de>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PULL 22/31] target/ppc: Fix lxvx/stxvx facility check
Date: Sun, 22 Sep 2024 14:01:03 +0200
Message-ID: <20240922120112.5067-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240922120112.5067-1-richard.henderson@linaro.org>
References: <20240922120112.5067-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x635.google.com
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

From: Fabiano Rosas <farosas@suse.de>

The XT check for the lxvx/stxvx instructions is currently
inverted. This was introduced during the move to decodetree.

>From the ISA:
  Chapter 7. Vector-Scalar Extension Facility
  Load VSX Vector Indexed X-form

  lxvx XT,RA,RB
  if TX=0 & MSR.VSX=0 then VSX_Unavailable()
  if TX=1 & MSR.VEC=0 then Vector_Unavailable()
  ...
  Let XT be the value 32×TX + T.

The code currently does the opposite:

    if (paired || a->rt >= 32) {
        REQUIRE_VSX(ctx);
    } else {
        REQUIRE_VECTOR(ctx);
    }

This was already fixed for lxv/stxv at commit "2cc0e449d1 (target/ppc:
Fix lxv/stxv MSR facility check)", but the indexed forms were missed.

Cc: qemu-stable@nongnu.org
Fixes: 70426b5bb7 ("target/ppc: moved stxvx and lxvx from legacy to decodtree")
Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Claudio Fontana <cfontana@suse.de>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-ID: <20240911141651.6914-1-farosas@suse.de>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/translate/vsx-impl.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/translate/vsx-impl.c.inc b/target/ppc/translate/vsx-impl.c.inc
index 40a87ddc4a..a869f30e86 100644
--- a/target/ppc/translate/vsx-impl.c.inc
+++ b/target/ppc/translate/vsx-impl.c.inc
@@ -2244,7 +2244,7 @@ static bool do_lstxv_PLS_D(DisasContext *ctx, arg_PLS_D *a,
 
 static bool do_lstxv_X(DisasContext *ctx, arg_X *a, bool store, bool paired)
 {
-    if (paired || a->rt >= 32) {
+    if (paired || a->rt < 32) {
         REQUIRE_VSX(ctx);
     } else {
         REQUIRE_VECTOR(ctx);
-- 
2.43.0


