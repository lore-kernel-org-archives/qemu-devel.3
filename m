Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A313C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 03:30:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYdYy-0003yH-Ap; Mon, 29 Jul 2024 23:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYdYx-0003ta-9V
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 23:30:11 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sYdYv-0002DU-8Z
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 23:30:10 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2c964f5a037so2563673a91.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 20:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722310207; x=1722915007;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6bx9v8k0TKyONtZEPMxXR3+hYJhZL/DPK3ZeGkIdcmM=;
 b=mnI4bkgmiYXffhjvZW/pZaABMbimaCdi5ev+1gaGOZsKbxDHddAwcVvTctszx4iZx2
 J22SU5sUHwAffVKGaBtI+UoK9FBavt4bu84kJGbZddJGDhl+YGy4MYIhA73o1Wgr0Qq4
 4osqT16evdIJoSQlwnLRglN6yRMpFrtuWT3DIxIG2jrE3T1icP0+zGg8HulbevVF/qQa
 pWb4tNLg67Yo2HYEu+a5tJ+0w3L6+D/BzKNtf3jDCRuzsJ12cpYzAfr126DXDlxFWslt
 pXHknhwkVjSF5Dq4Wi6y2w0c+95PvJyvYIDyzeoeMAboLh0mLPOQHwGKX3IbgJlxvNlH
 NN8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722310207; x=1722915007;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6bx9v8k0TKyONtZEPMxXR3+hYJhZL/DPK3ZeGkIdcmM=;
 b=okbMu+lju8fGXxUTtVDm2MPlyHFUqstbzQhqjFY7ScDi/hK70IPr/ECBHgZtgKbCSv
 LA2PotHXkBnZqx1CKTMNExbfo2oB4shD/grVadpAyZPN1aAvi8GM56P+tuRlVAOVogIx
 rZSM69bGr8okHZgj9btMf0hqPSxN3+oyxyVHNeUfeqktFERPA5eK07wH6GRi+Byt/uGH
 J2xJwAAUCr25YQcpZKXU3dSvm9yQOn3/dN0H8oyblcfxuXWRPfTdwPhW5Y0yICq0Rb2p
 Kl6QNtaYLAuTJWpwhLx0tDZPLT+iU7IATMbJB81ewMGmvywwga0X6COsq0Wuq+T5M1X7
 paGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbBVO0WMzfWS71WuZtYb4x3EWUcNwwNzuIrVBgd1NoLyO5rzxoNabV2BgZ2a6+cMOJT/E8EkheDDyhQGaV5P6cJpVxbdA=
X-Gm-Message-State: AOJu0YwWfTTwjnMJhZqPRooHgxD8upyOIyzfpdn1IrSymQRi63kFbzA/
 9OUWYj+rmFSWxLmwhmS+RonOX/Z5zaUJCEXs8mj5heFqNhKgaf/RoQhLyzR/XfuRkYBefB/08/6
 kgyo=
X-Google-Smtp-Source: AGHT+IGaovxrV7uI1pmYcx5foY42mubEHDzw8JTqKMTjXtoF+CwrJhadCa7LylULTcQA5/C2ysYqew==
X-Received: by 2002:a17:902:d50f:b0:1f7:26f:9185 with SMTP id
 d9443c01a7336-1ff047df061mr80528985ad.10.1722308257288; 
 Mon, 29 Jul 2024 19:57:37 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fed7f1b80asm89774745ad.184.2024.07.29.19.57.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 19:57:36 -0700 (PDT)
Message-ID: <688dd596-888f-49e1-a19c-0d62d417cce4@daynix.com>
Date: Tue, 30 Jul 2024 11:57:32 +0900
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
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CACGkMEtPwdddgnmSqzS92Z7yNDfu_B8xaFujy9PqMks7m8jqiA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
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

