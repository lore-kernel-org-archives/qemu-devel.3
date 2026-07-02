Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16058C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHCl-0007Yl-4T; Thu, 02 Jul 2026 09:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wfHCj-0007YH-62
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:11:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wfHCh-0006MF-Rv
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:11:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782997902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0dC1/xjKaSYyWxJrIi95BC+AjqyHw72eAfR+jRKz2Ik=;
 b=E9oQK1VLa8jfvDEwljKYBnkPkYpKruw+BkIJEIZaSEpFK3Xpde9bmMx+R+/VtEnTejKSwi
 U3wtLexYiCmFyGEIcM+VMGtUejPxin90u+Ip/597Qcmo+abvQ5dXCINDR2Hv3JkJMHC9v+
 H2pSa1UlyYiQtP9MLXzLiWsVWSAGHjA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-285TyGt_PjG7u91LuhnOyQ-1; Thu, 02 Jul 2026 09:11:40 -0400
X-MC-Unique: 285TyGt_PjG7u91LuhnOyQ-1
X-Mimecast-MFC-AGG-ID: 285TyGt_PjG7u91LuhnOyQ_1782997899
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-471c76f357aso1631065f8f.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782997899; x=1783602699; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=0dC1/xjKaSYyWxJrIi95BC+AjqyHw72eAfR+jRKz2Ik=;
 b=Qvor8XhFazVVlJace+Zpn3DhW8q7TrXjLMZCmr44Xd+t3gbhJ40yhM0PjkI3tz00/X
 P9mXA65j+FIxbsCTLIjljqQfShxAFw27JrpViw/NrQzajg4d/ON06g6xsD1vRughqGhA
 isWAtdRusV3rejOxg/hCi/HR3ZLLN5xTgE9EbEUTuM3eacCAUEM7Fat8TthuYwZf+IMU
 jDmYjbqiVXXxOWmaFXTKqyoUteuAMKst8CGzZI747Se+msiL3jgKia9ufa2Gw1KTr4YI
 s0p/iMo/rpxxhn0vSRKCKnbWC2kDCL1Ecw2wTQki6DyZWH5LnD++KdblWPkphnRFpNtK
 6HLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782997899; x=1783602699;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0dC1/xjKaSYyWxJrIi95BC+AjqyHw72eAfR+jRKz2Ik=;
 b=HuiEvMo40mb8aU9Mx2xBy03l2SGrmCPnMg3L1FHsPCxF0xusy481MLJ3R44v7ZRPVA
 dWyt9uV8wm8OLVYwbngqZdxjZbJjqOoh7WgwVmc65BNn8DAlDA7zOr1w27ifDZXTYI4c
 YRb9DuBAob3endnsVf/t+5dP50G3N7/FZN4a5HMOAW3PfW4rwdiDt0XljghgkMYGNLfC
 yx3Kea1cH13nHgYZLUbUEieM2/JgWJObm9jTlN55iwHq5WF/oxVpB5X66zs4Uaq7Tt7s
 iuL1DaADsa/TedUv0PjCake1jBOf8c5h0MgIMuPHdcC6IPdW7ti0cjBzBSsZ0IcOSXUU
 MfGg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrd5wgdvE+EfPuMJ/HVnR2iXGMmH57qpMiUIcMCGpXyQlEVlNkK1cSRd1tS00xKOMi0u1jS9q9AeyyS@nongnu.org
X-Gm-Message-State: AOJu0YxfTFKw0XXK2BsF5Z7kH2Cz13IpYTPyocR0ned9SK+KdZGqEnvP
 /Bz5sbz1GpzIukuGgQo3lm2v+2K/scywh4KUAJs+OlbIEQxkFtnUDJkOuMtHCDekhGnNr9AFqLk
 1PA1Gal9Tt9BGub0Qa/UnRClRxOsITQjl581ZwqoXEup/syIlrIbr3shV
