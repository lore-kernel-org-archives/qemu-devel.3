Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36EFAE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQBDG-0005Zp-Ac; Tue, 24 Dec 2024 15:09:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDD-0005Pp-J8
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:03 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQBDC-0002up-3i
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:09:03 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-218c8aca5f1so66387505ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070940; x=1735675740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1RODzffUtUxINNUBBssSAHn/zSJ6hm+VWiAhpzm3k/E=;
 b=wDVo3/t4PYaN+gxajcQ8ppA/HJBzaJTrRYsijcfAoM5S++EmUwb4rfybtBGHa3NFGk
 jMErJt6uaknxeY90otCUBRZYs+PvYAlnmppVzIDNxroo/qE2C9aKz0iuL7ACRZspzjXv
 w6lHzH2PnF6OPk+KpwgtJwJC/TcQIGOTldn2fFPr78vPi4CuVZwhxifCOG+v45clkdfB
 ytpQPWyS/TExyTJr/afAm4vp4icbykTiX8R5+F4gf34FikrRjOsju+wKUcwG4HgcZknN
 EG1xW7F4gC6O8oKjzzlFbcngSqH8j3JGUUBonocZAhMOYXDfxVxMg6HS9j6OgaCsKNZd
 Hphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070940; x=1735675740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1RODzffUtUxINNUBBssSAHn/zSJ6hm+VWiAhpzm3k/E=;
 b=NcMcXTCnXzjkePuZqHd6feFW8uyGIU+axkbWglQq6aaBMPuI4L60I2nZi+0SVrtuor
 j01x3AxCIPLVuFHrqa58joMO9+1HgLzbYPKH7yG17GEGCg/pem5IEpwoFuNqbEKCaj+p
 Y7XR0ht2/0sL58iuQOUJh9POAEgALmctO5uvmdAnHO/IeGgWGrg4/ZsdGxpEadHaw614
 D6O6CrcBQkOoGrBQf0Sf9v5Be5UkveQFcPtNw1Wvyzh3GzXXRrdxzpxWoEvjEO+LXRxj
 nYbRVRBc9zKuJGG8dBkJTdESVWp5SdL3ssHq4RL/IC8gOBAJjodUlgd5EiI8k8Kd4PpP
 5yFQ==
X-Gm-Message-State: AOJu0YyLIA8dp7uY8OHBsPh43VJlvn0nsaQXACcDd7UhN/kTeTRt555I
 2h/riwbMd6VED1ggbBqB6AQo/wyMLZst0jy9ygve1nkj/yJT028TdHOX61n/5ecSfKh22ofdIqU
 7KTY=
X-Gm-Gg: ASbGncuED/uAkNk1JrhO6HyCVX5hJVwUraAmf2wXvKzoG7QTmVs+jEDIwQPz+OyvWag
 Brh62HcYj+Dq8OEzkQP9HqKY+FH3q6RwnuV3Xdi6apflaXBxL86d61cmEbprq2ymLhnx0WOGyJJ
 V2IDSJyeGIc15kfj5YH4aaxooAB/zpxqn3ujbUD/mwcCXDrkcbthdRcWIp1401RebYaf8MP8mvQ
 qfd14YjZoz0zOHJrHWqZ3jaYkOI07C462DTpSdah24Z2OxgsAW3MnpHqSvOiygJY44jXwy+lzgy
 smkr6D/yzzrMZtIZntuQbzsM8Q==
X-Google-Smtp-Source: AGHT+IEgO0wpSQUuLyabT45OOJ4WuBq/QwluoLTMRBwb/NbrHL/SHPb75KGyXMNfuMZrqH6l0mQ9lA==
X-Received: by 2002:a05:6a00:1909:b0:72a:bc54:84f7 with SMTP id
 d2e1a72fcca58-72abddbe0demr25550027b3a.12.1735070940413; 
 Tue, 24 Dec 2024 12:09:00 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8309acsm10033521b3a.45.2024.12.24.12.08.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:09:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 40/72] tcg/optimize: Use finish_folding in fold_cmp_vec
Date: Tue, 24 Dec 2024 12:04:49 -0800
Message-ID: <20241224200521.310066-41-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index c61d0eae4e..ccdac7b7d7 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -2480,7 +2480,7 @@ static bool fold_cmp_vec(OptContext *ctx, TCGOp *op)
     if (swap_commutative(NO_DEST, &op->args[1], &op->args[2])) {
         op->args[3] = tcg_swap_cond(op->args[3]);
     }
-    return false;
+    return finish_folding(ctx, op);
 }
 
 static bool fold_cmpsel_vec(OptContext *ctx, TCGOp *op)
-- 
2.43.0


