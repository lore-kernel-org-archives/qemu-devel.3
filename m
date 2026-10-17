Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B0ECCF2C1
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 15:39:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xI6V5-0004Xw-8M; Sat, 17 Oct 2026 11:39:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI6V2-0004XD-P2
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:39:08 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xI6V0-0001zT-KQ
 for qemu-devel@nongnu.org; Sat, 17 Oct 2026 11:39:08 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8ab38a051aaso6796647b3.3
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2026 08:39:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792251545; cv=none;
 d=google.com; s=arc-20260327;
 b=rGAtgrbmSnsXeUL+JPwDee3uY3jEeEqRstpCLr/FfYMqWO8Clt09PzYuC0691S1aH7
 dUNrWD4L12LcxdW7BMXAeB7+scaQTSsh69hVYpoaXQTdHnPhu+8alyaGa4lBTJKHzJER
 hYV5WenDwf6iK1B/QryNyQDOEKEdBayn90XtzQncCjn+EiPU9jVolDbKWx9pD2mvnLsX
 oNHMO6ur7SLmAsYzB+7Stp/Tte8vrHcR0fX3BElvWVs9FrAv1J5kj62W3vp3VkgDFBzz
 KJbWwfqzEpm1KPSaATSXgRY430ZzZ3c8VwCGrIiuwUIupyUsF9DF+okqGfQNUZ5UOEjb
 qUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=xH9Ow/YbPdzqpaddQqmZkDKhcR9h1zYKMdW6/JuC33M=;
 fh=TUfzxw1B/DFEA1jNT0iQFdzEda/YXFE68WBEXYJToV4=;
 b=CcNaBc09lN1Tu/fVIZxuJBwnlV4dd65zoR5HzN5tsRQpWRDS6J/dmdybLbtwpTPndj
 zBOZQ9qDCAta4DeoZC6cKMMaADWqHxMgFGGGekVeRkDjtNod6nIOJCPm3AHLeGwtpVHO
 Tpe/zPsqH7BkwV6fs6k6IUTbFpFw6op7jjJ/Unrmy56H2y2+BfOoCtMF85mdZxAKd4Nb
 S6RqMlvj2ti6diSkpn5hTQibj9YZLFsp3GtuWUTmVL5tBNYjDrZAkPaaw/SUj8xQwpNs
 31GjQA/LJRiNW5MYNmUqglLo4zK/FCp08frIqm90x0hUC68zskKUlqTbGIHWfQFkF5Fe
 TWyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792251545; x=1792856345; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xH9Ow/YbPdzqpaddQqmZkDKhcR9h1zYKMdW6/JuC33M=;
 b=lXwL7eJH04KOBFswOQcYZBjIfPhVUqyZu5EoInfDC9LVQ8gGXfB0C2FUbtEj2/CnDq
 lOLd1E+DsCnFxaePb2b1SOuldrGz6c5eHTqoA9n/GPlr4bRspAGWAreBNq+5tfKDDB/p
 4JqOHZ/Hh9XWMfP1piNe64G3kB8SY9eTvk5kUrKZj57RBt2gt8wWac6RMKNiGlxXzC1k
 /2fSyRIy2oH21FY4CYce+xo4FJHLcJr9eljrtFxN1Avu0hqS9xNvS+KbCS2OQ7IofAL9
 t/IAv2UkQchwP4JckpMCXxcYBIbQIXWwrkX/J0CLgPfgppDy+aixv4flQ+Y7fWfgNy/y
 WvWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792251545; x=1792856345;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=xH9Ow/YbPdzqpaddQqmZkDKhcR9h1zYKMdW6/JuC33M=;
 b=hR/eFHZB2pNj1FqRU5qLErB0d5qC0JX1IXAAl01yMml46QlErHqyhwdxLlla50aTMj
 dQj1HGy1dyDujpWp8ZOUzSsNVLgVXYmSR5zGKKABI2FsFF4k8TlfAh1e7QubG9e1aY0O
 ntnAEnc8E4OlpmzucjBuxPiut9XCkOUnJFLcABppJiDConPNHxN0TTPbcFekpiYOBaZo
 vzSBDxXs4h6LUQL9Mj7I9Wpir4vyhee4Fc9iOEvLxbJG0BPTEIjtx5VwdIiDsVy8SwTW
 Xyjoq0SoXGP9C6UgRES7jsGwHnxKAvOt8brwTXniAQ8cCBDb08jLcWAV2Ih58gjKxV/j
 FDcw==
