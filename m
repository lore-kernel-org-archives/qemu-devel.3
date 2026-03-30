Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C141061B00
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:32:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Deq-0001Aj-RX; Mon, 30 Mar 2026 10:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DeO-00014y-TU
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:31:33 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7DeK-0002cl-8e
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:31:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-482f454be5bso53022255e9.0
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774881085; x=1775485885; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qTjsNxfP1bTzgwndOT7LQzFk5ouNPuqMxWEm+bT+blw=;
 b=J8ag3eHlsKdg2Q6rQy1WswW/bfpux8Kt/Vki7ZW9Jq4ruUFmLPEjzeRftmwB2K9zfF
 v//W6l/2BBRBDQ5voPmj7rxypWlOEs5fE+haJ4bgfG/EV5kVD6ufTUGDmwY5aENFwtPe
 nTRTA75FjXfvC0j3EnY0AEg5RenRIryVzn2y/DlgKM7IgREAtH48LD3vHW6THVDUIF6T
 ObzA9Xu8ic+eNcydGHPr0EkxS8AyHwYbsFWtaVjuVzFKfdMrT27o3SmJ8EJYA5+5H3Td
 V/Lt2F68hJa6+L5FozmkedsUxecVNEs6PITmmiIGDlptgsMExABInZSdpk5usuFj0b7C
 O5/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774881085; x=1775485885;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qTjsNxfP1bTzgwndOT7LQzFk5ouNPuqMxWEm+bT+blw=;
 b=bdUuL5k70+seLNhyq1TAmWh6FHPzuP22Bs7aw75wilOTc1Mo4rhbEkNL1Av+B30QDu
 y2urzFvEDEkpxwV9dkKosQ8WbAUwV3fTd9vyXGIjoIqe4TW2ASSXZVsV3raOLvpV2YPv
 Poxs+ivz/EwW5uqAj36jt/OiTS5eGulYg8+Q3zrb50pfznAtAne8YpzbZUZc8BrtrslR
 BF4EvQsoVBeqA4CnGf4RwEOEONQNbuRb06kj1NXDKRo5+sn1zPS2OGjtsFS/tjASUZ8O
 TyEKfeQlb/gn9GUfXeKmlXcXJSISjTJoHwwmN4FwdTFmocnzThkFx/ElxHfy+m406j7x
 JDmA==
X-Gm-Message-State: AOJu0YzeMrFVoc7m4EP8fFB9qG7GhLosu6lqLnUuRDXcMRuvwT8ir7gz
 Q2GIvj1jxIxBipsxp5MuO8aM4yXTM1MJYfrUEZc97uUkqWUGHenxB5LHPAIQvrXA9ZVThDIyhca
 wOguhvRs=
X-Gm-Gg: ATEYQzwQu5lQqIPjaANVxFBiSRFGGOGR/50wLQwaH9fW1LJVf4qt/UkWXAN9Gsj07Mf
 1sjgznggCHfdYEbSlcERkBVJHOaGshSteVQDK/Ss0WEWxnC7tkNbgE5GjuREUxTCqGicluJdMV7
 8ZQk+5cT2caPLrWEh5L9DvPwEDZAbI5LlogYIkD4j+KjWT69p7fPrO626Iaw4yQyU9Hi6WYpZ/A
 UANfGZmoQESmFhbGZrsEgKTV053L5VhJAeY1+ka7yd+a2JC5XMIbF5KyuoArpjxpGiwz3LaCdwb
 eiGKi4b5kks1yBmzObuRBHhhZaxPnuNO+aK2uK8ZFCsAjlXiB7PkjX2S9wZe/omm+9HM9NUh0Rc
 ZnL53f9wDSkLfOtK28BiQ42iTJGMFAVnscd/267VqWQXr+l4UTcdIMjX0qhBlB8vsyNcs3PVGIk
 5nbT1rsm9/Ua0NdL3KZ//f0oq4/n1didqYjBQQGYjKo9K1rD9UcHzejcnFUwA1dxd8Z2ml3LnhH
 HQFqCrOV14w03Y/0gGLeiBjZ8l6ecI=
X-Received: by 2002:a05:600c:8289:b0:47e:e59c:67c5 with SMTP id
 5b1f17b1804b1-487290de830mr193724365e9.8.1774881085354; 
 Mon, 30 Mar 2026 07:31:25 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722d49c18sm279767145e9.14.2026.03.30.07.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Mar 2026 07:31:24 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/2] linux-user: Fix incorrect sign-extension of guest
 addresses
Date: Mon, 30 Mar 2026 15:31:21 +0100
Message-ID: <20260330143123.1685142-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In commit 7804c84a ("include/user: Use vaddr in guest-host.h") we
changed all the functions in guest-host.h that took or returned their
guest address argument in type abi_ptr to instead use vaddr.

This introduced regressions for the case of a 32-bit guest and an
address above 2GB for the common situation where the address is a
syscall argument stored in a variable of type 'abi_long'.  With
abi_ptr (which will be an unsigned 32-bit type for 32-bit guests),
the address is cast to unsigned 32-bit, and then zero-extended to
64-bits in g2h_untagged_vaddr().  With the switch to vaddr (which is
always a 64-bit unsigned type), the guest address will instead be
sign-extended to 64 bits, which gives the wrong answer.

This is https://gitlab.com/qemu-project/qemu/-/work_items/3333

There are multiple ways we could fix this, and I wasn't really
very enthusiastic about any of the ways I thought of:

 * we could require all the code that has guest addresses in
   abi_long variables to carefully make sure it casts them
   to abi_ptr before calling any of the relevant functions.
   That would be making changes to quite a lot of code, and
   it feels somewhat bug-prone because the "obvious" way to
   write code (..."g2h(arg1)"...) is the wrong way.

 * we could try to abstract away direct calls to these functions
   (as a comment in the header says, we likely need to do that
   at some point if we ever want to have usermode softmmu), as
   we already do somewhat with the lock_user() and unlock_user()
   primitives. But that would be a huge upheaval not suitable
   for fixing a regression.

 * we could make the "normal" versions of these functions the
   same as they've traditionally been in QEMU, and provide
   variants specifically using vaddr for the small amount of
   code that needs them and is being compiled only once.
   This is at least minimally invasive and fairly obviously
   reviewable for correctness, but having two versions of each
   function is a bit ugly.

In this patchset I've opted for the last of these possibilities.
If anybody has a better idea I didn't think of, feel free to
suggest it :-)

Patch 1 in this series isn't a requirement for patch 2;
but cutting down the number of places where we include the
header helped make me more confident that I wasn't missing
any uses.

thanks
-- PMM

Peter Maydell (2):
  include: Don't include guest-host.h in cpu-ldst.h
  include/user/guest-host.h: Provide g2h etc for both abi_ptr and vaddr

 accel/tcg/user-exec.c        | 26 +++++++--------
 bsd-user/qemu.h              |  1 +
 include/accel/tcg/cpu-ldst.h |  4 ---
 include/user/guest-host.h    | 62 ++++++++++++++++++++++++++++++++----
 linux-user/qemu.h            |  1 +
 5 files changed, 71 insertions(+), 23 deletions(-)

-- 
2.43.0


