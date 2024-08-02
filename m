Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C965C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 15:55:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZucR-00017I-81; Fri, 02 Aug 2024 11:55:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZucO-0000ur-Nf
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:55:00 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sZucL-0001WD-Vz
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 11:55:00 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1fd65aaac27so24737775ad.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 08:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722614096; x=1723218896;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MxOuDtqWD9IL+F9ULlvajex+r2YEEwkia/SF6aPJTog=;
 b=mLvL2hmPXIrGAfUMh+rwIPBAhQPS+oRnWYEP+AG1a401gNuWxsSfz8FcL4XPOaEPfg
 KkDFRC71rhEUVPyJmnzGvoNuz5a78oGjzOF+yKOgWHqOBJbgdASryKOn4tyqK3ZZoteT
 skZT4u+pUumBRi3PY1bgi4BF90AjBzf+wRXITchdhNYXRsTUJxJnBY3ymE5Bf/p9PmzW
 uO17EjBaYC6+108a9nOQeN8nEErtJBGv+JrbfAaWbeXM60x7rvSVT3aGhDf3Fqzd2vLU
 IuVkOM86Fe16JDjN8iZSAqz50Vj5BE1EedYUA+ATJDSJpuh7cB5qEByB2IcaXVQ/b8Ru
 ME/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722614096; x=1723218896;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MxOuDtqWD9IL+F9ULlvajex+r2YEEwkia/SF6aPJTog=;
 b=iYzLIKPQuhSKT3btUNntMywDcCZCNujfDPYhYrsrVJB46bd5NmSwhZ5bZTYxSo4Sah
 iklb2+SHxO+NDU0DP0un1A8pB1DBnB0ClB6/6bfxoALnuV3jJeZWLvWeLy/mBky2zBeZ
 SeB3jHmNmjPKgP/CWsXXkobEWlb7lbeWtWw9B1S1sSd+rUGPz1yWKJQd+Kbb8ry5EdNe
 1z1yPSbXUcLAKS0owOojU6VsUitL1M9AMmv0z1+5lv8EUalgsUwudM6M9svA0nlZVi7o
 np/1Sk30XmRASyeYaNwheHp4eMIdG1KrDGPnL1sQyC3HYTi098kHkQEYKAV0kUyG7+Ib
 gijw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3nmX6VmNhFEt+alMKSgcTI/NxVM6Evz31k+ZmO60ZIYRQek1BsTbRQerXEUABsvAZRQHRWPcfil1V78sJaYE5ozIQoLo=
X-Gm-Message-State: AOJu0YwVXVX2HJFIBRxGry7XY5tc04AuCXH0x0pXmFdGUQaMoVXin4Nx
 hz2ZgZzMKzCxAlaLQLdJ7QNxg4jQicqHhPMQ5fp9jSBH+utMsvfwmmnReTLCxSk=
X-Google-Smtp-Source: AGHT+IH5GTUL32mw+Ivf075TMeI1LSKPIREccnP0XOBfSooyw2IbNq9NNWrrZRfQekLTw0nZEokORA==
X-Received: by 2002:a17:903:240c:b0:1ff:4a01:43f7 with SMTP id
 d9443c01a7336-1ff5240a95dmr86289445ad.10.1722614096303; 
 Fri, 02 Aug 2024 08:54:56 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:32ed:25ae:21b1:72d6?
 ([2400:4050:a840:1e00:32ed:25ae:21b1:72d6])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7b762e9f5cdsm1505681a12.2.2024.08.02.08.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 08:54:55 -0700 (PDT)
Message-ID: <c5ea7a57-fc52-4bb7-bc4c-f3aca8da0574@daynix.com>
Date: Sat, 3 Aug 2024 00:54:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
To: Peter Xu <peterx@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com, sriram.yagnaraman@est.tech,
 sw@weilnetz.de, qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
References: <ZqQLbGxEW3XT7qL-@x1n> <Zqe8C9AfaojKHM8A@redhat.com>
 <ZqfKrtQSSRVnEOGt@x1n> <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com> <ZqumIZcs1tCNTpRE@x1n>
 <b70d09a5-554a-456b-904e-59cec5836ae8@daynix.com> <Zqz1vvYqRuIAPnod@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Zqz1vvYqRuIAPnod@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::632;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x632.google.com
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

