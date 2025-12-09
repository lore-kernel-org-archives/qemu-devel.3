Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C51D1CDC6
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Dec 2025 09:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSty1-0006nz-Ud; Tue, 09 Dec 2025 04:25:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vStxz-0006lF-4k
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:25:07 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vStxx-0002PJ-3p
 for qemu-devel@nongnu.org; Tue, 09 Dec 2025 04:25:06 -0500
Received: by mail-wm1-x343.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso32854945e9.0
 for <qemu-devel@nongnu.org>; Tue, 09 Dec 2025 01:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765272303; x=1765877103; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZJsc/7zy+r+NN+k7x6+P6QM2USPYl25ybm2MMGme1Y=;
 b=qLQnjK/xn+NeB8CjsmxC66tkvrKYrLMOBC6xyuBj7U6y6sWwnP4pgRlg2eqM6CJCcU
 l+WlZbjU+cZyRM4qRqt3epxFAdY8h01xBsRHTPyth5XLIoM4lzxXgoyvDa5BR6Ky4RB8
 DB918aNgTkqvIYJj+tQJ7RMU5DCtstiEyMuPWVP5zVZCQ+ZhOcJl1f5w4GQwd6xhayps
 DoatKAM9T+to2ffoc8HwYXNjUwzM5hvjGVGrJp534enm5zcBGF8BboXujk5nXARN4H+l
 MrhKnWWTsK1fFGsVvwF315aoCCnwMx9eBnXeZAyex1nGNXBkZYKXim3ax0dMagJ709Ct
 6aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765272303; x=1765877103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IZJsc/7zy+r+NN+k7x6+P6QM2USPYl25ybm2MMGme1Y=;
 b=EkLr/ODLIxocA+LBEtBKAGssfuXyIlvcoUayudi8qbMpDG5P9Hm0XL6njU14qzq0ye
 /30cCgsbGUHDnjacFtZYsVi04FWTc+HjXd4Y9vAZ5JfT6o0EuSCUDbAPhCesYJ0Ibanr
 aKJxHbIwQ3ooYcNyNnj0kWQkdofJ+IaMOZUPw611NATdW2KYCZpA4fjYOmj2EtNI/G6+
 F7CbmnGHClB+DP++vFR1P9LK0RTicy9Xl2FQ6G+NcVh54PGw4FbQXMaNADncQAT8Hydr
 SHsivkv4YqS4nIrEmP9rKsB5vetMSoAUwoW2pep1L+/iT5f09nPwwQ0yVxeayvgX5x22
 DWQQ==
X-Gm-Message-State: AOJu0Yx17pe3IxkO2ggMJCeFErSZZfL7xsNnHUjuk/+Ohi/bLfq/TDef
 V+fMeBzoC7pPOSS8eFNRxEUNBJODnAIF3Ix56k2z4eddMaKBMryUjJNGN5CUFQDWAgc=
X-Gm-Gg: ASbGncvN0XTkueT3ShPyPhLNeeFxzHdfs+kklfOkX3GWoHC29Z0AOcIgJhK2lMXy73y
 R7mCFEKoV7xD4OenBWimGVn3gXVZqJI8X7z+DQH8njk07mhBZPVPkSiDJ7DbArIRESwDWxL0vEh
 /CLhSLNh5v8lmjD4YmHbyuXDpTO1xxx8+evbaJqOT3Bueh2ZC/EBbvvfBpEs/l+LRqhn0Q0cK1Z
 sTbybUaSS7Y+UVhIlUq8RCFrgMUJHLOz8lzRXMIYpWj1DK+mRnNKnDPkVqneAhdIJ/X2FC3k6to
 zPccJ3IniN5PcnhotXG1zitvKhUCTa+hmGm0GHqgHwmLyFiXY2hmvx/bdFUAidbKlDusp2hmVE7
 EK/acMnL0CnhEkrdXk2M+xXsPrEEpRLX7KjNIDq3N9F3XblGnOlRmnB7Wy0mjEZU4xSvKopo60y
 xZz0DYbgH0rL8=
X-Google-Smtp-Source: AGHT+IGzACwnbivZERwEL46t6zyXatTk00Oosxpt0+Dy0ORY3ehssEp7POa43K5jNVNibgBocnlR6g==
X-Received: by 2002:a5d:528b:0:b0:42b:3383:bcf4 with SMTP id
 ffacd0b85a97d-42fa071b8b6mr837358f8f.1.1765272303437; 
 Tue, 09 Dec 2025 01:25:03 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7d2226e7sm31598901f8f.27.2025.12.09.01.25.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Dec 2025 01:25:00 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B88EC5F892;
 Tue, 09 Dec 2025 09:24:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 3/4] target/arm: make HV_EXIT_REASON_CANCELED leave
 hvf_arch_vcpu_exec
Date: Tue,  9 Dec 2025 09:24:58 +0000
Message-ID: <20251209092459.1058313-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251209092459.1058313-1-alex.bennee@linaro.org>
References: <20251209092459.1058313-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
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

Without this we can spin tightly in the main HVF dispatch loop and
never release the lock long enough. As a result the HMP never gets to
run and shutting down the system deadlocks.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3228
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

---
v2
  - expanded commit summary and contents
  - added Resolves link
---
 target/arm/hvf/hvf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 8e2940217a6..8288b605299 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2020,6 +2020,7 @@ static int hvf_handle_vmexit(CPUState *cpu, hv_vcpu_exit_t *exit)
         break;
     case HV_EXIT_REASON_CANCELED:
         /* we got kicked, no exit to process */
+        ret = -1;
         break;
     default:
         g_assert_not_reached();
-- 
2.47.3


