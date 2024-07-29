Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89EB5C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYTle-0003WP-Ne; Mon, 29 Jul 2024 13:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYTld-0003Vu-M9
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:02:37 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYTlb-0003J3-FC
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:02:37 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fd6ed7688cso22843195ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722272553; x=1722877353;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kYS7BLzwEAyDvYLlkU5INYD7aCEorap0M7u6c3nK6jU=;
 b=dxy7YkAkEd+zBf/GfQewvKLPrwFWrM+xalgsm5PUAzfpefQDJoS2YAdkFYTTtPOllD
 ZbfkIJmnr/Q6Nv7lZyu9Bbn/1HfB5bqaIffcvc6Ydd/kkNCx5Sbl+wax8jR5kb/EzWLP
 EPW292r68GsvVTW4Hg4naihA4I6UUvwPv3lVEoDUJ9Aw+yTGud2qcaF0Vb3OlSOJi9/a
 irlxwdbXJXUYu3pD4M+aPl3ZAn6cLIV3hxBa5yQI2vHxmsjt4nsAMH1NjkWHJ7Y6LqOx
 KGId53xiSNeW+Uqg0s1D/WqTADbgOHr1J5ZsHdcM/nwVUTdmZlxoZIilvDKbMBDg/dY5
 JK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722272553; x=1722877353;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kYS7BLzwEAyDvYLlkU5INYD7aCEorap0M7u6c3nK6jU=;
 b=T1ZuI4ZM8SIMvxohJAcAmzwYo1C/EnkgkSoke29MhczUqyTw52a51XL8d/Y4uaPdr3
 v1P6VuKSTXowCrAsqskibpbe37eZi6SeKUybV1mHcpmWF8rnUqo+7YTHcCy5BJEIt+0T
 BOoTx3JMUDBq29edD/DqBZE9n7Xj+vNM1y3lVph3ZJ0xjQVybPKsE7PIfgGioWurvMO3
 6Q04eeJKggbu+pwdjpXA+7WdBPRhbkqvawnfyiJJOPQz1fqmU6mfrOYAsrvN6kXT+CNt
 /fgaQf3lrLRaUpem/NClT+7f9/DREvBZS4APf3LM9/Xik3e7OCH873I+EbQ0X54yPkt/
 iU5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEgj/ppDH24uXndSg8D4NoJuFVxVmi+vh0vjRitAF8D9FKBkcb+beB/DVAYlRgwLUubc4pyKjG4L0KKViJ7wDNJk0cZqc=
X-Gm-Message-State: AOJu0Yy57UIkiUTvvihL1yXMEoeyYBwZ+94s0DTuYlP7y25aB/7WY8F7
 Uuu3EekQuPameX4epgI0IqqiTSlKrS3MAnVYDT7gEmiP9u31CHkzJI5NWfjwWqs=
X-Google-Smtp-Source: AGHT+IGISGitUCFGsdHBbeE3pjkaT/c2zx2fZlRHYRfSD0kJIImPLTUoVLSEzY6UG20Bi/VB6tAT5g==
X-Received: by 2002:a17:902:ee8b:b0:1fd:d807:b29e with SMTP id
 d9443c01a7336-1ff048616f4mr58610135ad.35.1722272553043; 
 Mon, 29 Jul 2024 10:02:33 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7fcd252sm85212845ad.285.2024.07.29.10.02.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 10:02:31 -0700 (PDT)
Message-ID: <da9de7f6-da16-4858-b680-0e2ee15162dc@daynix.com>
Date: Tue, 30 Jul 2024 02:02:27 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>
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
 <Zqe8C9AfaojKHM8A@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Zqe8C9AfaojKHM8A@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
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

