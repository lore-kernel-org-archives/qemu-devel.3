Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F239C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmr-0005HU-UF; Wed, 23 Apr 2025 20:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmn-0005F9-MU
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:53 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kml-0004LA-Go
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:52 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-739525d4e12so357004b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455790; x=1746060590; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCoWmgPRVw8+vOgQ2VpvLXdyfprmS+31wGRDcwl1Zz8=;
 b=U0xiM3LA5u3nPPM6brVUHz9AgMxHIUxaHd+01cZVRtBqFPp8VBz1Hma+3y53N0ZRCQ
 pYNniApYTjN2kcP7/Ixe0Sv3I9NQUigFZd6sJHuNfRVXcvSfTy4D1X3QBy4xIUhSt747
 cA5al1/Lv5ytONKGT4d0NKsFHF48tOieUwRXlodSR67QLOp6/+WsGHAQpP/2IzmYhLAr
 esWcwbUcF9uOMzrmHExkVte2WyLKhVjAvSEVnnPm0xxQ4yLKlsIFutFETXnZ4akkyIiG
 AhgT8GA8bQ9c5RDmMUzPn5zhHiG0gdgoVmsmmzkCTvMomFBfQXmrl9Uio064qfjIzx8I
 LjAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455790; x=1746060590;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCoWmgPRVw8+vOgQ2VpvLXdyfprmS+31wGRDcwl1Zz8=;
 b=P1TlDCMFMcuuj5yJ9ksmICULon2d9kjDBr3b17BqBy4DXyWuCRo1xPPQE/01B8AHrB
 uvgjgljshx6SReUC2eCvvEkqHCAIQZdXL+QrfOQ++87Ql1cM56GwVTHdOPzbdEMNGSQs
 ZVhsyE3zXQHB4j+ehK5noE3p//rGHqicbiOnDlGQezpq721mr6FKoe5cPqft/1nZTXD/
 k//4FT6xuehck9lNAQ7rGoHlEV6NferPUhrwAyjw3H61wKZ1fGg/66XUFrfuTyRofBZ3
 iQTFzMQpS+qN9Fmjmvh4xMVjgRKG5M288OVahBUFs4BaCwOcWDKfW+LzSdGRGgy3jeM9
 1OcQ==
X-Gm-Message-State: AOJu0Yz+99FXYW0SzKvGaSnnTkLpqqX+WT5kcbwnBwHiAtSA6zMqrDA2
 Q7RU41ga2HAbZ1zf8/iItlsgoLFiVPD+WJsI2N8HRlVW5neNexJcz87RbF5DQuR7hQsvpMvh3iE
 H
X-Gm-Gg: ASbGnctQ+UeD9GfJLUESetWoKA9DIjMu6+O3xBoz++m2KiwAty3QJLyTdRl8ySom7ze
 bHD6gyZyZHFA8+ZJcBJbC8m6M6Wgxo5EFzsfPqDf3FGYXAK/fWgakMLaQmvK0PEpDIF0fn2KYVO
 yxNX54ynOzGVLmQ2BoMM+3Gx8Q9IJ6LM6B5Azfy3RjtBgLaV/NgDo2o7sI4RpUI6cTQRXn/QObo
 ijlwqv8Hu6J9pJVu0BvuR0552qNy31FE7NEMY3zVc4ilheNe86lE3NeLJyFsrybWQ/SRBNJQGS1
 w4yeMuncSTnGxNEwE6QUi3/3qiivHlRimCeE25YzdAlsK53NCpKa+UrL+y8vVOCsn+YpIIoYxhs
 =
X-Google-Smtp-Source: AGHT+IEzFY+0pQZAfJP88riIdiGWTpIvTstmlwtmV8vuqC0APTTdexYD9BrAWopEhJ/OQOigutPIIA==
X-Received: by 2002:a05:6a00:3a0f:b0:737:9b:582a with SMTP id
 d2e1a72fcca58-73e24ae8c13mr1201720b3a.24.1745455790292; 
 Wed, 23 Apr 2025 17:49:50 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 019/148] accel/tcg: Build user-exec-stub.c once
Date: Wed, 23 Apr 2025 17:47:24 -0700
Message-ID: <20250424004934.598783-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

CONFIG_USER_ONLY == !CONFIG_SYSTEM_ONLY.
Therefore it's cleaner to just add to user_ss.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/meson.build | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 38ff227eb0..14bf797fda 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -12,7 +12,6 @@ tcg_specific_ss.add(files(
   'translator.c',
 ))
 tcg_specific_ss.add(when: 'CONFIG_USER_ONLY', if_true: files('user-exec.c'))
-tcg_specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_false: files('user-exec-stub.c'))
 if get_option('plugins')
   tcg_specific_ss.add(files('plugin-gen.c'))
 endif
@@ -22,6 +21,10 @@ specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
 ))
 
+user_ss.add(when: ['CONFIG_TCG'], if_true: files(
+  'user-exec-stub.c',
+))
+
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'icount-common.c',
   'monitor.c',
-- 
2.43.0