X-Gm-Gg: AfdE7clAjySRvJpn+ViIPzp/KXydmpv8GWHsG8LENOeye3KHS0V37wIUEvZer5x4I2s
 WMOm16d/709WTaMR09pL2bLssLlsbS9iTi9yVwvQyruqzBzC+tbq9GaC7y5q7dVpGFOHREuG4u9
 VM2Qu+Ha5v1DSV778kV4vdHQLwJMGhs4eLh7N+l3zNVb4t9dNbCk2GY0hjnyGy56OZdfvyyndBz
 C6ymzzyLToqQX61iP0OnMZPLjlW5cK01Da5GiuJ2N0KIBhk8r69ZLOyFg7cr3uODZoxvv8mDP0X
 GAfkyi1E7TVmpkYIJw2R2MN23FXzixI22OzzG+8RoVlv1R1GOhnh+DRiHHOMd898k233Xu2kL2j
 PXzFdISc1cseF6zcSPOjLn1uDPh3QUdmbu4vHwW1RnnsOHHJidFIytU7fiMqL
X-Received: by 2002:a05:6000:27ce:b0:472:90af:e406 with SMTP id
 ffacd0b85a97d-4775a1f55c9mr7561540f8f.37.1782997898919; 
 Thu, 02 Jul 2026 06:11:38 -0700 (PDT)
X-Received: by 2002:a05:6000:27ce:b0:472:90af:e406 with SMTP id
 ffacd0b85a97d-4775a1f55c9mr7561503f8f.37.1782997898524; 
 Thu, 02 Jul 2026 06:11:38 -0700 (PDT)
Received: from rh (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dba0esm8538417f8f.7.2026.07.02.06.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:11:37 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:11:36 +0200 (CEST)
From: Sebastian Ott <sebott@redhat.com>
To: Eric Auger <eauger@redhat.com>
cc: Peter Maydell <peter.maydell@linaro.org>, 
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Cornelia Huck <cohuck@redhat.com>, qemu-arm@nongnu.org, 
 qemu-devel@nongnu.org
Subject: Re: [PATCH v3 2/3] arm: handle CCSIDR_EL1 as a demuxed register
In-Reply-To: <aa1f8006-4665-4fcd-b8ee-5b90cd53e953@redhat.com>
Message-ID: <d4e67daa-64b0-946f-21cd-b7e0c6a942ca@redhat.com>
References: <20260622135627.40573-1-sebott@redhat.com>
 <20260622135627.40573-3-sebott@redhat.com>
 <aa1f8006-4665-4fcd-b8ee-5b90cd53e953@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Hey Eric,

On Mon, 29 Jun 2026, Eric Auger wrote:
> On 6/22/26 3:56 PM, Sebastian Ott wrote:
>> From: Cornelia Huck <cohuck@redhat.com>
>>
>> Move handling of CCSIDR_EL1 over to the new *_IDREG_DEMUX
>> infrastructure.
>>
>> Tested-by: Alireza Sanaee <alireza.sanaee@huawei.com>
>> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>> Signed-off-by: Sebastian Ott <sebott@redhat.com>
>> ---
>>  hw/arm/virt.c                 | 23 ++++++------
>>  hw/intc/armv7m_nvic.c         |  2 +-
>>  target/arm/cpu-max.c          |  6 ++--
>>  target/arm/cpu-sysregs.h.inc  |  1 +
>>  target/arm/cpu.h              |  6 ----
>>  target/arm/cpu64.c            |  6 ++--
>>  target/arm/helper.c           |  2 +-
>>  target/arm/tcg/cpu32-system.c | 26 +++++++-------
>>  target/arm/tcg/cpu64.c        | 68 +++++++++++++++++------------------
>>  9 files changed, 68 insertions(+), 72 deletions(-)
>>
>> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
>> index d8d27f2ef6..ab2b566e69 100644
>> --- a/hw/arm/virt.c
>> +++ b/hw/arm/virt.c
>> @@ -307,21 +307,22 @@ void set_cpu_cache(CPUCoreCaches *cpu_cache, enum CacheType cache_type,
>>
> I think you would gain in readibility to use a local variable
> ccsdir = GET_IDREG_DEMUX(&armcpu->isar, CCSIDR_EL1, bank_index);

Indeed, thanks!
Sebastian


