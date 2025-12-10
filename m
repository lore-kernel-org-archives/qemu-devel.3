Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01DB1D3E76E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 18:26:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTOsZ-0006yX-6n; Wed, 10 Dec 2025 13:25:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vTOsU-0006yH-Mk
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:25:30 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vTOsQ-0006yE-G5
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 13:25:30 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:49f:0:640:b99a:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id D557480874;
 Wed, 10 Dec 2025 21:25:20 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:887::1:d] (unknown [2a02:6bf:8080:887::1:d])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HPT6Le0FwKo0-Gw7Z6irz; Wed, 10 Dec 2025 21:25:20 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1765391120;
 bh=odMD8ZR7fULkwkh8p+6KgkPV3/VGymFoCiVW6KZVRME=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Q1UDfzJYMAnWcVpq3Q24dYPq8zsfELoAN5iCamBXBctYa5HFSNpKvmU/tMB5mbUUR
 sQQ8N1DJz54dZkj5ae2tu+bX5yTwo2Ce77L0xpSbS4LpWAKG8qwqCMVN9L6s4QPIA/
 OAOidOfz3AqcI2eOrhjVCDW2QKazwthZQjt5BJn0=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <6b0f2fec-ddde-4b24-90f9-df906ac73253@yandex-team.ru>
Date: Wed, 10 Dec 2025 21:25:16 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] QOM: Introduce OBJECT_COMPAT class
To: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Juraj Marcin <jmarcin@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, Eric Blake <eblake@redhat.com>
References: <20251209162857.857593-1-peterx@redhat.com>
 <aTlZIlgB20OpdSEl@redhat.com> <aTle5C2pN8ZslZX7@redhat.com>
 <aTmdJ5H67mk8qmSC@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aTmdJ5H67mk8qmSC@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10.12.25 19:17, Peter Xu wrote:
