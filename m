Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080A0D68BE8
	for <qemu-devel@archiver.kernel.org>; Sun, 17 Nov 2024 02:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tCUin-0002WB-Q5; Sat, 16 Nov 2024 21:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1tCUil-0002Vu-Ul
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 21:09:03 -0500
Received: from mail-oa1-x29.google.com ([2001:4860:4864:20::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wsh@wshooper.org>) id 1tCUij-0007D4-GU
 for qemu-devel@nongnu.org; Sat, 16 Nov 2024 21:09:03 -0500
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-288661760d3so1251562fac.3
 for <qemu-devel@nongnu.org>; Sat, 16 Nov 2024 18:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wshooper-org.20230601.gappssmtp.com; s=20230601; t=1731809339; x=1732414139;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKjdsaPS3xJtqeOLFIP5v+KOIOi47TAq2JhucXWfrl4=;
 b=dhatH7Bnnqqo9nX3GszpIqBFo17I4Nd9EGxoqs//lboLf/KLb+Te9k/ec7hH/x4jOm
 1pSFDWBlIkVOMLERZvFjB2Nl3cPdp0in0MA/ThyGZ51VjPqQgx8Rp620nbjCeQd7fQMe
 0SQnkvbV9vWvz7WIxRL4aKrdlaNo2MXbwWShee6abuFpnkEA6kWN0rsEFjbBFZgpf9gT
 rrn3ddeOXBerzsU7hy9HQ7w5d1t5YlkPNvhpYLPdZLcUf4uEEqsvTQPcx14ESfSDmA/b
 RzcceFJGrRRTFcSIujQH7ZWMkyjRLU6BKeTV+6eSylB7KqSC45jwMC/Y8cP8k7BOtLc7
 J/Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731809339; x=1732414139;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKjdsaPS3xJtqeOLFIP5v+KOIOi47TAq2JhucXWfrl4=;
 b=nYEisRtM1wpS3iQWlHvxvhc08aD7UnL3Gu1d+cAztHL6v2ZxYylYoGssDI4ZxH1ES8
 qq+NawKQyNBBftGliPWFglZSTUOJN+xXzv+o9Jfp1KnnJGnck4r4plmA/TvSW34Dsein
 Yc4xUPLe3Bh9z1bj5PR8jE+FWCpiMV2DUtyt54ab9IT8DNIBeddaR1dm//AgZyvxj66W
 akx4AMNrnMlEdZn5FoV7XPABTTLi/addAOq8AGFUlc2GFKID0lW0wlza3ikYZEUf7dH7
 rJrjbZDG8KWElliq1p9rT2uQ8C+bbcN/8gAsZQ0i4rR3ni0JAsfynsYs4lGswD58PpBp
 iuEw==
X-Gm-Message-State: AOJu0YwsWsh3alz5NdHWWea331/1GNlRCf8nKmSuftjWLY6fS9qcsMkx
 f0m7UKoRpcDCM+7tu3cx3i0lov5dZr8u+1SOhOAe2N41hNNIrW5CN5Eo83cqPV6/J1qKu/9FRG8
 loUCedETiACgQ8Ja+34dJHdkhHW88BL1dpIQWGjzKHGnEMjtz
X-Google-Smtp-Source: AGHT+IGYysWoImwYZGuVZl8kNgEu2qrx1iBCasJn7be7XPVI6/7KKbwr2ijTDeU4dYiD1KQe0xKO6+mb6eQzu/CeTBI=
X-Received: by 2002:a05:6870:be95:b0:288:6220:fe0b with SMTP id
 586e51a60fabf-2962dc72d5emr6342813fac.7.1731809339038; Sat, 16 Nov 2024
 18:08:59 -0800 (PST)
MIME-Version: 1.0
References: <CAGCz3vsusRSsT8-Fi3a2Z4aeQMtxCzDZ73D8ZgefxVZvm=qY6Q@mail.gmail.com>
 <20241102205653.30476-1-wsh@wshooper.org>
In-Reply-To: <20241102205653.30476-1-wsh@wshooper.org>
From: William Hooper <wsh@wshooper.org>
Date: Sat, 16 Nov 2024 18:08:48 -0800
Message-ID: <CANto9c4DLCYTqkodiDNrW6xyq=DfUE3oX3HEyiY8sbEoSCguYg@mail.gmail.com>
Subject: Ping: [PATCH v3] net/vmnet: Pad short Ethernet frames
To: qemu-devel@nongnu.org
Cc: Bin Meng <bin.meng@windriver.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Phil Dennis-Jordan <lists@philjordan.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2001:4860:4864:20::29;
 envelope-from=wsh@wshooper.org; helo=mail-oa1-x29.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Sat, Nov 2, 2024 at 1:56=E2=80=AFPM William Hooper <wsh@wshooper.org> wr=
ote:
> At least on macOS 12.7.2, vmnet doesn't pad Ethernet frames, such as the
> host's ARP replies, to the minimum size (60 bytes before the frame check
> sequence) defined in IEEE Std 802.3-2022, so guests' Ethernet device
> drivers may drop them with "frame too short" errors.
>
> This patch calls eth_pad_short_frame() to add padding, as in net/tap.c
> and net/slirp.c. Thanks to Bin Meng, Philippe Mathieu-Daud=C3=A9, and Phi=
l
> Dennis-Jordan for reviewing earlier versions.
>
> Signed-off-by: William Hooper <wsh@wshooper.org>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2058
> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>  net/vmnet-common.m | 23 ++++++++++++++++++++---
>  1 file changed, 20 insertions(+), 3 deletions(-)
>
> diff --git a/net/vmnet-common.m b/net/vmnet-common.m
> index 30c4e53c13..4b7e330c05 100644
> --- a/net/vmnet-common.m
> +++ b/net/vmnet-common.m
> @@ -18,6 +18,7 @@
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "sysemu/runstate.h"
> +#include "net/eth.h"
>
>  #include <vmnet/vmnet.h>
>  #include <dispatch/dispatch.h>
> @@ -147,10 +148,26 @@ static int vmnet_read_packets(VmnetState *s)
>   */
>  static void vmnet_write_packets_to_qemu(VmnetState *s)
>  {
> +    uint8_t *pkt;
> +    size_t pktsz;
> +    uint8_t min_pkt[ETH_ZLEN];
> +    size_t min_pktsz;
> +    ssize_t size;
> +
>      while (s->packets_send_current_pos < s->packets_send_end_pos) {
> -        ssize_t size =3D qemu_send_packet_async(&s->nc,
> -                                      s->iov_buf[s->packets_send_current=
_pos].iov_base,
> -                                      s->packets_buf[s->packets_send_cur=
rent_pos].vm_pkt_size,
> +        pkt =3D s->iov_buf[s->packets_send_current_pos].iov_base;
> +        pktsz =3D s->packets_buf[s->packets_send_current_pos].vm_pkt_siz=
e;
> +
> +        if (net_peer_needs_padding(&s->nc)) {
> +            min_pktsz =3D sizeof(min_pkt);
> +
> +            if (eth_pad_short_frame(min_pkt, &min_pktsz, pkt, pktsz)) {
> +                pkt =3D min_pkt;
> +                pktsz =3D min_pktsz;
> +            }
> +        }
> +
> +        size =3D qemu_send_packet_async(&s->nc, pkt, pktsz,
>                                        vmnet_send_completed);
>
>          if (size =3D=3D 0) {

Ping?

https://patchew.org/QEMU/20241102205653.30476-1-wsh@wshooper.org/

