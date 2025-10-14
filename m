Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05126CCD194
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 17:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8ikc-00019e-Bq; Tue, 14 Oct 2025 13:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8ikY-00018F-Ga
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:23:50 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8ikT-0008CG-EB
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 13:23:50 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-781ea2cee3fso5393703b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760462623; x=1761067423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=niR71WY8+70F5DTcAjNAlB+900kgRK4/ItkjLbV5EFI=;
 b=erbrFnPTDZxOYnxBR4CpOvxeUCe1nGMhdjGiXdUP+FehPNHtoyN3GU0WZ0NWPsSJCW
 6+qmJqpm9L6FAx1Dm5yKqW5cS4wv5PvjtK496ObdI7UF/j+woIaJ318t93ikU2nG6jXd
 lFlcyRnu0gvLUpdagv2iEJCFPw+2CILgoFA7P7WmdC54foHPaNGOHkJRLFnIK/fUM4Sr
 d9yGTVoe43JuFhOnUE+ti4fn/OpMJaVJDX4+gM9i2ijS8lWakvspw0ULQcXxY7lhQAmI
 TAc2S89AZE5yHDSkvvrcIkKNSnEcMSO37rhP6AA1xh7eNfnXckA5/dRBtSWaruKDRWrA
 jH0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760462623; x=1761067423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=niR71WY8+70F5DTcAjNAlB+900kgRK4/ItkjLbV5EFI=;
 b=MzX/uOF1bIfUFjnP9SswETtWjSd3PuTq8dEmwWa63klKA+Sex0T52ihr7k4ZtFAK0C
 e4XGpaBDW4pKc8MKagGjsbgicWjgDHDLQnYqMPJNNLxjY4YnVSaBhLgrYwcR72PSCqtW
 iA6GxljW9fou+jCJE9cBAJTMpeuu1wM/NIMuPgatn/C84yRJUUP2FfxFT/kvzhS5K4IS
 WN1JhsIU4iFR8aHITL9CNWtT34ItdygYVDKxSyB4Ls1hhQNd+7ly735c6oB0V/7zA932
 iw7WghtLtYt/5Y4ZaSIRLhrN9bDblydafSJ1Kw5/5YynvGGXXgGIvK36FOwnYkUh4Yb3
 B3tQ==
X-Gm-Message-State: AOJu0YyljKezIv4m6Vp3eIT6KQA8XaxNqOzZOO65M6Wl3bl2hJPRKO/F
 1jVN4J1pdTIMyTP9Z5x18F4H1sJsMIAcQTN0E/KB1Tk/DsqBsJjQ/NuYphzsPOxNBmsnD+cwj8g
 Xj446psU=
X-Gm-Gg: ASbGncsD10MAl8bYrVBNnTJ+zzKZsQlztzj+djxkUNPpQ+ZoN4SjVaYjVNuBZ0M7phm
 sP3S8QNMVcVhzH6VvAMi2blM4yBwbBzQsopnDNkxdIf0S0lra82Uy2VpLds0KkP6vQw5foS12jP
 6yRmP4WLHyXgdCDnMWZuS1cUHJHuNaPtUx2w1upuZSZSbMzT5fyS6bKPUzarJoY3UuQjnNGIQRh
 yYpGxQnJKd0KqK9jvSg05k/1BzkljT8k0AwMk2MSgcm3gFxiLrqMmj6JElFET6FsoLMX7MP4UFi
 uERBNJOoZLkLd09AAz9XI7Tqn5jXB3r+1EZC1LJez2LZB8gddX59418ecC8k3oyxkXn6PQEtKd4
 1X1AnfWxFv7hReoSf2TBkiK4DXe4wAu7bleVp9XXDtNZi9XinEig=
X-Google-Smtp-Source: AGHT+IFfxfS6RH2o49k/eMS++jDvaC02A7y82sUzKJdq8v/rDZWrcO2BH8SzUKbDiH9IvjJ3sRzUtw==
X-Received: by 2002:a05:6a00:9a1:b0:781:2ba:ef14 with SMTP id
 d2e1a72fcca58-79387637461mr28004389b3a.25.1760462622768; 
 Tue, 14 Oct 2025 10:23:42 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992bb116basm15741913b3a.30.2025.10.14.10.23.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 10:23:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] tcg/linux-user patch queue
Date: Tue, 14 Oct 2025 10:23:38 -0700
Message-ID: <20251014172341.243858-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

The following changes since commit f3f2ad119347e8c086b72282febcaac5d731b343:

  Merge tag 'pull-target-arm-20251010' of https://gitlab.com/pm215/qemu into staging (2025-10-10 08:26:09 -0700)

are available in the Git repository at:

  https://gitlab.com/rth7680/qemu.git tags/pull-tcg-20251014

for you to fetch changes up to ec03dd9723781c7e9d4b4f70c7f54d12da9459d5:

  accel/tcg: Hoist first page lookup above pointer_wrap (2025-10-14 07:33:21 -0700)

----------------------------------------------------------------
linux-user: Support MADV_DONTDUMP, MADV_DODUMP
accel/tcg: Hoist first page lookup above pointer_wrap

----------------------------------------------------------------
Jon Wilson (1):
      linux-user: Support MADV_DONTDUMP, MADV_DODUMP

Richard Henderson (2):
      accel/tcg: Add clear_flags argument to page_set_flags
      accel/tcg: Hoist first page lookup above pointer_wrap

 bsd-user/bsd-mem.h             |   7 +--
 include/exec/page-protection.h |  21 ++++----
 include/user/page-protection.h |   9 +++-
 target/arm/cpu.h               |   1 -
 accel/tcg/cputlb.c             |  23 +++++----
 accel/tcg/user-exec.c          | 114 +++++++++++------------------------------
 bsd-user/mmap.c                |   6 +--
 linux-user/arm/elfload.c       |   2 +-
 linux-user/elfload.c           |   4 +-
 linux-user/hppa/elfload.c      |   2 +-
 linux-user/mmap.c              |  38 +++++++++-----
 linux-user/x86_64/elfload.c    |   2 +-
 12 files changed, 98 insertions(+), 131 deletions(-)

