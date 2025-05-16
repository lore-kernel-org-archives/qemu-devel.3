Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAE7C2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 01:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFjtG-0004ZD-Qm; Thu, 15 May 2025 21:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFjt4-0004OR-W6; Thu, 15 May 2025 21:29:24 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFjt1-0002Bp-RQ; Thu, 15 May 2025 21:29:22 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-73972a54919so1734105b3a.3; 
 Thu, 15 May 2025 18:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747358957; x=1747963757; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zWV+HFQDyjTh59zW7uB/BVwsfhiiynxhTz2knoFIz0=;
 b=bT5ZZOIGawzIx4f0AhbAnGk3M2PXiJP6IlG6yxFNlEczNFJNo270HQhPRY9aEbUYUa
 cfK+KOvBYv2fsicHIrKu1FDCAJxDQ2t56/lxIYcw+BcavDH1YGksm8lBv+cU4eYC8rCI
 3cydJGViXozFu0Vg8u3j1AZMm/K8RGUbKQCzjKf+K9yXJLgbHDXy7BHf2dEHsbZIqPUC
 gNMINvB2iJ1fvYLQFMYecPA6HqPpKIWd3PK9etdgiEOPqosNlnJgeOnL0qZSobzZWkmi
 RBPbIHE3IqLvRgeRm4uh+gz7sNXBCmJ1dgBdAQItIuQ7PQv3qt0kTuQ/vax8WjSWKhEm
 KZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747358957; x=1747963757;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8zWV+HFQDyjTh59zW7uB/BVwsfhiiynxhTz2knoFIz0=;
 b=YyqJMPq4Clq/J0kQcJK5vh/2t3Sb4AB2dBl/hRdXzeXV+6s+nzXVVthrw5Z758r5FU
 3icHuVLf4OkWbDndgv6oh6hxVxdL9hj6139ni0IspiW2cf7oaFU/8xLGQTw+gJUG4wrh
 +0hhLPyr9pn5WQEZylqaRfUzkEUaYLeLtzjqOu9PUJb1wd7qziNKAk5gYtAt7Jf/xfDG
 ofOQPlM9zgVj7oALRSQXeoOapmYCKSghIAH//sF3hcSrxhWSdURBRft2UJa+4L2TWTIb
 NxlqU8nlzQ+3cVmuv/cGaEJBiSscEaj7OZKypiBD+O1V9sPcumOB56afbZv0BYhACJ9T
 t+Hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViUVydbRPN97ax4epR/qJUtkdcsfI4ft7Q2t8dYUDB8bkCWV89w09r4BIdWWP9j9gvOsF88dNdkQ==@nongnu.org
X-Gm-Message-State: AOJu0Yx3E4LSPJMIeGavZfeH+c20q/vjH9jrVYeqLHt6haCI5Mkzfilj
 dnESUnFs/ZsmxCiqbHCzoPKCSMZUHd2bRsSWwLhnp7ZacCSoZn2MFiF5
X-Gm-Gg: ASbGnctZWfJZglc9LahalSLT1iorx7pEr8Xf+wWhglOj6FHBIA/cWroX7JUqbbwC2yI
 0Hx6clxXx5aFXEdWCjRuzUugm14DqPLLrI1U6pe7/GXAyesJy4sBofZ2BAdNCizSnzgQr3dAI3B
 0mS9yz1KNEAdlqAgE5rh1y+WOjpgHvyG4+5AFT9yOJvHLcvftzap/tVTzwYInkwTGRSdefW0oYv
 6Kt9gkyDnJCi7AWRgLN6OjRWcZURq7/hDILnPRoZV2FBPQnLbyHPThOsCH2/M8d3YB5RG2hQowW
 Mw6ORzBFR7J69TdW+GdanfrooyEzLKmXtbAv6WAusIQvNGg=
X-Google-Smtp-Source: AGHT+IHOR2dc0648fXOhgOISzHDQ5teMC3F7sMZuz4cie5vjjwxnXbK7Zyaezw28xxUm/j6g1IIvhw==
X-Received: by 2002:a17:902:c948:b0:220:d257:cdbd with SMTP id
 d9443c01a7336-231d45c9a2emr17755655ad.48.1747358957139; 
 Thu, 15 May 2025 18:29:17 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4e97227sm3967255ad.109.2025.05.15.18.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 18:29:16 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 11:29:11 +1000
Message-Id: <D9X71WIPID90.1W1RJIDOU9DID@gmail.com>
Subject: Re: [PATCH 00/50] ppc/xive: updates for PowerVM
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <b192697a-f936-450d-8e19-6cb364b7e747@redhat.com>
In-Reply-To: <b192697a-f936-450d-8e19-6cb364b7e747@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x430.google.com
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

