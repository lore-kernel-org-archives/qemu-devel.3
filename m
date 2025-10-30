Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FA9CCF9F1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 09:55:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEPMV-0002KD-Od; Thu, 30 Oct 2025 05:54:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEPMQ-0002Jc-P4
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:54:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vEPMI-0000du-Gr
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 05:54:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761818051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=6XdgfQxluwBcLDe1xFkj4ry8yZVXVpGUg4q+UPa18g0=;
 b=h+yYS+MC16hTm1OgmEmpE0YpcmjH4VGhM6BGb+iUYjezSZ/aHHa1oo/6BVQD0Hefcarh2h
 tlXQAV8tZcITGrSYHC1xyuklx8f8HD+uqXzDp+9cF/uWxvJ73YksRQvHK54iGjJntqxerT
 aSL7qiArmRtf8+jnzbBMGK+oXiVhJMM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-jjJMfaP_NjKO8GZENv30iA-1; Thu, 30 Oct 2025 05:54:09 -0400
X-MC-Unique: jjJMfaP_NjKO8GZENv30iA-1
X-Mimecast-MFC-AGG-ID: jjJMfaP_NjKO8GZENv30iA_1761818048
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-475dca91610so3243525e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 02:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761818048; x=1762422848;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6XdgfQxluwBcLDe1xFkj4ry8yZVXVpGUg4q+UPa18g0=;
 b=vDihF2zoDlGEPbitWaxccy2UOF8FDUzU9rhigawMCUIWO9HUZyCZ3mB/JteUnWwrio
 sIO0j+lD58peXMBlgaeLtxty3hLbdxlM+KZEXm0jCMLQyql0JHUIwrkrw8P4UTz3lN6N
 dS0pGFvSY/RNx7A3e972k2cnGnu2XIxFo9zQQzhwJ86MzlqnYsL/egVPB6zI/LznY5yM
 035NQ4g2oXnqE+pyTT+yOxrIOqpNSR26dkeujOqTa9jDOW50J/XwfmUpdTGIEaBLjmRm
 /LqAO3tonon7GCApc0UxiBJ80/NffsCF6TWprRyJqm7u5YBCSoG5xklBzWI1cWHIx4GO
 78OQ==
X-Gm-Message-State: AOJu0YxCP76rGv5uEL7mFfDwIUYiUqjBWWtjxJFyozr3mGLr6ySq0lEb
 XVYqz6A0KmDrk+WjeHc2OghUB1AfB8cqNnT5nPIMRfh8vktnZ9q6eoLGCXQ1SMuP76Z8ttJ+ZQk
 pssleHKW7zdltI1khEsH0i/2MIEN0ErKBJFzPdtvh3q12HCUyy/a7xjK6
X-Gm-Gg: ASbGncs39q33h77WfJ8XWGJyRxyF3dNmz94cq4Gbksg7isuWPjGqqBnWBgLbo4G+O/R
 TQHF2sGxNkva0SejNuL7njVRJx2o9bUIWhuuI7J1VbVM7I5aCRDSGNVuZXgt3UCszTeyfN/UBaA
 fMCuYdzMs2R5Ul0W80nad9kKPjHpdVUMUcOXQ6S1fCDIOL43hX936h6tp2ehQT0yVc8B8SZkeGO
 whiFvFscm9+OI5sGCWQneJN1RoQaHaNxlXp/dX6PwSg6xV6pWokRUfSylX052pMbtDbHbDg9++7
 KXxcsxPSxFC9XUxajkUgSgHuWpSQ7xXKXqKxU/98Dxrg9MJbGV4euTldw8s1/eveH9Qt8PA=
X-Received: by 2002:a05:600c:4589:b0:46e:38f7:625f with SMTP id
 5b1f17b1804b1-477267cba4cmr19188285e9.10.1761818048125; 
 Thu, 30 Oct 2025 02:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiKnsTMRwnEykoX7nPL335mVoGXcmgw5oh565MUBk2izNxIBlvGI3Zzs/AFgkI8nYoxDqwpA==
X-Received: by 2002:a05:600c:4589:b0:46e:38f7:625f with SMTP id
 5b1f17b1804b1-477267cba4cmr19187955e9.10.1761818047685; 
 Thu, 30 Oct 2025 02:54:07 -0700 (PDT)
