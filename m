Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8567BC624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:49:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x26rp-0005oR-A5; Thu, 03 Sep 2026 08:48:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x26rn-0005oF-K3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:48:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x26rm-0004VS-2x
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:48:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788439708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T8CcZdE6GTyDprr0Z7IKHPLZ/8a/zNryxtIPGfg1/MI=;
 b=B1j/NBenW7O0qpF/FZd56ghyXEEgmUTea4pYhClGe2fEgZ194X/RrL1ZU8KAZ61I6DzbLs
 vUHkifgoGevtmADQCJHo7KGif1bJBQu/++rR/xcsVad2BeM2jZTX24uX4mqA7QQcYk8LwK
 4eecfMhE2zUq78jsRvbyQfNabIZJjn0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-7xPh15MOMamTAv1ohbJidA-1; Thu, 03 Sep 2026 08:48:27 -0400
X-MC-Unique: 7xPh15MOMamTAv1ohbJidA-1
X-Mimecast-MFC-AGG-ID: 7xPh15MOMamTAv1ohbJidA_1788439706
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-499b99a8a10so7499635e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788439706; x=1789044506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T8CcZdE6GTyDprr0Z7IKHPLZ/8a/zNryxtIPGfg1/MI=;
 b=Mpx9x38JI1fDhBaX1O9KtNq9AUW9g0sdrfbAkflWYHlM0ObwlOodqs0jsoVwMzVN6q
 KYXI552n70dSa/wzw9vK1yGiQz3OQwnD5jglUSNNosxGh18Um15wQdV8or7vguPqdZnu
 kMISKofuF7Pe9ZHS0Qm0j/j4d3jBMDQ0vNGtijg8WFOpnQRZQpYR6oqcCm48fi750jHP
 GfOqIOgddpsKsjM/xbHmOMEGXJ7FczUaUkc4tE4jaUlm3KkbMfAm9RHSsQEoETQbMpsg
 YUCMBH7GxwAxghX/ZrMBVIKySWcY7Rf8iBAV5s6fguPkXJwjnaKGbP/c1LZVThw63qbx
 zwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788439706; x=1789044506;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=T8CcZdE6GTyDprr0Z7IKHPLZ/8a/zNryxtIPGfg1/MI=;
 b=O6osX8XzMbfaM/4aRLWW9ocYETN2n3EDCrOugJ0QRa2wW9ZZX9TFcm7MQEn4sWkGAg
 DEiR1vVQuxcMPMQsBTDhYyh74YZ7Lqg2sKYzuQcU1/FFV8TA8RrJRvXAL0lz0GXwr4Ed
 d4faVu9ukOC594wQZ+oMVdV5x3+A3Vgh8RTbRSapMTOIk8s/0tdoi6W1FsB6Z1swuGNx
 6L1sjHF+5H6/y6roIwEmoT+B+JEMn6xBbwt0uZCKOc5VLR/fUqlcnv6WsvSFko7oQQMl
 TjlPjR1WztSH4NplDUt+baYF0vxgkYS7Z2eedDpeDl+znmG+K1Wf/J0G71izs3yNcAK9
 ZidA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxjgGp0hbxnPWpLaZaAk2tk8rk9MYG+9in0ZwU+G0ND584zMGGULv21S4pd0gUYGd/XrZWczWDUtPi1@nongnu.org
X-Gm-Message-State: AFuF++neNFOsvTXudQ7xoTBIHzKC9X0TxgXUaVPdbX1vg/6dkHMuKf8m
 MpmfXTRsQXRIAKxutE230feWJnRhRqSjHuYAQ/bBPd3RJ83JwGRUfhXY9S11G1IBfo8gV9BS/4Q
 rbBUsE0+GL3hfQT1YfLzSD/02q8NV7PJNoxiEFk24di4nFAnpNx+CfwbV