On 2024/07/30 0:58, Daniel P. Berrangé wrote:
> On Fri, Jul 26, 2024 at 04:47:40PM -0400, Peter Xu wrote:
>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
>>>
>>> In terms of launching QEMU I'd imagine:
>>>
>>>    $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
>>>
>>> Any virtual machine HW features which are tied to host kernel features
>>> would have their defaults set based on the requested -platform. The
>>> -machine will be fully invariant wrt the host kernel.
>>>
>>> You would have -platform hlep to list available platforms, and
>>> corresonding QMP "query-platforms" command to list what platforms
>>> are supported on a given host OS.
>>>
>>> Downstream distros can provide their own platforms definitions
>>> (eg "linux-rhel-9.5") if they have kernels whose feature set
>>> diverges from upstream due to backports.
>>>
>>> Mgmt apps won't need to be taught about every single little QEMU
>>> setting whose default is derived from the kernel. Individual
>>> defaults are opaque and controlled by the requested platform.
>>>
>>> Live migration has clearly defined semantics, and mgmt app can
>>> use query-platforms to validate two hosts are compatible.
>>>
>>> Omitting -platform should pick the very latest platform that is
>>> cmpatible with the current host (not neccessarily the latest
>>> platform built-in to QEMU).
>>
>> This seems to add one more layer to maintain, and so far I don't know
>> whether it's a must.
>>
>> To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
>> thought it was mostly the case already, except some extremely rare
>> outliers.
>>
>> When we have one host that boots up a VM using:
>>
>>    $QEMU1 $cmdline
>>
>> Then another host boots up:
>>
>>    $QEMU2 $cmdline -incoming XXX
>>
>> Then migration should succeed if $cmdline is exactly the same, and the VM
>> can boot up all fine without errors on both sides.
>>
>> AFAICT this has nothing to do with what kernel is underneath, even not
>> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
>> didn't, I thought the ABI should be guaranteed.
> 
> We've got two mutually conflicting goals with the machine type
> definitions.
> 
> Primarily we use them to ensure stable ABI, but an important
> secondary goal is to enable new tunables to have new defaults
> set, without having to update every mgmt app.  The latter
> works very well when the defaults have no dependancy on the
> platform kernel/OS, but breaks migration when they do have a
> platform dependancy.
> 
>>    - Firstly, never quietly flipping any bit that affects the ABI...
>>
>>    - Have a default value of off, then QEMU will always allow the VM to boot
>>      by default, while advanced users can opt-in on new features.  We can't
>>      make this ON by default otherwise some VMs can already fail to boot,
>>
>>    - If the host doesn't support the feature while the cmdline enabled it,
>>      it needs to fail QEMU boot rather than flipping, so that it says "hey,
>>      this host does not support running such VM specified, due to XXX
>>      feature missing".
>>
>> That's the only way an user could understand what happened, and IMHO that's
>> a clean way that we stick with QEMU cmdline on defining the guest ABI,
>> while in which the machine type is the fundation of such definition, as the
>> machine type can decides many of the rest compat properties.  And that's
>> the whole point of the compat properties too (to make sure the guest ABI is
>> stable).
>>
>> If kernel breaks it easily, all compat property things that we maintain can
>> already stop making sense in general, because it didn't define the whole
>> guest ABI..
>>
>> So AFAIU that's really what we used for years, I hope I didn't overlook
>> somehting.  And maybe we don't yet need the "-platform" layer if we can
>> keep up with this rule?
> 
> We've failed at this for years wrt enabling use of new defaults that have
> a platform depedancy, so historical practice isn't a good reference.
> 
> There are 100's (possibly 1000's) of tunables set implicitly as part of
> the machine type, and of those, libvirt likely only exposes a few 10's
> of tunables. The vast majority are low level details that no mgmt app
> wants to know about, they just want to accept QEMU's new defaults,
> while preserving machine ABI. This is a good thing. No one wants the
> burden of wiring up every single tunable into libvirt and mgmt apps.
> 
> This is what the "-platform" concept would be intended to preserve. It
> would allow a way to enable groups of settings that have a platform level
> dependancy, without ever having to teach either libvirt or the mgmt apps
> about the individual tunables.

The concept of -platform will certainly reduce the number of tunables, 
but I'm a bit worried that such platform definitions can still have too 
much variety.

The variety of kernel is one; a downstream distro can have 
linux-rhel-9.5 or something as you suggested, but it is still a chore. 
Some features like eBPF may need privilege. Others may depend on 
hardware features.

I think it is simpler to analyze the platform dependency and dump it for 
the management layer. For example, libvirt can request QEMU to analyze 
the platform dependency when it creates a new domain. QEMU will then 
figure out that the host kernel is capable of USO and bake it as a 
platform dependency.

Regards,
Akihiko Odaki

