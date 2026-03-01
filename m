Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AB0FD0057
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Mar 2026 14:43:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwi05-0000FI-R0; Sun, 01 Mar 2026 09:42:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi04-0000Eh-FV
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwi01-0005hS-R0
 for qemu-devel@nongnu.org; Sun, 01 Mar 2026 09:42:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772376144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=W58/GMqnX+pibEwats/XCGuk5jAwv2J+pg18yrXmRLQ=;
 b=AOG6jv9gqPyhzmJ/JZU0FA3DOQe30hrhUl9nNTmnnxSechMOWX3M9t7EnbNRaIeAi4bjea
 XFyXKF7RFPwFKuTgbbDMaZEqsVAnqe1+AXaJlV7QKCQpNh0LbJhgxkSOBFcayKVs7KLtQO
 Neyvex52nMRmeDsqjWhvTwwbf4VCoUI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-HKwHyfJhMNezFlzdZ2ghTQ-1; Sun, 01 Mar 2026 09:42:22 -0500
X-MC-Unique: HKwHyfJhMNezFlzdZ2ghTQ-1
X-Mimecast-MFC-AGG-ID: HKwHyfJhMNezFlzdZ2ghTQ_1772376142
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439aa1d898cso830186f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Mar 2026 06:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772376141; x=1772980941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=W58/GMqnX+pibEwats/XCGuk5jAwv2J+pg18yrXmRLQ=;
 b=K/ddeWuFF5LXi+53bpwgJKc9VA1F0S41W7/TOv3IPkECSbwSdaoSHMBede2szrQNSL
 ui/jjQpQZrXqOVwxreRsonPlfRH6GjXkHolQz8M+L1mNP5mvLu2cqmiSMlozMB8UuNT0
 fwXJpbwnSNlD1Kig7X38J6ocGiCf8mqC0TSck3jQ1XXX1Iv6pQP97gyITZdHqdNHZ7Lk
 jiGVSMh4gHnqwSV5Mi/+vG1PATA8fHYwqyvyuEHuYYMxaGaiO6z+oi7Z87QcHfDNDhTY
 yfg4bM8bcxys6gGHnLB/4rg2eV0WH9yMoPwg+UMYmAZRG7bba3dPra0mCh8MyztNre6m
 GP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772376141; x=1772980941;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W58/GMqnX+pibEwats/XCGuk5jAwv2J+pg18yrXmRLQ=;
 b=BhNlkW+z+adq8vcMi5IWtw6e6q6fWqotfphHQB0JJS+Jyqd6OuQIjOSgLxYiYEreIy
 ftxSnY1o1Joe/sUIRMVul+zZyRgv6/gCj/XD7k4RXEyHo7GvX1ldWBl2LZx+IZKCuISL
 rEvSLekl5XA6BN8bVOO4aet1AGe0If7AQtu6nAexKebfu7VEllMMMxY5JaCbLBtlQx6k
 hNYxocUFjHVYma5ZNhGxt7Clx9i26295rmmkDVirFip2jjuGwUfJcm1W/ofFlmPirMZB
 /NzOv6OoPlmVyAdSsktgVUwdoN/KGeHONcVDoEyYO4S9c8PDP47ZDCR4l8OijEX721NW
 Ij6A==
X-Gm-Message-State: AOJu0Yw2pJtXYfg+f/8SnARscMh8n+Jb9Y7RhGLLowef9S8UjHDBZHJM
 IcSolRr5h/tmFqrE5eX47HJT2QwnV2tNMOsgarwI7ZufTKHue2q6gG9fQIZ7S/JvEeBhPa7vgBZ
 7nD1oOPgZs6rjq9nkXFBeldy2J4qGi1e9zYABVAdLl/npAY8X48XFcj8yZ+EP5DppMM9HKyDAzP
 SNanKSiCCsPuML8o95TFd8mE4CmHdIFORQKv4y8l1J
X-Gm-Gg: ATEYQzxweaLwx4nIlQCZhLRcFloZAmkdPakysrRA7dDsKriVjshmm+Lrghwgf/0UvG0
 FB1gQq/O2WaXRVMrhi5KG6ga6NM+idgWPltHhfUDr8w4zariC20gTzRlKPCcBk6NYo2Ea+Q8gt3
 1fFDcm7Ae5OR4l1Er3fUN+g9uB8nGSn6I1XKCEARVWswaLyb0gaOQTW+lsgE42KDrbktyjYcVQf
 BMyEljqhssLtYWPLYdE1HcsSeAwYhjM/qqSr12rAOxXzwGOEnnoBhCjvb5xvHjCIXgL8rcaVOGw
 pdk1J9agUrwvWVwC72M+ypbGbFLv/45c0idBI5vZ6dTTMKAt2hkC69lC1BCeoRhm+wRYjRHFcIp
 55+7MC84m49EczSSnixknK4YNkTmdec7ZcXWvo0T/49TKTVc7zVIeuAZlyIDQlcLZztt/YK4mAM
 Mmy+TujYPKEIE5AX+YKLTA09r4cQs=
