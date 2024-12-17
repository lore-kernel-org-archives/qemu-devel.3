Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECEDE7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 01:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNM3Z-0008Fp-BJ; Mon, 16 Dec 2024 20:07:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3W-0008EB-4f
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:22 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tNM3U-0004wi-7i
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 20:07:21 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2166651f752so50049345ad.3
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 17:07:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734397638; x=1735002438; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oad9B0AQNcIsrUgWQ2hwmUjwMCOEE19BjdFvmSTNXFQ=;
 b=ozbpYbnlWYAufOXGPsbpL6CPQ1HK3BJxRr88LMlNCRuL5gYRCpx5gqY+bq562o7QjE
 mUTUpo8sMxNGZsLWP522gy8M7R5+wS/OGddgyfCE/E7KE8Z0D295Mr831TwuxRCavSbj
 LYjDves5Tl44FvmSxLJxaVGGnaFV/vTPWmMA2JHbeGJpMgLh0NcNjsF2YahDjt5uipHn
 Q6wquSnac+RJdmy4lQRyagcJcmoyAmLoy//lPWGpCCUJQ3OkgHzj5So87IRYeGOGJtfT
 zDvqWypfWEXhrOsnG2uZHIejYBNusVtPPUPUJQXx0c4yh7WtihtMdxMZXgd5uTAGE/Vr
 MU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734397638; x=1735002438;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oad9B0AQNcIsrUgWQ2hwmUjwMCOEE19BjdFvmSTNXFQ=;
 b=T/6CFVgBkfWQA5WT+fVCCph0ZR9/MrlEIHCkONozerYqGIGQKZEbJFPnBwifFc76h0
 pu5BlXBb0X/bKIcqRZ6ix2lwW4ZHDdlBYxXlSOfhSO7QBx4x6NhsmfWU6C6ABgNm/fan
 znKzdhsjSzodOXLgDmrhqQSr5ua5XDUajug9JrEJP/fViq6OM8RYx/hFhAzrtAuUIaXx
 vflIXXicXMm1wuENGQn6awUd6+pUQNw4BHq3cW6qn1i/6tbfufhmiMId2YKO+m1HmB7B
 lGcT9h02aHUYO6QO2a0Ab1rd/fcWiJBVzX+TxNROdeWJd5Zkkc6ylBBOS6mcgK8eeYgX
 8K5Q==
X-Gm-Message-State: AOJu0YzwL/P3bOG4uGO/BOfS12n2aizlTU2ycTht8C+9CfHuydZ+b/55
 YZ0xAuseQFzOzbM6P8fieT25alJoHvDKFWZgPMXgA0aK7O7LKTHG9M4pF5IcpJKuE2LDjnG0Riz
 Zl14=
X-Gm-Gg: ASbGncvyaGG9HSc9q5/OSuVIpExNisApzhh+tvMkaLqRV42i6UstHDQnFCC44mrjI/A
 vrbkpk5p+JU6voFwGUPLX4Fx82KrhDtjtaFTxSOkygd9fc0awgLX3exK1O6kKE0oH41Ql0IP4Nh
 u4y9T4GDI3LR9bn1xiDdIpGUDwsKuBao/GZ3NQbbPT+rVhHe0/KO6DZnD1jXPfdDGJf6wYEDPKB
 QxT2UWwk4RZe1LvHeXsEHtkYBL0qvRKlRwrCC1IbWbFQgv8RMrUbeJdTAtUUPp+liJ15P1IuBPe
 tBrmHugUk6HbAJ4=
X-Google-Smtp-Source: AGHT+IEq71n6wHkJ5WSqHQNcUNwu8NvVUYN4mp5W+yXlGUYcsw0yMGmYRB9nDrLkSehQfa7/oOEDOg==
X-Received: by 2002:a17:902:ea0b:b0:215:5625:885b with SMTP id
 d9443c01a7336-21892a7a858mr213452265ad.52.1734397638124; 
 Mon, 16 Dec 2024 17:07:18 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-218a1e6d0e4sm48746595ad.261.2024.12.16.17.07.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2024 17:07:17 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 philmd@linaro.org
Subject: [PATCH 00/13] Fix 32-bit build for plugins
Date: Mon, 16 Dec 2024 17:06:54 -0800
Message-Id: <20241217010707.2557258-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62e.google.com
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

Since 9.2.0 release, we are building contrib plugins using the QEMU build system
(before, it was external makefiles). When building for 32-bit host platform,
some warnings are triggered and build fail.

Thus, at the time, the decision was to not fix those plugins, and
disable by default plugins for 32-bit host platforms (see cf2a78cb).

This series fix plugins to have the same behaviour on 32-bit and 64-bit
platform, and reenable plugins for 32-bit platforms.

There are two portability issues:
- we use hash tables, and use data as key directly. As key has a pointer size,
  it limits its size for 32-bit platform.
  The fix is to use pointer as a key, and point to allocated 64-bit data. The
  change is pretty straightforward for concerned plugins, and does not imply a
  memory overhead, as hash table entry is already heap allocated usually.
- we use plugins callback data to pass a pc. This does not work on 32-bit
  platform, as we are limited to a pointer size.
  To avoid doing memory allocations, we simply we simply use
  inline operations and a scoreboard to achieve the same result.

Tested (for every plugin modified) on i686 and x86_64.
The behaviour before and after this series was checked as well, and there is no
difference, apart from bug fixing (some pc were clipped at 32-bit values, even
on the 64-bit platform).

Pierrick Bouvier (13):
  plugins: change signature of qemu_plugin_insn_haddr
  plugins: bump API version
  tests/tcg/plugins/insn: remove unused callback parameter
  contrib/plugins/howvec: ensure we don't regress if this plugin is
    extended
  tests/tcg/plugins/syscall: fix 32-bit build
  tests/tcg/plugins/mem: fix 32-bit build
  contrib/plugins/stoptrigger: fix 32-bit build
  contrib/plugins/cache: fix 32-bit build
  contrib/plugins/hotblocks: fix 32-bit build
  contrib/plugins/cflow: fix 32-bit build
  contrib/plugins/hwprofile: fix 32-bit build
  contrib/plugins/hotpages: fix 32-bit build
  configure: reenable plugins by default for 32-bit hosts

 configure                     | 21 +--------------
 include/qemu/qemu-plugin.h    |  8 ++++--
 plugins/plugin.h              |  2 +-
 contrib/plugins/cache.c       | 18 +++++--------
 contrib/plugins/cflow.c       | 17 ++++++++-----
 contrib/plugins/hotblocks.c   |  8 +++---
 contrib/plugins/hotpages.c    |  6 ++---
 contrib/plugins/howvec.c      |  7 ++---
 contrib/plugins/hwprofile.c   | 27 ++++++++++++--------
 contrib/plugins/stoptrigger.c | 48 ++++++++++++++++++++---------------
 plugins/api.c                 | 12 ++++-----
 tests/tcg/plugins/insn.c      |  4 +--
 tests/tcg/plugins/mem.c       |  6 ++---
 tests/tcg/plugins/syscall.c   |  6 ++---
 14 files changed, 93 insertions(+), 97 deletions(-)

-- 
2.39.5


