Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63C2C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:24:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYU6H-0005KA-GP; Mon, 29 Jul 2024 13:23:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYU6F-0005JF-N5
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:23:55 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYU6D-0001w0-3B
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:23:55 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d19c525b5so2207633b3a.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722273832; x=1722878632;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eFu4sdBXCTPDoYVWDA2L/SQFWlfOrTdqMguNGjKna9U=;
 b=sLq0xyChj6BUyRwH+y/Act2vov4RgRcjrPhlYp088KgyFxbXFzqQ8j8UKgGgB3gE1s
 2VIpVvljGGElqqiqdFPZXZ/iARNY/FbxGQvXSB7DOZwoRZwCR5T0n1D/EfHxUY5JGGSA
 8XXz0cotdqRbGdBuZ7U5dg1JYCL2h9vdjQaDtX044LoTIcG5RXfYF/emHF1ALJ0yz9h7
 eF2xVqThlEj6Ry2gbit8OROg1Yd2BW3S2WYk0RyoscPatc6C02qYV0WeRubfHhhBlUwq
 T02ivYfx795qBBh0oabB7agDN1Yka/NWW/Pbh+NbO1tSnEAPJbwYDz+lf7QOdL6drhkX
 4ZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722273832; x=1722878632;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eFu4sdBXCTPDoYVWDA2L/SQFWlfOrTdqMguNGjKna9U=;
 b=taywDIDQN20xO8sF7aGjtQfqKiX5EeEW0ZGqjcQ1vof+SYG05cj2jvRB8a/EYyrgtr
 hOJ/PrOsnrUrRZeV+2vTgLLpUzvF5eYXbgFzUW7tf0AkEkPo4kCaGl/VjAQUZzdDbT6N
 GzsrRDxq+ICmBlEdKiEmON5/DNyNnVT773zxHpVpBZelY6y9aLCT6e1GUg/BjZaI2nb8
 FUWd1P0alcH9rw0g567lY2uJo3SOalN9724uiSjo77PEJJtn6KkkQau0fCZ04+k6soHm
 C3ZkgC8yJKelAruYRk5lutJiJA83AU7pjTWa0BH+PvQeu85LntdBKXPPWlanodS2WYFf
 HxwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI4MR0tc3JDM/vaP/OBo4pQktG82BlOPUKTfReBCSwrj6fNxdBS3mjGz8UaPR/fYlOMrUVFLgMerw0cHbXRyg58VDIxBw=
X-Gm-Message-State: AOJu0YzGeD3YoB+0vf5DGHI76Uhmr7jHsFA3HiLHmyCOnvR1lZEdzOym
 wgokbNc8l7p+8/zQcEWYdeEz1I9/tKdQjpCNOlIGxYoVkOXpdeXS1Z40BwcH7Xk=
X-Google-Smtp-Source: AGHT+IHBj1XSkVkEdwKD1ViLuyQzc3OxpP0oJhJcVWaNYgzn/Vl0v94xzk4kRBSG54wQItyVPpJQ1w==
X-Received: by 2002:a05:6a00:928e:b0:70d:2b23:a724 with SMTP id
 d2e1a72fcca58-70eced8beb5mr6141047b3a.23.1722273831559; 
 Mon, 29 Jul 2024 10:23:51 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead6e18dfsm7262692b3a.11.2024.07.29.10.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 10:23:51 -0700 (PDT)
