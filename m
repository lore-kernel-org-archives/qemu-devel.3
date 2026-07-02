Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03CC5C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 09:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfDJj-0005gF-PT; Thu, 02 Jul 2026 05:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfDJi-0005g7-UX
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:02:42 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfDJg-0006QL-Mc
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 05:02:42 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-664c6304683so1724547d50.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 02:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782982959; cv=none;
 d=google.com; s=arc-20260327;
 b=BQNrMN+j5kkIP5CtrfVp2VybAnNMDY97z0+1uYhdD6y4WphGWGEMOmbvvLxOnh3Gz7
 nhhDUOiiTt9g67JYObhHTQRu9YGdY2NNdBGC14R3IzbJYcWUzD+vbcB88dgbuPwYG3PA
 qVfujmMy47ZsT5gnJTrzev7ImgYzUreogRZAsnvCNAsjiNwVXAXiSMgaWeVAw5kSp8AY
 6KwbbSJ8t7rlFATX4eUrsp4PodgnQmyJjBNt43/Cxh6VnWYciwntFkbM5ERXo14ab692
 HCgUbQiaBZmGoyI5Dbin8V7IZsSS3Pe+3mvh5l2zSxR7liJXUAFl+sp9VC7y3r8erhu1
 fz/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=5gYN2qjVBtBTQ5nJ6M6qCJgilZ67etZ0J/zz1OGtp+M=;
 fh=HGXODa9OB5cWNbRQVqE+1o6+6x5YQ0NZnehMepI0wS8=;
 b=qWR4jr/no0O0cr4GC9inR8vSoZ5N9JnyYMw64zqzUdU6ij8fxRuiU63kmhlBJFfwJD
 tuO8/bO1tLfi58GZjolWFl/Bf75MrdLdyuT4o2lIML+GuCZrP0FEo3MTeAcMvbDvPFgD
 TyuFZ0Run/Nr89xsuUP4t5G9CE/Kulip3AiTDoWqx26mkbpxwvqkp7MQPUHpul/8BXZY
 yHzOX2xuL5FlFRsid/qa0yX+m4S7rfKoKkYmTRXJZKXxegXLGZUI/mvJbS04NcRnp6tj
 aEsQwtvOxs1pd22HCCZsPp8OJN+U5zQHvjoe/f9BsmBcbRRKmCNkNDOPNEv2i2Zgc8Fa
 OIjQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782982959; x=1783587759; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5gYN2qjVBtBTQ5nJ6M6qCJgilZ67etZ0J/zz1OGtp+M=;
 b=P2a5pEZT36I9/9zBigUScaES9bQU1JWKtT4HxDY8mMOtPxLCBjHwUeyICG23p00iI9
 Mv/GGU72SWnZIv7gOI4432wCjzBBVOvrUPvqEwmSrxeSCxvhpYvDY3Zanp6IaUqrFIe1
 C9VYzjmlEqNLg19YDZI3wH6kO/iMC7WcprLaFHZYvb6nPhgfJuh3ycZihv/hMv3SOitw
 c5XH0xJg+40Isa7zoVuSJKLK0eaz6ZtV2A/4tSN+SDsqH+3enMyiixi4r6Ta2OkPgjS0
 SxRs9bdE36M9cnvpfpOPqnC9O5sDv7TjlT9Seq2dHga6eUw62qrujw0Q5Je+Gr3f5vrA
 qjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782982959; x=1783587759;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=5gYN2qjVBtBTQ5nJ6M6qCJgilZ67etZ0J/zz1OGtp+M=;
 b=SCvjH0nUeeCTOXgiZN+zWXFKqIIT4FFZ1+O0hcAeuZe5JddUxEtyMUv2+Sy9pEhKfg
 Ubo6MdULFUHNFhcJtkzAYNi3xHcESjPXHtm3D3HtJZ2ZTI3pptM/miBdE8i7w6MfYzMA
 jOCPU7219Z9AfJz42Qop1TMFm6ngZL23aSOWgEJ94lHpwnuDstw61MSCJugGF2GIUKgR
 jclEiBZkcBisAHP2YpSjlD0HgeMEBcatx5CwJJ6VmXZCwcntPrYUFJoZqvXSCUoKszBy
 DjJNQHDwKJhmIjHcrH245h2h2aNkfXHyY754uNAHGBPPZYVLXK7elkYlavSTokejKQ4w
 1USg==
