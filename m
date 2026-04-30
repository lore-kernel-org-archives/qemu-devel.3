Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA4FFF887E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:07:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIEuu-0006uV-8Y; Wed, 29 Apr 2026 20:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEus-0006nO-1b
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:06 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIEuq-0001n9-Fp
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:06:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-82f943870baso166774b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777507563; x=1778112363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqpUFWXlE+yNso214pVWpAnT/3t/2kgkwE5/W87FM+U=;
 b=ojXqJWS/X78eqGUK6zcPd11AK60DLmhN0gexHm0A2I0Oh3it5a2zKtRpCOYAzWFGl9
 ymzaPRwCTLwkZe+JTq/6xwCWelvP+iFoZDE7muSjkH3c1omlA0tQF2S1zS2PIloCCf1j
 OTvB1B3tIbA4Oo5VDnhqlGuuT5mXdXrVDaM+xH74gJfKp7mBIBci1GNgonAlJ8V5iNvu
 +Md+TvUa7YqaoJm20ys/xFXAZ+oQM/YmTIa9yjMW5SE41Fr8Xa6owCmKrH4RECGdcdvG
 j3ceHND9/KkI4tLz7ht6Bsge1PfWHaaJR0fKdm5cxWfinLXB8M5hu1Cu5wf6cIdjoINw
 EgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777507563; x=1778112363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JqpUFWXlE+yNso214pVWpAnT/3t/2kgkwE5/W87FM+U=;
 b=FszHVX9XV7dSgT/wb/APUOPUslxbmz1GalH8CWr65Xr3QWbkWGKWeozeF1sqPZZbZ9
 chrzWVwoTWt4WOIVeGk2ALyssWcfbUTCpQ93lg/OtAyheA+UURSbnckOfA9JawA+O1F4
 CQKUma1wXhXJEgsvqNiOHcpNHTuNiPmUdwFPgEF3Ix/DMw4OJp81RXQpiFBdVwknu+Ur
 TMa3wkijmQVi0olCAX2T0PkhwmrejHh1ec17+TloWassPUfbGPLCJGAb79keMwq/MslA
 YDxpfyipNIdCV9qiSjE0ieDJ47XwDVHpyrUPIkmnAAuk+zq8C3DIdOArgDN0pMlgB78L
 Ki3w==
X-Gm-Message-State: AOJu0Yw4f4qlJVUaZF5wmtgQn9DOSAwcWkFHMkfUYYYjophqaeQQpzJR
 oByckXgVRQTJMdNA5aAl64kKC2eY8rdGagK1C4HGl+n3gxMvVpuBfGu+WoSM8nFQGxKicujQORJ
 BHC7Bk7I=
X-Gm-Gg: AeBDievyRiyhBweK1bQaCslN5bfsYf9KSB//qtl+Fw4ZlTDUQ9VEsN2zc8Wt1ZeCiyu
 MWnKqCrFslWk1IH1aTPObTiYnCaJwbeSl0VXpFF9fsyqxk6o+iRdL5Wdz2p2jJSRvA54NWtfWYQ
 kAlxOg+IrEUhyuNcRsbiEbLeqq+6buTX1jtak+wa52LkGZ8CEj8hS+sRtcRQ8jzsxL/BCGyvbEW
 DmAYvHdQCEi2uaEEcQJFZZgiqFuH+xlfkFa3agalGC9JvaVwNY0SU9mlrE4XY1bYwn6wcyLOxAG
 eJg/+dACgJhoMkjtdlq/l9UDHhzJJ5EQBsKaaXb7U4oLxkaC3HqKTYuLEcpEXdHwgWEPkHd1xIj
 Z+PdePQL93Tnk35630UeLB1GaGSJ9SXX8ffI5NyvfqQbdk6l0qmWduHhnD806SY4LW9Ilh92TMY
 M6qXo3aN+6rLj9aOWiTh9GbQSaQ6kLcQ0fZWDZuHpk
X-Received: by 2002:a05:6a00:94cf:b0:82f:4191:da10 with SMTP id
 d2e1a72fcca58-834fdb902c2mr909953b3a.6.1777507562919; 
 Wed, 29 Apr 2026 17:06:02 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed7ef7a8sm2928667b3a.47.2026.04.29.17.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:06:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH v2 15/40] fpu: Sink exp_bias adjustment in float64r32_pack_raw
Date: Thu, 30 Apr 2026 10:04:58 +1000
Message-ID: <20260430000524.56046-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430000524.56046-1-richard.henderson@linaro.org>
References: <20260430000524.56046-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Share the float32->float64 bias adjustment from both
the normal and denormal paths.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 fpu/softfloat.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 7d67e25c17..b7d461bca4 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -1412,14 +1412,12 @@ static float64 float64r32_pack_raw(FloatParts64 *p)
              * in normalized form for float64.  Adjust, per canonicalize.
              */
             int shift = frac64_normalize(p);
-            p->exp = (float32_params.frac_shift -
-                      float32_params.exp_bias - shift + 1 +
-                      float64_params.exp_bias);
             frac64_shr(p, float64_params.frac_shift);
+            p->exp = float32_params.frac_shift - shift + 1;
         } else {
             frac64_shl(p, float32_params.frac_shift - float64_params.frac_shift);
-            p->exp += float64_params.exp_bias - float32_params.exp_bias;
         }
+        p->exp += float64_params.exp_bias - float32_params.exp_bias;
         break;
     case float_class_snan:
     case float_class_qnan:
-- 
2.43.0


