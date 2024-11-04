Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A205AD132DF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 15:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7zO9-0002hj-JL; Mon, 04 Nov 2024 10:53:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t7zO7-0002g5-7L
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:53:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1t7zO3-00065h-PK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 10:53:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730735582;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7mUA65axYf94RHzQ+FsEaE5eP349wKq6vreKY/gkmjE=;
 b=X+Agbtwxe6HdQ8bJHrhPQNtQBmnyHpe39qSdwqZ1Hhv3yZOuVFGS5vj6WQgdl+MFLhWWI5
 y9qR61t91H47Mw2xU1kNEppUauWXpO504lT1LfRzh53WLdZRHAX72zpA7Zjolp7lpTBVSi
 YPMRlOaNiOwbZAGs/eGElcHB6Hcj8Yw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-ASk_Tt4GNlaiYJ9IN22ofw-1; Mon, 04 Nov 2024 10:52:59 -0500
X-MC-Unique: ASk_Tt4GNlaiYJ9IN22ofw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-431673032e6so26534425e9.0
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 07:52:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730735578; x=1731340378;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7mUA65axYf94RHzQ+FsEaE5eP349wKq6vreKY/gkmjE=;
 b=kb7qe7RD9/xcvEkOUiLQwJk5JquS4mLwmUotFhxkPTvCFC6ciU1bKVLEmK19tydMnR
 QdCw1MF2H4xlZg6ZD8FoVsOAto2UkS8a7RN6bhGgerNhjZflaB+lmCbp4mqSeV4Kv2Sh
 e9xYy6avPeJBVwJvtrdQqhz/AlF3hregW/9F2pehVe034xCdvAoGxbHGKAmrT0mFWjT2
 zdNtFDP+CxdmZhe9Pi/EEPHLhz9hDnrBeHP0r774AuUrmazDTJqpYQavDwWxgsYOqgIe
 EFz58+5QZ31JJefkcT4jeT06KbmnveEF4uNDNBjFVYiQEeDph//RrxiEtF7mNWowE9eF
 F4Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvs/MH8O6jfHCNSauXloQik6p7tW4S1KJHt0y5JBeGdBJvqwTKLqzpdC+81+k0cGUPlWHgW84dsW+2@nongnu.org
X-Gm-Message-State: AOJu0YwqqgW64U5i7sAM8V1/GNya3CxRLNTRH9ywq99BCDCne55HaDOG
 +F+pyZCsuRliIl/nPmELePM4OKTR+Aho3q5L7FvBHiAuPuncOS4Ed+wRb/3lPuyLenFYF/94UcC
 zQ6fPyyRAvsKXooqWcqJrqpN7PJJEoj4Xvr026S6PN7geVVI5fUF+
X-Received: by 2002:a05:600c:a01:b0:42c:ba83:3f01 with SMTP id
 5b1f17b1804b1-431bb984e8cmr179170755e9.8.1730735577940; 
 Mon, 04 Nov 2024 07:52:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHM/sgFkPsRHyrJgwZBk+yGqKXTJjw6x9koC6zrD0mNzXVobnNx8Sxn9ebXaRxRRr6GdAwKOw==
X-Received: by 2002:a05:600c:a01:b0:42c:ba83:3f01 with SMTP id
 5b1f17b1804b1-431bb984e8cmr179170445e9.8.1730735577520; 
 Mon, 04 Nov 2024 07:52:57 -0800 (PST)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d698144sm162050515e9.39.2024.11.04.07.52.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 07:52:56 -0800 (PST)
Message-ID: <0007b45a-0278-4dad-8b8f-a65bd0506dc2@redhat.com>
Date: Mon, 4 Nov 2024 16:52:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/21] kvm/arm: Introduce a customizable aarch64 KVM host
 model
