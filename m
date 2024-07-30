Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF80C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 03:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYdMo-0001nL-Ml; Mon, 29 Jul 2024 23:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYdMj-0001hN-6L
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 23:17:33 -0400
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYdMf-0007ny-MW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 23:17:31 -0400
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6b7a0ef0e75so23257716d6.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 20:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722309448; x=1722914248;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cmShwRLjS0ToV/7Tjdb047dbmyWZMF+VMYWeK80E9xw=;
 b=brUVKxVVf849V/lckAjZA2aeZ944g1m+8BSvjDPwO/mSouf2h09U+Iwn9B5MCIFWBG
 KzR8g5C2oaKXvaaeud+1IXc7CMLKzjermSw5xR5bsCy7HSDz+8fVvFlgztpUq0Y2jLSU
 ep4AChqiHvIVNojSDZW7vClGkT7eDrJDmjLCEd5OMjJazcwgmMlMva275v0iHQKdnKq+
 pdDIZBM35JkfRW+mEyRS53OTLqlEJ7+7Y/FuHJr6pK404Pumv1PP52C5sLc+AGk36ppb
 zaiSszmVQvHEYHGXhcX/+0O9tBaRjALmd+7lOjhXdOM2sQLDC0U3Wdh2Q69KnvZtn7cu
 H6sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722309448; x=1722914248;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmShwRLjS0ToV/7Tjdb047dbmyWZMF+VMYWeK80E9xw=;
 b=BN9WkG7rNUAv+9AWYF1eE7PYAGttug5S1A2DwXboCE9tkDIepGGRfdqVT3KvU2Ymkw
 DoTE/8gs/1fPMl9K/vGdPdkDi4EQBF+kzqSMWsqno8jaxUmbepBPnm3qW5Ou8/CUDmCa
 IpCjT80iOw+RbKGxxmcwqAKYV7AHBe6+N+jUP8ElsKIYI2z5qV/pWYzbxTaP/8YegoB3
 tmcVR/WL2lbJf+mPrZwSxWeIK/5iel9y8F3sbZxTNwfP7mU2iAmveXdjJvm08Zm3Hlyr
 1/g+/y9rNSd+oiFydsn8pSXcr4SkWaKTEDBToMdTQO8f/E437yyHaRwDOjcPqZjqWj2c
 Ib4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLZooeGRorLTZhcGpl3k+ErSgEsLQt+6SwU1wptjWMn2r9JNOQJJ7o7sdWOQkrUWJ86vZFHD+Jv9/gY2WH0V/MPyUPJ0s=
X-Gm-Message-State: AOJu0YzDNnij2qbs5I+LNcykEqRKZuimO/vUgTe6sphrYUveiym3ESgW
 bqGj86tAcRbq9TlGadmVMzQQpgeeJfEUQ3GT1R1wCbxMds8WzrDzA+ZSdDTgukTF8rClkHsju/2
 dDvc=
X-Google-Smtp-Source: AGHT+IEHdaAHP5vAoyuBRiF4DNL7qE+VSF9NLQEF+NHmUDyZriBkgIjKmkHdwnIVx+reI+xXAX0MCA==
X-Received: by 2002:a05:6870:b507:b0:261:1c09:e0cf with SMTP id
 586e51a60fabf-267d4ccf58emr8959762fac.3.1722309116469; 
 Mon, 29 Jul 2024 20:11:56 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead8a39d8sm7538451b3a.213.2024.07.29.20.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 20:11:56 -0700 (PDT)
Message-ID: <bc2ef42e-9003-4a3e-aee5-e65d34f205bf@daynix.com>
Date: Tue, 30 Jul 2024 12:11:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Jason Wang <jasowang@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com, Fabiano Rosas <farosas@suse.de>,
 devel@lists.libvirt.org
References: <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <5a74c1d4-3c33-42d1-8abf-e3aab71e13a5@daynix.com>
 <CACGkMEtgPvGu9=n6nQqDwkV77X4830PQwv-E4m-+93Y8OhoVnQ@mail.gmail.com>
 <f1d0621b-84f0-4c2c-b4f4-f8ebd494ec48@daynix.com> <ZqenSQHzniN14g7G@x1n>
 <720d7d64-2b65-48cc-afa7-3b5ebc17e283@daynix.com>
 <CACGkMEtPwdddgnmSqzS92Z7yNDfu_B8xaFujy9PqMks7m8jqiA@mail.gmail.com>
 <688dd596-888f-49e1-a19c-0d62d417cce4@daynix.com>
 <CACGkMEvgYTjQ5orDJMbmE8-Kwqko9dFPerTnxsRgs0EtnmKKTQ@mail.gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEvgYTjQ5orDJMbmE8-Kwqko9dFPerTnxsRgs0EtnmKKTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-qv1-xf2f.google.com
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

