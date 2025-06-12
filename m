Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25070C71136
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Jun 2025 15:06:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPjUm-0005WQ-84; Thu, 12 Jun 2025 11:05:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPjUP-0005J1-EP
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uPjUM-0004nQ-W1
 for qemu-devel@nongnu.org; Thu, 12 Jun 2025 11:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749740708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DErl2PmW5XV63g+4ZRN820+qXuXU4DLA1b0SS6B9viQ=;
 b=Fj//UQqYWwxKZeX2rPd1MUtHdXN7lIwt2tIwJPkROdEcrt91ZXk6hshBdfTa4XEKA/f18I
 j2Hi/OqDekBYiDUx2SpqepPNnPdQEu6058//vY5FnzIF6GXYwlfrQDkuDueyLGWP3lX8Op
 Bf4K9rGuc02AQQAoqg5ouctGqZKAxUg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-zWAkaabpNBmjz2xyRnPgMg-1; Thu, 12 Jun 2025 11:05:07 -0400
X-MC-Unique: zWAkaabpNBmjz2xyRnPgMg-1
X-Mimecast-MFC-AGG-ID: zWAkaabpNBmjz2xyRnPgMg_1749740706
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4530ec2c87cso5336665e9.0
 for <qemu-devel@nongnu.org>; Thu, 12 Jun 2025 08:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749740706; x=1750345506;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DErl2PmW5XV63g+4ZRN820+qXuXU4DLA1b0SS6B9viQ=;
 b=gqVw3alGdv0Z9HOJkC72/RfbEyETcSOXeQIQV9GBNSrmbiLPO4pY6aUCE107MQ6qRQ
 ty/4gfsAg9RhDgLcndrd31rIIRE55OtNyZSj76a6tCft62lpEMw7S+PGJDqUQCtNkACd
 yI0NMyVZEo2kaoyDp2SIHU7EEPvAkutlxXl2eAlEcUnu4+F8BOIitaQzkLd+FRSwzd8u
 SLoO3BTbjq/A6nY0E5LqA55s9E34HMrtW5CZ2HMGpgBpIwgiqQ8kVkYThUQ5ocApWGgp
 L8YS4vRfO82TWlIzcqwGT/Rj1XbYySGOGeERIw40Q3jHxQHvKetKthSwj+GHmRVrwiAy
 y+og==
X-Gm-Message-State: AOJu0YyKMSmInnE/wdwj/Hzw+u3yvB0l9ZCKH93/vDO0w8Z2hh64DLLM
 c7qFo1xT1k969P4Y9zs5tr1fGabgetIcdd8hcBydYhpow5ue4PBzZ3+MRU5jmhkxIKCMgiiqWnx
 P/4yGyAp9dvjOK10un3lIWGUQBQZM00PXrRfBW0xxjnrBpdattkT6/KnP
X-Gm-Gg: ASbGncuwzSl7vVXRFvgQRvPKT+5SRmlnLESHMSdkMlN9torPFmQzlNFVlcEULpC1o1b
 y57Rl4HA5IWllTHYr7xoJ3hvoMi7H3iDXFqFt3F01yJ4tANpLBCeGYT0iTSjNsmEstalGQIPmjR
 6UwDSYaRYGx3U3lXR+GyksCkz6eZt6PHIVByZMFhMuTvdrvnm2a/cRJsO6chfYnta85RZ3XTxlX
 7avv2ItEg09vGQr+eG7tBMatQIpcg4WILCAoS/fGwW2OGX4ausPGPP18yr2d45VmIsllGehBgeu
 EJuiQVljBHFjMYj0cFUaXROt8wXYaDZD2id6kM0d/gwIY7EVAnPPDoISCQ4f9/k=
X-Received: by 2002:a05:600c:1e2a:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-4532b952215mr43973245e9.18.1749740705685; 
 Thu, 12 Jun 2025 08:05:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IER01s/EMuZ44+QUP+FNfG6CNzTdAhNJfEQnkZ6oSjQlsNzwsKgi819rHKxQomaKcpzLwyr+A==
X-Received: by 2002:a05:600c:1e2a:b0:43c:f8fe:dd82 with SMTP id
 5b1f17b1804b1-4532b952215mr43971915e9.18.1749740704871; 
 Thu, 12 Jun 2025 08:05:04 -0700 (PDT)
