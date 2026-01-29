Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC767D6100B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 11:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlQJ9-0002Qv-Tt; Thu, 29 Jan 2026 06:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIn-0002Cg-T5
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:12 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlQIj-0007sq-ME
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 06:35:09 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4801eb2c0a5so8205255e9.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 03:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769686503; x=1770291303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEeefLwyevAwvJbV1EeJJSkxsmhi2vz8LE44h+RFunE=;
 b=twBwvllTCvqT8H6u+7bRq2mU936RWtG0FfBInH106yHsgl8PXz0uZ5ZrNo6RW+neqP
 YIeTii+Joevj5nxT/+DeojAIwQx4tc08vj1/BCLvQru8VdcNvAkMvKmZLsVilK1M9hHw
 idpGoWBVaNR+wH67kXPVmD5E/bYhKzAGuqG4U4TfSDoGowpJK+i2ceOV2RwHXSi2LZyh
 rUo9Fl9nOASUOE5NwZBZXWdB8U4GHTsPw84MW8HAu4CqKLu2/7OgOhTlK2V0Hh7yfCum
 D2zVpw+eHOU8xvix4UQPBYPVmVCxlhypZ9Wr1c+oEO6oT20CkxZkYadMUz2F1igTFcK/
 ncag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769686503; x=1770291303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mEeefLwyevAwvJbV1EeJJSkxsmhi2vz8LE44h+RFunE=;
 b=cM9WH1zh1406Jty/PUg2NEDyFsHtODC6hAMj1iwcP7C07K84S9VwGO0jgEVjEkFW7+
 Bj3+dUABHdzaXb0+PQI8wamYCP1GWddZch4+b7B8OtlslVJoSUrrnrQvk1hpdWV8tZBy
 FSHZC//a1hvVrwcEgkMngZA1mNTx4JE6hQ+tB80ISGI8yCQxsY5MM4a3uYv0wxuI/RzE
 gYZoMoYIZsH24OfFA+zhd3MGt8fe1VhfbJLWUK7YnnFLUFYYn06keyf1+sIPC+dKUdeR
 ZDvbTjF5nv7ZsMqGebbiC6n9b3ibmRF++YQbFIUPNoZIP3ihrD1yz6zzD9BnCVqSMKTo
 dZaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8iFa5AkfZhf5a/ShRZfNcr9BhAXszVUSaQQ8EpcJsy0T5Nw48Vub7vo5kJRPoVY3QwFZIujg9BGbi@nongnu.org
X-Gm-Message-State: AOJu0Ywwz1Du64srNFVAcAlfnma3enu315QRoglwsBJEJdS0ifWJMhA/
 26kAd3IX60YQQZ8D5SKNPgjrt0OYreYld/ZzvATv8+KKelBUrTIfj9uNj2ZzRfneFzo=
X-Gm-Gg: AZuq6aLyMycLh3Xz1Y+qnsJH4e15aORK/S2z1Aicw7JqlWFmSvSKdXm5vnr2n7SaKgb
 UsY/6vQODjMtwewEDntf2txK5r52O6f9FKivQEBD0HZVZAY3v47XL7n3B/c3AFTfcweWrBqgkIe
 F9Jn83GJrFhHQRqeVW2y3kDbyzqh+7RQhJMw6aafOUSGP26gHj24Qrsx8jxRTaz+lJCekFFTsy2
 VNlhv5oEzS9cwTo7vQDHl53UDNpSfRxWeMFoxkbieQwQNYxDkm4qZabfX2Xdy0juQP0wP+VZRKS
 0sFaPrwqrCLaWAaGzGyfyy+iGhGoZ5N36v3MQ0uYHCnceBU1/VWGTHs3kRwZrVq9+GG0NPa/WRJ
 ce9BBU47bpxtgimJ++41zbhR1DG+luyd2nQP9qBmbKU3mn2sLgwuVPPkVZ9wc16QMd5wZf7cgii
 oI7SE+GwLubeEpLbCbxKmodiNyE0muhg==
X-Received: by 2002:a05:600c:3e85:b0:477:a54a:acba with SMTP id
 5b1f17b1804b1-48069c557a6mr125563085e9.17.1769686502857; 
 Thu, 29 Jan 2026 03:35:02 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c42895sm196311075e9.14.2026.01.29.03.35.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 03:35:01 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 4/6] target/arm: Handle SME-without-SVE on change of EL
Date: Thu, 29 Jan 2026 11:34:53 +0000
Message-ID: <20260129113455.1283266-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129113455.1283266-1-peter.maydell@linaro.org>
References: <20260129113455.1283266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

aarch64_sve_change_el() currently assumes that SME implies
SVE, and will return without doing anything if SVE is not
implemented, skipping a possible requirement to change
the vector register state because the SME vector length
has changed. Update it to handle SME also.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 732c3a9eba..655ce73ee1 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -10127,8 +10127,8 @@ void aarch64_sve_change_el(CPUARMState *env, int old_el,
     int old_len, new_len;
     bool old_a64, new_a64, sm;
 
-    /* Nothing to do if no SVE.  */
-    if (!cpu_isar_feature(aa64_sve, cpu)) {
+    /* Nothing to do if no SVE or SME.  */
+    if (!cpu_isar_feature(aa64_sve, cpu) && !cpu_isar_feature(aa64_sme, cpu)) {
         return;
     }
 
-- 
2.43.0


