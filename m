Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39AFCF3191
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 04:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swDqZ-0005VX-0H; Thu, 03 Oct 2024 00:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swDqW-0005VC-Op
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 00:53:49 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1swDqT-0006IN-5n
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 00:53:46 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2e0a74ce880so489173a91.2
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 21:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1727931223; x=1728536023;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9O9/5HrYnoCV2W17XeAiaPMEm4FUkuOB95wysgj+FSo=;
 b=jPcgFhltLIO1k2psD/Aar1vhbupak6VfEa703SJxz0t1zdZe6/sP/X3z4Je7iIhoRL
 2yvnK1TVPfdDNMQViddpUgMSehbhv4phtfABpQsyL0N7wFS0G3MV4ZIVKGJaYAb2Zp/2
 Rzp7DQ2EIWdORZh1DriT4s/AmIwEPQ/dcvuJT8p0iboiswlMnFVF2iiWZSkztP3oH8ID
 BH8dxB6qncrGkXNp7AN5gp8z8RuiGLpPRvySoWDiELjfrmn3Zq1AV5FUe3gaCnbnYBB4
 ftz9T9tQCfcolCL1REcfjTZ7aKYSAIodr/HyAacj9fkGOidPbDspiOwYvIqKj9Zo4KI0
 m0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727931223; x=1728536023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9O9/5HrYnoCV2W17XeAiaPMEm4FUkuOB95wysgj+FSo=;
 b=QK1j8yAqpkQRsLlOjlsfM4lp+bbUL+SmwSp4KSHob3DyX4Yvs+hnGWwZOY709GWAsP
 JB4vBg9pjWadFJOlCr//j/NE5/MLhcUrxKYjdvjZJK+rE+sNqoA4pwf7dL/e1VpgFHQn
 2IIbj1jsRwURgtHvnPlZD5HFzzjU4U6loivrzN+Bksako8G+ZgW3v9OzLNyGkjCJcE+5
 T9OC0+mNqUAN4MiGVDvKopIFiDw4z1agWevdbYDxTwxTovYErbN3UDdMa7kcKyfZNGQh
 Vg4BLEtZ+r6RcJ12alxo89xdJjbhdWjh93tt9mfoo52wJGrCSQLCMv7zgPpSTmo8p49Y
 ctpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9lcl/zs6MN/S/xfqM1N38TXj7f7Oby2CqdfFv92arnAOYxo5aABI7UXrtEtMyLPuFeJGpRlevMaeU@nongnu.org
X-Gm-Message-State: AOJu0YyiXAOMiENmCFMURt4WfXJz3FmrtulFVx0hy84K5ESWbqP0KbE/
 imfeXOZvXlkHc8Ksd8fquxpnYdU0v1f7luOK4qjiQ5EnP2woK22S1Xm6nVXTIuk=
X-Google-Smtp-Source: AGHT+IEndh8s4YDisVRcElmT9o8ITtXYAUcmHxNUJSWqmqil5mmgkzPw9R1w9TjCU9NSJL7M2V+tgQ==
X-Received: by 2002:a17:90a:c7cb:b0:2e0:6c40:e389 with SMTP id
 98e67ed59e1d1-2e18497114fmr7064088a91.33.1727931223284; 
 Wed, 02 Oct 2024 21:53:43 -0700 (PDT)
Received: from [157.82.207.107] ([157.82.207.107])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20beec9ead0sm1555115ad.78.2024.10.02.21.53.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 21:53:42 -0700 (PDT)
Message-ID: <e386eceb-1579-4445-ad93-2beb43aeb5ba@daynix.com>
Date: Thu, 3 Oct 2024 13:53:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/net_rx_pkt: Remove deadcode
To: dave@treblig.org, dmitry.fleytman@gmail.com, jasowang@redhat.com,
 qemu-devel@nongnu.org
References: <20240918225128.455043-1-dave@treblig.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240918225128.455043-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102b;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102b.google.com
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

On 2024/09/19 7:51, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> net_rx_pkt_get_l3_hdr_offset and net_rx_pkt_get_iovec_len haven't
> been used since they were added.

You forgot to remove net_rx_pkt_get_l3_hdr_offset() from: 
hw/net/net_rx_pkt.h
It looks good otherwise.

Regards,
Akihiko Odaki

> 
> Remove them.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/net/net_rx_pkt.c | 13 -------------
>   hw/net/net_rx_pkt.h |  9 ---------
>   2 files changed, 22 deletions(-)
> 
> diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
> index 32e5f3f9cf..cec1d0523d 100644
> --- a/hw/net/net_rx_pkt.c
> +++ b/hw/net/net_rx_pkt.c
> @@ -209,12 +209,6 @@ void net_rx_pkt_get_protocols(struct NetRxPkt *pkt,
>       *l4hdr_proto = pkt->l4hdr_info.proto;
>   }
>   
> -size_t net_rx_pkt_get_l3_hdr_offset(struct NetRxPkt *pkt)
> -{
> -    assert(pkt);
> -    return pkt->l3hdr_off;
> -}
> -
>   size_t net_rx_pkt_get_l4_hdr_offset(struct NetRxPkt *pkt)
>   {
>       assert(pkt);
> @@ -427,13 +421,6 @@ struct iovec *net_rx_pkt_get_iovec(struct NetRxPkt *pkt)
>       return pkt->vec;
>   }
>   
> -uint16_t net_rx_pkt_get_iovec_len(struct NetRxPkt *pkt)
> -{
> -    assert(pkt);
> -
> -    return pkt->vec_len;
> -}
> -
>   void net_rx_pkt_set_vhdr(struct NetRxPkt *pkt,
>                               struct virtio_net_hdr *vhdr)
>   {
> diff --git a/hw/net/net_rx_pkt.h b/hw/net/net_rx_pkt.h
> index 55ec67a1a7..e8df9cfd52 100644
> --- a/hw/net/net_rx_pkt.h
> +++ b/hw/net/net_rx_pkt.h
> @@ -267,15 +267,6 @@ net_rx_pkt_attach_data(struct NetRxPkt *pkt, const void *data,
>    */
>   struct iovec *net_rx_pkt_get_iovec(struct NetRxPkt *pkt);
>   
> -/**
> -* returns io vector length that holds the attached data
> -*
> -* @pkt:            packet
> -* @ret:            IOVec length
> -*
> -*/
> -uint16_t net_rx_pkt_get_iovec_len(struct NetRxPkt *pkt);
> -
>   /**
>    * prints rx packet data if debug is enabled
>    *


