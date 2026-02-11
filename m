Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3B4ECD6C3
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 16:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqChf-0001nO-V1; Wed, 11 Feb 2026 11:04:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vqChd-0001ml-WB
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:04:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vqChb-0005sf-8W
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 11:04:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770825870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5KpC7yaqnmPgfObvDWEmIArdNjIVjuTr6fFxuFr8Hdk=;
 b=FVQus8uqgehpxXP2IYKnvBMGDF4XTCcAP8/TKS2qmaaNsAqxKjJys3OxMYn8GQfGduQ4wj
 uDZn/u7SCVer1Ld4BOfHT5oAr4uVOgeQadZjULcrzblRFtcS45OdIaAcRX+xyANAw7a5ZM
 qFH6Wl0Jn2UKWr1x/BEQXIv0BNoaGFU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-2ZT5EwlpM1O5EZThJ1oZOA-1; Wed, 11 Feb 2026 11:04:29 -0500
X-MC-Unique: 2ZT5EwlpM1O5EZThJ1oZOA-1
X-Mimecast-MFC-AGG-ID: 2ZT5EwlpM1O5EZThJ1oZOA_1770825868
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-47ee432070aso51469175e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 08:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770825868; x=1771430668; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=5KpC7yaqnmPgfObvDWEmIArdNjIVjuTr6fFxuFr8Hdk=;
 b=VtiYefjeT/nFb/5MYTg0PJPK0zkkI4gJChMDbSxsEYeIAz6BWoFjZKOV8W3m8wbTHB
 aEp6vglJf9g5gaCDqWZsM8GPY0vBCAOEdioTMltUGt2pYTip6TYaFSTp14vGFtlL4dsi
 l/KqHb2y5OShm4RHbRAj5MmWz31M6GZbeNdDf/LytBO/SZ2g/dTWgAUttclapg1J5LNV
 Y3cE4yAfMoGB5BRx8R5aaFzJJd28xIEoWHtYUca5KSesbx2vKFudPTQQ+kcAxj1JsMPz
 NnwaY9spXj8fBAZeMUi9707fQd8BwPEzHMOTDTQt4zfCL+UEf5pz19JlXvtiimyFqNhT
 /KjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770825868; x=1771430668;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5KpC7yaqnmPgfObvDWEmIArdNjIVjuTr6fFxuFr8Hdk=;
 b=n/bnJSn2sC4KrJOgn4OPLL7aPidlLbx1hCxLIF2P1lmxuu1u3HQvaMJcGhtvJWTF+X
 wWn3euxbASAqjdONXMs8TWH1wA2Da1QPUqtondF3WC8BLo+GJI9BDe488sTTZlzPcJG9
 x26gCMm92Uaydo8EYpPQ/jxCp6MVmuBuyNFSHpCEeWdUu2wKMQwng4ND91DqUw4PFrSw
 ywa0r0fYQ9goXhvmsKqFCAlCv4jsB83PVpcJ197ZSHs7a9ZcM4HFQIjHhrLKwLfIYNc+
 +8FzpztJLKvkEnKCrvVb4FnroSWA1lKZS+MvcH7e3UOmMkn8DHWeV0C4d4PbpPcgH7Sl
 Puhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMpTW7D73QyNLVjvM9a/e70r63L5Y0cQ7RjGVYZe2CcCE9ptJcVMrHvLYjPSpwuAKaZMpe9kfRuRBL@nongnu.org
X-Gm-Message-State: AOJu0YyPG4y8JvHSWyJ6j4kXYAzK3De2elhaaYFdGRgWckriXn9G93uW
 zDKay2jwC7xeK4VLk0isVHmEJN77upSnsOIsr/5VJTwL4+C1xiZDUWdGoxCFyOeshHeRbyV1mZz
 QiT6IK2ShQM37OxdLphRE4H8U7XVn4EY80i5NGW2qxonz2bXvEsOpORX4
