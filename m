Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D52C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:21:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2Yr-0000kN-D3; Sat, 08 Jun 2024 16:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sG2Yp-0000jX-4X
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:21:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sG2Ym-0006To-K8
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:21:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-354be94c874so2441802f8f.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717878066; x=1718482866;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=B9zXy62U/i/GPhaOCkWS7JnbtEA8aZVV+oCWEQAna0s=;
 b=agMNl9aVnjDdLdLdZRrmb9wBbzoaxy3b/SVdcoxYZbxLrj+C0a++uu6jQbkcn8tU+0
 pihRZjysMUSFY1/bhEo7a+vZzu335kt3KILDRxID6FSDbLzHsruggwrxG/2ZRPZfxnFv
 jbi9DVDy9YBlT+sKdf2BgQP0nmtAzpnmmzDyHzJE3hjn/2QPHih+xRj4AmF7THfBMZk+
 lPhy1yYP1UV/Jwqnrr5wJUTuAeW9NK76GXLjrohgkDNrkwmT+79RGqhlbE+ypDxp0Gtk
 sqoxXyJ7MtMkjoH0TRehnwPrytRm0G0d62/WgOuglQ2Ao5NMUh6qWTZ/CSAf1qQALkgN
 3WqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717878066; x=1718482866;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B9zXy62U/i/GPhaOCkWS7JnbtEA8aZVV+oCWEQAna0s=;
 b=mk9UKBLfKIsz55wRY+PWs0qjHCca+v1nMO+tklhonbLQJ/KS6YRYALaIkEG6sciLNd
 zniivdm/SAb0o0JkV89MYms6vkBF7o+vOla94OTTc4q+w4XBfxQTncc+mzLZ5dQIR2av
 HnCT2njeuMSSiNEdjKRlmLgI6/sRCFkj5bI+vWpYNUNeub0+15F19N7pvtuUDY8UxAU7
 FvIFbfpYle3dOLcbBNgkaoUPWSZHT+bOTR61o5N+SR3tOyjQspcsrErYIDaLeKGK6V67
 8T6zTt7fWN6vVF4BXBW9tTirko8IsvMAE4GDNqUE1IKZIdIuQPas73uhHfR6Xwhtcudo
 1Tbw==
X-Gm-Message-State: AOJu0YxryEkKPDKvjdNeVOHnjxbukLUt3Pu1UIdJ6oHZi4W2zJUZZPFN
 iM2rKwCMoqxABTsvt8jhCfrLD4zXLIAA096YOP+KMvbzzGmmOkTEMksYr0ORG8/KsUFnN5zxg5o
 =
X-Google-Smtp-Source: AGHT+IFEahbfl52L063ZyCGRCyQYNUY0UT8wdBCLbwfdhANMExSBEYTgxNNFhSIna/3xQSUgRKNCoQ==
X-Received: by 2002:a5d:5f4a:0:b0:35d:be9a:3e6a with SMTP id
 ffacd0b85a97d-35efedca59fmr6347303f8f.53.1717878065942; 
 Sat, 08 Jun 2024 13:21:05 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-17.customer.bnet.at.
 [89.104.8.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f0ccc5f03sm3803845f8f.88.2024.06.08.13.21.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Jun 2024 13:21:05 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, philmd@linaro.org, akihiko.odaki@daynix.com,
 marcandre.lureau@redhat.com, Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 0/3] Mouse cursor improvements on macOS and VNC
Date: Sat,  8 Jun 2024 22:20:42 +0200
Message-Id: <20240608202045.2815-1-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::431;
 envelope-from=phil@philjordan.eu; helo=mail-wr1-x431.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

This series of loosely related changes provides some minor improvements
in mouse cursor usability.

 1. This one-liner changes alpha downsampling when using a UI frontend
    which does not support alpha-blended mouse cursors. Previously,
    any pixel with an alpha value other than 255 was treated as fully
    transparent in this context. This looks pretty bad when the guest
    OS uses anti-aliased cursors. (e.g. macOS) This occurs with some
    VNC clients, for example.
 2. This change has nothing to do with cursors: there are two
    functionally identical implementations of an int_clamp() inline
    function in the Qemu codebase. This unifies them in the shared
    cutils.h header, as I'm about to use it in a third location in
    patch number 3.
 3. This sizeable patch implements cursor support in the (macOS) Cocoa
    UI frontend. This fixes the issue of no mouse pointer showing up
    when using virtio-vga on a macOS host, for example.
    It unfortunately introduces some complexity to the mouse movement
    event handling when using a relative pointing device in the guest,
    as teleporting the cursor on the host offsets the next mouse event
    delta by a corresponding amount. We therefore need to track this
    offset and counteract it when processing the event. For details,
    see the commit message and inline comments.

This work was sponsored by Sauce Labs Inc.

Phil Dennis-Jordan (3):
  Cursor: 8 -> 1 bit alpha downsampling improvement
  hw: Moves int_clamp() implementations to header
  ui/cocoa: Adds support for mouse cursors

 hw/input/hid.c        |  12 +--
 hw/usb/dev-wacom.c    |  11 +--
 include/qemu/cutils.h |  11 +++
 ui/cocoa.m            | 167 +++++++++++++++++++++++++++++++++++++++++-
 ui/cursor.c           |   2 +-
 ui/trace-events       |   7 ++
 6 files changed, 185 insertions(+), 25 deletions(-)

-- 
2.36.1


