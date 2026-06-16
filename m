Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC73CD98D2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 21:21:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZbDR-0005Sw-Qe; Tue, 16 Jun 2026 17:21:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDP-0005SR-S5
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:20:59 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZbDO-0007Mj-1x
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 17:20:59 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-37c6cd1ac98so598138a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781644856; x=1782249656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XTv7EdBsZZYM17yXRx1WPmwJwV522V4xAkpIf3rGjQE=;
 b=tTveWOL0xF3lQmD3BwLc2stWTx5BU3uN3lFewrEX2k045rqzgWoKTvqhW+yWz7qPYN
 86m/0zzLbZsTHbPFV3HEE541dLVvo1W7FLTx0XlTM5MDXL1GpnBaVXe2vTYRATmBufqO
 e8ibwr2Iv+HsHQ+TNjRaDazvgErKza5it6P41XuQsmXhQUEAxtMimVRIPDdYsE8a++Gs
 lXTI4L0cLvitxzYHBVFx9b41cNso3aieUFtkg8a01mCmpZhZkA8Rx0eKsVUFjtgeULrh
 0EF4zp7uCvIuvn/f2mmjPawIWhko6ohgq6NKEL/PAPE+7sxDa5vBG/0dszjYCSsJXcab
 NJlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781644856; x=1782249656;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XTv7EdBsZZYM17yXRx1WPmwJwV522V4xAkpIf3rGjQE=;
 b=JpZ5d3vjRvNAYO+NZ71KluhLry9zz9nXlPHxvy2Nc1zIf9YCVWSGHf0/7cnxOsyPcl
 sRUv6d9qR1aF6m7+McMLTC0nTHreQyx//X3HfedB/3YNDm0Jd3iI4s/VYPrw04W7Dg9/
 QOoLvGvNi79ov7N4qc3kX7Vg2rYnNDsX1rfP2phEGFq2R8L4x8MM0OxTQjqkEZlJE+Ca
 sAnPC47jun2JHwNWPscn017QgHscmc6GEtfFH8L6T5UpGH7CC6pR9iQa+Bz8AbsgL2z+
 JDLga3pzpPZyHGA+A3gPeo9oaJ9M6dlLBhhNVPgatLo2i8cA8Vcb2V5fCDrNHujd2oHa
 IkXA==
X-Gm-Message-State: AOJu0Yx9d2VcFyfpAvWthAXUnjo3xjPFigUAUXfabpVuMXBMPG+dKmwT
 2+wxTW2eDMIcYFrADhDYFt5WfMWPRLijNC0T5yiOGIkPQaKwOB48NOAooX+PMvrQIiXrZYKyYNP
 pMKDX
X-Gm-Gg: AfdE7clsUjCkp8ZTqCb7vtcR4rLXyhzsR0quYJPYB8beO6q26tMCmmiMcoWxoeF2Izt
 Jr4qBNSm5Bsr0C4thOrVeXLUcu5+DpZJotKsAO5AvnTFcynaH0pGFCbtfzf6F9oqb5fTMEytelu
 43e5c5rshzZSA3eTVwL1YxnSjR3Hir1vCKH7cUeUM+n8hU8Fc045yuGwmmt+zfMH3zdZ/CbUEG6
 HgVaYbOzTFlaySSQ7UA+dUU27+yQwCCA3pdxYq0iCLHbcw++SxIDvlIoSrbwwwJZXQS6Xlko/Pj
 gr7JQZ3qVIG8J+q9JxnFP3mDKDqNEVnfpSzslbDkqciKGErp1jYyPeeGSTNs74fDei8CLW/te2X
 67T5Jjpw8euLenLcqcrxKczkpy4hCXlO1Fq/HaqN2JNHCz7OPPTQ8ZvhRvp6ImzQAVnepZr69dn
 4HnJO8ZvVUUimZSw5hOZA6gNS+GqCELsZq7/FmaqFrCZWBHdSu1gPk46wdNved
X-Received: by 2002:a17:90b:3cc6:b0:377:23bb:9b88 with SMTP id
 98e67ed59e1d1-37c9e9c8d85mr574773a91.12.1781644856256; 
 Tue, 16 Jun 2026 14:20:56 -0700 (PDT)
Received: from stoup.. (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3820063a91.8.2026.06.16.14.20.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:20:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH v2 00/13] *-user: probe_guest_base improvments
Date: Tue, 16 Jun 2026 14:20:41 -0700
Message-ID: <20260616212055.334466-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The first 4 patches fix the ambiguous guest_lobase parameter,
which affects an odd usage of a bare metal image with qemu-arm.

The rest of the patches improve bsd-user to use probe_guest_base.

Changes for v2:
  - read_self_maps rewrite (warner)
  - rebase and r-b applied.


r~


Richard Henderson (13):
  linux-user: Introduce PGBRange
  linux-user: Use PGBRange in load_elf_image
  linux-user: Drop hiaddr out-of-range check in probe_guest_base
  linux-user: Pass image_range to probe_guest_base
  linux-user: Use PGBRange for commpage
  common-user: Move mmap_min_addr from linux-user
  common-user: Initialize mmap_min_addr for FreeBSD
  include/user/guest-host: Include missing cpu.h
  common-user: Move selfmap from util
  common-user: Implement read_self_maps for FreeBSD
  common-user: Move probe_guest_base from linux-user
  bsd-user: Use probe_guest_base
  common-user: Move guest_base, have_guest_base to probe-guest-base.c

 include/user/guest-host.h        |   1 +
 include/user/mmap-min-addr.h     |  12 +
 include/user/probe-guest-base.h  |  37 +++
 include/{qemu => user}/selfmap.h |   0
 linux-user/arm/target_elf.h      |   2 +-
 linux-user/hppa/target_elf.h     |   2 +-
 linux-user/user-internals.h      |  17 +-
 bsd-user/elfload.c               |  37 +--
 bsd-user/main.c                  |  42 +---
 common-user/mmap-min-addr.c      |  50 ++++
 common-user/probe-guest-base.c   | 347 +++++++++++++++++++++++++++
 {util => common-user}/selfmap.c  |  45 +++-
 linux-user/arm/elfload.c         |   2 +-
 linux-user/elfload.c             | 400 ++-----------------------------
 linux-user/flatload.c            |   3 +-
 linux-user/hppa/elfload.c        |   4 +-
 linux-user/main.c                |  35 +--
 linux-user/mmap.c                |   1 +
 linux-user/syscall.c             |   2 +-
 common-user/meson.build          |   8 +
 util/meson.build                 |   4 -
 21 files changed, 565 insertions(+), 486 deletions(-)
 create mode 100644 include/user/mmap-min-addr.h
 create mode 100644 include/user/probe-guest-base.h
 rename include/{qemu => user}/selfmap.h (100%)
 create mode 100644 common-user/mmap-min-addr.c
 create mode 100644 common-user/probe-guest-base.c
 rename {util => common-user}/selfmap.c (69%)

-- 
2.43.0


