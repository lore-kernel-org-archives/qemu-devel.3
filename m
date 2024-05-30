Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38882C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 22:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCnui-0007JJ-UB; Thu, 30 May 2024 18:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCnuf-0007IM-DJ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:06:21 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1sCnud-0005CN-AJ
 for qemu-devel@nongnu.org; Thu, 30 May 2024 18:06:20 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f62fae8c3cso4746365ad.3
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 15:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717106773; x=1717711573; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=c+v3Csm26bJrGyWtWGYvNY7l6wOwq0bZJEszW/Rc9OM=;
 b=HM3dCL2RT2MhxxLfziXcVUtAEjLSdqt0PoFpNKQGbQBcGRIOghWo/SqIhrlruoFhVo
 3l0/no/JfvqHlVXEtRM9U2Xl5fMuzlemfHKOePWfT2E20YI8WorUzSB6sqIlcnOZom7A
 l/3wYVmHK+MqMnvK5rcvLK9ajwK5430zgNR1DcSM6HZLbML4MLjMnreirbMAjTUCqOof
 qMFHaGuDjDK5t51b86jciPl5cRVvIK8Q4bgIcOE8q4nquztiOaIsyVGv2Kw14DPbXl+9
 n3VxH1GubYOP0pajZS0/J+1o0wsvpYXA/IveW1nBK0U6vnnh1fhq9QWEHI8U5STrfv1D
 iikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717106773; x=1717711573;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c+v3Csm26bJrGyWtWGYvNY7l6wOwq0bZJEszW/Rc9OM=;
 b=iLO55nSYhmaAeoeR3w5dRiK1WK82CQyRmkMlD/E3QvVV1E1wNkXAi1iLxhgewok819
 4UPPclKksts+pUgEFOHZOhxbpsdAdyvVQqSKlZjoPj9wYOpFSCiNcXp8mvqwGioZTW80
 wEI6qeeydmPzB+9957yzgVAYsububilJa8qS8LJ2HQg2vRSpW5xe8CKYE/RRcn0IYqIm
 aqYrasM935B7A3+ZxvgOdVf4gy+oKoImUhkx3fJjgyjH/i6adCWIxXZP+88Tmb3fTrF+
 0jPa7sV+yOlvUmJLgFiW2I4UyRRVvlLQzUfBjYmShiIHxQqhzT9e0Bk6zNTVYEs7YJtz
 mifw==
X-Gm-Message-State: AOJu0YyfZAvY+J1KlcL6CdWkWglwQAUpBMCcSzqEOmVRHfa813efo0KR
 V+9kFsesbH3DWOZB4iuyOLSskfW3fEyiz6XcD8hE8yMCQT4FcQGuTQxzKZGg+ZRFW4SIVjm869D
 CTAw=
X-Google-Smtp-Source: AGHT+IGvCN1bDs8DczhYLgo9oVH4qj9IDop4ggUxid16S6B+ro7F/b8NLBYJBI7CIC5ibIdvZobcNA==
X-Received: by 2002:a17:902:ecc5:b0:1f6:35ab:dd55 with SMTP id
 d9443c01a7336-1f6370c1400mr1039165ad.65.1717106773296; 
 Thu, 30 May 2024 15:06:13 -0700 (PDT)
Received: from linaro.vn.shawcable.net ([2604:3d08:9384:1d00::e697])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6323dde39sm2732615ad.167.2024.05.30.15.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 May 2024 15:06:12 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 0/6] Implement icount=auto using TCG Plugins
Date: Thu, 30 May 2024 15:06:04 -0700
Message-Id: <20240530220610.1245424-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62b.google.com
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

The goal here is to be able to scale temporally execution of qemu-user/system,
using a given number of instructions per second.

We define a virtual clock, that can be late or in advance compared to real time.
When we are in advance, we slow execution (by sleeping) until catching real
time.

Finally, we should be able to cleanup icount=auto mode completely, and keep
icount usage for determistic purposes only.

It is built upon new TCG Plugins inline ops (store + conditional callbacks), now
merged on master.

Example in user-mode:

- Retrieve number of instructions to execute /bin/true
$ ./build/qemu-x86_64 -plugin ./build/tests/plugin/libinsn.so -d plugin /bin/true
cpu 0 insns: 120546
total insns: 120546
- Slow execution to match 5 seconds
$ time ./build/qemu-x86_64 -plugin ./build/contrib/plugins/libips,ips=$((120546/5)) /bin/true
real    0m4.985s

Tested in system mode by booting a full debian system, and using:
$ sysbench cpu run
Performance decrease linearly with the given number of ips.

v2
--

- Added missing personal Signed-off-by for commits from Alex
- Fix bad rebase in stubs/meson.build
- move qtest_{get,set}_virtual_clock to accel/qtest/qtest.c
- A race condition was identified for plugins init/idle/resume, but is not
  related to this series, and will be fixed in another one:
  https://lore.kernel.org/qemu-devel/20240529152219.825680-1-alex.bennee@linaro.org/

v3
--

- remove precise execution (per insn, per tb is enough)
- fixed algorithm used. Instead of comparing from start time of the system, we
  just check on a given quantum of time that we didn't run too fast. It is more
  simple, there is no need to track idle/resume events, and a vcpu can sleep
  correctly.
- use "sysbench cpu run" in system mode to check execution is slowed as expected.
- do not use idle/resume callback

Alex Bennée (4):
  sysemu: add set_virtual_time to accel ops
  qtest: use cpu interface in qtest_clock_warp
  sysemu: generalise qtest_warp_clock as qemu_clock_advance_virtual_time
  plugins: add time control API

Pierrick Bouvier (2):
  qtest: move qtest_{get,set}_virtual_clock to accel/qtest/qtest.c
  contrib/plugins: add ips plugin example for cost modeling

 include/qemu/qemu-plugin.h                    |  23 +++
 include/qemu/timer.h                          |  15 ++
 include/sysemu/accel-ops.h                    |  18 +-
 include/sysemu/cpu-timers.h                   |   3 +-
 include/sysemu/qtest.h                        |   2 -
 accel/qtest/qtest.c                           |  13 ++
 contrib/plugins/ips.c                         | 164 ++++++++++++++++++
 plugins/api.c                                 |  31 ++++
 ...t-virtual-clock.c => cpus-virtual-clock.c} |   5 +
 system/cpus.c                                 |  11 ++
 system/qtest.c                                |  37 +---
 util/qemu-timer.c                             |  26 +++
 contrib/plugins/Makefile                      |   1 +
 plugins/qemu-plugins.symbols                  |   2 +
 stubs/meson.build                             |   2 +-
 15 files changed, 314 insertions(+), 39 deletions(-)
 create mode 100644 contrib/plugins/ips.c
 rename stubs/{cpus-get-virtual-clock.c => cpus-virtual-clock.c} (68%)

-- 
2.39.2