On 2024/07/30 12:03, Jason Wang wrote:
> On Tue, Jul 30, 2024 at 10:57 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/07/30 11:04, Jason Wang wrote:
>>> On Tue, Jul 30, 2024 at 12:43 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> On 2024/07/29 23:29, Peter Xu wrote:
>>>>> On Mon, Jul 29, 2024 at 01:45:12PM +0900, Akihiko Odaki wrote:
>>>>>> On 2024/07/29 12:50, Jason Wang wrote:
>>>>>>> On Sun, Jul 28, 2024 at 11:19 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>>>
>>>>>>>> On 2024/07/27 5:47, Peter Xu wrote:
>>>>>>>>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
>>>>>>>>>> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
>>>>>>>>>>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrangé wrote:
>>>>>>>>>>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
>>>>>>>>>>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
>>>>>>>>>>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
>>>>>>>>>>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
>>>>>>>>>>>>>>>> USO features of virtio-net device depend on kernel ability
>>>>>>>>>>>>>>>> to support them, for backward compatibility by default the
>>>>>>>>>>>>>>>> features are disabled on 8.0 and earlier.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>>>>>>>>>>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Looks like this patch broke migration when the VM starts on a host that has
>>>>>>>>>>>>>>> USO supported, to another host that doesn't..
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> This was always the case with all offloads. The answer at the moment is,
>>>>>>>>>>>>>> don't do this.
>>>>>>>>>>>>>
>>>>>>>>>>>>> May I ask for my understanding:
>>>>>>>>>>>>> "don't do this" = don't automatically enable/disable virtio features in QEMU
>>>>>>>>>>>>> depending on host kernel features, or "don't do this" = don't try to migrate
>>>>>>>>>>>>> between machines that have different host kernel features?
>>>>>>>>>>>>>
>>>>>>>>>>>>>> Long term, we need to start exposing management APIs
>>>>>>>>>>>>>> to discover this, and management has to disable unsupported features.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Ack, this likely needs some treatments from the libvirt side, too.
>>>>>>>>>>>>
>>>>>>>>>>>> When QEMU automatically toggles machine type featuers based on host
>>>>>>>>>>>> kernel, relying on libvirt to then disable them again is impractical,
>>>>>>>>>>>> as we cannot assume that the libvirt people are using knows about
>>>>>>>>>>>> newly introduced features. Even if libvirt is updated to know about
>>>>>>>>>>>> it, people can easily be using a previous libvirt release.
>>>>>>>>>>>>
>>>>>>>>>>>> QEMU itself needs to make the machine types do that they are there
>>>>>>>>>>>> todo, which is to define a stable machine ABI.
>>>>>>>>>>>>
>>>>>>>>>>>> What QEMU is missing here is a "platform ABI" concept, to encode
>>>>>>>>>>>> sets of features which are tied to specific platform generations.
>>>>>>>>>>>> As long as we don't have that we'll keep having these broken
>>>>>>>>>>>> migration problems from machine types dynamically changing instead
>>>>>>>>>>>> of providing a stable guest ABI.
>>>>>>>>>>>
>>>>>>>>>>> Any more elaboration on this idea?  Would it be easily feasible in
>>>>>>>>>>> implementation?
>>>>>>>>>>
>>>>>>>>>> In terms of launching QEMU I'd imagine:
>>>>>>>>>>
>>>>>>>>>>        $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
>>>>>>>>>>
>>>>>>>>>> Any virtual machine HW features which are tied to host kernel features
>>>>>>>>>> would have their defaults set based on the requested -platform. The
>>>>>>>>>> -machine will be fully invariant wrt the host kernel.
>>>>>>>>>>
>>>>>>>>>> You would have -platform hlep to list available platforms, and
>>>>>>>>>> corresonding QMP "query-platforms" command to list what platforms
>>>>>>>>>> are supported on a given host OS.
>>>>>>>>>>
>>>>>>>>>> Downstream distros can provide their own platforms definitions
>>>>>>>>>> (eg "linux-rhel-9.5") if they have kernels whose feature set
>>>>>>>>>> diverges from upstream due to backports.
>>>>>>>>>>
>>>>>>>>>> Mgmt apps won't need to be taught about every single little QEMU
>>>>>>>>>> setting whose default is derived from the kernel. Individual
>>>>>>>>>> defaults are opaque and controlled by the requested platform.
>>>>>>>>>>
>>>>>>>>>> Live migration has clearly defined semantics, and mgmt app can
>>>>>>>>>> use query-platforms to validate two hosts are compatible.
>>>>>>>>>>
>>>>>>>>>> Omitting -platform should pick the very latest platform that is
>>>>>>>>>> cmpatible with the current host (not neccessarily the latest
>>>>>>>>>> platform built-in to QEMU).
>>>>>>>>>
>>>>>>>>> This seems to add one more layer to maintain, and so far I don't know
>>>>>>>>> whether it's a must.
>>>>>>>>>
>>>>>>>>> To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
>>>>>>>>> thought it was mostly the case already, except some extremely rare
>>>>>>>>> outliers.
>>>>>>>>>
>>>>>>>>> When we have one host that boots up a VM using:
>>>>>>>>>
>>>>>>>>>        $QEMU1 $cmdline
>>>>>>>>>
>>>>>>>>> Then another host boots up:
>>>>>>>>>
>>>>>>>>>        $QEMU2 $cmdline -incoming XXX
>>>>>>>>>
>>>>>>>>> Then migration should succeed if $cmdline is exactly the same, and the VM
>>>>>>>>> can boot up all fine without errors on both sides.
>>>>>>>>>
>>>>>>>>> AFAICT this has nothing to do with what kernel is underneath, even not
>>>>>>>>> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
>>>>>>>>> didn't, I thought the ABI should be guaranteed.
>>>>>>>>>
>>>>>>>>> That's why I think this is a migration violation, as 99.99% of other device
>>>>>>>>> properties should be following this rule.  The issue here is, we have the
>>>>>>>>> same virtio-net-pci cmdline on both sides in this case, but the ABI got
>>>>>>>>> break.
>>>>>>>>>
>>>>>>>>> That's also why I was suggesting if the property contributes to the guest
>>>>>>>>> ABI, then AFAIU QEMU needs to:
>>>>>>>>>
>>>>>>>>>        - Firstly, never quietly flipping any bit that affects the ABI...
>>>>>>>>>
>>>>>>>>>        - Have a default value of off, then QEMU will always allow the VM to boot
>>>>>>>>>          by default, while advanced users can opt-in on new features.  We can't
>>>>>>>>>          make this ON by default otherwise some VMs can already fail to boot,
>>>>>>>>
>>>>>>>> It may not be necessary the case that old features are supported by
>>>>>>>> every systems. In an extreme case, a user may migrate a VM from Linux to
>>>>>>>> Windows, which probably doesn't support any offloading at all. A more
>>>>>>>> convincing scenario is RSS offloading with eBPF; using eBPF requires a
>>>>>>>> privilege so we cannot assume it is always available even on the latest
>>>>>>>> version of Linux.
>>>>>>>
>>>>>>> I don't get why eBPF matters here. It is something that is not noticed
>>>>>>> by the guest and we have a fallback anyhow.
>>>>
>>>> It is noticeable for the guest, and the fallback is not effective with
>>>> vhost.
>>>
>>> It's a bug then. Qemu can fallback to tuntap if it sees issues in vhost.
>>
>> We can certainly fallback to in-QEMU RSS by disabling vhost, but I would
>> not say lack of such fallback is a bug.
> 
> Such fallback is by design since the introduction of vhost.
> 
>> We don't provide in-QEMU
>> fallback for other offloads.
> 
> Yes but what I want to say is that eBPF RSS is different from those
> segmentation offloads. And technically, Qemu can do fallback for
> offloads (as RSC did).

Well, I couldn't find any code disabling vhost for the in-QEMU RSC 
implementation.

Looking at the code, I also found the case of vhost-vdpa. vhost can be 
simply disabled if it is backed by tuntap, but it is not the case for vDPA.

Regards,
Akihiko Odaki

