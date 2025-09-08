Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D422CCAC586
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 13:12:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvbdA-0004Cn-IL; Mon, 08 Sep 2025 09:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvbd8-0004BX-3n
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:09:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvbd0-0007vN-IO
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 09:09:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757336984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=u9rBbDBkBCTtqr6qKdjAv4+DymLGXhOSd1J6cFxBUnA=;
 b=hiD6hycNlXFhimpxxsi3MHEPyVIh4HC245eSwuCOhy2RKdFSE1fr+4va3jYpWisEo5VMor
 3ORvChbDo5qwvkRxn9YI6/pYTsAiSs866B/iT43SJzHnHn+3fc4blaBWX1UdFM59uSo/Av
 AFa2lI6zt56m/LoYZWNE0PCCKo9cZ9I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-JTVOe_4MPXuJymF8OFQtQg-1; Mon, 08 Sep 2025 09:09:43 -0400
X-MC-Unique: JTVOe_4MPXuJymF8OFQtQg-1
X-Mimecast-MFC-AGG-ID: JTVOe_4MPXuJymF8OFQtQg_1757336982
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3e38ae5394aso2532345f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 06:09:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757336982; x=1757941782;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u9rBbDBkBCTtqr6qKdjAv4+DymLGXhOSd1J6cFxBUnA=;
 b=xRK1245c9PrBhWRPb4iNmN4tPZvdmf8W5Or4afjTu49FRoP1B9GBuzexJCyuirI8KS
 bsORIMqKevTjjQuGrPdPokY74UvLOMsxy9zJVAOkDV+EaYVnK02LIX12GPsuB97LfXq1
 x0BHduQBGC3JcVQzEa2A9BNMWfoohQtYfPHAmr6L0XLOuMAoYpJNjD6s7s6R1UyQa6yw
 cDShXfzPzjGauYaVf15i2PWTprijlNL5TaIPFeyCkX/Ds1O0eTTC7X+rLcHN8uIj/WRQ
 rqvtz1ZIeTVcrXqDH8aJoKV4L/hdR86yOdtVnbhADXY4uSI7mlgNV2ZHM/IlJ2OtCdwS
 aVKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVocW6LkCooHpVtBTS9bAXiUp0pqrK0zwT1bHIh+yCpdsciMIRGy+Im4edYdOTJROIRV0nXHlEUGKgq@nongnu.org
X-Gm-Message-State: AOJu0YxdbXrhb0CyPygNu7XhmXAGy6XCaMekkikLpuVsagSQk86509z4
 neNE/n21h9deY4C/J4dke7TX8CZGc8c/9lsVhJWHOVwvO2NLT6Eh8Uv7htPZgMp9X2QKZsRlQkg
 wzL4tOVGSMORcAfhPZxSuyFKfDGPpe1oMm1vBbp1cwMJ1Wc8YQCNU7lqc
X-Gm-Gg: ASbGncstURB3GvPPXne0K460DbTR135llPOlyDe3+cUyKIHpVmlaKTNSQVH1QYfvCQB
 XIKwNKOn7u4MpPAptOITQ2aVAJRRoHoxVppN5SJ3QK2mojh2YI/QF+TdzlmNv/M0evIeQCSNTBa
 ceZZaPadgcP+GTpZxvXalxXGbCIh5G8GhBqB0/4vlqn50EdzJNgrWoz1uxsQFNxApAQtQt0um6M
 ftZoXkqyJftCAFsI65ni7ukn1xhaxKbKnw5nrZwAPwgGrHp6qs7K6Jzs+fjSFHBTgY5oTZM0Vj0
 MsglO+lQfb0lfEinXYfAxqlW4GF+q6D10ZhpCIMJXxbVKIvyowA0kbacPp4Hg33X8mcIbLD2Jib
 bOQHayR6PLaimyDOXOpnoEgi4kaO1nmrhXDRT/N+szNk=
X-Received: by 2002:adf:a2de:0:b0:3e6:e931:b3e7 with SMTP id
 ffacd0b85a97d-3e6e931f910mr3841455f8f.61.1757336982106; 
 Mon, 08 Sep 2025 06:09:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxyLezQA4/PKwjWgzAeAlKCa07RXIAixnbayTQ7KFa8x0SwM3nFFmWSTSlU6N3GjkkeYMeWA==
X-Received: by 2002:adf:a2de:0:b0:3e6:e931:b3e7 with SMTP id
 ffacd0b85a97d-3e6e931f910mr3841431f8f.61.1757336981695; 
 Mon, 08 Sep 2025 06:09:41 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3dbead0b247sm22477352f8f.6.2025.09.08.06.09.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Sep 2025 06:09:40 -0700 (PDT)
Message-ID: <58abecd0-4071-4cd9-8df6-78478c310969@redhat.com>
Date: Mon, 8 Sep 2025 15:09:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] docs/system/security: Restrict "virtualization use
 case" to specific machines
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 qemu-ppc@nongnu.org, Huacai Chen <chenhuacai@kernel.org>,
 qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>
References: <20250908125058.220973-1-peter.maydell@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250908125058.220973-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001,
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

On 9/8/25 14:50, Peter Maydell wrote:
> architectures where I've made a guess:
> 
> i386, x86_64:
>   -- I have assumed that all machine types except the "experimental"
>      x-remote are supported

Please exclude isapc as well.

> mips, mips64

Probably none.

> riscv32, riscv64

I'd assume "virt" only.

> ppc, ppc64

"pseries" only.

Paolo


