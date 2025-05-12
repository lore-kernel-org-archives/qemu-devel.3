Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 841BCC3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 03:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEJZT-0006sJ-3Z; Sun, 11 May 2025 23:11:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZR-0006rb-3X; Sun, 11 May 2025 23:11:13 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uEJZP-0006h3-A8; Sun, 11 May 2025 23:11:12 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-74248a3359fso1774436b3a.2; 
 Sun, 11 May 2025 20:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747019469; x=1747624269; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u9r2yyKX/u9ldGgI8SjiWAY0cx5O7JLkzSvZL9g2Zs4=;
 b=bCHlm7ZKm0sBir5OvYjnqXOxMXHpFzlBoMadhif2BNOAC1hTuXBPK8LZ2cWwyYSHQ/
 AxRm4+V5OwMcoXPML6vIIStIYYNy4B+lsUlQVHzWMp6SUG/v7M1Q11BSi2B8jzkztF8z
 KvjgKI2hMF0YcqBqF/wIyS8JbCmHAHUNaR/v7kHru4VZ7v3Os+Xb4xAiKwDIHiXaEqqt
 tyPMlFFsdK1gZfZDRc7T/IvONgZJ+sObPAk9o2PtR2lK2192A6wGac2hj/38Y60Sr/ps
 1r3s6e2lkrR4Nzuetl2jyGtoojik90hNzpCxsw3DtI+usim+twnRqvuIFcG5ZzlBCJtp
 JROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747019469; x=1747624269;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9r2yyKX/u9ldGgI8SjiWAY0cx5O7JLkzSvZL9g2Zs4=;
 b=UfN38/w2BIUhRqbQnI825G/LAxrXKn//cOUd33ixizDASfW+fOB3NIiALSAPf+l+Yl
 WX2Qh7AqUfEThweybKH9ee+QLdr2rTI+OH+i1au9TTj76I8TykedAiosZb4swXF277M2
 I4UfmJlGMsPtEWypvMX+52PhlxniR+Cco/BEuIXN2+CWqdClwKRuOMdjDIqubgg+FkVg
 TO2nv2PH6xwv81R72g7F0HPBuOD5eL92YxtGeKJ3Xd4uhcS/i1HhmMahwdRUYPJFq2LB
 Qs7BULtEQo3BWmb1w92b3pazlql98gRqMvSuWhSxwtgEcujdALIFikG9gCIUDS351sv9
 jBXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+Pf5B9SOPDVPbl4PU19xldyGCdqpgHAgaCw1kYuBto6FVFeQvAklatKBU4nV4IPRluOtFR0jNzKGb@nongnu.org
X-Gm-Message-State: AOJu0Yw6D7fLDwOLGmzxRC81A67zZdv2GKCNEweeLenifCvpSOEY/0M/
 5VpqnG6cwOWa8/Xus3zIk7h3Be6SI59X3OBv6MCDBukHD06EKK/kdSyP9A==
X-Gm-Gg: ASbGncvAVlr/n3du1bLrJoiNkt/AV6IU+lMGQiEjF4ul9SBK+dcZNCfBNql94TkG0HV
 R+n1UJxcLRUwIDFGJXgBn/KL6ZiF9+z/k5eOm/wszeTpNwQ4Rc9nYQkf+c241hoNp4I92ijqnSZ
 P7wfXDetwHFAahZ7JxZEP4fQESO5iz2AMA7nYmPphmNPt/PnWArNXbZIuKqvdj7JfAyB2Gh7LGY
 jsp+j7wMjlVqcBEi2VGQtvn5H+LtynwMOlcEo5r9avDI4W0+7FXB2FJY9x6bZeNSdKN6ADIh9Bw
 KTgTOqifEN7bkdtMkEngjl/CaAkKoAfsqKJ7u+vhE2GZZeKIiHJF2x7Qvg==
X-Google-Smtp-Source: AGHT+IEXrRHXyRkFD9CJEcbVP/3HjPj+bqxbFqBiQOcCoE7xei/PLoIzKcDmuHMHoJswHxUFU0YyYg==
X-Received: by 2002:a05:6a20:c991:b0:1f0:e706:1370 with SMTP id
 adf61e73a8af0-215abd306ffmr19979291637.35.1747019468731; 
 Sun, 11 May 2025 20:11:08 -0700 (PDT)
Received: from wheely.local0.net ([118.209.229.237])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b234951024csm4750069a12.5.2025.05.11.20.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 20:11:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Barrat?= <fbarrat@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>
Subject: [PATCH 00/50] ppc/xive: updates for PowerVM
Date: Mon, 12 May 2025 13:10:09 +1000
Message-ID: <20250512031100.439842-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42f.google.com
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

These changes gets the powernv xive2 to the point it is able to run
PowerVM with good stability.

