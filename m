Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8963FC02188
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 00:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcZh3-0008N9-3h; Mon, 27 Jan 2025 19:43:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcZh0-0008Lm-G1
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 19:43:02 -0500
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcZgy-0003Tq-Na
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 19:43:02 -0500
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so9500458a91.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 16:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738024978; x=1738629778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9K0gzoVmD8GMKzwq0FIbI66sQB1frBuqpa3K1kcWYM8=;
 b=z7NA+w4i23cgXgWSGUN2wqxk7iLNGhqxnp7S2ZXLiXPRg1/RwNN9HnVzloxYzKQpl1
 L1rUtIhinUqPrUvP2YnUYKm3ZTNDR2Q8FzZHrsnR8DKr+Xr7bYS5NQwMZtXQQlnYjUnV
 O0itCgsdf8YWZo/A4yc95UA3J9osIO4vSXv/NEnSKK1QOpdqH/BR+Yanf/dwrU+DJui8
 LtkO0t7ZGzhno8JU1apF4DjKOeaIQrMWA7eVr1wwKA/f98MfWfvqknI6cOPxPzaGdEkC
 ukwE5WWa+s7DJzx4M+kTotdAB8VYU0MIVDMTZpnZ0xr8trvm5RLcB4AJbGZ1P+hxJUxn
 QvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738024978; x=1738629778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9K0gzoVmD8GMKzwq0FIbI66sQB1frBuqpa3K1kcWYM8=;
 b=fViNqyjdfckdBf0u5hHt7ByGGbmmu73fd8xtda+MkUxZUHNJPB/u5J2/z2jtK6dZ55
 JZF1k90a/m49A3fUU1bFNAmZfrWKK7HzA2AWHO9Okl3DfYl2sf7MTGGOs//pGlZou+Ng
 pUI8cVFMCAh2lM5DYquhvfM/eycsWPTJuETe6NB1GS3SajdTeSOTxy+TXI9iJmP1ex00
 IHtTPhibB/a03YTScakon97zb1AjQ+YPgcDxm34+WolddBcSULeGWJ1JZRvgMgyU3o+Y
 0VA9zVorHSmyD1Y1HlTW7EUOcKpLMh/J1x4+WZJuCtRlic3W7ZkNdyd0O3RCLN3fYD74
 1DnQ==
X-Gm-Message-State: AOJu0YyfnZbD+2bi3twWI1G8h9oOMlkr6zLbscrDojkydb9mgK+IoGnn
 Fvhg0qPHQzJQTmHZISk1bhBILNrkjRpRuAxwuPTcTLZE608BhNGuCCHqA1dVz4t8ENASu2E45JC
 5
X-Gm-Gg: ASbGncu5yOAqRYffVZglEeJHl5IKx8fRK50bYdpx/3ibFqj+VbF9VYF4X8d2gacELU/
 1Wot4ESHsGyaJTnIams54eqLw8PuKQ/S0EU4dVyLbD5dGB29YQkFgv6nKOCGIIWT1hiuWvSVeu0
 DhyHM7rpmSlUT/CpVRdZXYvuD8ZKOkATKrOzHMvhzailkETbmGpB9FFyYkfAs1qBZJWrXkgX563
 MTATcKHB3VIKjVtdEHj3TCCiAKd987ESsEsNetegd7C2DLggi9uAlWMpLhY72E0yRCV6DJBEqBC
 66aKjT5ecaKvMZuPu1PTdhytsGG2f2DkF+2lkRU=
X-Google-Smtp-Source: AGHT+IGX66kXlWCLsXjLpckkOk7s9aDkHq4k02dGPzAcPDTdc7sUDg41jEfHU7c/mVp4w1mlmOrzfg==
X-Received: by 2002:a05:6a00:2188:b0:728:f21b:ce4c with SMTP id
 d2e1a72fcca58-72fc08fa5c8mr2159107b3a.5.1738024978084; 
 Mon, 27 Jan 2025 16:42:58 -0800 (PST)
Received: from stoup.. (174-21-71-127.tukw.qwest.net. [174.21.71.127])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72f8a78e0f9sm7791026b3a.158.2025.01.27.16.42.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 16:42:57 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, peter.maydell@linaro.org, stefanha@redhat.com,
 pbonzini@redhat.com, berrange@redhat.com, philmd@linaro.org,
 mark.cave-ayland@ilande.co.uk, alex.bennee@linaro.org
Subject: [PATCH 1/1] meson: Deprecate 32-bit host support
Date: Mon, 27 Jan 2025 16:42:54 -0800
Message-ID: <20250128004254.33442-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250128004254.33442-1-richard.henderson@linaro.org>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

We deprecated i686 system mode support for qemu 8.0.
However, to make real cleanups to TCG we need to remove
all 32-bit hosts.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 docs/about/deprecated.rst | 8 ++++++++
 meson.build               | 6 ++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 4a3c302962..a200f4fd28 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -204,6 +204,14 @@ is going to be so much slower it wouldn't make sense for any serious
 instrumentation. Due to implementation differences there will also be
 anomalies in things like memory instrumentation.
 
+32-bit host operating systems (since 10.0)
+''''''''''''''''''''''''''''''''''''''''''
+
+Keeping the 32-bit support alive is a substantial burden for the QEMU
+project. Thus QEMU will soon drop the support for 32-bit host systems.
+Recent testing on 32-bit host OS has been inadequate at best, apparently
+due to lack of interest and usage on such hosts.
+
 System emulator CPUs
 --------------------
 
diff --git a/meson.build b/meson.build
index 15a066043b..0bf5c93777 100644
--- a/meson.build
+++ b/meson.build
@@ -4834,14 +4834,12 @@ if host_arch == 'unknown'
     message('configure has succeeded and you can continue to build, but')
     message('QEMU will use a slow interpreter to emulate the target CPU.')
   endif
-elif host_arch == 'mips'
+elif cc.sizeof('void *') < 8
   message()
   warning('DEPRECATED HOST CPU')
   message()
   message('Support for CPU host architecture ' + cpu + ' is going to be')
-  message('dropped as soon as the QEMU project stops supporting Debian 12')
-  message('("Bookworm"). Going forward, the QEMU project will not guarantee')
-  message('that QEMU will compile or work on this host CPU.')
+  message('dropped in a future QEMU release.')
 endif
 
 if not supported_oses.contains(host_os)
-- 
2.43.0


