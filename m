Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC077C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 09:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh1qU-0004nd-41; Tue, 07 Jul 2026 05:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wh1qR-0004g9-N8
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wh1qO-0002Np-JH
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 05:11:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783415515;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=MTDNtny+DqUH1t70ZdyARMjR0IIaxzgiIhz/lbuxjIM=;
 b=KEzH79uH0FVoPissCyhoVcTfUDkt96Z2G5s57vgl3OtTmryIRYi8gW+BWOb4AKSWAQgBty
 /3ewJrSAs4K8nXOvqr8oxGu2FPOg1x3si/VnqopLfwNXPUO55hGoAh9ZQhDJncUcJB33OG
 PFtrlyuaWmKgwYvTy8GOLFcxSf6B80U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-371-TnFaVrLxNlW4Lt-6XXrGdA-1; Tue, 07 Jul 2026 05:11:51 -0400
X-MC-Unique: TnFaVrLxNlW4Lt-6XXrGdA-1
X-Mimecast-MFC-AGG-ID: TnFaVrLxNlW4Lt-6XXrGdA_1783415511
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-475de65009dso3072131f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 02:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783415511; x=1784020311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=MTDNtny+DqUH1t70ZdyARMjR0IIaxzgiIhz/lbuxjIM=;
 b=EalYFj+7bPKoWh27avgn+2LVkb3GYg8kaAbNrpDIq9hnTKIfU++RtPuReC8516i5xw
 ymDhcjuSP0ilUmr1TBXduL11Lsji2gZt7fS3aobN7VV40CcFt05Lo9k4l0o/rcFfKzOo
 unkPxivm5qV1Iq9fN8gSlSZv8H47TAy2ndKyYncBJE0CC5gbzikVpcWSbkUBXJfkstml
 gxkGNbsz+QG2oiJKankj57d8oxMoOXSqenyp+A4WWd+nQa6mAeGyr/ykb2JL9CbS5ufi
 Y/iTIqSB9PcK8wCnliRPEFAvwlUXSUPDjnjVLYrsXjS0dLzXkT8UPv1hM3MEbg+vLUwL
 snNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783415511; x=1784020311;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MTDNtny+DqUH1t70ZdyARMjR0IIaxzgiIhz/lbuxjIM=;
 b=NYvofoYgCYrrHgB+fHxqJOIRlCDXu/Fxq04O9d4oxgWQcSnHPX1UTYhbtJqVJ7waiM
 801i07oMGzwh4GFOHKcJlgBjA7QLWSpLd6IjLuJWUzvkFeQPU1aGMiG0Km5yBMntH3bW
 yTxI5X23+5GCplkTgKZScC27Nk8C5/B0meZZqDdF363iZMtfJlg2zf3WdpXZsGZ7JMYF
 Z1KMKcJZmblWuVqUm9bqFXiC8y1/SM+8MuHiOxtQ5+M5qYSsF59oc5or9BtNE/fQ8y1R
 5uKPWqRIOam3XdqPSrKsXMpHHqyFair4v0tJgQAj6uQlhgyDBxRV/slusxL4mqQuCqiV
 Xupg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2pi3vV43R8WG6oFdZRKRo0yTnXzl7GvRmH0RgpqcW+LxsLE2iQTbvQh4gVhhjJHKzxUNjq+GdAFhD@nongnu.org
X-Gm-Message-State: AOJu0Yx1bRZLBeL2MQw90AYBvNiXyUXlB+Pssw5ibZkZzbCUZECe5B1y
 wSP4Qfj7ewJbCmQyb0H1eP8j+lxs6sQm/gi3lcGhDv7HX1o7J1/WLY4S0pvq50C1f2z61cGtopE
 pUs7i6tDbcbevR5X65EKDSNzqVFjkbmfXTyhy7hU3aD0qkZwMB5VSLyy7
X-Gm-Gg: AfdE7cnalpAElPFfGJmO2BdHMvBjYwj2b3LqmGHE+qDYnjB1KowedEP+iYxW1Rm6qL4
 6ShBlFx5nAbsOY8wdsqvONtJBB18JyTe+VforRjUlccAbyoIFx7u14vzeHZKxs7Yco3Lgw2DJ7w
 QKm3Bkwg0Q1hWoFxod/qBJYznpdmSiomlo7a6ElbDmCyRN8iKDihyK+ldKdjWK+0st/c1Vvn+sY
 YCITy2vLxDTSdOR4qEKBD3A+HC9rMHzz3IBO+2nvLBmFcXLQrCTD2wzmC10SruP7BgMLtVQTuCW
 JbtfRHGkFdcze2m0//M4hZNnUwdHqok9vt0Z13gqRB1f/i6Yh2HHOGlMsUqfUZo6gXwLwi303Rj
 wTZBbFQ==
X-Received: by 2002:a5d:4289:0:b0:46d:d6c1:8383 with SMTP id
 ffacd0b85a97d-47de66dd473mr3557107f8f.44.1783415510773; 
 Tue, 07 Jul 2026 02:11:50 -0700 (PDT)
X-Received: by 2002:a5d:4289:0:b0:46d:d6c1:8383 with SMTP id
 ffacd0b85a97d-47de66dd473mr3557089f8f.44.1783415510382; 
 Tue, 07 Jul 2026 02:11:50 -0700 (PDT)
Received: from [10.22.2.34] ([91.26.127.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1d8f1sm32306081f8f.3.2026.07.07.02.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 02:11:49 -0700 (PDT)
Message-ID: <4d9cc51f-e3fb-4f2f-b20f-4f65ec00db60@redhat.com>
Date: Tue, 7 Jul 2026 11:11:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hw/pci: Have various pci_bus*() methods take a const
 PCIBus argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Michael Tokarev <mjt@tls.msk.ru>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20260707084050.32137-1-philmd@oss.qualcomm.com>
 <20260707084050.32137-2-philmd@oss.qualcomm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260707084050.32137-2-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

On 07/07/2026 10.40, Philippe Mathieu-Daudé wrote:
> Mark the PCIBus pointer argument const when methods
> don't need to update the structure referenced.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   include/hw/pci/pci.h                | 10 +++++-----
>   include/hw/pci/pci_bus.h            | 10 +++++-----
>   hw/pci-bridge/pci_expander_bridge.c |  4 ++--
>   hw/pci/pci.c                        | 18 +++++++++---------
>   4 files changed, 21 insertions(+), 21 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


