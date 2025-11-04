Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E06CCFA04
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 22:08:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGPCI-00013N-VS; Tue, 04 Nov 2025 17:08:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rbalint@gmail.com>) id 1vGPCH-00013D-UK
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:08:13 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rbalint@gmail.com>) id 1vGPCE-00054E-BT
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 17:08:13 -0500
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-64034284521so10421595a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 14:08:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762294086; x=1762898886;
 h=subject:date:cc:from:message-id:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HTF7/P+G6vQPwKuUcJEOsNzczUX4QA4ntI8YilOM9Dc=;
 b=mV2fQDtM/FbiDAA4Vw0K3iJ4hWG2aZA+5quFMo06PEwxhLeZVZia864WWX9kzieKbf
 HvXdaRdpURZ4xKLfwa/fgUaIfWsIGUloPWAYhqtGZahXKw3sDQ3KG1tpyBUs4UT9zeFe
 HymZKpBdmhHLX3ZXNcKG+KOhA+ankPniDnshpSxyvjfCgd8Rd7AGEvZSUwAYnTM8nY9D
 IKO5S9QxQ2sS4x2IDf37EwLG10rI/rVu2j+99cNinnxqGf+2UKQfUlfw27X9v5gOTLJQ
 zpTsL7Kmo2uoDoOl8XmPHGWDWi9o/YBfGhCVCX9UEYwkJT8QhCGQpy8z5lvtWU163KOc
 9rkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUw4GOuJpoorngnN0FxvAdvVNBwFAP30p6Af30Z6GS6xsl7d/dnfAc26oj+kR88wlfCALdUFSUzsRBM@nongnu.org
X-Gm-Message-State: AOJu0YwaKXTlsrQ5YJ5Ub3cZSmxclxsMrGfNWVO4JeXFAp84YAa+NOML
 oisB/G1yfDUQo00JmGayvZxJ5BXaUM269BRZD9DSenxuyf0A24Q2O68AsWtA5wbi
X-Gm-Gg: ASbGncsTmux2Nlo25IKR2OtzFXziYVGzOeynUc42l6zHIaZG2TPKeE4IZpJAC9GLxf3
 Di0kZhadn/5pxXi7jVJchQfwOlRZFN736HuiquWzSHHPz0WD9N+jphwMaa0i0WzpC4lZ+kyy8o0
 Y6NTNf64ph33n02YFdkjB0QvI/TV3/5cSNyL9sE0Qkrlo+eajfxGIC+0hsj2zazvWWwHhxZF1Lz
 8jrrI76KQh9zaMIq9ccXI06VXSco/TXZOo/TkMvG2IHvvN4cRZexHtK6BzUzd44zdycCb6Hwp0d
 hBv6HDC8usKd7eEMwOA5NR8HRdO/cOAzmgilTAQdVp1l3cYW3D/zSWvIK3B/kfRLLyCoGZAsxs4
 l5lIVQc788IJm7d1gzSq0FZqT1TWcQXVAOH+wO3M3C8smqkOqaEa8LfN1FikHAVqRWIsAjA==
X-Google-Smtp-Source: AGHT+IHVG/SqX2WSmulciKXLuGyioQiF0oEpdn4Hm72eKC5Wsha8pjhVwwq1QVZPU5zCchkpuziW6A==
X-Received: by 2002:a17:907:6d0c:b0:b3f:5049:9e81 with SMTP id
 a640c23a62f3a-b726554c6fbmr65187166b.47.1762294085947; 
 Tue, 04 Nov 2025 14:08:05 -0800 (PST)
Received: from localhost ([149.200.120.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723d3a3f8bsm318423266b.1.2025.11.04.14.08.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 14:08:05 -0800 (PST)
Message-ID: <c50c166a14af171f77ba0956512cdee1.rbalint@gmail.com>
CC: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Date: Tue, 4 Nov 2025 14:54:23 +0100
Subject: [PATCH 0/1] user: add runtime switch to call safe_syscall via libc
Received-SPF: pass client-ip=209.85.208.51; envelope-from=rbalint@gmail.com;
 helo=mail-ed1-f51.google.com
X-Spam_score_int: 7
X-Spam_score: 0.7
X-Spam_bar: /
X-Spam_report: (0.7 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_06_12=1.543,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, MISSING_HEADERS=1.021,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-to:  Balint Reczey <balint@balintreczey.hu>
From:  Balint Reczey via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

qemu-user implements calling signal-race-safe syscalls for the guest
in assembly directly to the kernel instead of going through the host's libc.

The proposed patch adds a switch to go through libc, which allows interposition
of libc's syscall(), even when the guest program is statically linked.

The motivation behind the change is intercepting statically linked binaries [1]
with firebuild [2], a build accelerator implemented in userspace.

I have tested the Linux changes, but not not BSD ones.
I think they are trivial enough to work and I'd like to port firebuild
to BSD, too, in the future.

Cheers,
Balint

[1] https://github.com/firebuild/firebuild/pull/1334
[2] https://github.com/firebuild/firebuild

Balint Reczey (1):
  user: add runtime switch to call safe_syscall via libc

 bsd-user/main.c             | 11 +++++++
 common-user/meson.build     |  1 +
 common-user/safe-syscall.c  | 57 +++++++++++++++++++++++++++++++++++++
 docs/user/main.rst          | 28 ++++++++++++++++--
 include/user/safe-syscall.h | 25 +++++++++++-----
 linux-user/main.c           |  9 ++++++
 6 files changed, 122 insertions(+), 9 deletions(-)
 create mode 100644 common-user/safe-syscall.c

-- 
2.43.0


