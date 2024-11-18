Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B79D591B3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2024 20:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tD8Yu-0001V8-5B; Mon, 18 Nov 2024 15:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD8Ys-0001UO-F9
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:41:30 -0500
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tD8Yq-0002O1-Jm
 for qemu-devel@nongnu.org; Mon, 18 Nov 2024 15:41:30 -0500
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539f84907caso265056e87.3
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2024 12:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731962487; x=1732567287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XDyffl07CJF0M0DGgKE69bB4AQSjff6CC/++zS6LNmU=;
 b=MucceMWXFDWRSYZOnucRAck6l8QQvibJJ9vF7WySamtuecX2B5f2AJpJMd/F9qyKIX
 Ad5QHNhnT8cTKavDTk2UuphaZg28iZC7nhAdZouxh6RAPY0jd8HQ9kFarhsOn0NaFLqv
 uXuVZMjBd9RJQppf6fs5Io8nvQKdIu+Q4GOn0f7WVZhwxBFgLS+l2CdTxeJ0p82Fx5Kj
 tKZaKHNOD8CH3Z0KCmM8F4x/xke+m3rWqdP4jEYt3Q3YFblD974wKbR2i6njktLm5NGC
 cwkNTm/A+uscEs/7KPYkMgUrg7hlZz+d299wdsD1wdLJ4uucpRfxK62YCfkga5GzNVOI
 53DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731962487; x=1732567287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XDyffl07CJF0M0DGgKE69bB4AQSjff6CC/++zS6LNmU=;
 b=SHT+qU93NyJsl/3JPzLdJUdJ+lnVJ4ThHb5rQdepwh4uGiZe5qmhGOuiTTAzPxKUGp
 Oym7+TMljOElpBPKPnEp2CR0zp9NxJKPSjplQUnRLiwOVYoTOMdzL1v0SyYQn7d51OWk
 9DN/IzdWraDEJ5LfjAjpEnBKBG7iT9/5O/oHggX+gzFkccZuFU4M5UIOjRlLvGhLPVxs
 9qg+l5wQ+JWWtoKd0Ea+i5+EhNss2/T2uWwWUJpBDpoXmsRnz3+4xXbCSsgvO42mV9tR
 jEecYGocjWoH7StAJdffbm20IoE6mlJnkXiMzk2gEW4vcqlL87itpkGrqTDHV9QYw2Rk
 +GBg==
X-Gm-Message-State: AOJu0YyOeDW43YFQJTyK2TqIjy1QGmi8qPRY56TI2rX6+8z/Vz+M6oEh
 ijTp6JwrrOeCPvJ9Hpn0/fidKlZWd7Tjh6iD8xxbzlCYUOuz1DlB3ovGr4nrttg=
X-Google-Smtp-Source: AGHT+IGGITJkspTspF+mpmMFEAsIYJYpwV43fOSBhBs4gaavK8jRBBNvjIgMbOxxTUO2WMUB3/hNEA==
X-Received: by 2002:a05:6512:3ba1:b0:53b:1f90:576f with SMTP id
 2adb3069b0e04-53dab2a6022mr6181408e87.22.1731962486821; 
 Mon, 18 Nov 2024 12:41:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf79bb3a0asm5061085a12.39.2024.11.18.12.41.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Nov 2024 12:41:25 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4C2505F915;
 Mon, 18 Nov 2024 20:41:23 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 2/4] MAINTAINERS: CC rust/ patches to qemu-rust list
Date: Mon, 18 Nov 2024 20:41:21 +0000
Message-Id: <20241118204123.3083310-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241118204123.3083310-1-alex.bennee@linaro.org>
References: <20241118204123.3083310-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12a.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

As of Nov 2024 [1], we have a new topical mailing list for Rust
related patches. Add a new MAINTAINERS entry to touch all files under
rust/ subdirectory and additionally add it to previous rust related
entries.

[1] https://lore.kernel.org/qemu-devel/CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.com

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Message-Id: <20241109-update-maintainers-file-rust-v1-1-f4daba6f782f@linaro.org>
[AJB: tweak commit msg]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 095420f8b0..373176e445 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3338,6 +3338,10 @@ F: rust/qemu-api
 F: rust/qemu-api-macros
 F: rust/rustfmt.toml
 
+Rust-related patches CC here
+L: qemu-rust@nongnu.org
+F: rust/
+
 SLIRP
 M: Samuel Thibault <samuel.thibault@ens-lyon.org>
 S: Maintained
@@ -4241,6 +4245,7 @@ F: docs/devel/docs.rst
 
 Rust build system integration
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
+L: qemu-rust@nongnu.org
 S: Maintained
 F: scripts/rust/
 F: rust/.gitignore
-- 
2.39.5


