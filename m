Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D7F1C35FFF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Mar 2025 11:25:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvaVH-0003v3-Js; Fri, 21 Mar 2025 07:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvaVF-0003u7-H7
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:25:29 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tvaVD-0004O7-HN
 for qemu-devel@nongnu.org; Fri, 21 Mar 2025 07:25:29 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso15480415e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Mar 2025 04:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742556326; x=1743161126; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4jBi2XfHUS12bu8iuavnXsaJxhHBfQaoWbhQNC0jHPQ=;
 b=m27iFHDSftRvb4HUH3B89chhhRnI8SVvbEg+DqSjKRC684mGL6+XTJ6FeNgq9a3pMd
 Jo+2ATJ/6A5pJdsXqaHaeeNN5mfX2VV0t8JLRgG+tNz5WqX3MBfrIKsUdCiXXHdPhZl8
 5hA9tAFAaQXpzgoWI/xqLBo3DyTHXPARM/orT9P4/yKWGwl7mwBZUfKSQn1Jc9WzBke+
 dYnZj7gt4Zmb8bPR40weMRofreeVbS7M4Od55ab9HQBvQzMwoB6QPnjL0sxzZCzCV6Mf
 o8biueTM9ztUxZzSyPibUUj4qnERJ7yT5hFw8CKziykkxRMVd8VEDXEumyfweVtjMOKz
 86EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742556326; x=1743161126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4jBi2XfHUS12bu8iuavnXsaJxhHBfQaoWbhQNC0jHPQ=;
 b=BLOPeQD5JOl49Uw/T/ETRjMxIZYl+0tTyYWiRZ1QY/OdwTUQpLi5hJPVKxEx5+iPD5
 EEv03ZfqXRlIL9Jm1jjaIYnAd0SPTHijHb5jiKJWy2N/vVptciRsA8L84Hpxxr/t4gzK
 yb5OthRnwDlUT4HaCZwF0NwB0n2lcwmRKwXL682juRA5+f+PJEQiA6rFRQR4QgbrmFEl
 cMCeyLqq2Z2sEIAUNQd8Bve9a3rV+2E0IPW9R/U9WBZvkBRuwL6K2HRyiT/5wo9a2T0h
 AEqYgI75N8cf5nCOsz5VTmpgLkY9QubMdHLi7hUyY4/PhMK6z2QDGnCZGinS3T0FASZb
 y6Jg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnMBA566lO4wcgKJ9H0zQAG86mi7SASKhlehhsB386POnteBjTVmGJWw7Qit5WPPZV2OVa0hsoO2r8@nongnu.org
X-Gm-Message-State: AOJu0YzBrX6FS5q82g0OWJ8vOzGyx2x+K0jE+q7kXcL3b6B15TIFRGHu
 zjSf3Zu4uZukxOZXyZAcOX72vsDtpc4Eya9QMAUpoO3FYS7+dAh5e/xhbQwkPBM=
X-Gm-Gg: ASbGncss3UPnqcfg8jKMZp/SExqtzJbfHKQ5dT9hdzbgg8wto4/+/o63kh6BTyNlGPt
 Wq6M2UHwat+YOZqFgw0RirjE+t6lO+2hVKtympwceGwwH5Uiz+FKydZvAvP/xcK3HgBPZU5rBHP
 U2m4xRSogJTSxRzr1tWuG8trQpqxrUuhlfs4lP35ABgW2YlIcX1Fx0K3GGU2DOqWse8CyHzql5X
 rukrjm3usEMNVD5prCDwJYgiDcB6voY5YJG5PrKQW2/B04vYPLbltbM+y0xfJngi1HfGxDiMf5/
 N56IrppfY3oUNaLIVHG3h6N6mLojOVJyZhCfXYFpJlbBLZ74OdM=
X-Google-Smtp-Source: AGHT+IEfLLQk0tHm5HjQf+E9C33h5KD8z1CsdQwClauizGriyI2wEVtbUjIavsvXR1hwgt0F/Mrzvg==
X-Received: by 2002:a05:600c:4f55:b0:439:9b2a:1b2f with SMTP id
 5b1f17b1804b1-43d568cdf1bmr3559105e9.3.1742556325692; 
 Fri, 21 Mar 2025 04:25:25 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9e6767sm2132614f8f.66.2025.03.21.04.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 04:25:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH v2 0/3] rust: Fix PL011State size mismatch assert
Date: Fri, 21 Mar 2025 11:25:20 +0000
Message-ID: <20250321112523.1774131-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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


Summary: v2 of fixing an assert due to mismatch of the
PL011 state struct size between the Rust and C impls.

Changes v1->v2:
 * in patch 3, adjust 'use' statements to maintain alpha order and to
   prefer 'size_of' and 'qemu_api::bindings::PL011State' over
   'mem::size_of' and 'bindings::PL011State'.

All patches are reviewed.

NOTE: I won't be around to do a v3 of this series next week,
I'm afraid, so if it needs any further tweaks I'd appreciate
if somebody else could pick it up and make those, since this is
a bug we need to fix for 10.0.


More detailed info, same as v1 cover letter, below:

We have some users of the PL011 struct which embed it directly into
their own state structs. This means that the Rust version of the
device must have a state struct that is the same size or smaller
than the C struct.

In commit 9b642097d6b7 ("rust: pl011: switch to safe chardev operation")
the Rust PL011 state struct changed from having a bindings::CharBackend
to a chardev::CharBackend, which made it grow larger than the C
version. This results in an assertion at startup when QEMU was
built with Rust enabled:

 $ qemu-system-arm -M raspi2b -display none
 ERROR:../../qom/object.c:562:object_initialize_with_type: assertion
 failed: (size >= type->instance_size)

This series fixes that by the simple expedient of adding
a padding field to the end of the C struct to ensure that
it's big enough to also fit the Rust version of the device.

It also moves the failure from runtime to compiletime,
by adding a Rust compile-time assert that it hasn't made
the state bigger than the C one, so if we do this again
it should be caught before it gets into git. (We don't
need to do the same thing for the HPET device, because there
the HPETState is a private implementation detail of the C
code, not exposed to its users.)

thanks
-- PMM

Paolo Bonzini (1):
  rust: assertions: add static_assert

Peter Maydell (2):
  hw/char/pl011: Pad PL011State struct to same size as Rust impl
  rust: pl011: Check size of state struct at compile time

 include/hw/char/pl011.h          |  5 +++++
 rust/wrapper.h                   |  1 +
 rust/hw/char/pl011/src/device.rs |  9 ++++++++-
 rust/qemu-api/src/assertions.rs  | 22 ++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

-- 
2.43.0