> On Wed, Dec 10, 2025 at 11:52:04AM +0000, Daniel P. Berrangé wrote:
>> On Wed, Dec 10, 2025 at 12:27:30PM +0100, Kevin Wolf wrote:
>>> Am 09.12.2025 um 17:28 hat Peter Xu geschrieben:
>>>> [This is an RFC series, as being marked out.  It is trying to collect
>>>>   opinions.  It's not for merging yet]
>>>>
>>>> Background
>>>> ==========
>>>>
>>>> It all starts with machine compat properties..
>>>>
>>>> Machine compat properties are the major weapon we use currently in QEMU to
>>>> define a proper guest ABI, so that whenever we migration a VM instance from
>>>> whatever QEMU version1 to another QEMU version2, as long as the machine
>>>> type is the same, logically the ABI is guaranteed, and migration should
>>>> succeed.  If it didn't, it's a bug.
>>>>
>>>> These compat properties are only attached to qdev for now.  It almost
>>>> worked.
>>>>
>>>> Said that, it's also not true - we already have non-qdev users of such, by
>>>> explicitly code it up to apply the compat fields.  Please refer to the
>>>> first patch commit message for details (meanwhile latter patches will
>>>> convert them into a generic model).
>>>>
>>>> Obviously, we have demands to leverage machine compat properties even
>>>> outside of qdev.  It can be a network backend, it can be an object (for
>>>> example, memory backends), it can be a migration object, and more.
>>>
>>> This doesn't feel obvious to me at all. A machine type defines what
>>> hardware the guest sees. Guest hardware is essentially qdev.
>>>
>>> I don't see any reasons why a backend should be interested in what guest
>>> hardware looks like, that would seem like a bad layering violation. Many
>>> backends can even exist without a guest at all, and are also used in
>>> tools like qemu-storage-daemon. Having a machine type in a tool that
>>> doesn't run a guest doesn't make any sense.
>>
>> The sev-guest compat property for 'legacy-vm-type' is an interesting
>> example.
>>
>> This property ultimately controls which of two different kernel ioctls
>> for KVM are used for initializing the SEV guest. It can casue guest
>> VM measurement changes, but none the less this is not really a guest
>> ABI knob, it is a host kernel compatibility knob.  You need a newer
>> host kernel version if this is set to 'off'.
>>
>> So by associating this legacy-vm-type type with the machine type,
>> we don't affect the guest hardware, but we *do* impact the ability
>> to use that machine type depedning on what kernel version you have.
> 
> Yes.
> 
> Maybe I emphasized too much on "guest ABI" in the cover letter, so it can
> be confusing when not reading into the details of the patchset (I did
> mention all the existing users in patch 1, then converted all existing
> users in patch 2-5).
> 
> Besides SEV, I can also quickly go over the rest ones if that wasn't clear
> we're already using this feature.. in a open-coded way.  Maybe that'll make
> it slightly easier to grasp for reviewers.
> 
> The current use case for hostmem (2nd example) on compat properties, see:
> 
>      commit fa0cb34d2210cc749b9a70db99bb41c56ad20831
>      Author: Marc-André Lureau <marcandre.lureau@redhat.com>
>      Date:   Wed Sep 12 16:18:00 2018 +0400
> 
>      hostmem: use object id for memory region name with >= 4.0
> 
> So that's not strictly "guest ABI", but the goal was to persist the name of
> MRs so that migration is not broken.  It's not strictly "guest ABI" but
> more like "guest ABI for migration" - even if the guest OS cannot see the
> names of MRs, migration can see (via ramblocks).  So it can be more than
> the guest HWs.
> 
> 3rd example in accel:
> 
>      commit fe174132478b4e7b0086f2305a511fd94c9aca8b
>      Author: Paolo Bonzini <pbonzini@redhat.com>
>      Date:   Wed Nov 13 15:16:44 2019 +0100
> 
>      tcg: add "-accel tcg,tb-size" and deprecate "-tb-size"
> 
> That was trying to keep some old behavior for accel cmdlines.  It's not
> even a migration ABI, but cmdline ABI.
> 
> Hence OBJECT_COMPAT might be useful whenever we want to persist some ABI.
> It can be machine compat properties, it can be something else that has
> nothing to do with machine types.  The accel example used a separate entry
> in object_compat_props[] (index 0) for the same purpose, out of three:
> 
> /*
>   * Global property defaults
>   * Slot 0: accelerator's global property defaults
>   * Slot 1: machine's global property defaults
>   * Slot 2: global properties from legacy command line option
>   * Each is a GPtrArray of GlobalProperty.
>   * Applied in order, later entries override earlier ones.
>   */
> static GPtrArray *object_compat_props[3];
> 
>>
>> IOW, QEMU machine types version 9.1 or later are no longer runnable
>> on many old kernels.
>>
>> Over the years we've had a good number of occassions where we want
>> defaults changes, or worse, where we auto-negotiate features, which
>> depend on host kernel version.
>>
>> I've suggested in the past that IMHO we're missing a concept of a
>> "versioned platform", to complement the "versioned machine" concept.
>>
>> That would let mgmt apps decide what platform compatibility level
>> they required, independantly of choosing machine types, and so avoid
>> creating runability constraints on machine types.
> 
> Yes, I agree some kind of "versioned platform" would be nice.  In practise,
> I wonder if it needs to be versioned at all, or something like a
> query-platform QMP API that will return the capabilities of the host in
> QEMU's view.  Maybe versioning isn't needed here.
> 
> Taking USO* feature for virtio-net as example, it should report what kind
> of USO* features are supported on this host.
> 
> IMHO it doesn't need to be the "yet another" weapon to define guest ABI /
> QEMU ABI.
> 
> Mgmt should leverage that interface to query and get platform informations
> across the whole cluster, then find a minimum set. Maybe also plus
> something the user would specify, for example, an user may want to
> explicitly disable USO feature on the whole cluster, then mgmt should also
> take it into account.
> 
> After the min subset of platform features selected, mgmt will need to map
> them into device properties and apply then when booting VM.  Then guest ABI
> is guaranteed.
> 
> So I think it might still be good we stick with the solo way to define the
> ABI, I hope we can stick with machine types.
> 
> There're also other things that may not be attached to platform
> capabilities, like the current discussion in:
> 
> https://lore.kernel.org/all/20251030203116.870742-1-vsementsov@yandex-team.ru/
> 
> That is about some new capability of network backend (in this case, TAP)
> that we should always enable for new QEMUs, but disable for old QEMUs.
> Such won't appear at all in query-platform..  Current solution proposed in
> that series was adding per-device special QMP commands to query and set
> these features.  However IMHO essentially it's the same problem that
> object_compat_props() is solving.  It's just that we need it to work
> outside of QDEV.
> 
> With OBJECT_COMPAT, we could QOMify TAP into an object and inherit from
> OBJECT_COMPAT.
> 
> Thanks,
> 

My two cents.

1. QAPI vs QOM

First, QEMU has too many object-like interfaces: QOM, QAPI structures, vmstates..
Of course, it would be better to have one generic. Should it be QAPI or QOBJECT?

If I understand correctly, these series expand the QOBJECTS's zone of influence. And
Kevin argue, that it could be QAPI instead. Right?

QOBJECT is better in a way that it represent existing in-QEMU state. QAPI structures
are normally used only temporarily during QMP calls.

If everything was a QOBJECT, we probably should not have to invent all these -replace-
and -change- commands in QMP for block layer object, but only implement set/get for
corresponding QOBJECT properties. And we'd not have to unite the namespaces of
qom paths, block export names and block node names, they all would be qom paths..

So we could live in the world, where we need to implement only "action" QMP commands,
like "migrate", "quit", "cont". But to change/query the state, we always use qom-set
qom-get, and don't invent a new command for each piece of state.

On the other hand, QAPI is a lot better in a way that it have explicit json schema.
QAPI definition is a protocol specification in the same time, we don't have such
thing for QOM. Probably the best world would be a QAPI-like interface to internal
QEMU objects, which are defined by QAPI structures. A kind of combination of best
options of QOM and QAPI worlds. But that's only a dream.


2. Machine types

I'd not care about them too much. Machine type is a syntax sugar, it's simply a
"set of defaults".

So, I think it's OK to share the concept wider than guest-ABI. What's wrong if
we just rename "Machine Type" into "Set Of QOM Defaults", and follow Peter's
suggestion? This way it will not conflict with tools that doesn't start the
guest, or don't have frontends.


-- 
Best regards,
Vladimir

