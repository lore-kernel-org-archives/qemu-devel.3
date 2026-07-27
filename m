Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469B1C53219
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:20:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGZ2-0006Xq-Uv; Mon, 27 Jul 2026 04:19:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woGZ1-0006Xb-HU
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:19:55 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1woGYz-0003PR-7e
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:19:55 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66R8JjMD046435
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 27 Jul 2026 17:19:45 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=75pR8Gpqt2T8QYdmYo1HOa1gzP9K+CNFUycv1ayEIu0=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1785140385; v=1;
 b=aGxC5a8kwCqILX3xXPDwIBYnSj47F6KsGrtn2miNwnmXGcRtJaTPCvw23MOKnRAD
 Mql6x7ZqjJNt4opP+FvDI66tSrQdt3PQm2uyXiuRvpf1mdc4t341f2ajPcv60FdF
 Le83XdV3RhpK3GRqFi1gB00AuoATjTH9dGoJa/wFgSmCyfWlY3WnalYrN19OT+ud
 jecVNj48XH5TFtHKgF2jSwbicHuspL6aOjySDbllK0p/oHqOrrO3lTr1mveHPzt2
 CGgRCVYIaOiwBpm2azgCbwlkzwPKbcT8Dlaj1OhSY206VqM6aQUa/Fp405K05COM
 oW8mSrGgxP9S21m9upyirw==
Message-ID: <2dd7a514-bc66-4a19-974f-6258cc966d67@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 27 Jul 2026 17:19:45 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 07/11] igb: Quiesce VFs on STOP and include PF enable
 state in migration blob
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowangio@gmail.com>, Alex Williamson <alex@shazbot.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20260727053935.1392269-1-clg@redhat.com>
 <20260727053935.1392269-8-clg@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260727053935.1392269-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

