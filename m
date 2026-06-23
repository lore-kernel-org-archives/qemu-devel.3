Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5CA8CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:24:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc2z2-0004kH-Vu; Tue, 23 Jun 2026 11:24:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wc2z0-0004jT-PS
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:24:15 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wc2yx-0003FK-KN
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 11:24:14 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490b8ac62baso11424105e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2026 08:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1782228249; x=1782833049; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=furMavqkiQ1mMg+SFKSul/jWMUzV83r9DJ8+BFZ7JT4=;
 b=ZVsTmTuxajfP4OOr3mSZm9pfEKvNwjXZoDkpy56PR8/G6vszg1DGhRDMikbkNDTRRY
 IwAF5ms9mdCf/DT/gbYr4GVso0WcwVcuM/ksN45iQO5GvRVuur4HBMgDsdsRdHXLPNvG
 +vQw2zL4ngjST5uc8RcRwNcoRSiN13X4QVzcnzRkwVyGTlVD0dv24hEdNeqroXNgdGjj
 e7Tm5agTOfNbb5yHT2i6iBhr4ypBL7RXqMrascJBLlSrHnB7v3xm8Fi1IXQKxZ5Zo0o0
 n8vayVt02MB8iSpnKC9zujVxTtaeIv0rbcQ3uFZCCLiwK3hC+XJifU5Nh6XNL/mtM9xo
 dVAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782228249; x=1782833049;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=furMavqkiQ1mMg+SFKSul/jWMUzV83r9DJ8+BFZ7JT4=;
 b=jf0/rHK1bowZFGcWzTYuEPJOqSgAWTJSvudWQRDlY7iP+94MOytzDCzL9lXcedY+b8
 B8rbbEiVWgfedViNoVXOKD0KwGjybC3C2lFBckQJM5xntr5sPP5HTANkzlq0/6dHSmzy
 veZqKLnPnhpzpeGM1+S8gdeVY6lAA6w/OvhjIOfHKr88cgsPUO1sFD99063K7IC1Vg59
 9DFiIoYiUp4MmtqQYQ7HDSTCv73darzgwDsXGF3yWtmzmWrKCey2Vx/8QpvCU/Y3zhFV
 a4/qjof0K8SXgGczHNQPXUFdgviL15iMGDblciifDqOctstT2SB1Ufv3CMsm8PuaB9NC
 yZCg==
X-Gm-Message-State: AOJu0YyuS6Jl+Vvx3eH3zMozIHhFpLUXBu5Nbg7r4prVNHjbCpTcEzpr
 X0x3HNmC1MbmGlLhq70+6cIvNrxGFV9qf1Thje4kJH5ln9zqoZg6QEFUxSmn5xFUDLc=
X-Gm-Gg: AfdE7ckPmNcixfYnD/lHYFZ27/es6f7qTiuZtW6jrrI0GFSSUPLNffgSDtvS6s8hTXX
 hS2BsNc1Gtja11ALvAlg34aGm1iZShJhFiMRpIbWlu+PuLLNcwxynvu5jT0PjKy8KF+A/pJ6hzi
 TPgNLCCeREDcLfJ+rLv/2uIVoFubAstA3yYXTF9m7HHlcjRpgiFvTkJ7wDnM+XupiMxWhkrGykl
 EQ9IiNcY3eMMwpiEf49GhKsc2650lxjWgCYpLiHVGBoFhPkotSwQNwVC2NEAMWaVzp2m89aNMwP
 A4Rj40ZVIFT+imI/b0FrPIcFRrrRHexnvZ/CzWsU1FHSiYHyFNrp2dmhIy5YpfFQJuWKpQW1+tA
 MUqOuxt7B+dADx3Bg7Gjr05fXKU61yUkInggOlKgjZFVCWjgGrj1dvR2+EeiwFcGlq6OavbI=
X-Received: by 2002:a05:600c:4e8f:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-4925a0c4ec8mr61102185e9.14.1782228249179; 
 Tue, 23 Jun 2026 08:24:09 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:406b:7279:5a3e:280f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49240eef2basm406008895e9.2.2026.06.23.08.24.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 08:24:08 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 "Denis V. Lunev" <den@openvz.org>
Subject: [PATCH 0/2] job: don't drop job->paused while a pause is pending
Date: Tue, 23 Jun 2026 17:24:04 +0200
Message-ID: <20260623152406.1180235-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=den@openvz.org; helo=mail-wm1-x32b.google.com
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

A guest can abort QEMU with

  qemu-system-x86_64: ../job.c:379: job_set_aio_context: Assertion
  `job->paused || job_is_completed_locked(job)' failed.

when it touches a virtio-blk device whose BlockBackend lives in an
iothread while a block job (drive-mirror / blockCopy) runs on the same
node. It is guest-triggerable and reproduces on current master. It was
reported against the qemu-kvm 10.0 downstream, hit by the live-migration
validation suite when a blockdev-mirror (libvirt blockCopy) ran while
the guest reset its virtio-blk device during boot.

Under overlapping drains job_pause_point_locked() clears job->paused on
wake while a pause is still pending (pause_count > 0), and the
concurrent AioContext change reads paused == false and asserts. Patch 1
carries the full interleaving and the fix; being in the job layer it
also covers the other bdrv_try_change_aio_context() callers
(x-blockdev-set-iothread, blockdev hot-plug/unplug, job completion), not
just the virtio-blk reset path.

Patch 2 is a deterministic regression test in tests/unit/test-blockjob
that fails without patch 1 and passes with it. It is illustrative only:
it pins the exact invariant patch 1 restores, but the fix stands on its
own and the test may be dropped freely.

There is no iotests reproducer. iotests run under qtest, which has no
vCPU, so the only way to change a running job's AioContext from outside
its iothread is x-blockdev-set-iothread, which runs in the main loop
under the BQL - the same lock the pause handshake takes - and the
cross-thread window never opens on an idle qtest VM. Several designs
(back-to-back set-iothread, pause/resume churn, two iothreads, a
latency-injecting null-co feeding a throttled mirror) all pass on the
unfixed build; a timing test that passes on broken code is worse than
none.

To reproduce on master: in the guest, tightly unbind/rebind a virtio-blk
PCI function backed by an iothread; on the host, keep a throttled
blockdev-mirror alive on that disk's node. The assertion fires within
seconds; with patch 1 it runs indefinitely.

checkpatch is clean; test-blockjob, test-bdrv-drain and test-block-iothread
pass.

Denis V. Lunev (2):
  job: keep job paused across overlapping pause requests
  tests/unit/test-blockjob: cover keeping a job paused while a pause is
    pending

 job.c                      |   9 +++-
 tests/unit/test-blockjob.c | 100 +++++++++++++++++++++++++++++++++++++
 2 files changed, 108 insertions(+), 1 deletion(-)

-- 
2.53.0