X-Gm-Gg: AYBFou1I1GjAwA2hXKPq2C1fMruqtFfGppa8QY0tq6An5JS7Mz3tHvaOvmrRAZrUEVC
 9jRc+Q3sNW8F9l7tPa/cdouA0uoy1HyATqeGrvDDpKsMEmc/NabXOM/bitDvhCbwHJHCE9GVYRr
 nVsceYhz4y17HAAU1k6D0Ks6WE5b8xTAXXs6ckAxnO7M+dYHgSsluvqiAoyCIxW01Jd0uFbvd6R
 w9etLjdh41hf3H4KMLngCiNNo6h//iENsIrFtbc/PqwMKVXf4S6wxjL7HTSRBkgfQ7/ULVW3lAC
 kDSXcDIn358rL1GCxhmFSbHhvMlPsfUkH6+IcGeM17QMrfY32ZDvjohPn/O/wusjpWTgFiRAJhN
 6BfnmwxCylx//waKd5Fj3udxBzwZ5AUVDXAAiPMg=
X-Received: by 2002:a05:600c:600b:b0:49b:90bc:d4f3 with SMTP id
 5b1f17b1804b1-49cee5d6287mr57664115e9.4.1788439705891; 
 Thu, 03 Sep 2026 05:48:25 -0700 (PDT)
X-Received: by 2002:a05:600c:600b:b0:49b:90bc:d4f3 with SMTP id
 5b1f17b1804b1-49cee5d6287mr57663555e9.4.1788439705421; 
 Thu, 03 Sep 2026 05:48:25 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:1292:d530:bf4:da16:e208:c6bd?
 ([2a01:e0a:1292:d530:bf4:da16:e208:c6bd])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48448e80388sm15371880f8f.14.2026.09.03.05.48.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 05:48:24 -0700 (PDT)
Message-ID: <61fa37dd-1ed5-45a2-8a63-9fedaef45bd2@redhat.com>
Date: Thu, 3 Sep 2026 14:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/igd: Add device ID support for Meteor Lake and
 Arrow Lake
To: Yuan Wang <yuan1.wang@intel.com>, qemu-devel@nongnu.org
Cc: alex@shazbot.org, tomitamoeko@gmail.com
References: <20260825090435.1492485-1-yuan1.wang@intel.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260825090435.1492485-1-yuan1.wang@intel.com>
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

On 8/25/26 11:04, Yuan Wang wrote:
> Currently, igd_gen() does not include the PCI device IDs for Meteor
> Lake and Arrow Lake platforms, causing it to return -1 for these GPUs.
> 
> As a result, QEMU calculates the stolen memory size as 0 and exposes a
> zero-sized 'etc/igd-bdsm-size' entry via fw_cfg. When OVMF boots,
> IgdAssignmentDxe fails validation on the zero BDSM size and aborts
> without programming the ASLS register. Consequently, the guest Intel
> GOP driver fails to locate and read the OpRegion (ASLS remains 0x0).
> 
> Add the device ID prefixes (0x7D00 and 0xB600) to igd_gen() as Gen 12
> so that stolen memory is correctly determined, allowing OVMF to properly
> initialize the OpRegion and BDSM for the Intel GOP driver.
> 
> Signed-off-by: Yuan Wang <yuan1.wang@intel.com>
> ---
> v2:
> - Resending because the v1 patch was sent with an incorrect future
>    system timestamp due to an unsynchronized local clock. No code
>    changes.
> ---
>   hw/vfio/igd.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/hw/vfio/igd.c b/hw/vfio/igd.c
> index 413a49aae9..a0b6b34d81 100644
> --- a/hw/vfio/igd.c
> +++ b/hw/vfio/igd.c
> @@ -96,6 +96,8 @@ static int igd_gen(VFIOPCIDevice *vdev)
>       case 0x4C00:    /* Rocket Lake */
>       case 0x4600:    /* Alder Lake */
>       case 0xA700:    /* Raptor Lake */
> +    case 0x7D00:    /* Meteor Lake / Arrow Lake */
> +    case 0xB600:    /* Arrow Lake */
>           return 12;
>       }
>   

Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


