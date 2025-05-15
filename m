Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EF3C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 17:47:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFcfa-00011V-F8; Thu, 15 May 2025 13:46:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcfS-0000zj-Hp
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:46:50 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uFcfQ-0004fJ-MD
 for qemu-devel@nongnu.org; Thu, 15 May 2025 13:46:50 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7418e182864so1420160b3a.1
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 10:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747331207; x=1747936007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rVsacexuhDTK9h99dudm/8TY6NWVjrdnKMHqsB0i42Y=;
 b=i+7WG0pPC744b8+dGfj4xN+sRj18wcHeTFCmHXnTvZ+HZIqr4Uz4UFOCywiISldzZJ
 +08SS6yBK+kGgcIfF8w/TIm06cwYCB017Vms1HdeCoktLHDtDMH/owVaBc8+LS3hEv1N
 oP8Y5foLU3cN/bFZlzYoH+oSHLMJb5V6/CHwSFylImzovcd3SfVtjcQrLGd86jt0T1Ja
 BsBSay5Pw1Qe88rFZd3zDyk0Lb+herXRa6XRgDI9f8qqeTvbBGVdUB7PDB2gDleUmwct
 gx3VjtsKm8qfK0zyhc7uCNmDrrgcT7aRSYmhA0iJzYnfCzDjB5qA60AcDnkg6i8bEVRY
 idSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747331207; x=1747936007;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rVsacexuhDTK9h99dudm/8TY6NWVjrdnKMHqsB0i42Y=;
 b=kvU0/iuaKGEzjaHvIMQAgLd93HbbMKKGhYQwBjcjOrmkTdNwIHMvABkUWStX9HkfQj
 Vp9fZebzBdt7N8rzAJlHvcjw0GhoCrHnKappU6Exs23HZ8L6DHFSPqrDVTmiGQBNsbAB
 lZzB+coCBhGCdeyTg/RNtnaJdPTAWcBMR5iFeuIGvcPritzua+fHn+1bVdAbJG3Kovii
 XaLp1g6kGOE61Mfy45Cj3ujtP++GrXuVM6KnFeTgnK8xLUh3to280JBs0TAyEAcsfkNn
 ulrpbEm9KNp1BGQQNZQ+qEyxsMBqAOQJKSNYGJOo1UazgOnXsNtJJFsbse7lEhNksCFK
 jFSQ==
X-Gm-Message-State: AOJu0Yx4v2+3hgsNrdU7LYZBFrjs9xMSYGVRxYK2dhQk5bbvfWTsJHTQ
 1D39pcLoB6ol91m34Kwem96wI5CyaI9uMk4orytohc8qqflpCERA+B0miOpu7TgOVYmkDE8nqXk
 H0g6v
X-Gm-Gg: ASbGncufhjlnfWaHbLXEKMNOWIf2rkEaBUqbk3HTIIFANdwcKR6/3cwFXbA8EFaYNGJ
 ippkhHvLV8kFZautO2b4YrSKWlwceBBWoBR/W3notZdFUhHi1hOokakqqYIkKCQy5RetVmEOYBp
 G3qM0OBQT1gSuPYjpRWVJv8AAvwv2QT1rj58Exn/J6vCZqUP4IVr0tBtIGWbhxwlvf3n0rYe55A
 2MOvIR+QDQG7exdjsfGR5d8a8dsX7cDa2XY4lb2I044eXOrWJbfW7GsBczYFoakNLjEkJvcS2pP
 /L5pBJgh+m9aGCvzBEBEFE+LQRkU15D+z1mLOpDruB2hBrDYLY8=
X-Google-Smtp-Source: AGHT+IEAYa2bH9UaWLLfI4vADebdaLPcMS2f4ELCGRWN3SnZr75CjPCYFWxaR9waE0NhVC1Ftu6C0g==
X-Received: by 2002:a05:6a00:856:b0:73f:ff25:90b3 with SMTP id
 d2e1a72fcca58-742a98b7f48mr367356b3a.24.1747331206980; 
 Thu, 15 May 2025 10:46:46 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b26eaf8e05fsm172370a12.39.2025.05.15.10.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 10:46:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, npiggin@gmail.com,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH] system/main: comment lock rationale
Date: Thu, 15 May 2025 10:46:41 -0700
Message-ID: <20250515174641.4000309-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
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
2.47.2