X-Received: by 2002:a5d:584e:0:b0:439:b788:73ae with SMTP id
 ffacd0b85a97d-439b7887890mr462877f8f.49.1772376140930; 
 Sun, 01 Mar 2026 06:42:20 -0800 (PST)
X-Received: by 2002:a5d:584e:0:b0:439:b788:73ae with SMTP id
 ffacd0b85a97d-439b7887890mr462816f8f.49.1772376140204; 
 Sun, 01 Mar 2026 06:42:20 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c60f8e5sm23835314f8f.4.2026.03.01.06.42.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 06:42:19 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 00/18] target/i386/tcg: implement APX
Date: Sun,  1 Mar 2026 15:42:00 +0100
Message-ID: <20260301144218.458140-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series implements APX support.  This is little more than some
Christmas time hacking, and I have tested it for now only on user mode
emulation.  The main reason to do this is actually to have some initial
infrastructure for EVEX, without requiring all the complexity of AVX512.
It also forces some changes that (hopefully) make QEMU's decoder align
a bit more with what Intel processors actually do.  These (patches 1, 4,
8, 9 in particular) could be extracted and committed separately, though
at this point this would be something for 11.1 anyway.

There are relatively few *new* instructions (CCMP/CTEST, CFCMOV,
PUSH2/POP2), all of them trivial except for CCMP/CTEST. Therefore, most
of the new code is for decoding.  The new data destination feature comes
almost for free thanks to the existing support for BMI instructions, and
variants such as no flags update and zero-upper are quite easy as well.
For CCMP/CTEST, I tried to make them reasonably efficient, also thanks
to the changes to AF/CF/OF computation that came over the past year,
but that takes quite a few lines of code.

Don't expect any performance gains.  APX binaries do produce about 1%
fewer TCG ops, but they map to about 1% *more* assembly instructions,
at least for x86-on-x86: that's because while the optimizer could
already produce roughly the same ops as NDD or NF instructions, the new
PUSH2/POP2 instructions include a stack alignment check that isn't there
in non-APX code.  I don't think it's worth wasting a precious HF_ bit
for it, at least not until for 10 years or so.

Other than testing system emulation, the main decision to take is
whether to treat VEX and EVEX maps as an extension of the regular maps,
or just bite the bullet, copy them over to a new array and define them
from scratch.  There are some annoying differences already in APX
(accepted prefixes and opcodes moved to a different spot) and there
would be even more with AVX512, for example mask register instructions
use opcodes in VEX map 1 that overlap with two-byte 0F opcodes.

I don't think I will have much time to work on this for a few months,
since I did it just out of my own interest, but I thought I'd throw it
out there for review.

Paolo

Paolo Bonzini (18):
  target/i386/tcg: move check bits out of validate_vex
  target/i386/tcg: add APX support to XSAVE/XRSTOR
  target/i386/tcg: treat VEX as disabling high-byte registers
  target/i386/tcg: add definition for REX2 prefix
  target/i386/tcg: mark XSAVE* as not allowing REX2
  target/i386/tcg: decode REX2 prefix
  target/i386/tcg: implement JMPABS instruction
  target/i386/tcg: fetch modrm early
  target/i386/tcg: move VEX validation early
  target/i386/tcg: extend VEX.vvvv parsing for APX
  target/i386/tcg: decode EVEX prefix
  target/i386/tcg: add ZU writeback
  target/i386/tcg: add decode functionality for APX
  target/i386/tcg: implement CCMP/CTEST
  target/i386/tcg: undo IMUL memory load optimization
  target/i386/tcg: decode APX instructions
  target/i386/tcg: mark APX as supported
  target/i386/tcg: optimize CCMP

 configs/targets/x86_64-bsd-user.mak      |   2 +-
 configs/targets/x86_64-linux-user.mak    |   2 +-
 target/i386/cpu.h                        |   8 +
 target/i386/helper.h                     |   1 +
 target/i386/tcg/decode-new.h             |  20 +
 target/i386/tcg/tcg-cpu.h                |  16 +-
 target/i386/tcg/cc_helper_template.h.inc |  11 +
 target/i386/cpu.c                        |  15 +-
 target/i386/helper.c                     |  11 +
 target/i386/tcg/cc_helper.c              |  10 +
 target/i386/tcg/excp_helper.c            |   5 +
 target/i386/tcg/fpu_helper.c             |  59 +-
 target/i386/tcg/tcg-cpu.c                |   5 +-
 target/i386/tcg/translate.c              | 106 ++-
 target/i386/tcg/decode-new.c.inc         | 937 ++++++++++++++++++-----
 target/i386/tcg/emit.c.inc               | 243 +++++-
 16 files changed, 1226 insertions(+), 225 deletions(-)

-- 
2.52.0


