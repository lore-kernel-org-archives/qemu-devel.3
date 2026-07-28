Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D3BC531F9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:43:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wofGY-00084Y-7p; Tue, 28 Jul 2026 06:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGW-00083y-Kl
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:28 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wofGU-0008GL-Tv
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 06:42:28 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-69fe3cd5ee6so3938041a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 03:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785235345; x=1785840145; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yk9jkNWBB7hh4KiT+8xifCnuI6JCLbuRT7I1bT75+zE=;
 b=Q0WVGb/XQWOo+vu7rRcP+EtiCwUpgpQ+i7MwW3XAA793J+t+CH5LkpIs6T0gx/celg
 FMqiDsY+YGH2f5vzg+EswR0nI0SiV83NUzrpyLuaOP4Ypr3WLxJnNPl+CJJ7yk4SCRPR
 6kt3OvHFCA1Ja45Dgvrq3nkUEt4nck4oPV2GUYW2uLRVZBDoXhgIJUeixVsFj1afsY4P
 fgbgaqX17D6OoxBaSNloWgaUIjWQOVTs3wSddYNDIdBf/EQ6gQY8uiC0eyZL/IkJ0UFN
 2W/bc8EaFKhO6Wb3zDKm5vJCpCthXECBhD+gydhm4T3jg81aQX6zPYoi6rv2vj8cQ5tv
 MF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785235345; x=1785840145;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yk9jkNWBB7hh4KiT+8xifCnuI6JCLbuRT7I1bT75+zE=;
 b=bUBQN2wFFnYoNle15UHC+ddObC+Q7a2XDX8eVVzqjtlt3SBTrqllEs06N2TR/20SFd
 TBR2KL80Cu5IL/DbEWXCqPbwydcHpInb9GWJ3kkxwsqoejdN0+09EluBatbOK5gwy+Ym
 ddpTnSzXxQWgDZ89esIJ4iyXucKmQ0uE9oxnby/q2aDhoQSX2eamSU35h+WZjtW3RZPw
 8mDQC4fdkE9uujeVOOwwoMlvtBg9KtHf0d5IAxXGL2v7/C6FS2vSEUFBZjWzV09UPPYS
 wouqiiv3XWrbSd+OhfecaEO2D2BlALG9ITqX7nHwuwxwTg/IGHVvl1lFxcMBzXleVcfX
 YN8Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro3c8/LUoOWBLv67HZkFrrqKkiqrT8JbZ1Uq+MHjPoynST7uLEYd9S0h+1AIyhL/ZZ/rDZ2nE2xnreA@nongnu.org
X-Gm-Message-State: AOJu0YzBqQH9dO6OmD9bRfAhYrUTzLHoq50Zxr/QL81Y+y2qF+ellcCZ
 16iBtg3AEc8Y81ONMsJhkxkJGrDBw5DCwbou0f3RApWe5Md/Q0Oru29zC3txgQ5qRU8=
X-Gm-Gg: AR+sD11fur4Z9vhY2bempyySEapUHtlVgfYYVKilZ9H0e2Uvc+zHH0tms/B6qIx38X9
 9q+GEI1Rpj2JBDYsDw8uw4FC+BYQunPsT9a0mgEVJYp/gLzHHqw5jytGNZYAye2zK5xp+pqSbiP
 Z2c7ckhTrmmz5l5A4djMFdE327b7SUK76yqwH9Nx1qFr5N7VFnHtxyy/C7e6bQeJ87nuVAeNX7C
 EDcmEoCK5avWfAvcSh5eQ1kTQAEmAlRb5GISYcdxoW2uAk/cizmfnNbAOD1Oint5/HURaVNyxAk
 7WmZBOPpa3O3Ff+Ri04oJDotgxXqlr+fM4Lr7B6sw3fQvEUsWsrUwHdp1sZLLE3LMsn0HAdYlw0
 /ENcLNLD48UMpa9lIY5392w14QyPwHybtk0qI/RjdIEtQDaCrwqMQtLJhdfEYknE6mg==
X-Received: by 2002:a17:907:9617:b0:c16:710a:53d with SMTP id
 a640c23a62f3a-c1f7248b10amr97955966b.61.1785235344603; 
 Tue, 28 Jul 2026 03:42:24 -0700 (PDT)
Received: from athena ([2a06:5b06:b600:300:45be:7876:b62b:ca4])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1c32c90b4dsm745682266b.35.2026.07.28.03.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:42:23 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Thomas Huth <thuth@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/9] parallels: fix reachable assertion and related
 bounds-checking gaps
Date: Tue, 28 Jul 2026 12:42:12 +0200
Message-ID: <20260728104221.3981592-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=den@openvz.org; helo=mail-ed1-x531.google.com
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

The following changes since commit 6333226c2abb72f31648c251624c56e70993d625:

  Merge tag 'pull-9p-20260725' of https://github.com/cschoenebeck/qemu into staging (2026-07-26 08:30:07 -0400)

are available in the Git repository at:

  https://gitlab.com/dlunev/qemu.git tags/pull-parallels-2026-07-22

for you to fetch changes up to 2a1c31578eb96f829f3234fe9da1abecbb11aa1e:

  MAINTAINERS: update parallels tree location (2026-07-27 14:42:24 +0200)

----------------------------------------------------------------
Parallels block driver patches

- fix a reachable assert()/process abort on a crafted image with an
  inconsistent BAT vs. advertised disk size (GitLab #3804)
- fix related integer overflows capping the format's usable catalog
  size below its documented maximum
- reject BAT entries pointing outside the data area in either
  direction
- harden the dirty-bitmap extension loader against a reachable
  abort and an unsafe allocator

This is my first pull request signed with this key:

  RSA rsa4096/0BAEAA87D3020ADC1150E51F5E0771B6CB666CAB
  Denis V. Lunev <den@openvz.org>

Public key: https://keys.openpgp.org/vks/v1/by-fingerprint/0BAEAA87D3020ADC1150E51F5E0771B6CB666CAB

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Thomas Huth <thuth@redhat.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>

----------------------------------------------------------------
Denis V. Lunev (9):
  parallels: fix integer overflow in header size calculation
  parallels: read header/BAT table in bounded chunks
  parallels: fix bat_entries overflow in image creation
  parallels: reject BAT entries pointing outside backed storage
  parallels: validate bitmap L1 table size before allocating it
  parallels: skip loading a genuinely empty bitmap L1 table
  parallels: avoid fatal abort on large bitmap L1 table
  parallels: validate BAT capacity against advertised disk size
  MAINTAINERS: update parallels tree location

 MAINTAINERS                                   |   2 +-
 block/parallels-ext.c                         |  52 +++++----
 block/parallels.c                             |  74 ++++++++++---
 tests/qemu-iotests/212                        |   8 +-
 tests/qemu-iotests/212.out                    |  10 +-
 tests/qemu-iotests/tests/parallels-checks     | 102 ++++++++++++++++++
 tests/qemu-iotests/tests/parallels-checks.out |  59 ++++++++++
 7 files changed, 270 insertions(+), 37 deletions(-)

-- 
2.53.0


