Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F8BC55AB9
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Feb 2026 12:13:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vtPNt-0001n1-H0; Fri, 20 Feb 2026 07:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vtPNM-0001c5-3C
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 07:12:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1vtPNJ-00083T-WC
 for qemu-devel@nongnu.org; Fri, 20 Feb 2026 07:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771589567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a6WnYkUv+1p2RXUoYer9jX6Ro906Av76rOQTzY8hn48=;
 b=RQA5LcYiquEiuV3yr6KMg2yaxT3olW/TQ6RsqCFzfL8+/8NESH1zoJHjifMq+hU+k9DBCV
 mSMA/AMxEz/c+6cSpI6MZRZJZGOcsvHDdfc32nZs53+pNi4dLZwHeSY9ihuBQbriOMOk03
 Z7ydDns6Sa6ltq0LqGRVpwYJ/BsNrEM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-KEE1j4OaPLSQJfA0wiAiLg-1; Fri, 20 Feb 2026 07:12:46 -0500
X-MC-Unique: KEE1j4OaPLSQJfA0wiAiLg-1
X-Mimecast-MFC-AGG-ID: KEE1j4OaPLSQJfA0wiAiLg_1771589565
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837cee2e9bso15887635e9.3
 for <qemu-devel@nongnu.org>; Fri, 20 Feb 2026 04:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771589565; x=1772194365; darn=nongnu.org;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=a6WnYkUv+1p2RXUoYer9jX6Ro906Av76rOQTzY8hn48=;
 b=f8eVumYGHmeblqyWAmhkpsljIx1DShk9bn/mCnPODTWn/FKztWV88s7KouVVfE5Bfu
 1Pu/7F+aXQo99f+0eJs5asfMBwDNwaxZV57etUylT471FUhegzARqm5oUNyae/H7ylu+
 kAjlfkVvrozAIwzkSNK2Geo+mDbtksHJHQ+M2lOtsVazY2dGV1bZOMqnR/afr9KXayck
 /amJJMkTMZ5OpsrMQzxAp0UwS0FcnEkATy135x0plApIOCy01tsXLSD7yS7Ys9PkY/DY
 BreqH/w+jy4gNiquvqPrzPIcYp7BMS2y7ZBRejhjWS6UyvgAh40+Oo4xQr/79DP+HsoW
 pn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771589565; x=1772194365;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=a6WnYkUv+1p2RXUoYer9jX6Ro906Av76rOQTzY8hn48=;
 b=KzMYRpkY26vuKbYmgZ08d7Z+exGK6uGWqjJibYFn05CiWGaciFG1QB1KZVCOWlFeur
 p/C6zS4wEwHQIxSVMsGT4ZpbW/e3ROtX26GpRuoCXdxXUdustNzENO52CoRzfV+B7U7C
 IJ+RTuvMIGujxU9jnJjTSd08EU6/J7B5kwbpnyBDSb5z6zBrDMEKfeDQLtdYwuMw20dQ
 SaQ1BQUTwVzyh2MgoRT4d6KjLKHJ0GHviKF8DtVgoaR0Bu0A7E27UZbLDImXLs/dvJrW
 qtI6IOk9ilmKNszk7qtW6oGGeK0YIJEw41NbCYN0KxjODwaN4t5jznhXhbnuY5b/oGCH
 uimQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXJ65ULq3fjg/5VL0MKVt5IOUP2vWkd59794fWAFdAd+QiScgIftRooZ6UjHZPWWNe1ZVqcdG+HSF0h@nongnu.org
X-Gm-Message-State: AOJu0YwUE6v0Yq3+aPaiwQi4Gt/yHAEAGGSIwwyQ9Kz4vlrKAXwTy2C/
 a3WvpCiqYRpkaEvMvbvfFZA4FlwZNzUYxA5LSTQQll0GEbOk+hcgBFzhglipkhR4Vo4s2ffeEaz
 MYmkIpXw3v5XGLyyhq6E+yFB21Nk/nvwCVuvBIX4js9gTpkLtY2La2ANe
X-Gm-Gg: AZuq6aIAAi6gqEMwRRAlcyyyG2HWhZshbckQuoi9iVF3JNu2U/TQa/PXUZf5YMeQhv7
 TZ/We4xE4a2DCH/UVKONvNqT6H+Jp8XBzsTQ1ei6WUqApPhpVxyWCDtG78QAnuB4IpLtpbQP3LB
 sHR17YjdmsjAPGmrbr6l3ytJhjVoVhtQe54lqpKD1ll46Ohdy6Rxhbhgxdb6uYskURxGASHkO1g
 tdO64XJEI1/RTekSkUZThp8US5P2qBA7DF8QGlJD2ZFJoia7NY8U/EvczXUwDkMv8iXCB5qJ/ya
 pkzkdK/5XHG8sxwD9LARWu+AQhCxg5beaToASTczJFekVZo39WIjnHFGZslkd8Bei/48xKSk+Zd
 6JinE/x4OAGv4gsmh9Crmkme+DtxXfCjrJDqDEC7n2fGdXr6PssjfkpwAyoocJTzX1TavaSs=
X-Received: by 2002:a05:600c:5491:b0:480:1c2f:b003 with SMTP id
 5b1f17b1804b1-48379bfd732mr370818685e9.20.1771589564991; 
 Fri, 20 Feb 2026 04:12:44 -0800 (PST)
