Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73690C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 14:46:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubgtx-00065S-8J; Tue, 15 Jul 2025 10:45:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDJ-0008RX-Tl
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:01:17 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubgDH-00043P-0K
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:00:57 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-451dbe494d6so50537205e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752588051; x=1753192851; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=lpeMA05+hnxgLquvU/VABcfSIf5tYrmj6GLbqyHOeWY=;
 b=i2pZFsy7jW6Oxf7iBFz1wp0N04xb2kQPzdJi+nyKwJNsJhWVmtB+qEldWG3w6704aI
 esPvDSgnpc8919Ihk6zqlnJ6tLryNXevYL9i9J4CJWkODjdazDTTr5yQhiy1CyjufXa/
 w1cViQ7UDx8x6ZcsfyRf0dOUSD5MEAzfcjVBF1Py9/jG3XsiluVdxiiP0wEF/lWIQl1u
 LQxCz4TxZkApoZaWnXK56OSGdDEnNvMpS86rxjk2EqyEzqvOBu0+iCXV+cC8PU/tYny3
 SLXv5GPoEwgdKf0oI6l66ieYl+1tvVX3wIeKoI1PSCEtgdZGApEj2fMtdwanSotVVx5E
 3aIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752588051; x=1753192851;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lpeMA05+hnxgLquvU/VABcfSIf5tYrmj6GLbqyHOeWY=;
 b=b1CRbcuHpnopM5MMh3u9vrSgwilLgaNB0/yptLviDkv8D249yh9A+waMO6N/DSx4cF
 VFtlnKB74O6TO/MYTCAzcLg4qTTQR01uZD+zTz32lVPvSXO2IfIS3rXV0peSLnyohpO7
 iNN87lq8O8CdX3BwOVbcyIXf3qjeD22FWh/S5dUfXAH6swOmbYrkmqiG0nTtzzqLYyiP
 tQcGpbvDZW+TJbqsn+E3Y4Vd80lrv2zRrkMk1NuPApZPy0jxOjhlbfVcfsNyPQZLoa/+
 bUy9wPs/9IDmEugW83p6bsT24Sr/a+BSA+oQ84jGIpoDoHNyG+67tcCyYsu4LL6mbJX/
 qNWw==
X-Gm-Message-State: AOJu0YwY1+MDtu/rVrzOzDA/ykuHcBHe3SybUiAfQxQSDPLRrelWFaH+
 uKCtLaQ2bhNOKkLEEW6AMaBJfi5qgNvK2XkANFDB2UZKNuClgFTFxJe1TknxwvObbSiJvZ0uniO
 wYhpu
X-Gm-Gg: ASbGncsjcVwXnzDUftd1S7xfuVzc2uJcxeXPGpStgmJ1/Z5KVjxf2E8iwccln0UN29u
 fYPsr+KpPpKOAAYBz8+RO4HzYEez/uzjeWj0tuMPjV3sFOy9uA9T3UC/FofP03zNlNAV3NSmASg
 5gQ/31283ysFE1c1MwduiHlOWeKIV7fxp2FMa8m25T01up/N3bRNUlWVWitNGxIYujdGXXdrUur
 25eepTkN6SeBYYdTSBQcgNApURZUrXqmvKNfDde7QCmmhX5M0TCD5je98iULEG3ASUr2MCFLclB
 dMTB93NmICGboVblmxsfexytpCbNJ5Xp54oQ1udf7ee6yvqPW2tytC762/BlxEhX0We+PwkR5nO
 y3tSu4ZOLgr3etFFIeGRaA/f9YJXKCYfOlbmejYKu2Jk75sGkbqvlPnNESrIIVCXHCAst8+dk2/
 SoNA==
X-Google-Smtp-Source: AGHT+IGNSgdL3Qy8ek+PBsheuQ40VI8b8ZKZwapAOwngaQYRJejVuS2dE5XjYvKTfNAH4vleagfVZA==
X-Received: by 2002:a05:600c:3155:b0:454:ab87:a0a0 with SMTP id
 5b1f17b1804b1-454f4257f20mr180980575e9.17.1752588051029; 
 Tue, 15 Jul 2025 07:00:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4560be645a9sm101833935e9.40.2025.07.15.07.00.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Jul 2025 07:00:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Eric Blake <eblake@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH-for-10.1 v6 0/8] accel/system: Add 'info accel' on human
 monitor
Date: Tue, 15 Jul 2025 16:00:40 +0200
Message-ID: <20250715140048.84942-1-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

Since v5:
- Addressed rth review comments
- Added R-b tags

Philippe Mathieu-Daudé (8):
  Revert "accel/tcg: Unregister the RCU before exiting RR thread"
  accel/tcg: Extract statistic related code to tcg-stats.c
  accel/system: Introduce @x-accel-stats QMP command
  accel/system: Add 'info accel' on human monitor
  accel/tcg: Propagate AccelState to dump_accel_info()
  accel/tcg: Implement AccelClass::get_stats() handler
  accel/hvf: Implement AccelClass::get_vcpu_stats()
  [NOTFORMERGE] linux-user: Dump TCG stats to logfile

 qapi/accelerator.json         |  17 +++
 accel/tcg/internal-common.h   |   2 +-
 include/accel/accel-cpu-ops.h |   3 +
 include/accel/accel-ops.h     |   2 +
 include/tcg/tcg.h             |   2 +
 accel/accel-qmp.c             |  35 ++++++
 accel/accel-system.c          |   9 ++
 accel/hvf/hvf-accel-ops.c     |  24 ++++
 accel/tcg/monitor.c           | 200 -------------------------------
 accel/tcg/tcg-accel-ops-rr.c  |   2 -
 accel/tcg/tcg-all.c           |   1 +
 accel/tcg/tcg-stats.c         | 219 ++++++++++++++++++++++++++++++++++
 linux-user/exit.c             |   6 +
 accel/meson.build             |   2 +-
 accel/tcg/meson.build         |   1 +
 hmp-commands-info.hx          |  12 ++
 16 files changed, 333 insertions(+), 204 deletions(-)
 create mode 100644 accel/accel-qmp.c
 create mode 100644 accel/tcg/tcg-stats.c

-- 
2.49.0


