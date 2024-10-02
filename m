Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2247CF31AF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:31:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwd2-0002G1-UJ; Wed, 02 Oct 2024 06:30:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwcr-00029l-Rj
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:30:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwcq-00017C-Er
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727865031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PqbvLNiWpttX6u++jFp56ODO73PpQrxGcq4nCzgmhJM=;
 b=cqz6N8PklHMYCveC7vdEdkok2AyPg/JSSzYe7zYEzvyuXwzbxG9Of+DPk9BzOahAWEmeoj
 v8kfFoUB9wYw6dFDz8lHn/hKgLHAlkpoH+2JS6mTCLilh6XdId3BAavXkpXOVbuVYggL+u
 k7c3pOTT/Yhh6zp9GwklOXu/+e6BcrA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-vS6kt0KmP-y8Ao3_qjGSsw-1; Wed, 02 Oct 2024 06:30:29 -0400
X-MC-Unique: vS6kt0KmP-y8Ao3_qjGSsw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb080ab53so50110695e9.0
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 03:30:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727865028; x=1728469828;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PqbvLNiWpttX6u++jFp56ODO73PpQrxGcq4nCzgmhJM=;
 b=pdD4zlKCmorKTQbza/rbCavsviPQljmVw5clVRoD8wOrkXBJJtFy4jDJaKKX0hjPYI
 10OJ8cznKFTJXzwidi22Iccpv6v7Dpy0QEXb98WO6+vEBouh06S6MlBe2kzQG/civqUJ
 jBl0sSF34H3DrwJ1owSQD/xdEpHNcheB/7qd13L/Eq8oa5dW8R/GAtNYYqED2aVta52o
 zBCvhKbx+NhM1KdwXOaItLc3JdpVqPBihLiOYUZihdJB3rk9p1IGt9bbDhYx3ZN1OZcd
 bl4k3uP9GFxk8wbKEJqjY8UiKf6SKWQiuHavKzwvWsdV2Hyi5cDVpxKfbHcy14bO/CFP
 M7QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9mGpW8UDyQlCjvDyJb4kyGNwlPnWzqn/fFumtofx4jYuq/e/SiXKzeVRSl7OcDQ6ScZLKsNVkVWD0@nongnu.org
X-Gm-Message-State: AOJu0YzvAKrO7vlLDPCUBYmWzk/Quhit71GtrNYWr2egxbxb6u1+Jzua
 Ufq/W70dG6QGD9/QYiyi0EAwENIybbU5jV88s+/SlkM1V1yXf0XaZVk6tKYvI7of/v/YSsjmZYP
 v1ujm4+Qm0KVSBgzDhtsCzhMyb2srsfdqiGOX3a5mLy9a2xOwQvMhD4CvF/hTcrs=
X-Received: by 2002:a05:600c:4f86:b0:42c:b80e:5e50 with SMTP id
 5b1f17b1804b1-42f777633f9mr19500275e9.0.1727865027914; 
 Wed, 02 Oct 2024 03:30:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUhlHhvZKYmIy8aOXdAMOaFHvvcoQm4a4E4dLiXjVNQH5fIQ2nxovGvoW0AoiFfzB3BMJVBw==
X-Received: by 2002:a05:600c:4f86:b0:42c:b80e:5e50 with SMTP id
 5b1f17b1804b1-42f777633f9mr19500025e9.0.1727865027494; 
 Wed, 02 Oct 2024 03:30:27 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f7a01f4fasm14805785e9.38.2024.10.02.03.30.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 03:30:27 -0700 (PDT)
Message-ID: <c03863be-2e55-423c-b541-73831b3ffa88@redhat.com>
Date: Wed, 2 Oct 2024 12:30:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/net_rx_pkt: Remove deadcode
To: dave@treblig.org, dmitry.fleytman@gmail.com, akihiko.odaki@daynix.com,
 jasowang@redhat.com, qemu-devel@nongnu.org,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20240918225128.455043-1-dave@treblig.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240918225128.455043-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 19/09/2024 00.51, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> net_rx_pkt_get_l3_hdr_offset and net_rx_pkt_get_iovec_len haven't
> been used since they were added.
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

Reviewed-by: Thomas Huth <thuth@redhat.com>


