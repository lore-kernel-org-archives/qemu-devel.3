Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22A606A6A6
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Nov 2026 22:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUWrr-0007Sg-RM; Fri, 20 Nov 2026 17:14:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUWro-0007RL-Am
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:14:00 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1xUWri-0007g4-OZ
 for qemu-devel@nongnu.org; Fri, 20 Nov 2026 17:13:58 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CA5C160E017;
 Fri, 20 Nov 2026 23:13:52 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id MOON6KTz7Lvf; Fri, 20 Nov 2026 23:13:50 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 8BB1160CCE7; Fri, 20 Nov 2026 23:13:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 88D8F13C28F;
 Fri, 20 Nov 2026 23:13:50 +0100 (CET)
Date: Fri, 20 Nov 2026 23:13:50 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Fam Zheng <fam@euphon.net>, Keith Monahan <keith@techtravels.org>
Subject: Re: [RFC PATCH-for-11.2??? v4 07/14] hw/scsi/ncr53c710: Rewrite the
 53C710 SCRIPTS engine
In-Reply-To: <20261120171235.61325-8-philmd@oss.qualcomm.com>
Message-ID: <6186405e-08f7-ab8b-287c-3f58598a63b0@eik.bme.hu>
References: <20261120171235.61325-1-philmd@oss.qualcomm.com>
 <20261120171235.61325-8-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1004174178-1795212830=:80696"
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1004174178-1795212830=:80696
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT

