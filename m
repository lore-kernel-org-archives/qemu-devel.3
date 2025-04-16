Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4D12C369C4
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 18:52:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u57s8-0006lp-Et; Wed, 16 Apr 2025 14:52:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57s5-0006lU-G4
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:52:30 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u57s3-00026d-M9
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 14:52:29 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-224100e9a5cso114905ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744829545; x=1745434345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Vv221GdfuK4r2mwZnrVqZmxXBkoRTIrQL78vHAzQy7c=;
 b=q0SrLyI7haRAZi61ApI4irJjZtD4681FOkcgcRZhf+lUj+V7NFAzk26Gx4nSAlWBlI
 ZBEtL20vbOmmYhJDbldX7yWtVNWiPr/Yo/KyNleJaoIBnRTwLEh73sAgcJrU+x7q3DgH
 oELa04zl9I5nvYF6Sg5x9HPYY3juH7eqrNNaXd9D80hLuh6QxDq2JRa5z11swuSctcjM
 t4OrkDq+FiMQm/DmwjMJL4/nNYto+wDTFi28kOT/Px1bciKy5zgs3ij88YCFFPRgLRrd
 PO110wIz/c/EoVCNrCLRoysLeJQIkfXgVPM6PaRl2qsMMwEb8TRKw3aNS8aa1n7Wb8By
 9pYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744829545; x=1745434345;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Vv221GdfuK4r2mwZnrVqZmxXBkoRTIrQL78vHAzQy7c=;
 b=UOjpccWuYYsCHyPBQdIMbHul/2Xk8eAJ4GhAxT2Mm6iNSagBNGbIDeSaZfw4KzRH8a
 MjsmWQ/xoGYlTWXrfdR/ul6YZC95C1bGnAfcByA9bxsu0hQ1/ChWALfB9HMq0vT3LEwr
 QwLnFGMBjO0qJe8aC6NUeQvH1QrgiVF0x6tWsIWNK/ftIeCBDfqcl+yNwebAkJ1mFEZW
 j7REXRZWxwwTH64OP8fOoo7LtWkufjHNfaXnZa5XXGlTLL7wzoUdiAOsrnCg+BJZsFcc
 oeX7qVsKDOzL/jqWVh5EHlHluXEHNXHwPEsXy6XdVme2WzVBg/QKpIVEScuteGFDA9UH
 z6QQ==
X-Gm-Message-State: AOJu0YxmATTqpAPTJeHQKE3+YOGKrpWu4MxMAxmj7r73V7HKFUWO/8vp
 4B17aNdtZsb4DBHDNIbLoQb/iT+aWq8q47bfLE3eSvyrNpzpB5qCBzgvpO0eB6jvLwoeN/1OEbV
 C
X-Gm-Gg: ASbGncvgPIKwwMYHYqn2alRN2ag48eyLMaZ88oi5vLnaDszFIWM0nYDwexd1j0F7Q5z
 HjSx7TA7167nTTI6AEdo79wbYDV/81JQxOhHtxAqGLhFadw9sU13sQaCUn9VYgA/v6OLy5zt3jk
 Edz+kHNHaXtKCKs9QNQQyjUjzQxnLRpJKY1WL7wbLYndCNJK2XTIEKTP74HI0+HRA4xYfudb988
 ZGff+tWkn0FQ22rHomAsizfu7euQ256sNJb+OcdRnJg9VxP2HaT8evOFwBmBykEht6UnDK86Xua
 xGiU0SS+aR/RasR9pFz4hJNwyVGToCMHh+NJLj8+MOZaBYXOJfA=
X-Google-Smtp-Source: AGHT+IF4mmmpjx0MgGCLFOctue/OBR/6luNyPQtpTgPyDTRl0Yk+VBGHfQbA0wnKy3FTDp7F8MFmZw==
X-Received: by 2002:a17:902:d4c7:b0:223:33cb:335f with SMTP id
 d9443c01a7336-22c358bc546mr36788745ad.3.1744829545140; 
 Wed, 16 Apr 2025 11:52:25 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c33faac7asm17797435ad.137.2025.04.16.11.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 11:52:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Phil Dennis-Jordan <phil@philjordan.eu>,
 Paolo Bonzini <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] system/main: comment lock rationale
Date: Wed, 16 Apr 2025 11:52:18 -0700
Message-Id: <20250416185218.1654157-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 system/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/system/main.c b/system/main.c
index 1c022067349..b8f7157cc34 100644
--- a/system/main.c
+++ b/system/main.c
@@ -69,8 +69,21 @@ int (*qemu_main)(void) = os_darwin_cfrunloop_main;
 int main(int argc, char **argv)
 {
     qemu_init(argc, argv);
+
+    /*
+     * qemu_init acquires the BQL and replay mutex lock. BQL is acquired when
+     * initializing cpus, to block associated threads until initialization is
+     * complete. Replay_mutex lock is acquired on initialization, because it
+     * must be held when configuring icount_mode.
+     *
+     * On MacOS, qemu main event loop runs in a background thread, as main
+     * thread must be reserved for UI. Thus, we need to transfer lock ownership,
+     * and the simplest way to do that is to release them, and reacquire them
+     * from qemu_default_main.
+     */
     bql_unlock();
     replay_mutex_unlock();
+
     if (qemu_main) {
         QemuThread main_loop_thread;
         qemu_thread_create(&main_loop_thread, "qemu_main",
-- 
2.39.5