X-Received: by 2002:a05:600c:5491:b0:480:1c2f:b003 with SMTP id
 5b1f17b1804b1-48379bfd732mr370818155e9.20.1771589564568; 
 Fri, 20 Feb 2026 04:12:44 -0800 (PST)
Received: from rh (p200300f6af2d8700b4c2d356c3fafe63.dip0.t-ipconnect.de.
 [2003:f6:af2d:8700:b4c2:d356:c3fa:fe63])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483a316eb08sm77575655e9.0.2026.02.20.04.12.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Feb 2026 04:12:44 -0800 (PST)
Date: Fri, 20 Feb 2026 13:12:43 +0100 (CET)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
cc: Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>, 
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, 
 kvmarm@lists.linux.dev
Subject: Re: [PATCH v4 2/2] target/arm/kvm: add kvm-psci-version vcpu property
In-Reply-To: <CAFEAcA8V9bjQUzUYAW7qj5fEn_f9xaPJAYpTRgvdaFq0cY3pRA@mail.gmail.com>
Message-ID: <a4fffa2d-119a-cd78-44b6-b0c53d873833@redhat.com>
References: <20251202160853.22560-1-sebott@redhat.com>
 <20251202160853.22560-3-sebott@redhat.com>
 <CAFEAcA8oi1Xs2kv66dFV9NZore+Q2vHUsgMikveVdN1c+3SBJQ@mail.gmail.com>
 <9b04a20f-b708-208d-1e4e-466ec30b7bb9@redhat.com>
 <CAFEAcA-A+zW=QFdCY7z==+Z=xXfhJvPeyHhbG_MpEmpkQfrmaw@mail.gmail.com>
 <4e9470d5-ef3e-cf5c-4117-fb589d56323c@redhat.com>
 <CAFEAcA8V9bjQUzUYAW7qj5fEn_f9xaPJAYpTRgvdaFq0cY3pRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 16 Feb 2026, Peter Maydell wrote:
> On Wed, 11 Feb 2026 at 16:04, Sebastian Ott <sebott@redhat.com> wrote:
>>
>> On Wed, 11 Feb 2026, Peter Maydell wrote:
>>> On Wed, 11 Feb 2026 at 15:37, Sebastian Ott <sebott@redhat.com> wrote:
>>>>
>>>> On Fri, 6 Feb 2026, Peter Maydell wrote:
>>>>> On Tue, 2 Dec 2025 at 16:09, Sebastian Ott <sebott@redhat.com> wrote:
>>>
>>>>>> +static char *kvm_get_psci_version(Object *obj, Error **errp)
>>>>>> +{
>>>>>> +    ARMCPU *cpu = ARM_CPU(obj);
>>>>>> +    const struct psci_version *ver;
>>>>>> +
>>>>>> +    for (ver = psci_versions; ver->number != -1; ver++) {
>>>> [...]
>>>>>> +        if (ver->number == cpu->psci_version)
>>>>>> +            return g_strdup(ver->str);
>>>>>> +    }
>>>>>> +
>>>>>> +    return g_strdup_printf("Unknown PSCI-version: %x", cpu->psci_version);
>>>>>
>>>>> Is this ever possible?
>>>>
>>>> Hm, not sure actually - what if there's a new kernel/qemu implementing
>>>> psci version 1.4 and then you migrate to a qemu that doesn't know about
>>>> 1.4?
>>>
>>> Oh, I see -- we're reporting back cpu->psci_version here, which
>>> indeed could be the value set by KVM. I misread and assumed
>>> this was just reading back the field that the setter sets,
>>> which is kvm_prop_psci_version (and which I think will only
>>> be set via the setter and so isn't ever a value the setter
>>> doesn't know about).
>>>
>>> That does flag up a bug in this patch, though: if I set
>>> a QOM property via the setter function and then read its
>>> value via the getter function I ought to get back what
>>> I just wrote.
>>>
>>
>> Meaning this should be something like below?
>>
>> static char *kvm_get_psci_version(Object *obj, Error **errp)
>> {
>>      ARMCPU *cpu = ARM_CPU(obj);
>>
>>      return g_strdup_printf("%d.%d",
>>         (int) PSCI_VERSION_MAJOR(cpu->kvm_prop_psci_version),
>>         (int) PSCI_VERSION_MINOR(cpu->kvm_prop_psci_version));
>
> I guess we need to define what we want. Things we need:
>
> - user/QMP/etc setting a value and reading it back should
>   get back what they set
> - QEMU needs to keep working on a new kernel that defines a
>   new PSCI version in the future
> - user reading the default value and then writing it back
>   should succeed
>
> Things we might like:
> - ideally the setter would fail if the user picks a version
>   KVM can't support, but I don't think we can conveniently
>   determine this, so "fail vcpu init" may be as good as we
>   can get without unnecessarily large amounts of effort
>
> I think this probably adds up to:
> - setter should accept any a.b value (for a,b fitting in [0,65535])
> - getter can handle any value and turn it into a.b
> - make sure that setting it to an invalid value gives a helpful
>   error on vcpu start
>
> Doing it this way, do we need a separate cpu->kvm_prop_psci_version,
> or could we directly read and write cpu_>psci_version ?
>

Thanks for your suggestions! I've implemented them all and sent out a V6.

Sebastian


