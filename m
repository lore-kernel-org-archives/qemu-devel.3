Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CAC4C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 05:08:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdjlB-0002uo-DC; Tue, 13 Aug 2024 01:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjl5-0002ZO-O3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:48 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1sdjl3-0007sU-83
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 01:07:46 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-70d2b921cdfso4562263b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 22:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1723525663; x=1724130463; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hyZ3BgC3wzWJ/AN2QtdtJKt6aJY0U1HtqG5d5wV9Xns=;
 b=XSJ0uotr3pvBu2djGMYIDhe4BySxO6uRGv+vtCNHy5MBSsKBmvJ8sRumhC6T0PbJfE
 lc1LxIfjSFG5GwFEKGUs4KD3pIFTII0lJFYwIxFKYqUxwPsaoqpM3i4toN9owDec0SZK
 xYfBkq9tpJrS5ALXZkQIBiebqlmp0lB0HlAisf6jVuKmF2/Bw0V8ldMHA7hLoV6eLoKO
 Y81MmmYQRR763KOqNyIL93YN7aDIM9etTGdRWk7g8lmsGELL7Zze6A3oKtvClvmjQD2A
 Jrnxd/1qA0a1Uwv5ZQ4BDXsi4s4n9ey6eLX60Gi0jlsogMN98VXRXx9frEJ2CoFBnleT
 BLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723525663; x=1724130463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hyZ3BgC3wzWJ/AN2QtdtJKt6aJY0U1HtqG5d5wV9Xns=;
 b=lHvS8elkKnzwOeu8WXaMlFo+BxXtCWUUcMA4XhCD5U5495A77zoLfdYS/BLunjYzF6
 2T4eo9IqY+erB3c6Jn7FkqlSPzkk60vJVdi3yBmg1TPRIr3TP99nFxHlwEfCDoQ9cMsR
 xGia02tVWb5jSj/0+60uSNWqaXnRr/u0MddXK7DyfBSB20YZzM9jDeYbrfopUZZ9TnOZ
 ANggNGzPHBrIeDdOF3cr2lW8AHug99ypHs23DWZutqUzZlLUfp+8SUFMLDIyICFRUELm
 gSSnpk0VsfyD0Njn/+XjANFH0RArkuHStQMcZVKBvyBzty4dZ9ffwuMHVdoew96eK3ez
 UkcQ==
X-Gm-Message-State: AOJu0Yx5wL6aUaC0h6gvUxZZdAkX26At0+UOmxkUMIgNYkJjPB0Yme4m
 U/SEjgO2Uggp7Asob/6nluSEm2sOk+MmJvTtzQEnqFMJiFZUGNgCphBPKhok
X-Google-Smtp-Source: AGHT+IGUZJaX0+DfIM9GvJLMLQzHuaBwg3cbj32p6CMxk6uEVNpKXo2/zCgCvRCqY59PF1D9iSmACw==
X-Received: by 2002:a05:6a00:3d04:b0:705:ac9e:1740 with SMTP id
 d2e1a72fcca58-71255144fd0mr2838701b3a.10.1723525663094; 
 Mon, 12 Aug 2024 22:07:43 -0700 (PDT)
Received: from wheely.local0.net ([1.145.66.74])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e5874ddcsm4846449b3a.28.2024.08.12.22.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 22:07:42 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgalyuk@ispras.ru>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH v6 10/10] savevm: Fix load_snapshot error path crash
Date: Tue, 13 Aug 2024 15:06:37 +1000
Message-ID: <20240813050638.446172-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240813050638.446172-1-npiggin@gmail.com>
References: <20240813050638.446172-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

An error path missed setting *errp, which can cause a NULL deref.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 85958d7b09..6bb404b9c8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3288,6 +3288,7 @@ bool load_snapshot(const char *name, const char *vmstate,
     /* Don't even try to load empty VM states */
     ret = bdrv_snapshot_find(bs_vm_state, &sn, name);
     if (ret < 0) {
+        error_setg(errp, "Snapshot can not be found");
         return false;
     } else if (sn.vm_state_size == 0) {
         error_setg(errp, "This is a disk-only snapshot. Revert to it "
-- 
2.45.2


