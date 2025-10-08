Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFA01CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:07:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cCq-0000Xx-5N; Wed, 08 Oct 2025 18:00:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCe-0000Ar-8D
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:09 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cCL-0007Mu-3i
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 18:00:06 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso308685b3a.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960786; x=1760565586; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgapaYKJCYI8THelUZOsiqX66vR02pQghFFIRA5mWDg=;
 b=GW0X7MZW1oi+o1DiiGVx9EN+RJj8sIw1nMijPOO+d6eCQkk091d9zr54Tveo0aHsMs
 WIYx6Kdx88LrEVEv++izOvW0yznzYpjyvDXR6se2I91P91bCqSN4a6hxkT9lBSkDELyb
 ZybmfxevZH3CkJq0TMQmaK5w636o4RB/ZU9p+hBEQHW2cjMFov9MhhLe7yRKYrUGQpf6
 SFzJUyxiqjRTC4NjgLmzfEJtqXi5MRX4qm5pxBJIclMsqQvwxY6qtPiX26Q/EfqyeNlQ
 EdNOcJD8jqAtOs9aGWYJxwCFuck/MKQmjmggqMOtsF9qO1JMf5rf6Sco44oJ6zaOFGbv
 YUuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960786; x=1760565586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RgapaYKJCYI8THelUZOsiqX66vR02pQghFFIRA5mWDg=;
 b=a+2Hshw8PYk7lyAvxoccKPomTjYxi7Qym6QiMp/lgocdc7EVTwiJbU8b8W2qbLGwbU
 JnUS2NwD0A1tnX1Re79kcnpd1P5NQIVuk9Pw7YVbGuPDbD0spEsuYRDkDREENNTNU+PT
 eSKuARaPHf9JtlYFbQMMJsZqX6MsRPGR5O3nlq9po8YytRmbd15pzatIsFMljo8GuaIV
 4z2f0Zkfwk6J92NLfEXKVi20jf01iV9NACt6oafECW8/5LrRtyEj3q26QUFOr2Ry85An
 ILmJZYhaTHJRNWn4EXQ+vqr869I3z0iXWY85FZcmg3RTAxFqnv9yvWDEPFqCFGbdY3ND
 Vwrg==
X-Gm-Message-State: AOJu0YzCMciGtmeTThBwqkTuCS+vzS3fQV2DUNJrjknswyZMXsnkRVQt
 L4SRujuBcogRN0EgXGF5oOIPOmoS6f7e0yc4gMIKPYhOwPKoPhDLX3BGBziiWpo/91DuB4QTuve
 hYqiKAK4=
X-Gm-Gg: ASbGncv2oHxUMgfBNo+85LKNgn05C6KF5ZqeBuwuZGlf4FOjJJ9Q4qOrbiDKic+UVP0
 HsaoJk2i+nUFjzVjBy91NVNpvhF1WceP8OMx8H39Ayx8f6eWVRKCp/LlXGljY0ER9ZoZeUEjeil
 hEC4MPWFL2ucoLuwULJgjczo2+v/4FFbOabU1+5dl7Dlsmaf0tXDxHqQXZTcb3Meyr+fmpruq2W
 6javTfVYV68T9DJDFKwaBG5RNYjWBNlaSUnSu3zN+0nqE4/ep4Jn9+44jjGNQ/bOAaWgpHp+6Q2
 CRAFgkfPjs+cqIUXqJszMzAeO0hWvB4CGMjvSmkaRh28yjbHKawXtcWruIw5b2aa+JIwQwcOzqX
 ZarTuTN+gZs2IXjPPqN4fq8PQ3bty7np1UDhB1wriVEIBrQmS9etrWVKa
X-Google-Smtp-Source: AGHT+IGr9pJXJ7DRFUgrvSMpKbB+wHWn78PCwactkuSkOYrFWKhIt5CMqYw/s3bDk4N99nY/9WPs4Q==
X-Received: by 2002:a05:6a00:3926:b0:781:1e08:4459 with SMTP id
 d2e1a72fcca58-7938714695bmr7429591b3a.18.1759960785422; 
 Wed, 08 Oct 2025 14:59:45 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-794e1fc9db6sm740724b3a.66.2025.10.08.14.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:59:45 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 47/73] target/arm: Implement GCSB
Date: Wed,  8 Oct 2025 14:55:47 -0700
Message-ID: <20251008215613.300150-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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
 target/arm/tcg/translate-a64.c | 8 ++++++++
 target/arm/tcg/a64.decode      | 1 +
 2 files changed, 9 insertions(+)

diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b72aa968cd..38a1f51ed5 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2080,6 +2080,14 @@ static bool trans_ESB(DisasContext *s, arg_ESB *a)
     return true;
 }
 
+static bool trans_GCSB(DisasContext *s, arg_GCSB *a)
+{
+    if (dc_isar_feature(aa64_gcs, s)) {
+        tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    }
+    return true;
+}
+
 static bool trans_PACIAZ(DisasContext *s, arg_PACIAZ *a)
 {
     if (s->pauth_active) {
diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 2ae73f443a..01b1b3e38b 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -248,6 +248,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIA1716   1101 0101 0000 0011 0010 0001 100 11111
     AUTIB1716   1101 0101 0000 0011 0010 0001 110 11111
     ESB         1101 0101 0000 0011 0010 0010 000 11111
+    GCSB        1101 0101 0000 0011 0010 0010 011 11111
     PACIAZ      1101 0101 0000 0011 0010 0011 000 11111
     PACIASP     1101 0101 0000 0011 0010 0011 001 11111
     PACIBZ      1101 0101 0000 0011 0010 0011 010 11111
-- 
2.43.0


