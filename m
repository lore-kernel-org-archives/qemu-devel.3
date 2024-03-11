Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B68C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 17:44:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjjez-0002zE-AY; Mon, 11 Mar 2024 13:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjej-0002j7-6v
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:45 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1rjjeh-0007PR-Ji
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 13:41:44 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6e5d7f1f25fso2087367b3a.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710178902; x=1710783702; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TRcl63k4Enolg0XIOUbcFz2ceM8wzscJs4qT96hKv3M=;
 b=gaXKD3ThBCJDUQqQpmtGnxqQtrdY8TNmvgQyI9NhOTG6cOrH42EfVTotCwhDQ1eA0t
 ceWmXvGLUdRQRkEPa3hPnuXnmUu0AwYb5z6h5hLoS2K0990ouOIvwMdcfHd7l8WPWmb3
 EIkj86UUTgvZhWYWRp0DA+tq4I8Zjj9DSFz9hVw0FWZavzgqAPYl40wfMl5q8ofEOcmp
 HRW3s0h8Tbe6Uw5oUctUw4D2ypopiHiLUUkR+w+Xjn6ls6N/jlvYKOLyZzds5NfvjUI1
 iSIBwC/2nCiMaYLafNiPkGk8hg4co0mTFO26+Rg49AndlpWeWYV2vPgAK/SJcwm5mh7C
 lo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710178902; x=1710783702;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TRcl63k4Enolg0XIOUbcFz2ceM8wzscJs4qT96hKv3M=;
 b=LNaIDoPoR7JwxQqmw893MbVjKvXw+4MD9jiAo7hEk1xPmUI18R+gZaz6MMt7KSjRjc
 KBniZBXBvbf5/3ywC+SUoWR9jGQxfx1kuAhFsO36kRPKu5A9wQl3jE/kOUvL8KezgETv
 yl5Un1jVPb/Tk0gMl1fCkJgqgqN6GynmPTfdyUffYS4Syfh+jeWGO18fxfJIHMbt2vKF
 Kt+//kGFHjkUtDbc/av3kIxSsbIXpY9Vgr9fXigERayb8AUvGgEnNQHtyzLuPw6bFWTL
 VpAPQ7+moJ3EKHaSt0ed1teyVz5cwq8SJpbXuCtkqBX5orX3yu02iILLNLHUtE6WiERx
 EmAw==
X-Gm-Message-State: AOJu0Yxv4/iEt2lpOuQj9qXIvyimpiS5edsC5efbgXlkx4kaBp5nPvEJ
 2TA/tUEOF0cQomYeJYwlqBWONElJhI2pPWtwT2gDOaSOK7HGxhhXxSCLl18E+dw=
X-Google-Smtp-Source: AGHT+IHwg71O/unBd/fPFI8XRs5TXQrJKcPahM8orTDTp4kUgbr5FfeBfckNcFfpp0nJYyeiKBuCbg==
X-Received: by 2002:a05:6a00:27a0:b0:6e5:dff8:6e5f with SMTP id
 bd32-20020a056a0027a000b006e5dff86e5fmr7645519pfb.34.1710178901589; 
 Mon, 11 Mar 2024 10:41:41 -0700 (PDT)
Received: from wheely.local0.net ([118.208.155.46])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a62d412000000b006e67b4d7b74sm4593187pfh.197.2024.03.11.10.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 10:41:41 -0700 (PDT)
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
Subject: [PATCH v4 12/24] savevm: Fix load_snapshot error path crash
Date: Tue, 12 Mar 2024 03:40:14 +1000
Message-ID: <20240311174026.2177152-13-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240311174026.2177152-1-npiggin@gmail.com>
References: <20240311174026.2177152-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index dc1fb9c0d3..fee9318c06 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -3259,6 +3259,7 @@ bool load_snapshot(const char *name, const char *vmstate,
     /* Don't even try to load empty VM states */
     ret = bdrv_snapshot_find(bs_vm_state, &sn, name);
     if (ret < 0) {
+        error_setg(errp, "Snapshot can not be found");
         return false;
     } else if (sn.vm_state_size == 0) {
         error_setg(errp, "This is a disk-only snapshot. Revert to it "
-- 
2.42.0