X-Gm-Gg: AZuq6aI45q/lksVVhcHmLepf67brtnm1iCwA1bOgygiDjbP+D3psEmBUpEXBf1Fs3l8
 eexdVdsJKkbDoVz5itMobY2wQ4p0UhhBNNiDiACc1U6audUTj+r3GAcWuAiFsI9/XvcOxnlXeNE
 MXBsoKYGsa2vS1iaUC0yBJSMvww5ZzIHi40sqTnFo4zigJEtQCTko4S01mU0i6DI4auzIM/19Ma
 YYoofSigZDqkVAs6tdgbNqMBSrXnxaV1k6A/kSbs61kDSzTD6EDT86mETi4PuHvnoPDVt1Ha2jW
 K7j+WmqbdmO47kNDirdf1Yn41+ciCzy6WISHCy7+OwGAnSUcexOerR2HSZglAiFHCi4fTU6O+yP
 qdcvE9ddEQ35AbAQHK2ByiC7+BNOkDUrscULW75/L1Thkvp0E8TOHBv6oZQX9kCF3SwugZOk=
X-Received: by 2002:a05:600c:46d0:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-4835b96ec32mr36898565e9.28.1770825867293; 
 Wed, 11 Feb 2026 08:04:27 -0800 (PST)
X-Received: by 2002:a05:600c:46d0:b0:45d:f81d:eae7 with SMTP id
 5b1f17b1804b1-4835b96ec32mr36897035e9.28.1770825865304; 
 Wed, 11 Feb 2026 08:04:25 -0800 (PST)
Received: from rh (p200300f6af2d8700b4c2d356c3fafe63.dip0.t-ipconnect.de.
 [2003:f6:af2d:8700:b4c2:d356:c3fa:fe63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835d92267bsm70932155e9.0.2026.02.11.08.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 08:04:24 -0800 (PST)
Date: Wed, 11 Feb 2026 17:04:23 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 2/2] target/arm/kvm: add kvm-psci-version vcpu property
In-Reply-To: <CAFEAcA-A+zW=QFdCY7z==+Z=xXfhJvPeyHhbG_MpEmpkQfrmaw@mail.gmail.com>
Message-ID: <4e9470d5-ef3e-cf5c-4117-fb589d56323c@redhat.com>
References: <20251202160853.22560-1-sebott@redhat.com>
 <20251202160853.22560-3-sebott@redhat.com>
 <CAFEAcA8oi1Xs2kv66dFV9NZore+Q2vHUsgMikveVdN1c+3SBJQ@mail.gmail.com>
 <9b04a20f-b708-208d-1e4e-466ec30b7bb9@redhat.com>
 <CAFEAcA-A+zW=QFdCY7z==+Z=xXfhJvPeyHhbG_MpEmpkQfrmaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, 11 Feb 2026, Peter Maydell wrote:
> On Wed, 11 Feb 2026 at 15:37, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> Hi Peter,
>>
>> On Fri, 6 Feb 2026, Peter Maydell wrote:
>>> On Tue, 2 Dec 2025 at 16:09, Sebastian Ott <sebott@redhat.com> wrote:
>
>>>> +static char *kvm_get_psci_version(Object *obj, Error **errp)
>>>> +{
>>>> +    ARMCPU *cpu = ARM_CPU(obj);
>>>> +    const struct psci_version *ver;
>>>> +
>>>> +    for (ver = psci_versions; ver->number != -1; ver++) {
>> [...]
>>>> +        if (ver->number == cpu->psci_version)
>>>> +            return g_strdup(ver->str);
>>>> +    }
>>>> +
>>>> +    return g_strdup_printf("Unknown PSCI-version: %x", cpu->psci_version);
>>>
>>> Is this ever possible?
>>
>> Hm, not sure actually - what if there's a new kernel/qemu implementing
>> psci version 1.4 and then you migrate to a qemu that doesn't know about
>> 1.4?
>
> Oh, I see -- we're reporting back cpu->psci_version here, which
> indeed could be the value set by KVM. I misread and assumed
> this was just reading back the field that the setter sets,
> which is kvm_prop_psci_version (and which I think will only
> be set via the setter and so isn't ever a value the setter
> doesn't know about).
>
> That does flag up a bug in this patch, though: if I set
> a QOM property via the setter function and then read its
> value via the getter function I ought to get back what
> I just wrote.
>

Meaning this should be something like below?

static char *kvm_get_psci_version(Object *obj, Error **errp)
{
     ARMCPU *cpu = ARM_CPU(obj);

     return g_strdup_printf("%d.%d",
 	(int) PSCI_VERSION_MAJOR(cpu->kvm_prop_psci_version),
 	(int) PSCI_VERSION_MINOR(cpu->kvm_prop_psci_version));
}


