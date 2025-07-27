Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD25C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwpO-0002iA-KF; Sun, 27 Jul 2025 04:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwod-0001Tt-Q4
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:08 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwoc-0000CX-9q
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:07 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6148e399effso5756528a12.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605185; x=1754209985; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XrjnOg4Zy/ZXUzrZG6k/71L6/AzH7nZt/YAib9zjkv8=;
 b=qXVvcNjERc3VA5cgK6TMS6mE7yRdgUVrSIDTi68IQG4Kgv02zOMZBidlbZ1JxjtMrw
 eIkERhx7LbFBFX7nkRBN1EEeiyg/eswSyruzPdNt3TfXqTA8mUZ8wLPkVKWP8iZG/riJ
 Izjxh3fFJCVm1Hlr4bsTrH+89MwSR5rvvgLQsmsdh8pSBDC1l6t5ycYv9fXCa+NUshB+
 JlALGpathFAQiPZ58eiYxn6ZKM9jPRyOkv++qBZo8QzTw8ewh+aMS1aMbhhHpvpHoBsZ
 aK78JEvbhXMxIifqNDdvvGVUkguCGFhy6M/XjY9G8CnK/DRaacWeSo8TpeHSnMy/wK6s
 pG2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605185; x=1754209985;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XrjnOg4Zy/ZXUzrZG6k/71L6/AzH7nZt/YAib9zjkv8=;
 b=J43bu+wu+qhqRsdGW1fb2zfi5WdNvR3ipkuMtwgM+1HF+evf8of47zJOGBVH0KbhND
 Rgrle2NYVib5cozdfngICQSOxBjpH0MFuVyCpL2B8g6fQft/dKeU/U/MGpa/GVH9dZQo
 6316i6piTd2l4d/bVINF19JQrQLl8628rJlUF9V1Rtn1R2IJEF2shJEAojEaGTCtklRr
 r+USjFhw3fq4vuD3BJFkuaz3tdvRlomYl+Nn8FFbFRq7Y7BeeyXTb7cev57cfKPgZ4Hx
 5hEseroIlXLTIwHb+vnUmYmglJOHOyDvHXW+yZ7dLEkXxJwUNUHg+s3N8IQbzseg0rkY
 JBBA==
X-Gm-Message-State: AOJu0Yy9zHowvj7js578vOXg00JQRB//arHLu1JZ6WKKbt6R7L1n5Zgz
 nHvN/uBFbDBNjWKVLunE5B5rGqzgjumxtdsZAQhzQMjGC+XXLtln6fkW7TozxCIea8E=
X-Gm-Gg: ASbGncsLpv939FgLGYbZzqVvRr1qJE+vJaeuwN7jiQd8Z/1QIuIOhzDHB0cViusSghC
 nHhCuEqT/0zyiWtnejQHXPfnLn0slFZgJQdWSi/gtzSPUkhwRdeskFYiEBkGrc4MLmSdrXZ1lWs
 +8sdl8qqqZgsyKgTDjl7dYjPA2pkDwys680kK6aTLQ0m9FxT1+4aFLaebY4sk8QHEm9hRsUnc1s
 Z+pMOUCO1GHQ0Ka1+reIr8TNF1JXfidz9DOUt6/OL02HHKLSwjWEx9rOmsSSbTQK/cbCBxiQ9qz
 G5rJRepAHXuqq1KVeN6kJ/bCo5mLZrlfr+tWqsjwVJNQ8WbL8Nop/ZW2V8bjqRIy0ZJ86iD3GGE
 woqJl4oe2zoDgdYJZ2u4RQmI=
X-Google-Smtp-Source: AGHT+IGZ6hJ+kuQTM0zb7kZ9imp9Oqq82C4/7DGrajzU6tmXF3OK22BXdMz92y8H3EgtBPdl3zu7dg==
X-Received: by 2002:a05:6402:5107:b0:607:425c:3c23 with SMTP id
 4fb4d7f45d1cf-614f1bd63b3mr7385460a12.5.1753605184848; 
 Sun, 27 Jul 2025 01:33:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500aef3bdsm1925117a12.68.2025.07.27.01.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:33:02 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 023825F8ED;
 Sun, 27 Jul 2025 09:32:55 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 10/14] configure: expose PYTHON to test/tcg/config-host.mak
Date: Sun, 27 Jul 2025 09:32:49 +0100
Message-ID: <20250727083254.3826585-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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

This will be useful for making $shell calls to something more flexible
than the shell builtins.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-11-alex.bennee@linaro.org>

diff --git a/configure b/configure
index 95f67c1a827..825057ebf15 100755
--- a/configure
+++ b/configure
@@ -1800,6 +1800,7 @@ echo "SRC_PATH=$source_path" >> tests/tcg/$config_host_mak
 if test "$plugins" = "yes" ; then
     echo "CONFIG_PLUGIN=y" >> tests/tcg/$config_host_mak
 fi
+echo "PYTHON=$python" >> tests/tcg/$config_host_mak
 
 tcg_tests_targets=
 for target in $target_list; do
-- 
2.47.2


