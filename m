Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89199CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 19:02:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rs5ri-0004P9-T7; Wed, 03 Apr 2024 15:01:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aclements@csail.mit.edu>)
 id 1rs5az-000090-DJ
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:44:26 -0400
Received: from outgoing2021.csail.mit.edu ([128.30.2.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aclements@csail.mit.edu>)
 id 1rs5aw-0002GQ-Ej
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:44:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=outgoing.csail.mit.edu; s=test20231205; h=Content-Type:Cc:To:Subject:
 Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FT/MzJ3qYVVMaGUpe4z7eIHWdsgS+GZRwDt2t8hb+Hs=; t=1712169854; x=1713033854; 
 b=uS6ALSTaeKTM/aVCNHbOuZ+3RJsTg9mSNxE7TvcXqfJEcV/y4ESoistIFHbisO7mG6cqUDveNPp
 8YASVVcIZLcyHqCe1p9OODqLTxgi36Y29GP3V9UD3u8c7h6GTpk8NsUa6QcxtcS+rVYr4vBhffKtw
 ZAjnrwpnv648tsK4PSMpwesewRA3fBASjedgVkHsTrFb99O7/vHs228qt6V/8bvHHe546pr76RU5A
 jbRMKHsQaVi1JaxHZWPLxOCQeRg4QmSUGqh6OCmUvJ5Kuq3dGTnbMlSkD7/ELxFmMNvVl9YPXXrAP
 IhGJ+WuOvMKUbirygfGbcKyYiNOl43QWtbqA==;
Received: from mail-yw1-f181.google.com ([209.85.128.181])
 by outgoing2021.csail.mit.edu with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256 (Exim 4.95)
 (envelope-from <aclements@csail.mit.edu>) id 1rs5an-00FT3g-TP
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 14:44:13 -0400
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-60a104601dcso1781497b3.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 11:44:13 -0700 (PDT)
X-Gm-Message-State: AOJu0YyjVvy2pBHNGjeVBkrS/nOlaCznA29VvlVG7s/7FmJrxkzoXNZ2
 pYVW30E8muG+krs8bpEbG8jnO3EC1QUOnheMF5H/yRhNU33+c2CgX5IIqqlg6vDvdkP6Mg/lkJp
 W5zqG7MCB9Nsg6HspL8QbeKdNRt8=
X-Google-Smtp-Source: AGHT+IFftzBxalUxpPH/eM0Xx2vhgZMTJAhiiO2ZpHSlwZ4/i78AWvp1G6R0fQDb+iAA3GjFKhsr5X3l39fCS6kO340=
X-Received: by 2002:a25:2681:0:b0:dc6:bbbc:80e4 with SMTP id
 m123-20020a252681000000b00dc6bbbc80e4mr374752ybm.4.1712169853342; Wed, 03 Apr
 2024 11:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <7e66f00d-cc69-458d-be56-266689757f68@linaro.org>
 <20240403134546.1361812-1-porter@cs.unc.edu>
In-Reply-To: <20240403134546.1361812-1-porter@cs.unc.edu>
From: Austin Clements <aclements@csail.mit.edu>
Date: Wed, 3 Apr 2024 14:44:04 -0400
X-Gmail-Original-Message-ID: <CAH-f9WtDa=mZgbBPHwOeswMqbShabCjKqH8SXvXOTzhgCCc43g@mail.gmail.com>
Message-ID: <CAH-f9WtDa=mZgbBPHwOeswMqbShabCjKqH8SXvXOTzhgCCc43g@mail.gmail.com>
Subject: Re: [PATCH v2] e1000: Convert debug macros into tracepoints.
To: Don Porter <porter@cs.unc.edu>
Cc: qemu-devel@nongnu.org, jasonwang@redhat.com, richard.henderson@linaro.org, 
 Geoffrey Thomas <geofft@ldpreload.com>
Content-Type: multipart/alternative; boundary="000000000000e766260615359bb6"
Received-SPF: pass client-ip=128.30.2.78; envelope-from=aclements@csail.mit.edu;
 helo=outgoing2021.csail.mit.edu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 03 Apr 2024 15:01:40 -0400
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

--000000000000e766260615359bb6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

At this point there's not much of my original code left. :D Don, you're
welcome to take the credit in the commit.

On Wed, Apr 3, 2024, 9:46=E2=80=AFAM Don Porter <porter@cs.unc.edu> wrote:

> From: Austin Clements <aclements@csail.mit.edu>
>
> The E1000 debug messages are very useful for developing drivers.
> Make these available to users without recompiling QEMU.
>
> Signed-off-by: Austin Clements <aclements@csail.mit.edu>
> [geofft@ldpreload.com: Rebased on top of 2.9.0]
> Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>  hw/net/e1000.c      | 90 +++++++++++++++------------------------------
>  hw/net/trace-events | 25 ++++++++++++-
>  2 files changed, 54 insertions(+), 61 deletions(-)
>
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 43f3a4a701..24475636a3 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -44,26 +44,6 @@
>  #include "trace.h"
>  #include "qom/object.h"
>
> -/* #define E1000_DEBUG */
> -
> -#ifdef E1000_DEBUG
> -enum {
> -    DEBUG_GENERAL,      DEBUG_IO,       DEBUG_MMIO,     DEBUG_INTERRUPT,
> -    DEBUG_RX,           DEBUG_TX,       DEBUG_MDIC,     DEBUG_EEPROM,
> -    DEBUG_UNKNOWN,      DEBUG_TXSUM,    DEBUG_TXERR,    DEBUG_RXERR,
> -    DEBUG_RXFILTER,     DEBUG_PHY,      DEBUG_NOTYET,
> -};
> -#define DBGBIT(x)    (1<<DEBUG_##x)
> -static int debugflags =3D DBGBIT(TXERR) | DBGBIT(GENERAL);
> -
> -#define DBGOUT(what, fmt, ...) do { \
> -    if (debugflags & DBGBIT(what)) \
> -        fprintf(stderr, "e1000: " fmt, ## __VA_ARGS__); \
> -    } while (0)
> -#else
> -#define DBGOUT(what, fmt, ...) do {} while (0)
> -#endif
> -
>  #define IOPORT_SIZE       0x40
>  #define PNPMMIO_SIZE      0x20000
>
> @@ -351,8 +331,7 @@ e1000_mit_timer(void *opaque)
>  static void
>  set_ics(E1000State *s, int index, uint32_t val)
>  {
> -    DBGOUT(INTERRUPT, "set_ics %x, ICR %x, IMR %x\n", val,
> s->mac_reg[ICR],
> -        s->mac_reg[IMS]);
> +    trace_e1000_set_ics(val, s->mac_reg[ICR], s->mac_reg[IMS]);
>      set_interrupt_cause(s, 0, val | s->mac_reg[ICR]);
>  }
>
> @@ -425,8 +404,7 @@ set_rx_control(E1000State *s, int index, uint32_t val=
)
>      s->mac_reg[RCTL] =3D val;
>      s->rxbuf_size =3D e1000x_rxbufsize(val);
>      s->rxbuf_min_shift =3D ((val / E1000_RCTL_RDMTS_QUAT) & 3) + 1;
> -    DBGOUT(RX, "RCTL: %d, mac_reg[RCTL] =3D 0x%x\n", s->mac_reg[RDT],
> -           s->mac_reg[RCTL]);
> +    trace_e1000_set_rx_control(s->mac_reg[RDT], s->mac_reg[RCTL]);
>      timer_mod(s->flush_queue_timer,
>                qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL) + 1000);
>  }
> @@ -440,16 +418,16 @@ set_mdic(E1000State *s, int index, uint32_t val)
>      if ((val & E1000_MDIC_PHY_MASK) >> E1000_MDIC_PHY_SHIFT !=3D 1) // p=
hy #
>          val =3D s->mac_reg[MDIC] | E1000_MDIC_ERROR;
>      else if (val & E1000_MDIC_OP_READ) {
> -        DBGOUT(MDIC, "MDIC read reg 0x%x\n", addr);
> +        trace_e1000_mdic_read_register(addr);
>          if (!(phy_regcap[addr] & PHY_R)) {
> -            DBGOUT(MDIC, "MDIC read reg %x unhandled\n", addr);
> +            trace_e1000_mdic_read_register_unhandled(addr);
>              val |=3D E1000_MDIC_ERROR;
>          } else
>              val =3D (val ^ data) | s->phy_reg[addr];
>      } else if (val & E1000_MDIC_OP_WRITE) {
> -        DBGOUT(MDIC, "MDIC write reg 0x%x, value 0x%x\n", addr, data);
> +        trace_e1000_mdic_write_register(addr, data);
>          if (!(phy_regcap[addr] & PHY_W)) {
> -            DBGOUT(MDIC, "MDIC write reg %x unhandled\n", addr);
> +            trace_e1000_mdic_write_register_unhandled(addr);
>              val |=3D E1000_MDIC_ERROR;
>          } else {
>              if (addr < NPHYWRITEOPS && phyreg_writeops[addr]) {
> @@ -471,8 +449,8 @@ get_eecd(E1000State *s, int index)
>  {
>      uint32_t ret =3D E1000_EECD_PRES|E1000_EECD_GNT |
> s->eecd_state.old_eecd;
>
> -    DBGOUT(EEPROM, "reading eeprom bit %d (reading %d)\n",
> -           s->eecd_state.bitnum_out, s->eecd_state.reading);
> +    trace_e1000_get_eecd(s->eecd_state.bitnum_out, s->eecd_state.reading=
);
> +
>      if (!s->eecd_state.reading ||
>          ((s->eeprom_data[(s->eecd_state.bitnum_out >> 4) & 0x3f] >>
>            ((s->eecd_state.bitnum_out & 0xf) ^ 0xf))) & 1)
> @@ -511,9 +489,8 @@ set_eecd(E1000State *s, int index, uint32_t val)
>          s->eecd_state.reading =3D (((s->eecd_state.val_in >> 6) & 7) =3D=
=3D
>              EEPROM_READ_OPCODE_MICROWIRE);
>      }
> -    DBGOUT(EEPROM, "eeprom bitnum in %d out %d, reading %d\n",
> -           s->eecd_state.bitnum_in, s->eecd_state.bitnum_out,
> -           s->eecd_state.reading);
> +    trace_e1000_set_eecd(s->eecd_state.bitnum_in,
> s->eecd_state.bitnum_out,
> +                         s->eecd_state.reading);
>  }
>
>  static uint32_t
> @@ -580,8 +557,7 @@ xmit_seg(E1000State *s)
>
>      if (tp->cptse) {
>          css =3D props->ipcss;
> -        DBGOUT(TXSUM, "frames %d size %d ipcss %d\n",
> -               frames, tp->size, css);
> +        trace_e1000_xmit_seg1(frames, tp->size, css);
>          if (props->ip) {    /* IPv4 */
>              stw_be_p(tp->data+css+2, tp->size - css);
>              stw_be_p(tp->data+css+4,
> @@ -591,7 +567,7 @@ xmit_seg(E1000State *s)
>          }
>          css =3D props->tucss;
>          len =3D tp->size - css;
> -        DBGOUT(TXSUM, "tcp %d tucss %d len %d\n", props->tcp, css, len);
> +        trace_e1000_xmit_seg2(props->tcp, css, len);
>          if (props->tcp) {
>              sofar =3D frames * props->mss;
>              stl_be_p(tp->data+css+4, ldl_be_p(tp->data+css+4)+sofar); /*
> seq */
> @@ -759,7 +735,7 @@ start_xmit(E1000State *s)
>      uint32_t tdh_start =3D s->mac_reg[TDH], cause =3D E1000_ICS_TXQE;
>
>      if (!(s->mac_reg[TCTL] & E1000_TCTL_EN)) {
> -        DBGOUT(TX, "tx disabled\n");
> +        trace_e1000_start_xmit_fail1();
>          return;
>      }
>
> @@ -773,9 +749,9 @@ start_xmit(E1000State *s)
>                 sizeof(struct e1000_tx_desc) * s->mac_reg[TDH];
>          pci_dma_read(d, base, &desc, sizeof(desc));
>
> -        DBGOUT(TX, "index %d: %p : %x %x\n", s->mac_reg[TDH],
> -               (void *)(intptr_t)desc.buffer_addr, desc.lower.data,
> -               desc.upper.data);
> +        trace_e1000_transmit(s->mac_reg[TDH],
> +                             (void *)(intptr_t)desc.buffer_addr,
> +                             desc.lower.data, desc.upper.data);
>
>          process_tx_desc(s, &desc);
>          cause |=3D txdesc_writeback(s, base, &desc);
> @@ -789,8 +765,8 @@ start_xmit(E1000State *s)
>           */
>          if (s->mac_reg[TDH] =3D=3D tdh_start ||
>              tdh_start >=3D s->mac_reg[TDLEN] / sizeof(desc)) {
> -            DBGOUT(TXERR, "TDH wraparound @%x, TDT %x, TDLEN %x\n",
> -                   tdh_start, s->mac_reg[TDT], s->mac_reg[TDLEN]);
> +            trace_e1000_start_xmit_fail2(tdh_start, s->mac_reg[TDT],
> +                                         s->mac_reg[TDLEN]);
>              break;
>          }
>      }
> @@ -978,7 +954,7 @@ e1000_receive_iov(NetClientState *nc, const struct
> iovec *iov, int iovcnt)
>                  desc.status &=3D ~E1000_RXD_STAT_EOP;
>              }
>          } else { // as per intel docs; skip descriptors with null buf ad=
dr
> -            DBGOUT(RX, "Null RX descriptor!!\n");
> +            trace_e1000_null_rx();
>          }
>          pci_dma_write(d, base, &desc, sizeof(desc));
>          desc.status |=3D (vlan_status | E1000_RXD_STAT_DD);
> @@ -990,8 +966,8 @@ e1000_receive_iov(NetClientState *nc, const struct
> iovec *iov, int iovcnt)
>          /* see comment in start_xmit; same here */
>          if (s->mac_reg[RDH] =3D=3D rdh_start ||
>              rdh_start >=3D s->mac_reg[RDLEN] / sizeof(desc)) {
> -            DBGOUT(RXERR, "RDH wraparound @%x, RDT %x, RDLEN %x\n",
> -                   rdh_start, s->mac_reg[RDT], s->mac_reg[RDLEN]);
> +            trace_e1000_rdh_wraparound(rdh_start, s->mac_reg[RDT],
> +                                       s->mac_reg[RDLEN]);
>              e1000_receiver_overrun(s, total_size);
>              return -1;
>          }
> @@ -1033,7 +1009,7 @@ mac_icr_read(E1000State *s, int index)
>  {
>      uint32_t ret =3D s->mac_reg[ICR];
>
> -    DBGOUT(INTERRUPT, "ICR read: %x\n", ret);
> +    trace_e1000_mac_icr_read(ret);
>      set_interrupt_cause(s, 0, 0);
>      return ret;
>  }
> @@ -1109,7 +1085,7 @@ set_tctl(E1000State *s, int index, uint32_t val)
>  static void
>  set_icr(E1000State *s, int index, uint32_t val)
>  {
> -    DBGOUT(INTERRUPT, "set_icr %x\n", val);
> +    trace_e1000_set_icr(val);
>      set_interrupt_cause(s, 0, s->mac_reg[ICR] & ~val);
>  }
>
> @@ -1271,20 +1247,16 @@ e1000_mmio_write(void *opaque, hwaddr addr,
> uint64_t val,
>          if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
>              || (s->compat_flags & (mac_reg_access[index] >> 2))) {
>              if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
> -                DBGOUT(GENERAL, "Writing to register at offset: 0x%08x. =
"
> -                       "It is not fully implemented.\n", index<<2);
> +                trace_e1000_mmio_write_fail1(index << 2);
>              }
>              macreg_writeops[index](s, index, val);
>          } else {    /* "flag needed" bit is set, but the flag is not
> active */
> -            DBGOUT(MMIO, "MMIO write attempt to disabled reg.
> addr=3D0x%08x\n",
> -                   index<<2);
> +            trace_e1000_mmio_write_fail2(index << 2);
>          }
>      } else if (index < NREADOPS && macreg_readops[index]) {
> -        DBGOUT(MMIO, "e1000_mmio_writel RO %x: 0x%04"PRIx64"\n",
> -               index<<2, val);
> +        trace_e1000_mmio_write_fail3(index << 2, val);
>      } else {
> -        DBGOUT(UNKNOWN, "MMIO unknown write
> addr=3D0x%08x,val=3D0x%08"PRIx64"\n",
> -               index<<2, val);
> +        trace_e1000_mmio_write_fail4(index << 2, val);
>      }
>  }
>
> @@ -1298,16 +1270,14 @@ e1000_mmio_read(void *opaque, hwaddr addr,
> unsigned size)
>          if (!(mac_reg_access[index] & MAC_ACCESS_FLAG_NEEDED)
>              || (s->compat_flags & (mac_reg_access[index] >> 2))) {
>              if (mac_reg_access[index] & MAC_ACCESS_PARTIAL) {
> -                DBGOUT(GENERAL, "Reading register at offset: 0x%08x. "
> -                       "It is not fully implemented.\n", index<<2);
> +                trace_e1000_mmio_read_fail1(index << 2);
>              }
>              return macreg_readops[index](s, index);
>          } else {    /* "flag needed" bit is set, but the flag is not
> active */
> -            DBGOUT(MMIO, "MMIO read attempt of disabled reg.
> addr=3D0x%08x\n",
> -                   index<<2);
> +            trace_e1000_mmio_read_fail2(index << 2);
>          }
>      } else {
> -        DBGOUT(UNKNOWN, "MMIO unknown read addr=3D0x%08x\n", index<<2);
> +        trace_e1000_mmio_read_fail3(index << 2);
>      }
>      return 0;
>  }
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 78efa2ec2c..f426f79a0c 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -101,7 +101,31 @@ net_rx_pkt_rss_hash(size_t rss_length, uint32_t
> rss_hash) "RSS hash for %zu byte
>  net_rx_pkt_rss_add_chunk(void* ptr, size_t size, size_t input_offset)
> "Add RSS chunk %p, %zu bytes, RSS input offset %zu bytes"
>
>  # e1000.c
> +e1000_set_ics(uint32_t val, uint32_t ICR, uint32_t IMR) "set_ics 0x%x,
> ICR 0x%x, IMR 0x%x"
> +e1000_set_rx_control(uint32_t RDT, uint32_t RCTL) "RCTL: %d,
> mac_reg[RCTL] =3D 0x%x"
> +e1000_mdic_read_register(uint32_t addr) "MDIC read reg 0x%x"
> +e1000_mdic_read_register_unhandled(uint32_t addr) "MDIC read reg 0x%x
> unhandled"
> +e1000_mdic_write_register(uint32_t addr, uint32_t val) "MDIC write reg
> 0x%x, value 0x%x"
> +e1000_mdic_write_register_unhandled(uint32_t addr) "MDIC write reg 0x%x
> unhandled"
> +e1000_transmit(uint32_t tdh, void *addr, uint32_t data_low, uint32_t
> data_high) "index %d: %p : 0x%x 0x%x"
> +e1000_get_eecd(uint16_t bitnum_out, uint16_t reading) "reading eeprom bi=
t
> %d (reading %d)"
> +e1000_set_eecd(uint16_t bitnum_in, uint16_t bitnum_out, uint16_t reading=
)
> "eeprom bitnum in %d out %d, reading %d"
> +e1000_xmit_seg1(unsigned int frames, uint16_t size, unsigned int css)
> "frames %d size %d ipcss %d"
> +e1000_xmit_seg2(int8_t tcp, uint16_t css, unsigned int len) "tcp %d tucs=
s
> %d len %d"
> +e1000_start_xmit_fail1(void) "tx disabled"
> +e1000_start_xmit_fail2(uint32_t tdh_start, uint32_t TDT, uint32_t TDLEN)
> "TDH wraparound @0x%x, TDT 0x%x, TDLEN 0x%x"
>  e1000_receiver_overrun(size_t s, uint32_t rdh, uint32_t rdt) "Receiver
> overrun: dropped packet of %zu bytes, RDH=3D%u, RDT=3D%u"
> +e1000_null_rx(void) "Null RX descriptor!!"
> +e1000_rdh_wraparound(uint32_t rdh_start, uint32_t RDT, uint32_t RDLEN)
> "RDH wraparound @0x%x, RDT 0x%x, RDLEN 0x%x"
> +e1000_mac_icr_read(uint32_t ret) "ICR read: 0x%x"
> +e1000_set_icr(uint32_t val) "set_icr 0x%x"
> +e1000_mmio_write_fail1(unsigned int index) "Writing to register at
> offset: 0x%08x. It is not fully implemented."
> +e1000_mmio_write_fail2(unsigned int index) "MMIO write attempt to
> disabled reg. addr=3D0x%08x"
> +e1000_mmio_write_fail3(unsigned int index, uint64_t val)
> "e1000_mmio_writel RO 0x%x: 0x%04"PRIx64""
> +e1000_mmio_write_fail4(unsigned int index, uint64_t val) "MMIO unknown
> write addr=3D0x%08x,val=3D0x%08"PRIx64""
> +e1000_mmio_read_fail1(unsigned int index) "Reading register at offset:
> 0x%08x. It is not fully implemented."
> +e1000_mmio_read_fail2(unsigned int index) "MMIO read attempt of disabled
> reg. addr=3D0x%08x"
> +e1000_mmio_read_fail3(unsigned int index) "MMIO unknown read addr=3D0x%0=
8x"
>
>  # e1000x_common.c
>  e1000x_rx_can_recv_disabled(bool link_up, bool rx_enabled, bool
> pci_master) "link_up: %d, rx_enabled %d, pci_master %d"
> @@ -146,7 +170,6 @@ e1000e_wrn_no_snap_support(void) "WARNING: Guest
> requested TX SNAP header update
>  e1000e_wrn_iscsi_filtering_not_supported(void) "WARNING: Guest requested
> iSCSI filtering  which is not supported"
>  e1000e_wrn_nfsw_filtering_not_supported(void) "WARNING: Guest requested
> NFS write filtering  which is not supported"
>  e1000e_wrn_nfsr_filtering_not_supported(void) "WARNING: Guest requested
> NFS read filtering  which is not supported"
> -
>  e1000e_tx_disabled(void) "TX Disabled"
>  e1000e_tx_descr(void *addr, uint32_t lower, uint32_t upper) "%p : %x %x"
>
> --
> 2.25.1
>
>