Received: from [192.168.0.7] ([47.64.112.33]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429b6bc5907sm3040024f8f.13.2025.10.30.02.54.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 02:54:07 -0700 (PDT)
Message-ID: <55d74476-4697-464f-91d1-202b26627d2c@redhat.com>
Date: Thu, 30 Oct 2025 10:54:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm/bcm283x: Initialize CPU objects in SoC common
 DeviceRealize()
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20251029075257.63635-1-philmd@linaro.org>
 <CAFEAcA961WKB4fxwAS0WHXXKwYEO7TnmovD4z-BPGehr6sxBQw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA961WKB4fxwAS0WHXXKwYEO7TnmovD4z-BPGehr6sxBQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 29/10/2025 15.14, Peter Maydell wrote:
> On Wed, 29 Oct 2025 at 07:53, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> QOM .instance_init() handler can not fail. QDev DeviceRealize
>> can.
>>
>> The device-introspect QTest enumerates all QDev types and
>> instantiate each one, without realizing it, then introspects
>> the instance properties.
>>
>> When switching to a single QEMU binary, all QDev types are
>> available in the binary, but only a filtered subset might be
>> available, depending on which previous target the binary is
>> trying to mimic.
>>
>> In particular with the Raspi machines, the TYPE_RASPI4B_MACHINE
>> and ARM_CPU_TYPE_NAME("cortex-a72") will be built in the
>> qemu-system-arm binary, while not available (because filtered
>> as being 64-bit, for the qemu-system-aarch64 binary).
>>
>> However the TYPE_BCM2838 SoC is not filtered out, and will
>> abort when being initialized, because the "cortex-a72" CPU type
>> is filtered out, leading to device-introspect failure:
>>
>>    1/1 qemu:qtest+qtest-arm / qtest-arm/device-introspect-test        ERROR            2.46s   killed by signal 6 SIGABRT
>>    stderr:
>>    unknown type 'cortex-a72-arm-cpu'
>>    Broken pipe
>>    ../../tests/qtest/libqtest.c:199: kill_qemu() tried to terminate QEMU process but encountered exit status 1 (expected 0)
>>    (test program exited with status code -6)
>>    TAP parsing error: Too few tests run (expected 167, got 5)
>>
>> In order to avoid that, move the CPU *initialization* in the
>> SoC DeviceRealize handler, so the SoC initialization won't
>> fail, while realization still will.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/bcm2836.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
>> index cd61ba15054..6e4066f137d 100644
>> --- a/hw/arm/bcm2836.c
>> +++ b/hw/arm/bcm2836.c
>> @@ -25,12 +25,7 @@ static void bcm283x_base_init(Object *obj)
>>   {
>>       BCM283XBaseState *s = BCM283X_BASE(obj);
>>       BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(obj);
>> -    int n;
>>
>> -    for (n = 0; n < bc->core_count; n++) {
>> -        object_initialize_child(obj, "cpu[*]", &s->cpu[n].core,
>> -                                bc->cpu_type);
>> -    }
>>       if (bc->core_count > 1) {
>>           qdev_property_add_static(DEVICE(obj), &bcm2836_enabled_cores_property);
>>           qdev_prop_set_uint32(DEVICE(obj), "enabled-cpus", bc->core_count);
>> @@ -65,6 +60,11 @@ bool bcm283x_common_realize(DeviceState *dev, BCMSocPeripheralBaseState *ps,
>>       BCM283XBaseClass *bc = BCM283X_BASE_GET_CLASS(dev);
>>       Object *obj;
>>
>> +    for (int n = 0; n < bc->core_count; n++) {
>> +        object_initialize_child(OBJECT(dev), "cpu[*]", &s->cpu[n].core,
>> +                                bc->cpu_type);
>> +    }
>> +
> 
> This seems a bit odd to me. Yes, object instance_init isn't
> allowed to fail. But it's OK for one object to init another
> in its own init method, exactly because of this. And even
> if we do move this, the failure won't cause the realize
> method to fail cleanly, because object_initialize_child()
> doesn't return a failure message.
> 
> The problem as described in the commit message seems to be
> fairly general: we have effectively blacklisted some types
> as "not really creatable", but we haven't got a mechanism for
> propagating that to other types that unconditionally use those.
> Working around this problem by moving child init from
> init to realize in parent classes is going to result in
> a lot of weird parent classes that do work in realize that
> ought to be in init.
> 
> I think we should either:
> (1) find a way to propagate the "this type doesn't really
> exist for this binary" downwards
> (2) allow the "shouldn't really exist types" to be created
> programmatically, but just don't advertise them to the user.

Maybe we could have a DEFINE_TYPES_IF_ARCH(arch, ...) macro that uses
"if (qemu_arch_available(arch)) { ... }" internally, and then replace the 
DEFINE_TYPES() in hw/arm/bcm2836.c with that macro?

  Thomas


