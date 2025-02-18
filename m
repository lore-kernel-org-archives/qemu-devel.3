Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6502C02198
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 09:07:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkJZi-00048X-Oa; Tue, 18 Feb 2025 04:07:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkJZd-000489-ST
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:07:26 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tkJZa-00061M-Vb
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 04:07:25 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38f1e8efe84so1791504f8f.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 01:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739869640; x=1740474440; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lzu2ktDaqS10TPZDjRxVfWfdshVRC+131t80tzCVeoI=;
 b=ejvD/2yeGR9Jr/rozg9YyUrtdZJrvYdCwLvwuxb0aT1/UAMaREwDoAisERDRXVoTJp
 pFkIlZcHcoMdilqIndM+pNiF8S7G886cPCFTDyWuoJnV1gWUBqb3fhfXZh+bUKsqEqDZ
 fN9Rtz7mc3w4qaLep87DIxCCA2cMJlGMEQ7DPJdPJiqXa9OjGOC+nMfKSAJ+I9cJEBpN
 v4e9OYFK2xood5bTH4T6Vn7le07HZqRDK5JnUflmc85KEQLPt1ztvTU0NWQYHejSZLxR
 +bDszBZ3C3d4JIcbEDUgkS4iuQ44LVWEif+wwIgO/Z0vIs56+wa7aArGf4U90PU5yUbb
 MnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739869640; x=1740474440;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lzu2ktDaqS10TPZDjRxVfWfdshVRC+131t80tzCVeoI=;
 b=FYBQWDHN0Ucfv/7rbKPIMwFfyqt8rvS0G2IXI5uxCNVmTu344kiGCKUInhhaTFPrgZ
 tz3GL3pjNpUK4CUYOPF6ALcWfIXlhhBXOCB7FTkPsWy9QlFYVYn38gBzrl2Vqvia6KNR
 de8UVEtmXFWn2qrF2+2+/3dmj2YsAoFU6EG6Pt2nxULE4W6X1YBmCv3F33jMXQLDPnqG
 0hNglrY9ONTeEqzZBH9cicRaL+H1IIPzRVllC24Lq55YgbV9Alavxs19O2mtBPyI21fw
 r1RzKs3RQ3Pvdz9njXwI6nw4MwqEF6qlHCL6M+3LTenZGrwX5LuAbmC4Y8fvjmdKZ4rb
 R49w==
X-Gm-Message-State: AOJu0YzubNXB4GDO1pUc8BXjRXDriPzBN9IG8+YJExdWsNpJ/hcjPb6D
 hEeF0zB4ePJhIxGRTBXleW80IMhtcWqWL3BH3k7PsX9Xg4tndK1A8+mG5BeORVo=
X-Gm-Gg: ASbGncv3ZvtrfxI6QuhL+h/E8Y5r9DNA0M1MQtFj3i7qP09p6xfj+6ztJJXuAkWtawC
 XlA6YJAWdk4Q8mm234hOmbecPNOlswSRXPB3BRnpOfAqAXD7KzVpb8bV4krbh5EcRjLMF0mLF6m
 Xu8LpVBoPQf9GzhDZYkKCg8u26i3f035OfJ0o1DrbOdc1MlH/nVChHPHfFhUA1NOnwhLy0ES/HR
 nr+pgT+vjxp5MbfA9beLOxhe2J8qlG2POJSGCuAhtzsWLazVe0rg1zI6ECS6VDOigUFoU8Yvhdt
 HU5bZNsZzsaLVx2cwtMNFi4FHvA5ag+xVko1dXKGM16Z6W03EDwSKpvJdr8=
X-Google-Smtp-Source: AGHT+IGmxIjNLDFOPEhgYYWxfXbpn9DAS+yTwfJBFobD0HHfLr/S7LqMLB98d16vyrFxDLkkWRdrAA==
X-Received: by 2002:a5d:58c6:0:b0:38e:ba3d:cbdc with SMTP id
 ffacd0b85a97d-38f33f4e424mr10570087f8f.39.1739869639614; 
 Tue, 18 Feb 2025 01:07:19 -0800 (PST)
Received: from [192.168.69.196] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258ccdabsm14396691f8f.28.2025.02.18.01.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 01:07:19 -0800 (PST)
Message-ID: <cf10367d-90da-48d4-8440-7afb8b083883@linaro.org>
Date: Tue, 18 Feb 2025 10:07:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/timer/hpet: Detect invalid access to TN registers
To: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20250218073702.3299300-1-zhao1.liu@intel.com>
 <53739259-69a5-4d7e-9178-f09e1d6ede89@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <53739259-69a5-4d7e-9178-f09e1d6ede89@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/2/25 09:53, Paolo Bonzini wrote:
> On 2/18/25 08:37, Zhao Liu wrote:
>> "addr & 0x18" ignores invalid address, so that the trace in default
>> branch (trace_hpet_ram_{read|write}_invalid()) doesn't work.
>>
>> Mask addr by "0x1f & ~4", in which 0x1f means to get the complete TN
>> registers access and ~4 means to keep any invalid address offset.
> 
> I think this is less readable.
> 
> The reason to use !4 in the Rust code is because the initial AND is done
> in a separate function, timer_and_addr().

Having a quick look at the model without looking at the specs:

include/hw/timer/hpet.h:20:#define HPET_LEN                0x400

hw/timer/hpet.c:439:static uint64_t hpet_ram_read(...,
hw/timer/hpet.c-441-{
hw/timer/hpet.c-448-    /*address range of all TN regs*/
hw/timer/hpet.c-449-    if (addr >= 0x100 && addr <= 0x3ff) {
hw/timer/hpet.c-450-        uint8_t timer_id = (addr - 0x100) / 0x20;
                             ...
hw/timer/hpet.c-469-    } else {
hw/timer/hpet.c-470-        switch (addr & ~4) {
                                  ...
hw/timer/hpet.c-488-        }
hw/timer/hpet.c-489-    }
hw/timer/hpet.c-490-    return 0;
hw/timer/hpet.c-491-}

hw/timer/hpet.c:699:    memory_region_init_io(&s->iomem, obj,
                                               &hpet_ram_ops, s,
                                               "hpet", HPET_LEN);

I suppose we want to register multiple timers of I/O size 0x20 at 0x100,
and the I/O size of 0x20 at 0x000 is a generic control region.

Maybe split hpet_ram_ops in 2 (hpet_cfg_ops and hpet_tmr_ops), mapping
the first one once at 0x000 and the other 24 times at 0x100-0x3ff?
No clue what is between 0x020-0x0ff.

My 2 cents looking at QDev modelling to avoid these address
manipulations.

Regards,

Phil.

