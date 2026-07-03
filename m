Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D849C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 00:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfROm-0006Gw-Sl; Thu, 02 Jul 2026 20:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wfROd-0006GW-0y
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 20:04:44 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wfROa-0007Ev-0c
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 20:04:42 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 703FD59672E;
 Fri, 03 Jul 2026 02:04:37 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id DlCgDt-WskUz; Fri,  3 Jul 2026 02:04:30 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E9CDC59672D; Fri, 03 Jul 2026 02:04:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E7F1059672C;
 Fri, 03 Jul 2026 02:04:30 +0200 (CEST)
Date: Fri, 3 Jul 2026 02:04:30 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Keith Monahan <keith@techtravels.org>
cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>, 
 Fam Zheng <fam@euphon.net>
Subject: Re: [PATCH v2 3/4] hw/scsi/ncr53c710: rewrite the SCRIPTS engine
In-Reply-To: <8d3f679a-3039-404e-879d-b97e1b58e090@techtravels.org>
Message-ID: <41274750-6ed5-9525-75fc-59a82d2cd2cb@eik.bme.hu>
References: <20260701213359.1855870-1-keith@techtravels.org>
 <20260701213359.1855870-4-keith@techtravels.org>
 <CAFEAcA_3vf5vrwoO0cGcdTsykU8uTf8386oyWki3iQ3Bje9Trw@mail.gmail.com>
 <8d3f679a-3039-404e-879d-b97e1b58e090@techtravels.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Thu, 2 Jul 2026, Keith Monahan wrote:
> Peter,
>
> Thanks for going through it. I raised this originally in the v1 thread
> and I am not sure it reached you, so let me lay it out here.
>
> The size is real, but the more useful thing to flag is that reading this
> as a diff against the old model will not give you an accurate view of
> the change, because these are not two versions of one model. They are
> two different implementations, and git is aligning text between them
> that never shared any code.
>
> Three concrete ways they differ:
>
> 1. Different origin. The old model descends from Toni Wilen's UAE
>   implementation by way of Helge Deller. The new engine is derived from
>   QEMU's own lsi53c895a.c. They are unrelated codebases, so the delta
>   is not one evolving into the other, it is one file removed and a
>   different one added.
>
> 2. Different execution model. The old model runs SCRIPTS synchronously
>   inside the guest's register write, so completion interrupts come back
>   reentrantly. The new one runs the engine asynchronously and delivers
>   completion the way the chip actually does. That is a different control 
> flow from top to bottom, not a local change.
>
> 3. Different connection model. The old model is connected only, with no
>   target initiated disconnect or reselect. The new one implements
>   disconnect and reselect and the state machine around them. That is a
>   different device state machine, not a modified one.
>
> Because of those three, the two files do not line up function to
> function or line to line. The diff is large and noisy precisely because
> git has almost nothing to match, so it renders a wholesale replacement
> as a wall of edits. You will not learn what actually changed by reading
> the delta; the way to review this is to read ncr53c710.c as a new file
> against the 53C710 manual, not as a patch on the old one.

In that case maybe another approach could be to have a patch that replaces 
old 710 model with a copy of lsi53c895a.c unchanged first (of course this 
would remove it from compile so it can still be bisected or only include 
this patch as interim for review that can then be squashed with next patch 
on merge) then have the patch that rewrites the lsi53c895a.c model to 710 
which would be a more useful patch to look at to show what's really 
changed than the patch that's unreadable because it's diffing unrelated 
codebase?

Regards,
BALATON Zoltan

