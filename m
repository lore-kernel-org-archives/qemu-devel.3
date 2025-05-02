Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BCEC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:17:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgts-0003mw-Ea; Thu, 01 May 2025 23:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgtq-0003me-Ac
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:18 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1uAgto-0003Mb-Fd
 for qemu-devel@nongnu.org; Thu, 01 May 2025 23:17:18 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-7370a2d1981so1415760b3a.2
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 20:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155835; x=1746760635; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OnIlsuN4O7XTcvAMwTRCN5XKFLcv4EJ2BiQJ59Gikn0=;
 b=EhtnKiZgzQsLfOVqIbbfBF17n0t1IZKkTRw/P8fKRd/TW7z7vvsvyeXbmXcun+cjYF
 YfCjyEAiEtIm8cVa6jrY76JZ+bxUvDUKmXEOkPTKiShtG5+6l8dTMZzmYAbPUi6WzoY/
 Ls8UzbAA1LltlHu/pkMi1TfU/dxXARIi0eyCVpIBRnQTawX3hHWi3iwRGEK6VGiROhJN
 wEdBdAJVgQYy3UHq1Z0vFN422akWDPgRHWoMmx63F+VMO4Dd3Vo2+K/9H39JrvCtnBlw
 MRAbyNsr2Zms2oAQ+SyjwEz7cfzuZVWU1c5MQDg19PzZIuvdVyMKqYl3eUFn0bwES40x
 JM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155835; x=1746760635;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OnIlsuN4O7XTcvAMwTRCN5XKFLcv4EJ2BiQJ59Gikn0=;
 b=mxKD5Tn3VSkdmJakW4PpCxObP2E634YfwKkaGY/Xyle53rwUif4S9Hk+8EPGHjTSyC
 cm6J3KZxou4fMiYG1yUC3i3lunCEFeTH7AoQZWYWKOS/rp0UFnrrfsWGeOjaHk10RGsR
 ReD4DvwwIzke4eToxuSrub2XeVrMXLbQcxR0C7RCLPxQQIn9uLQ+KYuTjF00MhHU7+xa
 h4KwBpPvkFL3KHLoNP3R7By9PavYqHs3VffMVM0cwsFRL9LWu8oHevEysQxh4AKeWwM9
 l6+6zskLfix3n20tSjMMPXBnExU1u4Xwy3oJFGZQvjHEO48ADkMsxlQP1PA7JiqutSKO
 DwAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKvrjunBCs7whLNtF5CA6ySip5oYuP+rEJ2xYqMm/Uz9sEHy2gNT7b7SF/Ow8lDokhkKTBcHIj6leL@nongnu.org
X-Gm-Message-State: AOJu0YxYAL5atgHh068LytaNyP5kRJQbpP0m8unoEnQ1MBhzFNvlZBjC
 AmmI+Y3HiDZSsU9CwZ9+gGQN9FjqjbRRprtnYUaDfvT36GIR/wrP
X-Gm-Gg: ASbGncvu9Y9+oT1/fr2JS5Ci2l8sXB13Cx1+YdH1/dbvT/PJ59c0BYaQgwV4UVo5ZzH
 +/X8O4L9uY6P8zedB24cZz56BCgKSv/DHoZx4+IU90jsNU1nSSctP5cj7ioE0sFHT88jw2qJUfj
 eJOWIVeI9sMcH6ytTbY86noHIDbCrEvrrdQksI30+9TcaAAuulgchW6//+dspVeftxjbi9ca670
 GeNPUWdwFc6UZRG+UC4HkwBvt0QC/OjIoYrhpeUUxzWb8a2FOAqb46WZze7PkXdS0HJEkdgDJpm
 DFRH+7kR33vlzGTxRmx9M8OBlpIWvfRH754pTpAbwLnq
X-Google-Smtp-Source: AGHT+IFPXdJSo0RL4DB3hllneCaBxxr8QoWyoqNRt53ABCHvQ9YKdCUQM3JOMa6Or1sTNDEhfUP1uA==
X-Received: by 2002:a05:6a00:6ca9:b0:73e:2dc8:94f3 with SMTP id
 d2e1a72fcca58-7405890ad0cmr1743529b3a.1.1746155834998; 
 Thu, 01 May 2025 20:17:14 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058ded48fsm467883b3a.83.2025.05.01.20.17.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:17:14 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 00/12] hw/e1000e|igb: interrupts and qtests fixes
Date: Fri,  2 May 2025 13:16:52 +1000
Message-ID: <20250502031705.100768-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x435.google.com
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

Since v2:
https://lore.kernel.org/qemu-devel/20250411043128.201289-1-npiggin@gmail.com/

Mostly fixed comments from Akihiko Odaki

- e1000e change initial ITR as well as EITR
- Preserve EITR writable bits
- Use SCALE_US constant instead of 1000
- Fix register field definitions to not trample on code from Linux header
- Split the big fixes patch into several pieces

It is difficult to split the big fix into pieces because some of the
bugs are inter-dependent. I think I came up with a way to do it.

Thanks,
Nick

Nicholas Piggin (12):
  qtest/e1000e|igb: Clear interrupt-cause and msix pending bits after
    irq
  net/e1000e: Permit disabling interrupt throttling
  hw/net/e1000e|igb: Remove xitr_guest_value logic
  qtest/e1000e|igb: assert irqs are clear before triggering an irq
  net/igb: Fix interrupt throttling interval calculation
  net/igb: Implement EITR Moderation Counter
  igb: Add a note about re-loading timers breaking deterministic replay
  hw/net/e1000e: Postponed msix interrupt processing should auto-clear
    cause
  hw/net/e1000e: Do not auto-clear cause on postponed msix interrupt
  net/e1000e|igb: Only send delayed msix interrupts that have a cause
  net/e1000e|igb: Fix interrupt throttling rearming
  qtest/e1000e|igb: Test interrupt throttling in multiple_transfers test

 hw/net/igb_regs.h           |   9 +++
 tests/qtest/libqos/e1000e.h |   1 +
 hw/net/e1000e_core.c        | 146 +++++++++++++++++++++++++-----------
 hw/net/igb_core.c           | 109 +++++++++++++++++++++------
 tests/qtest/e1000e-test.c   |  21 +++++-
 tests/qtest/igb-test.c      |  18 +++++
 tests/qtest/libqos/e1000e.c |   9 ++-
 7 files changed, 246 insertions(+), 67 deletions(-)

-- 
2.47.1