Received: from [192.168.0.4] (ltea-047-064-115-122.pools.arcor-ip.net.
 [47.64.115.122]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4532e24b0c8sm22849715e9.24.2025.06.12.08.05.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Jun 2025 08:05:04 -0700 (PDT)
Message-ID: <be26f6ad-f266-4451-a7ce-3d78afe34f27@redhat.com>
Date: Thu, 12 Jun 2025 17:05:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Seabios 1.17.0 20250611 patches
To: Stefan Hajnoczi <stefanha@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20250611075037.659610-1-kraxel@redhat.com>
 <3bc239aa-a2ab-400c-84b5-d7de3e5193ea@redhat.com>
 <CAJSP0QU++wDCXvYe2sUyHCZHrHVVY2ehdeAswjDE_5V2J-qE9w@mail.gmail.com>
 <4dd4bee5-7098-4f24-a81b-3935c58a6d9c@redhat.com>
 <CAJSP0QWyjzLLGnvrzMDtRubHuzAPWNtejb_wLz33PVWJ+QJLmw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAJSP0QWyjzLLGnvrzMDtRubHuzAPWNtejb_wLz33PVWJ+QJLmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/06/2025 15.08, Stefan Hajnoczi wrote:
> On Thu, Jun 12, 2025 at 12:36 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 11/06/2025 21.09, Stefan Hajnoczi wrote:
>>> On Wed, Jun 11, 2025 at 2:36 PM Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> On 11/06/2025 09.50, Gerd Hoffmann wrote:
>>>>> The following changes since commit bc98ffdc7577e55ab8373c579c28fe24d600c40f:
>>>>>
>>>>>      Merge tag 'pull-10.1-maintainer-may-2025-070625-1' of https://gitlab.com/stsquad/qemu into staging (2025-06-07 15:08:55 -0400)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>      https://gitlab.com/kraxel/qemu.git tags/seabios-1.17.0-20250611-pull-request
>>>>>
>>>>> for you to fetch changes up to cba36cf3881e907553ba2de38abd5edf7f952de1:
>>>>>
>>>>>      seabios: update binaries to 1.17.0 (2025-06-11 09:45:00 +0200)
>>>>>
>>>>> ----------------------------------------------------------------
>>>>> seabios: update to 1.17.0 release
>>>>>
>>>>> ----------------------------------------------------------------
>>>>>
>>>>> Gerd Hoffmann (2):
>>>>>      seabios: update submodule to 1.17.0
>>>>>      seabios: update binaries to 1.17.0
>>>>
>>>>     Hi Gerd, hi Stefan,
>>>>
>>>> I'm now getting this when doing a git pull:
>>>>
>>>> Fetching submodule roms/seabios
>>>> fatal: remote error: upload-pack: not our ref
>>>> b52ca86e094d19b58e2304417787e96b940e39c6
>>>> Errors during submodule fetch:
>>>>           roms/seabios
>>>
>>> GitLab CI didn't detect this, probably because the tests don't build
>>> SeaBIOS from source and use the binaries instead. Given infinite CI
>>> resources we should rebuild all ROMs from source to catch problems
>>> like this one.
>>>
>>> I wanted to mention this in case anyone wants to tighten up the CI to
>>> catch these issues for SeaBIOS and other ROMs.
>>>
>>>> Looking at
>>>> https://gitlab.com/qemu-project/seabios/-/commits/master?ref_type=HEADS
>>>> there is a problem with the mirroring:
>>>>
>>>> "This project is mirrored from https://review.coreboot.org/seabios. Pull
>>>> mirroring failed 4 months ago.
>>>> Repository mirroring has been paused due to too many failed attempts. It can
>>>> be resumed by a project maintainer or owner.
>>>> Last successful update 4 months ago. This branch has diverged from upstream. "
>>>>
>>>> Could you please fix this?
>>>
>>> `git clone https://review.coreboot.org/seabios` works on my machine,
>>> but I manually clicked the "update" button and GitLab failed again.
>>>
>>> In the GitLab UI there is a button to add a new mirror repo. I thought
>>> maybe we can delete the old repo and add a new one, but the push/pull
>>> direction dropdown list is disabled. Maybe that's because only 1 repo
>>> can be a mirror source for pull, I'm worried that deleting the
>>> existing failed repo will leave us with no way to add a new repo that
>>> supports pull.
>>>
>>> Does anyone know how to go about fixing this failed mirror?
>>
>> Maybe do a manual push --force to our mirror to sync them again? ... but it
>> would be good to know how this could have happened at all - maybe seabios
>> force-pushed their master branch at one point in time? Or did we commit
>> something to the mirror that was not in the upstream repository?
>>
>> Anyway, I just noticed that it seems to be working now again - how did you
>> fix it?
> 
> I didn't fix it. GitLab's mirror operation is still failing. 

Oh, ok! Maybe the error message only pops up if I pull changes into my local 
master branch, and during my last fetch there were only changes coming in 
for the "origin/staging", and those didn't trigger the error message. 
Anyway, I'll keep my eyes open!

  Thanks,
   Thomas



