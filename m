Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22A9EEA845
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 18:46:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqbgk-0000UY-AQ; Thu, 12 Feb 2026 13:45:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqbgi-0000UH-U2
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:45:16 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vqbgg-0002Hi-Hu
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 13:45:16 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 68473596A29;
 Thu, 12 Feb 2026 19:45:10 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id LOBMRQKmUj0T; Thu, 12 Feb 2026 19:45:08 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 603BC596A0B; Thu, 12 Feb 2026 19:45:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5E2065969F0;
 Thu, 12 Feb 2026 19:45:08 +0100 (CET)
Date: Thu, 12 Feb 2026 19:45:08 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: qemu-devel@nongnu.org
cc: Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH] rtl8139: Remove ineffective parameter
In-Reply-To: <20260127173849.588F25969F0@zero.eik.bme.hu>
Message-ID: <597883bc-c6a3-cd7f-42dc-1ee7fb8e213c@eik.bme.hu>
References: <20260127173849.588F25969F0@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
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

On Tue, 27 Jan 2026, BALATON Zoltan wrote:
> The do_interrupt parameter for rtl8139_do_receive was originally added
> in commit 6cadb320c7 to avoid generating interrupt when receiving in
> loopback mode. Later commit 5311fb805a changed this so that this
> parameter became ineffective and now this parameter is unused and
> always 1. If this turns out to be a problem maybe there's a better way
> to fix this so remove the do_interrupt parameter for now to simplify
> code.

Ping?

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> hw/net/rtl8139.c | 24 ++++++++----------------
> 1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
> index 9fd00574d2..2ad6338ebe 100644
> --- a/hw/net/rtl8139.c
> +++ b/hw/net/rtl8139.c
> @@ -815,7 +815,8 @@ static bool rtl8139_can_receive(NetClientState *nc)
>     return avail == 0 || avail >= 1514 || (s->IntrMask & RxOverflow);
> }
>
> -static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t size_, int do_interrupt)
> +static ssize_t rtl8139_receive(NetClientState *nc,
> +                               const uint8_t *buf, size_t size_)
> {
>     RTL8139State *s = qemu_get_nic_opaque(nc);
>     PCIDevice *d = PCI_DEVICE(s);
> @@ -1173,20 +1174,11 @@ static ssize_t rtl8139_do_receive(NetClientState *nc, const uint8_t *buf, size_t
>     }
>
>     s->IntrStatus |= RxOK;
> -
> -    if (do_interrupt)
> -    {
> -        rtl8139_update_irq(s);
> -    }
> +    rtl8139_update_irq(s);
>
>     return size_;
> }
>
> -static ssize_t rtl8139_receive(NetClientState *nc, const uint8_t *buf, size_t size)
> -{
> -    return rtl8139_do_receive(nc, buf, size, 1);
> -}
> -
> static void rtl8139_reset_rxring(RTL8139State *s, uint32_t bufferSize)
> {
>     s->RxBufferSize = bufferSize;
> @@ -1745,7 +1737,7 @@ static uint32_t rtl8139_RxConfig_read(RTL8139State *s)
> }
>
> static void rtl8139_transfer_frame(RTL8139State *s, uint8_t *buf, int size,
> -    int do_interrupt, const uint8_t *dot1q_buf)
> +                                   const uint8_t *dot1q_buf)
> {
>     struct iovec *iov = NULL;
>     struct iovec vlan_iov[3];
> @@ -1828,7 +1820,7 @@ static int rtl8139_transmit_one(RTL8139State *s, int descriptor)
>     s->TxStatus[descriptor] |= TxHostOwns;
>     s->TxStatus[descriptor] |= TxStatOK;
>
> -    rtl8139_transfer_frame(s, txbuffer, txsize, 0, NULL);
> +    rtl8139_transfer_frame(s, txbuffer, txsize, NULL);
>
>     DPRINTF("+++ transmitted %d bytes from descriptor %d\n", txsize,
>         descriptor);
> @@ -2246,7 +2238,7 @@ static int rtl8139_cplus_transmit_one(RTL8139State *s)
>                     DPRINTF("+++ C+ mode TSO transferring packet size "
>                         "%d\n", tso_send_size);
>                     rtl8139_transfer_frame(s, saved_buffer, tso_send_size,
> -                        0, (uint8_t *) dot1q_buffer);
> +                                           (uint8_t *)dot1q_buffer);
>
>                     /* add transferred count to TCP sequence number */
>                     stl_be_p(&p_tcp_hdr->th_seq,
> @@ -2323,8 +2315,8 @@ skip_offload:
>
>         DPRINTF("+++ C+ mode transmitting %d bytes packet\n", saved_size);
>
> -        rtl8139_transfer_frame(s, saved_buffer, saved_size, 1,
> -            (uint8_t *) dot1q_buffer);
> +        rtl8139_transfer_frame(s, saved_buffer, saved_size,
> +                               (uint8_t *)dot1q_buffer);
>
>         /* restore card space if there was no recursion and reset offset */
>         if (!s->cplus_txbuffer)
>

