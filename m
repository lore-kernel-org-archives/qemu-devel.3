Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F6F2C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAwy-00050y-PK; Fri, 28 Jun 2024 08:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwU-0004n4-Gs
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:06 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwR-0005fB-EX
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:06 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a689ad8d1f6so73517066b.2
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578582; x=1720183382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bf4WpUP3pGX7br6bhDuGt9p7GApyU5+eBul3rNsS2rQ=;
 b=dJ8kVG8+/LAHdA2DUylJgR5ZA8TbZbU4iZWa45XkF72SChfAULXtgMvUzQojElbZ5t
 6VBQ3zHDlsEQOUMILPA+ofLTmS4qqlrwo77rh8x5eC7+6XpQkBg5AtcZRa4+Mjgj3bxr
 WuaHvu08YE10aEUVYs/ptKNXqk46BQgbmCvv7q7BhbUTA9MZvN438d291hT0keNQCJ12
 BbojqotxyfWLZkk3z9bDzpKtzCT9wu/Mft3R00yp6O+64GUBlD6BtlbUmAQ7GVcLHEWp
 7Nevo3ziV16NlN/+HOB2ReZLbrtOi81hgn5ONaJIy4MG48Jp3hXx9kJTl/woKivBrHgp
 yTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578582; x=1720183382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bf4WpUP3pGX7br6bhDuGt9p7GApyU5+eBul3rNsS2rQ=;
 b=Tj8nQTHMsXQYmqdAVfDE0KPz5xvYoNczMpM4DUpj1C++i8u/b0/X3nM5Mrh7lszQR8
 cdIeYkW7kX9DcSBvfIE+EFfvKZCKstxueAYU9Cm21y8x2hpKcEdScVV1gQtyezmLftJR
 7VhEpFeE8xN+t6THT0y3wto2BzqmdZi0xr6ilWqluN1m4iLuSNSN1LAUk4LVHM/CpWTN
 SfPVKXgXnN/q45hX2a2FCiULW3H1LmQL+VBS8jraduDSBeyOyxulwNtjLyGgzgeM9M47
 JwJmzq/y0giUZ74gnP3fitfZSPKapeMXgtq3mJ7tXst9Bo/ToQKojLYlQBPoDz0MN5kC
 35kQ==
X-Gm-Message-State: AOJu0YxoVdh+3WcuTu0LQ/9h0BPzycdeqmmsDVauQHV+CCKal9U/BOEh
 08/Fns5P4qnhQs4GbSxOyqhvKdo5RdTujbTYLBXRYg9bXs26Z0xl8PkwQUy5QYw=
X-Google-Smtp-Source: AGHT+IH+++P/R21eqDgTQn+xp0aj6mpEyYARlO13ChiKD2kwSVYr6Y/nEyIUv0KyAiH5JPRhrkK0rg==
X-Received: by 2002:a17:907:c805:b0:a72:4a4f:23d6 with SMTP id
 a640c23a62f3a-a724a4f2491mr1248488166b.8.1719578581296; 
 Fri, 28 Jun 2024 05:43:01 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72ab0b7dcfsm75779166b.209.2024.06.28.05.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:42:59 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2B5835F941;
 Fri, 28 Jun 2024 13:42:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH 02/23] target/i386: fix gen_prepare_size_nz condition
Date: Fri, 28 Jun 2024 13:42:37 +0100
Message-Id: <20240628124258.832466-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

Incorrect brace positions causes an unintended overflow on 32 bit
builds and shenanigans result.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2413
Suggested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/i386/tcg/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index ad1819815a..94f13541c3 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -877,7 +877,7 @@ static CCPrepare gen_prepare_sign_nz(TCGv src, MemOp size)
         return (CCPrepare) { .cond = TCG_COND_LT, .reg = src };
     } else {
         return (CCPrepare) { .cond = TCG_COND_TSTNE, .reg = src,
-                             .imm = 1ull << ((8 << size) - 1) };
+                             .imm = (1ull << (8 << size)) - 1 };
     }
 }
 
-- 
2.39.2


