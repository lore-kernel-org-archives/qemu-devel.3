Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BFC3CD98CF
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 23:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYBSa-0001Jk-9w; Fri, 12 Jun 2026 19:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wYBSV-0001JX-Au
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 19:38:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wYBST-0000K9-Jm
 for qemu-devel@nongnu.org; Fri, 12 Jun 2026 19:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781307520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8wdQzok3I/V8ejLSzcP7/1sVH4wjDG7aoCehjhLLEs=;
 b=RVZ2rXceoe5XzHUna1X0uE8ZQBkUGjcN8WSab3sjfMtQo4VDGBESfQvSA9bJb656GP+FCg
 ry0dqKxtV5/RoYdL6d6dqsPIbCioS4r0Dqpphjua1kstwTimo/I2kanVY6nyFj0YMxz5tC
 trHvHTSI4LRc5ltO932dQBSoibfHXZw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-MQOwNeRMP--d7rgj3_exAA-1; Fri, 12 Jun 2026 19:38:39 -0400
X-MC-Unique: MQOwNeRMP--d7rgj3_exAA-1
X-Mimecast-MFC-AGG-ID: MQOwNeRMP--d7rgj3_exAA_1781307518
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c0c20f7581so15439935ad.0
 for <qemu-devel@nongnu.org>; Fri, 12 Jun 2026 16:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781307518; x=1781912318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r8wdQzok3I/V8ejLSzcP7/1sVH4wjDG7aoCehjhLLEs=;
 b=VNVe/d4fiaHSoQkKIqM8v4ScmLEzLUWXBriN9r/wh6zrDbutzd/uME1w8cfg6qsLZH
 8j2CGuIwfhc1C+fGsRJNAbsdUWqVQBl773I0RX3CZ/dHoZLCIZBWtyvlSDnc4l3RXPrE
 SL11ys7Qvb7wBV9ug1QY6NNNujX6rLR6nRGcEvCdxYG5SbFzWMYrPR12tELVzu9IggqL
 9b+u3FOUkyaDPtJBHzw6vO992tWa6ZQ0nTXHq4Br8yKpeO8Ob6rNs8a/81UFZ/zM7lTy
 3gevhfpDw1sx0qGvuOL7WgrACTqo8SnHUm0TcwYdfUMwE5393yCcHxkVOtG1yOEguXcK
 Kx2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781307518; x=1781912318;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r8wdQzok3I/V8ejLSzcP7/1sVH4wjDG7aoCehjhLLEs=;
 b=Nd0xSNUGdX2z4kZcktDblHaijPAkLDleA88Dj12N9oUz3MdqWH5kY7pcNzX5nCbu4S
 fk9xNvTrXQI3fc62yk20vihOYt35/oQDE4t4R1wsABB6vnpXAS7LG8dXlucrlzlmMZlC
 wqE2wYGG82/NCpOpI/KXnOZPIxXFOxvinz51I1nJyhJXO9aovz+pQbESd82UqpDkJ212
 PO5MqHbrHH0xgIFb6jXfum9l4dGqpDyVmh7WXHRy7X8Ah69FtJwYC7u10k4UnXjPPacm
 3XbqtgtMy3RFIA01ZqGskLyGIP8fJf9pM6caMcc5u4yA6zxx7YrSEM0J5/TeI2NBHjWQ
 BlEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9UYPqPXvPX/90IZfyKfAlv599/aRknsQxuWeOSQM1iG+ZBZcsUR+WU5zOWhyyefRHUzwQoOW+53nL/@nongnu.org
X-Gm-Message-State: AOJu0YxxGp4XFE4A2iAUY2GomUoLZEyrs5UDtID4m5zVXj/hM5GBD05f
 4L6zGWugo8641RJXPMuz/fABVVaacqKjCaAdyapXP7/ngxXOl185DrefK2r4TSq+mNh7jjXvAML
 ycENgK1C0daxPPWQgYhwbQXTSOgJqdx3PfSHDnvW0eM6uE4rac/p03+qJ
X-Gm-Gg: Acq92OHXdIfavvvMqQ8+ju68DufQGe0441bI8bVH2Y54Dqwr/Mm9Z9CF9RMfLcR4LUH
 pRZNbKkeO8jVv3yJZ4M3z1V1IMcSqYdSn4QMi3gAJMMciukPRXyjcZ3TUJqD0cPm0VVIsA43ynR
 ZQxjbHIpAIs8P2swXlP/ngpLq/w3hlelvhcgGnMFeVnR3GMzLRCqGeyravZNquNlBy4atUgNDhD
 r+ZrM2Yb7V2bfRdQab8tW+R7z27Ho8/X+1o5unVUXIOCfMr9jxhMrtfPhLThs+sQwU60YUIynOz
 bE4mbM5Dc9vs4mh3sAm9xhztENU56evjHOEjs87sNKePIcFrnFEpQ2ag/SQQAoV/jKGeNKvdLJx
 OtzhPOCAsOu4X1v5JzceqZmW6ak/CELN4yfmsn4u+hVin6ySog0mVTFa3xshHjOby