* Various bug fixes around lost interrupts particularly.
* Major group interrupt work, in particular around redistributing
  interrupts. Upstream group support is not in a complete or usable
  state as it is.
* Significant context push/pull improvements, particularly pool and
  phys context handling was quite incomplete beyond trivial OPAL
  case that pushes at boot.
* Improved tracing and checking for unimp and guest error situations.
* Various other missing feature support.

The ordering and grouping of patches in the series is not perfect,
because it had been an ongoing development, and PowerVM only started
to become stable toward the end. I did try to rearrange and improve
things, but some were not worth rebasing cost (e.g., some of the
pool/phys pull redistribution patches should have ideally been squashed
or moved together), so please bear that in mind.  Suggestions for
further rearranging the series are fine, but I might just find they are
too much effort to be worthwhile.

Thanks,
Nick

Glenn Miles (12):
  ppc/xive2: Fix calculation of END queue sizes
  ppc/xive2: Use fair irq target search algorithm
  ppc/xive2: Fix irq preempted by lower priority group irq
  ppc/xive2: Fix treatment of PIPR in CPPR update
  pnv/xive2: Support ESB Escalation
  ppc/xive2: add interrupt priority configuration flags
  ppc/xive2: Support redistribution of group interrupts
  ppc/xive: Add more interrupt notification tracing
  ppc/xive2: Improve pool regs variable name
  ppc/xive2: Implement "Ack OS IRQ to even report line" TIMA op
  ppc/xive2: Redistribute group interrupt precluded by CPPR update
  ppc/xive2: redistribute irqs for pool and phys ctx pull

Michael Kowal (4):
  ppc/xive2: Remote VSDs need to match on forwarding address
  ppc/xive2: Reset Generation Flipped bit on END Cache Watch
  pnv/xive2: Print value in invalid register write logging
  pnv/xive2: Permit valid writes to VC/PC Flush Control registers

Nicholas Piggin (34):
  ppc/xive: Fix xive trace event output
  ppc/xive: Report access size in XIVE TM operation error logs
  ppc/xive2: fix context push calculation of IPB priority
  ppc/xive: Fix PHYS NSR ring matching
  ppc/xive2: Do not present group interrupt on OS-push if precluded by
    CPPR
  ppc/xive2: Set CPPR delivery should account for group priority
  ppc/xive: tctx_notify should clear the precluded interrupt
  ppc/xive: Explicitly zero NSR after accepting
  ppc/xive: Move NSR decoding into helper functions
  ppc/xive: Fix pulling pool and phys contexts
  pnv/xive2: VC_ENDC_WATCH_SPEC regs should read back WATCH_FULL
  ppc/xive: Change presenter .match_nvt to match not present
  ppc/xive2: Redistribute group interrupt preempted by higher priority
    interrupt
  ppc/xive: Add xive_tctx_pipr_present() to present new interrupt
  ppc/xive: Fix high prio group interrupt being preempted by low prio VP
  ppc/xive: Split xive recompute from IPB function
  ppc/xive: tctx signaling registers rework
  ppc/xive: tctx_accept only lower irq line if an interrupt was
    presented
  ppc/xive: Add xive_tctx_pipr_set() helper function
  ppc/xive2: split tctx presentation processing from set CPPR
  ppc/xive2: Consolidate presentation processing in context push
  ppc/xive2: Avoid needless interrupt re-check on CPPR set
  ppc/xive: Assert group interrupts were redistributed
  ppc/xive2: implement NVP context save restore for POOL ring
  ppc/xive2: Prevent pulling of pool context losing phys interrupt
  ppc/xive: Redistribute phys after pulling of pool context
  ppc/xive: Check TIMA operations validity
  ppc/xive2: Implement pool context push TIMA op
  ppc/xive2: redistribute group interrupts on context push
  ppc/xive2: Implement set_os_pending TIMA op
  ppc/xive2: Implement POOL LGS push TIMA op
  ppc/xive2: Implement PHYS ring VP push TIMA op
  ppc/xive: Split need_resend into restore_nvp
  ppc/xive2: Enable lower level contexts on VP push

 hw/intc/pnv_xive.c          |  16 +-
 hw/intc/pnv_xive2.c         | 139 +++++--
 hw/intc/pnv_xive2_regs.h    |   1 +
 hw/intc/spapr_xive.c        |  18 +-
 hw/intc/trace-events        |  12 +-
 hw/intc/xive.c              | 555 ++++++++++++++++++----------
 hw/intc/xive2.c             | 717 +++++++++++++++++++++++++++---------
 hw/ppc/pnv.c                |  48 +--
 hw/ppc/spapr.c              |  21 +-
 include/hw/ppc/xive.h       |  66 +++-
 include/hw/ppc/xive2.h      |  22 +-
 include/hw/ppc/xive2_regs.h |  22 +-
 12 files changed, 1145 insertions(+), 492 deletions(-)

-- 
2.47.1


