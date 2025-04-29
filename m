Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 016EDC3ABAB
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 15:40:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9n3V-0006me-7B; Tue, 29 Apr 2025 11:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n3N-0006c9-L4
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:39:26 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u9n3K-0007cW-45
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 11:39:25 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so41714005e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 08:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745941158; x=1746545958; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eqNWxGIMem4uer7YASxHLzlAMSlAZlNycae1AJ5U3ss=;
 b=Vk0P5cEOyIuNdaLMgM8k0PgGp6d+EJBOimM+w2KciDnS3ktzFY4wkBf92Iw/sOXCXc
 f34r96H/zsUa8VJsRBOo0gMD0EVEkTK2ERelBXC9NdNXwriD1nRyVbfT/dyPw4ODd8PN
 c0vIfw0HoT9MOPyvyiFqAfO3eklgNYQj6g7AMYhKboMckQIQtIeMFxyXplcBh7qYdVFL
 IUbNTJ6m4mIWq/ego3lImULoM5vLa/GowcWjAVqGzdPM2c5vOEGXTynJP59V7g2ZxuyM
 aYrD/BFN++M7VeYkXmHdrZ4nPeTEHzDODZk8DtcMym06uR26bsWTbDfZcX/fvIXpWhNn
 oizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745941158; x=1746545958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eqNWxGIMem4uer7YASxHLzlAMSlAZlNycae1AJ5U3ss=;
 b=tQ7ma4QjsCe6sDiEFtPElIFkqwKlw41v+YncqYByfNr8ld6XPIfTAspTG3GmtIz6sY
 SX8MAawltwED89MxafJGOIUwdcXgjDpJnG9TrN5vWec1NCZp4lM1Z6OKwwaj/swG0Z+K
 LvgqcIq+I/+imBu6V3+cFkkzIBhqULK1qJnvVXiOmghdxzBCjC3EKH7vNNqvAU3l4qxK
 cR/9VV7v1RpcFmkDPZ12ul9HGVRX7VsymHSnXbx7blUEnDv4hmUiFm2JK1mCMnX5JEZA
 dPDfqbAZg7ttvZPeBXf961Jo8OhqQeNcASmuttvvhPUVuI5rQGlgwKCHtNgbQe1K+Wak
 jVxg==
X-Gm-Message-State: AOJu0YwI0nDnrUE8mjaPay74FbNMOGWC6rdzpiyPUFiO9/1kb1Bm++9R
 L1YBamWQ5T4duFlUsW0ajcfZtZl0HRDVyGNrjWsq6SA3Qq42Z2Naz9SBu4s4+WJdO3kPtqTpug+
 9
X-Gm-Gg: ASbGnctaY4BQumZ+iIQfwkMSm4O1c3E6yEMiDiQLJOXxJFij7uhpEsBJBNhI0y0Eq1a
 XqvlaiKoIYXRQsXARq7+mkX5/NPAySP3JPvdCEm5Be6zMJ0EJ0YbO9y9k3+EnIYHFDzTqfKmI+g
 YnE0+8k2BG9NPEmwsv8ozHbtVoU5XV8d5QiRpJ3skr5dbsW92lE9v3LSZm68fFqLWjF+hUL9y5O
 bNKsarpYlXRjuFLwbrBqcWwkDN+0JA+BQx/0GKtDvFWjsAC1ChX7JxrkfaYlqa8HQP1xia2EAJe
 rR0Pp1/gIAnG0gZNNNzcJaVc18PuwFOdvVzdxXpaMLbCPQZYATKFiDaIWCICjDiJNbirpwL4SuK
 LvjJ6ZbC4mzRnqWckqaNV
X-Google-Smtp-Source: AGHT+IF9Kd0Vcs06nHCXSWtufJnNikAFf/YCbkjTEQzinXMkgYubgZcNrHYGPmAh46h9rhrxBiksfA==
X-Received: by 2002:a05:600c:870f:b0:439:873a:1114 with SMTP id
 5b1f17b1804b1-441acb065eamr34645175e9.6.1745941158356; 
 Tue, 29 Apr 2025 08:39:18 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441ad8149afsm13772635e9.0.2025.04.29.08.39.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Apr 2025 08:39:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/4] hw/arm/virt: Remove deprecated virt-3.0 machine
Date: Tue, 29 Apr 2025 17:39:05 +0200
Message-ID: <20250429153907.31866-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250429153907.31866-1-philmd@linaro.org>
References: <20250429153907.31866-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 83bd1152804..f70d90d12eb 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3577,10 +3577,3 @@ static void virt_machine_3_1_options(MachineClass *mc)
     compat_props_add(mc->compat_props, hw_compat_3_1, hw_compat_3_1_len);
 }
 DEFINE_VIRT_MACHINE(3, 1)
-
-static void virt_machine_3_0_options(MachineClass *mc)
-{
-    virt_machine_3_1_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_3_0, hw_compat_3_0_len);
-}
-DEFINE_VIRT_MACHINE(3, 0)
-- 
2.47.1