On 2024/08/03 0:05, Peter Xu wrote:
> On Fri, Aug 02, 2024 at 01:30:51PM +0900, Akihiko Odaki wrote:
>> On 2024/08/02 0:13, Peter Xu wrote:
>>> On Thu, Aug 01, 2024 at 02:05:54PM +0900, Akihiko Odaki wrote:
>>>> On 2024/07/31 4:11, Peter Xu wrote:
>>>>> On Tue, Jul 30, 2024 at 07:46:12PM +0100, Daniel P. Berrangé wrote:
>>>>>> On Tue, Jul 30, 2024 at 02:13:51PM -0400, Peter Xu wrote:
>>>>>>> On Mon, Jul 29, 2024 at 06:26:41PM +0100, Daniel P. Berrangé wrote:
>>>>>>>> On Mon, Jul 29, 2024 at 01:00:30PM -0400, Peter Xu wrote:
>>>>>>>>> On Mon, Jul 29, 2024 at 04:58:03PM +0100, Daniel P. Berrangé wrote:
>>>>>>>>>>
>>>>>>>>>> We've got two mutually conflicting goals with the machine type
>>>>>>>>>> definitions.
>>>>>>>>>>
>>>>>>>>>> Primarily we use them to ensure stable ABI, but an important
>>>>>>>>>> secondary goal is to enable new tunables to have new defaults
>>>>>>>>>> set, without having to update every mgmt app.  The latter
>>>>>>>>>> works very well when the defaults have no dependancy on the
>>>>>>>>>> platform kernel/OS, but breaks migration when they do have a
>>>>>>>>>> platform dependancy.
>>>>>>>>>>
>>>>>>>>>>>      - Firstly, never quietly flipping any bit that affects the ABI...
>>>>>>>>>>>
>>>>>>>>>>>      - Have a default value of off, then QEMU will always allow the VM to boot
>>>>>>>>>>>        by default, while advanced users can opt-in on new features.  We can't
>>>>>>>>>>>        make this ON by default otherwise some VMs can already fail to boot,
>>>>>>>>>>>
>>>>>>>>>>>      - If the host doesn't support the feature while the cmdline enabled it,
>>>>>>>>>>>        it needs to fail QEMU boot rather than flipping, so that it says "hey,
>>>>>>>>>>>        this host does not support running such VM specified, due to XXX
>>>>>>>>>>>        feature missing".
>>>>>>>>>>>
>>>>>>>>>>> That's the only way an user could understand what happened, and IMHO that's
>>>>>>>>>>> a clean way that we stick with QEMU cmdline on defining the guest ABI,
>>>>>>>>>>> while in which the machine type is the fundation of such definition, as the
>>>>>>>>>>> machine type can decides many of the rest compat properties.  And that's
>>>>>>>>>>> the whole point of the compat properties too (to make sure the guest ABI is
>>>>>>>>>>> stable).
>>>>>>>>>>>
>>>>>>>>>>> If kernel breaks it easily, all compat property things that we maintain can
>>>>>>>>>>> already stop making sense in general, because it didn't define the whole
>>>>>>>>>>> guest ABI..
>>>>>>>>>>>
>>>>>>>>>>> So AFAIU that's really what we used for years, I hope I didn't overlook
>>>>>>>>>>> somehting.  And maybe we don't yet need the "-platform" layer if we can
>>>>>>>>>>> keep up with this rule?
>>>>>>>>>>
>>>>>>>>>> We've failed at this for years wrt enabling use of new defaults that have
>>>>>>>>>> a platform depedancy, so historical practice isn't a good reference.
>>>>>>>>>>
>>>>>>>>>> There are 100's (possibly 1000's) of tunables set implicitly as part of
>>>>>>>>>> the machine type, and of those, libvirt likely only exposes a few 10's
>>>>>>>>>> of tunables. The vast majority are low level details that no mgmt app
>>>>>>>>>> wants to know about, they just want to accept QEMU's new defaults,
>>>>>>>>>> while preserving machine ABI. This is a good thing. No one wants the
>>>>>>>>>> burden of wiring up every single tunable into libvirt and mgmt apps.
>>>>>>>>>>
>>>>>>>>>> This is what the "-platform" concept would be intended to preserve. It
>>>>>>>>>> would allow a way to enable groups of settings that have a platform level
>>>>>>>>>> dependancy, without ever having to teach either libvirt or the mgmt apps
>>>>>>>>>> about the individual tunables.
>>>>>>>>>
>>>>>>>>> Do you think we can achieve similar goal by simply turning the feature to
>>>>>>>>> ON only after a few QEMU releases?  I also mentioned that idea below.
>>>>>>>>>
>>>>>>>>> https://lore.kernel.org/r/ZqQNKZ9_OPhDq2AK@x1n
>>>>>>>>>
>>>>>>>>> So far it really sounds like the right thing to do to me to fix all similar
>>>>>>>>> issues, even without introducing anything new we need to maintain.
>>>>>>>>
>>>>>>>> Turning a feature with a platform dependency to "on" implies that
>>>>>>>> the machine type will cease to work out of the box for platforms
>>>>>>>> which lack the feature. IMHO that's not acceptable behaviour for
>>>>>>>> any of our supported platforms.
>>>>>>>
>>>>>>> Right, that's why I was thinking whether we should just always be on the
>>>>>>> safe side, even if I just replied in the other email to Akihiko, that we do
>>>>>>> have the option to make this more aggresive by turning those to ON after
>>>>>>> even 1-2 years or even less.. and we have control of how aggressive this
>>>>>>> can be.
>>>>>>>
>>>>>>>>
>>>>>>>> IOW, "after a few QEMU releases" implies a delay of as much as
>>>>>>>> 5 years, while we wait for platforms which don't support the
>>>>>>>> feature to drop out of our supported targets list.  I don't
>>>>>>>> think that'll satisfy the desire to get the new feature
>>>>>>>> available to users as soon as practical for their particular
>>>>>>>> platform.
>>>>>>>
>>>>>>> The feature is always available since the 1st day, right?  We just need the
>>>>>>> user to opt-in, by specifying ON in the cmdline.
>>>>>>>
>>>>>>> That'll be my take on this that QEMU's default VM setup should be always
>>>>>>> bootable, migratable, and so on.  Then user opt-in on stuff like this one,
>>>>>>> where there's implication on the ABIs.  The "user" can also include
>>>>>>> Libvirt.  I mean when something is really important, Libvirt should, IMHO,
>>>>>>> opt-in by treating that similarly like many cpu properties, and by probing
>>>>>>> the host first.
>>>>>>>
>>>>>>> IIUC there aren't a lot of things like that (part of guest ABI & host
>>>>>>> kernel / HW dependent), am I right?  Otherwise I would expect more failures
>>>>>>> like this one, but it isn't as much as that yet.  IIUC it means the efforts
>>>>>>> to make Libvirt get involved should be hopefully under control too.  The
>>>>>>> worst case is Libvirt doesn't auto-on it, but again the user should always
>>>>>>> have the option to turn it on when it's necessary.
>>>>>>
>>>>>> If it is left to libvirt, then it would very likely end up being a user
>>>>>> opt-in, not auto-enabled.
>>>>>
>>>>> Not sure whether there's other opinions, but that's definitely fine by me.
>>>>>
>>>>> I think it even makes more sense, as even if Libvirt probed the host and
>>>>> auto-on the feature, it also means Libvirt made a decision for the user,
>>>>> saying "having a better performance" is more important than "being able to
>>>>> migrate this VM everywhere".
>>>>>
>>>>> I don't see a way that can make such fair decision besides requesting the
>>>>> user to opt-in always for those, then the user is fully aware what is
>>>>> enabled, with the hope that when a migration fails later with "target host
>>>>> doesn't support feature XXX" the user is crystal clear on what happened.
>>>>
>>>> I think it is better to distinguish saying "having a better performance is
>>>> more important than being able to migrate this VM everywhere" from
>>>> explicitly selecting all available offload features; the latter is lot of
>>>> chores. More importantly, users may not just know these features may prevent
>>>> migration; they may just look like performance features nice to have at
>>>> first glance.
>>>>
>>>> I don' think what a user would want are not individual performance knobs,
>>>> but a user is more likely to need to express the platforms they would want
>>>> to migrate VMs on. There are several possible scenarios in particular:
>>>> 1) Migration everywhere
>>>> 2) Migration on specific machines
>>>> 3) Migration on some known platforms
>>>> 4) No migration (migration on nowhere)
>>>>
>>>> If a user chooses 1-3), QEMU may reject platform-dependent features even if
>>>> the user requests one; in this way, we don't need the users to make things
>>>> crystal clear, but we can expect QEMU does so.
>>>>
>>>> If a user chooses 2-4), QEMU may enable all offloading features available on
>>>> the specified platforms. Again, the user will no longer have to know each
>>>> individual performance features. QEMU may also reject migration to platforms
>>>> not specified to prevent misconfiguration.
>>>>
>>>> The -platform proposal earlier corresponds to 3). However it has a downside
>>>> that QEMU needs to know about platforms, which may not be trivial. In that
>>>> case, we can support 1), 2), and 4).
>>>
>>> I'm not sure if I read it right.  Perhaps you meant something more generic
>>> than -platform but similar?
>>>
>>> For example, "-profile [PROFILE]" qemu cmdline, where PROFILE can be either
>>> "perf" or "compat", while by default to "compat"?
>>
>> "perf" would cover 4) and "compat" will cover 1). However neither of them
>> will cover 2) because an enum is not enough to know about all hosts. I
>> presented a design that will cover 2) in:
>> https://lore.kernel.org/r/2da4ebcd-2058-49c3-a4ec-8e60536e5cbb@daynix.com
> 
> "-merge-platform" shouldn't be a QEMU parameter, but should be something
> separate.