> For what it is worth, I did try to get there incrementally first. It
> took about a dozen fixes to the old model just to get the chip's own
> driver to negotiate its first command, and it still would not boot
> reliably, because the two blockers, connected only and synchronous
> SCRIPTS, are structural and cannot be patched out in small local steps.
> That is why I stopped treating the old code as a base: it has no path to
> an HP-UX boot to build on.
>
> I do appreciate that this is a large and complicated model, and that
> reviewing it will take real time; I am not trying to wave that away. But
> the incremental path would be worse on exactly that front. A series that
> converted the old model into this one would be a long chain of patches
> to write and a long chain to review, most of them touching code that is
> thrown away by the end. Reviewing one coherent new file, even a big one,
> is less work than reviewing however many steps it would take to get
> there.
>
> You really can't get THERE from HERE, which is why I took this approach.
>
> Thanks,
> Keith
>
> On 7/2/2026 5:02 AM, Peter Maydell wrote:
>> On Wed, 1 Jul 2026 at 22:49, Keith Monahan <keith@techtravels.org> wrote:
>>> 
>>> Replace the NCR 53C710 model with a SCRIPTS engine derived from QEMU's
>>> LSI53C895A model (hw/scsi/lsi53c895a.c), another device in the same
>>> NCR/LSI SCRIPTS family, adapted to the 53C710: its register map, the
>>> single-byte DSTAT/SSTAT0 interrupt model, big-endian SCRIPTS and
>>> table-indirect fetch (the part sits on the big-endian PA-RISC LASI bus),
>>> and 24-bit DMA byte counts.  Behaviour follows the NCR 53C710 Data Manual
>>> (Jun 1992) and Programmer's Guide (Oct 1990).
>>> 
>>> The base engine supports connected I/O and reselection-interrupt
>>> disconnect, enough to install and boot Debian off the 710 with the Linux
>>> lasi700/53c700 driver and to boot NetBSD/hppa 9.4 and 10.1 (osiop) with
>>> disk and CD-ROM enumeration.  Reselection follows the 53C700 family:
>>> gated on the (re)selection interrupt enable (SIEN.SEL) alone, one-hot
>>> SDID, and an SFBR id bitmask in 700-compatibility mode.  SDTR/WDTR/PPR
>>> negotiation is declined with MESSAGE REJECT, which the 700-family drivers
>>> require to proceed: unlike the 8xx parts they leave the target to drive
>>> the phase after the reject.
>>> 
>>> The LASI glue (hw/scsi/lasi_ncr710.c) embeds one NCR710State by value.
>>> It gains the free_request SCSIBusInfo callback and request-queue init the
>>> core needs, renames the reselection timer to scripts_timer, and narrows
>>> the SCSI bus to the 8-bit inclusive maxima.
>>> 
>>> The migration format is incompatible with the model this replaces, so the
>>> vmstate version and minimum version are both raised.
>>> 
>>> Signed-off-by: Keith Monahan <keith@techtravels.org>
>>> ---
>>>   hw/scsi/lasi_ncr710.c |  117 +-
>>>   hw/scsi/lasi_ncr710.h |   12 +-
>>>   hw/scsi/ncr53c710.c   | 2795 +++++++++++++++--------------------------
>>>   hw/scsi/ncr53c710.h   |  276 ++--
>>>   hw/scsi/trace-events  |   43 +-
>>>   5 files changed, 1191 insertions(+), 2052 deletions(-)
>> 
>> I'm likely not going to be the one doing detailed review here, so
>> my opinion here is not necessarily 100% controlling, but from my
>> perspective this is still significantly too large to review, both
>> in raw size terms and because it has a lot of changes in it that
>> do not all need or want to be in the same patch.
>> 
>> Just looking through the very early stuff to show some examples
>> of changes that don't need to be in this patch:
>> 
>>> @@ -50,22 +48,22 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, 
>>> hwaddr addr,
>>>       if (addr >= 0x100) {
>>>           hwaddr ncr_addr = addr - 0x100;
>>>           if (size == 1) {
>>> +            /*
>>> +             * Single byte access: flip the byte lane (PA-RISC big endian
>>> +             * access -> the chip's little endian register order).
>>> +             */
>>>               ncr_addr ^= 3;
>>> -            NCR710_DPRINTF("Reading value to LASI WRAPPER == 0x%lx%s, "
>>> -                           "val=0x%lx, size=%u\n",
>>> -                           addr - 0x100, size == 1 ? " (XORed)" : "",
>>> -                           val, size);
>>>               val = ncr710_reg_read(&s->ncr710, ncr_addr, size);
>>>           } else {
>>> +            /*
>>> +             * Multibyte access: gather little endian, no lane flip, so
>>> +             * the 24/32 bit registers assemble correctly.
>>> +             */
>>>               val = 0;
>> 
>> These are comment improvements to existing code. They don't need to be in
>> the big patch.
>>
>>>               for (unsigned i = 0; i < size; i++) {
>>>                   uint8_t byte_val = ncr710_reg_read(&s->ncr710, ncr_addr 
>>> + i, 1);
>>>                   val |= ((uint64_t)byte_val) << (i * 8);
>>> -                NCR710_DPRINTF("  Read byte %u from NCR addr 0x%lx: "
>>> -                               "0x%02x\n", i, ncr_addr + i, byte_val);
>>>               }
>>> -            NCR710_DPRINTF("  Reconstructed %u-byte value: 0x%lx\n",
>>> -                           size, val);
>> 
>> Here we drop some debug printfs. That can be done separately.
>>
>>>           }
>>>
>>>           trace_lasi_ncr710_reg_forward_read(addr, val);
>>> @@ -83,7 +81,13 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr 
>>> addr,
>>>
>>>       trace_lasi_ncr710_reg_write(addr, val, size);
>>> 
>>> -    if (addr <= 0x0F) {
>>> +    /*
>>> +     * 0x00..0x0f is the read only LASI module header 
>>> (ID/SVERSION/HVERSION) and
>>> +     * 0x10..0xff is unmapped module space; writes to both are ignored. 
>>> The
>>> +     * SCSI bus reset is driven through the chip's SCNTL1.RST at 
>>> forwarded
>>> +     * offset 0x101 (see ncr53c710.c), not through this window.
>>> +     */
>>> +    if (addr <= 0x0f) {
>>>           return;
>>>       }
>> 
>> This is a better explanatory comment. That's not something that
>> needs to be in the big patch.
>> 
>>> 
>>> @@ -92,16 +96,10 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr 
>>> addr,
>>>
>>>           if (size == 1) {
>>>               ncr_addr ^= 3;
>>> -            NCR710_DPRINTF("Writing value to LASI WRAPPER == 0x%lx%s, "
>>> -                           "val=0x%lx, size=%u\n",
>>> -                           addr - 0x100, size == 1 ? " (XORed)" : "",
>>> -                           val, size);
>>>               ncr710_reg_write(&s->ncr710, ncr_addr, val, size);
>>>           } else {
>>>               for (unsigned i = 0; i < size; i++) {
>>>                   uint8_t byte_val = (val >> (i * 8)) & 0xff;
>>> -                 NCR710_DPRINTF("  Writing byte %u to NCR addr 0x%lx: 
>>> 0x%02x\n",
>>> -                       i, ncr_addr + i, byte_val);
>>>                   ncr710_reg_write(&s->ncr710, ncr_addr + i, byte_val, 1);
>>>               }
>>>           }
>> 
>> Debug printfs being removed again.
>> 
>>> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
>>> index 57967e7a84..57cd7d91a4 100644
>>> --- a/hw/scsi/ncr53c710.c
>>> +++ b/hw/scsi/ncr53c710.c
>>> @@ -1,599 +1,308 @@
>>>   /*
>>> - * QEMU NCR710 SCSI Controller
>>> + * QEMU NCR 53C710 SCSI I/O Processor emulation
>>>    *
>>> - * Copyright (c) 2025 Soumyajyotii Ssarkar 
>>> <soumyajyotisarkar23@gmail.com>
>>> - * This driver was developed during the Google Summer of Code 2025 
>>> program.
>> 
>> Generally speaking you shouldn't drop somebody's Copyright line.
>> Even if the code has been mostly rewritten, there's still some
>> of Soumyajyotii's code here, I expect.
>> 
>>> + * Copyright (c) 2026 Keith Monahan <keith@techtravels.org>
>>> + * Copyright (c) 2006 CodeSourcery (lsi53c895a.c, written by Paul Brook)
>>>    *
>>> - * NCR710 SCSI Controller implementation
>>> - * Based on the NCR53C710 Technical Manual Version 3.2, December 2000
>>> + * A rewrite of the QEMU NCR 53C710 model.  The 53C710 is an early member 
>>> of
>>> + * the NCR/LSI SCRIPTS processor family, so the SCRIPTS engine here is 
>>> derived
>>> + * from QEMU's LSI53C895A model and adapted to the 53C710's register map,
>>> + * single byte interrupt model, big endian SCRIPTS fetch (PA-RISC) and 24 
>>> bit
>>> + * DMA, per the NCR 53C710 Data Manual (Jun 1992) and Programmer's Guide
>>> + * (Oct 1990).
>>>    *
>>> - * Developed from an implementation of NCR53C710 by Helge Deller
>>> - * which was interim based on the implementation by Toni Wilen for UAE.
>>> + * Derived from hw/scsi/lsi53c895a.c (Copyright (c) 2006 CodeSourcery, 
>>> written
>>> + * by Paul Brook).
>>>    *
>>> - * SPDX-License-Identifier: GPL-2.0-or-later
>>> + * Replaces the 53C710 model written for Google Summer of Code 2025 by
>>> + * Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, itself based on
>>> + * earlier NCR 53C710 work by Helge Deller and by Toni Wilen (for UAE).
>>>    *
>>> - * Contents:
>>> - * 1. Register Definitions
>>> - * 2. Register name functions
>>> - * 3. Parity functions
>>> - * 4. SCSI FIFO Structures
>>> - * 5. Scripts Misc functions
>>> - * 6. DMA functions
>>> - * 7. Scripts functions
>>> - * 8. Read and Write functions
>>> - * 9. QEMU Device model functions
>>> + * The only instantiated device is the LASI wrapper (lasi_ncr710.c), 
>>> which
>>> + * embeds one NCR710State by value and drives it through this file.
>>>    *
>>> + * SPDX-License-Identifier: GPL-2.0-or-later
>>>    */
>> 
>>> -/* SCNTL0 (0x00) - SCSI Control Register 0 */
>>> -#define NCR710_SCNTL0_TRG    0x01
>>> -#define NCR710_SCNTL0_AAP    0x02
>>> -#define NCR710_SCNTL0_EPG    0x04
>>> -#define NCR710_SCNTL0_EPC    0x08
>>> -#define NCR710_SCNTL0_WATN   0x10
>>> -#define NCR710_SCNTL0_START  0x20
>>> -#define NCR710_SCNTL0_ARB0   0x40
>>> -#define NCR710_SCNTL0_ARB1   0x80
>> 
>> 
>>> +/* SCNTL0 (0x00) */
>>> +#define NCR710_SCNTL0_TRG       0x01
>>> +#define NCR710_SCNTL0_AAP       0x02
>>> +#define NCR710_SCNTL0_EPG       0x04
>>> +#define NCR710_SCNTL0_EPC       0x08
>>> +#define NCR710_SCNTL0_WATN      0x10
>>> +#define NCR710_SCNTL0_START     0x20
>> 
>> These defines haven't actually changed, except that you've
>> reformatted the whitespace. If you want to adjust the whitespace,
>> that's a separate patch, but better still don't do that.
>> Then all this stuff doesn't appear in this patch at all
>> because it doesn't change.
>> 
>>> +static const char *const ncr710_reg_names[64] = {
>>> +    "SCNTL0", "SCNTL1", "SDID", "SIEN", "SCID", "SXFER", "SODL", "SOCL",
>>> +    "SFBR", "SIDL", "SBDL", "SBCL", "DSTAT", "SSTAT0", "SSTAT1", 
>>> "SSTAT2",
>>> +    "DSA0", "DSA1", "DSA2", "DSA3", "CTEST0", "CTEST1", "CTEST2", 
>>> "CTEST3",
>>> +    "CTEST4", "CTEST5", "CTEST6", "CTEST7", "TEMP0", "TEMP1", "TEMP2", 
>>> "TEMP3",
>>> +    "DFIFO", "ISTAT", "CTEST8", "LCRC", "DBC0", "DBC1", "DBC2", "DCMD",
>>> +    "DNAD0", "DNAD1", "DNAD2", "DNAD3", "DSP0", "DSP1", "DSP2", "DSP3",
>>> +    "DSPS0", "DSPS1", "DSPS2", "DSPS3", "SCRATCH0", "SCRATCH1", 
>>> "SCRATCH2",
>>> +    "SCRATCH3", "DMODE", "DIEN", "DWT", "DCNTL", "ADDER0", "ADDER1", 
>>> "ADDER2",
>>> +    "ADDER3",
>>> +};
>>> +
>>> +static const char *ncr710_reg_name(int offset)
>>>   {
>>> -    return (s->sien0 & NCR710_SSTAT0_SEL) != 0;
>>> +    return (offset >= 0 && offset < 64) ? ncr710_reg_names[offset] : 
>>> "???";
>>>   }
>> 
>> This is a rewrite of the old version of this function, to use
>> an array of strings instead of a big switch. It is definitely
>> nicer code, but this change can be done as its own patch.
>> 
>> 
>> Personally my experience is that it is much easier to
>> structure big changes into smaller pieces to start with,
>> rather than doing the big change first and then having
>> to break it up into smaller pieces later. Doing things
>> in smaller pieces makes it easier to isolate where bugs
>> or regressions are, both during development and later if
>> we need to git bisect once a change has landed.
>> 
>> thanks
>> -- PMM
>
>

