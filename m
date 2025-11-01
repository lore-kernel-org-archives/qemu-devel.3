Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06E82CCF9F0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Nov 2025 12:37:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFApr-0001k3-DH; Sat, 01 Nov 2025 08:35:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFApo-0001jn-NM
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 08:35:57 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <soumyajyotisarkar23@gmail.com>)
 id 1vFApe-00021V-9g
 for qemu-devel@nongnu.org; Sat, 01 Nov 2025 08:35:56 -0400
Received: by mail-ej1-x641.google.com with SMTP id
 a640c23a62f3a-b6d855ca585so645801466b.0
 for <qemu-devel@nongnu.org>; Sat, 01 Nov 2025 05:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762000539; x=1762605339; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=a4nKCLUxmVma9r3ezxO1uauZAES/UsbI6p0/5Sw5oJI=;
 b=IBENJNMttsd/ayrzeVOw95f61Qsw8MPsuRnaXC838vvhNeEdIgL/bYge92qXNkQ2lw
 9F1ynxOWOZVfKVvwuWS4X29mdaVrm9Wr78Xuk9/A8/1KBtDhhSZCTjTIffZkXfc+zKIZ
 pqQ+7FlPxm4Rds28vpoKy8RPsv0PA4iHErhHWKfwICe2Rzl4q8iWZJn8GT1V7rj0lDos
 hdiJgagyiBIEt6vsLCgHOoLwzyY5Ge4K2VEq6Oe4IUXOf6uGS0DWprcgK/9idCkfBL5U
 5SpYla/U9Np8i05VeLHDV8qc3lPXuP0CD1CDiGjLGjIK1ZxGFVv02X63CmkSLzC4vK8y
 sYlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762000539; x=1762605339;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a4nKCLUxmVma9r3ezxO1uauZAES/UsbI6p0/5Sw5oJI=;
 b=LqLdPekVQRGtjZD5oiJ94DtcH2bv0z292VFLUuSlFCLYvzPOjbHCZkwEPNLgR8e+Hf
 7oISuB8C9PvL1LXXTN2dt/1jszZE69YRw9f38cFYRqvB1F78ivdGHnaANXn9mbhdXubf
 PUvibN2w9fY1aqKQ6Z8JnAcqSjPOsJ1aB4LHwaz8LrAmgrZ862d/Ch+JDFYJhRAOHo7c
 BbbYU/VJJgvJz7Tt+2GAIRc1IhKZP43epjWTd09RtJ7s9L9sw+3Q2HDI7x74HtiBPUuZ
 UctLuFOqNKTw9SmUMFuIrvPAGaOURn/v9SMpXtMocbbaxL4ZF/8tBUz33s214RXTTb5b
 yK5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5E3UAGgzjFxqbX7T3xS3PaiThudr16y+k7ZumxLflOoB5vu4zGVrYxSliND741lVE4C/X4vVZ/dOn@nongnu.org
X-Gm-Message-State: AOJu0YwT3JwWUHktLf1nYxzn7p1WssiDq+6FKDeRNn0vdaZffD0zj0td
 Ns402PizHfWB1VzX5R1CJ60pRKVfm+1HKKAYwE5J/FlRfCKZVM1LQJ3Fn4V0N0PKKWaXK6oS8/N
 mrJh5PZoO2EX86DOPQefKf7PUmtaYZfg=
X-Gm-Gg: ASbGncsmP8caOlq4Ad76F3OfIMpvUAN8MkM46o5LGeMhP4WLlWsLFGLZ6dvNnjUjFOu
 wvJDvmxHrKwOZISrntf3WNGeDVGg3sCvNZ7w6PKLcPlFTAX6KDxfpuzDIzZ2AFJvHQI0pRmrP2F
 j8Txc6gPvapVa3gGYWGY5qAxnU9gqat3V7w7HoESwXgsV70w6LwALAL43a0AxZus3RO6bh0VmMZ
 LGKbMYlYwP1Bq/WC+qsYPJZ8L6XIpYg9QVKv5UKH2UboR9+hUz3bY8Q9gR958NO77MewCDf5+WJ
 K/2TSrqxpUsFyiyj
X-Google-Smtp-Source: AGHT+IHO0svLawA1jK0x+zmH/gkQimAPb1tTo51jrkYItVWzynSbgleAYROz4xlDnzlxt907MNzzrLPsOASp3slTJR4=
X-Received: by 2002:a17:907:7f13:b0:b6d:5718:d43f with SMTP id
 a640c23a62f3a-b70705ea525mr595238866b.39.1762000538759; Sat, 01 Nov 2025
 05:35:38 -0700 (PDT)
MIME-Version: 1.0
References: <20251031211516.208488-1-soumyajyotisarkar23@gmail.com>
 <20251031211516.208488-3-soumyajyotisarkar23@gmail.com>
 <b19bcd55-2ac3-4f1f-a406-02c0498f3cc3@ilande.co.uk>
In-Reply-To: <b19bcd55-2ac3-4f1f-a406-02c0498f3cc3@ilande.co.uk>
From: Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
Date: Sat, 1 Nov 2025 18:05:27 +0530
X-Gm-Features: AWmQ_bmKJVLtaGYlh-xi8hZdzeucbPTRw9aWvFaCv0n0Tmze6XyMC2QcKlWp-uc
Message-ID: <CAGkZZ+sz4kT8Zp9ZB8x+ztwuLK=7CXnoAkjmBEJYRUjWEti_MQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] i82596: Added core infrastructure and helper functions
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: deller@gmx.de, qemu-devel@nongnu.org, sarkarsoumyajyoti23@gmail.com, 
 Richard Henderson <richard.henderson@linaro.org>,
 Jason Wang <jasowang@redhat.com>
Content-Type: multipart/alternative; boundary="00000000000034f8dd064287b8a0"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=soumyajyotisarkar23@gmail.com; helo=mail-ej1-x641.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, HTML_MESSAGE=0.001,
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

--00000000000034f8dd064287b8a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 1, 2025 at 5:55=E2=80=AFAM Mark Cave-Ayland <
mark.cave-ayland@ilande.co.uk> wrote:

> On 31/10/2025 21:15, Soumyajyotii Ssarkar wrote:
>
> > From: RemZapCypher <soumyajyotisarkar23@gmail.com>
> >
> > As a part of GSOC 2025 I have done a massive rewrite of what was the
> > 82596 NIC. This has been done to add the missing functionality accordin=
g
> > to the 82596 Manual and making the code more production
> > ready.
> >
> > In this patch I have done the following:
> > - Added comprehensive 82596 constants and configuration macros
> > - Implemented address translation for segmented/linear memory modes
> > - Added error recording and statistics tracking infrastructure
> > - Implemented CRC-16/32 calculation and appending functions
> > - Added CSMA/CD collision detection and backoff logic
> > - Implemented bus throttle timer framework
> > - Added enhanced reset with full state initialization
> > - Added receive_iov and polling support functions
> > - Updated VMState for migration of all new fields
> >
> > Note:
> > This patch primarily includes placeholder code.
> > To achieve full 82596 emulation, the complete 82596 patch series is
> required.
> > Nevertheless, QEMU is able to load and boot successfully with this patc=
h.
> >
> > ---
> >   hw/net/i82596.c      | 667 ++++++++++++++++++++++++++++++++++++++----=
-
> >   hw/net/i82596.h      |  74 ++++-
> >   hw/net/lasi_i82596.c |   6 +
> >   3 files changed, 655 insertions(+), 92 deletions(-)
> >
> > diff --git a/hw/net/i82596.c b/hw/net/i82596.c
> > index c1ff3e6c56..859cc88b2e 100644
> > --- a/hw/net/i82596.c
> > +++ b/hw/net/i82596.c
> > @@ -2,10 +2,38 @@
> >    * QEMU Intel i82596 (Apricot) emulation
> >    *
> >    * Copyright (c) 2019 Helge Deller <deller@gmx.de>
> > - * This work is licensed under the GNU GPL license version 2 or later.
> >    *
> > + * Additional functionality added by:
> > + * Soumyajyotii Ssarkar <soumyajyotisarkar23@gmail.com>
> > + * During GSOC 2025 under mentorship of Helge Deller.
> > + *
> > + * This work is licensed under the GNU GPL license version 2 or later.
> >    * This software was written to be compatible with the specification:
> >    *
> https://parisc.docs.kernel.org/en/latest/_downloads/96672be0650d9fc046bbc=
ea40b92482f/82596CA.pdf
> > + *
> > + * INDEX:
> > + * 1.  Reset
> > + * 2.  Address Translation
> > + * 3.  Transmit functions
> > + * 4.  Receive Helper functions
> > + * 5.  Receive functions
> > + * 6.  Misc Functionality Functions
> > + * 6.1 Individual Address
> > + * 6.2 Multicast Address List
> > + * 6.3 Link Status
> > + * 6.4 CSMA/CD functions
> > + * 6.5 Unified CRC Calculation
> > + * 6.6 Unified Statistics Update
> > + * 7.  Bus Throttling Timer
> > + * 8.  Dump functions
> > + * 9.  Configure
> > + * 10. Command Loop
> > + * 11. Examine SCB
> > + * 12. Channel attention (CA)
> > + * 13. LASI interface
> > + * 14. Polling functions
> > + * 15. QOM and interface functions
> > + *
> >    */
> >
> >   #include "qemu/osdep.h"
> > @@ -21,50 +49,90 @@
> >   #include "i82596.h"
> >   #include <zlib.h> /* for crc32 */
> >
> > +#define ENABLE_DEBUG 0
> > +
> >   #if defined(ENABLE_DEBUG)
> >   #define DBG(x)          x
> >   #else
> >   #define DBG(x)          do { } while (0)
> >   #endif
>
> All new code should use trace-events instead of #defines to enable
> debugging.
>
> > -#define USE_TIMER       0
> > -
> > -#define BITS(n, m) (((0xffffffffU << (31 - n)) >> (31 - n + m)) << m)
> > +#define USE_TIMER       1
> >
> > -#define PKT_BUF_SZ      1536
> >   #define MAX_MC_CNT      64
> > -
> > -#define ISCP_BUSY       0x0001
> > -
> >   #define I596_NULL       ((uint32_t)0xffffffff)
> > -
> > -#define SCB_STATUS_CX   0x8000 /* CU finished command with I bit */
> > -#define SCB_STATUS_FR   0x4000 /* RU finished receiving a frame */
> > -#define SCB_STATUS_CNA  0x2000 /* CU left active state */
> > -#define SCB_STATUS_RNR  0x1000 /* RU left active state */
> > -
> > -#define SCB_COMMAND_ACK_MASK \
> > -        (SCB_STATUS_CX | SCB_STATUS_FR | SCB_STATUS_CNA |
> SCB_STATUS_RNR)
> > -
> > +#define BITS(n, m)      (((0xffffffffU << (31 - n)) >> (31 - n + m)) <=
<
> m)
> > +
> > +#define SCB_STATUS_CX   0x8000  /* CU finished command with I bit */
> > +#define SCB_STATUS_FR   0x4000  /* RU finished receiving a frame */
> > +#define SCB_STATUS_CNA  0x2000  /* CU left active state */
> > +#define SCB_STATUS_RNR  0x1000  /* RU left active state */
> > +#define SCB_ACK_MASK    0xF000  /* All interrupt acknowledge bits */
> > +
> > +/* 82596 Operational Modes */
> > +#define I82586_MODE                 0x00
> > +#define I82596_MODE_SEGMENTED       0x01
> > +#define I82596_MODE_LINEAR          0x02
> > +
> > +/* Monitor Options */
> > +#define MONITOR_NORMAL      0x00
> > +#define MONITOR_FILTERED    0x01
> > +#define MONITOR_ALL         0x02
> > +#define MONITOR_DISABLED    0x03
> > +
> > +/* Operation mode flags from SYSBUS byte */
> > +#define SYSBUS_LOCK_EN         0x08
> > +#define SYSBUS_INT_ACTIVE_LOW  0x10
> > +#define SYSBUS_BIG_ENDIAN_32   0x80
> > +#define SYSBUS_THROTTLE_MASK   0x60
> > +
> > +/* SCB commands - Command Unit (CU) */
> > +#define SCB_CUC_NOP            0x00
> > +#define SCB_CUC_START          0x01
> > +#define SCB_CUC_RESUME         0x02
> > +#define SCB_CUC_SUSPEND        0x03
> > +#define SCB_CUC_ABORT          0x04
> > +#define SCB_CUC_LOAD_THROTTLE  0x05
> > +#define SCB_CUC_LOAD_START     0x06
> > +
> > +/* SCB commands - Receive Unit (RU) */
> > +#define SCB_RUC_NOP            0x00
> > +#define SCB_RUC_START          0x01
> > +#define SCB_RUC_RESUME         0x02
> > +#define SCB_RUC_SUSPEND        0x03
> > +#define SCB_RUC_ABORT          0x04
> > +
> > +/* SCB statuses - Command Unit (CU) */
> >   #define CU_IDLE         0
> >   #define CU_SUSPENDED    1
> >   #define CU_ACTIVE       2
> >
> > -#define RX_IDLE         0
> > -#define RX_SUSPENDED    1
> > -#define RX_READY        4
> > +/* SCB statuses - Receive Unit (RU) */
> > +#define RX_IDLE         0x00
> > +#define RX_SUSPENDED    0x01
> > +#define RX_NO_RESOURCES 0x02
> > +#define RX_READY        0x04
> > +#define RX_NO_RESO_RBD  0x0A
> > +#define RX_NO_MORE_RBD  0x0C
> > +
> > +#define CMD_FLEX        0x0008
> > +#define CMD_MASK        0x0007
> > +
> > +#define CMD_EOL         0x8000
> > +#define CMD_SUSP        0x4000
> > +#define CMD_INTR        0x2000
> >
> > -#define CMD_EOL         0x8000  /* The last command of the list, stop.
> */
> > -#define CMD_SUSP        0x4000  /* Suspend after doing cmd. */
> > -#define CMD_INTR        0x2000  /* Interrupt after doing cmd. */
> > +#define ISCP_BUSY                   0x01
> > +#define NANOSECONDS_PER_MICROSECOND 1000
> >
> > -#define CMD_FLEX        0x0008  /* Enable flexible memory model */
> > +#define DUMP_BUF_SZ                 304
> >
> >   enum commands {
> >           CmdNOp =3D 0, CmdSASetup =3D 1, CmdConfigure =3D 2, CmdMultic=
astList
> =3D 3,
> >           CmdTx =3D 4, CmdTDR =3D 5, CmdDump =3D 6, CmdDiagnose =3D 7
> >   };
> >
> > +
> >   #define STAT_C          0x8000  /* Set to 0 after execution */
> >   #define STAT_B          0x4000  /* Command being executed */
> >   #define STAT_OK         0x2000  /* Command executed ok */
> > @@ -73,15 +141,60 @@ enum commands {
> >   #define I596_EOF        0x8000
> >   #define SIZE_MASK       0x3fff
> >
> > -/* various flags in the chip config registers */
> > -#define I596_PREFETCH   (s->config[0] & 0x80)
> > -#define I596_PROMISC    (s->config[8] & 0x01)
> > -#define I596_BC_DISABLE (s->config[8] & 0x02) /* broadcast disable */
> > -#define I596_NOCRC_INS  (s->config[8] & 0x08)
> > -#define I596_CRCINM     (s->config[11] & 0x04) /* CRC appended */
> > -#define I596_MC_ALL     (s->config[11] & 0x20)
> > -#define I596_MULTIIA    (s->config[13] & 0x40)
> > -
> > +#define CSMA_SLOT_TIME         51
> > +#define CSMA_MAX_RETRIES       16
> > +#define CSMA_BACKOFF_LIMIT     10
> > +
> > +/* Global Flags fetched from config bytes */
> > +#define I596_PREFETCH       (s->config[0] & 0x80)
> > +#define SAVE_BAD_FRAMES     (s->config[2] & 0x80)
> > +#define I596_NO_SRC_ADD_IN  (s->config[3] & 0x08)
> > +#define I596_LOOPBACK       (s->config[3] >> 6)
> > +#define I596_PROMISC        (s->config[8] & 0x01)
> > +#define I596_BC_DISABLE     (s->config[8] & 0x02)
> > +#define I596_NOCRC_INS      (s->config[8] & 0x08)
> > +#define I596_CRC16_32       (s->config[8] & 0x10)
> > +#define I596_PADDING        (s->config[8] & 0x80)
> > +#define I596_MIN_FRAME_LEN  (s->config[10])
> > +#define I596_CRCINM         (s->config[11] & 0x04)
> > +#define I596_MONITOR_MODE   ((s->config[11] >> 6) & 0x03)
> > +#define I596_MC_ALL         (s->config[11] & 0x20)
> > +#define I596_FULL_DUPLEX    (s->config[12] & 0x40)
> > +#define I596_MULTIIA        (s->config[13] & 0x40)
> > +
> > +/* RX Error flags */
> > +#define RX_COLLISIONS         0x0001
> > +#define RX_LENGTH_ERRORS      0x0080
> > +#define RX_OVER_ERRORS        0x0100
> > +#define RX_FIFO_ERRORS        0x0400
> > +#define RX_FRAME_ERRORS       0x0800
> > +#define RX_CRC_ERRORS         0x1000
> > +#define RX_LENGTH_ERRORS_ALT  0x2000
> > +#define RFD_STATUS_TRUNC      0x0020
> > +#define RFD_STATUS_NOBUFS     0x0200
> > +
> > +/* TX Error flags */
> > +#define TX_COLLISIONS       0x0020
> > +#define TX_HEARTBEAT_ERRORS 0x0040
> > +#define TX_CARRIER_ERRORS   0x0400
> > +#define TX_COLLISIONS_ALT   0x0800
> > +#define TX_ABORTED_ERRORS   0x1000
> > +
> > +static void i82596_update_scb_irq(I82596State *s, bool trigger);
> > +static void i82596_update_cu_status(I82596State *s, uint16_t cmd_statu=
s,
> > +                                     bool generate_interrupt);
> > +static void update_scb_status(I82596State *s);
> > +static void examine_scb(I82596State *s);
> > +static bool i82596_check_medium_status(I82596State *s);
> > +static int i82596_csma_backoff(I82596State *s, int retry_count);
> > +static uint16_t i82596_calculate_crc16(const uint8_t *data, size_t len=
);
> > +static size_t i82596_append_crc(I82596State *s, uint8_t *buffer, size_=
t
> len);
> > +static void i82596_bus_throttle_timer(void *opaque);
> > +static void i82596_flush_queue_timer(void *opaque);
> > +static int i82596_flush_packet_queue(I82596State *s);
> > +static void i82596_update_statistics(I82596State *s, bool is_tx,
> > +                                      uint16_t error_flags,
> > +                                      uint16_t collision_count);
> >
> >   static uint8_t get_byte(uint32_t addr)
> >   {
> > @@ -116,7 +229,44 @@ static void set_uint32(uint32_t addr, uint32_t val=
)
> >       set_uint16(addr + 2, val >> 16);
> >   }
>
> What is the endianness of where this is used? I'd expect to see an stw_*
> function
> being used here.
>
> Hello Mark,
Thank you for your detailed review of my patch and pointing out the
endianness concerns.
set_uint32() does call set_uint16() which internally calls stw_be_phys().
I do understand your concern about using stl_* functions directly.

Regarding the 16 bit writes rather than the stl_be_phy() is that 82596
requires 16 bit aligned
access but does not guarantee a 4-byte alignment in 32-bit values.
I think using stl_be_phys() would require 4-byte alignment which isn't
always guaranteed for our 82596 structures.
Please let me know your opinion on this.

Thank you,
Soumyajyotii


> > +/* Centralized error detection and update mechanism */
> > +static void i82596_record_error(I82596State *s, uint16_t error_type,
> bool is_tx)
> > +{
> > +    if (is_tx) {
> > +        if (error_type & TX_ABORTED_ERRORS) {
> > +            s->tx_aborted_errors++;
> > +            set_uint32(s->scb + 28, s->tx_aborted_errors);
> > +        }
> > +    } else {
> > +        if (error_type & RX_CRC_ERRORS) {
> > +            s->crc_err++;
> > +            set_uint32(s->scb + 16, s->crc_err);
> > +        }
> >
> > +        if (error_type & (RX_LENGTH_ERRORS | RX_LENGTH_ERRORS_ALT |
> > +                          RX_FRAME_ERRORS)) {
> > +            s->align_err++;
> > +            set_uint32(s->scb + 18, s->align_err);
>
> and an stl_* function here?
>
> > +        }
> > +
> > +        if (error_type & RFD_STATUS_NOBUFS) {
> > +            s->resource_err++;
> > +            set_uint32(s->scb + 20, s->resource_err);
> > +        }
> > +
> > +        if (error_type & (RX_OVER_ERRORS | RX_FIFO_ERRORS)) {
> > +            s->over_err++;
> > +            set_uint32(s->scb + 22, s->over_err);
> > +        }
> > +
> > +        if (error_type & RFD_STATUS_TRUNC) {
> > +            s->short_fr_error++;
> > +            set_uint32(s->scb + 26, s->short_fr_error);
> > +        }
> > +    }
> > +}
> > +
> > +/* Packet Header Debugger */
> >   struct qemu_ether_header {
> >       uint8_t ether_dhost[6];
> >       uint8_t ether_shost[6];
> > @@ -124,12 +274,122 @@ struct qemu_ether_header {
> >   };
> >
> >   #define PRINT_PKTHDR(txt, BUF) do {                  \
> > -    struct qemu_ether_header *hdr =3D (void *)(BUF); \
> > -    printf(txt ": packet dhost=3D" MAC_FMT ", shost=3D" MAC_FMT ",
> type=3D0x%04x\n",\
> > -           MAC_ARG(hdr->ether_dhost), MAC_ARG(hdr->ether_shost),
> \
> > -           be16_to_cpu(hdr->ether_type));       \
> >   } while (0)
> >
> > +static void i82596_cleanup(I82596State *s)
> > +{
> > +    if (s->throttle_timer) {
> > +        timer_del(s->throttle_timer);
> > +    }
> > +    if (s->flush_queue_timer) {
> > +        timer_del(s->flush_queue_timer);
> > +    }
> > +    s->queue_head =3D 0;
> > +    s->queue_tail =3D 0;
> > +    s->queue_count =3D 0;
> > +}
> > +
> > +static void i82596_s_reset(I82596State *s)
> > +{
> > +    trace_i82596_s_reset(s);
> > +    i82596_cleanup(s);
> > +
> > +    /* Clearing config bits */
> > +    memset(s->config, 0, sizeof(s->config));
> > +    s->scp =3D 0x00FFFFF4;
> > +    s->scb =3D 0;
> > +    s->scb_base =3D 0;
> > +    s->scb_status =3D 0;
> > +    s->cu_status =3D CU_IDLE;
> > +    s->rx_status =3D RX_IDLE;
> > +    s->cmd_p =3D I596_NULL;
> > +    s->lnkst =3D 0x8000;
> > +    s->ca =3D s->ca_active =3D 0;
> > +    s->send_irq =3D 0;
> > +
> > +    /* Statistical Counters */
> > +    s->crc_err =3D 0;
> > +    s->align_err =3D 0;
> > +    s->resource_err =3D 0;
> > +    s->over_err =3D 0;
> > +    s->rcvdt_err =3D 0;
> > +    s->short_fr_error =3D 0;
> > +    s->total_frames =3D 0;
> > +    s->total_good_frames =3D 0;
> > +    s->collision_events =3D 0;
> > +    s->total_collisions =3D 0;
> > +    s->tx_good_frames =3D 0;
> > +    s->tx_collisions =3D 0;
> > +    s->tx_aborted_errors =3D 0;
> > +    s->last_tx_len =3D 0;
> > +
> > +    s->last_good_rfa =3D 0;
> > +    s->current_rx_desc =3D 0;
> > +    s->current_tx_desc =3D 0;
> > +    s->tx_retry_addr =3D 0;
> > +    s->tx_retry_count =3D 0;
> > +
> > +    s->rnr_signaled =3D false;
> > +    s->flushing_queue =3D false;
> > +
> > +    memset(s->tx_buffer, 0, sizeof(s->tx_buffer));
> > +    memset(s->rx_buffer, 0, sizeof(s->rx_buffer));
> > +    s->tx_frame_len =3D 0;
> > +    s->rx_frame_len =3D 0;
> > +}
> > +
> > +void i82596_h_reset(void *opaque)
> > +{
> > +    I82596State *s =3D opaque;
> > +
> > +    i82596_s_reset(s);
> > +}
> > +
> > +/*
> > + * Address Translation Implementation
> > + * Handles segmented and linear memory modes for i82596.
> > + * Returns physical address for DMA operations.
> > + * Returns I596_NULL (0xffffffff) on invalid addresses.
> > + */
> > +static inline uint32_t i82596_translate_address(I82596State *s,
> > +                                                 uint32_t logical_addr=
,
> > +                                                 bool is_data_buffer)
>
> Drop the inline: for modern compilers it is a weak hint, and the compiler
> will just
> do the right thing here.
>
> > +{
> > +    if (logical_addr =3D=3D I596_NULL || logical_addr =3D=3D 0) {
> > +        return logical_addr;
> > +    }
> > +
> > +    switch (s->mode) {
> > +    case I82596_MODE_LINEAR:
> > +        return logical_addr;
> > +
> > +    case I82596_MODE_SEGMENTED: {
> > +        uint32_t base =3D (logical_addr >> 16) & 0xFFFF;
> > +        uint32_t offset =3D logical_addr & 0xFFFF;
> > +
> > +        if (is_data_buffer) {
> > +            return (base << 4) + offset;
> > +        } else {
> > +            if (base =3D=3D 0xFFFF && offset =3D=3D 0xFFFF) {
> > +                return I596_NULL;
> > +            }
> > +            return s->scb_base + ((base << 4) + offset);
> > +        }
> > +    }
> > +
> > +    case I82586_MODE:
> > +    default:
> > +        if (is_data_buffer) {
> > +            return logical_addr;
> > +        } else {
> > +            if ((logical_addr & 0xFFFF0000) =3D=3D 0xFFFF0000) {
> > +                return I596_NULL;
> > +            }
> > +            return s->scb_base + logical_addr;
> > +        }
> > +    }
> > +}
> > +
> >   static void i82596_transmit(I82596State *s, uint32_t addr)
> >   {
> >       uint32_t tdb_p; /* Transmit Buffer Descriptor */
> > @@ -223,32 +483,198 @@ static void set_multicast_list(I82596State *s,
> uint32_t addr)
> >
> >   void i82596_set_link_status(NetClientState *nc)
> >   {
> > -    I82596State *d =3D qemu_get_nic_opaque(nc);
> > +    I82596State *s =3D qemu_get_nic_opaque(nc);
> > +    bool was_up =3D s->lnkst !=3D 0;
> > +
> > +    s->lnkst =3D nc->link_down ? 0 : 0x8000;
> > +    bool is_up =3D s->lnkst !=3D 0;
> >
> > -    d->lnkst =3D nc->link_down ? 0 : 0x8000;
> > +    if (!was_up && is_up && s->rx_status =3D=3D RX_READY) {
> > +        qemu_flush_queued_packets(qemu_get_queue(s->nic));
> > +    }
> >   }
> >
> > -static void update_scb_status(I82596State *s)
> > +static bool G_GNUC_UNUSED i82596_check_medium_status(I82596State *s)
>
> Generally you want to arrange the series so that you don't require
> G_GNUC_UNUSED: the
> function should be defined at the point where it is first used.
>
> >   {
> > -    s->scb_status =3D (s->scb_status & 0xf000)
> > -        | (s->cu_status << 8) | (s->rx_status << 4);
> > -    set_uint16(s->scb, s->scb_status);
> > +    if (I596_FULL_DUPLEX) {
> > +        return true;
> > +    }
> > +
> > +    if (!s->throttle_state) {
> > +        return false;
> > +    }
> > +
> > +    if (!I596_LOOPBACK && (qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) % 100
> < 5)) {
> > +        s->collision_events++;
> > +        return false;
> > +    }
> > +
> > +    return true;
> >   }
> >
> > +static int G_GNUC_UNUSED i82596_csma_backoff(I82596State *s, int
> retry_count)
> > +{
> > +    int backoff_factor, slot_count, backoff_time;
> > +
> > +    backoff_factor =3D MIN(retry_count + 1, CSMA_BACKOFF_LIMIT);
> > +    slot_count =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) % (1 <<
> backoff_factor);
> > +    backoff_time =3D slot_count * CSMA_SLOT_TIME;
> >
> > -static void i82596_s_reset(I82596State *s)
> > +    return backoff_time;
> > +}
> > +
> > +static uint16_t i82596_calculate_crc16(const uint8_t *data, size_t len=
)
> >   {
> > -    trace_i82596_s_reset(s);
> > -    s->scp =3D 0;
> > -    s->scb_status =3D 0;
> > -    s->cu_status =3D CU_IDLE;
> > -    s->rx_status =3D RX_SUSPENDED;
> > -    s->cmd_p =3D I596_NULL;
> > -    s->lnkst =3D 0x8000; /* initial link state: up */
> > -    s->ca =3D s->ca_active =3D 0;
> > -    s->send_irq =3D 0;
> > +    uint16_t crc =3D 0xFFFF;
> > +    size_t i, j;
> > +
> > +    for (i =3D 0; i < len; i++) {
> > +        crc ^=3D data[i] << 8;
> > +        for (j =3D 0; j < 8; j++) {
> > +            if (crc & 0x8000) {
> > +                crc =3D (crc << 1) ^ 0x1021;
> > +            } else {
> > +                crc <<=3D 1;
> > +            }
> > +        }
> > +    }
> > +    return crc;
> > +}
> > +
> > +static size_t G_GNUC_UNUSED i82596_append_crc(I82596State *s, uint8_t
> *buffer, size_t len)
> > +{
> > +    if (len + 4 > PKT_BUF_SZ) {
> > +        return len;
> > +    }
> > +
> > +    if (I596_CRC16_32) {
> > +        uint32_t crc =3D crc32(~0, buffer, len);
> > +        crc =3D cpu_to_be32(crc);
> > +        memcpy(&buffer[len], &crc, sizeof(crc));
> > +        return len + sizeof(crc);
> > +    } else {
> > +        uint16_t crc =3D i82596_calculate_crc16(buffer, len);
> > +        crc =3D cpu_to_be16(crc);
> > +        memcpy(&buffer[len], &crc, sizeof(crc));
> > +        return len + sizeof(crc);
> > +    }
> > +}
> > +
> > +static void G_GNUC_UNUSED i82596_update_statistics(I82596State *s, boo=
l
> is_tx,
> > +                                      uint16_t error_flags,
> > +                                      uint16_t collision_count)
>
> Same here with formatting.
>
> > +{
> > +    if (is_tx) {
> > +        if (collision_count > 0) {
> > +            s->tx_collisions +=3D collision_count;
> > +            s->collision_events++;
> > +            s->total_collisions +=3D collision_count;
> > +            set_uint32(s->scb + 32, s->tx_collisions);
> > +        }
> > +        if (error_flags) {
> > +            i82596_record_error(s, error_flags, true);
> > +        }
> > +        if (!(error_flags & (TX_ABORTED_ERRORS | TX_CARRIER_ERRORS))) =
{
> > +            s->tx_good_frames++;
> > +            set_uint32(s->scb + 36, s->tx_good_frames);
> > +        }
> > +    } else {
> > +        s->total_frames++;
> > +        set_uint32(s->scb + 40, s->total_frames);
> > +        if (error_flags) {
> > +            i82596_record_error(s, error_flags, false);
> > +        } else {
> > +            s->total_good_frames++;
> > +            set_uint32(s->scb + 44, s->total_good_frames);
> > +        }
> > +    }
> > +}
> > +
> > +/* Bus Throttle Functionality */
> > +static void G_GNUC_UNUSED i82596_bus_throttle_timer(void *opaque)
> > +{
> > +    I82596State *s =3D opaque;
> > +
> > +    if (s->throttle_state) {
> > +        s->throttle_state =3D false;
> > +        if (s->t_off > 0) {
> > +            timer_mod(s->throttle_timer,
> > +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +                      (s->t_off * NANOSECONDS_PER_MICROSECOND));
> > +        }
> > +    } else {
> > +        s->throttle_state =3D true;
> > +        if (s->t_on > 0) {
> > +            timer_mod(s->throttle_timer,
> > +                      qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> > +                      (s->t_on * NANOSECONDS_PER_MICROSECOND));
> > +        }
> > +
> > +        if (s->cu_status =3D=3D CU_ACTIVE || s->rx_status =3D=3D RX_RE=
ADY) {
> > +            examine_scb(s);
> > +        }
> > +    }
> > +}
> > +
> > +static int G_GNUC_UNUSED i82596_flush_packet_queue(I82596State *s)
> > +{
> > +    /* Stub for now - will be implemented in Patch 2 */
> > +    return 0;
> > +}
> > +
> > +static void G_GNUC_UNUSED i82596_flush_queue_timer(void *opaque)
> > +{
> > +    /* Stub for now - will be implemented in Patch 2 */
> > +}
> > +
> > +static void i82596_update_scb_irq(I82596State *s, bool trigger)
> > +{
> > +    if (trigger) {
> > +        s->send_irq =3D 1;
> > +        qemu_set_irq(s->irq, 1);
> > +    }
> > +}
> > +
> > +static void G_GNUC_UNUSED i82596_update_cu_status(I82596State *s,
> uint16_t cmd_status,
> > +                                     bool generate_interrupt)
> > +{
> > +    if (cmd_status & STAT_C) {
> > +        if (cmd_status & STAT_OK) {
> > +            if (s->cu_status =3D=3D CU_ACTIVE && s->cmd_p =3D=3D I596_=
NULL) {
> > +                s->cu_status =3D CU_IDLE;
> > +                s->scb_status |=3D SCB_STATUS_CNA;
> > +            }
> > +        } else {
> > +            s->cu_status =3D CU_IDLE;
> > +            s->scb_status |=3D SCB_STATUS_CNA;
> > +        }
> > +
> > +        if (generate_interrupt) {
> > +            s->scb_status |=3D SCB_STATUS_CX;
> > +            i82596_update_scb_irq(s, true);
> > +        }
> > +    }
> > +
> > +    update_scb_status(s);
> >   }
> >
> > +static void update_scb_status(I82596State *s)
> > +{
> > +    s->scb_status =3D (s->scb_status & 0xf000)
> > +        | (s->cu_status << 8) | (s->rx_status << 4) | (s->lnkst >> 8);
> > +    set_uint16(s->scb, s->scb_status);
> > +
> > +    set_uint32(s->scb + 28, s->tx_aborted_errors);
> > +    set_uint32(s->scb + 32, s->tx_collisions);
> > +    set_uint32(s->scb + 36, s->tx_good_frames);
> > +
> > +    set_uint32(s->scb + 16, s->crc_err);
> > +    set_uint32(s->scb + 18, s->align_err);
> > +    set_uint32(s->scb + 20, s->resource_err);
> > +    set_uint32(s->scb + 22, s->over_err);
> > +    set_uint32(s->scb + 24, s->rcvdt_err);
> > +    set_uint32(s->scb + 26, s->short_fr_error);
> > +}
>
> The set_uint16() and set_uint32() functions don't look correct: you want
> to reference
> all addresses through their offset from the base address rather than thei=
r
> absolute
> address, since for other boards they can be mapped at other addresses.
>
> >   static void command_loop(I82596State *s)
> >   {
> > @@ -330,17 +756,6 @@ static void command_loop(I82596State *s)
> >       qemu_flush_queued_packets(qemu_get_queue(s->nic));
> >   }
> >
> > -static void i82596_flush_queue_timer(void *opaque)
> > -{
> > -    I82596State *s =3D opaque;
> > -    if (0) {
> > -        timer_del(s->flush_queue_timer);
> > -        qemu_flush_queued_packets(qemu_get_queue(s->nic));
> > -        timer_mod(s->flush_queue_timer,
> > -              qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
> > -    }
> > -}
> > -
> >   static void examine_scb(I82596State *s)
> >   {
> >       uint16_t command, cuc, ruc;
> > @@ -353,7 +768,7 @@ static void examine_scb(I82596State *s)
> >       /* and clear the scb command word */
> >       set_uint16(s->scb + 2, 0);
> >
> > -    s->scb_status &=3D ~(command & SCB_COMMAND_ACK_MASK);
> > +    s->scb_status &=3D ~(command & SCB_ACK_MASK);
> >
> >       switch (cuc) {
> >       case 0:     /* no change */
> > @@ -465,13 +880,6 @@ uint32_t i82596_ioport_readw(void *opaque, uint32_=
t
> addr)
> >       return -1;
> >   }
> >
> > -void i82596_h_reset(void *opaque)
> > -{
> > -    I82596State *s =3D opaque;
> > -
> > -    i82596_s_reset(s);
> > -}
> > -
> >   bool i82596_can_receive(NetClientState *nc)
> >   {
> >       I82596State *s =3D qemu_get_nic_opaque(nc);
> > @@ -595,7 +1003,6 @@ ssize_t i82596_receive(NetClientState *nc, const
> uint8_t *buf, size_t sz)
> >       rbd =3D get_uint32(rfd_p + 8);
> >       assert(rbd && rbd !=3D I596_NULL);
> >
> > -    trace_i82596_receive_packet(len);
> >       /* PRINT_PKTHDR("Receive", buf); */
> >
> >       while (len) {
> > @@ -714,14 +1121,113 @@ ssize_t i82596_receive(NetClientState *nc, cons=
t
> uint8_t *buf, size_t sz)
> >       return sz;
> >   }
> >
> > +ssize_t i82596_receive_iov(NetClientState *nc, const struct iovec *iov=
,
> > +                            int iovcnt)
> > +{
> > +    size_t sz =3D 0;
> > +    uint8_t *buf;
> > +    int i;
> > +    for (i =3D 0; i < iovcnt; i++) {
> > +        sz +=3D iov[i].iov_len;
> > +    }
> > +    if (sz =3D=3D 0) {
> > +        return -1;
> > +    }
> > +    buf =3D g_malloc(sz);
> > +    if (!buf) {
> > +        return -1;
> > +    }
> > +    size_t offset =3D 0;
> > +    for (i =3D 0; i < iovcnt; i++) {
> > +        if (iov[i].iov_base =3D=3D NULL) {
> > +            g_free(buf);
> > +            return -1;
> > +        }
> > +        memcpy(buf + offset, iov[i].iov_base, iov[i].iov_len);
> > +        offset +=3D iov[i].iov_len;
> > +    }
> > +    DBG(PRINT_PKTHDR("Receive IOV:", buf));
> > +    i82596_receive(nc, buf, sz);
> > +    g_free(buf);
> > +    return sz;
> > +}
> > +
> > +void i82596_poll(NetClientState *nc, bool enable)
> > +{
> > +    I82596State *s =3D qemu_get_nic_opaque(nc);
> > +
> > +    if (!enable) {
> > +        return;
> > +    }
> > +
> > +    if (s->send_irq) {
> > +        qemu_set_irq(s->irq, 1);
> > +    }
> > +
> > +    if (s->rx_status =3D=3D RX_NO_RESOURCES) {
> > +        if (s->cmd_p !=3D I596_NULL) {
> > +            s->rx_status =3D RX_READY;
> > +            update_scb_status(s);
> > +        }
> > +    }
> > +
> > +    if (s->cu_status =3D=3D CU_ACTIVE && s->cmd_p !=3D I596_NULL) {
> > +        examine_scb(s);
> > +    }
> > +    qemu_set_irq(s->irq, 0);
> > +}
> >
> >   const VMStateDescription vmstate_i82596 =3D {
> >       .name =3D "i82596",
> >       .version_id =3D 1,
> >       .minimum_version_id =3D 1,
> > -    .fields =3D (const VMStateField[]) {
> > +    .fields =3D (VMStateField[]) {
> > +        VMSTATE_UINT8(mode, I82596State),
> > +        VMSTATE_UINT16(t_on, I82596State),
> > +        VMSTATE_UINT16(t_off, I82596State),
> > +        VMSTATE_BOOL(throttle_state, I82596State),
> > +        VMSTATE_UINT32(iscp, I82596State),
> > +        VMSTATE_UINT8(sysbus, I82596State),
> > +        VMSTATE_UINT32(scb, I82596State),
> > +        VMSTATE_UINT32(scb_base, I82596State),
> > +        VMSTATE_UINT16(scb_status, I82596State),
> > +        VMSTATE_UINT8(cu_status, I82596State),
> > +        VMSTATE_UINT8(rx_status, I82596State),
> >           VMSTATE_UINT16(lnkst, I82596State),
> > -        VMSTATE_TIMER_PTR(flush_queue_timer, I82596State),
> > +        VMSTATE_UINT32(cmd_p, I82596State),
> > +        VMSTATE_INT32(ca, I82596State),
> > +        VMSTATE_INT32(ca_active, I82596State),
> > +        VMSTATE_INT32(send_irq, I82596State),
> > +        VMSTATE_BUFFER(mult, I82596State),
> > +        VMSTATE_BUFFER(config, I82596State),
> > +        VMSTATE_BUFFER(tx_buffer, I82596State),
> > +        VMSTATE_UINT32(tx_retry_addr, I82596State),
> > +        VMSTATE_INT32(tx_retry_count, I82596State),
> > +        VMSTATE_UINT32(tx_good_frames, I82596State),
> > +        VMSTATE_UINT32(tx_collisions, I82596State),
> > +        VMSTATE_UINT32(tx_aborted_errors, I82596State),
> > +        VMSTATE_UINT32(last_tx_len, I82596State),
> > +        VMSTATE_UINT32(collision_events, I82596State),
> > +        VMSTATE_UINT32(total_collisions, I82596State),
> > +        VMSTATE_UINT32(crc_err, I82596State),
> > +        VMSTATE_UINT32(align_err, I82596State),
> > +        VMSTATE_UINT32(resource_err, I82596State),
> > +        VMSTATE_UINT32(over_err, I82596State),
> > +        VMSTATE_UINT32(rcvdt_err, I82596State),
> > +        VMSTATE_UINT32(short_fr_error, I82596State),
> > +        VMSTATE_UINT32(total_frames, I82596State),
> > +        VMSTATE_UINT32(total_good_frames, I82596State),
> > +        VMSTATE_BUFFER(rx_buffer, I82596State),
> > +        VMSTATE_UINT16(tx_frame_len, I82596State),
> > +        VMSTATE_UINT16(rx_frame_len, I82596State),
> > +        VMSTATE_UINT64(current_tx_desc, I82596State),
> > +        VMSTATE_UINT64(current_rx_desc, I82596State),
> > +        VMSTATE_UINT32(last_good_rfa, I82596State),
> > +        VMSTATE_INT32(queue_head, I82596State),
> > +        VMSTATE_INT32(queue_tail, I82596State),
> > +        VMSTATE_INT32(queue_count, I82596State),
> > +        VMSTATE_BOOL(rnr_signaled, I82596State),
> > +        VMSTATE_BOOL(flushing_queue, I82596State),
> >           VMSTATE_END_OF_LIST()
> >       }
> >   };
> > @@ -736,8 +1242,15 @@ void i82596_common_init(DeviceState *dev,
> I82596State *s, NetClientInfo *info)
> >       qemu_format_nic_info_str(qemu_get_queue(s->nic),
> s->conf.macaddr.a);
> >
> >       if (USE_TIMER) {
> > -        s->flush_queue_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > -                                    i82596_flush_queue_timer, s);
> > +        if (!s->flush_queue_timer) {
> > +            s->flush_queue_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                        i82596_flush_queue_timer, s);
> > +        }
> > +        if (!s->throttle_timer) {
> > +            s->throttle_timer =3D timer_new_ns(QEMU_CLOCK_VIRTUAL,
> > +                                        i82596_bus_throttle_timer, s);
> > +        }
> >       }
> > +
> >       s->lnkst =3D 0x8000; /* initial link state: up */
> >   }
> > diff --git a/hw/net/i82596.h b/hw/net/i82596.h
> > index dc1fa1a1dc..67b18f957a 100644
> > --- a/hw/net/i82596.h
> > +++ b/hw/net/i82596.h
> > @@ -6,11 +6,15 @@
> >   #include "system/memory.h"
> >   #include "system/address-spaces.h"
> >
> > -#define PORT_RESET              0x00    /* reset 82596 */
> > -#define PORT_SELFTEST           0x01    /* selftest */
> > -#define PORT_ALTSCP             0x02    /* alternate SCB address */
> > -#define PORT_ALTDUMP            0x03    /* Alternate DUMP address */
> > -#define PORT_CA                 0x10    /* QEMU-internal CA signal */
> > +#define PACKET_QUEUE_SIZE 64
> > +#define RX_RING_SIZE    16
> > +#define PKT_BUF_SZ      1536
> > +
> > +#define PORT_RESET              0x00
> > +#define PORT_SELFTEST           0x01
> > +#define PORT_ALTSCP             0x02
> > +#define PORT_ALTDUMP            0x03
> > +#define PORT_CA                 0x10
> >
> >   typedef struct I82596State_st I82596State;
> >
> > @@ -21,35 +25,75 @@ struct I82596State_st {
> >       NICState *nic;
> >       NICConf conf;
> >       QEMUTimer *flush_queue_timer;
> > +    uint8_t mode;
> > +
> > +    QEMUTimer *throttle_timer;
> > +    uint16_t t_on;
> > +    uint16_t t_off;
> > +    bool throttle_state;
> >
> > -    hwaddr scp;         /* pointer to SCP */
> > +    hwaddr scp;
> > +    uint32_t iscp;
> >       uint8_t sysbus;
> > -    uint32_t scb;       /* SCB */
> > +    uint32_t scb;
> > +    uint32_t scb_base;
> >       uint16_t scb_status;
> >       uint8_t cu_status, rx_status;
> >       uint16_t lnkst;
> > +    uint32_t last_tx_len;
> > +    uint32_t collision_events;
> > +    uint32_t total_collisions;
> > +
> > +    uint32_t tx_retry_addr;
> > +    int tx_retry_count;
> > +    uint32_t tx_good_frames;
> > +    uint32_t tx_collisions;
> > +    uint32_t tx_aborted_errors;
> >
> > -    uint32_t cmd_p;     /* addr of current command */
> > +    uint32_t cmd_p;
> >       int ca;
> >       int ca_active;
> >       int send_irq;
> >
> > -    /* Hash register (multicast mask array, multiple individual
> addresses). */
> >       uint8_t mult[8];
> > -    uint8_t config[14]; /* config bytes from CONFIGURE command */
> > +    uint8_t config[14];
> > +
> > +    uint32_t crc_err;
> > +    uint32_t align_err;
> > +    uint32_t resource_err;
> > +    uint32_t over_err;
> > +    uint32_t rcvdt_err;
> > +    uint32_t short_fr_error;
> > +    uint32_t total_frames;
> > +    uint32_t total_good_frames;
> > +
> > +    uint8_t tx_buffer[PKT_BUF_SZ];
> > +    uint8_t rx_buffer[PKT_BUF_SZ];
> > +    uint16_t tx_frame_len;
> > +    uint16_t rx_frame_len;
> >
> > -    uint8_t tx_buffer[0x4000];
> > +    hwaddr current_tx_desc;
> > +    hwaddr current_rx_desc;
> > +    uint32_t last_good_rfa;
> > +    uint8_t packet_queue[PACKET_QUEUE_SIZE][PKT_BUF_SZ];
> > +    size_t packet_queue_len[PACKET_QUEUE_SIZE];
> > +    int queue_head;
> > +    int queue_tail;
> > +    int queue_count;
> > +    bool rnr_signaled;
> > +    bool flushing_queue;
> >   };
> >
> >   void i82596_h_reset(void *opaque);
> >   void i82596_ioport_writew(void *opaque, uint32_t addr, uint32_t val);
> >   uint32_t i82596_ioport_readw(void *opaque, uint32_t addr);
> > -void i82596_ioport_writel(void *opaque, uint32_t addr, uint32_t val);
> > -uint32_t i82596_ioport_readl(void *opaque, uint32_t addr);
> > -uint32_t i82596_bcr_readw(I82596State *s, uint32_t rap);
> >   ssize_t i82596_receive(NetClientState *nc, const uint8_t *buf, size_t
> size_);
> > +ssize_t i82596_receive_iov(NetClientState *nc, const struct iovec *iov=
,
> > +                           int iovcnt);
> >   bool i82596_can_receive(NetClientState *nc);
> >   void i82596_set_link_status(NetClientState *nc);
> > -void i82596_common_init(DeviceState *dev, I82596State *s, NetClientInf=
o
> *info);
> > +void i82596_poll(NetClientState *nc, bool enable);
> > +void i82596_common_init(DeviceState *dev, I82596State *s,
> > +                        NetClientInfo *info);
> >   extern const VMStateDescription vmstate_i82596;
> >   #endif
> > diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c
> > index 9e1dd21546..fc06588ade 100644
> > --- a/hw/net/lasi_i82596.c
> > +++ b/hw/net/lasi_i82596.c
> > @@ -86,6 +86,10 @@ static const MemoryRegionOps lasi_82596_mem_ops =3D =
{
> >           .min_access_size =3D 4,
> >           .max_access_size =3D 4,
> >       },
> > +    .impl =3D {
> > +        .min_access_size =3D 4,
> > +        .max_access_size =3D 4,
> > +    },
> >   };
> >
> >   static NetClientInfo net_lasi_82596_info =3D {
> > @@ -93,6 +97,8 @@ static NetClientInfo net_lasi_82596_info =3D {
> >       .size =3D sizeof(NICState),
> >       .can_receive =3D i82596_can_receive,
> >       .receive =3D i82596_receive,
> > +    .receive_iov =3D i82596_receive_iov,
> > +    .poll =3D i82596_poll,
> >       .link_status_changed =3D i82596_set_link_status,
> >   };
>
> ATB,
>
> Mark.
>
>

--00000000000034f8dd064287b8a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sat, Nov 1, 2025 at 5:55=E2=80=AFAM Ma=
rk Cave-Ayland &lt;<a href=3D"mailto:mark.cave-ayland@ilande.co.uk">mark.ca=
ve-ayland@ilande.co.uk</a>&gt; wrote:</div><div class=3D"gmail_quote gmail_=
quote_container"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">On 31/10=
/2025 21:15, Soumyajyotii Ssarkar wrote:<br>
<br>
&gt; From: RemZapCypher &lt;<a href=3D"mailto:soumyajyotisarkar23@gmail.com=
" target=3D"_blank">soumyajyotisarkar23@gmail.com</a>&gt;<br>
&gt; <br>
&gt; As a part of GSOC 2025 I have done a massive rewrite of what was the<b=
r>
&gt; 82596 NIC. This has been done to add the missing functionality accordi=
ng<br>
&gt; to the 82596 Manual and making the code more production<br>
&gt; ready.<br>
&gt; <br>
&gt; In this patch I have done the following:<br>
&gt; - Added comprehensive 82596 constants and configuration macros<br>
&gt; - Implemented address translation for segmented/linear memory modes<br=
>
&gt; - Added error recording and statistics tracking infrastructure<br>
&gt; - Implemented CRC-16/32 calculation and appending functions<br>
&gt; - Added CSMA/CD collision detection and backoff logic<br>
&gt; - Implemented bus throttle timer framework<br>
&gt; - Added enhanced reset with full state initialization<br>
&gt; - Added receive_iov and polling support functions<br>
&gt; - Updated VMState for migration of all new fields<br>
&gt; <br>
&gt; Note:<br>
&gt; This patch primarily includes placeholder code.<br>
&gt; To achieve full 82596 emulation, the complete 82596 patch series is re=
quired.<br>
&gt; Nevertheless, QEMU is able to load and boot successfully with this pat=
ch.<br>
&gt; <br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0hw/net/i82596.c=C2=A0 =C2=A0 =C2=A0 | 667 ++++++++++++++++=
++++++++++++++++++++++-----<br>
&gt;=C2=A0 =C2=A0hw/net/i82596.h=C2=A0 =C2=A0 =C2=A0 |=C2=A0 74 ++++-<br>
&gt;=C2=A0 =C2=A0hw/net/lasi_i82596.c |=C2=A0 =C2=A06 +<br>
&gt;=C2=A0 =C2=A03 files changed, 655 insertions(+), 92 deletions(-)<br>
&gt; <br>
&gt; diff --git a/hw/net/i82596.c b/hw/net/i82596.c<br>
&gt; index c1ff3e6c56..859cc88b2e 100644<br>
&gt; --- a/hw/net/i82596.c<br>
&gt; +++ b/hw/net/i82596.c<br>
&gt; @@ -2,10 +2,38 @@<br>
&gt;=C2=A0 =C2=A0 * QEMU Intel i82596 (Apricot) emulation<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt;=C2=A0 =C2=A0 * Copyright (c) 2019 Helge Deller &lt;<a href=3D"mailto:d=
eller@gmx.de" target=3D"_blank">deller@gmx.de</a>&gt;<br>
&gt; - * This work is licensed under the GNU GPL license version 2 or later=
.<br>
&gt;=C2=A0 =C2=A0 *<br>
&gt; + * Additional functionality added by:<br>
&gt; + * Soumyajyotii Ssarkar &lt;<a href=3D"mailto:soumyajyotisarkar23@gma=
il.com" target=3D"_blank">soumyajyotisarkar23@gmail.com</a>&gt;<br>
&gt; + * During GSOC 2025 under mentorship of Helge Deller.<br>
&gt; + *<br>
&gt; + * This work is licensed under the GNU GPL license version 2 or later=
.<br>
&gt;=C2=A0 =C2=A0 * This software was written to be compatible with the spe=
cification:<br>
&gt;=C2=A0 =C2=A0 * <a href=3D"https://parisc.docs.kernel.org/en/latest/_do=
wnloads/96672be0650d9fc046bbcea40b92482f/82596CA.pdf" rel=3D"noreferrer" ta=
rget=3D"_blank">https://parisc.docs.kernel.org/en/latest/_downloads/96672be=
0650d9fc046bbcea40b92482f/82596CA.pdf</a><br>
&gt; + *<br>
&gt; + * INDEX:<br>
&gt; + * 1.=C2=A0 Reset<br>
&gt; + * 2.=C2=A0 Address Translation<br>
&gt; + * 3.=C2=A0 Transmit functions<br>
&gt; + * 4.=C2=A0 Receive Helper functions<br>
&gt; + * 5.=C2=A0 Receive functions<br>
&gt; + * 6.=C2=A0 Misc Functionality Functions<br>
&gt; + * 6.1 Individual Address<br>
&gt; + * 6.2 Multicast Address List<br>
&gt; + * 6.3 Link Status<br>
&gt; + * 6.4 CSMA/CD functions<br>
&gt; + * 6.5 Unified CRC Calculation<br>
&gt; + * 6.6 Unified Statistics Update<br>
&gt; + * 7.=C2=A0 Bus Throttling Timer<br>
&gt; + * 8.=C2=A0 Dump functions<br>
&gt; + * 9.=C2=A0 Configure<br>
&gt; + * 10. Command Loop<br>
&gt; + * 11. Examine SCB<br>
&gt; + * 12. Channel attention (CA)<br>
&gt; + * 13. LASI interface<br>
&gt; + * 14. Polling functions<br>
&gt; + * 15. QOM and interface functions<br>
&gt; + *<br>
&gt;=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#include &quot;qemu/osdep.h&quot;<br>
&gt; @@ -21,50 +49,90 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;i82596.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &lt;zlib.h&gt; /* for crc32 */<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +#define ENABLE_DEBUG 0<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#if defined(ENABLE_DEBUG)<br>
&gt;=C2=A0 =C2=A0#define DBG(x)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x<br>
&gt;=C2=A0 =C2=A0#else<br>
&gt;=C2=A0 =C2=A0#define DBG(x)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 do { } wh=
ile (0)<br>
&gt;=C2=A0 =C2=A0#endif<br>
<br>
All new code should use trace-events instead of #defines to enable debuggin=
g.<br>
<br>
&gt; -#define USE_TIMER=C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt; -<br>
&gt; -#define BITS(n, m) (((0xffffffffU &lt;&lt; (31 - n)) &gt;&gt; (31 - n=
 + m)) &lt;&lt; m)<br>