X-Gm-Message-State: AOJu0YzL2dEYhauedQ9W3oaltVBaXhDXN9DuLiKFmLjhDSCEnxIRUBQg
 q65FZPKv+hFwPIbpIEyFQp9DVuBrY/dizUnB7VxKByGoUrJkkYF6Va6H/fTOJx0wQyagS6R/TEI
 6HDX/iVa1Q+MkBbVIO+/SkitNtAq6w/VLt622Hbjllg==
X-Gm-Gg: AfdE7cnB2vGJpBr8xEZFMgM/xlrSsZ10xGw/shVxFpKQpi4scG7gLxhs94WcNn3otHR
 D44GAB+jDtGQDn1VDU/Dca31+5F5T53aAgUvLTgsI5kHcbyJ2tB7fb1Vl7wtfUePgrBRDK2v0U2
 YvBqzRe6j25USwmq/tR5s1YOG/YM//y/NOZa3r9vOT3S33348KEmNg09BaYTKWJqDTqSfdq2PHi
 NlomBrbA0Gir5js3LONV/0uqTZYbo374iUiU5KamBCRitfolhpagps5+ZZt4ZOHO/n1nKeW4kPa
 EViSI3pH/TYQoE9lSdRnByqJI1SxfPJ8PV3d1RIJg2I1N/Os+lFG0ZSr
X-Received: by 2002:a05:690e:128b:b0:664:ae69:2317 with SMTP id
 956f58d0204a3-665995c2ab2mr3698301d50.84.1782982958435; Thu, 02 Jul 2026
 02:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260701213359.1855870-1-keith@techtravels.org>
 <20260701213359.1855870-4-keith@techtravels.org>
In-Reply-To: <20260701213359.1855870-4-keith@techtravels.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 Jul 2026 10:02:27 +0100
X-Gm-Features: AVVi8CfMCTpgwh1zYY2AX1aRROBSDKqeBbt5RiB3-1IBng9JB1H9HEeetbYfRSE
Message-ID: <CAFEAcA_3vf5vrwoO0cGcdTsykU8uTf8386oyWki3iQ3Bje9Trw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw/scsi/ncr53c710: rewrite the SCRIPTS engine
To: Keith Monahan <keith@techtravels.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Wed, 1 Jul 2026 at 22:49, Keith Monahan <keith@techtravels.org> wrote:
>
> Replace the NCR 53C710 model with a SCRIPTS engine derived from QEMU's
> LSI53C895A model (hw/scsi/lsi53c895a.c), another device in the same
> NCR/LSI SCRIPTS family, adapted to the 53C710: its register map, the
> single-byte DSTAT/SSTAT0 interrupt model, big-endian SCRIPTS and
> table-indirect fetch (the part sits on the big-endian PA-RISC LASI bus),
> and 24-bit DMA byte counts.  Behaviour follows the NCR 53C710 Data Manual
> (Jun 1992) and Programmer's Guide (Oct 1990).
>
> The base engine supports connected I/O and reselection-interrupt
> disconnect, enough to install and boot Debian off the 710 with the Linux
> lasi700/53c700 driver and to boot NetBSD/hppa 9.4 and 10.1 (osiop) with
> disk and CD-ROM enumeration.  Reselection follows the 53C700 family:
> gated on the (re)selection interrupt enable (SIEN.SEL) alone, one-hot
> SDID, and an SFBR id bitmask in 700-compatibility mode.  SDTR/WDTR/PPR
> negotiation is declined with MESSAGE REJECT, which the 700-family drivers
> require to proceed: unlike the 8xx parts they leave the target to drive
> the phase after the reject.
>
> The LASI glue (hw/scsi/lasi_ncr710.c) embeds one NCR710State by value.
> It gains the free_request SCSIBusInfo callback and request-queue init the
> core needs, renames the reselection timer to scripts_timer, and narrows
> the SCSI bus to the 8-bit inclusive maxima.
>
> The migration format is incompatible with the model this replaces, so the
> vmstate version and minimum version are both raised.
>
> Signed-off-by: Keith Monahan <keith@techtravels.org>
> ---
>  hw/scsi/lasi_ncr710.c |  117 +-
>  hw/scsi/lasi_ncr710.h |   12 +-
>  hw/scsi/ncr53c710.c   | 2795 +++++++++++++++--------------------------
>  hw/scsi/ncr53c710.h   |  276 ++--
>  hw/scsi/trace-events  |   43 +-
>  5 files changed, 1191 insertions(+), 2052 deletions(-)

I'm likely not going to be the one doing detailed review here, so
my opinion here is not necessarily 100% controlling, but from my
perspective this is still significantly too large to review, both
in raw size terms and because it has a lot of changes in it that
do not all need or want to be in the same patch.

