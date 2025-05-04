Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18346C369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 05:41:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBRvQ-0002Ve-RO; Sun, 04 May 2025 01:30:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvD-0002Ix-S7
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:51 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBRvC-0004RX-10
 for qemu-devel@nongnu.org; Sun, 04 May 2025 01:29:51 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2295d78b45cso45529315ad.0
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 22:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746336588; x=1746941388; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rZlgeH+rY7gWoAJ7wLcP0EAGnraHtpI1zUMj9EMPIpQ=;
 b=n26v4EaJB+1mhvkzODtVBSY5lxIqk1iT97quMF7VXCADFCnRJT8++xs6QLp8I4laaB
 GoS41WavH1g6TDnfHAilCAx7e7R9mbpCgnBWFWJFvIxzY/YzjTEOKB24B+USQwrJSjbO
 dp3jP/4GzVgCIcijKJm6jSwU5UTZqUbOYUvd+gl3jzwE4z0Kvy0szxag9ZdyF5f/B5aU
 +Jh+FjgFD7j1A8bi61CrlvBiBLdZm3cNwE51KWoSwghLMhO2x4XG7kE9HavYK4b1PA+4
 U/DbjUkkxvA4aFyBSA78Os/hNzKaho9YLKfTRJoZGV0NThuNX7R1Qfmj2HBWgkj70bCx
 83Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746336588; x=1746941388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rZlgeH+rY7gWoAJ7wLcP0EAGnraHtpI1zUMj9EMPIpQ=;
 b=gS1VnFA+LarCApzWcks4WdGFchRRo/8T2P0tw2O1zpN3cQiLyJcNbewdutyKduxryZ
 PHivm8s0s4PSnz/d76iU2jgYYsZzUvk3NL+9/PzZdQq2Hpsz8qFwpG/1FQR6+gu+dnjS
 HgeWo051ZP469aretbgnjrLCZRUTfx7xAt1C9Fs0UAg+unTGgwMx9Az8rpPngACpe9CZ
 YtCkX7mTbnVhjgsE66tYUWrk989ejlY1Fk+Frtn+WC1eM2VvMhvYeN/rspjcY0OP0O4a
 wseZaS8UARAQP/LzvEQZE4hDADPwc5E3Cc7fI4MCYOuQGatfCm+NscJmUZzKLb3+43Ep
 5Brw==
X-Gm-Message-State: AOJu0YzGGQDCal61395oALg9ZVExK34CwUbGvmIkdm+uiZJDuDuZXY2Z
 k2c4N+rg2phC0b43UbgFImp970Sql5SozKhzN1u9ucT+TAcdP8fAjRAeIxUTfbHd6hGaylcuVt8
 V+60=
X-Gm-Gg: ASbGncvpW9Y9hazp/2Mo47DiomcFY39DPDyrrwzRm2dstUJ0QQtbpFMskf6xRjsQGV8
 Qnd3po+XnkrrtRknMgi+hEy/Gg3gjh92FbadewSTV2HdLbCrJ7EbmTp/3NoOlXtA2NMT2LLqTti
 VheKv8QIxOrsXVs6zfTyX9edZtcRAkn/C5wcAleyObAQUChL7KsIixMvxOa+wSky/rbRNlgtwdB
 vin8EF5Hh+bDzBjQHO80MdIM/0FybKhfOpdIPbxvnyAZKxHfVu+qd8eL+xjwfK9pe/jjEl9sx5f
 2ZU4+pifrZC7NbkPXItFz4YcP4EtHSE1JPQWAeM/
X-Google-Smtp-Source: AGHT+IGvRnjHT32PK5YuBRc1hb6W3fJORtPLfFOYwa9VWFtEYD8F4Y3wY4BjdSzdWSGFbFMh9vP1nQ==
X-Received: by 2002:a17:902:d584:b0:220:c143:90a0 with SMTP id
 d9443c01a7336-22e1ea39b8fmr63196145ad.24.1746336588289; 
 Sat, 03 May 2025 22:29:48 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590207e3sm4400511b3a.94.2025.05.03.22.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 May 2025 22:29:47 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, richard.henderson@linaro.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 32/40] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
Date: Sat,  3 May 2025 22:29:06 -0700
Message-ID: <20250504052914.3525365-33-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

This function needs 64 bit compare exchange, so we hide implementation
for hosts not supporting it (some 32 bit target, which don't run 64 bit
guests anyway).

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/ptw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 424d1b54275..f3e5226bac5 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -737,7 +737,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
                              uint64_t new_val, S1Translate *ptw,
                              ARMMMUFaultInfo *fi)
 {
-#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
+#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
     uint64_t cur_val;
     void *host = ptw->out_host;
 
-- 
2.47.2


