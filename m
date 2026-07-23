Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE922C531C7
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:55:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmr54-0005jj-ID; Thu, 23 Jul 2026 06:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1wmr52-0005dI-Lq
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:55:08 -0400
Received: from smtpx.feld.cvut.cz ([147.32.210.153] helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1wmr50-0001I6-5e
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 06:55:08 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id D9BEF2677F;
 Thu, 23 Jul 2026 12:55:02 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id nGLfZm71yaQy; Thu, 23 Jul 2026 12:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1784803866;
 bh=IzJEvph+BFIv5s0K0ZvzdOaVpthIO1cI8w32JGwgPps=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=seBmvouuRDjZ+giztT2ldhvIHyAJVUe5Zp1bdXo6UmRXYEq4hGEG/+eFF5P7yfhOY
 ZnGi+7Y0KZ2PaTM99A5Ds7rEpVoBHXLbs0FHf/GSgLxh4SGVM0qOZ1aQSZXC7WsP/E
 2lCFHastKc3Hlapyc3b0xrrn2/RPC9E4RafuBT1cqT53nTKBQFnI0Gxe2WehK5Auhu
 3m+9XScojcZ1Uigc5BjHxs0EaDu8CILx2Vec/ABqUhTNah22O7jupry56YBvfQretd
 H31l29RjtwyBuNGkWuBOA5DuiHqBsudA7YMCUfpnLApFs/Ed//rD4Bmj+SxRSNR2eI
 cXpo9QgNdn1bg==
Received: from [147.32.86.199] (unknown [147.32.86.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 08856266E3;
 Thu, 23 Jul 2026 12:51:06 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH 7/9] hw/net/flexcan: Drop oversized 'mb[]' mailbox view
Date: Thu, 23 Jul 2026 12:51:05 +0200
User-Agent: KMail/1.9.10
Cc: "Philippe =?utf-8?q?Mathieu-Daud=C3=A9?=" <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
References: <20260723070059.6332-1-shentey@gmail.com>
 <84061116-c6d5-4def-acd8-ba9c81a0eece@oss.qualcomm.com>
 <F33F7AFC-1868-49E8-95C8-CBB04339F6A3@gmail.com>
In-Reply-To: <F33F7AFC-1868-49E8-95C8-CBB04339F6A3@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202607231251.05529.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=147.32.210.153; envelope-from=pisa@fel.cvut.cz;
 helo=smtpx.fel.cvut.cz
X-Spam_score_int: -67
X-Spam_score: -6.8
X-Spam_bar: ------
X-Spam_report: (-6.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.494,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Hello Bernhard and Philippe,

On Thursday 23 of July 2026 12:26:41 Bernhard Beschow wrote:
> Am 23. Juli 2026 08:20:34 UTC schrieb "Philippe Mathieu-Daud=C3=A9"=20
<philmd@oss.qualcomm.com>:
> >On 23/7/26 09:00, Bernhard Beschow wrote:
> >> As indicated in the comments, the `mb[]` a.k.a. `mbs []` views should
> >> cover 0x400 (1024) bytes. However, the `mb[]` array covers four times
> >> the size since `sizeof(FlexcanRegsMessageBuffer)` returns the size in
> >> bytes instead of counting the number of uint32_t fields. This shifts t=
he
> >> subsequent register offsets by 0xc00 which is not intended. Fix the si=
ze
> >> and thus the offsets by dropping the now unused `mb[]` view.
> >>
> >> Note that the different size changes the migration layout. Since the
> >> device model is new, no change in the version fields is needed.
> >
> >typedef struct FlexcanState {
> >    ...
> >    union {
> >        FlexcanRegs     regs;
> >        uint32_t        regs_raw[sizeof(FlexcanRegs) / 4];
> >    };
> >    ...
> >} FlexcanState;
> >
> >static const VMStateDescription vmstate_can =3D {
> >    .name =3D TYPE_CAN_FLEXCAN,
> >    .version_id =3D 1,
> >    .minimum_version_id =3D 1,
> >    .fields =3D (const VMStateField[]) {
> >        ...
> >        VMSTATE_UINT32_ARRAY(regs_raw, FlexcanState, sizeof(FlexcanRegs)=
 /
> > 4),
> >
> >        ^^^
> >
> >This "consider this structure as a casted array of u32" is very fragile
> >anyway, and will unlikely scale over time.
> >
> >        ...
> >        VMSTATE_END_OF_LIST(),
> >    },
> >};
>
> Any suggestions what to do instead?
>

I would suggest to keep the state as uint32_t array.
It is accessed by this and only by this size as the
=46lexCAN MemoryRegionOps are defined. In the fact
I would like/plan in longer term, even to switch
the mbs array to be plain area of uint32_t in the future,
that is remove field

  FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];

in FlexcanRegs.

There should be only function which would return start
of given FlexcanRegsMessageBuffer based on index
argument and actual message buffers configuration.
It is required for CAN FD where message buffer
size is configurable. The raw/uint32_t area is kept
the same, but it is distributed to the indexed
buffers different way.

So my preference is to move from structured view
in direction to the offsets in the words array.
Even the registers could be defined as offsets
to this array in the theory but as the overlay
structure for register accesses is used even
in the Linux kernel driver, I do not think that
this is necessary.

But replacement of

  FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];

with appropriate

  uint32_t mbs[FLEXCAN_MAILBOX_AREA_WORD_COUNT];

and access functions would please me, because
it helps with future CAN FD support.

Best wishes,

                Pavel Pisa
    phone:      +420 603531357
    e-mail:     pisa@cmp.felk.cvut.cz
    Department of Control Engineering FEE CVUT
    Karlovo namesti 13, 121 35, Prague 2
    university: http://control.fel.cvut.cz/
    personal:   http://cmp.felk.cvut.cz/~pisa
    social:     https://social.kernel.org/ppisa
    projects:   https://www.openhub.net/accounts/ppisa
    CAN related:http://canbus.pages.fel.cvut.cz/
    RISC-V education: https://comparch.edu.cvut.cz/
    Open Technologies Research Education and Exchange Services
    https://gitlab.fel.cvut.cz/otrees/org/-/wikis/home