Just looking through the very early stuff to show some examples
of changes that don't need to be in this patch:

> @@ -50,22 +48,22 @@ static uint64_t lasi_ncr710_reg_read(void *opaque, hwaddr addr,
>      if (addr >= 0x100) {
>          hwaddr ncr_addr = addr - 0x100;
>          if (size == 1) {
> +            /*
> +             * Single byte access: flip the byte lane (PA-RISC big endian
> +             * access -> the chip's little endian register order).
> +             */
>              ncr_addr ^= 3;
> -            NCR710_DPRINTF("Reading value to LASI WRAPPER == 0x%lx%s, "
> -                           "val=0x%lx, size=%u\n",
> -                           addr - 0x100, size == 1 ? " (XORed)" : "",
> -                           val, size);
>              val = ncr710_reg_read(&s->ncr710, ncr_addr, size);
>          } else {
> +            /*
> +             * Multibyte access: gather little endian, no lane flip, so
> +             * the 24/32 bit registers assemble correctly.
> +             */
>              val = 0;

These are comment improvements to existing code. They don't need to be in
the big patch.

>              for (unsigned i = 0; i < size; i++) {
>                  uint8_t byte_val = ncr710_reg_read(&s->ncr710, ncr_addr + i, 1);
>                  val |= ((uint64_t)byte_val) << (i * 8);
> -                NCR710_DPRINTF("  Read byte %u from NCR addr 0x%lx: "
> -                               "0x%02x\n", i, ncr_addr + i, byte_val);
>              }
> -            NCR710_DPRINTF("  Reconstructed %u-byte value: 0x%lx\n",
> -                           size, val);

Here we drop some debug printfs. That can be done separately.

>          }
>
>          trace_lasi_ncr710_reg_forward_read(addr, val);
> @@ -83,7 +81,13 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
>
>      trace_lasi_ncr710_reg_write(addr, val, size);
>
> -    if (addr <= 0x0F) {
> +    /*
> +     * 0x00..0x0f is the read only LASI module header (ID/SVERSION/HVERSION) and
> +     * 0x10..0xff is unmapped module space; writes to both are ignored.  The
> +     * SCSI bus reset is driven through the chip's SCNTL1.RST at forwarded
> +     * offset 0x101 (see ncr53c710.c), not through this window.
> +     */
> +    if (addr <= 0x0f) {
>          return;
>      }

This is a better explanatory comment. That's not something that
needs to be in the big patch.

>
> @@ -92,16 +96,10 @@ static void lasi_ncr710_reg_write(void *opaque, hwaddr addr,
>
>          if (size == 1) {
>              ncr_addr ^= 3;
> -            NCR710_DPRINTF("Writing value to LASI WRAPPER == 0x%lx%s, "
> -                           "val=0x%lx, size=%u\n",
> -                           addr - 0x100, size == 1 ? " (XORed)" : "",
> -                           val, size);
>              ncr710_reg_write(&s->ncr710, ncr_addr, val, size);
>          } else {
>              for (unsigned i = 0; i < size; i++) {
>                  uint8_t byte_val = (val >> (i * 8)) & 0xff;
> -                 NCR710_DPRINTF("  Writing byte %u to NCR addr 0x%lx: 0x%02x\n",
> -                       i, ncr_addr + i, byte_val);
>                  ncr710_reg_write(&s->ncr710, ncr_addr + i, byte_val, 1);
>              }
>          }

Debug printfs being removed again.

> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
> index 57967e7a84..57cd7d91a4 100644
> --- a/hw/scsi/ncr53c710.c
> +++ b/hw/scsi/ncr53c710.c
> @@ -1,599 +1,308 @@
>  /*
> - * QEMU NCR710 SCSI Controller
> + * QEMU NCR 53C710 SCSI I/O Processor emulation
>   *
> - * Copyright (c) 2025 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> - * This driver was developed during the Google Summer of Code 2025 program.

Generally speaking you shouldn't drop somebody's Copyright line.
Even if the code has been mostly rewritten, there's still some
of Soumyajyotii's code here, I expect.

> + * Copyright (c) 2026 Keith Monahan <keith@techtravels.org>
> + * Copyright (c) 2006 CodeSourcery (lsi53c895a.c, written by Paul Brook)
>   *
> - * NCR710 SCSI Controller implementation
> - * Based on the NCR53C710 Technical Manual Version 3.2, December 2000
> + * A rewrite of the QEMU NCR 53C710 model.  The 53C710 is an early member of
> + * the NCR/LSI SCRIPTS processor family, so the SCRIPTS engine here is derived
> + * from QEMU's LSI53C895A model and adapted to the 53C710's register map,
> + * single byte interrupt model, big endian SCRIPTS fetch (PA-RISC) and 24 bit
> + * DMA, per the NCR 53C710 Data Manual (Jun 1992) and Programmer's Guide
> + * (Oct 1990).
>   *
> - * Developed from an implementation of NCR53C710 by Helge Deller
> - * which was interim based on the implementation by Toni Wilen for UAE.
> + * Derived from hw/scsi/lsi53c895a.c (Copyright (c) 2006 CodeSourcery, written
> + * by Paul Brook).
>   *
> - * SPDX-License-Identifier: GPL-2.0-or-later
> + * Replaces the 53C710 model written for Google Summer of Code 2025 by
> + * Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, itself based on
> + * earlier NCR 53C710 work by Helge Deller and by Toni Wilen (for UAE).
>   *
> - * Contents:
> - * 1. Register Definitions
> - * 2. Register name functions
> - * 3. Parity functions
> - * 4. SCSI FIFO Structures
> - * 5. Scripts Misc functions
> - * 6. DMA functions
> - * 7. Scripts functions
> - * 8. Read and Write functions
> - * 9. QEMU Device model functions
> + * The only instantiated device is the LASI wrapper (lasi_ncr710.c), which
> + * embeds one NCR710State by value and drives it through this file.
>   *
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */

> -/* SCNTL0 (0x00) - SCSI Control Register 0 */
> -#define NCR710_SCNTL0_TRG    0x01
> -#define NCR710_SCNTL0_AAP    0x02
> -#define NCR710_SCNTL0_EPG    0x04
> -#define NCR710_SCNTL0_EPC    0x08
> -#define NCR710_SCNTL0_WATN   0x10
> -#define NCR710_SCNTL0_START  0x20
> -#define NCR710_SCNTL0_ARB0   0x40
> -#define NCR710_SCNTL0_ARB1   0x80


> +/* SCNTL0 (0x00) */
> +#define NCR710_SCNTL0_TRG       0x01
> +#define NCR710_SCNTL0_AAP       0x02
> +#define NCR710_SCNTL0_EPG       0x04
> +#define NCR710_SCNTL0_EPC       0x08
> +#define NCR710_SCNTL0_WATN      0x10
> +#define NCR710_SCNTL0_START     0x20

These defines haven't actually changed, except that you've
reformatted the whitespace. If you want to adjust the whitespace,
that's a separate patch, but better still don't do that.
Then all this stuff doesn't appear in this patch at all
because it doesn't change.

> +static const char *const ncr710_reg_names[64] = {
> +    "SCNTL0", "SCNTL1", "SDID", "SIEN", "SCID", "SXFER", "SODL", "SOCL",
> +    "SFBR", "SIDL", "SBDL", "SBCL", "DSTAT", "SSTAT0", "SSTAT1", "SSTAT2",
> +    "DSA0", "DSA1", "DSA2", "DSA3", "CTEST0", "CTEST1", "CTEST2", "CTEST3",
> +    "CTEST4", "CTEST5", "CTEST6", "CTEST7", "TEMP0", "TEMP1", "TEMP2", "TEMP3",
> +    "DFIFO", "ISTAT", "CTEST8", "LCRC", "DBC0", "DBC1", "DBC2", "DCMD",
> +    "DNAD0", "DNAD1", "DNAD2", "DNAD3", "DSP0", "DSP1", "DSP2", "DSP3",
> +    "DSPS0", "DSPS1", "DSPS2", "DSPS3", "SCRATCH0", "SCRATCH1", "SCRATCH2",
> +    "SCRATCH3", "DMODE", "DIEN", "DWT", "DCNTL", "ADDER0", "ADDER1", "ADDER2",
> +    "ADDER3",
> +};
> +
> +static const char *ncr710_reg_name(int offset)
>  {
> -    return (s->sien0 & NCR710_SSTAT0_SEL) != 0;
> +    return (offset >= 0 && offset < 64) ? ncr710_reg_names[offset] : "???";
>  }

This is a rewrite of the old version of this function, to use
an array of strings instead of a big switch. It is definitely
nicer code, but this change can be done as its own patch.


Personally my experience is that it is much easier to
structure big changes into smaller pieces to start with,
rather than doing the big change first and then having
to break it up into smaller pieces later. Doing things
in smaller pieces makes it easier to isolate where bugs
or regressions are, both during development and later if
we need to git bisect once a change has landed.

thanks
-- PMM