Content-Language: en-US
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: eric.auger.pro@gmail.com, cohuck@redhat.com, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, kvmarm@lists.linux.dev, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, maz@kernel.org,
 oliver.upton@linux.dev, sebott@redhat.com,
 shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com,
 shahuang@redhat.com, mark.rutland@arm.com, philmd@linaro.org,
 pbonzini@redhat.com
References: <20241025101959.601048-1-eric.auger@redhat.com>
 <ZxuwZw2plMI6dNyE@pinwheel>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <ZxuwZw2plMI6dNyE@pinwheel>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Kashyap,
On 10/25/24 16:51, Kashyap Chamarthy wrote:
> On Fri, Oct 25, 2024 at 12:17:19PM +0200, Eric Auger wrote:
>
> Hi Eric,
>
> I'm new to Arm, so please bear with my questions :)
>
>> This RFC series introduces a KVM host "custom" model.
> (a) On terminology: as we know, in the x86 world, QEMU uses these
>     terms[1]:
>
>     - Host passthrough
>     - Named CPU models
>     - Then there's the libvirt abstraction, "host-model", that aims to
>       provide the best of 'host-passthrough' + named CPU models.
>
>     Now I see the term "host 'custom' model" here.  Most
>     management-layer tools and libvirt users are familiar with the
>     classic terms "host-model" or "custom".  If we now say "host
>     'custom' model", it can create confusion.  I hope we can settle on
>     one of the existing terms, or create a new term if need be.
>
>     (I'll share one more thought on how layers above libvirt tend to use
>     the term "custom", as a reply to patch 21/21, "arm/cpu-features:
>     Document custom vcpu model".)
agreed, as replied earlier, custom terminology most probably will be
dropped.
>
> (b) The current CPU features doc[2] for Arm doesn't mention "host
>     passthrough" at all.  It is only implied by the last part of this
>     paragraph, from the section titled "A note about CPU models and
>     KVM"[3]:
>
>       "Named CPU models generally do not work with KVM. There are a few
>       cases that do work [...] but mostly if KVM is enabled the 'host'
>       CPU type must be used."
indeed
>
>     Related: in your reply[4] to Dan in this series, you write: "Having
>     named models is the next thing".  So named CPU models will be a
>     thing in Arm, too?  Then the above statement in the Arm
>     'cpu-features' will need updating :-)

Yes named models implementing a baseline are the end goal.
>
> [...]
>
>> - the QEMU layer does not take care of IDREG field value consistency.
>>   The kernel neither. I imagine this could be the role of the upper
>>   layer to implement a vcpu profile that makes sure settings are
>>   consistent. Here we come to "named" models. What should they look
>>   like on ARM?
> Are there reasons why they can't be similar to how x86 reports in
> `qemu-system-x86 -cpu help`?  
>
> E.g. If it's an NVIDIA "Grace A02" (Neoverse-V2) host, it can report:
>
>     [gracehopper] $> qemu-kvm -cpu help
>     Available CPUs:
>       gracehopper-neoverse-v2
>       cortex-a57 (deprecated)
>       host
>       max
>
> Or whatever is the preferred nomenclature for ARM.  It also gives users
> of both x86 and ARM deployments a consistent expectation.  
>
> Currently on a "Grace A02" ("Neoverse-V2") machine, it reports:
>
>     [gracehopper] $> qemu-kvm -cpu help
>     Available CPUs:
>       cortex-a57 (deprecated)
>       host
>       max
>
> I see it's because there are no named models yet on ARM :-)
yes this is definitively because on ARM there is no such named KVM model
besides cortex-a57 on aarch64.
on x86 does it return the closest named model?

Thanks

Eric
>
> [...]
>
> [1] https://www.qemu.org/docs/master/system/i386/cpu.html
> [2] https://www.qemu.org/docs/master/system/arm/cpu-features.html
> [3] https://www.qemu.org/docs/master/system/arm/cpu-features.html#a-note-about-cpu-models-and-kvm
> [4] https://lists.nongnu.org/archive/html/qemu-arm/2024-10/msg00891.html
>
>


