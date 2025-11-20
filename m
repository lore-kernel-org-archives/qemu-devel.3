Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691CFCF857B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 10:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM1cc-00033c-FJ; Thu, 20 Nov 2025 05:10:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vM1ca-00033L-Fs
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:10:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1vM1cY-00066H-32
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 05:10:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763633431;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HeoDb+vlF915PRVllvP6sQ90CREKCg4bhArXpU7WssA=;
 b=IJdJPavz+Az5rLY4+oSBtsLvR+AiDmKSWBIoOhQcoxNgdaNw0RaH2dqZO4x65Lda3YcE5z
 4b6GZMOhVj0i2ElW8edx42slOzheHspVviwquG3gRN9gyDYE99DY29DrUQaaiYI+ErTemu
 WQWbLAMrOolTWJF7VEN9I8Vopj4c24s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-rvUsgwWwMMaN_WHgaXYxeQ-1; Thu, 20 Nov 2025 05:10:29 -0500
X-MC-Unique: rvUsgwWwMMaN_WHgaXYxeQ-1
X-Mimecast-MFC-AGG-ID: rvUsgwWwMMaN_WHgaXYxeQ_1763633428
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-47496b3c1dcso7453845e9.3
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 02:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763633428; x=1764238228;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HeoDb+vlF915PRVllvP6sQ90CREKCg4bhArXpU7WssA=;
 b=v0xid2++5YFMoIjGuE5iZt1lfxs298zWmMBvXsqZ0LvTwkU24MZ0hX0k06S7WHyz6d
 Y+runHr9G/b4OaaJ1+gomBtuwsDI66XTPQmgoIBVB3yfre/hm/LOpkvwQhIlwdsfmp2G
 CdJi4jS+xruQNUSnliDO2kN2m7yaJDXqfpWtkorpcN48yeNxXUhj2Xt/JBSCV3OBYPAE
 j2jZcQ8pfpn6NNuobb2eEtW4fHLiBYTSwLg22LnqE8S5QoC3GNMR1DZv9H9Pi0u222qf
 /A50hegM9Oqeti/XVDvk514VFK5Thi302JCkTFJj+ujh8F6lCNQRHUck+i9/15M/4Zhc
 8VXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgnMqvtMwwSN4W5nDKuB0KD7GZTUqiuVsjwkkyAdSiGWRzfwnLuIyMuVtSxktrjW29GxHXBTmxXH1I@nongnu.org
X-Gm-Message-State: AOJu0YweP/h/I94ptqTvAXdwegHnYge8BIcYTtJLoHPX/dtG2zqsp5xk
 lf7UR0xkvX0bxnwUdRHUuV96H+q2O711fNKHkD1x3wzXdIqPPyCB9hYMDmdmarZRHfIlCAHDawp
 xL0CSClbBICq7rg04CvAQt20mk7KIyJ7OvN2mde0V3PVLnotBolUKAiPl
X-Gm-Gg: ASbGncvHzb+W/UrhrE+pCjd2F9ryA+QPfhiRYHbOgimGYAYgciwbGaryCDEgzlcAJGJ
 Zy4ZL+sf8oHfUwKwdOUFAcKGidjliBY14fl/jxZvUYOturUYHN2RK9k4JK0vKjub8EUmiX7Fhqm
 HkKiRJkFCHsbbvaOXUEMMrVk6Ph26q5J/y/1pTT+yNGtPk09tyOuMRXNFJSOsqukwJpJBXcLKAf
 02zh0jhgl7cmmD0hNQtCcJz8A7NWzjO5vuuvfNk+VgklgUXO3UoSgJUuGlzv1EtHNWCG0MRQFyX
 HBzHAaCYF2ZRcqeX55lITUlTKOW7tQyfgh2u+AxVTKjL0j1murk82bjMGT1N2tl3azUuYsoimsL
 0FIqYuF/XSnOMhujZ7LSnY6Fb9AYLYYMbFSjUCtD74YbG8NwqBwBGBsbMwg==
X-Received: by 2002:a05:600c:1d26:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-477b9e2bcb6mr19350435e9.24.1763633428207; 
 Thu, 20 Nov 2025 02:10:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn8i/nIi7fng7vNcKrFRWxYoraaRwDoQuaqyZbsNoVahq6dZkJgw5xsH9XpdRKx7HNqjDlIA==
X-Received: by 2002:a05:600c:1d26:b0:471:1717:411 with SMTP id
 5b1f17b1804b1-477b9e2bcb6mr19349995e9.24.1763633427742; 
 Thu, 20 Nov 2025 02:10:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a96a58c5sm64071555e9.0.2025.11.20.02.10.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Nov 2025 02:10:26 -0800 (PST)