Message-ID: <e66cb5d6-e74d-4f8a-a2c1-c10763acf12b@daynix.com>
Date: Tue, 30 Jul 2024 02:23:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 sw@weilnetz.de, qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com> <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <ZqfKrtQSSRVnEOGt@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/07/30 2:00, Peter Xu wrote:
> On Mon, Jul 29, 2024 at 04:58:03PM +0100, Daniel P. Berrangé wrote:
>> On Fri, Jul 26, 2024 at 04:47:40PM -0400, Peter Xu wrote:
>>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
>>>>
>>>> In terms of launching QEMU I'd imagine:
>>>>
>>>>    $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
>>>>
>>>> Any virtual machine HW features which are tied to host kernel features
>>>> would have their defaults set based on the requested -platform. The
>>>> -machine will be fully invariant wrt the host kernel.
>>>>
>>>> You would have -platform hlep to list available platforms, and
>>>> corresonding QMP "query-platforms" command to list what platforms
>>>> are supported on a given host OS.
>>>>
>>>> Downstream distros can provide their own platforms definitions
>>>> (eg "linux-rhel-9.5") if they have kernels whose feature set
>>>> diverges from upstream due to backports.
>>>>
>>>> Mgmt apps won't need to be taught about every single little QEMU
>>>> setting whose default is derived from the kernel. Individual
>>>> defaults are opaque and controlled by the requested platform.
>>>>
>>>> Live migration has clearly defined semantics, and mgmt app can
>>>> use query-platforms to validate two hosts are compatible.
>>>>
>>>> Omitting -platform should pick the very latest platform that is
>>>> cmpatible with the current host (not neccessarily the latest
>>>> platform built-in to QEMU).
>>>
>>> This seems to add one more layer to maintain, and so far I don't know
>>> whether it's a must.
>>>
>>> To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
>>> thought it was mostly the case already, except some extremely rare
>>> outliers.
>>>
>>> When we have one host that boots up a VM using:
>>>
>>>    $QEMU1 $cmdline
>>>
>>> Then another host boots up:
>>>
>>>    $QEMU2 $cmdline -incoming XXX
>>>
>>> Then migration should succeed if $cmdline is exactly the same, and the VM
>>> can boot up all fine without errors on both sides.
>>>
>>> AFAICT this has nothing to do with what kernel is underneath, even not
>>> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
>>> didn't, I thought the ABI should be guaranteed.
>>
>> We've got two mutually conflicting goals with the machine type
>> definitions.
>>
>> Primarily we use them to ensure stable ABI, but an important
>> secondary goal is to enable new tunables to have new defaults
>> set, without having to update every mgmt app.  The latter
>> works very well when the defaults have no dependancy on the
>> platform kernel/OS, but breaks migration when they do have a
>> platform dependancy.
>>
>>>    - Firstly, never quietly flipping any bit that affects the ABI...
>>>
>>>    - Have a default value of off, then QEMU will always allow the VM to boot
>>>      by default, while advanced users can opt-in on new features.  We can't
>>>      make this ON by default otherwise some VMs can already fail to boot,
>>>
>>>    - If the host doesn't support the feature while the cmdline enabled it,
>>>      it needs to fail QEMU boot rather than flipping, so that it says "hey,
>>>      this host does not support running such VM specified, due to XXX
>>>      feature missing".
>>>
>>> That's the only way an user could understand what happened, and IMHO that's
>>> a clean way that we stick with QEMU cmdline on defining the guest ABI,
>>> while in which the machine type is the fundation of such definition, as the
>>> machine type can decides many of the rest compat properties.  And that's
>>> the whole point of the compat properties too (to make sure the guest ABI is
>>> stable).
>>>
>>> If kernel breaks it easily, all compat property things that we maintain can
>>> already stop making sense in general, because it didn't define the whole
>>> guest ABI..
>>>
>>> So AFAIU that's really what we used for years, I hope I didn't overlook
>>> somehting.  And maybe we don't yet need the "-platform" layer if we can
>>> keep up with this rule?
>>
>> We've failed at this for years wrt enabling use of new defaults that have
>> a platform depedancy, so historical practice isn't a good reference.
>>
>> There are 100's (possibly 1000's) of tunables set implicitly as part of
>> the machine type, and of those, libvirt likely only exposes a few 10's
>> of tunables. The vast majority are low level details that no mgmt app
>> wants to know about, they just want to accept QEMU's new defaults,
>> while preserving machine ABI. This is a good thing. No one wants the
>> burden of wiring up every single tunable into libvirt and mgmt apps.
>>
>> This is what the "-platform" concept would be intended to preserve. It
>> would allow a way to enable groups of settings that have a platform level
>> dependancy, without ever having to teach either libvirt or the mgmt apps
>> about the individual tunables.
> 
> Do you think we can achieve similar goal by simply turning the feature to
> ON only after a few QEMU releases?  I also mentioned that idea below.
> 
> https://lore.kernel.org/r/ZqQNKZ9_OPhDq2AK@x1n
> 
> So far it really sounds like the right thing to do to me to fix all similar
> issues, even without introducing anything new we need to maintain.
> 
> To put that again, what we need to do is this:
> 
>    - To start: we should NEVER turn any guest ABI relevant bits
>      automatically by QEMU, for sure..
> 
>    - When introducing any new device feature that may both (1) affects guest
>      ABI, and (2) depends on host kernel features, we set those default
>      values to OFF always at start. So this already covers old machine
>      types, no compat property needed so far.
> 
>    - We always fail hard on QEMU boot whenever we detected such property is
>      not supported by the current host when with ON (and since it's OFF by
>      default it must be that the user specified that ON).
> 
>    - When after a stablized period of time for that new feature to land most
>      kernels (we may consider to look at how major Linux distros updates the
>      kernel versions) when we're pretty sure the new feature should be
>      available on most of the QEMU modern users, we add a patch to make the
>      property default ON on the new machine type, add a compat property for
>      old machines.
> 
> The last bullet also means we'll start to fail new machine type from
> booting when running that very new QEMU on a very old kernel, but that's
> the trade-off, and when doing it right on "stablizing the feature in the
> kernel world", it should really be corner case.  The user should simply
> invoke an old machine type on that old kernel, even if the qemu is new.

docs/about/build-platforms.rst already defines supported platforms. One 
of the supported platforms is Debian 11 (bullseye), and it carries Linux 
5.10, which was released December 2020. If we follow this platform 
support, a new feature added to upstream Linux may take about 4 years 
before it gets enabled by default on QEMU.

As an upstream developer, I feel it is too long, but I'm sure there are 
different opinions from different perspectives.

Regards,
Akihiko Odaki

