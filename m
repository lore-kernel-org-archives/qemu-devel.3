Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278F8E9A053
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 17:19:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt7fO-0005Lg-Gf; Thu, 19 Feb 2026 12:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fM-0005Kj-2S
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:16 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vt7fK-0000Pw-1r
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 12:18:15 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b8850aa5b56so225137366b.2
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 09:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771521492; x=1772126292; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=gadO7bigcRDHgxevTilDA1AZWO5dSY59yjXY5cBcG9g=;
 b=dqebgeBIkKBnOw5Z7Suz5g2vi22QfU6GNWD1VRfnWcrsekI4m8d44r7xdmmq63ja1O
 U+kVXkHkPOQy/FBAQMDqymIRB9bUmcPQJsls0SWy2fLsJ6F2pTJ3FsoAB5glL3t/qeL7
 dusdOXhEx9wAG+rgFUpeC9olDF36qQ1t2MyULse7Qqp312dIa3KkX0BRjyz2woraXl1K
 dcX4stwFKbpHDQBuEJwvxsjzfVr8Hp9+obFK9/2TH1gq63FOB70Aj/ET/SC14vgWuu34
 88zYEBrZYNvcOis7l14FlWa523VxnJ1kgdTpzlEWeoAaqv88fvfmA0DJALvkblb/+/xc
 Z2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771521492; x=1772126292;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gadO7bigcRDHgxevTilDA1AZWO5dSY59yjXY5cBcG9g=;
 b=X9KU+IQHuBYcrZ6UBhoHYE95TiDcezzQsD5LwvKy4oZFyTrl9EpDNyGsATIIas4Ij+
 CxCKgNpGqa2Ua7X9shM37QEJk/hKhv/2kIUygaxD7cm3607oLRdYaQdUVWXywPH+mGCW
 A9BYOE4BahFaQ36ZSX7df+zjzWNZplJTMHENbnDbftTKW5qVaXInAjlwtGsG96CA2WJb
 CZN4muvS7qAqFTuoi+ycMAIcojF+TJ8lf6uZ3izYzIxQ1tlSVFYBxw+9IwX8OfXCngUG
 13icLbDG/zaT82xl1a8ecJf8EqVZrk0W0MM9WrcAAmqdz2N06Ecp3hs19ya5CbdvcDUA
 BLmg==
X-Gm-Message-State: AOJu0Yy5DNF91GV/JQfJeUOm7nXfqagSSvyjJjXDGIItAjbtIrSC+qDK
 XqYT8YHtd2xiqbgoMbcFJ9VtxgK6y7y7W2KMFPujAkvuJd77hSqX4WWaSX2hCi8Ox94=
X-Gm-Gg: AZuq6aKZBLIGGb89efz53SH2e6LHe91yoKbqYb3BzKYmgmwbqA6RS7aBy8zapUPd99a
 CtUuDFKZjaz1EB2OJIZNZpo4qf620yAXJzS33h57fuceRuqEqBOpzQ5SH+D8GQ9q9R7qEdd1vob
 neIr9kIZQYb7Pn4nfKZ3cVcljzy8zmTnMxH/TSufpQfbfaztEJlkSEnhnMzAFecnsg11wOpUa3z
 QHzwJkfj9VarLornys50bESxD98rws6gdsX/yxLKQhxvnzHS0UAFFKuTB3snwkfr2R03+McHfPm
 wrO+srLnWEkua/sQIQFuGtvG2TCetNVEiw8trarup73q6Qds8/kwzLWbNSkE116gm6PtSPX6CCE
 8mkOKZtWVeH/VKi9M+x7CPR0/m/7Yqk6So99mq370lLyF6Fvatho3zDHiJ4+T40Igc74lnFM4Ne
 cBHegK9Uc7lHiKIZpiXmiu3Oc=
X-Received: by 2002:a17:907:7fa5:b0:b8e:fe3c:2264 with SMTP id
 a640c23a62f3a-b8face2498amr1270538066b.41.1771521492121; 
 Thu, 19 Feb 2026 09:18:12 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b8fc735e4cbsm599432366b.13.2026.02.19.09.18.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 09:18:11 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 898D05F818;
 Thu, 19 Feb 2026 17:18:10 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <yoshinori.sato@nifty.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>, Thomas Huth <huth@tuxfamily.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jim MacArthur <jim.macarthur@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bastian Koppelmann <kbastian@rumtueddeln.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH v2 00/14] cpu_reset clean-ups for arm, alpha, mips,
 m68k and tricore
Date: Thu, 19 Feb 2026 17:17:56 +0000
Message-ID: <20260219171810.602667-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

We tend to apply cpu_reset inconsistently throughout our various
models which leads to unintended ordering dependencies. This got in
the way in my last plugins series:

  https://patchew.org/QEMU/20251219190849.238323-1-alex.bennee@linaro.org/

where I needed to shuffle things around to ensure that gdb register
creation was done after dependant peripherals had created their cpu
interfaces.

Regardless of that we do have a proper reset interface now and most
architectures have moved to it. This series attempts to clean-up the
remaining cases with proper qemu_register_reset() calls so reset is
called when we intend to.

v2

I re-span this to address the missing cpu_reset Akihiko found
troubling the alpha replay test:

  Message-Id: <20260217-alpha-v1-0-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp>
  Date: Tue, 17 Feb 2026 15:34:28 +0900
  Subject: [PATCH 0/2] Reapply "rcu: Unify force quiescent state"
  From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

I also dropped the use of qemu_register_reset in favour of the proper
3-phase APIs.

Alex.

Alex Bennée (14):
  target/m68k: clean-up includes in cpu.c
  target/m68k: initialise pc/sp vector during reset
  hw/m68k: transition virt machine to multi-phase reset
  hw/m68k: update nextcube to 3-phase reset
  hw/m68k: update mcf5208evb to 3-phase reset
  hw/m68k: update an5206 to 3-phase reset
  hw/mips: defer finalising gcr_base until reset time
  hw/mips: drop cpu_reset in mips_cpu_realizefn
  target/tricore: move cpu_reset from tricore_cpu_realizefn
  target/arm: remove extraneous cpu_reset from realizefn
  hw/alpha: remove unused includes
  hw/alpha: add a reset function for the clipper machine
  target/alpha: move cpu reset into a proper reset function
  include/hw: expand cpu_reset function docs

 include/hw/core/cpu.h |  3 +++
 include/hw/mips/cps.h | 14 +++++++++++++-
 target/alpha/cpu.h    |  2 ++
 target/m68k/cpu.h     |  2 ++
 hw/alpha/dp264.c      | 12 ++++++++++--
 hw/m68k/an5206.c      | 23 ++++++++++++++++-------
 hw/m68k/mcf5208.c     | 26 ++++++++++++--------------
 hw/m68k/next-cube.c   | 23 +++++++++++++++++------
 hw/m68k/virt.c        | 34 ++++++++++------------------------
 hw/mips/cps.c         | 26 +++++++++++++++++---------
 hw/misc/mips_cmgcr.c  |  1 -
 target/alpha/cpu.c    | 10 ++++++----
 target/arm/cpu.c      |  1 -
 target/m68k/cpu.c     | 41 +++++++++++++++++++++++++++++++++--------
 target/mips/cpu.c     |  1 -
 target/tricore/cpu.c  |  9 ++++++++-
 16 files changed, 149 insertions(+), 79 deletions(-)

-- 
2.47.3