On Fri May 16, 2025 at 1:36 AM AEST, C=C3=A9dric Le Goater wrote:
> On 5/12/25 05:10, Nicholas Piggin wrote:
>> These changes gets the powernv xive2 to the point it is able to run
>> PowerVM with good stability.
>>=20
>> * Various bug fixes around lost interrupts particularly.
>> * Major group interrupt work, in particular around redistributing
>>    interrupts. Upstream group support is not in a complete or usable
>>    state as it is.
>> * Significant context push/pull improvements, particularly pool and
>>    phys context handling was quite incomplete beyond trivial OPAL
>>    case that pushes at boot.
>> * Improved tracing and checking for unimp and guest error situations.
>> * Various other missing feature support.
>>=20
>> The ordering and grouping of patches in the series is not perfect,
>> because it had been an ongoing development, and PowerVM only started
>> to become stable toward the end. I did try to rearrange and improve
>> things, but some were not worth rebasing cost (e.g., some of the
>> pool/phys pull redistribution patches should have ideally been squashed
>> or moved together), so please bear that in mind.  Suggestions for
>> further rearranging the series are fine, but I might just find they are
>> too much effort to be worthwhile.
>>=20
>> Thanks,
>> Nick
>>=20
>> Glenn Miles (12):
>>    ppc/xive2: Fix calculation of END queue sizes
>>    ppc/xive2: Use fair irq target search algorithm
>>    ppc/xive2: Fix irq preempted by lower priority group irq
>>    ppc/xive2: Fix treatment of PIPR in CPPR update
>>    pnv/xive2: Support ESB Escalation
>>    ppc/xive2: add interrupt priority configuration flags
>>    ppc/xive2: Support redistribution of group interrupts
>>    ppc/xive: Add more interrupt notification tracing
>>    ppc/xive2: Improve pool regs variable name
>>    ppc/xive2: Implement "Ack OS IRQ to even report line" TIMA op
>>    ppc/xive2: Redistribute group interrupt precluded by CPPR update
>>    ppc/xive2: redistribute irqs for pool and phys ctx pull
>>=20
>> Michael Kowal (4):
>>    ppc/xive2: Remote VSDs need to match on forwarding address
>>    ppc/xive2: Reset Generation Flipped bit on END Cache Watch
>>    pnv/xive2: Print value in invalid register write logging
>>    pnv/xive2: Permit valid writes to VC/PC Flush Control registers
>>=20
>> Nicholas Piggin (34):
>>    ppc/xive: Fix xive trace event output
>>    ppc/xive: Report access size in XIVE TM operation error logs
>>    ppc/xive2: fix context push calculation of IPB priority
>>    ppc/xive: Fix PHYS NSR ring matching
>>    ppc/xive2: Do not present group interrupt on OS-push if precluded by
>>      CPPR
>>    ppc/xive2: Set CPPR delivery should account for group priority
>>    ppc/xive: tctx_notify should clear the precluded interrupt
>>    ppc/xive: Explicitly zero NSR after accepting
>>    ppc/xive: Move NSR decoding into helper functions
>>    ppc/xive: Fix pulling pool and phys contexts
>>    pnv/xive2: VC_ENDC_WATCH_SPEC regs should read back WATCH_FULL
>>    ppc/xive: Change presenter .match_nvt to match not present
>>    ppc/xive2: Redistribute group interrupt preempted by higher priority
>>      interrupt
>>    ppc/xive: Add xive_tctx_pipr_present() to present new interrupt
>>    ppc/xive: Fix high prio group interrupt being preempted by low prio V=
P
>>    ppc/xive: Split xive recompute from IPB function
>>    ppc/xive: tctx signaling registers rework
>>    ppc/xive: tctx_accept only lower irq line if an interrupt was
>>      presented
>>    ppc/xive: Add xive_tctx_pipr_set() helper function
>>    ppc/xive2: split tctx presentation processing from set CPPR
>>    ppc/xive2: Consolidate presentation processing in context push
>>    ppc/xive2: Avoid needless interrupt re-check on CPPR set
>>    ppc/xive: Assert group interrupts were redistributed
>>    ppc/xive2: implement NVP context save restore for POOL ring
>>    ppc/xive2: Prevent pulling of pool context losing phys interrupt
>>    ppc/xive: Redistribute phys after pulling of pool context
>>    ppc/xive: Check TIMA operations validity
>>    ppc/xive2: Implement pool context push TIMA op
>>    ppc/xive2: redistribute group interrupts on context push
>>    ppc/xive2: Implement set_os_pending TIMA op
>>    ppc/xive2: Implement POOL LGS push TIMA op
>>    ppc/xive2: Implement PHYS ring VP push TIMA op
>>    ppc/xive: Split need_resend into restore_nvp
>>    ppc/xive2: Enable lower level contexts on VP push
>>=20
>>   hw/intc/pnv_xive.c          |  16 +-
>>   hw/intc/pnv_xive2.c         | 139 +++++--
>>   hw/intc/pnv_xive2_regs.h    |   1 +
>>   hw/intc/spapr_xive.c        |  18 +-
>>   hw/intc/trace-events        |  12 +-
>>   hw/intc/xive.c              | 555 ++++++++++++++++++----------
>>   hw/intc/xive2.c             | 717 +++++++++++++++++++++++++++---------
>>   hw/ppc/pnv.c                |  48 +--
>>   hw/ppc/spapr.c              |  21 +-
>>   include/hw/ppc/xive.h       |  66 +++-
>>   include/hw/ppc/xive2.h      |  22 +-
>>   include/hw/ppc/xive2_regs.h |  22 +-
>>   12 files changed, 1145 insertions(+), 492 deletions(-)
>>=20
>
> I am impressed :) and glad that you are still taking care of XIVE.
>
> I suggest adding new names under the XIVE entry in the MAINTAINERS file.

Yeah it's good to see. They are building a lot more cool stuff with
powernv at the moment, hopefully almost all should get upstreamed
eventually.

I will try to convince them to add MAINTAINER entries :)

Thanks,
Nick

