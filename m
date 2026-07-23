Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA061C531CC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 21:28:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wn0xH-0006z9-GO; Thu, 23 Jul 2026 17:27:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1wn0xF-0006yu-Dg
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 17:27:45 -0400
Received: from smtpx.feld.cvut.cz ([2001:718:2:1516::210:153]
 helo=smtpx.fel.cvut.cz)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_CHACHA20_POLY1305:256)
 (Exim 4.90_1) (envelope-from <pisa@fel.cvut.cz>) id 1wn0xC-0000Wu-M6
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 17:27:45 -0400
Received: from localhost (unknown [192.168.200.27])
 by smtpx.fel.cvut.cz (Postfix) with ESMTP id AB23A28640;
 Thu, 23 Jul 2026 23:27:37 +0200 (CEST)
X-Virus-Scanned: IMAP STYX AMAVIS
Received: from smtpx.fel.cvut.cz ([192.168.200.2])
 by localhost (cerokez-250.feld.cvut.cz [192.168.200.27]) (amavis, port 10060)
 with ESMTP id oNpOwRu8mQqp; Thu, 23 Jul 2026 23:27:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fel.cvut.cz;
 s=felmail; t=1784842056;
 bh=uf73OJp3lxWdrCgX3edLMe4tzbPdOYkP3iImtmBr3tA=;
 h=From:To:Subject:Date:Cc:References:In-Reply-To:From;
 b=tL/FPKlOO87muykUUc9sERXHshVpnAxQmtNKLtH6gkIkzmOcAoVZ5PA6KSWqCZROt
 EqUsaPS8TsXEg6oikkrCjcOdWOjUQAnI7NQIo/2ENW970+5gcqTBh+ZsY4rifsVZbw
 wSPku7cPQsh9N5jwQqx2sZF2kBnymutEQYbAkmvNxsJk3Bic9pFeL8mY3SIE7aJmTg
 716vYf2O7g4WkhxT7KSUMJG6bgN3U3dRqjPlfOAR+Boq+VaxxtZpa2TkViE97nAuiO
 lv8pkZuKhAON+OBAOA81IL9DazhaacTV50Pgi4ss7CidGFQ70TfYXO/sBUAOB9ZJLa
 /pya8Z9H9Do3g==
Received: from baree.pikron.com (static-84-242-78-234.bb.vodafone.cz
 [84.242.78.234])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pisa)
 by smtpx.fel.cvut.cz (Postfix) with ESMTPSA id 6AF8128599;
 Thu, 23 Jul 2026 23:27:35 +0200 (CEST)
From: Pavel Pisa <pisa@fel.cvut.cz>
To: Bernhard Beschow <shentey@gmail.com>
Subject: Re: [PATCH 7/9] hw/net/flexcan: Drop oversized 'mb[]' mailbox view
Date: Thu, 23 Jul 2026 23:27:34 +0200
User-Agent: KMail/1.9.10
Cc: "Philippe =?utf-8?q?Mathieu-Daud=C3=A9?=" <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org, Matyas Bobek <matyas.bobek@gmail.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Jason Wang <jasowangio@gmail.com>,
 Vikram Garhwal <vikram.garhwal@bytedance.com>
References: <20260723070059.6332-1-shentey@gmail.com>
 <202607231251.05529.pisa@fel.cvut.cz>
 <3A984F2D-FCCC-401C-8ADD-6335C7F44478@gmail.com>
In-Reply-To: <3A984F2D-FCCC-401C-8ADD-6335C7F44478@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Message-Id: <202607232327.34530.pisa@fel.cvut.cz>
Received-SPF: pass client-ip=2001:718:2:1516::210:153;
 envelope-from=pisa@fel.cvut.cz; helo=smtpx.fel.cvut.cz
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, NICE_REPLY_A=-2.557, SPF_HELO_NONE=0.001,
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

Hello Bernhard,

