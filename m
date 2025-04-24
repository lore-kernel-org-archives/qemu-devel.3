Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D21C369D8
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 18:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u81Od-0003cJ-UN; Thu, 24 Apr 2025 14:34:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u81Ob-0003b4-FL
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:34:01 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u81OY-0007lr-6b
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 14:34:01 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-736e52948ebso1552526b3a.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 11:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745519636; x=1746124436; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JtAsAk9Pi6vIy9Bk1sQSsGqUPVl8PURk7rv1C5keXn0=;
 b=IorF5kUy8MRhbYZkl1KHB5hMJHVQIIBjKMzqf9QBumSoDgM/bFKfzXJCrELqaalZCX
 2RFDAYMS9Imw9PVzWROX3yyik5//FUqdIZaRgChmEpcuS/afCiUqorr1aEXCtEj9rWFQ
 8rXhVJm0fsBB/bb5YcI/5vUrCA6evihscptRhQMsIOjgCitcuURTPRjvXGjr9gj0PoiN
 TQhQi5zRsEqojC3XQGBScYRoD0dGaje5XeCx6O12fcCXrdVQuaXQ0As/HigSg1/4mLSW
 ywyp/8VEkAd01Th8EH8PAH5RN34R7r3ZbrPipP+rTNUrWFO111tns2L+MD4RtgniPLvE
 IeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745519636; x=1746124436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JtAsAk9Pi6vIy9Bk1sQSsGqUPVl8PURk7rv1C5keXn0=;
 b=p5mBZuyv5fngTlRMp9Ij9ItLTUn6KilJHTwcC/L26yZPicbZb36z8vErNeOX4LqDQO
 mB4/hHP7Dh+wbI1EcN+h0qZaXBpBJScWplQ3yvtmxzvblX+sU7udQ/PetnJueVgw08Rn
 sX5LB2zxjAZSV2I7d8KHvhC9I8HKBVv5uCyjZ2KMXAGObFxUIPT5cSQonc1LZUZf0Ip0
 jGyAb/WWvYFDZOp3s1qDpfGQAUo7aTlNWr/4DPktbzyEfCwIo7PJtUbDjZrXUHY5kdfJ
 U1HPLX9fImy+TKEeguZIR955uebevTDLQIgyr5HTDb/I4IEU7C5Kv63HziaI3VtYiKmq
 3VmA==
X-Gm-Message-State: AOJu0Ywmq2fwqoGUXTRG7jtBsPVPPFg0sy3aRG1fDrBQOE3+AAFIbJeQ
 IgPykDh8P+vB1HVLqQ3iFIVsRgWzTRVmaVN+fAsuoqou4q58/qN8GsNhae3muHpMaiBQBEEjhHx
 d4Ic=
X-Gm-Gg: ASbGnctj6WMJVw5Ygk4mt6yPf7DLFs13XZUWaXsKlSuiL9fIk0LZzZkuushpZBpcy0L
 6D28SJ4K7diN5nVkYdOUT7+ypDzsfM8DyMhz5pdIpqScA0JWcYBPY5ZuxpAdKqt3HnwPbyIIcz5
 8ZUSFvF05oHc2c4fpTvH9DU7hu9tghcceO/31BtQZRaWuxDRWAvgxV1ygja5h6JzqbuApyDWqi4
 /UUBXNHYlQK4NCwNGSOZtf4T0/ADYsxun0mbgbqE9ko90BhGH9R0YIn9vg2j3yx03kD9b8z79dN
 puVxuTJjhqATJfXHxQf0/DOiwsqO2UtapTTzZUBP
X-Google-Smtp-Source: AGHT+IH9f9p/GT01Kwh9idNn12hJhJM1QYMNA5GJ3veUuXg0T5yD6NKyQJeRDlPoKXuyrK1GsmjxbQ==
X-Received: by 2002:a05:6a21:501:b0:1fe:90c5:7d00 with SMTP id
 adf61e73a8af0-20456709facmr467948637.28.1745519635992; 
 Thu, 24 Apr 2025 11:33:55 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b15fa80fbaasm1544157a12.49.2025.04.24.11.33.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 11:33:55 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, stefanha@redhat.com,
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 berrange@redhat.com, peter.maydell@linaro.org, thuth@redhat.com,
 jsnow@redhat.com, philmd@linaro.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [RFC PATCH 0/3] single-binary: make QAPI generated files common
