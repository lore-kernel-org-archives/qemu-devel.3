Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7C4C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIk-0002eJ-10; Tue, 22 Apr 2025 15:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIP-0002Uf-Lx
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:43 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JII-0006CA-Ko
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:40 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-224100e9a5cso66501515ad.2
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350113; x=1745954913; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCoWmgPRVw8+vOgQ2VpvLXdyfprmS+31wGRDcwl1Zz8=;
 b=ZViyN7mVOWvtlhDd76fj9g1D0yknMPzpVS8+j7LxJIIZunlkqr9Oh6FP/ifx4v2ymN
 LDv7Y0nJ/y4VoZJoGZxgj413eUxXUe2d9/de66MuP3acwV3csnBsC6QDHb2+d2veqsYt
 McQCLIH1IUaPOGFAkDQHC6Ur4vgEkvXD4blnGeUITeMVMHyfEthX8lQa0eR2K7dteOfU
 UuQAVHoUwfCf+RqEJiLq4jL5soFiAD4obGCUGc2fHH79WsP7dQWDEn22AcbG7UK3qg+O
 Fsve9b8Laaj7BL2sUx7Wu5nQZWJy1S+s5FbKoi6SKB+p3lK4ZPgX1jsS31t+xkfoYB7T
 CxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350113; x=1745954913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TCoWmgPRVw8+vOgQ2VpvLXdyfprmS+31wGRDcwl1Zz8=;
 b=KR+0HMGnSXK9Ba08YOdtnzQcQVnR7zhz66Ml3kzCFtm2qfgiLdoFy72Cm8WH+T6/Bc
 qrzXkZk0bCi8nUkeRG1JKnaA+PZbafK1RfROsMseYykOG37xIkCbuS5g7uEx9ThPOhGo
 CJ2w2sc/PqOAu/Taf3XmRK0SQMIQclIw8LF23pKGprNaDz78zDdn5Fk9xFDFRk1qR4M1
 TD/3X3sHgx/oJgj/pmMuhwmk0YMOFObxaq5Zs3tgG9aeJe5BU/HjZ6kKV3CDtruv0+5R
 as8YqtA/p8iAULWlruSoBL44T0KRPtQq7sFnimQAkKPRfxr+PKAat5snGMhK+WUoIsk4
 BQXA==
X-Gm-Message-State: AOJu0Yxt/wvy4lF9S2snMpuknN8NSc5X8+eM5Bpq3mP/g5sgk4yMifYj
 1ltZ5dBBpWu58Qq11qEYhJ6GtHQcP/TpVMKwQgR6xaEeap1m2fG0Qpy1EgoaXRA/zzcK86WMZ+2
 P
X-Gm-Gg: ASbGncsWBXMLPkXqzRDZx7uRWVQC0ibPY7zSBeS6exzgOfO7MwGxIB7HiSNAmf1/rm9
 paTe7AzrppmfA1MmMTdP5l6wj3jW/vAM0GDd5mFSxecMCvqd8z0VYW02E0nFcpAdnKIfpsfqndH
 eIKDqjXAryk+diIVq0TKrPggUVWvrTbiiDYxTvJ5vZ5xrHP4TqKkbXnZzODRFm/vzwTH1OGvgnj
 CAbIBvHz/0qzq7tUZ+OxccXo6fwZKTu8+05sMspR7IeozsyLzK9nfwS6FzSFr/4VwjruEjiJsWP
 rD/Pcy5YKmamTmhWiLOyZuM8pR1fB4xSiJG9+QwcEPzM7Yhc2xnHNdtRyKpqfUS/bnmMRdQ1deE
 =
X-Google-Smtp-Source: AGHT+IG4Qk2dCi4KiRk46AXsGuoZmIxMSfEZ/dzNAijfZq9tyEcot8OcxoFeShosj4lcbc/unjEmAQ==
X-Received: by 2002:a17:90b:2dc5:b0:2ee:863e:9ffc with SMTP id
 98e67ed59e1d1-3087bb6bb41mr22394128a91.21.1745350112937; 
 Tue, 22 Apr 2025 12:28:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 019/147] accel/tcg: Build user-exec-stub.c once
Date: Tue, 22 Apr 2025 12:26:08 -0700
Message-ID: <20250422192819.302784-20-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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