On Thursday 23 of July 2026 20:31:00 Bernhard Beschow wrote:
> Am 23. Juli 2026 10:51:05 UTC schrieb Pavel Pisa <pisa@fel.cvut.cz>:
> >Hello Bernhard and Philippe,
>
> Hi Pavel,
>
> >On Thursday 23 of July 2026 12:26:41 Bernhard Beschow wrote:
> >> Am 23. Juli 2026 08:20:34 UTC schrieb "Philippe Mathieu-Daud=C3=A9"
> >
> ><philmd@oss.qualcomm.com>:
> >> >On 23/7/26 09:00, Bernhard Beschow wrote:
> >> >> As indicated in the comments, the `mb[]` a.k.a. `mbs []` views shou=
ld
> >> >> cover 0x400 (1024) bytes. However, the `mb[]` array covers four tim=
es
> >> >> the size since `sizeof(FlexcanRegsMessageBuffer)` returns the size =
in
> >> >> bytes instead of counting the number of uint32_t fields. This shifts
> >> >> the subsequent register offsets by 0xc00 which is not intended. Fix
> >> >> the size and thus the offsets by dropping the now unused `mb[]` vie=
w.
> >> >>
> >> >> Note that the different size changes the migration layout. Since the
> >> >> device model is new, no change in the version fields is needed.
> >> >
> >> >typedef struct FlexcanState {
> >> >    ...
> >> >    union {
> >> >        FlexcanRegs     regs;
> >> >        uint32_t        regs_raw[sizeof(FlexcanRegs) / 4];
> >> >    };
> >> >    ...
> >> >} FlexcanState;
> >> >
> >> >static const VMStateDescription vmstate_can =3D {
> >> >    .name =3D TYPE_CAN_FLEXCAN,
> >> >    .version_id =3D 1,
> >> >    .minimum_version_id =3D 1,
> >> >    .fields =3D (const VMStateField[]) {
> >> >        ...
> >> >        VMSTATE_UINT32_ARRAY(regs_raw, FlexcanState,
> >> > sizeof(FlexcanRegs) / 4),
> >> >
> >> >        ^^^
> >> >
> >> >This "consider this structure as a casted array of u32" is very fragi=
le
> >> >anyway, and will unlikely scale over time.
> >> >
> >> >        ...
> >> >        VMSTATE_END_OF_LIST(),
> >> >    },
> >> >};
> >>
> >> Any suggestions what to do instead?
> >
> >I would suggest to keep the state as uint32_t array.
> >It is accessed by this and only by this size as the
> >FlexCAN MemoryRegionOps are defined. In the fact
> >I would like/plan in longer term, even to switch
> >the mbs array to be plain area of uint32_t in the future,
> >that is remove field
> >
> >  FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
> >
> >in FlexcanRegs.
> >
> >There should be only function which would return start
> >of given FlexcanRegsMessageBuffer based on index
> >argument and actual message buffers configuration.
> >It is required for CAN FD where message buffer
> >size is configurable. The raw/uint32_t area is kept
> >the same, but it is distributed to the indexed
> >buffers different way.
> >
> >So my preference is to move from structured view
> >in direction to the offsets in the words array.
> >Even the registers could be defined as offsets
> >to this array in the theory but as the overlay
> >structure for register accesses is used even
> >in the Linux kernel driver, I do not think that
> >this is necessary.
> >
> >But replacement of
> >
> >  FlexcanRegsMessageBuffer mbs[FLEXCAN_MAILBOX_COUNT];
> >
> >with appropriate
> >
> >  uint32_t mbs[FLEXCAN_MAILBOX_AREA_WORD_COUNT];
> >
> >and access functions would please me, because
> >it helps with future CAN FD support.
>
> Having CAN FD support would be nice indeed. Let's keep the code simple for
> now though until it gets implemented. Having just one way of doing things
> helps avoid traps such as those fixed in this series. We can change the
> code any time as we need it.

My main point is that attempt to implement VMStateDescription
some more structural way, i.e. mbs as array of corresponding
structures (which can be what has Philippe in mind), is counterproductive
from the longer term perspective, because the mbs role is the array
of words (uint32_t) which is interpretted according to other registers
in the FlexCAN3. In FlexCAN2, interpretation is fixed.
So storing whole area including control registers as array
of uint32_t matches reality quite well.

So I agree with keeping VMStateDescription unchanged.

Best wishes,

                Pavel

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

