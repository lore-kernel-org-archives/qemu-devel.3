Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84249CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 06:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v37pT-00075B-Mx; Mon, 29 Sep 2025 02:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v37pS-00074L-A9
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 02:57:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v37p6-0003wK-7r
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 02:57:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759129040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vDjYSF+m6qrRiedw7BHR39bZjOO2/b1mNagf9yr6NBM=;
 b=SoRYJ1KjkmbmuUaRektdYVpAEKYHvbPntEGOJ68IrpHwTuFhmotAREtHIUhjBjV+aoqEhi
 Xp25Pbh5a5UYlEWieKUjpuWsvajTPObMQjyuOj8uFZ8mMeUYSXgKhywIkqia+GvWWFsO0k
 nNR93X1WS/UJOnfRtd8CJlvwOiIjqU8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-xIIxoPGhPNGVIvEkt_HU3A-1; Mon, 29 Sep 2025 02:57:17 -0400
X-MC-Unique: xIIxoPGhPNGVIvEkt_HU3A-1
X-Mimecast-MFC-AGG-ID: xIIxoPGhPNGVIvEkt_HU3A_1759129037
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b3cd833e7b5so91139466b.3
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 23:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759129036; x=1759733836;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vDjYSF+m6qrRiedw7BHR39bZjOO2/b1mNagf9yr6NBM=;
 b=hkxVZKN+Gy0TIHu8TVkSQrCHRVRUn3eBOCstfQETx6GpbGSEbZzFoWUxvtY49WnbJf
 AsZlXYmcGBBBTovObG9GlI1hrLVwYmCdSZtM4MtYU7JM7tjniRAA0Y8HAPIVvpns3qz7
 /d2OOpTJZyPAyv4gFY9r4w9Tlc4HD2wwaFrG+q1eqQ2JLpmEAf5sislCSpU7U7UNFkPo
 P4TxG94D/5RwARUBpq9BeO79Qb7ie7QdQUWCELoQMRVOghqoH94FL14x8NUjJD0PxvXd
 IfGr28mRCZ5PuJQcwOCRO7CoxRxkWbO8rsytjKlvtFTCziOGXnq9dnlQHlgvZedfXAwc
 I0mg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkU5kgKqhRgXMzi1n6sn9B2JrZLPMqhl1RSbxHTMDZxWOxj/2dC6u4McuKUQzf46LCRexKjyA2msrn@nongnu.org
X-Gm-Message-State: AOJu0Yx0kP+rXxtMlWYCMDlKpz8Hk3bzEXLzNesNgVjtXmz36/gjm+JC
 t+H1rKP24lqRZU7wC+TzYvwBuVJsveDivsUyBiHbYiZ341X4jO7JlL4NtBTNcjNBsY/7zK3O352
 JYqCgI0eg4HalKxxOwbrd9im2EwuRZ0mpTipDxH7yB4QTrN2lpVXaV4o4
X-Gm-Gg: ASbGncuIK9Go4sEYM9bFHvDUW4L8KlYzFgVmwS0G32I1fl1/qYTY4wTPzvxLlNW9lhr
 kMD/j85HfalZvn8a/+Anqu3SkbavGZHISPCBKGRqboeCcK9tfAbk3gQRflyPUg0nk7pMw+Opb7w
 y2xayq6iFYWggdO5u9VurPna3LpILdr7YnrDqCC9t0USDiNMCsU1X0MObNsImdabNOSAcqe7ffv
 DPIbt6zx9H4yiUdtPZfk2OEb76Dx2Q5nYZeFhCbMDk5UOyIz37go1gBJyrJ0eZKEzRFg5ef2lWZ
 LB+ltIxpjDtOAmC8HPZzTyg7dMGMitpjbc68Ly7BUlQnweCD/9acIt8CrAg/VvTqXqFmsQb6qhH
 fhDEjlQ==
X-Received: by 2002:a17:906:391:b0:b3e:151b:849e with SMTP id
 a640c23a62f3a-b3e151b86d4mr276221866b.10.1759129036585; 
 Sun, 28 Sep 2025 23:57:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzSbQFSoVwAn03ph3eutXgCWt7avcM+1xRDMULFgIwkTs3rU4krt6REhXXnPbvWSP33FwugQ==
X-Received: by 2002:a17:906:391:b0:b3e:151b:849e with SMTP id
 a640c23a62f3a-b3e151b86d4mr276220366b.10.1759129036190; 
 Sun, 28 Sep 2025 23:57:16 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3ad6ff6f51sm403840866b.102.2025.09.28.23.57.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Sep 2025 23:57:15 -0700 (PDT)
Message-ID: <008fd065-6332-470c-9ff0-1bccb026ea69@redhat.com>
Date: Mon, 29 Sep 2025 08:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 01/36] MAX78000: Add MAX78000FTHR Machine
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20250711133429.1423030-1-peter.maydell@linaro.org>
 <20250711133429.1423030-2-peter.maydell@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Cc: Jackson Donaldson <jackson88044@gmail.com>, qemu-arm
 <qemu-arm@nongnu.org>, Jackson Donaldson <jcksn@duck.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250711133429.1423030-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 11/07/2025 15.33, Peter Maydell wrote:
> From: Jackson Donaldson <jackson88044@gmail.com>
> 
> This patch adds support for the MAX78000FTHR machine.
> 
> The MAX78000FTHR contains a MAX78000 and a RISC-V core. This patch
> implements only the MAX78000, which is Cortex-M4 based.
> Details can be found at:
> https://www.analog.com/media/en/technical-documentation/user-guides/max78000-user-guide.pdf
> 
> Signed-off-by: Jackson Donaldson <jcksn@duck.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Message-id: 20250704223239.248781-2-jcksn@duck.com
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/arm/max78000_soc.h |  35 +++++++
>   hw/arm/max78000_soc.c         | 172 ++++++++++++++++++++++++++++++++++
>   hw/arm/max78000fthr.c         |  50 ++++++++++
>   hw/arm/Kconfig                |  10 ++
>   hw/arm/meson.build            |   2 +
>   5 files changed, 269 insertions(+)
>   create mode 100644 include/hw/arm/max78000_soc.h
>   create mode 100644 hw/arm/max78000_soc.c
>   create mode 100644 hw/arm/max78000fthr.c

  Hi Peter, hi Jackson,

could you please also provide a patch that adds an entry for this machine in 
the MAINTAINERS file? (I just noticed that 
tests/functional/arm/test_max78000fthr.py does not have any maintainer, 
that's why I'm asking)

  Thanks,
   Thomas


