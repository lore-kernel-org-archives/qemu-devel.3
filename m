Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D428C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:23:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZhQ-00013p-0x; Tue, 02 Jul 2024 05:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhK-000138-Dz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:14 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhH-0006MT-P3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:13 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4256eec963eso27749145e9.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912060; x=1720516860; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cnrpgaba+viPx04OXDYFrUGjYb7FyAmcjVlf/y5TLg0=;
 b=Se7sgW/8/xFjnSfrFqKP66hNIrboEBT3Icew00IcMVU5iBcOw88GMBNG+SpGS8a21c
 MvrWJjdrW3jljhGWvcSgIneLaj4gjlNWH+UBtTp+j9cff+UrNsCA/9eKXUtCPjq+OIzr
 LgkdFXKld/9WH/U1p5hDT5x74K7+pgTyB/zKrJc0aCqtqQQbWrKsz0Ra1obnUZLCFZzm
 NWNKPSSv3BWXWPRLbDtOkfRmI/6jraxXd93DD7ZYW1LsCVu8EEMIBE6fRBlnMHLB9gCV
 SwWFukWD7m45N8FCul2bXcoN0elWGpeHL1+jOoYKd1Q0x29dWJqWRdh5H/HoL98vW30B
 N7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912060; x=1720516860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cnrpgaba+viPx04OXDYFrUGjYb7FyAmcjVlf/y5TLg0=;
 b=llogNf55xGtUxxwzy3I+x1zF4kpo/GZT3ePHVwyt9LTCE3P3q3gexesG996OYy3iLE
 +nMyfaLPId1ZxHUcYvmn+6A0lkMh4NAuEhCHVoFaVmM6Ld2f0w8FOlxVPUSw04AztoDj
 8LasGUvb1gWFy5yXzkL6nbLXcnVweDsU8g64Ruzzb0sHglDQTCZ2+1Qpl4DQk0wH4wdI
 uD35phVoIRpPOOZyNhMdP2k0T46dhwMkXJZwsuKn5umjHeVY9NoGJ8BrX72kcsjzhisz
 9olCelZMgJGCfJQxtzSF5oUghOCnV/ukl7GDRm0JLyegn4G4kiC9W/jurx52mtovTigw
 By0g==
X-Gm-Message-State: AOJu0Yxts+EWZqYeh1y6Xzvn0SLFigDi5i9ErlgIZ/lXhjFiGMj/oMZd
 GOtDmq9XgCDtqPH6pBu/u3C2S7SpwXbae0T/U+EV+Ujs4EAqH8Nz8HQU8h3gXUbM6VHlc3WXXQw
 C
X-Google-Smtp-Source: AGHT+IHPxlhz7r6hSMhYoxgitvfI9+nOoTze2Jc1cL/pyPJoZZ/vEextPI7QLr68ZFhmtJHj4d4pmQ==
X-Received: by 2002:a05:600c:3501:b0:424:a3d7:2a89 with SMTP id
 5b1f17b1804b1-4257a02c817mr49545515e9.4.1719912060238; 
 Tue, 02 Jul 2024 02:21:00 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af5b91bsm190794595e9.20.2024.07.02.02.20.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:20:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 01/67] hw/sd/sdcard: Deprecate support for spec v1.10
Date: Tue,  2 Jul 2024 11:19:44 +0200
Message-ID: <20240702092051.45754-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

We use the v2.00 spec by default since commit 2f0939c234
("sdcard: Add a 'spec_version' property, default to Spec v2.00").
Time to deprecate the v1.10 which doesn't bring much, and
is not tested.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Tested-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240627071040.36190-2-philmd@linaro.org>
---
 docs/about/deprecated.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index ff3da68208..02cdef14aa 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -362,6 +362,12 @@ recommending to switch to their stable counterparts:
 - "Zve64f" should be replaced with "zve64f"
 - "Zve64d" should be replaced with "zve64d"
 
+``-device sd-card,spec_version=1`` (since 9.1)
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+SD physical layer specification v2.00 supersedes the v1.10 one.
+v2.00 is the default since QEMU 3.0.0.
+
 Block device options
 ''''''''''''''''''''
 
-- 
2.41.0


