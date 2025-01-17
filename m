Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57648C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYpku-0004eq-DT; Fri, 17 Jan 2025 12:03:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkh-0004PP-Rt
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:26 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYpkd-0003CX-Sp
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:03:21 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso44323175ad.3
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737133395; x=1737738195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/ag5zYWG1yf/yk3aZcuPCDB7lEG9uvv++z3XXlUIbnE=;
 b=Kg0NdCqimFn3ylTqZKKtrjW5XmDQJL8L9AO/W6zX7okUgiDMhiiyMiKANwxi9c7qug
 75QL9neGVCncTXIwdJMWN5gR9A6zGbxx42dtQNkN33XnQce+82Ri4bR8UP+l5uXL6LE8
 o6BC0ilQLAwtCoZ+0P4ANAihJCNA4zLFHvE5uIzvFIDtP9BxMZG+pbVWqzVZLnAZ7N5s
 MYWrLLuhO4L7FXK4/lLh8YtGMe2XZIBuaBzbUif13u2nrOvMPmMusg0DJzsZVNq6SmBG
 xsZPKWYmLztWk5JbTThN7eNkMOTKBx++AYML3N0Hb0DJayRHlrYcL/VqclvyELLJ4RFh
 ROgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737133395; x=1737738195;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/ag5zYWG1yf/yk3aZcuPCDB7lEG9uvv++z3XXlUIbnE=;
 b=P2535kTn8r17izb30XLze5CdANzv1ReNHZaXeWWMHtFAZyd6+uRYWk7UxonhOCb818
 ZcjB7DTVkpL+/8B2VhvNmPRC8+yUkHyok9LXRiTNswGYgnow+MpSeWCWYV+LHkyQ+CGx
 q0zmNswlL3EFpqudMukIVToO+s/j6M5RUVHrThVUdOLdUdCs8BQdq/mEsOeSRwlp0NDM
 jAfP2vD5fnul3dBjBzWemjuh6rhUFDzkxVTy0S8ReGAJvo09Qy2+qjOER7By0i+hPESi
 5x69KhpblQUC8e6wfOOX3uwbMGGbWB6wUFUx3S6H/9q87FHQR0An/O26NsCwHt3K/8Ry
 iVpQ==
X-Gm-Message-State: AOJu0YzyuCtXzMrdAQO8YUwReBrVVDl3gbkUs5Rp6H3MY7NuR5tUUthB
 FKPRG2vOIgxCiiJHtWWISqJg0f0y5TCl00WZhlgnFylbzEc5/chBlpM0tQ==
X-Gm-Gg: ASbGncslw4xi3o2S2aVVj2Rzd4K7ae808pNO7o/giGUqHGeXAPvh3/31UDkleI4psXV
 9Vzzm6je9WU72T+nFEFBqoNHnccU5Mu33sN6t5RrCg46HCHjHU5UT3/dL3aAYlhB22wqxhcesgb
 nVAfIVjCj+skc6WUf947dE5rrofSgL7WDPdeSj/OQq+P/Zc1oGnGkwYhNc/9cBHwR9hi7Z3JHA+
 ct9QHhp239h6NJcjcD4mHlzj7PLHS2HJJ647yTixcKZxI9LzDq1AJUdSKvXAEKUJ9hcFh6KMunk
 PDafP6mlTjTO9RM=
X-Google-Smtp-Source: AGHT+IFZPjaIug7BNGrVWcCb54mZdhdOiN4GFsxETFbbo99S+QRL0yQ2636kjpzVY+U1o/HH4W+WsA==
X-Received: by 2002:a17:902:ce0c:b0:21c:e34:c8c3 with SMTP id
 d9443c01a7336-21c35540560mr64687745ad.24.1737133395127; 
 Fri, 17 Jan 2025 09:03:15 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2cea0b91sm18249435ad.49.2025.01.17.09.03.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:03:14 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 0/9] hw/e1000e|igb: interrupts and qtests fixes
Date: Sat, 18 Jan 2025 03:02:56 +1000
Message-ID: <20250117170306.403075-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x632.google.com
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

This is a re-work of the patch series here

https://lore.kernel.org/qemu-devel/20250115150112.346497-1-npiggin@gmail.com/

Patch 1 is taken from patch 4 there, and adjusted with Odaki san's
suggestion to clear the msix pending bit with the PBACLR register.
That makes all the other patches unnecessary, which is great. This
patch should be good by itself.

However after doing more testing, I found interrupt throttling in
the devices was raising supurious interrupts and went too far down
that rabbit hole. Consider patches 2-9 to be RFC to address some of
these issues and not required for patch 1.

Thanks,
Nick

Nicholas Piggin (9):
  qtest/e1000e|igb: Clear interrupt-cause and msix pending bits after
    irq
  net/e1000e: Permit disabling interrupt throttling
  qtest/e1000e|igb: assert irqs are clear before triggering an irq
  net/igb: Fix interrupt throttling interval calculation
  net/igb: Fix EITR LLI and counter fields
  net/e1000e|igb: Fix interrupt throttling logic
  qtest/e1000e|igb: Test interrupt throttling in multiple_transfers test
  net/e1000e: Fix xITR minimum value
  hw/net/e1000e|igb: Remove xitr_guest_value logic

 hw/net/igb_core.h           |   2 -
 hw/net/igb_regs.h           |  11 +++-
 tests/qtest/libqos/e1000e.h |   1 +
 hw/net/e1000e_core.c        | 107 ++++++++++++++++++++++++++----------
 hw/net/igb.c                |   2 +-
 hw/net/igb_core.c           |  81 +++++++++++++++++++++------
 tests/qtest/e1000e-test.c   |  19 ++++++-
 tests/qtest/igb-test.c      |  18 ++++++
 tests/qtest/libqos/e1000e.c |   9 ++-
 9 files changed, 197 insertions(+), 53 deletions(-)

-- 
2.45.2


