Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1767CCAC5A8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 11:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzD2n-0001GA-5R; Thu, 18 Sep 2025 07:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzD2Y-0001AV-Cs
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:43:10 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzD2V-0003FV-O6
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:43:05 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-45dd513f4ecso5866375e9.3
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 04:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758195782; x=1758800582; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NRw7bN2IZ4fqIjs30E+Zw0/hpYU18gqWI4OvfZ3tjPI=;
 b=NIlqK3Mye/lI6HkS0odQpG6ud7FWNGzX4jYeJ/2YxEt1ZPlVYawGJ/gKAYAHUczpsh
 gosOBlevFRXOp1cD4p11PGtWvfottsE2JSp6AIv/DTQQIlIl9HnoJ65aagS78Pa3vVcC
 mkhFw0XgjQPh7S0BESsA6rXIDo0Qp/p314MtR7kzfnAMfBYCOiYRXtVs1DoN0raxobAi
 C9v423dOsW4IbRTqhtE3svrqvVEoQcxw83KFH7ng3Ote7XtbWa1h/X9I7MTCUlLu/foV
 flGJDP6VrTCIG22aIflzfrmsIKTeiLI13+SUpg+9UGEASm0kbNFtoI8SJ8DkjWhyLgSj
 jvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758195782; x=1758800582;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NRw7bN2IZ4fqIjs30E+Zw0/hpYU18gqWI4OvfZ3tjPI=;
 b=OTlSE+cNGL8c9+aPZKBeOXwHGS9/C4W7p7nymiwsQHVeeFGcN8aXg9/Vn+Mhl1853I
 Yb91P4bAYbZxRJjBvAnLWOxA4NpNna9eLraqpc52cP7yzVbE5X6pDMRl4VJRmOkMOzvZ
 h8GAWQylnhA+hHlO68TpBhD9il3oTKTz4qfVGdiKD1us3fhixt4X+qJlQY/b9PYUw83u
 nefN0Cz0/ZlPbVfhkaagUTu7cGRD801/5Mq6rhvtjUjEMwuBnWW3vB0voaiAX0qNxteF
 TqnuA3pb6CzmW68CmYpGt0YAycEJYguaWAgv/SWenLXgN673vAFzEyzTPZkot/miCpFF
 M6Mg==
X-Gm-Message-State: AOJu0YyPcksh3L1eNzQqCbSy7k/+60j36aukTn7XXtQNUVjlNsFRhgse
 mNTWJhe93VdP7sEKrblUVqGWOM7gm28dTiqFRBrSI5P6gLrxul9X+qsnLnsuZtBxdSWgseHy2ri
 xZWWx
X-Gm-Gg: ASbGncsVoThxKIw3jNJdiHdUfBw1pjhy6YNvp0LEcywu7F8eD1AaiA7hSwqZptiAvYL
 gvhRYEeEVGjywpYAL4EDELU4MH+FzOe11JSFADuc8/0TCzV49fORcUacPnbvOoiSRKrwNEbxsPY
 +ph6uMrAU158AtbMelxPXnPxXzJVLVF1gBN504qWewwJYY1i8eEHB40dU58ENCKCkgCdjeUeKUO
 hnlMlKGo291XZLcFrbypJVxFHANkzsBff4Yksf68Y9+s2v4bvCsx4Ll2VDpzVoFCRwgyYuW3azS
 9Jet/bZ3vbY199ROi/CK4Dig7hS0pFMvkVPTm3D2iUZtkMNGD/+ubngou4kDcmZdTE42Q+wboHs
 KAEy+6zlXOP5HG5lvOyaiXNjQ2/O2Bqwdrs0J3hVr2i9L/ySzke9YCXv7aA==
X-Google-Smtp-Source: AGHT+IFhWsXuSb1dh2fC9gwmtayxMoX/oTTFFM33uX9voJxjl1qgPOTwEJuZ9mtqtm07+mM1FNTHlQ==
X-Received: by 2002:a05:600c:3b09:b0:45f:2c39:51af with SMTP id
 5b1f17b1804b1-461fc85bda2mr50700685e9.0.1758195781708; 
 Thu, 18 Sep 2025 04:43:01 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46139122cb5sm76942665e9.8.2025.09.18.04.43.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 04:43:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PATCH 0/2] hw/pci-host: fix use-after-free in hppa pci-host devices
Date: Thu, 18 Sep 2025 12:42:57 +0100
Message-ID: <20250918114259.1802337-1-peter.maydell@linaro.org>
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

This patchset fixes use-after-free bugs which show up if you put
some of the hppa pci-host devices through an "init -> deinit" lifecycle,
as the device-introspect-test does.

The problem in both cases is that we were calling pci_register_root_bus()
in instance_init: we should only call this in realize, as all the
other callers do.

These bugs show up if you run 'make check' with an ASAN enabled
build; they are also likely behind the intermittent segfaults
on s390 that RTH has noticed recently.

thanks
-- PMM

Peter Maydell (2):
  hw/pci-host/dino: Don't call pci_register_root_bus() in init
  hw/pci-host/astro: Don't call pci_regsiter_root_bus() in init

 hw/pci-host/astro.c | 27 +++++++-------
 hw/pci-host/dino.c  | 90 +++++++++++++++++++++------------------------
 2 files changed, 55 insertions(+), 62 deletions(-)

-- 
2.43.0


