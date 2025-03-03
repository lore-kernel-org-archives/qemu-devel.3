Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B354C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 11:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3tR-0002oy-1h; Mon, 03 Mar 2025 06:23:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp3tN-0002kM-8d; Mon, 03 Mar 2025 06:23:26 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tp3tL-00075y-GE; Mon, 03 Mar 2025 06:23:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2234bec7192so57713885ad.2; 
 Mon, 03 Mar 2025 03:23:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741001001; x=1741605801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dUidDEA6np+35JPmU5jOJYVOfmEjlpsQmxLwUQgUvG0=;
 b=nsIxQYexcJ4YZGvrvxZTs77dVlt18POhqN2SmKqqn7tg5IF9SmaQ11xyLspVDeW7Bi
 QCqE6SN58N8H2JE1StNRIKnyGpNM7CwkPazElj2WiwHi0L5HjYXr2vo9dF8+pwgZXFy9
 Nd519+acQ9wJVIGCbQVUu/ZiwoZ0vzjAcZP7p9Fn0h3ky004Kenj4G2HTWY87JeC5UY2
 Kj4NDnBvXy3GeQH4Azw2PUsbml+MA1bEEBnGHmo7L58FlVNCxq40FclussBolKKsc/1a
 PhK/FNansCmTZ9O1oNtvL8kMJjwRXA6edXSFG4RQA+Of4p9iU3mHYZJXwgzJIwS5b8S0
 saAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741001001; x=1741605801;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dUidDEA6np+35JPmU5jOJYVOfmEjlpsQmxLwUQgUvG0=;
 b=VsezlWSpJtNQWhw6REe4/DLozvIVnf20FyGJCX7oOhHXjowU9jUIpTrrltsxkAWKAQ
 xmNIhKr4Oq1rB6BTiwXt9/bkX5/VBg6V47Ivda8Oar9GIf8WAc/a9d2khOw3Ld4heriz
 XwX2Rk7KldXK/zi3X+pAN19eV/8/r2svVsqTUsePG4h7/mUd6gsnTkcZS2KwEVP+5n6s
 irbuen33BA733TYWZF1brL9TUP8dLCI5wl5XOsrifa/DCYUaBMRs40huDSiziGg2bBMy
 HVoYjuR2GQToH1d27/AAoyypwNmCVu5/L4f9UgotwqMXDeHooGZt+c4cpMIxWKOPfmEo
 BOlw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0dDj4Rm9rUzhj7oMS+jOljqDucoUdOLN+sbTwpmI1JTWewMlXawYkWRnLQ/W+Ece8aBlKVd5879qI@nongnu.org
X-Gm-Message-State: AOJu0YxpQV1bjsITHIriUDBI7zxIyVFMNToQ8ZGxmBkJ6WAHKe7Kkrx+
 cE2JaHZgkn2W5k2RlIF0pCPta5eL8Hs2p68PL/wpf7VoKjWNMxZ8xs1+HQ==
X-Gm-Gg: ASbGnctPtrjpf4vc+p4oUBIO1uh9V4BG7cVM1zrMUYudwr+8c9QXv8bHGzXTXompPGs
 pMTFge3DJ4eUbOl5SciNxFZDCIUBpliugBRdVY9SUinO9O6jPQ1p0rc07mWrUxTQPomqJHudvkk
 7Z1Wbch2uUxNQPJIzdqfy9kJXofywpZRcDswJ371iAdDEgZcYVxd59TGNlvE/MG/XGzPxYRq4i/
 +4bMEynnpgFFH76r2KypjL69LKkUzi5u6k+bEw1CimmiRyM4dn+0UjyzC39OIVbQApYwm+1VZSr
 vqhVpwH2n5OPCbWZDSrCkPXuJwR/9euY/25zpUtPNtK+IoGus30=
X-Google-Smtp-Source: AGHT+IGetSR4DGXERuvfSs4PL9dDW+y5MIrBDl72BoYnuNej2psiFC34e4Rk8RmKlJcYPeR1sMtQ8A==
X-Received: by 2002:a17:903:41cf:b0:21f:164d:93fe with SMTP id
 d9443c01a7336-2236922174bmr201897175ad.53.1741001001304; 
 Mon, 03 Mar 2025 03:23:21 -0800 (PST)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-223501f9e3bsm75388875ad.82.2025.03.03.03.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 03:23:20 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/ppc: Fixes for TCG TLB modeling of some MMU SPRs
Date: Mon,  3 Mar 2025 21:23:11 +1000
Message-ID: <20250303112315.586478-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
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

Any register or memory value that is used by the .tlb_fill
function (e.g., in ppc_xlate()) can affect what gets put in TCG's
TLB, so changing it requires either: that the ISA permits cached
address translations that become incoherent vs the changed value;
that TCG TLB is "tagged" with the changing value (e.g., with mmuidx);
or that the TCG TLB is flushed.

ppc is missing a few such flushes. Other than the AMR flush, Linux/KVM
probably covers such SPR changes with other flushes (e.g., context
switching between guests or guest/host will update LPCR and LPIDR and
LPIDR update already causes a TLB flush), which explains why they
haven't caused obvious bugs.

Thanks,
Nick

Nicholas Piggin (3):
  target/ppc: flush TLB on HRMOR and LPCR SPR updates
  target/ppc: Avoid work if MMU SPRs are written with same value
  target/ppc: add missing TLB flushes for memory protection key SPR
    updates

 target/ppc/helper.h      |  3 ++
 target/ppc/spr_common.h  |  1 +
 target/ppc/cpu.c         | 12 +++++-
 target/ppc/cpu_init.c    |  6 +--
 target/ppc/misc_helper.c | 85 +++++++++++++++++++++++++++++++++++++++-
 target/ppc/translate.c   | 62 ++++++-----------------------
 6 files changed, 114 insertions(+), 55 deletions(-)

-- 
2.47.1