On 2024/07/30 11:04, Jason Wang wrote:
> On Tue, Jul 30, 2024 at 12:43 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> On 2024/07/29 23:29, Peter Xu wrote:
>>> On Mon, Jul 29, 2024 at 01:45:12PM +0900, Akihiko Odaki wrote:
>>>> On 2024/07/29 12:50, Jason Wang wrote:
>>>>> On Sun, Jul 28, 2024 at 11:19 PM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>>>>>
>>>>>> On 2024/07/27 5:47, Peter Xu wrote:
>>>>>>> On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
>>>>>>>> On Fri, Jul 26, 2024 at 10:43:42AM -0400, Peter Xu wrote:
>>>>>>>>> On Fri, Jul 26, 2024 at 09:48:02AM +0100, Daniel P. Berrangé wrote:
>>>>>>>>>> On Fri, Jul 26, 2024 at 09:03:24AM +0200, Thomas Huth wrote:
>>>>>>>>>>> On 26/07/2024 08.08, Michael S. Tsirkin wrote:
>>>>>>>>>>>> On Thu, Jul 25, 2024 at 06:18:20PM -0400, Peter Xu wrote:
>>>>>>>>>>>>> On Tue, Aug 01, 2023 at 01:31:48AM +0300, Yuri Benditovich wrote:
>>>>>>>>>>>>>> USO features of virtio-net device depend on kernel ability
>>>>>>>>>>>>>> to support them, for backward compatibility by default the
>>>>>>>>>>>>>> features are disabled on 8.0 and earlier.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
>>>>>>>>>>>>>> Signed-off-by: Andrew Melnychecnko <andrew@daynix.com>
>>>>>>>>>>>>>
>>>>>>>>>>>>> Looks like this patch broke migration when the VM starts on a host that has
>>>>>>>>>>>>> USO supported, to another host that doesn't..
>>>>>>>>>>>>
>>>>>>>>>>>> This was always the case with all offloads. The answer at the moment is,
>>>>>>>>>>>> don't do this.
>>>>>>>>>>>
>>>>>>>>>>> May I ask for my understanding:
>>>>>>>>>>> "don't do this" = don't automatically enable/disable virtio features in QEMU
>>>>>>>>>>> depending on host kernel features, or "don't do this" = don't try to migrate
>>>>>>>>>>> between machines that have different host kernel features?
>>>>>>>>>>>
>>>>>>>>>>>> Long term, we need to start exposing management APIs
>>>>>>>>>>>> to discover this, and management has to disable unsupported features.
>>>>>>>>>>>
>>>>>>>>>>> Ack, this likely needs some treatments from the libvirt side, too.
>>>>>>>>>>
>>>>>>>>>> When QEMU automatically toggles machine type featuers based on host
>>>>>>>>>> kernel, relying on libvirt to then disable them again is impractical,
>>>>>>>>>> as we cannot assume that the libvirt people are using knows about
>>>>>>>>>> newly introduced features. Even if libvirt is updated to know about
>>>>>>>>>> it, people can easily be using a previous libvirt release.
>>>>>>>>>>
>>>>>>>>>> QEMU itself needs to make the machine types do that they are there
>>>>>>>>>> todo, which is to define a stable machine ABI.
>>>>>>>>>>
>>>>>>>>>> What QEMU is missing here is a "platform ABI" concept, to encode
>>>>>>>>>> sets of features which are tied to specific platform generations.
>>>>>>>>>> As long as we don't have that we'll keep having these broken
>>>>>>>>>> migration problems from machine types dynamically changing instead
>>>>>>>>>> of providing a stable guest ABI.
>>>>>>>>>
>>>>>>>>> Any more elaboration on this idea?  Would it be easily feasible in
>>>>>>>>> implementation?
>>>>>>>>
>>>>>>>> In terms of launching QEMU I'd imagine:
>>>>>>>>
>>>>>>>>       $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
>>>>>>>>
>>>>>>>> Any virtual machine HW features which are tied to host kernel features
>>>>>>>> would have their defaults set based on the requested -platform. The
>>>>>>>> -machine will be fully invariant wrt the host kernel.
>>>>>>>>
>>>>>>>> You would have -platform hlep to list available platforms, and
>>>>>>>> corresonding QMP "query-platforms" command to list what platforms
>>>>>>>> are supported on a given host OS.
>>>>>>>>
>>>>>>>> Downstream distros can provide their own platforms definitions
>>>>>>>> (eg "linux-rhel-9.5") if they have kernels whose feature set
>>>>>>>> diverges from upstream due to backports.
>>>>>>>>
>>>>>>>> Mgmt apps won't need to be taught about every single little QEMU
>>>>>>>> setting whose default is derived from the kernel. Individual
>>>>>>>> defaults are opaque and controlled by the requested platform.
>>>>>>>>
>>>>>>>> Live migration has clearly defined semantics, and mgmt app can
>>>>>>>> use query-platforms to validate two hosts are compatible.
>>>>>>>>
>>>>>>>> Omitting -platform should pick the very latest platform that is
>>>>>>>> cmpatible with the current host (not neccessarily the latest
>>>>>>>> platform built-in to QEMU).
>>>>>>>
>>>>>>> This seems to add one more layer to maintain, and so far I don't know
>>>>>>> whether it's a must.
>>>>>>>
>>>>>>> To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
>>>>>>> thought it was mostly the case already, except some extremely rare
>>>>>>> outliers.
>>>>>>>
>>>>>>> When we have one host that boots up a VM using:
>>>>>>>
>>>>>>>       $QEMU1 $cmdline
>>>>>>>
>>>>>>> Then another host boots up:
>>>>>>>
>>>>>>>       $QEMU2 $cmdline -incoming XXX
>>>>>>>
>>>>>>> Then migration should succeed if $cmdline is exactly the same, and the VM
>>>>>>> can boot up all fine without errors on both sides.
>>>>>>>
>>>>>>> AFAICT this has nothing to do with what kernel is underneath, even not
>>>>>>> Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
>>>>>>> didn't, I thought the ABI should be guaranteed.
>>>>>>>
>>>>>>> That's why I think this is a migration violation, as 99.99% of other device
>>>>>>> properties should be following this rule.  The issue here is, we have the
>>>>>>> same virtio-net-pci cmdline on both sides in this case, but the ABI got
>>>>>>> break.
>>>>>>>
>>>>>>> That's also why I was suggesting if the property contributes to the guest
>>>>>>> ABI, then AFAIU QEMU needs to:
>>>>>>>
>>>>>>>       - Firstly, never quietly flipping any bit that affects the ABI...
>>>>>>>
>>>>>>>       - Have a default value of off, then QEMU will always allow the VM to boot
>>>>>>>         by default, while advanced users can opt-in on new features.  We can't
>>>>>>>         make this ON by default otherwise some VMs can already fail to boot,
>>>>>>
>>>>>> It may not be necessary the case that old features are supported by
>>>>>> every systems. In an extreme case, a user may migrate a VM from Linux to
>>>>>> Windows, which probably doesn't support any offloading at all. A more
>>>>>> convincing scenario is RSS offloading with eBPF; using eBPF requires a
>>>>>> privilege so we cannot assume it is always available even on the latest
>>>>>> version of Linux.
>>>>>
>>>>> I don't get why eBPF matters here. It is something that is not noticed
>>>>> by the guest and we have a fallback anyhow.
>>
>> It is noticeable for the guest, and the fallback is not effective with
>> vhost.
> 
> It's a bug then. Qemu can fallback to tuntap if it sees issues in vhost.

We can certainly fallback to in-QEMU RSS by disabling vhost, but I would 
not say lack of such fallback is a bug. We don't provide in-QEMU 
fallback for other offloads.

Regards,
Akihiko Odaki

