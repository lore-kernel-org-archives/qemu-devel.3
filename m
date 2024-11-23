Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D71E6ADEF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Nov 2024 10:39:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEnXH-0003wX-TE; Sat, 23 Nov 2024 05:38:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tEnXG-0003wL-Qh
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 05:38:42 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1tEnXF-0001Xa-Dd
 for qemu-devel@nongnu.org; Sat, 23 Nov 2024 05:38:42 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso26108175e9.1
 for <qemu-devel@nongnu.org>; Sat, 23 Nov 2024 02:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732358318; x=1732963118; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PqmikmZDyeHIBM/sfd9W7X6AK78vfBdfMyKfkZeHz/E=;
 b=AuELhD4YEsT+lpaz3VaxT0Pl3OjB2TUu2vEBYStvkhCwtRc3qV5f2EdYSYzcxq3bqK
 j40ThLeL2++bdo93GlX5Y0wPyqhNcmjkbV8rw2wLDTUZC3u8Vu6tkEfgEh170De/6TO0
 gbAvl8qYJeXGG0zo28CXJ0obnen2NevVWOvRl8/CXyAj2GUZ+5AYNpuzUCU/eVyRVxjj
 DHR6VESBSKQAjqSXxNMWcDcy1sB6Hs3LD4bBceHqnzyzO+DxNGpgLU9uHSO2MvKdO54U
 WnQNygxEk69fAOFif2WyqFWMJO8/mN2ZVdH+dSe9zYMuxKZDBRoVxwcaX/3J0gjyMAMw
 jGBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732358318; x=1732963118;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PqmikmZDyeHIBM/sfd9W7X6AK78vfBdfMyKfkZeHz/E=;
 b=TeF0AAN9jzj5ZgpEZ9HVCg81UiVfCrUBIe3iYRwnh6oDKxEA+WJ1cAScs5iu6NnnCh
 KKga8tNKtILrikEbE1FQ1GDt1Us3u7G4dGrydleZS2kX53+rFnn0Z2TDejx3bAxXQ0Ik
 FwQKEKuAI1AgaL18zDmILpyCnmW9ugR5BHnABKGXonSPgBfshbj8Q1rShSHWsnChQ3kj
 04F5j2DCt6IZRIiihwXBx8sJ1BMZOg4oQrxCIZflvywva0CsNsbC8WRe0dApPL74mJIg
 rAy9IBKAHAZ9OJipbn4qv+OJGjMKFaB1ult8B3N4kT4FmePLEtwAM/+rSoHZC19VWoC2
 /qyw==
X-Gm-Message-State: AOJu0YzYcksWVH1nN2tc3Ui5cCr9bwR2Tzdy2IZvu0cbqvIoWn2Ap9gy
 20Wh7/+nCR7c0ZDKGUyTitDq/gpZQ1kUhLVrMi2QDRR14a1aETCQamPU0Q==
X-Gm-Gg: ASbGncsI12zmwY5NVFZa0ZBg1QRs6LG8BQNx2lzpQP0omLt2LtgT62M2Xr4dQlgc3eZ
 DSr9tWWhS2II8z29AzztG3pvQubB563rJ/Sch5122tLTSAXvyciIQdtoTqK99djJw8MaPxW5VJ5
 aBA952FxsL3ZmV6DMuD5kFRBfr5NN/S78KHetY0yPHg7jYwFNl6XMEyuVKZdU2qbnMn8LV9DB+U
 ngOKcNYRA3G+dML9lwLPCK4LJ91SJ3ZFTop9sEf3FQtu9TaWuE7LYzzAOSoz/1+V4lCKfjKGYHl
 ZPkxbhhjoUEBoQ==
X-Google-Smtp-Source: AGHT+IE+kugnKf4tsaSr7+QGaO/HvjiEbO2E2addTRyuny6viYqbGZHm2c6NOgk1XswAnpubYANkEg==
X-Received: by 2002:a05:600c:34c3:b0:431:58c4:2eb9 with SMTP id
 5b1f17b1804b1-433ce41c6a2mr57547205e9.3.1732358317904; 
 Sat, 23 Nov 2024 02:38:37 -0800 (PST)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net.
 [86.9.131.95]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43366c8757asm74862895e9.1.2024.11.23.02.38.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Nov 2024 02:38:36 -0800 (PST)
From: Stafford Horne <shorne@gmail.com>
To: QEMU Development <qemu-devel@nongnu.org>
Cc: Stafford Horne <shorne@gmail.com>
Subject: [PATCH 0/2] Misc OpenRISC fixes for 9.2.0
Date: Sat, 23 Nov 2024 10:38:25 +0000
Message-ID: <20241123103828.3157128-1-shorne@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This series has 2 fixes for OpenRISC that came in over that past few months.

Ahmad Fatoum (1):
  hw/openrisc/openrisc_sim: keep serial@90000000 as default

Joel Holdsworth (1):
  hw/openrisc: Fixed undercounting of TTCR in continuous mode

 hw/openrisc/cputimer.c     | 26 +++++++++++++++-----------
 hw/openrisc/openrisc_sim.c | 13 ++++++++-----
 2 files changed, 23 insertions(+), 16 deletions(-)

-- 
2.47.0