On 2026/07/27 14:39, Cédric Le Goater wrote:
> Quiesce VF queues when entering the STOP state by disabling RX and TX
> at the PF level (VFRE/VFTE). This ensures no DMA activity occurs while
> the device state is being serialized. The unquiesce path re-enables
> queues when returning to RUNNING.
> 
> The VFRE and VFTE registers are shared PF-level registers with one bit
> per VF controlling RX and TX enable respectively. Writing the full
> 32-bit register during restore would clobber other VFs' bits, so these
> bits cannot be included in the regular per-VF register list. Instead,
> save the per-VF VFRE/VFTE bit state at quiesce time - before the bits
> are cleared - and append it to the migration blob as two bytes. On the
> destination, extract these bits and restore them during unquiesce.
> 
> For QEMU's emulated igb, the device state machine guarantees no DMA in
> these states. This register establishes the protocol for real hardware
> implementations where DMA drain has latency.
> 
> Assisted-by: Claude
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/net/igb_migration.h |   4 ++
>   hw/net/igb_migration.c | 110 +++++++++++++++++++++++++++++++++++++++--
>   hw/net/trace-events    |   6 ++-
>   3 files changed, 115 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/net/igb_migration.h b/hw/net/igb_migration.h
> index a2e7b363cb04..414412f6392e 100644
> --- a/hw/net/igb_migration.h
> +++ b/hw/net/igb_migration.h
> @@ -75,6 +75,7 @@
>   /* MIG_STATUS bits */
>   #define IGB_MIG_STATUS_DATA_AVAIL   (1u << 0)
>   #define IGB_MIG_STATUS_ERROR        (1u << 1)
> +#define IGB_MIG_STATUS_QUIESCED     (1u << 2)
>   
>   /* MIG_STATUS error codes in bits [15:8], valid when ERROR bit is set */
>   #define IGB_MIG_STATUS_ERR_SHIFT    8
> @@ -143,6 +144,9 @@ typedef struct IgbVfMigState {
>       uint32_t mig_data_size;
>       uint64_t mig_data_buf_addr;
>   
> +    bool mig_saved_vfre;
> +    bool mig_saved_vfte;
> +
>       uint32_t mig_dirty_pgsize;
>       uint64_t mig_dirty_range_iova;
>       uint32_t mig_dirty_range_size;
> diff --git a/hw/net/igb_migration.c b/hw/net/igb_migration.c
> index 9a9ce902bb4a..187077c14c48 100644
> --- a/hw/net/igb_migration.c
> +++ b/hw/net/igb_migration.c
> @@ -95,6 +95,7 @@ static IGBCore *igbvf_get_core(IgbVfState *s)
>    *   { uint32_t offset; uint32_t value; } regs[num_regs]
>    *   uint32_t  num_tx_ctx   (number of TX queue context blocks)
>    *   { raw struct igb_tx data } tx_ctx[num_tx_ctx]
> + *   uint32_t  vfre_vfte    (VFRE in [7:0], VFTE in [15:8])
>    */
>   
>   /* Maximum number of registers in the VF state slice */
> @@ -227,6 +228,13 @@ static uint32_t *igb_core_vf_save_ra(IGBCore *core, uint16_t vfn,
>       return p;
>   }
>   
> +static uint32_t *igb_core_vf_save_vfre_vfte(uint32_t *p,
> +                                            bool vfre, bool vfte)
> +{
> +    *p++ = cpu_to_le32((uint32_t)vfre | ((uint32_t)vfte << 8));
> +    return p;
> +}
> +
>   static uint32_t *igb_core_vf_save_tx_ctx(IGBCore *core, int queue,
>                                            uint32_t *p)
>   {
> @@ -243,12 +251,14 @@ static size_t igb_core_vf_state_max_size(int num_fixed_regs)
>            + num_fixed_regs * 2 * sizeof(uint32_t)   /* fixed reg pairs */
>            + max_ra_regs * 2 * sizeof(uint32_t)      /* RA reg pairs */
>            + sizeof(uint32_t)                        /* num_tx_ctx */
> -         + 2 * sizeof(struct igb_tx);              /* TX context */
> +         + 2 * sizeof(struct igb_tx)               /* TX context */
> +         + sizeof(uint32_t);                        /* VFRE + VFTE */
>   }
>   
>   static int igb_core_vf_save_state(IgbVfState *s,
>                                     void *buf, size_t buf_size)
>   {
> +    IgbVfMigState *ms = &s->mig;
>       IGBCore *core = igbvf_get_core(s);
>       uint32_t offsets[IGB_VF_MAX_REGS];
>       int num_regs, total_regs;
> @@ -296,9 +306,15 @@ static int igb_core_vf_save_state(IgbVfState *s,
>       p = igb_core_vf_save_tx_ctx(core, q0, p);
>       p = igb_core_vf_save_tx_ctx(core, q1, p);
>   
> +    /* Per-VF VFRE/VFTE enable bits */
> +    p = igb_core_vf_save_vfre_vfte(p, ms->mig_saved_vfre,
> +                                   ms->mig_saved_vfte);
> +
>       size = (uint8_t *)p - (uint8_t *)buf;
>   
> -    trace_igbvf_mig_save_state(s->vfn, size);
> +    trace_igbvf_mig_save_state(s->vfn, size, ms->mig_saved_vfre,
> +                               ms->mig_saved_vfte,
> +                               core->mac[VFRE]);
>       return size;
>   }
>   
> @@ -310,6 +326,16 @@ static int igb_core_vf_max_data_size(IgbVfState *s)
>       return size;
>   }
>   
> +static const void *igb_core_vf_load_vfre_vfte(const void *p,
> +                                              bool *out_vfre, bool *out_vfte)
> +{
> +    uint32_t val = le32_to_cpu(*(const uint32_t *)p);
> +
> +    *out_vfre = !!(val & 0xff);
> +    *out_vfte = !!((val >> 8) & 0xff);
> +    return (const uint8_t *)p + sizeof(uint32_t);
> +}
> +
>   static const void *igb_core_vf_load_tx_ctx(IGBCore *core, int queue,
>                                              const void *data)
>   {
> @@ -323,6 +349,7 @@ static const void *igb_core_vf_load_tx_ctx(IGBCore *core, int queue,
>   static int igb_core_vf_load_state(IgbVfState *s,
>                                     const void *buf, size_t size)
>   {
> +    IgbVfMigState *ms = &s->mig;
>       IGBCore *core = igbvf_get_core(s);
>       const uint32_t *p = buf;
>       uint32_t magic, version, saved_vfn, num_regs, num_tx;
> @@ -378,7 +405,13 @@ static int igb_core_vf_load_state(IgbVfState *s,
>        * destination-specific IRTE references after migration.
>        */
>   
> -    trace_igbvf_mig_load_state(s->vfn, (uint32_t)size);
> +    /* Per-VF VFRE/VFTE enable bits */
> +    p = igb_core_vf_load_vfre_vfte(p, &ms->mig_saved_vfre,
> +                                   &ms->mig_saved_vfte);
> +
> +    trace_igbvf_mig_load_state(s->vfn, (uint32_t)size,
> +                               ms->mig_saved_vfre,
> +                               ms->mig_saved_vfte);
>       return 0;
>   }
>   
> @@ -387,6 +420,12 @@ static int igbvf_mig_load(IgbVfState *s, const void *buf, size_t size)
>       IGBCore *core = igbvf_get_core(s);
>       int ret;
>   
> +    /*
> +     * Pre-load: Clear the VFLRE bit before restoring state so the PF
> +     * watchdog does not overwrite what we are about to load.
> +     */
> +    core->mac[VFLRE] &= ~BIT(s->vfn);
> +
>       ret = igb_core_vf_load_state(s, buf, size);
>       if (ret < 0) {
>           return ret;
> @@ -556,6 +595,45 @@ static bool igb_core_vf_dirty_query(IgbVfState *s,
>       return false;
>   }
>   
> +/* Quiesce a VF by disabling its RX and TX at the PF level. */
> +static void igb_core_vf_quiesce(IgbVfState *s)
> +{
> +    IgbVfMigState *ms = &s->mig;
> +    IGBCore *core = igbvf_get_core(s);
> +
> +    ms->mig_saved_vfre = !!(core->mac[VFRE] & BIT(s->vfn));
> +    ms->mig_saved_vfte = !!(core->mac[VFTE] & BIT(s->vfn));
> +
> +    core->mac[VFRE] &= ~BIT(s->vfn);
> +    core->mac[VFTE] &= ~BIT(s->vfn);
> +    trace_igbvf_mig_quiesce(s->vfn, core->mac[VFRE], core->mac[VFTE]);
> +}
> +
> +static void igb_core_vf_unquiesce(IgbVfState *s)
> +{
> +    IgbVfMigState *ms = &s->mig;
> +    IGBCore *core = igbvf_get_core(s);
> +    bool re = ms->mig_saved_vfre;
> +    bool te = ms->mig_saved_vfte;
> +
> +    if (re) {
> +        core->mac[VFRE] |= BIT(s->vfn);
> +    } else {
> +        core->mac[VFRE] &= ~BIT(s->vfn);
> +    }
> +    if (te) {
> +        core->mac[VFTE] |= BIT(s->vfn);
> +    } else {
> +        core->mac[VFTE] &= ~BIT(s->vfn);
> +    }
> +
> +    trace_igbvf_mig_unquiesce(s->vfn, core->mac[VFRE], core->mac[VFTE]);
> +
> +    if (re) {
> +        igb_start_recv(core);
> +    }
> +}
> +
>   /* ================================================================
>    * Migration BAR register read/write handlers
>    * ================================================================ */
> @@ -599,6 +677,10 @@ static bool igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
>               old == IGB_MIG_STATE_ERROR) {
>               igb_core_vf_dirty_disable(s);
>           }
> +        if (old == IGB_MIG_STATE_RUNNING ||
> +            old == IGB_MIG_STATE_PRE_COPY) {
> +            igb_core_vf_quiesce(s);
> +        }

ERROR → STOP is accepted, but quiescing only occurs from RUNNING or 
PRE_COPY. For example, a missing DATA_XFER buffer enters ERROR while 
RX/TX remain enabled; moving to STOP then advertises QUIESCED while VF 
DMA is still enabled.

Regards,
Akihiko Odaki

>           break;
>   
>       case IGB_MIG_STATE_RUNNING:
> @@ -609,6 +691,9 @@ static bool igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
>           if (old == IGB_MIG_STATE_PRE_COPY) {
>               igb_core_vf_dirty_disable(s);
>           }
> +        if (old == IGB_MIG_STATE_STOP) {
> +            igb_core_vf_unquiesce(s);
> +        }
>           break;
>   
>       case IGB_MIG_STATE_STOP_COPY:
> @@ -616,6 +701,9 @@ static bool igbvf_mig_set_state(IgbVfState *s, uint32_t new_state)
>               old != IGB_MIG_STATE_PRE_COPY) {
>               return false;
>           }
> +        if (old == IGB_MIG_STATE_PRE_COPY) {
> +            igb_core_vf_quiesce(s);
> +        }
>           ret = igb_core_vf_save_state(s, ms->mig_data, sizeof(ms->mig_data));
>           if (ret < 0) {
>               ms->mig_error = -ret;
> @@ -656,6 +744,20 @@ static uint32_t igbvf_mig_get_status(IgbVfState *s)
>           status |= IGB_MIG_STATUS_DATA_AVAIL;
>       }
>   
> +    /*
> +     * QUIESCED tells the driver it is safe to read device state.
> +     * STOP and STOP_COPY must guarantee that no VF DMA is in flight;
> +     * igb_core_vf_quiesce() enforces this by disabling RX/TX for the
> +     * VF.
> +     *
> +     * Under QEMU, DMA completes synchronously within the MMIO handler
> +     * so there is nothing to drain, but real hardware would need this.
> +     */
> +    if (ms->mig_state == IGB_MIG_STATE_STOP ||
> +        ms->mig_state == IGB_MIG_STATE_STOP_COPY) {
> +        status |= IGB_MIG_STATUS_QUIESCED;
> +    }
> +
>       return status;
>   }
>   
> @@ -1000,5 +1102,7 @@ void igbvf_mig_state_reset(IgbVfState *s)
>       ms->mig_dirty_range_size = 0;
>       ms->mig_dirty_buf_addr = 0;
>       ms->mig_dirty_status = IGB_MIG_DIRTY_STATUS_OK;
> +    ms->mig_saved_vfre = true;
> +    ms->mig_saved_vfte = true;
>       trace_igbvf_mig_reset(s->vfn);
>   }
> diff --git a/hw/net/trace-events b/hw/net/trace-events
> index 95fdea89d49c..f4940e3e176d 100644
> --- a/hw/net/trace-events
> +++ b/hw/net/trace-events
> @@ -300,8 +300,8 @@ igbvf_mig_bar_read(uint16_t vfn, uint64_t addr, uint64_t val) "VF%u: BAR read ad
>   igbvf_mig_bar_write(uint16_t vfn, uint64_t addr, uint64_t val) "VF%u: BAR write addr=0x%"PRIx64" val=0x%"PRIx64
>   igbvf_mig_set_state(uint16_t vfn, uint32_t old_state, uint32_t new_state) "VF%u: state %u -> %u"
>   igbvf_mig_set_state_err(uint16_t vfn, uint32_t old_state, uint32_t new_state) "VF%u: invalid transition %u -> %u"
> -igbvf_mig_save_state(uint16_t vfn, uint32_t size) "VF%u: saved %u bytes of device state"
> -igbvf_mig_load_state(uint16_t vfn, uint32_t size) "VF%u: loaded %u bytes of device state"
> +igbvf_mig_save_state(uint16_t vfn, int size, bool vfre, bool vfte, uint32_t reg_vfre) "VF%u: saved %d bytes vfre=%d vfte=%d VFRE=0x%x"
> +igbvf_mig_load_state(uint16_t vfn, uint32_t size, bool vfre, bool vfte) "VF%u: loaded %u bytes vfre=%d vfte=%d"
>   igbvf_mig_reset(uint16_t vfn) "VF%u: migration state reset"
>   igbvf_mig_dirty_enable(uint16_t vfn, uint64_t pgsize, uint64_t nbits) "VF%u: dirty tracking enabled pgsize=%"PRIu64" nbits=%"PRIu64
>   igbvf_mig_dirty_disable(uint16_t vfn) "VF%u: dirty tracking disabled"
> @@ -310,6 +310,8 @@ igbvf_mig_dirty_query(uint16_t vfn, uint64_t size, uint32_t dirty_pages) "VF%u:
>   # igb_core.c - VF migration diagnostics
>   igb_core_dirty_track_dma(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA addr=0x%"PRIx64" len=%"PRIu64
>   igb_core_dirty_track_dma_drop(int vfn, uint64_t addr, uint64_t len) "VF%d: dirty DMA dropped addr=0x%"PRIx64" len=%"PRIu64" no matching range"
> +igbvf_mig_quiesce(uint16_t vfn, uint32_t vfre, uint32_t vfte) "VF%u: quiesce VFRE=0x%x VFTE=0x%x"
> +igbvf_mig_unquiesce(uint16_t vfn, uint32_t vfre, uint32_t vfte) "VF%u: unquiesce VFRE=0x%x VFTE=0x%x"
>   
>   # spapr_llan.c
>   spapr_vlan_get_rx_bd_from_pool_found(int pool, int32_t count, uint32_t rx_bufs) "pool=%d count=%"PRId32" rxbufs=%"PRIu32