On Fri, 20 Nov 2026, Philippe Mathieu-Daudé wrote:
> From: Keith Monahan <keith@techtravels.org>
>
> Rewrite the NCR 53C710 model with a SCRIPTS engine derived from QEMU's
> LSI53C895A model (hw/scsi/lsi53c895a.c), an actively maintained sibling
> in the same NCR/LSI SCRIPTS family, adapted to the 53C710: its register
> map, single byte (DSTAT/SSTAT0) interrupt model, big endian SCRIPTS and
> table indirect fetch (the part sits on the big endian PA-RISC LASI bus),
> and 24 bit DMA counts.  Behaviour follows the NCR 53C710 Data Manual
> (Jun 1992) and Programmer's Guide (Oct 1990).
>
> The LASI glue (hw/scsi/lasi_ncr710.c) is the only instantiated device
> and embeds one NCR710State by value.  It gains the free_request
> SCSIBusInfo callback and request queue init the new core needs, renames
> the reselection timer to scripts_timer, and drops the old model's dead
> scaffolding (the unused SCNR define, the DPRINTF macros, and unused or
> shadowing register macros).
>
> Disconnect and reselect, adapted from lsi53c895a, let a driver overlap
> tagged commands: a disconnecting command's request moves onto a per
> device queue and is reselected once its data is ready and the engine is
> parked at Wait Reselect.  Reselection follows the 53C700 family rather
> than the 8xx parts: gated on the (re)selection interrupt enable
> (SIEN.SEL) alone, one hot SDID, an SFBR id bitmask in 700 compatibility
> mode, and IDENTIFY (plus SIMPLE QUEUE TAG when tagged) replayed on
> reconnect.  A disconnect is fabricated only for a tagged command under a
> driver that parks on Wait Reselect with SIEN.SEL clear, which today
> means HP-UX; untagged transfers and reselection interrupt drivers (e.g.
> Linux 53c700) keep the existing connected completion path.
>
> SDTR/WDTR/PPR negotiation is declined with MESSAGE REJECT.
>
> Completion deferral, the synchronous drain, the HP-UX MESSAGE REJECT
> quirk, the reentrancy guard and the soft reset request cancel are added
> by the following patches, as is the migration version bump: this patch
> does not preserve the migration stream of the model it replaces.
>
> Derived from hw/scsi/lsi53c895a.c (Copyright (c) 2006 CodeSourcery,
> written by Paul Brook), which is LGPL; this derived work is distributed
> under GPL-2.0-or-later, as the LGPL permits.  Replaces the 53C710 model
> written for Google Summer of Code 2025 by Soumyajyotii Ssarkar, itself
> based on earlier NCR 53C710 work by Helge Deller and by Toni Wilen (for
> UAE).
>
> Signed-off-by: Keith Monahan <keith@techtravels.org>
> Signed-off-by: Helge Deller <deller@gmx.de>
> AI-used-for: Patch series decomposition (commit splitting and ordering)
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
> hw/scsi/lasi_ncr710.h |   28 +-
> hw/scsi/ncr53c710.h   |  263 ++--
> hw/scsi/lasi_ncr710.c |  108 +-
> hw/scsi/ncr53c710.c   | 2843 ++++++++++++++---------------------------
> hw/scsi/trace-events  |   42 +-
> 5 files changed, 1131 insertions(+), 2153 deletions(-)
[...]
> diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
> index 55153418e409..305958b92f4a 100644
> --- a/hw/scsi/ncr53c710.c
> +++ b/hw/scsi/ncr53c710.c
> @@ -1,1497 +1,958 @@
> /*
> - * QEMU NCR710 SCSI Controller
> + * QEMU NCR 53C710 SCSI I/O Processor emulation
>  *
> - * Copyright (c) 2025 Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> - * This driver was developed during the Google Summer of Code 2025 program.
> + * Copyright (c) 2026 Keith Monahan <keith@techtravels.org>
> + * Copyright (c) 2006 CodeSourcery (lsi53c895a.c, written by Paul Brook)
>  *
> - * NCR710 SCSI Controller implementation
> - * Based on the NCR53C710 Technical Manual Version 3.2, December 2000
> + * The SCRIPTS engine is derived from QEMU's LSI53C895A model and adapted to
> + * the 53C710's register map, single byte interrupt model, big endian SCRIPTS
> + * fetch and 24 bit DMA, per the NCR 53C710 Data Manual and Programmer's Guide.
>  *
> - * Developed from an implementation of NCR53C710 by Helge Deller
> - * which was interim based on the implementation by Toni Wilen for UAE.
> + * Replaces the 53C710 model written for Google Summer of Code 2025 by
> + * Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>, itself based on
> + * earlier NCR 53C710 work by Helge Deller and by Toni Wilen (for UAE).
>  *
>  * SPDX-License-Identifier: GPL-2.0-or-later
> - *
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
> - *
>  */
>
> #include "qemu/osdep.h"
> -#include "qapi/error.h"
> -#include "qemu/timer.h"
> -#include "hw/core/irq.h"
> -#include "hw/core/sysbus.h"
> -#include "hw/scsi/scsi.h"
> -#include "hw/scsi/ncr53c710.h"
> -#include "migration/vmstate.h"
> -#include "system/dma.h"
> +#include "qemu/bitops.h"
> #include "qemu/log.h"
> -#include "qemu/module.h"
> +#include "qemu/main-loop.h"
> +#include "hw/core/irq.h"
> +#include "hw/scsi/ncr53c710.h"
> +#include "system/block-backend.h"
> #include "trace.h"
> -#include "qom/object.h"
>
> -#define NCR710_MAX_DEVS 7
> +/* SCNTL0 (0x00) */
> +#define LSI_SCNTL0_EPG       0x04
>
> -/* SCNTL0 (0x00) - SCSI Control Register 0 */
> -#define NCR710_SCNTL0_TRG    0x01
> -#define NCR710_SCNTL0_AAP    0x02
> -#define NCR710_SCNTL0_EPG    0x04
> -#define NCR710_SCNTL0_EPC    0x08
> -#define NCR710_SCNTL0_WATN   0x10
> -#define NCR710_SCNTL0_START  0x20
> -#define NCR710_SCNTL0_ARB0   0x40
> -#define NCR710_SCNTL0_ARB1   0x80
> +/* SCNTL1 (0x01) */
> +#define LSI_SCNTL1_ESR       0x20
>
> -/* SCNTL1 (0x01) - SCSI Control Register 1 */
> -#define NCR710_SCNTL1_RES0   0x01
> -#define NCR710_SCNTL1_RES1   0x02
> -#define NCR710_SCNTL1_AESP   0x04
> -#define NCR710_SCNTL1_RST    0x08
> -#define NCR710_SCNTL1_CON    0x10
> -#define NCR710_SCNTL1_ESR    0x20
> -#define NCR710_SCNTL1_ADB    0x40
> -#define NCR710_SCNTL1_EXC    0x80
> +/* SSTAT0 (0x0d) and SIEN (0x03) share this bit layout. */
> +#define LSI_STAT0_PAR        0x01
> +#define LSI_STAT0_RST        0x02
> +#define LSI_STAT0_UDC        0x04
> +#define LSI_STAT0_SGE        0x08
> +#define LSI_STAT0_SEL        0x10
> +#define LSI_STAT0_STO        0x20
> +#define LSI_STAT0_FCMP       0x40
> +#define LSI_STAT0_MA         0x80
>
> -/* ISTAT (0x21) - Interrupt Status Register */
> -#define NCR710_ISTAT_DIP    0x01
> -#define NCR710_ISTAT_SIP    0x02
> -#define NCR710_ISTAT_CON    0x08
> -#define NCR710_ISTAT_SIGP   0x20
> -#define NCR710_ISTAT_RST    0x40
> -#define NCR710_ISTAT_ABRT   0x80
> +/* DSTAT (0x0c) and DIEN (0x39) share this bit layout. */
> +#define LSI_DSTAT_WTD        0x02
>
> -/* SSTAT0 (0x0D) - SCSI Status Register 0 */
> -#define NCR710_SSTAT0_PAR    0x01
> -#define NCR710_SSTAT0_RST    0x02
> -#define NCR710_SSTAT0_UDC    0x04
> -#define NCR710_SSTAT0_SGE    0x08
> -#define NCR710_SSTAT0_SEL    0x10
> -#define NCR710_SSTAT0_STO    0x20
> -#define NCR710_SSTAT0_FCMP   0x40
> -#define NCR710_SSTAT0_MA     0x80
> +/* SBCL (0x0b): low 3 bits mirror the SCSI phase, upper bits are bus signals. */
> +#define LSI_SBCL_SEL         0x10
>
> -/* SSTAT1 (0x0E) - SCSI Status Register 1 */
> -#define NCR710_SSTAT1_ORF    0x02
> -#define NCR710_SSTAT1_ILF    0x04
> +/* DCNTL (0x3b) */
> +#define LSI_DCNTL_FA         0x02
> +#define LSI_DCNTL_LLM        0x08
> +#define LSI_DCNTL_EA         0x20
>
> -/* SSTAT2 (0x0F) - SCSI Status Register 2 */
> -#define NCR710_SSTAT2_FF0    0x01
> -#define NCR710_SSTAT2_FF1    0x02
> -#define NCR710_SSTAT2_FF2    0x04
> -#define NCR710_SSTAT2_FF3    0x08
> +#define LSI_BUF_SIZE     4096
>
> -/* SOCL (0x07) / SBCL (0x0B) - SCSI Output/Bus Control Lines */
> -#define NCR710_SOCL_IO       0x01
> -#define NCR710_SOCL_CD       0x02
> -#define NCR710_SOCL_MSG      0x04
> -#define NCR710_SOCL_ATN      0x08
> -#define NCR710_SOCL_SEL      0x10
> -#define NCR710_SOCL_BSY      0x20
> -#define NCR710_SOCL_ACK      0x40
> -#define NCR710_SOCL_REQ      0x80
> +static const char *const lsi_reg_names[64] = {
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
>
> -/* SBCL bits same as SOCL */
> -#define NCR710_SBCL_IO       0x01
> -#define NCR710_SBCL_CD       0x02
> -#define NCR710_SBCL_MSG      0x04
> -#define NCR710_SBCL_ATN      0x08
> -#define NCR710_SBCL_SEL      0x10
> -#define NCR710_SBCL_BSY      0x20
> -#define NCR710_SBCL_ACK      0x40
> -#define NCR710_SBCL_REQ      0x80
> -
> -/* DSTAT (0x0C) - DMA Status Register */
> -#define NCR710_DSTAT_IID     0x01
> -#define NCR710_DSTAT_SIR     0x04
> -#define NCR710_DSTAT_SSI     0x08
> -#define NCR710_DSTAT_ABRT    0x10
> -#define NCR710_DSTAT_BF      0x20
> -#define NCR710_DSTAT_MDPE    0x40
> -#define NCR710_DSTAT_DFE     0x80
> -
> -/* DCNTL (0x3B) - DMA Control Register */
> -#define NCR710_DCNTL_COM     0x01
> -#define NCR710_DCNTL_IRQD    0x02
> -#define NCR710_DCNTL_STD     0x04
> -#define NCR710_DCNTL_IRQM    0x08
> -#define NCR710_DCNTL_SSM     0x10
> -#define NCR710_DCNTL_PFEN    0x20
> -#define NCR710_DCNTL_PFF     0x40
> -
> -/* DMODE (0x38) - DMA Mode Register */
> -#define NCR710_DMODE_MAN     0x01
> -#define NCR710_DMODE_BOF     0x02
> -#define NCR710_DMODE_ERMP    0x04
> -#define NCR710_DMODE_ERL     0x08
> -#define NCR710_DMODE_DIOM    0x10
> -#define NCR710_DMODE_SIOM    0x20
> -#define NCR710_DMODE_BL_MASK 0xC0
> -#define NCR710_DMODE_BL_1    0x00
> -#define NCR710_DMODE_BL_2    0x40
> -#define NCR710_DMODE_BL_4    0x80
> -#define NCR710_DMODE_BL_8    0xC0
> -
> -/* CTEST2 (0x16) - Chip Test Register 2 */
> -#define NCR710_CTEST2_DACK   0x01
> -#define NCR710_CTEST2_DREQ   0x02
> -#define NCR710_CTEST2_TEOP   0x04
> -#define NCR710_CTEST2_PCICIE 0x08
> -#define NCR710_CTEST2_CM     0x10
> -#define NCR710_CTEST2_CIO    0x20
> -#define NCR710_CTEST2_SIGP   0x40
> -#define NCR710_CTEST2_DDIR   0x80
> -
> -/* CTEST5 (0x19) - Chip Test Register 5 */
> -#define NCR710_CTEST5_BL2    0x04
> -#define NCR710_CTEST5_DDIR   0x08
> -#define NCR710_CTEST5_MASR   0x10
> -#define NCR710_CTEST5_DFSN   0x20
> -#define NCR710_CTEST5_BBCK   0x40
> -#define NCR710_CTEST5_ADCK   0x80
> -
> -/* SCID (0x04) - SCSI Chip ID Register */
> -#define NCR710_SCID_RRE      0x60
> -#define NCR710_SCID_ID_MASK  0x07
> -
> -#define NCR710_HOST_ID       7
> -
> -/* NCR53C710 has 8-byte SCSI FIFO */
> -#define NCR710_MAX_MSGIN_LEN 8
> -#define NCR710_BUF_SIZE         4096
> -
> -/* Standard SCSI Message Byte Constants */
> -#define SCSI_MSG_ABORT                      0x06
> -#define SCSI_MSG_BUS_DEVICE_RESET           0x0c
> -#define SCSI_MSG_COMMAND_COMPLETE           0x00
> -#define SCSI_MSG_DISCONNECT                 0x04
> -#define SCSI_MSG_EXTENDED_MESSAGE           0x01
> -#define SCSI_MSG_IDENTIFY                   0x80
> -#define SCSI_MSG_IGNORE_WIDE_RESIDUE        0x23
> -#define SCSI_MSG_MESSAGE_PARITY_ERROR       0x09
> -#define SCSI_MSG_MESSAGE_REJECT             0x07
> -#define SCSI_MSG_NO_OPERATION               0x08
> -#define SCSI_MSG_RELEASE_RECOVERY           0x10
> -#define SCSI_MSG_RESTORE_POINTERS           0x03
> -#define SCSI_MSG_SAVE_DATA_POINTER          0x02
> -#define SCSI_MSG_SYNCHRONOUS_DATA_TRANSFER  0x01
> -#define SCSI_MSG_WIDE_DATA_TRANSFER         0x03
> -
> -/* Script interrupt codes */
> -#define A_GOOD_STATUS_AFTER_STATUS          0x401
> -#define A_DISCONNECT_AFTER_CMD              0x380
> -#define A_DISCONNECT_AFTER_DATA             0x580
> -#define A_DISCONNECT_DURING_DATA            0x780
> -#define A_RESELECTION_IDENTIFIED            0x1003
> -#define A_UNEXPECTED_PHASE                  0x20
> -#define A_FATAL                             0x2000
> -#define A_DEBUG_INTERRUPT                   0x3000
> -
> -/* SCSI Script execution states */
> -#define SCRIPT_STATE_IDLE                  0
> -#define SCRIPT_STATE_SELECTING             1
> -#define SCRIPT_STATE_COMMAND               2
> -#define SCRIPT_STATE_DATA                  3
> -#define SCRIPT_STATE_STATUS                4
> -#define SCRIPT_STATE_MESSAGE               5
> -#define SCRIPT_STATE_DISCONNECTED          6
> -
> -#define AFTER_SELECTION         0x100
> -#define BEFORE_CMD              0x200
> -#define AFTER_CMD               0x300
> -#define AFTER_STATUS            0x400
> -#define AFTER_DATA_IN           0x500
> -#define AFTER_DATA_OUT          0x600
> -#define DURING_DATA_IN          0x700
> -
> -#define NOT_MSG_OUT             0x10
> -#define UNEXPECTED_PHASE        0x20
> -#define NOT_MSG_IN              0x30
> -#define UNEXPECTED_MSG          0x40
> -#define MSG_IN                  0x50
> -#define SDTR_MSG_R              0x60
> -#define REJECT_MSG_R            0x70
> -#define DISCONNECT              0x80
> -#define MSG_OUT                 0x90
> -#define WDTR_MSG_R              0xA0
> -
> -#define GOOD_STATUS             0x1
> -
> -#define NOT_MSG_OUT_AFTER_SELECTION         0x110
> -#define UNEXPECTED_PHASE_BEFORE_CMD         0x220
> -#define UNEXPECTED_PHASE_AFTER_CMD          0x320
> -#define NOT_MSG_IN_AFTER_STATUS             0x430
> -#define GOOD_STATUS_AFTER_STATUS            0x401
> -#define UNEXPECTED_PHASE_AFTER_DATA_IN      0x520
> -#define UNEXPECTED_PHASE_AFTER_DATA_OUT     0x620
> -#define UNEXPECTED_MSG_BEFORE_CMD           0x240
> -#define MSG_IN_BEFORE_CMD                   0x250
> -#define MSG_IN_AFTER_CMD                    0x350
> -#define SDTR_MSG_BEFORE_CMD                 0x260
> -#define REJECT_MSG_BEFORE_CMD               0x270
> -#define DISCONNECT_AFTER_CMD                0x380
> -#define SDTR_MSG_AFTER_CMD                  0x360
> -#define WDTR_MSG_AFTER_CMD                  0x3A0
> -#define MSG_IN_AFTER_STATUS                 0x440
> -#define DISCONNECT_AFTER_DATA               0x580
> -#define MSG_IN_AFTER_DATA_IN                0x550
> -#define MSG_IN_AFTER_DATA_OUT               0x650
> -#define MSG_OUT_AFTER_DATA_IN               0x590
> -#define DATA_IN_AFTER_DATA_IN               0x5a0
> -#define MSG_IN_DURING_DATA_IN               0x750
> -#define DISCONNECT_DURING_DATA              0x780
> -
> -#define RESELECTED_DURING_SELECTION      0x1000
> -#define COMPLETED_SELECTION_AS_TARGET    0x1001
> -#define RESELECTION_IDENTIFIED           0x1003
> -
> -#define FATAL                            0x2000
> -#define FATAL_UNEXPECTED_RESELECTION_MSG 0x2000
> -#define FATAL_SEND_MSG                   0x2001
> -#define FATAL_NOT_MSG_IN_AFTER_SELECTION 0x2002
> -#define FATAL_ILLEGAL_MSG_LENGTH         0x2003
> -
> -#define DEBUG_INTERRUPT     0x3000
> -#define DEBUG_INTERRUPT1    0x3001
> -#define DEBUG_INTERRUPT2    0x3002
> -#define DEBUG_INTERRUPT3    0x3003
> -#define DEBUG_INTERRUPT4    0x3004
> -#define DEBUG_INTERRUPT5    0x3005
> -#define DEBUG_INTERRUPT6    0x3006
> -
> -#define COMMAND_COMPLETE_MSG      0x00
> -#define EXTENDED_MSG              0x01
> -#define SDTR_MSG                  0x01
> -#define SAVE_DATA_PTRS_MSG        0x02
> -#define RESTORE_DATA_PTRS_MSG     0x03
> -#define WDTR_MSG                  0x03
> -#define DISCONNECT_MSG            0x04
> -#define REJECT_MSG                0x07
> -#define PARITY_ERROR_MSG          0x09
> -#define SIMPLE_TAG_MSG            0x20
> -#define IDENTIFY_MSG              0x80
> -#define IDENTIFY_MSG_MASK         0x7F
> -#define TWO_BYTE_MSG              0x20
> -#define TWO_BYTE_MSG_MASK         0x0F
> -
> -/* SCSI phases */
> -#define PHASE_DO   0  /* Data out phase */
> -#define PHASE_DI   1  /* Data in phase */
> -#define PHASE_CO   2  /* Command phase */
> -#define PHASE_SI   3  /* Status phase */
> -#define PHASE_ST   3  /* Status phase (alias) */
> -#define PHASE_MO   6  /* Message out phase */
> -#define PHASE_MI   7  /* Message in phase */
> -#define PHASE_MASK 7  /* Mask for phase bits */
> -
> -#define NCR710_TAG_VALID     (1 << 16)
> -
> -static void ncr710_scsi_fifo_init(NCR710_SCSI_FIFO *fifo);
> -static const char *ncr710_reg_name(int offset);
> -static void ncr710_script_scsi_interrupt(NCR710State *s, int stat0);
> -static void ncr710_update_irq(NCR710State *s);
> -static void ncr710_script_dma_interrupt(NCR710State *s, int stat);
> -static void ncr710_request_free(NCR710State *s, NCR710Request *p);
> -static inline void ncr710_dma_read(NCR710State *s, uint32_t addr,
> -                                   void *buf, uint32_t len);
> -static inline void ncr710_dma_write(NCR710State *s, uint32_t addr,
> -                                    const void *buf, uint32_t len);
> -static uint8_t ncr710_reg_readb(NCR710State *s, int offset);
> -static void ncr710_reg_writeb(NCR710State *s, int offset, uint8_t val);
> -
> -
> -static inline int ncr710_irq_on_rsl(NCR710State *s)
> +static const char *lsi_reg_name(int offset)
> {
> -    return (s->sien0 & NCR710_SSTAT0_SEL) != 0;
> +    return (offset >= 0 && offset < 64) ? lsi_reg_names[offset] : "???";
> }
>
> -static void ncr710_clear_pending_irq(NCR710State *s)
> +static uint8_t lsi_reg_readb(NCR710State *s, int offset);
> +static void lsi_reg_writeb(NCR710State *s, int offset, uint8_t val);
> +static void lsi_execute_script(NCR710State *s);
> +static void lsi_set_phase(NCR710State *s, int phase);
> +
> +/*
> + * On the 53C700 family the Select/Reselect destination ID and SDID are a one
> + * hot bitmask, unlike the 53C8xx's binary target number.
> + */
> +static int lsi_id_from_bits(unsigned bits)
> {
> -    if (s->current) {
> -        if (s->current->req) {
> -            s->current->req->hba_private = NULL;
> +    int i;
> +
> +    bits &= 0xff;
> +    for (i = 0; i < 8; i++) {
> +        if (bits & (1u << i)) {
> +            return i;
>         }
> -        ncr710_request_free(s, s->current);
> -        s->current = NULL;
>     }
> +    qemu_log_mask(LOG_GUEST_ERROR,
> +                  "ncr710: empty destination ID bitmask; defaulting to ID 0\n");
> +    return 0;
> }
>
> void ncr710_soft_reset(NCR710State *s)
> {
>     trace_ncr710_reset();
> +
>     s->carry = 0;
> -    s->msg_action = NCR710_MSG_ACTION_NONE;
> +    s->msg_action = LSI_MSG_ACTION_COMMAND;
>     s->msg_len = 0;
> -    s->waiting = NCR710_WAIT_NONE;
> -    s->wait_reselect = false;
> -    s->reselection_id = 0;
> -    s->dsa = 0;
> -    s->dnad = 0;
> -    s->dbc = 0;
> -    s->temp = 0;
> -    s->scratch = 0;
> -    s->istat &= 0x40;
> -    s->dcmd = 0x40;
> -    s->dstat = NCR710_DSTAT_DFE;
> -    s->dien = 0x04;
> -    s->sien0 = 0;
> -    s->ctest2 = NCR710_CTEST2_DACK;
> -    s->ctest3 = 0;
> -    s->ctest4 = 0;
> -    s->ctest5 = 0;
> -    s->dsp = 0;
> -    s->dsps = 0;
> -    s->dmode &= NCR710_DMODE_FC1;
> -    s->dcntl &= NCR710_DCNTL_EA;
> -    s->scntl0 = 0xc0;
> +    s->waiting = LSI_NOWAIT;
> +    s->current_lun = 0;
> +    s->select_tag = 0;
> +    s->command_complete = 0;
> +    s->script_running = false;
> +
> +    s->scntl0 = 0xc0;       /* full arbitration */
>     s->scntl1 = 0;
> +    s->sdid = 0;
> +    s->sien = 0;
> +    s->scid = 0;
> +    s->sxfer = 0;
> +    s->sodl = 0;
> +    s->socl = 0;
> +    s->sfbr = 0;
> +    s->sidl = 0;
> +    s->sbdl = 0;
> +    s->sbcl = 0;
> +    s->dstat = 0;           /* DFE is OR'd in on read */
>     s->sstat0 = 0;
>     s->sstat1 = 0;
>     s->sstat2 = 0;
> -    s->scid = 0x80;
> -    s->sxfer = 0;
> -    s->socl = 0;
> -    s->sdid = 0;
> -    s->sbcl = 0;
> -    s->sidl = 0;
> -    s->sfbr = 0;
> -    qemu_set_irq(s->irq, 0);
> -    if (s->current && s->current->req) {
> -        /* Drops hba_private via ncr710_request_cancelled() */
> -        scsi_req_cancel(s->current->req);
> -    }
> -    ncr710_clear_pending_irq(s);
> -    ncr710_scsi_fifo_init(&s->scsi_fifo);
> -}
> +    s->dsa = 0;
> +    s->ctest0 = 0;
> +    s->ctest3 = 0;
> +    s->ctest4 = 0;
> +    s->ctest5 = 0;
> +    s->ctest7 = 0;
> +    s->temp = 0;
> +    s->dfifo = 0;
> +    s->istat = 0;
> +    s->lcrc = 0;
> +    s->dbc = 0;
> +    s->dcmd = 0;
> +    s->dnad = 0;
> +    s->dsp = 0;
> +    s->dsps = 0;
> +    s->scratch = 0;
> +    s->dmode &= NCR710_DMODE_FC1;
> +    s->dien = 0;
> +    s->dwt = 0;
> +    s->dcntl &= NCR710_DCNTL_EA;
> +    s->adder = 0;
>
> -static const char *ncr710_reg_name(int offset)
> -{
> -    switch (offset) {
> -    case NCR710_SCNTL0_REG:      return "SCNTL0";
> -    case NCR710_SCNTL1_REG:      return "SCNTL1";
> -    case NCR710_SDID_REG:        return "SDID";
> -    case NCR710_SIEN_REG:        return "SIEN";
> -    case NCR710_SCID_REG:        return "SCID";
> -    case NCR710_SXFER_REG:       return "SXFER";
> -    case NCR710_SODL_REG:        return "SODL";
> -    case NCR710_SOCL_REG:        return "SOCL";
> -    case NCR710_SFBR_REG:        return "SFBR";
> -    case NCR710_SIDL_REG:        return "SIDL";
> -    case NCR710_SBDL_REG:        return "SBDL";
> -    case NCR710_SBCL_REG:        return "SBCL";
> -    case NCR710_DSTAT_REG:       return "DSTAT";
> -    case NCR710_SSTAT0_REG:      return "SSTAT0";
> -    case NCR710_SSTAT1_REG:      return "SSTAT1";
> -    case NCR710_SSTAT2_REG:      return "SSTAT2";
> -    case NCR710_DSA_REG:         return "DSA";
> -    case NCR710_DSA_REG + 1:     return "DSA+1";
> -    case NCR710_DSA_REG + 2:     return "DSA+2";
> -    case NCR710_DSA_REG + 3:     return "DSA+3";
> -    case NCR710_CTEST0_REG:      return "CTEST0";
> -    case NCR710_CTEST1_REG:      return "CTEST1";
> -    case NCR710_CTEST2_REG:      return "CTEST2";
> -    case NCR710_CTEST3_REG:      return "CTEST3";
> -    case NCR710_CTEST4_REG:      return "CTEST4";
> -    case NCR710_CTEST5_REG:      return "CTEST5";
> -    case NCR710_CTEST6_REG:      return "CTEST6";
> -    case NCR710_CTEST7_REG:      return "CTEST7";
> -    case NCR710_TEMP_REG:        return "TEMP";
> -    case NCR710_TEMP_REG + 1:    return "TEMP+1";
> -    case NCR710_TEMP_REG + 2:    return "TEMP+2";
> -    case NCR710_TEMP_REG + 3:    return "TEMP+3";
> -    case NCR710_DFIFO_REG:       return "DFIFO";
> -    case NCR710_ISTAT_REG:       return "ISTAT";
> -    case NCR710_CTEST8_REG:      return "CTEST8";
> -    case NCR710_LCRC_REG:        return "LCRC";
> -    case NCR710_DBC_REG:         return "DBC";
> -    case NCR710_DBC_REG + 1:     return "DBC+1";
> -    case NCR710_DBC_REG + 2:     return "DBC+2";
> -    case NCR710_DCMD_REG:        return "DCMD";
> -    case NCR710_DNAD_REG:        return "DNAD";
> -    case NCR710_DNAD_REG + 1:    return "DNAD+1";
> -    case NCR710_DNAD_REG + 2:    return "DNAD+2";
> -    case NCR710_DNAD_REG + 3:    return "DNAD+3";
> -    case NCR710_DSP_REG:         return "DSP";
> -    case NCR710_DSP_REG + 1:     return "DSP+1";
> -    case NCR710_DSP_REG + 2:     return "DSP+2";
> -    case NCR710_DSP_REG + 3:     return "DSP+3";
> -    case NCR710_DSPS_REG:        return "DSPS";
> -    case NCR710_DSPS_REG + 1:    return "DSPS+1";
> -    case NCR710_DSPS_REG + 2:    return "DSPS+2";
> -    case NCR710_DSPS_REG + 3:    return "DSPS+3";
> -    case NCR710_SCRATCH_REG:     return "SCRATCH";
> -    case NCR710_SCRATCH_REG + 1: return "SCRATCH+1";
> -    case NCR710_SCRATCH_REG + 2: return "SCRATCH+2";
> -    case NCR710_SCRATCH_REG + 3: return "SCRATCH+3";
> -    case NCR710_DMODE_REG:       return "DMODE";
> -    case NCR710_DIEN_REG:        return "DIEN";
> -    case NCR710_DWT_REG:         return "DWT";
> -    case NCR710_DCNTL_REG:       return "DCNTL";
> -    case NCR710_ADDER_REG:       return "ADDER";
> -    case NCR710_ADDER_REG + 1:   return "ADDER+1";
> -    case NCR710_ADDER_REG + 2:   return "ADDER+2";
> -    case NCR710_ADDER_REG + 3:   return "ADDER+3";
> -    default:                     return "UNKNOWN";
> +    if (s->scripts_timer) {
> +        timer_del(s->scripts_timer);
>     }
> }
>
> -static uint8_t ncr710_generate_scsi_parity(NCR710State *s, uint8_t data)
> +static inline void lsi_mem_read(NCR710State *s, uint32_t addr,
> +                                void *buf, uint32_t len)
> {
> -    uint8_t parity = parity8(data);
> -
> -    if (s->scntl1 & NCR710_SCNTL1_AESP) {
> -        parity = !parity;
> -    }
> -
> -    return parity;
> +    address_space_read(s->as, addr, MEMTXATTRS_UNSPECIFIED, buf, len);
> }
>
> -static bool ncr710_check_scsi_parity(NCR710State *s, uint8_t data,
> -                                     uint8_t parity)
> +static inline void lsi_mem_write(NCR710State *s, uint32_t addr,
> +                                 const void *buf, uint32_t len)
> {
> -    if (!(s->scntl0 & NCR710_SCNTL0_EPC)) {
> -        return true;
> -    }
> -
> -    uint8_t expected_parity = ncr710_generate_scsi_parity(s, data);
> -    return parity == expected_parity;
> +    address_space_write(s->as, addr, MEMTXATTRS_UNSPECIFIED, buf, len);
> }
>
> -static void ncr710_handle_parity_error(NCR710State *s)
> -{
> -    s->sstat0 |= NCR710_SSTAT0_PAR;
> -
> -    /* If parity error ATN is enabled, assert ATN */
> -    if (s->scntl0 & NCR710_SCNTL0_AAP) {
> -        s->socl |= NCR710_SOCL_ATN;
> -    }
> -
> -    ncr710_script_scsi_interrupt(s, NCR710_SSTAT0_PAR);
> -}
> -
> -/*
> - * NCR710 SCSI FIFO IMPLEMENTATION
> - *
> - * Hardware Specifications (NCR53C710 datasheet):
> - * - Width: 9 bits (8 data bits + 1 parity bit)
> - * - Depth: 8 bytes
> - * - Type: Circular buffer
> - *
> - * Implementation:
> - * - Enqueue: Add byte at tail position ((head + count) % 8)
> - * - Dequeue: Remove byte from head position, advance head
> - * - Status: Empty (count=0), Full (count=8)
> - *
> - * FIFO Operations:
> - * - ncr710_scsi_fifo_init()    - Reset FIFO to empty state
> - * - ncr710_scsi_fifo_enqueue() - Add byte with parity to tail
> - * - ncr710_scsi_fifo_dequeue() - Remove byte with parity from head
> - * - ncr710_scsi_fifo_empty()   - Check if FIFO is empty
> - * - ncr710_scsi_fifo_full()    - Check if FIFO is full
> - */
> -
> -static void ncr710_scsi_fifo_init(NCR710_SCSI_FIFO *fifo)
> -{
> -    memset(fifo->data, 0, NCR710_SCSI_FIFO_SIZE);
> -    memset(fifo->parity, 0, NCR710_SCSI_FIFO_SIZE);
> -    fifo->head = 0;
> -    fifo->count = 0;
> -}
> -
> -static inline bool ncr710_scsi_fifo_empty(NCR710_SCSI_FIFO *fifo)
> -{
> -    return fifo->count == 0;
> -}
> -
> -static inline bool ncr710_scsi_fifo_full(NCR710_SCSI_FIFO *fifo)
> -{
> -    return fifo->count == NCR710_SCSI_FIFO_SIZE;
> -}
> -
> -static inline int ncr710_scsi_fifo_enqueue(NCR710_SCSI_FIFO *fifo,
> -                                           uint8_t data, uint8_t parity)
> -{
> -    if (ncr710_scsi_fifo_full(fifo)) {
> -        return -1; /* FIFO full - 8 transfers deep */
> -    }
> -
> -    /* Add data at the tail (head + count) */
> -    int tail_pos = (fifo->head + fifo->count) % NCR710_SCSI_FIFO_SIZE;
> -    fifo->data[tail_pos] = data;
> -    fifo->parity[tail_pos] = parity;
> -    fifo->count++;
> -
> -    return 0;
> -}
> -
> -static inline uint8_t ncr710_scsi_fifo_dequeue(NCR710_SCSI_FIFO *fifo,
> -                                                uint8_t *parity)
> -{
> -    uint8_t data;
> -
> -    if (ncr710_scsi_fifo_empty(fifo)) {
> -        *parity = 0;
> -        return 0; /* FIFO empty */
> -    }
> -
> -    /* Taking data from the head position */
> -    data = fifo->data[fifo->head];
> -    *parity = fifo->parity[fifo->head];
> -    fifo->head = (fifo->head + 1) % NCR710_SCSI_FIFO_SIZE;
> -    fifo->count--;
> -
> -    return data;
> -}
> -
> -static inline uint32_t ncr710_read_dword(NCR710State *s, uint32_t addr)
> +/* SCRIPTS and table indirect structures are built by the big endian CPU. */
> +static inline uint32_t lsi_read_dword(NCR710State *s, uint32_t addr)
> {
>     uint32_t buf;
> -    address_space_read(s->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                       (uint8_t *)&buf, 4);
> -    /*
> -     * The NCR710 datasheet saying "operates internally in LE mode"
> -     * refers to its internal register organization,
> -     * not how it reads SCRIPTS from host memory.
> -     */
> -    buf = be32_to_cpu(buf);
> -    NCR710_DPRINTF("Read dword %08x from %08x\n", buf, addr);
> -    return buf;
> +
> +    address_space_read(s->as, addr, MEMTXATTRS_UNSPECIFIED, &buf, 4);
> +    return be32_to_cpu(buf);
> }
>
> -static inline void ncr710_dma_read(NCR710State *s, uint32_t addr,
> -                                   void *buf, uint32_t len)
> +static void lsi_stop_script(NCR710State *s)
> {
> -    address_space_read(s->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                       buf, len);
> -    NCR710_DPRINTF("Read %d bytes from %08x: ", len, addr);
> -    for (int i = 0; i < len && i < 16; i++) {
> -        NCR710_DPRINTF("%02x ", ((uint8_t *)buf)[i]);
> -    }
> -    NCR710_DPRINTF("\n");
> +    s->script_running = false;
> }
>
> -static inline void ncr710_dma_write(NCR710State *s, uint32_t addr,
> -                                    const void *buf, uint32_t len)
> -{
> -    address_space_write(s->as, addr, MEMTXATTRS_UNSPECIFIED,
> -                        buf, len);
> -    NCR710_DPRINTF("Wrote %d bytes to %08x\n", len, addr);
> -}
> -
> -static void ncr710_stop_script(NCR710State *s)
> -{
> -    s->script_active = 0;
> -    s->scntl1 &= ~NCR710_SCNTL1_CON;
> -    s->istat &= ~NCR710_ISTAT_CON;
> -}
> -
> -static void ncr710_update_irq(NCR710State *s)
> +static void lsi_update_irq(NCR710State *s)
> {
>     int level = 0;
>
> -    if (s->dstat & ~NCR710_DSTAT_DFE) {
> +    if (s->dstat) {
>         if (s->dstat & s->dien) {
>             level = 1;
>         }
> -        s->istat |= NCR710_ISTAT_DIP;
> +        s->istat |= LSI_ISTAT0_DIP;
>     } else {
> -        s->istat &= ~NCR710_ISTAT_DIP;
> +        s->istat &= ~LSI_ISTAT0_DIP;
>     }
>
>     if (s->sstat0) {
> -        if ((s->sstat0 & s->sien0)) {
> +        if (s->sstat0 & s->sien) {
>             level = 1;
>         }
> -        s->istat |= NCR710_ISTAT_SIP;
> +        s->istat |= LSI_ISTAT0_SIP;
>     } else {
> -        s->istat &= ~NCR710_ISTAT_SIP;
> +        s->istat &= ~LSI_ISTAT0_SIP;
>     }
>
> +    trace_ncr710_update_irq(level, s->istat, s->sstat0, s->dstat);
>     qemu_set_irq(s->irq, level);
> }
>
> -static void ncr710_script_scsi_interrupt(NCR710State *s, int stat0)
> +/* Raise a SCSI interrupt and stop SCRIPTS on a fatal/unmasked condition. */
> +static void lsi_script_scsi_interrupt(NCR710State *s, int stat0)
> {
> -    uint32_t mask0;
> +    uint8_t mask;
>
>     trace_ncr710_script_scsi_interrupt(stat0, s->sstat0);
>     s->sstat0 |= stat0;
> -    mask0 = stat0 & s->sien0;
> -    if (mask0) {
> -        ncr710_stop_script(s);
> -        s->istat |= NCR710_ISTAT_SIP;
> -        ncr710_update_irq(s);
> +    /*
> +     * FCMP and SEL are nonfatal (only stop when enabled in SIEN); STO never
> +     * stops here (execution continues until the next SCSI bus instruction).
> +     */
> +    mask = s->sien | (uint8_t)~(LSI_STAT0_FCMP | LSI_STAT0_SEL);
> +    mask &= ~LSI_STAT0_STO;
> +    if (s->sstat0 & mask) {
> +        lsi_stop_script(s);
>     }
> +    lsi_update_irq(s);
> }
>
> -static void ncr710_script_dma_interrupt(NCR710State *s, int stat)
> +/* Raise a DMA interrupt and stop SCRIPTS (all DMA interrupts are fatal). */
> +static void lsi_script_dma_interrupt(NCR710State *s, int stat)
> {
>     trace_ncr710_script_dma_interrupt(stat, s->dstat);
> -    if (stat == NCR710_DSTAT_SIR && (s->dstat & NCR710_DSTAT_DFE)) {
> -        s->dstat &= ~NCR710_DSTAT_DFE;
> -    }
> -
>     s->dstat |= stat;
> -    s->istat |= NCR710_ISTAT_DIP;
> -    ncr710_update_irq(s);
> -    ncr710_stop_script(s);
> +    lsi_update_irq(s);
> +    lsi_stop_script(s);
> }
>
> -inline void ncr710_set_phase(NCR710State *s, int phase)
> +static void lsi_set_phase(NCR710State *s, int phase)
> {
> +    trace_ncr710_set_phase(phase);
> +    s->sbcl = (s->sbcl & ~PHASE_MASK) | phase | LSI_SBCL_REQ;
>     s->sstat2 = (s->sstat2 & ~PHASE_MASK) | phase;
> -    s->ctest0 &= ~1;
> -    if (phase == PHASE_DI) {
> -        s->ctest0 |= 1;
> -    }
> -    s->sbcl &= ~NCR710_SBCL_REQ;
> }
>
> -static void ncr710_disconnect(NCR710State *s)
> +/* 53C710 has no phase mismatch jump feature; a bad phase always interrupts. */
> +static int lsi_bad_phase(NCR710State *s, int new_phase)
> +{
> +    lsi_script_scsi_interrupt(s, LSI_STAT0_MA);
> +    lsi_stop_script(s);
> +    lsi_set_phase(s, new_phase);
> +    return 1;
> +}
> +
> +static void lsi_resume_script(NCR710State *s)
> +{
> +    trace_ncr710_resume_script(s->waiting);
> +    if (s->waiting != LSI_DMA_SCRIPTS) {
> +        s->waiting = LSI_NOWAIT;
> +        lsi_execute_script(s);
> +    } else {
> +        s->waiting = LSI_NOWAIT;
> +    }
> +}
> +
> +static void lsi_disconnect(NCR710State *s)
> {
>     trace_ncr710_disconnect(s->waiting);
> -    if (s->waiting == NCR710_WAIT_NONE) {
> -        s->scntl1 &= ~NCR710_SCNTL1_CON;
> -        s->istat &= ~NCR710_ISTAT_CON;
> -    }
> +    s->scntl1 &= ~LSI_SCNTL1_CON;
>     s->sstat2 &= ~PHASE_MASK;
> +    s->sbcl = 0;
> }
>
> -static void ncr710_bad_selection(NCR710State *s, uint32_t id)
> +static void lsi_bad_selection(NCR710State *s, uint32_t id)
> {
>     trace_ncr710_bad_selection(id);
> -    s->dstat = 0;
> -    s->dsps = 0;
> -    ncr710_script_scsi_interrupt(s, NCR710_SSTAT0_STO);
> -    ncr710_disconnect(s);
> +    lsi_script_scsi_interrupt(s, LSI_STAT0_STO);
> +    lsi_disconnect(s);
> }
>
> -static void ncr710_clear_selection_timeout(NCR710State *s)
> -{
> -    if (s->sstat0 & NCR710_SSTAT0_STO) {
> -        s->sstat0 &= ~NCR710_SSTAT0_STO;
> -        ncr710_clear_pending_irq(s);
> -        if (s->sstat0 == 0) {
> -            s->istat &= ~NCR710_ISTAT_SIP;
> -        }
> -        ncr710_update_irq(s);
> -    }
> -}
> -
> -static void ncr710_do_dma(NCR710State *s, int out)
> +static void lsi_do_dma(NCR710State *s, int out)
> {
>     uint32_t count;
>     uint32_t addr;

lsi53c895a.c has dma_addr_t addr; here.

Regards,
BALATON Zoltan
--3866299591-1004174178-1795212830=:80696--

