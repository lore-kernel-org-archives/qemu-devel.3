Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6498DE7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 21:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwfy-0006Mm-Ea; Wed, 04 Dec 2024 16:12:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIwfw-0006MU-RJ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:12:48 -0500
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIwfv-0007kK-CP
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 16:12:48 -0500
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7fbbe0fb0b8so183287a12.0
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 13:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733346765; x=1733951565; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8VxKFI/0y4LY07W6bm/GbHm9mzNlrCNc2KPV8KgQ4yg=;
 b=crI0yPZatGlMK1OlwQLrEh/LmTizDCdmXGEWRRVNxDPEwsN/uvJUuzYuGgG6c5NJL3
 eLwIW8ORvV+tOGO69ZEig0ifgWa2ezNJpq2oPdfsmotQEW74z1QGip/iVtwDfM+2ZSwB
 OYdagZvKdoyAJnF7JuBKaoOVWmU/SVvTPw1nJKaWx/wgLTod3WJDOsmEJTM7+e2FoUrU
 anxMzTQCs5OSeNPB5+ZwkpC60+Hsz6mZZjXhyFZwT/oBmngXpjtYZ9FpqYu0xBvPX1n8
 lXhnDDziKHWeU/v/UvoPuOHu2fHEQ/l3rY8U12X81rQtRSiazFAuyb1OdHbzu3nvaaUz
 OH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733346765; x=1733951565;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8VxKFI/0y4LY07W6bm/GbHm9mzNlrCNc2KPV8KgQ4yg=;
 b=mdtCLhy5xIAs6JLnzQOYl/GEOR5kmBLXAt8IEdn3Sw0MpHmGXPfSxUn/ZgO4tA1o4T
 wHSle1Cq8CzBueWpnQRh7ab+sJbaYrAfs4tGjOI849RTAaxAe+VJ34EbtlLYFn4muT7E
 1SN9pG0D+5x60H/sj8a6DnDwdlVqLoL1P7eZb3GXXSbnt1PmWErW2bK4nTsNYRxKcDJK
 nUtQt2+UxcFLHBEEdoi9ONYF2o4jxtNzfIFhh/Sox7HeYU+IPHHOo8eu41wQvyszfglm
 YhnFMZW4yML0mItK1bT+BedQPZUG1KujDNJVqVJqIDfOh5NZQ5PzFU9QVWtsA4EOlB3V
 IV2A==
X-Gm-Message-State: AOJu0YyVue4AInkU2eQVnL0mOo1tbypTauGGNl9RNXqhc9/U+UTIAGDk
 Di/ZQwT1lH8jGVp7SkLWq59lDJ+gMBxsI1O8pxLc1ZHv8wgfPRZ5lZHLF0EVdx4jgoiGnWU8gLZ
 RodE=
X-Gm-Gg: ASbGncvtDGsxTPH0MkxmEGmyI04bSTwqp/pRqC/58KXqus/eaVOBlDXPz6yVvc9wg4l
 h7F1yGCLtZfEs1jjH8JVaS3tZJwHDDHpPPDlWo8ywdtsHD6IQu1TdVr6D7axfbxrrOosdPU4wHm
 YOWeE8GaPzaq7oPjgSt+GV5kHMHz7g/Gob3giA/K96Dg6Yb42rgyNBnO1hUzIoHOsFABu7pyj8C
 vv4bhUzpbO1pHGHRv/19byejBEZsta2Ir9kIWw9Bapd1oCxUatv3Thqvdp2FP+Cmtn8exuCYo22
 TbTDKxPk
X-Google-Smtp-Source: AGHT+IFa7NuxkjmSlj91ppu2WcILvyQUw8fQwV6FzxvpANFnQRC9Plpj+yeak7xKC4H9v/xGIFKbmQ==
X-Received: by 2002:a17:90a:ec90:b0:2ef:19d0:2261 with SMTP id
 98e67ed59e1d1-2ef19d02442mr8604205a91.16.1733346765423; 
 Wed, 04 Dec 2024 13:12:45 -0800 (PST)
Received: from pc.. (216-180-64-156.dyn.novuscom.net. [216.180.64.156])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef270089b8sm1905830a91.14.2024.12.04.13.12.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 13:12:44 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 alex.bennee@linaro.org, Fabiano Rosas <farosas@suse.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/2] Change default pointer authentication algorithm on
 aarch64 to impdef
Date: Wed,  4 Dec 2024 13:12:32 -0800
Message-Id: <20241204211234.3077434-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52d.google.com
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

qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
spent up to 50% of the emulation time running it (when using TCG).

Switching to pauth-impdef=on is often given as a solution to speed up execution.
Thus we talked about making it the new default.

The first patch introduce a new property (pauth-qarma5) to allow to select
current default algorithm.
The second one change the default.

Pierrick Bouvier (2):
  target/arm: add new property to select pauth-qarma5
  target/arm: change default pauth algorithm to impdef

 docs/system/arm/cpu-features.rst |  7 +++++--
 docs/system/introduction.rst     |  2 +-
 target/arm/cpu.h                 |  1 +
 target/arm/arm-qmp-cmds.c        |  2 +-
 target/arm/cpu64.c               | 30 +++++++++++++++++++-----------
 tests/qtest/arm-cpu-features.c   | 15 +++++++++++----
 6 files changed, 38 insertions(+), 19 deletions(-)

-- 
2.39.5


