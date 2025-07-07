Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E7E2C8303C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Jul 2025 09:57:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uYias-0007dS-Ki; Mon, 07 Jul 2025 05:57:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYiai-0007af-0N
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 05:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uYiad-0001xr-UV
 for qemu-devel@nongnu.org; Mon, 07 Jul 2025 05:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751882206;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vOiSaLN/pUNTy4kE4V5dPDa6QQvJsX9iaAfDT3vF9TY=;
 b=AOev3DN+IsGTddzHMYpS/LKRwipRnicuiXiR5XQqEgypAOOibSi4GfqgL/iK+BHmLqhGAx
 Wn0ougB9SDKInHxNnM228V5VMxAKNz70e1ECyYxlEn7oSVd+242R46tYT06ztvaO3Gh5K8
 7F5y9TOi6uYH6+UR1LtEpknLzkMsCho=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-Nug1HhiRNy2tI2zJAUQLnw-1; Mon, 07 Jul 2025 05:56:45 -0400
X-MC-Unique: Nug1HhiRNy2tI2zJAUQLnw-1
X-Mimecast-MFC-AGG-ID: Nug1HhiRNy2tI2zJAUQLnw_1751882204
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4535ee06160so25158215e9.3
 for <qemu-devel@nongnu.org>; Mon, 07 Jul 2025 02:56:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751882204; x=1752487004;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vOiSaLN/pUNTy4kE4V5dPDa6QQvJsX9iaAfDT3vF9TY=;
 b=vMpmKRBs4wERX6vbtNbBsdus9rPBaHq0DeVJ2iXyxKnENnHZZ/xnwG+VWlY4o6FSzG
 1iJ50F20USWvwjmG9CM4POKCDVM8z9w+PLirik+KEBGdXUNcq6XknM1v5CQ/irwh+ctm
 XgU+DRYTetVWnbtV3u61Kbc4/qO/5gmSjuyEQT9YO7CFFvX1Q3jsDVOYuj3YZwhBnn3R
 ekLA4eZYnqldQ7QYv20d7I2Ik545yTHLe+QlEbbY2pVlehuR8jzdh+Es0FrpAm54dMXb
 Jq8zJ1o3OuroaCkkUyraTvCED/hWjqqRPE/NQP+ktD/a3CJP5kFJnBMGGvaiv9yd0rQr
 GPpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCk58AanmOTJ6RNRur8LD7qLNGWkADvPeyCLBd3YJvP256OJPUzyfPsnUL7tfNpqxKME8wKJcZfkNp@nongnu.org
X-Gm-Message-State: AOJu0YwEKrlvvA6Fr7r/F9UxQiiqf8XwUlSlpuYZherEkBEnPzQ+j2L3
 +cQMxh9JQAT8vzsCpJqEjpsYtm7hG0T/f8w5b1xKskaOqj/Ait/yQ730tOlTD780biInTQAf8ey
 zgdmYxFhpw8YN0WFDVfMSmpj4+AoxHOWh9pdZxjcbv4cPSfb0TM8B6bCA
X-Gm-Gg: ASbGncs5gJbLKWldo0okdpgpiwjSubf5OepC5KctPtCcWPB5WgGcpc5CBjrLrEIFQQp
 uWi3QekkGNadPqVmtuJqk0//Pu+WacJo9I04aZEyVyiWwfhFYWrcQnjoYVNnlyezG9/zVUuxdfw
 +snWLDg6RDu197W7G4TBK/N3n/lb8+NenIi6ohyaUUHAmoT+V15YHOw2X5kjjMAkOwtlpdlcMaX
 OGyuEJwldci8Ta1v0vInLMEf+FWsCWnQmjOQqtUBBZvnEZXEhJlK56yPbrpBF/r59q5ZtrXZv4k
 iDMY8Db6JdAA9x9XckRoBnRCBNb/0RXv3wDCZsMLWIyWQn8Eejp4SJ5kqe7oryONNL/iPQ==
X-Received: by 2002:a05:600c:3493:b0:442:cd03:3e2 with SMTP id
 5b1f17b1804b1-454b306a122mr112561185e9.2.1751882203886; 
 Mon, 07 Jul 2025 02:56:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHZB1gy5XdeVhZBruFePguCmorbp8m8Rui+5wwDbfOHaJK/1v47bwOPB0uKPxf0QwYz6D1Hzg==
X-Received: by 2002:a05:600c:3493:b0:442:cd03:3e2 with SMTP id
 5b1f17b1804b1-454b306a122mr112560965e9.2.1751882203425; 
 Mon, 07 Jul 2025 02:56:43 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454b1695577sm106882365e9.27.2025.07.07.02.56.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Jul 2025 02:56:42 -0700 (PDT)
Message-ID: <eae68d00-af45-4880-b976-58d2f2c6f7a5@redhat.com>
Date: Mon, 7 Jul 2025 11:56:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/4] hw/arm/virt: Allow virt extensions with KVM
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 miguel.luis@oracle.com, richard.henderson@linaro.org, maz@kernel.org,
 gkulkarni@amperecomputing.com, gankulkarni@os.amperecomputing.com,
 hi@alyssa.is
References: <20250702163115.251445-1-eric.auger@redhat.com>
 <20250702163115.251445-5-eric.auger@redhat.com>
 <CAFEAcA9hhdwHNrBfEqO4GD6kSb3Efcw-Rztq=CqvcOGMG3+z6A@mail.gmail.com>
 <9c78f7c0-88ce-4c4d-b6c0-5b77b4d83367@redhat.com>
 <CAFEAcA-qh5zPUY6q-TH3T8CCrD2KEfXNDrZbVzr2H-HX5n7sSw@mail.gmail.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <CAFEAcA-qh5zPUY6q-TH3T8CCrD2KEfXNDrZbVzr2H-HX5n7sSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Peter,

On 7/7/25 11:53 AM, Peter Maydell wrote:
> On Mon, 7 Jul 2025 at 10:30, Eric Auger <eric.auger@redhat.com> wrote:
>> Hi Peter, Marc,
>>
>> On 7/4/25 2:22 PM, Peter Maydell wrote:
>>> I suppose the system registers probably generally Just Work
>>> via the sysreg GET/SET_ONE_REG API, but won't the in-kernel
>>> GICv3 have extra state that we need to migrate in
>>> hw/intc/arm_gicv3_kvm.c ?
>> Do you see some specific registers/resources that would need attention?
> All the EL2-only-accessible GIC registers: ICH_AP*R<n>_EL2,
> ICH_EISR_EL2, ICH_ELRSR_EL2, ICH_HCR_EL2, ICH_LR<n>_EL2,
> etc etc.
>
> These all need to be exposed via KVM_DEV_ARM_VGIC_GRP_CPU_SYSREG
> and hw/intc/arm_gicv3_kvm.c needs code to be able to save and
> restore them into the GIC data structures (and we need to make
> sure the kernel isn't accidentally exposing them as CPU registers
> via the GET/SET_ONE_REG API, I think, in whatever way we do
> that for the existing EL1 GIC cpuif registers).
>
> I don't see any of the EL2 sysregs listed in the kernel's
> gic_v3_icc_reg_descs[], which looks like it's what drives
> the handling of KVM_DEV_ARM_VGIC_GRP_CPU_SYSREG.

OK thank you for the insights.
>
> I'm ok with just putting in a migration blocker for the moment,
> especially if this needs kernel-side changes.
OK I will do that until we get this fixed

Thanks!

Eric
>
> thanks
> -- PMM
>


