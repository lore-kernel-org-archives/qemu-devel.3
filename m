Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E711C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 18:42:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdBV4-0003BB-Od; Fri, 26 Jun 2026 14:42:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBUz-0003Ae-R0
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wdBUy-0002JC-6i
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 14:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782499313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=FmNj1WmEmAwRhq/a26fEtDH3y29gcjt0IVbyfDHmEiw=;
 b=FzcHOxJjvuhonOC77MIqX4scJeSpKzgV6nhFYM3uzQM8gY8tCcbUyTdtkSi3Fjb8VShmQT
 /hFfRaD5KNfCq+ga+RHY7/6HhXrNtuvQJ7dvjX0pgYvrDsQ5IOPM3io/azZNnLFmub/RMj
 nFHpOJhT87UN0SXRz5Iz9SifCiJ3wOU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-8WqBRaO_N_GXPR0E_xBd2w-1; Fri, 26 Jun 2026 14:41:51 -0400
X-MC-Unique: 8WqBRaO_N_GXPR0E_xBd2w-1
X-Mimecast-MFC-AGG-ID: 8WqBRaO_N_GXPR0E_xBd2w_1782499310
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4629f312a67so1055273f8f.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 11:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782499310; x=1783104110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FmNj1WmEmAwRhq/a26fEtDH3y29gcjt0IVbyfDHmEiw=;
 b=hL4exQcDrOYR/tRp5r9Ae8eO9APL5IGzKdC8HVxMkMfdRqCCcZYTybvnwSsSuhKgBN
 LUICZ8m2/2bX/9R+nhCWTzWgKvbQmMQOVUWZ85erbkcItoSxrV8SnRsRIraUG4YiBHxM
 jcZWnTsk6DfJDyID47UQnTegN/FP/xSxQJkk/NPYY+P63tJcSx/6BAC8dUFlk7g2A8oB
 /giliwhXGP/fgnfXybiFlgMVHt/lTfONWc6Vs5kIrSACtv2pAJ5KKWZEtdxkVaJ6pgLn
 34EtHY8p7SWbOHZFBTHt19Gu0/bfj3Y4pcwxQ/l7it0jR0eLRy9gWmhpo6uuQMfrj2iD
 mrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782499310; x=1783104110;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FmNj1WmEmAwRhq/a26fEtDH3y29gcjt0IVbyfDHmEiw=;
 b=YfShAdTXEcmrKlEnH6MsJyxcO48OnPQZDZ5gWUCmS+Dc6Tm2VFs1XwZzaxicKx9U68
 PzZ4IbKmvQAxWwMv/xxgmgM59ugshQza5jNZXCXAGgV+5BvsofmEvzkq0o9erFe5DrAv
 KaGxyAA57+6R5+HS4GpQLAig83nNcwkZJvvUw02cFImPJA37V3am/1r2liZJyC9aD/ZJ
 YRyj3zf7q+jYGyjGiumaIxT8i3VnDzBRGOhf7HYcJ2Yvp7QiJjX1YFnXnGtRUrzIgGdw
 IUkfuoQd8Yl6ItdZ2Jo6S4Xnnn4JJDtWg8kBL65WdtXBbuJhxmvguzFcr3JWYqFxElbV
 +suw==
X-Gm-Message-State: AOJu0YyZ/7IOO/vAR1xxuYkmLzc+JEFR2wcFH8JQwTNjsJTXPXGCVZUt
 TLnSGxNdgy1ghlqNegpA2tMVpmNq7EE4sZL4yH2uV9wUBcUHMgAcZK90ZNGJoxKVXQLthxB/w8l
 u37ffxO4g8e6xrq3PiI6dAVhfmbWtN3iFiSLyuYe7dot11CPdBTUL8CydUS5CQk+eehrHqMuIb8
 lhkVmZBOAPL89yqaTCmJCdNvLciQdCWOXQgw==
X-Gm-Gg: AfdE7cmCUjP0XSs+hi00KH0GD292hdgBboo7SbtxivEDC1kEtKOvglblNcgxg4V476K
 LGrn1twyxCDDcEzcX56pbbGPvw0p5sJZLSjUYLt04x8MvsABTaUhtV1Ca0ps/keAj+jMWoKFEtj
 MZPq694hZNDtMZUrBn6ITjJ4ojLdQupSE4ILOXuoqp4B65pV/08IDYLUwxWO84pa4wDjojDb+P4
 lkw+1FbzQJt1NkDamcKuCzY8dvHnkorsQL+MABM6U3sGtluoxOYtTNLaHvtGNK2XyEUJeuKwXbW
 qULwtcKornuS378rPCz57RyPkw38gLS5ezT+1D6zbHP6SOAKNvsoFF7/Jc5xwBELS0dwwzCy+R6
 XMdXR8Za3fID7YplIatRDvbly1iw2BngJ2Ls5IW80eq9wqtMxs8Hu
X-Received: by 2002:adf:e002:0:10b0:46d:d6e0:9cc8 with SMTP id
 ffacd0b85a97d-46dd6e09e23mr9318788f8f.46.1782499310427; 
 Fri, 26 Jun 2026 11:41:50 -0700 (PDT)
X-Received: by 2002:adf:e002:0:10b0:46d:d6e0:9cc8 with SMTP id
 ffacd0b85a97d-46dd6e09e23mr9318763f8f.46.1782499309933; 
 Fri, 26 Jun 2026 11:41:49 -0700 (PDT)
Received: from ?IPV6:2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5?
 ([2a01:cb19:8426:ae00:a924:b4e0:1ee:f5c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c221d93eesm25826573f8f.20.2026.06.26.11.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2026 11:41:49 -0700 (PDT)
Message-ID: <6ce9de1f-de0e-4ed6-a008-3caf0f29d304@redhat.com>
Date: Fri, 26 Jun 2026 20:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix information leak in vfio_rom_read()
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Mario Casquero <mcasquer@redhat.com>
References: <20260602074446.1206892-1-clg@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20260602074446.1206892-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
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

On 6/2/26 09:44, Cédric Le Goater wrote:
> vfio_rom_read() can leak uninitialized stack data to the guest when a
> read occurs at the end boundary of the ROM BAR.
> 
> Fix this by initializing the val union to 0xff, matching the ROM
> initialization pattern used in vfio_pci_load_rom().
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9df04fa2d76b1a78ee884d915f5a0c3c5fdb6115..de28e72519326741295c19f4a07208b95861f2ce 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -1142,7 +1142,7 @@ static uint64_t vfio_rom_read(void *opaque, hwaddr addr, unsigned size)
>           uint16_t word;
>           uint32_t dword;
>           uint64_t qword;
> -    } val;
> +    } val = { .qword = ~0ULL };
>       uint64_t data = 0;
>   
>       /* Load the ROM lazily when the guest tries to read it */

Applied to

     https://github.com/legoater/qemu vfio-next

Thanks,

C.


