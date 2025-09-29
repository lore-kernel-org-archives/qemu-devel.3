Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AEBECAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:15:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3GWs-0005Pf-Um; Mon, 29 Sep 2025 12:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v3GWn-0005Fe-99
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:15:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1v3GWX-0005aC-Fu
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759162486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NUkJpAi+5zoNIw298nQlQL7IEQx3EAGpQw+h35LnknU=;
 b=Qm1gGGQNbZOZ7GCWuX2zng2mOK+yF9kRxMavWNDG2UzVdnt5Wv6z8kP8/l2s+uAdk5NUxR
 rl+y7CNXzyWtcvK0BjG0hGdHsB161/PihTvJY4PeA0M+ORwSm/Eh3Tc0AN7iBRd/INQpyh
 qs+Lpf+ISrmVy1MG2YOTPYVPbNJH/EQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-oHFgtRb1N7-EdpHITfN22Q-1; Mon, 29 Sep 2025 12:14:43 -0400
X-MC-Unique: oHFgtRb1N7-EdpHITfN22Q-1
X-Mimecast-MFC-AGG-ID: oHFgtRb1N7-EdpHITfN22Q_1759162482
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3ee12ab7f33so2591282f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 09:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759162482; x=1759767282;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NUkJpAi+5zoNIw298nQlQL7IEQx3EAGpQw+h35LnknU=;
 b=MbtfptlCmiD8a1lPO+TqtttaXFyNhustImbgtdpZsQNj8UcP+UBYFp7jX4k6gIcyGJ
 y2pQM0BjDEJG+4Bq6QelDDCU/VxkTSlwlY/d+2myFSPugUOFcSUJWg/SAb4zT8wpNs96
 Lu8NAqflYv2FLnYxQaEGReeRx+83Ukmu8HLczfX2mBiNrUusixg2GaWi8SNniW3cLHK6
 TXD55ENNkXoZXKn3pZ2EChkG8RbQF4WTSburL0bfMDx+dz3uWzLW76k12Iem9tGwbkA5
 yvlbzVHl7GUbl7TAzPI9QVoHZNH1H2qTCsUM8rz9LwTQeHgiYM4Yv0syWjQGLK0gAbZv
 22IA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0sFHkVHIJR8EXEqwlHR+jmbrPAa+BD9sr9SMqwRoxBdU7n3INN2lFcpG0nwk2oXVljEX+A3sTtDIe@nongnu.org
X-Gm-Message-State: AOJu0YxrNSw7/yLm/IbG7q5McDp4jGkjgY5eBL4gIxEti1m5ZlpKLtGZ
 pR4asmUf6+XZPjhjriMEriHVg9eOAzJbVgqqCoLZDlfFKmR2ffVHSaS+viWZ/fsTwCzpaR+qko7
 GyWAY0NAmvllB+DMDKc5aUsfUZnZdeuLNKkpBrgAXG+uU9gp4lIsZIEhI
X-Gm-Gg: ASbGnctMaUuG8awJY0vbtffPVqyC27Oo+h4vboCsEODq5ITHRn8LePuLYHjiZAsdKQM
 PV2LehJW6RZdhNgwxau5jS3V9MSgcnbCOZp3Fc2syFJuBaH2I9wDOVi98T5I5C762szpNnrelco
 02sOp2uyfen3FwDgAe5clPDLWzfOzEMGh4BVerAuR+yL1MvJ+TCeTNyqcwF6r4BqgyVBxlVOjuS
 YjMT+7Y+QSI7G0OjggTV/FfUDV9bdcEqwqAiighoRR6GTDVlkj1v3UZl0TdpnsuS/dhmVnugVUj
 iAyZ9mxJ1vIyIP7QJ41QFpyWpoprIpgId2BPk8DPNagLwQfEkzOPVbIDD2iZGz0XOTP2MKA8HOy
 8q2o=
X-Received: by 2002:a05:6000:2f87:b0:3fe:4fa2:8cdc with SMTP id
 ffacd0b85a97d-40e4dabf3f7mr17238367f8f.60.1759162482314; 
 Mon, 29 Sep 2025 09:14:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFl2NUt5k0dQFzKvF6ywfCjTTjkzWaY0iklubmmuCg6GK2Tw7hrBDrndt0oVhRsX1xXyqQy+Q==
X-Received: by 2002:a05:6000:2f87:b0:3fe:4fa2:8cdc with SMTP id
 ffacd0b85a97d-40e4dabf3f7mr17238340f8f.60.1759162481864; 
 Mon, 29 Sep 2025 09:14:41 -0700 (PDT)
Received: from ?IPV6:2a01:599:901:4a65:f2e2:845:f3d2:404d?
 ([2a01:599:901:4a65:f2e2:845:f3d2:404d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5603356sm19194223f8f.30.2025.09.29.09.14.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 09:14:41 -0700 (PDT)
Message-ID: <0ac79b25-5ce6-4879-a49a-46c4d6ba19d9@redhat.com>
Date: Mon, 29 Sep 2025 18:14:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] include/system/memory.h: Clarify
 address_space_destroy() behaviour
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20250929144228.1994037-1-peter.maydell@linaro.org>
 <20250929144228.1994037-2-peter.maydell@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250929144228.1994037-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 29.09.25 16:42, Peter Maydell wrote:
> address_space_destroy() doesn't actually immediately destroy the AS;
> it queues it to be destroyed via RCU. This means you can't g_free()
> the memory the AS struct is in until that has happened.
> 
> Clarify this in the documentation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/system/memory.h | 11 ++++++++---
>   1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/include/system/memory.h b/include/system/memory.h
> index aa85fc27a10..827e2c5aa44 100644
> --- a/include/system/memory.h
> +++ b/include/system/memory.h
> @@ -2727,9 +2727,14 @@ void address_space_init(AddressSpace *as, MemoryRegion *root, const char *name);
>   /**
>    * address_space_destroy: destroy an address space
>    *
> - * Releases all resources associated with an address space.  After an address space
> - * is destroyed, its root memory region (given by address_space_init()) may be destroyed
> - * as well.
> + * Releases all resources associated with an address space.  After an
> + * address space is destroyed, the reference the AddressSpace had to
> + * its root memory region is dropped, which may result in the
> + * destruction of that memory region as well.
> + *
> + * Note that destruction of the AddressSpace is done via RCU;
> + * it is therefore not valid to free the memory the AddressSpace
> + * struct is in until after that RCU callback has completed.
>    *
>    * @as: address space to be destroyed
>    */

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