&gt; +#define USE_TIMER=C2=A0 =C2=A0 =C2=A0 =C2=A01<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#define PKT_BUF_SZ=C2=A0 =C2=A0 =C2=A0 1536<br>
&gt;=C2=A0 =C2=A0#define MAX_MC_CNT=C2=A0 =C2=A0 =C2=A0 64<br>
&gt; -<br>
&gt; -#define ISCP_BUSY=C2=A0 =C2=A0 =C2=A0 =C2=A00x0001<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0#define I596_NULL=C2=A0 =C2=A0 =C2=A0 =C2=A0((uint32_t)0xf=
fffffff)<br>
&gt; -<br>
&gt; -#define SCB_STATUS_CX=C2=A0 =C2=A00x8000 /* CU finished command with =
I bit */<br>
&gt; -#define SCB_STATUS_FR=C2=A0 =C2=A00x4000 /* RU finished receiving a f=
rame */<br>
&gt; -#define SCB_STATUS_CNA=C2=A0 0x2000 /* CU left active state */<br>
&gt; -#define SCB_STATUS_RNR=C2=A0 0x1000 /* RU left active state */<br>
&gt; -<br>
&gt; -#define SCB_COMMAND_ACK_MASK \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 (SCB_STATUS_CX | SCB_STATUS_FR | SCB_STAT=
US_CNA | SCB_STATUS_RNR)<br>
&gt; -<br>
&gt; +#define BITS(n, m)=C2=A0 =C2=A0 =C2=A0 (((0xffffffffU &lt;&lt; (31 - =
n)) &gt;&gt; (31 - n + m)) &lt;&lt; m)<br>
&gt; +<br>
&gt; +#define SCB_STATUS_CX=C2=A0 =C2=A00x8000=C2=A0 /* CU finished command=
 with I bit */<br>