Do you mean merging platform dumps should be done with another command? 
I think we will want to know the QOM tree is in use when implementing 
-merge-platform. For example, you cannot define a "platform" when e.g., 
you don't know what netdev backend (e.g., user, vhost-net, vhost-vdpa) 
is connected to virtio-net devices. Of course we can include those 
information in dumps, but we don't do so for VMState.

> 
> Yes, as you mentioned there it could be a lot of work, we may need to think
> it through and collect enough input before working on something like that.
> 
>>
>> I also want to point out that "perf" should be rather named like
>> "nomigrate". In general, a program should expose a functional requirement on
>> the interface. It can then do its best to achieve high performance under
>> that requirement.
> 
> "nomigrate" may be inaccurate or even wrong in this case, because as long
> as the features are supported on both hosts it's migratable.

Perhaps it may be named no-cross-migrate or something. There are lots of 
details we need to figure out.

> 
>>
>>>
>>> If so, I think I get the idea, but it'll be challenging in at least these
>>> aspects:
>>>
>>>     - We already have (at least.. that I'm aware of) three layers of
>>>       specifying a property for a device, they are:
>>>
>>>       (1) default value
>>>       (2) compat property (from machine type definitions)
>>>       (3) qemu cmdline (specify one property explicitly)
>>>
>>>       So far, there's an order we apply these (1-3), while (3) has the top
>>>       priority to overwrite (1-2), and (2) to overwrite (1).
>>>
>>>       The new "-profile", if I read it right, introduce (4), and it's already
>>>       unclear to me how that interacts with (3) when -profile says "turn
>>>       FEAT1 on" while cmdline says otherwise.
>>>
>>>       It can make things very compilcated, IMHO.
>>>
>>>     - This still will break the "QEMU cmdline defines the guest ABI", e.g.,
>>>       consider this USO* thing that we boot an old machine type on a new
>>>       system that has QEMU+Linux USO* all enabled.  We specify "-profile
>>>       perf" there.  Then when we try to migrate to another older QEMU it'll
>>>       still fail the migration instead of any way telling us "migration is
>>>       not compatible".  So even if it helps the user turning on knobs, it
>>>       doesn't sound like to fix the problem we're working on?
>>
>> When it is named nomigrate, it is obvious that migration does not work.
> 
> I am not sure whether you meant to e.g. add a migration blocker in this
> case even if migration can be supported between some hosts.  But if so it
> may not be wise either to block users trying to migrate where it is still
> applicable.  So maybe I misunderstood.

There is certainly downside and upside to add a migration blocker and I 
don't have a strong opinion here.

Regards,
Akihiko Odaki