X-Received: by 2002:a17:903:2cf:b0:2c1:6715:a4ea with SMTP id
 d9443c01a7336-2c411f73a6emr57357515ad.30.1781307518104; 
 Fri, 12 Jun 2026 16:38:38 -0700 (PDT)
X-Received: by 2002:a17:903:2cf:b0:2c1:6715:a4ea with SMTP id
 d9443c01a7336-2c411f73a6emr57357315ad.30.1781307517639; 
 Fri, 12 Jun 2026 16:38:37 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c42fca9f44sm36715305ad.37.2026.06.12.16.38.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jun 2026 16:38:36 -0700 (PDT)
Message-ID: <3490ea2e-2c23-41d1-a12a-a8202e67d428@redhat.com>
Date: Sat, 13 Jun 2026 09:38:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/net/e1000: Use address_space_stb for Rx descriptor
 status write on aarch64
To: Liu Gang <liugang24219@sangfor.com.cn>, qemu-devel@nongnu.org
Cc: jasowang@redhat.com, Ding Hui <dinghui@sangfor.com.cn>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260527091711.3901-1-liugang24219@sangfor.com.cn>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260527091711.3901-1-liugang24219@sangfor.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Liu & Ding,

On 5/27/26 7:17 PM, Liu Gang wrote:
> From: LiuGang <liugang24219@sangfor.com.cn>
> 
> In x86 environments, writing the Rx descriptor status byte with a single
> pci_dma_write() works correctly. However, on aarch64 with glibc 2.24+,
> the memcpy/memmove implementation uses a branchless sequence that copies
> the same byte three times when count == 1. This results in three
> consecutive STRB operations.
> Ref: https://sourceware.org/git/?p=glibc.git;a=blob;f=sysdeps/aarch64/memcpy.S;hb=refs/heads/release/2.24/master#l124
> 
> When the guest uses an e1000 NIC and DPDK, this behavior can cause
> packet reception to stop or packets to be dropped repeatedly. Under
> normal operation, DPDK clears the DD flag after processing a packet and
> then updates RDT. But due to the triple STRB from memcpy/memmove, the
> DD flag may be cleared and then immediately set again. This causes DPDK
> to consume the same packet twice, making RDT be incremented by one extra.
> As a result, RDH == RDT, and QEMU mistakenly considers the receive
> queue full, stopping packet reception.
> 
> The issue can be reproduced on aarch64 using the adapted test program:
> https://github.com/cdkey/e1000_poc
> 
> Replace pci_dma_write() with address_space_stb() to write the DD status
> byte directly, avoiding the problematic memcpy/memmove sequence and
> resolving the issue.
> 
> Fixes: 034d00d48581("e1000: set RX descriptor status in a separate
> operation")
> Signed-off-by: Liu Gang <liugang24219@sangfor.com.cn>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> ---
>   hw/net/e1000.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/net/e1000.c b/hw/net/e1000.c
> index 202ad40401..f7be035e0f 100644
> --- a/hw/net/e1000.c
> +++ b/hw/net/e1000.c
> @@ -869,6 +869,14 @@ e1000_receiver_overrun(E1000State *s, size_t size)
>       set_ics(s, 0, E1000_ICS_RXO);
>   }
>   
> +static inline void
> +e1000_dma_write_byte(PCIDevice *d, dma_addr_t addr, uint8_t val)
> +{
> +    AddressSpace *as = pci_get_address_space(d);
> +    dma_barrier(as, DMA_DIRECTION_FROM_DEVICE);
> +    address_space_stb(as, addr, val, MEMTXATTRS_UNSPECIFIED, NULL);
> +}
> +
>   static ssize_t
>   e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
>   {
> @@ -980,8 +988,8 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
>           }
>           pci_dma_write(d, base, &desc, sizeof(desc));
>           desc.status |= (vlan_status | E1000_RXD_STAT_DD);
> -        pci_dma_write(d, base + offsetof(struct e1000_rx_desc, status),
> -                      &desc.status, sizeof(desc.status));
> +        e1000_dma_write_byte(d, base + offsetof(struct e1000_rx_desc, status),
> +                             desc.status);
>   
>           if (++s->mac_reg[RDH] * sizeof(desc) >= s->mac_reg[RDLEN])
>               s->mac_reg[RDH] = 0;

Could you please try the following series to see if this issue gets fixed?

https://lore.kernel.org/qemu-arm/311f0568-facf-49de-83e8-7844f5c60e29@redhat.com/

Thanks,
Gavin