&gt; +#define SCB_STATUS_FR=C2=A0 =C2=A00x4000=C2=A0 /* RU finished receivi=
ng a frame */<br>
&gt; +#define SCB_STATUS_CNA=C2=A0 0x2000=C2=A0 /* CU left active state */<=
br>
&gt; +#define SCB_STATUS_RNR=C2=A0 0x1000=C2=A0 /* RU left active state */<=
br>
&gt; +#define SCB_ACK_MASK=C2=A0 =C2=A0 0xF000=C2=A0 /* All interrupt ackno=
wledge bits */<br>
&gt; +<br>
&gt; +/* 82596 Operational Modes */<br>
&gt; +#define I82586_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A00x00<br>
&gt; +#define I82596_MODE_SEGMENTED=C2=A0 =C2=A0 =C2=A0 =C2=A00x01<br>
&gt; +#define I82596_MODE_LINEAR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x02<br>
&gt; +<br>
&gt; +/* Monitor Options */<br>
&gt; +#define MONITOR_NORMAL=C2=A0 =C2=A0 =C2=A0 0x00<br>
&gt; +#define MONITOR_FILTERED=C2=A0 =C2=A0 0x01<br>
&gt; +#define MONITOR_ALL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x02<br>
&gt; +#define MONITOR_DISABLED=C2=A0 =C2=A0 0x03<br>
&gt; +<br>
&gt; +/* Operation mode flags from SYSBUS byte */<br>
&gt; +#define SYSBUS_LOCK_EN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08<br>
&gt; +#define SYSBUS_INT_ACTIVE_LOW=C2=A0 0x10<br>
&gt; +#define SYSBUS_BIG_ENDIAN_32=C2=A0 =C2=A00x80<br>
&gt; +#define SYSBUS_THROTTLE_MASK=C2=A0 =C2=A00x60<br>
&gt; +<br>
&gt; +/* SCB commands - Command Unit (CU) */<br>
&gt; +#define SCB_CUC_NOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00<br>
&gt; +#define SCB_CUC_START=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01<br>
&gt; +#define SCB_CUC_RESUME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x02<br>
&gt; +#define SCB_CUC_SUSPEND=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x03<br>
&gt; +#define SCB_CUC_ABORT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>
&gt; +#define SCB_CUC_LOAD_THROTTLE=C2=A0 0x05<br>
&gt; +#define SCB_CUC_LOAD_START=C2=A0 =C2=A0 =C2=A00x06<br>
&gt; +<br>
&gt; +/* SCB commands - Receive Unit (RU) */<br>
&gt; +#define SCB_RUC_NOP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00<br>
&gt; +#define SCB_RUC_START=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x01<br>
&gt; +#define SCB_RUC_RESUME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x02<br>
&gt; +#define SCB_RUC_SUSPEND=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x03<br>
&gt; +#define SCB_RUC_ABORT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>
&gt; +<br>
&gt; +/* SCB statuses - Command Unit (CU) */<br>
&gt;=C2=A0 =C2=A0#define CU_IDLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt;=C2=A0 =C2=A0#define CU_SUSPENDED=C2=A0 =C2=A0 1<br>
&gt;=C2=A0 =C2=A0#define CU_ACTIVE=C2=A0 =C2=A0 =C2=A0 =C2=A02<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#define RX_IDLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>
&gt; -#define RX_SUSPENDED=C2=A0 =C2=A0 1<br>
&gt; -#define RX_READY=C2=A0 =C2=A0 =C2=A0 =C2=A0 4<br>
&gt; +/* SCB statuses - Receive Unit (RU) */<br>
&gt; +#define RX_IDLE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00<br>
&gt; +#define RX_SUSPENDED=C2=A0 =C2=A0 0x01<br>
&gt; +#define RX_NO_RESOURCES 0x02<br>
&gt; +#define RX_READY=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x04<br>
&gt; +#define RX_NO_RESO_RBD=C2=A0 0x0A<br>
&gt; +#define RX_NO_MORE_RBD=C2=A0 0x0C<br>
&gt; +<br>
&gt; +#define CMD_FLEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0008<br>
&gt; +#define CMD_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0007<br>
&gt; +<br>
&gt; +#define CMD_EOL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x8000<br>
&gt; +#define CMD_SUSP=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4000<br>
&gt; +#define CMD_INTR=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2000<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#define CMD_EOL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x8000=C2=A0 /* The =
last command of the list, stop. */<br>
&gt; -#define CMD_SUSP=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4000=C2=A0 /* Suspend a=
fter doing cmd. */<br>
&gt; -#define CMD_INTR=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x2000=C2=A0 /* Interrupt=
 after doing cmd. */<br>
