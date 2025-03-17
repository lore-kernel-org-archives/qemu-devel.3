Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BBFC282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 05:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu2ps-0004Qd-NH; Mon, 17 Mar 2025 01:16:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tu2pn-0004QB-0U
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 01:16:19 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tu2pl-0007Fu-AM
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 01:16:18 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2239c066347so77643025ad.2
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 22:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742188574; x=1742793374; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DQKKnksmF4AroNDN2YPpYbk6Vs+1cZAjQbehWvFHz5M=;
 b=fbP8+HatFFy95qwqnbFqX6AMBPdNa2f4LLrD1OtG4RYh0JjpGTE0fBZGftjQvTkz6r
 7eLIm7OKN/GJ8UtjNkXD8X0N40tr2ClzDYlR79i09vyQfMlie0pO5B4uuRVzYaAVIc9C
 jSHS4PwvlXqf8axAYhRQ84N81L7SydqIpdmTG629Y4bY0Pv/ccG8i88xE60tyyOONf+S
 CLsN9qifB/O/7tJWZhI04JewhhRfYDSsumNHbmHEh+Xm27xpU/kTI9304/7D4+IgvF6Z
 rB2JCeloDooFI/VSL8QDknzfVMhfBmRnenttUk8TTDHz6ZhPiUw6KNCsoV7tX4Uw43cT
 8ymQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742188574; x=1742793374;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DQKKnksmF4AroNDN2YPpYbk6Vs+1cZAjQbehWvFHz5M=;
 b=JpplTtInHgmn272/BEkL2jmt1/NphQ9sJtFaJ6A6PRe4zhHmOXVutLDqBQtScNp1mY
 D5Whcmflgny79Zpw3aYqAh2Ixr47tt7NMhLnCQTk+bqNW6Yw5p4BNplDq/v9mCfDtIDH
 WkmTfxbwdtmi2cR5ilr+xsxdhGkH5x2HrfI7pE4CyqA4XeWc2Ob/rzqMDd8Mu08PFh9Q
 H3WtfSgptfOA5YDuj8dO/a1jP3QNliQawqkGvM60XBRlYZlE7ufL3+ZU2G6O5DEO3w2S
 NKJEUCcVte+3fqRuvliZkmj5elSjGskjIpadRqYzdssGkA9GnhMnAgnQPVz/rpWRpoPE
 10nQ==
X-Gm-Message-State: AOJu0YyOUkCzIieySr6kLtw/mGAA/xWArZ7F5FF+2H4aVizPcGmoc3Rk
 O8hAoB2YSCMol8TcwwJWIS05u431a7CY8c1WtZcv717BIGoGwkZgwN/o4g==
X-Gm-Gg: ASbGncuBAUdLVVA0LROT2ZqsJAHsmnbeOnf4W0oxx4kEfuAeT0rFdKNvo6dbKyFB5Ll
 f1FXxmJjUJWD4yQMk5DfCpC5Ea310uQRhf8MbabN5UzB/sj7tIejMCvWO/BABpsR/ceNmLKNOOL
 nOKPgxNtU8zVS2AOu4pwi0tIjYsz2nNzm51KbApYAAsT5BrEbU5KYEod5RBOb/mzqhRnEPVrevp
 DcR/Os4hzCETqU9peU3So3hGAMEYULWg9A/lnlwjcszoTb6z2StvcOmGf1tYJSp9LB8EDjxY796
 tYcbVMv9KoWJnpEOQRl42djEVlrhQZVGMvz78IS0AkG5ufNh5A==
X-Google-Smtp-Source: AGHT+IFUr+iyVrxt7yU+AZm07YTWRHhGpUHPevxZgP7Yquc3/x6wrNl029yNa/uLtQURSkydUZKbpQ==
X-Received: by 2002:a05:6a00:1256:b0:736:5c8e:bab8 with SMTP id
 d2e1a72fcca58-7372236c795mr12039619b3a.3.1742188574631; 
 Sun, 16 Mar 2025 22:16:14 -0700 (PDT)
Received: from wheely.local0.net ([118.208.135.36])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73711564cf1sm6544163b3a.72.2025.03.16.22.16.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 22:16:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 0/2] gdb invalid memory access handling improvements
Date: Mon, 17 Mar 2025 15:16:02 +1000
Message-ID: <20250317051605.1108128-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x629.google.com
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

This adds .debug=1 attribute for GDB's phys mem access mode, adds
memory transaction error handling for it so it reports cannot access
memory instead of silent success, and silences warning logs for
invalid memory access coming from the debugger.

Changes since v1:
- Move phys_memory_rw_debug() into gdbstub/system.c and update patch
  changelog to match.

Thanks,
Nick

Nicholas Piggin (2):
  gdbstub: Improve physical memory access handling
  memory: suppress INVALID_MEM logs caused by debug access

 gdbstub/system.c | 27 +++++++++++++++++++++------
 system/memory.c  | 37 ++++++++++++++++++++++---------------
 2 files changed, 43 insertions(+), 21 deletions(-)

-- 
2.47.1