Message-ID: <a2d0ddf1-f00c-42dd-851d-53f2ec789986@redhat.com>
Date: Thu, 20 Nov 2025 11:10:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] target/arm/kvm: add kvm-psci-version vcpu property
Content-Language: en-US
To: Sebastian Ott <sebott@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev
References: <20251112181357.38999-1-sebott@redhat.com>
 <20251112181357.38999-3-sebott@redhat.com>
 <d4f17034-94d9-4fdb-9d9d-c027dbc1e9b3@linaro.org>
 <c082340f-31b1-e690-8c29-c8d39edf8d35@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <c082340f-31b1-e690-8c29-c8d39edf8d35@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/13/25 1:05 PM, Sebastian Ott wrote:
> Hi Philippe,
>
> On Wed, 12 Nov 2025, Philippe Mathieu-Daudé wrote:
>> On 12/11/25 19:13, Sebastian Ott wrote:
>>>  Provide a kvm specific vcpu property to override the default
>>>  (as of kernel v6.13 that would be PSCI v1.3) PSCI version emulated
>>>  by kvm. Current valid values are: 0.1, 0.2, 1.0, 1.1, 1.2, and 1.3
>>>
>>>  Note: in order to support PSCI v0.1 we need to drop vcpu
>>>  initialization with KVM_CAP_ARM_PSCI_0_2 in that case.
>>>
>>>  Signed-off-by: Sebastian Ott <sebott@redhat.com>
>>>  ---
>>>    docs/system/arm/cpu-features.rst |  5 +++
>>>    target/arm/cpu.h                 |  6 +++
>>>    target/arm/kvm.c                 | 64
>>> +++++++++++++++++++++++++++++++-
>>>    3 files changed, 74 insertions(+), 1 deletion(-)
>>
>>
>>>  diff --git a/target/arm/kvm.c b/target/arm/kvm.c
>>>  index 0d57081e69..e91b1abfb8 100644
>>>  --- a/target/arm/kvm.c
>>>  +++ b/target/arm/kvm.c
>>>  @@ -484,6 +484,49 @@ static void kvm_steal_time_set(Object *obj, bool
>>>  value, Error **errp)
>>>        ARM_CPU(obj)->kvm_steal_time = value ? ON_OFF_AUTO_ON :
>>>    ON_OFF_AUTO_OFF;
>>>    }
>>>
>>>  +struct psci_version {
>>>  +    uint32_t number;
>>>  +    const char *str;
>>>  +};
>>>  +
>>>  +static const struct psci_version psci_versions[] = {
>>>  +    { QEMU_PSCI_VERSION_0_1, "0.1" },
>>>  +    { QEMU_PSCI_VERSION_0_2, "0.2" },
>>>  +    { QEMU_PSCI_VERSION_1_0, "1.0" },
>>>  +    { QEMU_PSCI_VERSION_1_1, "1.1" },
>>>  +    { QEMU_PSCI_VERSION_1_2, "1.2" },
>>>  +    { QEMU_PSCI_VERSION_1_3, "1.3" },
>>>  +    { -1, NULL },
>>>  +};
>>
>>
>>>  @@ -505,6 +548,12 @@ void kvm_arm_add_vcpu_properties(ARMCPU *cpu)
>>>                                 kvm_steal_time_set);
>>>        object_property_set_description(obj, "kvm-steal-time",
>>>                                        "Set off to disable KVM steal
>>>  time.");
>>>  +
>>>  +    object_property_add_str(obj, "kvm-psci-version",
>>>  kvm_get_psci_version,
>>>  +                            kvm_set_psci_version);
>>>  +    object_property_set_description(obj, "kvm-psci-version",
>>>  +                                    "Set PSCI version. "
>>>  +                                    "Valid values are 0.1, 0.2,
>>> 1.0, 1.1,
>>>  1.2, 1.3");
>>
>> Could we enumerate from psci_versions[] here?
>>
>
> Hm, we'd need to concatenate these. Either manually:
> "Valid values are " psci_versions[0].str ", " psci_versions[1].str ",
> " ... which is not pretty and still needs to be touched for a new
> version.
>
> Or by a helper function that puts these in a new array and uses smth like
> g_strjoinv(", ", array);
> But that's quite a bit of extra code that needs to be maintained without
> much gain.
>
> Or we shy away from the issue and rephrase that to:
> "Valid values include 1.0, 1.1, 1.2, 1.3" 
Personally I would vote for keeping it as is (by the way why did you
moit 0.1 and 0.2 above?)

Eric
>
> Since the intended use case is via machine types and I don't expect a
> lot of users setting the psci version manually - I vote for option 3.
>
> Opinions?
>
> Sebastian


