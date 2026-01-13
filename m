Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15401D29DDE
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 07:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfYsw-00078c-6z; Tue, 13 Jan 2026 02:32:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfYss-00077g-Pv
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:32:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vfYsq-000731-LW
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 02:32:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768289528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Dnw964J4Yl/DO4fJq4h+2o3K19nn454pRUG5hV9gays=;
 b=dOAAq637txk6fjyd89fRD3QYB7AHrItvOcpSwphjlOqMYCc4MYUE/T0npUtIp++MdjTkZT
 pyCaryLS5DvbvpeUGp3Rv3R1Sgc89cwugrI89A9D7S2sPSK+rnuc8wU65/zTRfRYMQ+csW
 IUNvzunITp9cge9OIhIEwmytymZZK2s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-V_Ep8JkiOgi5BOVjUwHYlw-1; Tue, 13 Jan 2026 02:32:06 -0500
X-MC-Unique: V_Ep8JkiOgi5BOVjUwHYlw-1
X-Mimecast-MFC-AGG-ID: V_Ep8JkiOgi5BOVjUwHYlw_1768289525
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43284edbbc8so4856593f8f.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 23:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768289525; x=1768894325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Dnw964J4Yl/DO4fJq4h+2o3K19nn454pRUG5hV9gays=;
 b=YgoTaGKER2yMCWWdKgNzi1T7xUafL/PZWi2v5KxzHI288qlLYCrUc7i+tImsob5ndT
 KwrBUODdB0748lJ6TCAqyg32I/mWHwVIJktHgBW7dAza0ue54MhaJELWwxW1cFwf3+IK
 F5CPKSs4N4z/FyMyboBRq/TPX5/Lmhe4rzQpB/nRU1AnOdMm3gM19282targXZkUV74K
 9WNTTfeZVWOK7imW9L41nQoq8xAEeZRFcB5EfZ1XvzJUejsQQCdzr4vunBq0E6AfXYBN
 Ij1uGVJeI6fEkV50t9/19f1hsdzBnUrp9UgKZt+vUfp9x5kH2p59psUJsZGJMf4h0E2i
 vxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768289525; x=1768894325;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dnw964J4Yl/DO4fJq4h+2o3K19nn454pRUG5hV9gays=;
 b=ZXBfaM4M3NO+qXp3CHtguipUqquf90KUdl9uX0HiDRLAT/ALZu9PEb0/v9NP2tqVk3
 2ALqa2Fajpn7k/Jwy9T0dTQTB2o1HBVKC20NDNjdFWa7+cdMKlvOUh6vxhYWiCP+o/on
 zMiAUPPFlJ6HdG+FawKYfRDvKn5vfFb/kUPECgz66xv1jj7iAwvAL4kQSghcX0skvJcM
 B7JW3VETYY3KB4WGvIzpx3YoJba8wsZDEtIxAj/ZPIS71W2b6fUYvvKXul2rqEJEXvqN
 By8R2A4RVHsuRHEj9X6XLSaNSc9il9mybsLvVNtWOdpDRdGZiiP2r3JHVW+d9F8zIbjC
 7Gwg==
X-Gm-Message-State: AOJu0Yx/XKqvicy8SYHvRkJ6q/x3C4kDOL9Ty+8WqS7l2/hpe8R5G+Jb
 wjpGQ7tkYVbX4fb1GbXnUAA5mRS+ke40OPIsdXDQs22+Osa3oDDwaqqRVsgSbuzWfDu4nyAAYHn
 hp2ua4bbkn/54Ph+MSJ75jnM5qTpbl+otW1bSb3gW9xNziw99xtYIuX0OF1DYUox/ZuXx0D6AB3
 OwYGrIk/DSxBszFMqj6xTC7gAbKD/2HhbG7Q==
X-Gm-Gg: AY/fxX7310n3ZFoAIt3+z4WNmb+F3GOeOL6TYrYCKxCx2badydOsRwRUGKI2Trj/Juc
 SABcIVq2iibZlbL69RnVgaGKkywSu8fM5Q4oZcSuUDUQSSn5Kkv6nES7Bpq7LUXff9Hi2tDckbJ
 jB5Sm/YQZucAtXWP2FFK9skFKwl4JQ0VNGZiYs+QKd8I9sZAmiCxMW4Q4ni+JKfqbozoTkicnL2
 NJ/hBKKB/RZ+dDQR626i7KdYlTCXxe+GzzXfwX3ZecANnnhxSJLvPIGdqK+1IK2z2etNZgG95+b
 +Dj8Wk6SzjSPrkrIY8JmIzTiRMR/QjW5jYT98pD7YJoGMvxoZ4hp4ktnyHQN0DSGu+nC1IRBTYn
 19g2PxL2YMRqHb5QRQrHj35giGiaedf5yhXU4rpRXsGSesx2H
X-Received: by 2002:adf:f20e:0:b0:431:3a5:d9b2 with SMTP id
 ffacd0b85a97d-432c37c87aemr20180323f8f.39.1768289525077; 
 Mon, 12 Jan 2026 23:32:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IECkwSwx6X2ClJzzqAN27YBT1EExOJR5oDzqO+F1zoa6ZNyN66PprymKi6KA8TqM7BWAUxEdw==
X-Received: by 2002:adf:f20e:0:b0:431:3a5:d9b2 with SMTP id
 ffacd0b85a97d-432c37c87aemr20180290f8f.39.1768289524629; 
 Mon, 12 Jan 2026 23:32:04 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee5e3sm42287444f8f.35.2026.01.12.23.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 23:32:04 -0800 (PST)
Message-ID: <deb51dac-c73c-4363-8ebd-eb9be52e9492@redhat.com>
Date: Tue, 13 Jan 2026 08:32:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] include/hw/hyperv: Remove unused 'struct
 mshv_vp_registers' definition
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
References: <20260108185012.2568277-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260108185012.2568277-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 1/8/26 19:50, Cédric Le Goater wrote:
> The 'struct mshv_vp_registers' definition in hvgdk_mini.h is unused in
> QEMU and conflicts with the canonical definition in
> linux-headers/linux/mshv.h.
> 
> Remove the duplicate definition to avoid build conflicts when the Linux
> headers are updated.
> 
> Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   include/hw/hyperv/hvgdk_mini.h | 7 -------
>   1 file changed, 7 deletions(-)
> 
> diff --git a/include/hw/hyperv/hvgdk_mini.h b/include/hw/hyperv/hvgdk_mini.h
> index d89315f5452fd565469bbfc98cacb226b71da13f..cb52cc9de283bbe4201357127c2eb1b0b37e4cab 100644
> --- a/include/hw/hyperv/hvgdk_mini.h
> +++ b/include/hw/hyperv/hvgdk_mini.h
> @@ -450,13 +450,6 @@ typedef struct hv_input_set_vp_registers {
>       struct hv_register_assoc elements[];
>   } hv_input_set_vp_registers;
>   
> -#define MSHV_VP_MAX_REGISTERS   128
> -
> -struct mshv_vp_registers {
> -    int count; /* at most MSHV_VP_MAX_REGISTERS */
> -    struct hv_register_assoc *regs;
> -};
> -
>   union hv_interrupt_control {
>       uint64_t as_uint64;
>       struct {

Applied to vfio-next.

Thanks,

C.