--000000000000e766260615359bb6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">At this point there&#39;s not much of my original code le=
ft. :D Don, you&#39;re welcome to take the credit in the commit.</div><br><=
div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr=
 3, 2024, 9:46=E2=80=AFAM Don Porter &lt;<a href=3D"mailto:porter@cs.unc.ed=
u">porter@cs.unc.edu</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>From: Austin Clements &lt;<a href=3D"mailto:aclements@csail.mit.edu" targe=
t=3D"_blank" rel=3D"noreferrer">aclements@csail.mit.edu</a>&gt;<br>
<br>
The E1000 debug messages are very useful for developing drivers.<br>
Make these available to users without recompiling QEMU.<br>
<br>
Signed-off-by: Austin Clements &lt;<a href=3D"mailto:aclements@csail.mit.ed=
u" target=3D"_blank" rel=3D"noreferrer">aclements@csail.mit.edu</a>&gt;<br>
[<a href=3D"mailto:geofft@ldpreload.com" target=3D"_blank" rel=3D"noreferre=
r">geofft@ldpreload.com</a>: Rebased on top of 2.9.0]<br>
Signed-off-by: Geoffrey Thomas &lt;<a href=3D"mailto:geofft@ldpreload.com" =
target=3D"_blank" rel=3D"noreferrer">geofft@ldpreload.com</a>&gt;<br>
Signed-off-by: Don Porter &lt;<a href=3D"mailto:porter@cs.unc.edu" target=
=3D"_blank" rel=3D"noreferrer">porter@cs.unc.edu</a>&gt;<br>
---<br>
=C2=A0hw/net/e1000.c=C2=A0 =C2=A0 =C2=A0 | 90 +++++++++++++++--------------=
----------------<br>
=C2=A0hw/net/trace-events | 25 ++++++++++++-<br>
=C2=A02 files changed, 54 insertions(+), 61 deletions(-)<br>
<br>
diff --git a/hw/net/e1000.c b/hw/net/e1000.c<br>
index 43f3a4a701..24475636a3 100644<br>
--- a/hw/net/e1000.c<br>
+++ b/hw/net/e1000.c<br>
@@ -44,26 +44,6 @@<br>
=C2=A0#include &quot;trace.h&quot;<br>
=C2=A0#include &quot;qom/object.h&quot;<br>
<br>
-/* #define E1000_DEBUG */<br>
-<br>
-#ifdef E1000_DEBUG<br>
-enum {<br>
-=C2=A0 =C2=A0 DEBUG_GENERAL,=C2=A0 =C2=A0 =C2=A0 DEBUG_IO,=C2=A0 =C2=A0 =
=C2=A0 =C2=A0DEBUG_MMIO,=C2=A0 =C2=A0 =C2=A0DEBUG_INTERRUPT,<br>
-=C2=A0 =C2=A0 DEBUG_RX,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0DEBUG_TX,=
=C2=A0 =C2=A0 =C2=A0 =C2=A0DEBUG_MDIC,=C2=A0 =C2=A0 =C2=A0DEBUG_EEPROM,<br>
-=C2=A0 =C2=A0 DEBUG_UNKNOWN,=C2=A0 =C2=A0 =C2=A0 DEBUG_TXSUM,=C2=A0 =C2=A0=
 DEBUG_TXERR,=C2=A0 =C2=A0 DEBUG_RXERR,<br>
-=C2=A0 =C2=A0 DEBUG_RXFILTER,=C2=A0 =C2=A0 =C2=A0DEBUG_PHY,=C2=A0 =C2=A0 =
=C2=A0 DEBUG_NOTYET,<br>
-};<br>
-#define DBGBIT(x)=C2=A0 =C2=A0 (1&lt;&lt;DEBUG_##x)<br>
-static int debugflags =3D DBGBIT(TXERR) | DBGBIT(GENERAL);<br>
-<br>
-#define DBGOUT(what, fmt, ...) do { \<br>
-=C2=A0 =C2=A0 if (debugflags &amp; DBGBIT(what)) \<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 fprintf(stderr, &quot;e1000: &quot; fmt, ## __=
VA_ARGS__); \<br>
-=C2=A0 =C2=A0 } while (0)<br>
-#else<br>
-#define DBGOUT(what, fmt, ...) do {} while (0)<br>
-#endif<br>
-<br>
=C2=A0#define IOPORT_SIZE=C2=A0 =C2=A0 =C2=A0 =C2=A00x40<br>
=C2=A0#define PNPMMIO_SIZE=C2=A0 =C2=A0 =C2=A0 0x20000<br>
<br>
@@ -351,8 +331,7 @@ e1000_mit_timer(void *opaque)<br>
=C2=A0static void<br>
=C2=A0set_ics(E1000State *s, int index, uint32_t val)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 DBGOUT(INTERRUPT, &quot;set_ics %x, ICR %x, IMR %x\n&quot;, =
val, s-&gt;mac_reg[ICR],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 s-&gt;mac_reg[IMS]);<br>
+=C2=A0 =C2=A0 trace_e1000_set_ics(val, s-&gt;mac_reg[ICR], s-&gt;mac_reg[I=
MS]);<br>
=C2=A0 =C2=A0 =C2=A0set_interrupt_cause(s, 0, val | s-&gt;mac_reg[ICR]);<br=
>
=C2=A0}<br>
<br>
@@ -425,8 +404,7 @@ set_rx_control(E1000State *s, int index, uint32_t val)<=
br>
=C2=A0 =C2=A0 =C2=A0s-&gt;mac_reg[RCTL] =3D val;<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_size =3D e1000x_rxbufsize(val);<br>
=C2=A0 =C2=A0 =C2=A0s-&gt;rxbuf_min_shift =3D ((val / E1000_RCTL_RDMTS_QUAT=
) &amp; 3) + 1;<br>
-=C2=A0 =C2=A0 DBGOUT(RX, &quot;RCTL: %d, mac_reg[RCTL] =3D 0x%x\n&quot;, s=
-&gt;mac_reg[RDT],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mac_reg[RCTL]);<br>
+=C2=A0 =C2=A0 trace_e1000_set_rx_control(s-&gt;mac_reg[RDT], s-&gt;mac_reg=
[RCTL]);<br>
=C2=A0 =C2=A0 =C2=A0timer_mod(s-&gt;flush_queue_timer,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0qemu_clock_get_ms(QE=
MU_CLOCK_VIRTUAL) + 1000);<br>
=C2=A0}<br>
@@ -440,16 +418,16 @@ set_mdic(E1000State *s, int index, uint32_t val)<br>
=C2=A0 =C2=A0 =C2=A0if ((val &amp; E1000_MDIC_PHY_MASK) &gt;&gt; E1000_MDIC=
_PHY_SHIFT !=3D 1) // phy #<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D s-&gt;mac_reg[MDIC] | E1000_MDIC_=
ERROR;<br>
=C2=A0 =C2=A0 =C2=A0else if (val &amp; E1000_MDIC_OP_READ) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(MDIC, &quot;MDIC read reg 0x%x\n&quot;,=
 addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mdic_read_register(addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(phy_regcap[addr] &amp; PHY_R)) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(MDIC, &quot;MDIC read reg=
 %x unhandled\n&quot;, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mdic_read_register_u=
nhandled(addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val |=3D E1000_MDIC_ERROR;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val =3D (val ^ data) | s-&g=
t;phy_reg[addr];<br>
=C2=A0 =C2=A0 =C2=A0} else if (val &amp; E1000_MDIC_OP_WRITE) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(MDIC, &quot;MDIC write reg 0x%x, value =
0x%x\n&quot;, addr, data);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mdic_write_register(addr, data);<b=
r>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(phy_regcap[addr] &amp; PHY_W)) {<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(MDIC, &quot;MDIC write re=
g %x unhandled\n&quot;, addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mdic_write_register_=
unhandled(addr);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val |=3D E1000_MDIC_ERROR;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (addr &lt; NPHYWRITEOPS =
&amp;&amp; phyreg_writeops[addr]) {<br>
@@ -471,8 +449,8 @@ get_eecd(E1000State *s, int index)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t ret =3D E1000_EECD_PRES|E1000_EECD_GNT | s-&gt=
;eecd_state.old_eecd;<br>
<br>
-=C2=A0 =C2=A0 DBGOUT(EEPROM, &quot;reading eeprom bit %d (reading %d)\n&qu=
ot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;eecd_state.bitnum_out, s-&g=
t;eecd_state.reading);<br>
+=C2=A0 =C2=A0 trace_e1000_get_eecd(s-&gt;eecd_state.bitnum_out, s-&gt;eecd=
_state.reading);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0if (!s-&gt;eecd_state.reading ||<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((s-&gt;eeprom_data[(s-&gt;eecd_state.bit=
num_out &gt;&gt; 4) &amp; 0x3f] &gt;&gt;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((s-&gt;eecd_state.bitnum_out &amp=
; 0xf) ^ 0xf))) &amp; 1)<br>
@@ -511,9 +489,8 @@ set_eecd(E1000State *s, int index, uint32_t val)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;eecd_state.reading =3D (((s-&gt;eec=
d_state.val_in &gt;&gt; 6) &amp; 7) =3D=3D<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0EEPROM_READ_OPCODE_MICROWIR=
E);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 DBGOUT(EEPROM, &quot;eeprom bitnum in %d out %d, reading %d\=
n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;eecd_state.bitnum_in, s-&gt=
;eecd_state.bitnum_out,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;eecd_state.reading);<br>
+=C2=A0 =C2=A0 trace_e1000_set_eecd(s-&gt;eecd_state.bitnum_in, s-&gt;eecd_=
state.bitnum_out,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0s-&gt;eecd_state.reading);<br>
=C2=A0}<br>
<br>
=C2=A0static uint32_t<br>
@@ -580,8 +557,7 @@ xmit_seg(E1000State *s)<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (tp-&gt;cptse) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0css =3D props-&gt;ipcss;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(TXSUM, &quot;frames %d size %d ipcss %d=
\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0frames, tp-&gt;size=
, css);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_xmit_seg1(frames, tp-&gt;size, css=
);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (props-&gt;ip) {=C2=A0 =C2=A0 /* IPv4 =
*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stw_be_p(tp-&gt;data+css+2,=
 tp-&gt;size - css);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stw_be_p(tp-&gt;data+css+4,=
<br>
@@ -591,7 +567,7 @@ xmit_seg(E1000State *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0css =3D props-&gt;tucss;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0len =3D tp-&gt;size - css;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(TXSUM, &quot;tcp %d tucss %d len %d\n&q=
uot;, props-&gt;tcp, css, len);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_xmit_seg2(props-&gt;tcp, css, len)=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (props-&gt;tcp) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sofar =3D frames * props-&g=
t;mss;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0stl_be_p(tp-&gt;data+css+4,=
 ldl_be_p(tp-&gt;data+css+4)+sofar); /* seq */<br>
@@ -759,7 +735,7 @@ start_xmit(E1000State *s)<br>
=C2=A0 =C2=A0 =C2=A0uint32_t tdh_start =3D s-&gt;mac_reg[TDH], cause =3D E1=
000_ICS_TXQE;<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (!(s-&gt;mac_reg[TCTL] &amp; E1000_TCTL_EN)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(TX, &quot;tx disabled\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_start_xmit_fail1();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -773,9 +749,9 @@ start_xmit(E1000State *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sizeof(struct e1000=
_tx_desc) * s-&gt;mac_reg[TDH];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_read(d, base, &amp;desc, sizeof(d=
esc));<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(TX, &quot;index %d: %p : %x %x\n&quot;,=
 s-&gt;mac_reg[TDH],<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)(intptr_t)d=
esc.buffer_addr, desc.lower.data,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc.upper.data);<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_transmit(s-&gt;mac_reg[TDH],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(void *)(intptr_t)desc.buffer_addr,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc.lower.data, desc.upper.data);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_tx_desc(s, &amp;desc);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cause |=3D txdesc_writeback(s, base, &amp=
;desc);<br>
@@ -789,8 +765,8 @@ start_xmit(E1000State *s)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;mac_reg[TDH] =3D=3D tdh_start |=
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tdh_start &gt;=3D s-&gt;mac=
_reg[TDLEN] / sizeof(desc)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(TXERR, &quot;TDH wraparou=
nd @%x, TDT %x, TDLEN %x\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tdh_s=
tart, s-&gt;mac_reg[TDT], s-&gt;mac_reg[TDLEN]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_start_xmit_fail2(tdh=
_start, s-&gt;mac_reg[TDT],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-=
&gt;mac_reg[TDLEN]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -978,7 +954,7 @@ e1000_receive_iov(NetClientState *nc, const struct iove=
c *iov, int iovcnt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc.status &=
amp;=3D ~E1000_RXD_STAT_EOP;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else { // as per intel docs; skip descr=
iptors with null buf addr<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(RX, &quot;Null RX descrip=
tor!!\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_null_rx();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pci_dma_write(d, base, &amp;desc, sizeof(=
desc));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0desc.status |=3D (vlan_status | E1000_RXD=
_STAT_DD);<br>
@@ -990,8 +966,8 @@ e1000_receive_iov(NetClientState *nc, const struct iove=
c *iov, int iovcnt)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* see comment in start_xmit; same here *=
/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (s-&gt;mac_reg[RDH] =3D=3D rdh_start |=
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdh_start &gt;=3D s-&gt;mac=
_reg[RDLEN] / sizeof(desc)) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(RXERR, &quot;RDH wraparou=
nd @%x, RDT %x, RDLEN %x\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rdh_s=
tart, s-&gt;mac_reg[RDT], s-&gt;mac_reg[RDLEN]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_rdh_wraparound(rdh_s=
tart, s-&gt;mac_reg[RDT],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s-&gt;mac=
_reg[RDLEN]);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0e1000_receiver_overrun(s, t=
otal_size);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -1033,7 +1009,7 @@ mac_icr_read(E1000State *s, int index)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0uint32_t ret =3D s-&gt;mac_reg[ICR];<br>
<br>
-=C2=A0 =C2=A0 DBGOUT(INTERRUPT, &quot;ICR read: %x\n&quot;, ret);<br>
+=C2=A0 =C2=A0 trace_e1000_mac_icr_read(ret);<br>
=C2=A0 =C2=A0 =C2=A0set_interrupt_cause(s, 0, 0);<br>
=C2=A0 =C2=A0 =C2=A0return ret;<br>
=C2=A0}<br>
@@ -1109,7 +1085,7 @@ set_tctl(E1000State *s, int index, uint32_t val)<br>
=C2=A0static void<br>
=C2=A0set_icr(E1000State *s, int index, uint32_t val)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 DBGOUT(INTERRUPT, &quot;set_icr %x\n&quot;, val);<br>
+=C2=A0 =C2=A0 trace_e1000_set_icr(val);<br>
=C2=A0 =C2=A0 =C2=A0set_interrupt_cause(s, 0, s-&gt;mac_reg[ICR] &amp; ~val=
);<br>
=C2=A0}<br>
<br>
@@ -1271,20 +1247,16 @@ e1000_mmio_write(void *opaque, hwaddr addr, uint64_=
t val,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(mac_reg_access[index] &amp; MAC_ACC=
ESS_FLAG_NEEDED)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| (s-&gt;compat_flags &amp=
; (mac_reg_access[index] &gt;&gt; 2))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mac_reg_access[index] &=
amp; MAC_ACCESS_PARTIAL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(GENERAL, &q=
uot;Writing to register at offset: 0x%08x. &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;It is not fully implemented.\n&quot;, index&lt;&lt;2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mmio_w=
rite_fail1(index &lt;&lt; 2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0macreg_writeops[index](s, i=
ndex, val);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {=C2=A0 =C2=A0 /* &quot;flag neede=
d&quot; bit is set, but the flag is not active */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(MMIO, &quot;MMIO write at=
tempt to disabled reg. addr=3D0x%08x\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index=
&lt;&lt;2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mmio_write_fail2(ind=
ex &lt;&lt; 2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else if (index &lt; NREADOPS &amp;&amp; macreg_readop=
s[index]) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(MMIO, &quot;e1000_mmio_writel RO %x: 0x=
%04&quot;PRIx64&quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index&lt;&lt;2, val=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mmio_write_fail3(index &lt;&lt; 2,=
 val);<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(UNKNOWN, &quot;MMIO unknown write addr=
=3D0x%08x,val=3D0x%08&quot;PRIx64&quot;\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index&lt;&lt;2, val=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mmio_write_fail4(index &lt;&lt; 2,=
 val);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
@@ -1298,16 +1270,14 @@ e1000_mmio_read(void *opaque, hwaddr addr, unsigned=
 size)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!(mac_reg_access[index] &amp; MAC_ACC=
ESS_FLAG_NEEDED)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|| (s-&gt;compat_flags &amp=
; (mac_reg_access[index] &gt;&gt; 2))) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (mac_reg_access[index] &=
amp; MAC_ACCESS_PARTIAL) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(GENERAL, &q=
uot;Reading register at offset: 0x%08x. &quot;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&quot;It is not fully implemented.\n&quot;, index&lt;&lt;2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mmio_r=
ead_fail1(index &lt;&lt; 2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return macreg_readops[index=
](s, index);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {=C2=A0 =C2=A0 /* &quot;flag neede=
d&quot; bit is set, but the flag is not active */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(MMIO, &quot;MMIO read att=
empt of disabled reg. addr=3D0x%08x\n&quot;,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index=
&lt;&lt;2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mmio_read_fail2(inde=
x &lt;&lt; 2);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 DBGOUT(UNKNOWN, &quot;MMIO unknown read addr=
=3D0x%08x\n&quot;, index&lt;&lt;2);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 trace_e1000_mmio_read_fail3(index &lt;&lt; 2);=
<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0return 0;<br>
=C2=A0}<br>
diff --git a/hw/net/trace-events b/hw/net/trace-events<br>
index 78efa2ec2c..f426f79a0c 100644<br>
--- a/hw/net/trace-events<br>
+++ b/hw/net/trace-events<br>
@@ -101,7 +101,31 @@ net_rx_pkt_rss_hash(size_t rss_length, uint32_t rss_ha=
sh) &quot;RSS hash for %zu byte<br>
=C2=A0net_rx_pkt_rss_add_chunk(void* ptr, size_t size, size_t input_offset)=
 &quot;Add RSS chunk %p, %zu bytes, RSS input offset %zu bytes&quot;<br>
<br>
=C2=A0# e1000.c<br>
+e1000_set_ics(uint32_t val, uint32_t ICR, uint32_t IMR) &quot;set_ics 0x%x=
, ICR 0x%x, IMR 0x%x&quot;<br>
+e1000_set_rx_control(uint32_t RDT, uint32_t RCTL) &quot;RCTL: %d, mac_reg[=
RCTL] =3D 0x%x&quot;<br>
+e1000_mdic_read_register(uint32_t addr) &quot;MDIC read reg 0x%x&quot;<br>
+e1000_mdic_read_register_unhandled(uint32_t addr) &quot;MDIC read reg 0x%x=
 unhandled&quot;<br>
+e1000_mdic_write_register(uint32_t addr, uint32_t val) &quot;MDIC write re=
g 0x%x, value 0x%x&quot;<br>
+e1000_mdic_write_register_unhandled(uint32_t addr) &quot;MDIC write reg 0x=
%x unhandled&quot;<br>
+e1000_transmit(uint32_t tdh, void *addr, uint32_t data_low, uint32_t data_=
high) &quot;index %d: %p : 0x%x 0x%x&quot;<br>
+e1000_get_eecd(uint16_t bitnum_out, uint16_t reading) &quot;reading eeprom=
 bit %d (reading %d)&quot;<br>
+e1000_set_eecd(uint16_t bitnum_in, uint16_t bitnum_out, uint16_t reading) =
&quot;eeprom bitnum in %d out %d, reading %d&quot;<br>
+e1000_xmit_seg1(unsigned int frames, uint16_t size, unsigned int css) &quo=
t;frames %d size %d ipcss %d&quot;<br>
+e1000_xmit_seg2(int8_t tcp, uint16_t css, unsigned int len) &quot;tcp %d t=
ucss %d len %d&quot;<br>
+e1000_start_xmit_fail1(void) &quot;tx disabled&quot;<br>
+e1000_start_xmit_fail2(uint32_t tdh_start, uint32_t TDT, uint32_t TDLEN) &=
quot;TDH wraparound @0x%x, TDT 0x%x, TDLEN 0x%x&quot;<br>
=C2=A0e1000_receiver_overrun(size_t s, uint32_t rdh, uint32_t rdt) &quot;Re=
ceiver overrun: dropped packet of %zu bytes, RDH=3D%u, RDT=3D%u&quot;<br>
+e1000_null_rx(void) &quot;Null RX descriptor!!&quot;<br>
+e1000_rdh_wraparound(uint32_t rdh_start, uint32_t RDT, uint32_t RDLEN) &qu=
ot;RDH wraparound @0x%x, RDT 0x%x, RDLEN 0x%x&quot;<br>
+e1000_mac_icr_read(uint32_t ret) &quot;ICR read: 0x%x&quot;<br>
+e1000_set_icr(uint32_t val) &quot;set_icr 0x%x&quot;<br>
+e1000_mmio_write_fail1(unsigned int index) &quot;Writing to register at of=
fset: 0x%08x. It is not fully implemented.&quot;<br>
+e1000_mmio_write_fail2(unsigned int index) &quot;MMIO write attempt to dis=
abled reg. addr=3D0x%08x&quot;<br>
+e1000_mmio_write_fail3(unsigned int index, uint64_t val) &quot;e1000_mmio_=
writel RO 0x%x: 0x%04&quot;PRIx64&quot;&quot;<br>
+e1000_mmio_write_fail4(unsigned int index, uint64_t val) &quot;MMIO unknow=
n write addr=3D0x%08x,val=3D0x%08&quot;PRIx64&quot;&quot;<br>
+e1000_mmio_read_fail1(unsigned int index) &quot;Reading register at offset=
: 0x%08x. It is not fully implemented.&quot;<br>
+e1000_mmio_read_fail2(unsigned int index) &quot;MMIO read attempt of disab=
led reg. addr=3D0x%08x&quot;<br>
+e1000_mmio_read_fail3(unsigned int index) &quot;MMIO unknown read addr=3D0=
x%08x&quot;<br>
<br>
=C2=A0# e1000x_common.c<br>
=C2=A0e1000x_rx_can_recv_disabled(bool link_up, bool rx_enabled, bool pci_m=
aster) &quot;link_up: %d, rx_enabled %d, pci_master %d&quot;<br>
@@ -146,7 +170,6 @@ e1000e_wrn_no_snap_support(void) &quot;WARNING: Guest r=
equested TX SNAP header update<br>
=C2=A0e1000e_wrn_iscsi_filtering_not_supported(void) &quot;WARNING: Guest r=
equested iSCSI filtering=C2=A0 which is not supported&quot;<br>
=C2=A0e1000e_wrn_nfsw_filtering_not_supported(void) &quot;WARNING: Guest re=
quested NFS write filtering=C2=A0 which is not supported&quot;<br>
=C2=A0e1000e_wrn_nfsr_filtering_not_supported(void) &quot;WARNING: Guest re=
quested NFS read filtering=C2=A0 which is not supported&quot;<br>
-<br>
=C2=A0e1000e_tx_disabled(void) &quot;TX Disabled&quot;<br>
=C2=A0e1000e_tx_descr(void *addr, uint32_t lower, uint32_t upper) &quot;%p =
: %x %x&quot;<br>
<br>
-- <br>
2.25.1<br>
<br>
</blockquote></div>

--000000000000e766260615359bb6--

