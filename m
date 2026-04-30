Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55347FF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:51:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIO2h-00054i-3j; Thu, 30 Apr 2026 05:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wIO2d-00054A-PB
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:50:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wIO2S-0007hX-MZ
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:50:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777542627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MDnV0AY4VlGUr+gAszDJ3VsPdCUUQsGfr2dowpSPiYo=;
 b=chKQP5EJW3L24cQ8I8Had3O1ugpKhxvKxjABK7+ICE17V7TBzbNfiuscykaWAX2IkXYBwx
 3TQ83U5Sn2dG7esmRua9h8+50qwfTDG4kU5145kNptC1q3sCsP4DBg0raHXKGuB66WeWHI
 RdjR0c8gttPRYE+gdkf2otqUQzIm6j0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-O0JDIPSDNOOkah-UFWjKNA-1; Thu, 30 Apr 2026 05:50:25 -0400
X-MC-Unique: O0JDIPSDNOOkah-UFWjKNA-1
X-Mimecast-MFC-AGG-ID: O0JDIPSDNOOkah-UFWjKNA_1777542625
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b49424ad88so1222456d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777542625; x=1778147425; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=MDnV0AY4VlGUr+gAszDJ3VsPdCUUQsGfr2dowpSPiYo=;
 b=LRfbcLaBB0WWyE6YZXsqC/esXysmm9ypKEKMo/UpNb3rG2i2WUxG/wFg0KnR7ZDj5s
 pWgRkBsedm1cNBNaJYzYmHNi9s74ECg15LQ3EgfEix64brHPv562trFYcTJEDnf/G+sI
 H03wTbe4XSmjkHmb2U80n+cCb7Bl5P2kfxA2FZwafEhtrUvVyqlqfog7BxOkQwL3MRuQ
 Nb7Xov9cqeMFKCnHlOxdrpfjnmtnAm3KVzmaG7PIhS4OrBzEooqkdBGQj7JsSu/cORBu
 oDfXWsXDxqfSHtP4ss9XigxRHZCMz3kYPPEUQ8nL1RsUa1FPSQ8F2tKDsd67vsgUcirN
 n9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777542625; x=1778147425;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MDnV0AY4VlGUr+gAszDJ3VsPdCUUQsGfr2dowpSPiYo=;
 b=GKVanqE6aYKAcEVm3d6vWApvkZbohGM9V7CcAhJTcWGxJmBc6MLqypVfFv+PZ6QR0o
 4fFHs6/22pgrGWMJDc1bw5sJwLXyE2Vrk7il5AlGBHq3s99UMkAB+ydKFYsRj/gXAzqb
 8ZRI/JKoK4euLrVzquUmWGf8FGsSkx8vgbVWaWP+eAabKg8BBJYDvnS6ZXDw2BzXBcqi
 Y9+P4A/uRwW0ZDu7JZgDCEUOBTqYW9m4A0Nbg4KgZFYhfnyGbr6PYxuGs7465wAOD7Im
 xzFdqsLkbn2LT9STqFN9ei76etycXlhRFXuhNJLR+2N3KfMV7lec1m0KdJWGSgxZD14V
 J6Wg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8R4aaUvdY+O7y6XN6Hp4D0WTA87fWKNbnv+qTYsmV0yexSuZ5vfhRl9uNf7L3VPWan57ivvh1fmiR2@nongnu.org
X-Gm-Message-State: AOJu0YwPYysy+cJgrAMTRqiYLh60RW/091DFHtX20Ac8wIBk9lMvqZsG
 f1d/aC0eb7M8UqUc2ub6Wmab+4z4zg93yhxG7HDqhyhGDEkzjCfGSaR+mbRKfExEmdVVy2Ih9ba
 D7UYaZfSFDOd/OExhPKAkDtpSmqN6XHGSg/g/ddrrL0r6vo9MQZNvnrWz
X-Gm-Gg: AeBDietzATK3LeNRYT36qpXoi5BG9EJ2u0nxAc2edYJAoz/572ay/TQI2mz1CEhBsWI
 IgL1OzOGLCDJ/p1rWBJXzMAl0ZTd8hsFJaYeNx5cllDXqjWvBh1ilVvuzCtL+n+LRBsWn1ZvE0y
 TqRwGXawPdJBW0f775dgl2Sbm4TzRaDDwqsbipWTRFHpOVk7B3IxhtjRfQM4UylKAqpUTJT5n+B
 VJ0Ap3r/X4Aaz+IBML+6PQoLc5pT22OVzh+a5TLzfWk7YhiYoCeiMZTguTO6SLQJUocGlSUwnpl
 mmMISxuFroVhh0Ji8W3dfkLzWX5zScA7LBExw27WxhHIHbFnUPli/5Gw6kVykn8p0wQnyOglHZz
 EgR/wwLtbxqnreVT9dqy02DQbP3orfkfSZRlfkOKM8qOUp6HJrkeaVaDKEQ==
X-Received: by 2002:a05:6214:3d0b:b0:89c:5110:751a with SMTP id
 6a1803df08f44-8b3fecf1fbdmr29745546d6.44.1777542624604; 
 Thu, 30 Apr 2026 02:50:24 -0700 (PDT)
X-Received: by 2002:a05:6214:3d0b:b0:89c:5110:751a with SMTP id
 6a1803df08f44-8b3fecf1fbdmr29745066d6.44.1777542624093; 
 Thu, 30 Apr 2026 02:50:24 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff32ee6asm13743456d6.19.2026.04.30.02.50.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2026 02:50:23 -0700 (PDT)
Message-ID: <00c4ab4b-a58b-4de4-8e41-566b2cb7f920@redhat.com>
Date: Thu, 30 Apr 2026 11:50:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/sparc64/sun4u: Mark unusable PCI busses as full to
 ease device plugging
From: Thomas Huth <thuth@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Artyom Tarasenko <atar4qemu@gmail.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20260309181452.83702-1-thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260309181452.83702-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 09/03/2026 19.14, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> When trying to plug a PCI device to a Sparc64 machine, you currently
> have to specify the right bus ("bus=pciB"), otherwise you get this error:
> 
>   $ qemu-system-sparc64 -device virtio-scsi-pci
>   qemu-system-sparc64: -device virtio-scsi-pci: PCI: no slot/function
>   available for virtio-scsi-pci, all in use or reserved
> 
> This is quite annoying for the unexperienced users, and it also breaks
> e.g. the iotests ("make check-block") when running with qemu-system-sparc64.
> 
> Mark the non-usable PCI busses as full now, so that QEMU can automatically
> plug new PCI devices to the right "pciB" bus.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   v2: Do the change in the machine code, not in the sabre device
> 
>   hw/sparc64/sun4u.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index b8bda1eb816..37539535c6c 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -723,6 +723,13 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
>       fw_cfg_add_i16(fw_cfg, FW_CFG_SPARC64_DEPTH, graphic_depth);
>   
>       qemu_register_boot_set(fw_cfg_boot_set, fw_cfg);
> +
> +    /*
> +     * Mark internal PCI busses as full so that the plugging of additional
> +     * PCI devices happens on the right bus that still has free slots:
> +     */
> +    qbus_mark_full(&pci_bus->qbus);
> +    qbus_mark_full(&pci_busA->qbus);
>   }
>   
>   enum {

Friendly ping!

  Thomas