Date: Thu, 24 Apr 2025 11:33:47 -0700
Message-Id: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

Note: This RFC was posted to trigger a discussion around this topic, and it's
not expected to merge it as it is.

Context
=======

Linaro is working towards heterogeneous emulation, mixing several architectures
in a single QEMU process. The first prerequisite is to be able to build such a
binary, which we commonly name "single-binary" in our various series.
An (incomplete) list of series is available here:
https://patchew.org/search?q=project%3AQEMU+single-binary

We don't expect to change existing command line interface or any observable
behaviour, it should be identical to existing binaries. If anyone notices a
difference, it will be a bug.

The first objective we target is to combine qemu-system-arm and
qemu-system-aarch64 in a single binary, showing that we can build and link such
a thing. While being useless from a feature point of view, it allows us to make
good progress towards the goal, and unify two "distinct" architectures, and gain
experience on problems met.

Our current approach is to remove compilation units duplication to be able to
link all object files together. One of the concerned subsystem is QAPI.

QAPI
====

QAPI generated files contain conditional clauses to define various structures,
enums, and commands only for specific targets. This forces files to be
compiled for every target. What we try to do here is to build them only once
instead.

In the past, we identied that the best approach to solve this is to expose code
for all targets (thus removing all #if clauses), and stub missing
symbols for concerned targets.

This series build QAPI generated code once, by removing all TARGET_{arch} and
CONFIG_KVM clauses. What it does *not* at the moment is:
- prevent target specific commands to be visible for all targets
  (see TODO comment on patch 2 explaining how to address this)
- nothing was done to hide all this from generated documentation

From what I understood, the only thing that matters is to limit qmp commands
visible. Exposing enums, structure, or events is not a problem, since they
won't be used/triggered for non concerned targets. Please correct me if this is
wrong, and if there are unexpected consequences for libvirt or other consumers.

Impact on code size
===================

There is a strong focus on keeping QEMU fast and small. Concerning performance,
there is no impact, as the only thing that would change is to conditionally
check current target to register some commands.
Concerning code size, you can find the impact on various qemu-system binaries
with optimized and stripped build.

upstream:
12588   ./build/qemu-system-s390x
83992   ./build/qemu-system-x86_64
31884   ./build/qemu-system-aarch64
upstream + this series:
12644   ./build/qemu-system-s390x (+56kB, +0.004%)
84076   ./build/qemu-system-x86_64 (+84kB, +0.001%)
31944   ./build/qemu-system-aarch64 (+60kB, +0.001%)

Feedback
========

The goal of this series is to be spark a conversation around following topics:

- Would you be open to such an approach? (expose all code, and restrict commands
  registered at runtime only for specific targets)

- Are there unexpected consequences for libvirt or other consumers to expose
  more definitions than what we have now?

- Would you recommend another approach instead? I experimented with having per
  target generated files, but we still need to expose quite a lot in headers, so
  my opinion is that it's much more complicated for zero benefit. As well, the
  code size impact is more than negligible, so the simpler, the better.

Feel free to add anyone I could have missed in CC.

Regards,
Pierrick

Pierrick Bouvier (3):
  qapi: add weak stubs for target specific commands
  qapi: always expose TARGET_* or CONFIG_KVM code
  qapi: make all generated files common

 qapi/commands-weak-stubs.c | 38 ++++++++++++++++++++++++++++++++++++++
 qapi/meson.build           |  5 ++++-
 scripts/qapi/commands.py   |  4 ++++
 scripts/qapi/common.py     |  4 +++-
 4 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 qapi/commands-weak-stubs.c

-- 
2.39.5