&gt; +#define ISCP_BUSY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A00x01<br>
&gt; +#define NANOSECONDS_PER_MICROSECOND 1000<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#define CMD_FLEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0008=C2=A0 /* Enable fl=
exible memory model */<br>
&gt; +#define DUMP_BUF_SZ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0304<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0enum commands {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CmdNOp =3D 0, CmdSASetup =3D 1=
, CmdConfigure =3D 2, CmdMulticastList =3D 3,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0CmdTx =3D 4, CmdTDR =3D 5, Cmd=
Dump =3D 6, CmdDiagnose =3D 7<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0#define STAT_C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8000=C2=
=A0 /* Set to 0 after execution */<br>
&gt;=C2=A0 =C2=A0#define STAT_B=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x4000=C2=
=A0 /* Command being executed */<br>
&gt;=C2=A0 =C2=A0#define STAT_OK=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x2000=C2=
=A0 /* Command executed ok */<br>
&gt; @@ -73,15 +141,60 @@ enum commands {<br>
&gt;=C2=A0 =C2=A0#define I596_EOF=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x8000<br>
&gt;=C2=A0 =C2=A0#define SIZE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x3fff<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -/* various flags in the chip config registers */<br>
&gt; -#define I596_PREFETCH=C2=A0 =C2=A0(s-&gt;config[0] &amp; 0x80)<br>
&gt; -#define I596_PROMISC=C2=A0 =C2=A0 (s-&gt;config[8] &amp; 0x01)<br>
&gt; -#define I596_BC_DISABLE (s-&gt;config[8] &amp; 0x02) /* broadcast dis=
able */<br>
&gt; -#define I596_NOCRC_INS=C2=A0 (s-&gt;config[8] &amp; 0x08)<br>
&gt; -#define I596_CRCINM=C2=A0 =C2=A0 =C2=A0(s-&gt;config[11] &amp; 0x04) =
/* CRC appended */<br>
&gt; -#define I596_MC_ALL=C2=A0 =C2=A0 =C2=A0(s-&gt;config[11] &amp; 0x20)<=
br>
&gt; -#define I596_MULTIIA=C2=A0 =C2=A0 (s-&gt;config[13] &amp; 0x40)<br>
&gt; -<br>
&gt; +#define CSMA_SLOT_TIME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A051<br>
&gt; +#define CSMA_MAX_RETRIES=C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
&gt; +#define CSMA_BACKOFF_LIMIT=C2=A0 =C2=A0 =C2=A010<br>
&gt; +<br>
&gt; +/* Global Flags fetched from config bytes */<br>
&gt; +#define I596_PREFETCH=C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;config[0] &amp=
; 0x80)<br>
&gt; +#define SAVE_BAD_FRAMES=C2=A0 =C2=A0 =C2=A0(s-&gt;config[2] &amp; 0x8=
0)<br>
&gt; +#define I596_NO_SRC_ADD_IN=C2=A0 (s-&gt;config[3] &amp; 0x08)<br>
&gt; +#define I596_LOOPBACK=C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;config[3] &gt;=
&gt; 6)<br>
&gt; +#define I596_PROMISC=C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;config[8] &amp=
; 0x01)<br>
&gt; +#define I596_BC_DISABLE=C2=A0 =C2=A0 =C2=A0(s-&gt;config[8] &amp; 0x0=
2)<br>
&gt; +#define I596_NOCRC_INS=C2=A0 =C2=A0 =C2=A0 (s-&gt;config[8] &amp; 0x0=
8)<br>
&gt; +#define I596_CRC16_32=C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;config[8] &amp=
; 0x10)<br>
&gt; +#define I596_PADDING=C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;config[8] &amp=
; 0x80)<br>
&gt; +#define I596_MIN_FRAME_LEN=C2=A0 (s-&gt;config[10])<br>
&gt; +#define I596_CRCINM=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;config[11=
] &amp; 0x04)<br>
&gt; +#define I596_MONITOR_MODE=C2=A0 =C2=A0((s-&gt;config[11] &gt;&gt; 6) =
&amp; 0x03)<br>
&gt; +#define I596_MC_ALL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(s-&gt;config[11=
] &amp; 0x20)<br>
&gt; +#define I596_FULL_DUPLEX=C2=A0 =C2=A0 (s-&gt;config[12] &amp; 0x40)<b=
r>
&gt; +#define I596_MULTIIA=C2=A0 =C2=A0 =C2=A0 =C2=A0 (s-&gt;config[13] &am=
p; 0x40)<br>
&gt; +<br>
&gt; +/* RX Error flags */<br>
&gt; +#define RX_COLLISIONS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x0001<br>
&gt; +#define RX_LENGTH_ERRORS=C2=A0 =C2=A0 =C2=A0 0x0080<br>
&gt; +#define RX_OVER_ERRORS=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0100<br>
&gt; +#define RX_FIFO_ERRORS=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x0400<br>
&gt; +#define RX_FRAME_ERRORS=C2=A0 =C2=A0 =C2=A0 =C2=A00x0800<br>
&gt; +#define RX_CRC_ERRORS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x1000<br>
&gt; +#define RX_LENGTH_ERRORS_ALT=C2=A0 0x2000<br>
&gt; +#define RFD_STATUS_TRUNC=C2=A0 =C2=A0 =C2=A0 0x0020<br>
&gt; +#define RFD_STATUS_NOBUFS=C2=A0 =C2=A0 =C2=A00x0200<br>
&gt; +<br>
&gt; +/* TX Error flags */<br>
&gt; +#define TX_COLLISIONS=C2=A0 =C2=A0 =C2=A0 =C2=A00x0020<br>
&gt; +#define TX_HEARTBEAT_ERRORS 0x0040<br>
&gt; +#define TX_CARRIER_ERRORS=C2=A0 =C2=A00x0400<br>
&gt; +#define TX_COLLISIONS_ALT=C2=A0 =C2=A00x0800<br>
&gt; +#define TX_ABORTED_ERRORS=C2=A0 =C2=A00x1000<br>
&gt; +<br>
&gt; +static void i82596_update_scb_irq(I82596State *s, bool trigger);<br>
&gt; +static void i82596_update_cu_status(I82596State *s, uint16_t cmd_stat=
us,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool generat=
e_interrupt);<br>
&gt; +static void update_scb_status(I82596State *s);<br>
&gt; +static void examine_scb(I82596State *s);<br>
&gt; +static bool i82596_check_medium_status(I82596State *s);<br>
&gt; +static int i82596_csma_backoff(I82596State *s, int retry_count);<br>
&gt; +static uint16_t i82596_calculate_crc16(const uint8_t *data, size_t le=
n);<br>
&gt; +static size_t i82596_append_crc(I82596State *s, uint8_t *buffer, size=
_t len);<br>
&gt; +static void i82596_bus_throttle_timer(void *opaque);<br>
&gt; +static void i82596_flush_queue_timer(void *opaque);<br>
&gt; +static int i82596_flush_packet_queue(I82596State *s);<br>
&gt; +static void i82596_update_statistics(I82596State *s, bool is_tx,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t er=
ror_flags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t co=
llision_count);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static uint8_t get_byte(uint32_t addr)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; @@ -116,7 +229,44 @@ static void set_uint32(uint32_t addr, uint32_t va=
l)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0set_uint16(addr + 2, val &gt;&gt; 16);<br>
&gt;=C2=A0 =C2=A0}<br>
<br>
What is the endianness of where this is used? I&#39;d expect to see an stw_=
* function <br>
being used here.<br>
<br></blockquote><div>Hello Mark,</div><div>Thank you for your detailed rev=
iew of my patch and pointing out the endianness concerns.</div><div>set_uin=
t32() does call set_uint16() which internally=C2=A0calls stw_be_phys().=C2=
=A0</div><div>I do understand your concern about using stl_* functions dire=
ctly.</div><div><br></div><div>Regarding the 16 bit writes rather than the =
stl_be_phy() is that 82596 requires 16 bit aligned</div><div>access but doe=
s not guarantee a 4-byte alignment in 32-bit values.</div><div>I think usin=
g stl_be_phys() would require 4-byte alignment which isn&#39;t always guara=
nteed for our 82596 structures.</div><div>Please let me know your opinion o=
n this.</div><div><br></div><div>Thank you,</div><div>Soumyajyotii</div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
&gt; +/* Centralized error detection and update mechanism */<br>
&gt; +static void i82596_record_error(I82596State *s, uint16_t error_type, =
bool is_tx)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (is_tx) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error_type &amp; TX_ABORTED_ERRORS) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_aborted_errors++;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_uint32(s-&gt;scb + 28, =
s-&gt;tx_aborted_errors);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error_type &amp; RX_CRC_ERRORS) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;crc_err++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_uint32(s-&gt;scb + 16, =
s-&gt;crc_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error_type &amp; (RX_LENGTH_ERRORS | =
RX_LENGTH_ERRORS_ALT |<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 RX_FRAME_ERRORS)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;align_err++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_uint32(s-&gt;scb + 18, =
s-&gt;align_err);<br>
<br>
and an stl_* function here?<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error_type &amp; RFD_STATUS_NOBUFS) {=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;resource_err++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_uint32(s-&gt;scb + 20, =
s-&gt;resource_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error_type &amp; (RX_OVER_ERRORS | RX=
_FIFO_ERRORS)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;over_err++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_uint32(s-&gt;scb + 22, =
s-&gt;over_err);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error_type &amp; RFD_STATUS_TRUNC) {<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;short_fr_error++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_uint32(s-&gt;scb + 26, =
s-&gt;short_fr_error);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Packet Header Debugger */<br>
&gt;=C2=A0 =C2=A0struct qemu_ether_header {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t ether_dhost[6];<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t ether_shost[6];<br>
&gt; @@ -124,12 +274,122 @@ struct qemu_ether_header {<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0#define PRINT_PKTHDR(txt, BUF) do {=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 struct qemu_ether_header *hdr =3D (void *)(BUF); \<br>
&gt; -=C2=A0 =C2=A0 printf(txt &quot;: packet dhost=3D&quot; MAC_FMT &quot;=
, shost=3D&quot; MAC_FMT &quot;, type=3D0x%04x\n&quot;,\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MAC_ARG(hdr-&gt;ether_dhost)=
, MAC_ARG(hdr-&gt;ether_shost),=C2=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0be16_to_cpu(hdr-&gt;ether_ty=
pe));=C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
&gt;=C2=A0 =C2=A0} while (0)<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void i82596_cleanup(I82596State *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;throttle_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(s-&gt;throttle_timer);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;flush_queue_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(s-&gt;flush_queue_timer);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 s-&gt;queue_head =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;queue_tail =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;queue_count =3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void i82596_s_reset(I82596State *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 trace_i82596_s_reset(s);<br>
&gt; +=C2=A0 =C2=A0 i82596_cleanup(s);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Clearing config bits */<br>
&gt; +=C2=A0 =C2=A0 memset(s-&gt;config, 0, sizeof(s-&gt;config));<br>
&gt; +=C2=A0 =C2=A0 s-&gt;scp =3D 0x00FFFFF4;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;scb =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;scb_base =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;scb_status =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;cu_status =3D CU_IDLE;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rx_status =3D RX_IDLE;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;cmd_p =3D I596_NULL;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;lnkst =3D 0x8000;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;ca =3D s-&gt;ca_active =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;send_irq =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 /* Statistical Counters */<br>
&gt; +=C2=A0 =C2=A0 s-&gt;crc_err =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;align_err =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;resource_err =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;over_err =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rcvdt_err =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;short_fr_error =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;total_frames =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;total_good_frames =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;collision_events =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;total_collisions =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_good_frames =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_collisions =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_aborted_errors =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;last_tx_len =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;last_good_rfa =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;current_rx_desc =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;current_tx_desc =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_retry_addr =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_retry_count =3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rnr_signaled =3D false;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;flushing_queue =3D false;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 memset(s-&gt;tx_buffer, 0, sizeof(s-&gt;tx_buffer));<br=
>
&gt; +=C2=A0 =C2=A0 memset(s-&gt;rx_buffer, 0, sizeof(s-&gt;rx_buffer));<br=
>
&gt; +=C2=A0 =C2=A0 s-&gt;tx_frame_len =3D 0;<br>
&gt; +=C2=A0 =C2=A0 s-&gt;rx_frame_len =3D 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void i82596_h_reset(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 I82596State *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 i82596_s_reset(s);<br>
&gt; +}<br>
&gt; +<br>
&gt; +/*<br>
&gt; + * Address Translation Implementation<br>
&gt; + * Handles segmented and linear memory modes for i82596.<br>
&gt; + * Returns physical address for DMA operations.<br>
&gt; + * Returns I596_NULL (0xffffffff) on invalid addresses.<br>
&gt; + */<br>
&gt; +static inline uint32_t i82596_translate_address(I82596State *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t logical_addr,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool is_data_buffer)<br>
<br>
Drop the inline: for modern compilers it is a weak hint, and the compiler w=
ill just <br>
do the right thing here.<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (logical_addr =3D=3D I596_NULL || logical_addr =3D=
=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return logical_addr;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 switch (s-&gt;mode) {<br>
&gt; +=C2=A0 =C2=A0 case I82596_MODE_LINEAR:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return logical_addr;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case I82596_MODE_SEGMENTED: {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t base =3D (logical_addr &gt;&gt; =
16) &amp; 0xFFFF;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t offset =3D logical_addr &amp; 0x=
FFFF;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_data_buffer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return (base &lt;&lt; 4) + =
offset;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (base =3D=3D 0xFFFF &amp=
;&amp; offset =3D=3D 0xFFFF) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return I596_N=
ULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return s-&gt;scb_base + ((b=
ase &lt;&lt; 4) + offset);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 case I82586_MODE:<br>
&gt; +=C2=A0 =C2=A0 default:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (is_data_buffer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return logical_addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if ((logical_addr &amp; 0xF=
FFF0000) =3D=3D 0xFFFF0000) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return I596_N=
ULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return s-&gt;scb_base + log=
ical_addr;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0static void i82596_transmit(I82596State *s, uint32_t addr)=
<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t tdb_p; /* Transmit Buffer Descripto=
r */<br>
&gt; @@ -223,32 +483,198 @@ static void set_multicast_list(I82596State *s, =
uint32_t addr)<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void i82596_set_link_status(NetClientState *nc)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 I82596State *d =3D qemu_get_nic_opaque(nc);<br>
&gt; +=C2=A0 =C2=A0 I82596State *s =3D qemu_get_nic_opaque(nc);<br>
&gt; +=C2=A0 =C2=A0 bool was_up =3D s-&gt;lnkst !=3D 0;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 s-&gt;lnkst =3D nc-&gt;link_down ? 0 : 0x8000;<br>
&gt; +=C2=A0 =C2=A0 bool is_up =3D s-&gt;lnkst !=3D 0;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 d-&gt;lnkst =3D nc-&gt;link_down ? 0 : 0x8000;<br>
&gt; +=C2=A0 =C2=A0 if (!was_up &amp;&amp; is_up &amp;&amp; s-&gt;rx_status=
 =3D=3D RX_READY) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_flush_queued_packets(qemu_get_queue(=
s-&gt;nic));<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static void update_scb_status(I82596State *s)<br>
&gt; +static bool G_GNUC_UNUSED i82596_check_medium_status(I82596State *s)<=
br>
<br>
Generally you want to arrange the series so that you don&#39;t require G_GN=
UC_UNUSED: the <br>
function should be defined at the point where it is first used.<br>
<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 s-&gt;scb_status =3D (s-&gt;scb_status &amp; 0xf000)<br=
>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 | (s-&gt;cu_status &lt;&lt; 8) | (s-&gt;r=
x_status &lt;&lt; 4);<br>
&gt; -=C2=A0 =C2=A0 set_uint16(s-&gt;scb, s-&gt;scb_status);<br>
&gt; +=C2=A0 =C2=A0 if (I596_FULL_DUPLEX) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!s-&gt;throttle_state) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!I596_LOOPBACK &amp;&amp; (qemu_clock_get_ns(QEMU_C=
LOCK_VIRTUAL) % 100 &lt; 5)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;collision_events++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return false;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 return true;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static int G_GNUC_UNUSED i82596_csma_backoff(I82596State *s, int retr=
y_count)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 int backoff_factor, slot_count, backoff_time;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 backoff_factor =3D MIN(retry_count + 1, CSMA_BACKOFF_LI=
MIT);<br>
&gt; +=C2=A0 =C2=A0 slot_count =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) % =
(1 &lt;&lt; backoff_factor);<br>
&gt; +=C2=A0 =C2=A0 backoff_time =3D slot_count * CSMA_SLOT_TIME;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static void i82596_s_reset(I82596State *s)<br>
&gt; +=C2=A0 =C2=A0 return backoff_time;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static uint16_t i82596_calculate_crc16(const uint8_t *data, size_t le=
n)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; -=C2=A0 =C2=A0 trace_i82596_s_reset(s);<br>
&gt; -=C2=A0 =C2=A0 s-&gt;scp =3D 0;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;scb_status =3D 0;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;cu_status =3D CU_IDLE;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;rx_status =3D RX_SUSPENDED;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;cmd_p =3D I596_NULL;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;lnkst =3D 0x8000; /* initial link state: up */<br=
>
&gt; -=C2=A0 =C2=A0 s-&gt;ca =3D s-&gt;ca_active =3D 0;<br>
&gt; -=C2=A0 =C2=A0 s-&gt;send_irq =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint16_t crc =3D 0xFFFF;<br>
&gt; +=C2=A0 =C2=A0 size_t i, j;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; len; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crc ^=3D data[i] &lt;&lt; 8;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (j =3D 0; j &lt; 8; j++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (crc &amp; 0x8000) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crc =3D (crc =
&lt;&lt; 1) ^ 0x1021;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 crc &lt;&lt;=
=3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 return crc;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static size_t G_GNUC_UNUSED i82596_append_crc(I82596State *s, uint8_t=
 *buffer, size_t len)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (len + 4 &gt; PKT_BUF_SZ) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (I596_CRC16_32) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint32_t crc =3D crc32(~0, buffer, len);<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crc =3D cpu_to_be32(crc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;buffer[len], &amp;crc, sizeof=
(crc));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len + sizeof(crc);<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t crc =3D i82596_calculate_crc16(b=
uffer, len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 crc =3D cpu_to_be16(crc);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(&amp;buffer[len], &amp;crc, sizeof=
(crc));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return len + sizeof(crc);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void G_GNUC_UNUSED i82596_update_statistics(I82596State *s, bo=
ol is_tx,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t er=
ror_flags,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 uint16_t co=
llision_count)<br>
<br>
Same here with formatting.<br>
<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (is_tx) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (collision_count &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_collisions +=3D co=
llision_count;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;collision_events++;<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;total_collisions +=3D=
 collision_count;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_uint32(s-&gt;scb + 32, =
s-&gt;tx_collisions);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error_flags) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i82596_record_error(s, erro=
r_flags, true);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!(error_flags &amp; (TX_ABORTED_ERROR=
S | TX_CARRIER_ERRORS))) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;tx_good_frames++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_uint32(s-&gt;scb + 36, =
s-&gt;tx_good_frames);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;total_frames++;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 set_uint32(s-&gt;scb + 40, s-&gt;total_fr=
ames);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (error_flags) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i82596_record_error(s, erro=
r_flags, false);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;total_good_frames++;<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_uint32(s-&gt;scb + 44, =
s-&gt;total_good_frames);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +/* Bus Throttle Functionality */<br>
&gt; +static void G_GNUC_UNUSED i82596_bus_throttle_timer(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 I82596State *s =3D opaque;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;throttle_state) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;throttle_state =3D false;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;t_off &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(s-&gt;throttle_ti=
mer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (s-&gt;t_off * NANOSECONDS_PER_MICROSECOND));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;throttle_state =3D true;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;t_on &gt; 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(s-&gt;throttle_ti=
mer,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 (s-&gt;t_on * NANOSECONDS_PER_MICROSECOND));<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;cu_status =3D=3D CU_ACTIVE || s=
-&gt;rx_status =3D=3D RX_READY) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 examine_scb(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int G_GNUC_UNUSED i82596_flush_packet_queue(I82596State *s)<br=
>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* Stub for now - will be implemented in Patch 2 */<br>
&gt; +=C2=A0 =C2=A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void G_GNUC_UNUSED i82596_flush_queue_timer(void *opaque)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 /* Stub for now - will be implemented in Patch 2 */<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void i82596_update_scb_irq(I82596State *s, bool trigger)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (trigger) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;send_irq =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, 1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void G_GNUC_UNUSED i82596_update_cu_status(I82596State *s, uin=
t16_t cmd_status,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bool generat=
e_interrupt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 if (cmd_status &amp; STAT_C) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (cmd_status &amp; STAT_OK) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;cu_status =3D=3D =
CU_ACTIVE &amp;&amp; s-&gt;cmd_p =3D=3D I596_NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cu_stat=
us =3D CU_IDLE;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;scb_sta=
tus |=3D SCB_STATUS_CNA;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;cu_status =3D CU_IDLE=
;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;scb_status |=3D SCB_S=
TATUS_CNA;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (generate_interrupt) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;scb_status |=3D SCB_S=
TATUS_CX;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i82596_update_scb_irq(s, tr=
ue);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 update_scb_status(s);<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +static void update_scb_status(I82596State *s)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 s-&gt;scb_status =3D (s-&gt;scb_status &amp; 0xf000)<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 | (s-&gt;cu_status &lt;&lt; 8) | (s-&gt;r=
x_status &lt;&lt; 4) | (s-&gt;lnkst &gt;&gt; 8);<br>
&gt; +=C2=A0 =C2=A0 set_uint16(s-&gt;scb, s-&gt;scb_status);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 set_uint32(s-&gt;scb + 28, s-&gt;tx_aborted_errors);<br=
>
&gt; +=C2=A0 =C2=A0 set_uint32(s-&gt;scb + 32, s-&gt;tx_collisions);<br>
&gt; +=C2=A0 =C2=A0 set_uint32(s-&gt;scb + 36, s-&gt;tx_good_frames);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 set_uint32(s-&gt;scb + 16, s-&gt;crc_err);<br>
&gt; +=C2=A0 =C2=A0 set_uint32(s-&gt;scb + 18, s-&gt;align_err);<br>
&gt; +=C2=A0 =C2=A0 set_uint32(s-&gt;scb + 20, s-&gt;resource_err);<br>
&gt; +=C2=A0 =C2=A0 set_uint32(s-&gt;scb + 22, s-&gt;over_err);<br>
&gt; +=C2=A0 =C2=A0 set_uint32(s-&gt;scb + 24, s-&gt;rcvdt_err);<br>
&gt; +=C2=A0 =C2=A0 set_uint32(s-&gt;scb + 26, s-&gt;short_fr_error);<br>
&gt; +}<br>
<br>
The set_uint16() and set_uint32() functions don&#39;t look correct: you wan=
t to reference <br>
all addresses through their offset from the base address rather than their =
absolute <br>
address, since for other boards they can be mapped at other addresses.<br>
<br>
&gt;=C2=A0 =C2=A0static void command_loop(I82596State *s)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt; @@ -330,17 +756,6 @@ static void command_loop(I82596State *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_flush_queued_packets(qemu_get_queue(s-&=
gt;nic));<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -static void i82596_flush_queue_timer(void *opaque)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 I82596State *s =3D opaque;<br>
&gt; -=C2=A0 =C2=A0 if (0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_del(s-&gt;flush_queue_timer);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_flush_queued_packets(qemu_get_queue(=
s-&gt;nic));<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 timer_mod(s-&gt;flush_queue_timer,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_clock_get_ms(QE=
MU_CLOCK_VIRTUAL) + 1000);<br>
&gt; -=C2=A0 =C2=A0 }<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0static void examine_scb(I82596State *s)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t command, cuc, ruc;<br>
&gt; @@ -353,7 +768,7 @@ static void examine_scb(I82596State *s)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* and clear the scb command word */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0set_uint16(s-&gt;scb + 2, 0);<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 s-&gt;scb_status &amp;=3D ~(command &amp; SCB_COMMAND_A=
CK_MASK);<br>
&gt; +=C2=A0 =C2=A0 s-&gt;scb_status &amp;=3D ~(command &amp; SCB_ACK_MASK)=
;<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (cuc) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case 0:=C2=A0 =C2=A0 =C2=A0/* no change */<b=
r>
&gt; @@ -465,13 +880,6 @@ uint32_t i82596_ioport_readw(void *opaque, uint32=
_t addr)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -void i82596_h_reset(void *opaque)<br>
&gt; -{<br>
&gt; -=C2=A0 =C2=A0 I82596State *s =3D opaque;<br>
&gt; -<br>
&gt; -=C2=A0 =C2=A0 i82596_s_reset(s);<br>
&gt; -}<br>
&gt; -<br>
&gt;=C2=A0 =C2=A0bool i82596_can_receive(NetClientState *nc)<br>
&gt;=C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0I82596State *s =3D qemu_get_nic_opaque(nc);<=
br>
&gt; @@ -595,7 +1003,6 @@ ssize_t i82596_receive(NetClientState *nc, const =
uint8_t *buf, size_t sz)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0rbd =3D get_uint32(rfd_p + 8);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0assert(rbd &amp;&amp; rbd !=3D I596_NULL);<b=
r>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 trace_i82596_receive_packet(len);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* PRINT_PKTHDR(&quot;Receive&quot;, buf); *=
/<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0while (len) {<br>
&gt; @@ -714,14 +1121,113 @@ ssize_t i82596_receive(NetClientState *nc, con=
st uint8_t *buf, size_t sz)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return sz;<br>
&gt;=C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0<br>
&gt; +ssize_t i82596_receive_iov(NetClientState *nc, const struct iovec *io=
v,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int iovcnt)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 size_t sz =3D 0;<br>
&gt; +=C2=A0 =C2=A0 uint8_t *buf;<br>
&gt; +=C2=A0 =C2=A0 int i;<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; iovcnt; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 sz +=3D iov[i].iov_len;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 if (sz =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 buf =3D g_malloc(sz);<br>
&gt; +=C2=A0 =C2=A0 if (!buf) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 size_t offset =3D 0;<br>
&gt; +=C2=A0 =C2=A0 for (i =3D 0; i &lt; iovcnt; i++) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (iov[i].iov_base =3D=3D NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 g_free(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 memcpy(buf + offset, iov[i].iov_base, iov=
[i].iov_len);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 offset +=3D iov[i].iov_len;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 DBG(PRINT_PKTHDR(&quot;Receive IOV:&quot;, buf));<br>
&gt; +=C2=A0 =C2=A0 i82596_receive(nc, buf, sz);<br>
&gt; +=C2=A0 =C2=A0 g_free(buf);<br>
&gt; +=C2=A0 =C2=A0 return sz;<br>
&gt; +}<br>
&gt; +<br>
&gt; +void i82596_poll(NetClientState *nc, bool enable)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 I82596State *s =3D qemu_get_nic_opaque(nc);<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (!enable) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 return;<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;send_irq) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, 1);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;rx_status =3D=3D RX_NO_RESOURCES) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (s-&gt;cmd_p !=3D I596_NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;rx_status =3D RX_READ=
Y;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 update_scb_status(s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 if (s-&gt;cu_status =3D=3D CU_ACTIVE &amp;&amp; s-&gt;c=
md_p !=3D I596_NULL) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 examine_scb(s);<br>
&gt; +=C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 qemu_set_irq(s-&gt;irq, 0);<br>
&gt; +}<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0const VMStateDescription vmstate_i82596 =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.name =3D &quot;i82596&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.version_id =3D 1,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.minimum_version_id =3D 1,<br>
&gt; -=C2=A0 =C2=A0 .fields =3D (const VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 .fields =3D (VMStateField[]) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(mode, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(t_on, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(t_off, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(throttle_state, I82596State)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(iscp, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(sysbus, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(scb, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(scb_base, I82596State),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(scb_status, I82596State),<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(cu_status, I82596State),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT8(rx_status, I82596State),<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_UINT16(lnkst, I82596St=
ate),<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_TIMER_PTR(flush_queue_timer, I825=
96State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(cmd_p, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_INT32(ca, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_INT32(ca_active, I82596State),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_INT32(send_irq, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BUFFER(mult, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BUFFER(config, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BUFFER(tx_buffer, I82596State),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_retry_addr, I82596State=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_INT32(tx_retry_count, I82596State=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_good_frames, I82596Stat=
e),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_collisions, I82596State=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(tx_aborted_errors, I82596S=
tate),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(last_tx_len, I82596State),=
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(collision_events, I82596St=
ate),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(total_collisions, I82596St=
ate),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(crc_err, I82596State),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(align_err, I82596State),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(resource_err, I82596State)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(over_err, I82596State),<br=
>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(rcvdt_err, I82596State),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(short_fr_error, I82596Stat=
e),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(total_frames, I82596State)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(total_good_frames, I82596S=
tate),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BUFFER(rx_buffer, I82596State),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(tx_frame_len, I82596State)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT16(rx_frame_len, I82596State)=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64(current_tx_desc, I82596Sta=
te),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT64(current_rx_desc, I82596Sta=
te),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_UINT32(last_good_rfa, I82596State=
),<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_INT32(queue_head, I82596State),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_INT32(queue_tail, I82596State),<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_INT32(queue_count, I82596State),<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(rnr_signaled, I82596State),<=
br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 VMSTATE_BOOL(flushing_queue, I82596State)=
,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VMSTATE_END_OF_LIST()<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0};<br>
&gt; @@ -736,8 +1242,15 @@ void i82596_common_init(DeviceState *dev, I82596=
State *s, NetClientInfo *info)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_format_nic_info_str(qemu_get_queue(s-&g=
t;nic), s-&gt;conf.macaddr.a);<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (USE_TIMER) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;flush_queue_timer =3D timer_new_ns(=
QEMU_CLOCK_VIRTUAL,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i82596_flush_queue=
_timer, s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!s-&gt;flush_queue_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;flush_queue_timer =3D=
 timer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i825=
96_flush_queue_timer, s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!s-&gt;throttle_timer) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;throttle_timer =3D ti=
mer_new_ns(QEMU_CLOCK_VIRTUAL,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 i825=
96_bus_throttle_timer, s);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;lnkst =3D 0x8000; /* initial link stat=
e: up */<br>
&gt;=C2=A0 =C2=A0}<br>
&gt; diff --git a/hw/net/i82596.h b/hw/net/i82596.h<br>
&gt; index dc1fa1a1dc..67b18f957a 100644<br>
&gt; --- a/hw/net/i82596.h<br>
&gt; +++ b/hw/net/i82596.h<br>
&gt; @@ -6,11 +6,15 @@<br>
&gt;=C2=A0 =C2=A0#include &quot;system/memory.h&quot;<br>
&gt;=C2=A0 =C2=A0#include &quot;system/address-spaces.h&quot;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -#define PORT_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x=
00=C2=A0 =C2=A0 /* reset 82596 */<br>
&gt; -#define PORT_SELFTEST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x01=C2=
=A0 =C2=A0 /* selftest */<br>
&gt; -#define PORT_ALTSCP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
02=C2=A0 =C2=A0 /* alternate SCB address */<br>
&gt; -#define PORT_ALTDUMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x03=C2=
=A0 =C2=A0 /* Alternate DUMP address */<br>
&gt; -#define PORT_CA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x10=C2=A0 =C2=A0 /* QEMU-internal CA signal */<br>
&gt; +#define PACKET_QUEUE_SIZE 64<br>
&gt; +#define RX_RING_SIZE=C2=A0 =C2=A0 16<br>
&gt; +#define PKT_BUF_SZ=C2=A0 =C2=A0 =C2=A0 1536<br>
&gt; +<br>
&gt; +#define PORT_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x=
00<br>
&gt; +#define PORT_SELFTEST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x01<br=
>
&gt; +#define PORT_ALTSCP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x=
02<br>
&gt; +#define PORT_ALTDUMP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x03<br=
>
&gt; +#define PORT_CA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A00x10<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0typedef struct I82596State_st I82596State;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; @@ -21,35 +25,75 @@ struct I82596State_st {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NICState *nic;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0NICConf conf;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0QEMUTimer *flush_queue_timer;<br>
&gt; +=C2=A0 =C2=A0 uint8_t mode;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 QEMUTimer *throttle_timer;<br>
&gt; +=C2=A0 =C2=A0 uint16_t t_on;<br>
&gt; +=C2=A0 =C2=A0 uint16_t t_off;<br>
&gt; +=C2=A0 =C2=A0 bool throttle_state;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 hwaddr scp;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* pointer=
 to SCP */<br>
&gt; +=C2=A0 =C2=A0 hwaddr scp;<br>
&gt; +=C2=A0 =C2=A0 uint32_t iscp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t sysbus;<br>
&gt; -=C2=A0 =C2=A0 uint32_t scb;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* SCB */<br>
&gt; +=C2=A0 =C2=A0 uint32_t scb;<br>
&gt; +=C2=A0 =C2=A0 uint32_t scb_base;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t scb_status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t cu_status, rx_status;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint16_t lnkst;<br>
&gt; +=C2=A0 =C2=A0 uint32_t last_tx_len;<br>
&gt; +=C2=A0 =C2=A0 uint32_t collision_events;<br>
&gt; +=C2=A0 =C2=A0 uint32_t total_collisions;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_retry_addr;<br>
&gt; +=C2=A0 =C2=A0 int tx_retry_count;<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_good_frames;<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_collisions;<br>
&gt; +=C2=A0 =C2=A0 uint32_t tx_aborted_errors;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 uint32_t cmd_p;=C2=A0 =C2=A0 =C2=A0/* addr of current c=
ommand */<br>
&gt; +=C2=A0 =C2=A0 uint32_t cmd_p;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ca;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int ca_active;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int send_irq;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 /* Hash register (multicast mask array, multiple indivi=
dual addresses). */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t mult[8];<br>
&gt; -=C2=A0 =C2=A0 uint8_t config[14]; /* config bytes from CONFIGURE comm=
and */<br>
&gt; +=C2=A0 =C2=A0 uint8_t config[14];<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint32_t crc_err;<br>
&gt; +=C2=A0 =C2=A0 uint32_t align_err;<br>
&gt; +=C2=A0 =C2=A0 uint32_t resource_err;<br>
&gt; +=C2=A0 =C2=A0 uint32_t over_err;<br>
&gt; +=C2=A0 =C2=A0 uint32_t rcvdt_err;<br>
&gt; +=C2=A0 =C2=A0 uint32_t short_fr_error;<br>
&gt; +=C2=A0 =C2=A0 uint32_t total_frames;<br>
&gt; +=C2=A0 =C2=A0 uint32_t total_good_frames;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 uint8_t tx_buffer[PKT_BUF_SZ];<br>
&gt; +=C2=A0 =C2=A0 uint8_t rx_buffer[PKT_BUF_SZ];<br>
&gt; +=C2=A0 =C2=A0 uint16_t tx_frame_len;<br>
&gt; +=C2=A0 =C2=A0 uint16_t rx_frame_len;<br>
&gt;=C2=A0 =C2=A0<br>
&gt; -=C2=A0 =C2=A0 uint8_t tx_buffer[0x4000];<br>
&gt; +=C2=A0 =C2=A0 hwaddr current_tx_desc;<br>
&gt; +=C2=A0 =C2=A0 hwaddr current_rx_desc;<br>
&gt; +=C2=A0 =C2=A0 uint32_t last_good_rfa;<br>
&gt; +=C2=A0 =C2=A0 uint8_t packet_queue[PACKET_QUEUE_SIZE][PKT_BUF_SZ];<br=
>
&gt; +=C2=A0 =C2=A0 size_t packet_queue_len[PACKET_QUEUE_SIZE];<br>
&gt; +=C2=A0 =C2=A0 int queue_head;<br>
&gt; +=C2=A0 =C2=A0 int queue_tail;<br>
&gt; +=C2=A0 =C2=A0 int queue_count;<br>
&gt; +=C2=A0 =C2=A0 bool rnr_signaled;<br>
&gt; +=C2=A0 =C2=A0 bool flushing_queue;<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0void i82596_h_reset(void *opaque);<br>
&gt;=C2=A0 =C2=A0void i82596_ioport_writew(void *opaque, uint32_t addr, uin=
t32_t val);<br>
&gt;=C2=A0 =C2=A0uint32_t i82596_ioport_readw(void *opaque, uint32_t addr);=
<br>
&gt; -void i82596_ioport_writel(void *opaque, uint32_t addr, uint32_t val);=
<br>
&gt; -uint32_t i82596_ioport_readl(void *opaque, uint32_t addr);<br>
&gt; -uint32_t i82596_bcr_readw(I82596State *s, uint32_t rap);<br>
&gt;=C2=A0 =C2=A0ssize_t i82596_receive(NetClientState *nc, const uint8_t *=
buf, size_t size_);<br>
&gt; +ssize_t i82596_receive_iov(NetClientState *nc, const struct iovec *io=
v,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0int iovcnt);<br>
&gt;=C2=A0 =C2=A0bool i82596_can_receive(NetClientState *nc);<br>
&gt;=C2=A0 =C2=A0void i82596_set_link_status(NetClientState *nc);<br>
&gt; -void i82596_common_init(DeviceState *dev, I82596State *s, NetClientIn=
fo *info);<br>
&gt; +void i82596_poll(NetClientState *nc, bool enable);<br>
&gt; +void i82596_common_init(DeviceState *dev, I82596State *s,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 NetClientInfo *info);<br>
&gt;=C2=A0 =C2=A0extern const VMStateDescription vmstate_i82596;<br>
&gt;=C2=A0 =C2=A0#endif<br>
&gt; diff --git a/hw/net/lasi_i82596.c b/hw/net/lasi_i82596.c<br>
&gt; index 9e1dd21546..fc06588ade 100644<br>
&gt; --- a/hw/net/lasi_i82596.c<br>
&gt; +++ b/hw/net/lasi_i82596.c<br>
&gt; @@ -86,6 +86,10 @@ static const MemoryRegionOps lasi_82596_mem_ops =3D=
 {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.min_access_size =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.max_access_size =3D 4,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0},<br>
&gt; +=C2=A0 =C2=A0 .impl =3D {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .min_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 .max_access_size =3D 4,<br>
&gt; +=C2=A0 =C2=A0 },<br>
&gt;=C2=A0 =C2=A0};<br>
&gt;=C2=A0 =C2=A0<br>
&gt;=C2=A0 =C2=A0static NetClientInfo net_lasi_82596_info =3D {<br>
&gt; @@ -93,6 +97,8 @@ static NetClientInfo net_lasi_82596_info =3D {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.size =3D sizeof(NICState),<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.can_receive =3D i82596_can_receive,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.receive =3D i82596_receive,<br>
&gt; +=C2=A0 =C2=A0 .receive_iov =3D i82596_receive_iov,<br>
&gt; +=C2=A0 =C2=A0 .poll =3D i82596_poll,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.link_status_changed =3D i82596_set_link_sta=
tus,<br>
&gt;=C2=A0 =C2=A0};<br>
<br>
ATB,<br>
<br>
Mark.<br>
<br>
</blockquote></div></div>

--00000000000034f8dd064287b8a0--

