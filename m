Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16443C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:43:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLqb-0002Ks-Er; Sat, 02 Aug 2025 19:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnO-0004eu-9m
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:52 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLnK-0005zM-6L
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:37:45 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-301a83477e5so2808814fac.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177860; x=1754782660; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xwpjIKFwZpPOs1MrHyzWBavKC4efZpu/4iinDNh8yuo=;
 b=rXIm+/0r3ubRRQUiBCA7hbOb6f9URQQ9Pw0fNK3VtcfkbqU+iBsr7uWl7Gpj4+Qy4o
 Sj6R6GksV7PA0vnIkke39NVCLcWeFmZfLpMgO7N904ybMrXdOKIdSf4XppQ2QMyFBFXs
 N00OD5U+7R85XaLrfKDaDQToykh/hyQZQy3KwoivP9q5WanetZPBzdesMqwOP2SkZ/Eu
 dcrra41SfxnCM6uoXnEplj3cmFI6yho1eJiqrS2xeEhhGGM8ze1C8d4Mw8KyiJFhiaGu
 JCOo3/nI585TRDqPVIBi5UlH6glrI2dMR+5yr5HHe2jQv1iHXMA97SuL+HFXYxwVLZix
 F4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177860; x=1754782660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xwpjIKFwZpPOs1MrHyzWBavKC4efZpu/4iinDNh8yuo=;
 b=FsrXvzXHXXwdy7wP0JB+P76ZfKrcruut04tAkdgsEGrCxdnCy0GKkrj0abNWBmhVCZ
 F2fEwaYweqqrftYK997If2kAXYn5fB2nYEzitHxuhdSKLoB04BidCD5+mK2p+3M+UPS7
 izaHKZTMMQ4wBUGZuSx6FmVycXdgnMcv4Wtadz5HffZOEgyBgNyejqr5tjxirhxx1qeO
 jUuXpuFjwg3Lfpll1rrxCndFlVuFDonZ7tMdGfTIq4SWtOBdtpgOclAD0D87QMOzE+fn
 q99v9nOgtC3bjT0hIzSZwe8yLkNu1YEK9YZyTQQgBy+RdWDr/R+aKoT44dAAwIxlFYtJ
 Az3A==
X-Gm-Message-State: AOJu0YzN4HGihAwJt9n3VlujY7iukl/vvRqX9tE3AbtcdSneholZtWXL
 yq44/v5o3sVmzOCQYFFuJEexOiGXxB+Zc/yeQGiRdyNHF4ugou/IKqxU4gtQVOoybzQtHh5fHdY
 QwTTVrMI=
X-Gm-Gg: ASbGncsJn0L1h5Yn4btaImTh2c8cSZFrdpBj3t21fHZ0/Bf0Lj6tyyut+ng5Z1upgGU
 lTwjiKXoBE9iPilOzovCgjDHjnXxCj9tzI4eVmHxCOdPpNCmCpq4uGXAUqS3u3lRiJ9yIYc13ua
 P5mL7l8XgzDbziwHh0LrYvByUJavXlYEzdGZLTRvWVmp1M6ubDMdHwAbzzP5QuNo8otev737/08
 U7gJjRtLBgQVlZ7sCRVF7OPNw4banmwD6eKhp/HpO8NgQMiP5N5J/wsA3GD15Z7u0pKuMMOh4rb
 7AvtCrW5Ij31MgdNGnEOcrxNPgQDTYrwSQtfJNukRcVaWnWK5Cm8aWn9OK5IdnshU2SY8JA2AZr
 i4AgN04fURoyIiVBAbp2diOGTNaMaNCkhk5iwxItM40K74gciM8UW
X-Google-Smtp-Source: AGHT+IEKH/KntxcCjvRSkAjlK8IZVrRHAV4Zkn0dscop5y38l99zhU4CyVGurC2n/eEMoUsim5N3uA==
X-Received: by 2002:a05:6871:6a0b:b0:30b:8821:aba4 with SMTP id
 586e51a60fabf-30b8821b1a0mr305076fac.20.1754177860403; 
 Sat, 02 Aug 2025 16:37:40 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-741a71dc78asm380409a34.30.2025.08.02.16.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:37:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 58/85] target/arm: Implement GCSB
Date: Sun,  3 Aug 2025 09:29:26 +1000
Message-ID: <20250802232953.413294-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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
index e0548f7180..45ff7bb0b2 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -2072,6 +2072,14 @@ static bool trans_ESB(DisasContext *s, arg_ESB *a)
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
index d034d96b37..e8b0ef07eb 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -238,6 +238,7 @@ ERETA           1101011 0100 11111 00001 m:1 11111 11111 &reta  # ERETAA, ERETAB
     AUTIA1716   1101 0101 0000 0011 0010 0001 100 11111
     AUTIB1716   1101 0101 0000 0011 0010 0001 110 11111
     ESB         1101 0101 0000 0011 0010 0010 000 11111
+    GCSB        1101 0101 0000 0011 0010 0010 011 11111
     PACIAZ      1101 0101 0000 0011 0010 0011 000 11111
     PACIASP     1101 0101 0000 0011 0010 0011 001 11111
     PACIBZ      1101 0101 0000 0011 0010 0011 010 11111
-- 
2.43.0


