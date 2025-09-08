Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B73CAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 14:16:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvceZ-0000LB-D6; Mon, 08 Sep 2025 10:15:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvceV-0000IQ-H9
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uvceP-0008U1-3W
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 10:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757340913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UqobEociHISGXHoPFrTuEaGE4lGnImZfZNTTfRNmsl8=;
 b=MAbztudCY0UYGLMNQMIgct26oBB0ftP/JSQs0NvBa06Pya1K0OFWBYt4nDrR99vsLp3Qqy
 tswvgThvDgbIKjrxlLVCBEYcKSqfpl5X89AKEVmfXMRjnoX/PwGPqxTG52FJytezoSROY1
 4YMrLMCaH78sdY+EkSES/jE6tLCLS64=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-s7bSrb9ONE-zhCW1bthSEQ-1; Mon, 08 Sep 2025 10:15:12 -0400
X-MC-Unique: s7bSrb9ONE-zhCW1bthSEQ-1
X-Mimecast-MFC-AGG-ID: s7bSrb9ONE-zhCW1bthSEQ_1757340910
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45de5fdda1aso4788605e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 07:15:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757340910; x=1757945710;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UqobEociHISGXHoPFrTuEaGE4lGnImZfZNTTfRNmsl8=;
 b=YurksH0TFaXkk+opoRPOJmp3KHYkaetNxxhEzcRqb8KsgdkTdRpvhU7Oz35JOdt0ni
 xISZMyqV+EbB447Mw3UMbSU28bg33P8tf7vr16ppMrCZekYpNF6wjsc35lYy8gOjh1wx
 x9oSRvrBvu8je0v6/jTdcdjk+ZciFbr191tOSRv9+oOmKFxvDGLkz0cyB1Ishgjm/cBG
 Lo9piEJ1ceYNczwC7HEQPWHT/yCBjfCfp6CnEQudejB7P0pK2DQRGTima2AIvrN9ZLky
 3JcTDT9wiS55ag8uHFi4hvyAjRx+4GAeRtmbHEbRQYLfRVh2DnsPOHMok5bkmH2iSXOa
 yLDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUxmQEyprPVHd4Es/nNWuiWtuhUDqLCUfYVWl2FxmdV+mEc2D5hKTHg1ifmhgrjAf2ZRyMl7x+6E7BS@nongnu.org
X-Gm-Message-State: AOJu0Yx6YaFc9RQF52VOHrZA7CH5Ph4A/7NdfopYhn6A7yw4S5N2rir3
 zDgUQKdaAclBqSJUCfkkcolal1tW+6kPiLRFtINzlF6irRJ46KXnXGhRuP0lVsCizy+mSnJIoaO
 L0x70aVB7/xFg4fFrimG+V0jxzUeyLt8mVl56qh/v9quK2fLluLKmNd5c
X-Gm-Gg: ASbGncuEAIL7joVvv7Ngd6X2ACan7fAxC2hvtQqZCljuzg6KiHlcLk29sVilUHNy2uW
 bHzO3Bi0HwU1h43d6PlMHrXYKrF5UO7RZg4Ec3dCz7JSKmjIY53rIAsmPfZ9vwGaheiE8NswMlf
 U+br+9H5DWB6APpCha7nYpTtMsJx5/1aMWtPGfi3ikjTzLs59Klrr9gO4VyRjow8j4aXu13ZfVL
 1BOVETPfiynPHcXtaia++5/3GEMeDw9IQ3u5KQMaKOH2/QHf+Ipps8rxAU1GnFTxCvk627Z9giZ
 okBEJa8Y4tSCocufiywZO6GZJNlyWiYo8QpfUdDEA/9f7rFMsW/h1U+BsWx44X0aXvu8uw+7ePf
 laCU=
X-Received: by 2002:a05:600c:5247:b0:45d:cf5f:cff8 with SMTP id
 5b1f17b1804b1-45de2028e47mr58266665e9.11.1757340910156; 
 Mon, 08 Sep 2025 07:15:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1ly88li0Mob/lKd02q/CS+HQZU8OunN/3HxCbN+Vijw/PzkuiH2lHj9iw8D8EUCf7xBagwQ==
X-Received: by 2002:a05:600c:5247:b0:45d:cf5f:cff8 with SMTP id
 5b1f17b1804b1-45de2028e47mr58266315e9.11.1757340909702; 
 Mon, 08 Sep 2025 07:15:09 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3df4fd372ccsm19922666f8f.32.2025.09.08.07.15.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 07:15:09 -0700 (PDT)
Message-ID: <0c15d5bc-7888-429d-84d5-b6d76ae8b1c3@redhat.com>
Date: Mon, 8 Sep 2025 16:15:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/container: set error on cpr failure
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>
References: <1755094667-281419-1-git-send-email-steven.sistare@oracle.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <1755094667-281419-1-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 8/13/25 16:17, Steve Sistare wrote:
> Set an error message if vfio_cpr_ram_discard_register_listener fails so
> the fail label gets a valid error object.
> 
> Reported-by: Cédric Le Goater <clg@redhat.com>
> Fixes: eba1f657cbb1 ("vfio/container: recover from unmap-all-vaddr failure")
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/listener.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
> index f498e23..5ebafaa 100644
> --- a/hw/vfio/listener.c
> +++ b/hw/vfio/listener.c
> @@ -574,6 +574,9 @@ void vfio_container_region_add(VFIOContainerBase *bcontainer,
>               vfio_ram_discard_register_listener(bcontainer, section);
>           } else if (!vfio_cpr_ram_discard_register_listener(bcontainer,
>                                                              section)) {
> +            error_setg(&err,
> +                       "vfio_cpr_ram_discard_register_listener for %s failed",
> +                       memory_region_name(section->mr));
>               goto fail;
>           }
>           return;


Applied to vfio-next.

Thanks,

C.