X-Gm-Message-State: AFq9FYKn0EVhOa50r6731U1o1cP1p+OGV/0wsorPJX9IYMAy1bCALcoq
 y7HqLQ2IOX6FxxPhZOmMwSTf1784OqXrov7JZs6c6E6cZ/t5PYQ7iK1zSHxRvbvMXaz+S4lRBrp
 ehiP7ctD9OYfpJFHa7ibY9S9KgrSEm9cWo8qKJIKj+g==
X-Gm-Gg: AYBFou1ncIFdzvSk7+/7q6+206AV5t0QPxd9m3mOwE0q+Zporfl6Nj1+HjyulXlKRI5
 EJT/XmZPmvVEAZMuH1JOkJUHQC+hBd2z3/qw/2TUwTJfEIb7ceMRIJEwap9SCMHnEJpTThacWMZ
 dBeJCeY6ZUxQGd5VaINz4c7FER3SkevQJeYK29R0Lq40FS4tyRMLXUtcsGemYVfNaDkjEXRJ34C
 2fySpSnBUjHhTIBtD6fUo+IEWcQlf8Lybubt0EVVI5ODanMIRtIthdJEtTYv/vaD/p9iENi07yA
 0Z4ghOykFnUJLS+wLxsQDv+dTcfm9Sny0kapQxujyPGqbpYdxLtBY5e1ak0Kao8h1MLnnvntt21
 PcDuV8ng582WGjmSRgaNveBcMdfcj/MnuJYIHEy2e77JegYYdNg==
X-Received: by 2002:a05:690c:6903:b0:8ac:c329:67e6 with SMTP id
 00721157ae682-8b0f21ae8a2mr11292217b3.16.1792251545026; Sat, 17 Oct 2026
 08:39:05 -0700 (PDT)
MIME-Version: 1.0
References: <20261015181122.60608-1-marcelomanzo@gmail.com>
 <20261015181122.60608-13-marcelomanzo@gmail.com>
In-Reply-To: <20261015181122.60608-13-marcelomanzo@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2026 16:38:53 +0100
X-Gm-Features: AclHuK8TmQtBDBKUkeLVXbSUdlXDH9bUFF0pDmh40JjGV_pvwgP-byOi4_z9ngo
Message-ID: <CAFEAcA8fkUuyz7HDEEnhZ1RZRZjzrNeyw9tbV5+fTczRmxSDSg@mail.gmail.com>
Subject: Re: [PATCH v3 12/16] hw/net/bcm2838_genet: implement GENET TX path
To: Marcelo Manzo <marcelomanzo@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Sergey Kambalin <serg.oker@gmail.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, 
 Jason Wang <jasowangio@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Thu, 15 Oct 2026 at 19:11, Marcelo Manzo <marcelomanzo@gmail.com> wrote:
>
> From: Sergey Kambalin <serg.oker@gmail.com>
>
> Implement the transmit DMA ring handling: walk TX descriptors
> between the consumer and producer index for a ring, pull frame data
> out of guest memory, and hand completed frames to the netdev peer
> via qemu_send_packet(), advancing the consumer index and raising the
> TXDMA_MBDONE interrupt as descriptors complete.
>
> Part of Sergey Kambalin's original Raspberry Pi 4B PCIe/GENET
> networking series (patchwork series 829638, posted to qemu-devel in
> 2024, never merged). Carried forward and completed by Marcelo Manzo.
>
> While carrying this forward, fix bcm2838_genet_tdma_ring_active():
> it extracted the per-ring enable bit using the DMA_CTRL register's
> 1-bit EN field definition instead of DMA_RING_CFG's 17-bit EN field
> (one bit per ring), so only ring 0 ever appeared active and TX
> traffic hashed onto any other queue was silently dropped, eventually
> tripping the guest's qdisc watchdog ("NETDEV WATCHDOG: transmit
> queue N timed out") and breaking DHCP.
>
> Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
> Signed-off-by: Marcelo Manzo <marcelomanzo@gmail.com>
> ---
>  hw/net/bcm2838_genet.c         | 219 ++++++++++++++++++++++++++++++++-
>  include/hw/net/bcm2838_genet.h |  17 +++
>  2 files changed, 235 insertions(+), 1 deletion(-)
>
> diff --git a/hw/net/bcm2838_genet.c b/hw/net/bcm2838_genet.c
> index fe2a3cf890..7eba0edbb6 100644
> --- a/hw/net/bcm2838_genet.c
> +++ b/hw/net/bcm2838_genet.c
> @@ -239,6 +239,13 @@ REG16(GENET_PHY_EXP_SEL,           0)
>  FIELD(GENET_PHY_EXP_SEL, REG_ID,   0, 8)
>  FIELD(GENET_PHY_EXP_SEL, BLOCK_ID, 8, 8)
>
> +REG32(GENET_TX_CSUM_INFO,            0)
> +FIELD(GENET_TX_CSUM_INFO, OFFSET,    0, 15)
> +FIELD(GENET_TX_CSUM_INFO, PROTO_UDP, 15, 1)
> +FIELD(GENET_TX_CSUM_INFO, START,     16, 15)
> +FIELD(GENET_TX_CSUM_INFO, LV,        30, 1)
> +
> +
>  static void bcm2838_genet_set_qemu_mac(BCM2838GenetState *s)
>  {
>      const MACAddr *addr = &s->nic_conf.macaddr;
> @@ -403,6 +410,216 @@ static uint64_t bcm2838_genet_mdio_cmd(BCM2838GenetState *s, uint64_t cmd)
>      return cmd;
>  }
>
> +static void bcm2838_genet_xmit_packet(NetClientState *s, void *packet,
> +                                      size_t size)
> +{
> +    uint8_t *buf = packet + sizeof(BCM2838GenetXmitStatus);

Do we know that the size is always big enough for this
(and for the accesses to buf + 12 and buf + 13 below) ?

> +    size_t len = size;
> +    uint16_t len_type = 0;
> +
> +    len -= sizeof(BCM2838GenetXmitStatus);
> +    net_checksum_calculate(buf, len, CSUM_ALL);
> +
> +    memcpy(&len_type, &buf[12], sizeof(len_type));
> +    len_type = ntohs(len_type);

This can be more clearly written as
    len_type = lduw_be_p(buf + 12);
rather than manual memcpy-and-swap

> +    if (len_type < MAX_PAYLOAD_SIZE) {
> +        len_type = len;
> +        len_type = htons(len_type);
> +        memcpy(&buf[12], &len_type, sizeof(len_type));

and this is
    stw_be_p(buf + 12, len);

> +    }
> +
> +    qemu_send_packet(s, buf, len);
> +}
> +
> +static uint64_t bcm2838_genet_tx(BCM2838GenetState *s, unsigned int ring_index,
> +                                 uint32_t prod_index,
> +                                 uint32_t cons_index)
> +{
> +    const unsigned int DESC_SIZE_WORDS
> +        = sizeof(BCM2838GenetTdmaDesc) / sizeof(uint32_t);
> +    const uint64_t RING_START_ADDR
> +        = ((uint64_t)s->regs.tdma.rings[ring_index].start_addr_hi << 32)
> +            + s->regs.tdma.rings[ring_index].start_addr;
> +    const uint64_t RING_END_ADDR
> +        = ((uint64_t)s->regs.tdma.rings[ring_index].end_addr_hi << 32)
> +            + s->regs.tdma.rings[ring_index].end_addr;

Use lower case for variables please, upper case is for preprocessor macros.

This "construct the 64 bit value from the two 32 bit halves" is awkward
enough and happens often enough in this function that maybe it would
read more clearly if abstracted out somehow?

> +
> +    hwaddr data_addr;
> +    uint64_t desc_index;
> +    uint32_t desc_status = 0;
> +    uint32_t buflength = 0;
> +    uint64_t num_descs = 0;
> +    uint64_t read_ptr
> +        = ((uint64_t)s->regs.tdma.rings[ring_index].read_ptr_hi << 32)
> +            + s->regs.tdma.rings[ring_index].read_ptr;
> +    off_t packet_off = 0;
> +
> +    uint32_t prod_index_fld = FIELD_EX32(prod_index,
> +                                         GENET_DMA_PROD_INDEX, INDEX);
> +    uint32_t cons_index_fld = FIELD_EX32(cons_index,
> +                                        GENET_DMA_CONS_INDEX, INDEX);
> +
> +    while (cons_index_fld != prod_index_fld) {
> +        desc_index = read_ptr / DESC_SIZE_WORDS;
> +        if (desc_index >= BCM2838_GENET_DMA_DESC_CNT) {
> +            qemu_log_mask(
> +                LOG_GUEST_ERROR,
> +                "%s: invalid TX descriptor index %" PRIu64 " (exceeds %u)\n",
> +                __func__, desc_index, BCM2838_GENET_DMA_DESC_CNT - 1);
> +            break;
> +        }
> +        desc_status = s->regs.tdma.descs[desc_index].length_status;
> +        data_addr = ((uint64_t)s->regs.tdma.descs[desc_index].address_hi << 32)
> +            + s->regs.tdma.descs[desc_index].address_lo;
> +        trace_bcm2838_genet_tx(ring_index, desc_index, desc_status,
> +                               data_addr);
> +
> +        if (FIELD_EX32(desc_status, GENET_RDMA_LENGTH_STATUS, SOP) != 0) {
> +            packet_off = 0;
> +        }
> +
> +        buflength = FIELD_EX32(desc_status,
> +                               GENET_RDMA_LENGTH_STATUS, BUFLENGTH);
> +
> +        /* TODO: Add address_space_read() return value check */

That would be a good idea :-)

> +        address_space_read(&s->dma_as, data_addr,
> +                                        MEMTXATTRS_UNSPECIFIED,
> +                                        s->tx_packet + packet_off,
> +                                        buflength);

There doesn't seem to be a check here that this isn't going to read
more data than we can fit without running off the end of tx_packet[].

> +        packet_off += buflength;
> +
> +        if (FIELD_EX32(desc_status, GENET_RDMA_LENGTH_STATUS, EOP) != 0) {
> +            bcm2838_genet_xmit_packet(qemu_get_queue(s->nic), s->tx_packet,
> +                                                     packet_off);
> +            packet_off = 0;
> +        }
> +
> +        num_descs++;
> +        cons_index_fld++;
> +        s->regs.tdma.descs[desc_index].length_status =
> +            FIELD_DP32(s->regs.tdma.descs[desc_index].length_status,
> +                       GENET_RDMA_LENGTH_STATUS, OWN, 1);
> +        read_ptr = read_ptr == RING_END_ADDR + 1 - DESC_SIZE_WORDS
> +            ? RING_START_ADDR : read_ptr + DESC_SIZE_WORDS;
> +    }
> +
> +    s->regs.tdma.rings[ring_index].read_ptr = read_ptr;
> +    s->regs.tdma.rings[ring_index].read_ptr_hi = read_ptr >> 32;
> +
> +    return num_descs;
> +}
> +
> +static bool bcm2838_genet_tdma_ring_active(BCM2838GenetState *s,
> +                                           unsigned int ring_index)
> +{
> +    uint32_t ctrl_reg = s->regs.tdma.ctrl;
> +    uint32_t ring_cfg_reg = s->regs.tdma.ring_cfg;
> +    uint32_t ring_mask = 1 << ring_index;
> +    bool dma_en = FIELD_EX32(ctrl_reg, GENET_DMA_CTRL, EN) != 0;

You don't need the != 0 when you're assigning to a bool;
  dma_en = FIELD_EX32(....);
is sufficient.

> +    bool ring_en =
> +        (FIELD_EX32(ring_cfg_reg, GENET_DMA_RING_CFG, EN) & ring_mask) != 0;

> +    bool ring_buf_en =
> +        (FIELD_EX32(ctrl_reg, GENET_DMA_CTRL, RING_BUF_EN) & ring_mask) != 0;
> +    bool active = dma_en && ring_en && ring_buf_en;
> +
> +    trace_bcm2838_genet_tx_dma_ring_active(ring_index,
> +                                           active ? "active" : "halted");
> +    return active;
> +}
> +
> +static void bcm2838_genet_tdma(BCM2838GenetState *s, hwaddr offset,
> +                               uint64_t value)
> +{
> +    hwaddr ring_offset;
> +    uint64_t num_descs_tx;
> +    unsigned int ring_index;
> +     uint32_t tx_intrs;

Misaligned indent.

> +    uint32_t cons_index;
> +    uint32_t prod_index = value;
> +    uint32_t ring_cfg = value;
> +    uint32_t dma_ctrl = value;
> +
> +    uint32_t cons_index_fld;
> +    uint32_t prod_index_fld =
> +        FIELD_EX32(prod_index, GENET_DMA_PROD_INDEX, INDEX);
> +
> +    uint32_t exst_tdma_en =
> +        FIELD_EX32(s->regs.tdma.ctrl, GENET_DMA_CTRL, EN);
> +    uint32_t exst_ring_en =
> +        FIELD_EX32(s->regs.tdma.ring_cfg, GENET_DMA_RING_CFG, EN);
> +    uint32_t incm_tdma_en =
> +        FIELD_EX32(dma_ctrl, GENET_DMA_CTRL, EN);
> +    uint32_t incm_ring_en =
> +        FIELD_EX32(ring_cfg, GENET_DMA_RING_CFG, EN);
> +    uint32_t incm_ring_buf_en =
> +        FIELD_EX32(dma_ctrl, GENET_DMA_CTRL, RING_BUF_EN);
> +
> +    switch (offset) {
> +    case BCM2838_GENET_TDMA_RINGS
> +        ... BCM2838_GENET_TDMA_RINGS + sizeof(s->regs.tdma.rings) - 1:
> +        ring_index = (offset - BCM2838_GENET_TDMA_RINGS)
> +            / sizeof(BCM2838GenetTdmaRing);
> +        if (bcm2838_genet_tdma_ring_active(s, ring_index)) {
> +            ring_offset = offset - BCM2838_GENET_TDMA_RINGS
> +                - ring_index * sizeof(BCM2838GenetTdmaRing);
> +            switch (ring_offset) {
> +            case BCM2838_GENET_TRING_PROD_INDEX:
> +                cons_index = s->regs.tdma.rings[ring_index].cons_index;
> +                cons_index_fld = FIELD_EX32(cons_index,
> +                                            GENET_DMA_CONS_INDEX, INDEX);
> +                if (cons_index_fld != prod_index_fld) {
> +                    trace_bcm2838_genet_tx_request(ring_index,
> +                                                   prod_index_fld,
> +                                                   cons_index_fld);
> +                    num_descs_tx = bcm2838_genet_tx(s, ring_index, prod_index,
> +                                                    cons_index);
> +                    if (num_descs_tx > 0) {
> +                        s->regs.tdma.rings[ring_index].cons_index =
> +                            FIELD_DP32(s->regs.tdma.rings[ring_index].cons_index,
> +                                       GENET_DMA_CONS_INDEX, INDEX,
> +                                       cons_index + num_descs_tx);
> +
> +                        if (ring_index == BCM2838_GENET_DMA_RING_DEFAULT) {
> +                            s->regs.intrl0.stat =
> +                                FIELD_DP32(s->regs.intrl0.stat, GENET_INTRL_0,
> +                                           TXDMA_MBDONE, 1);
> +                        } else {
> +                            tx_intrs =  FIELD_EX32(s->regs.intrl1.stat,
> +                                                   GENET_INTRL_1, TX_INTRS);
> +                            s->regs.intrl1.stat =
> +                                FIELD_DP32(s->regs.intrl1.stat,
> +                                           GENET_INTRL_1, TX_INTRS,
> +                                           tx_intrs | 1 << ring_index);
> +                        }
> +                    }
> +                }

This is quite awkward to read because it indents in a lot and a
lot of the lines end up heavily wrapped as a consequence. Abstracting
some of the inner bit out into a function might help.

> +                break;
> +            default:
> +                break;
> +            }
> +        }
> +        break;
> +    case BCM2838_GENET_TDMA_RING_CFG:
> +        if (exst_ring_en != incm_ring_en) {
> +            trace_bcm2838_genet_tx_dma_ring(incm_ring_en);
> +        }
> +        break;
> +    case BCM2838_GENET_TDMA_CTRL:
> +        s->regs.tdma.status = (~dma_ctrl) & GENET_DMA_ENABLE_MASK;
> +        if (exst_tdma_en != incm_tdma_en) {
> +            trace_bcm2838_genet_tx_dma(incm_tdma_en == 1
> +                                       ? "enabled"
> +                                       : "disabled");
> +        }
> +        if (exst_ring_en != incm_ring_buf_en) {
> +            trace_bcm2838_genet_tx_dma_ring_buf(incm_ring_buf_en);
> +        }
> +        break;
> +    default:
> +        break;
> +    }

thanks
-- PMM

