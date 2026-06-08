Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0B9CD8C9F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWXOI-0003JK-LA; Mon, 08 Jun 2026 06:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWXO5-0003IK-Sz
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wWXO2-0006Xe-Nh
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 06:39:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780915132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 resent-to:resent-from:resent-message-id:in-reply-to:in-reply-to:
 references:references; bh=EMQegm1vyGTQDO8eY6w8pbL4Vo/nmltz4HxzHBm91HU=;
 b=GmWvi0HC4T/gldjBDUbgPb8N+/1E0/pCd2XntTmoehs0t2qvM2+kKE9r/9MPbcJmqbMfAZ
 9CjpX3hbUCLt4xzKB+rA2CAT8o4xfjY7wytOo2eB1i9xzy9FReCYZr2LiYUqQtFEfr08pp
 8Z5Xk3wvKFiJv7XUMBp9FZC5K58R/ko=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-TeMONzBgMH-BSiiWBCJ2LA-1; Mon,
 08 Jun 2026 06:38:44 -0400
X-MC-Unique: TeMONzBgMH-BSiiWBCJ2LA-1
X-Mimecast-MFC-AGG-ID: TeMONzBgMH-BSiiWBCJ2LA_1780915123
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8E381956056; Mon,  8 Jun 2026 10:38:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 11722180049F; Mon,  8 Jun 2026 10:38:41 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C6EA21E6A01; Mon, 08 Jun 2026 12:38:38 +0200 (CEST)
Resent-To: bchaney@akamai.com, raphael.s.norwitz@gmail.com,
 zhao1.liu@intel.com, philmd@linaro.org, qemu-devel@nongnu.org,
 mark.caveayland@nutanix.com, farosas@suse.de, vsementsov@yandex-team.ru,
 yc-core@yandex-team.ru
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Mon, 08 Jun 2026 12:38:38 +0200
Resent-Message-ID: <87zf15iafl.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com,  mst@redhat.com,  peterx@redhat.com,
 farosas@suse.de,  raphael.s.norwitz@gmail.com,  bchaney@akamai.com,
 qemu-devel@nongnu.org,  berrange@redhat.com,  pbonzini@redhat.com,
 yc-core@yandex-team.ru,  mark.caveayland@nutanix.com,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Zhao Liu
 <zhao1.liu@intel.com>,  Eric
 Blake <eblake@redhat.com>,  John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v17 08/10] net/tap: support local migration with virtio-net
In-Reply-To: <dd60fb31-3055-490e-9e75-e4976e524a83@yandex-team.ru> (Vladimir
 Sementsov-Ogievskiy's message of "Wed, 3 Jun 2026 19:50:57 +0300")
References: <20260527191150.250333-1-vsementsov@yandex-team.ru>
 <20260527191150.250333-9-vsementsov@yandex-team.ru>
 <877boh74kf.fsf@pond.sub.org>
 <2e44a425-4f04-4ed3-9c7e-ea649ab64300@yandex-team.ru>
 <87jysgm0ho.fsf@pond.sub.org>
 <dd60fb31-3055-490e-9e75-e4976e524a83@yandex-team.ru>
Date: Mon, 08 Jun 2026 10:05:57 +0200
Message-ID: <877bo9mp7e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 03.06.26 12:33, Markus Armbruster wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>>> On 02.06.26 11:02, Markus Armbruster wrote:
>>>> [Cc: John Snow for advice on cross-references (search for "John?")]
>>>>
>>>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>>>>
>>>>> Support transferring of TAP state (including open fd).
>>>>>
>>>>> Add new property "local-migration-supported", which defines,
>>>>> is local-migration is actually supported for this TAP device.
>>>>
>>>> which defines whether
>>>>
>>>>> Starting from 11.1 MT it's enabled by default.
>>>>
>>>> What does "MT" mean?
>>>
>>> Machine Type I mean
>> 
>> Got it.  Please don't abbreviate it here.
>> 
>>>
>>>>
>>>>>
>>>>> Note, that local-migration (including migrating opened FDs
>>>>> through migration channel, which must be UNIX socket), is
>>>>> enabled by global "local" migration parameters. But individual
>>>>> devices may have additional options to enable/disable it
>>>>> personally.
>>>>
>>>> per device
>>>>
>>>>>
>>>>> Add new option "incoming-fds", which should be set to true on
>>>>> target for incoming migration work. It says "do not open any
>>>>> files, but instead wait for FDs coming from migration stream".
>>>>> "local-migration-supported" option is not enough, as it work in pair
>>>>> with migration parameter "local", and intialization process
>>>>> of TAP device should not depend on migration parameters.
>>>>>
>>>>> For new option require explicitly unset script and downscript,
>>>>> to keep possibility of implementing support for them in the
>>>>> future.
>>>>
>>>> Why explicitly unset?  Do we have to override a default script?
>>>
>>> Current version doesn't support having any scripts, as we should
>>> also transfer a responsiblity for calling downscript to the target
>>> (but what if migration failed, transfer it back?).
>>>
>>> Still, several version ago Ben asked to keep a possibility to support
>>> scripts in future. So, current version requires script=no and
>>> downscript=no. In future we may implement support for scripts together
>>> with fd-migration, and drop this restriction.
>>>
>>> (Hope I answered the question)
>> 
>> I understand we can't run scripts specified with @script and @downscript
>> when @incoming-fds is enabled.  We might be able to run them in the
>> future.
>> 
>> We obviously should reject user requests for scripts we don't run.
>> Thus, user specifying scripts together with @incoming-fds should be an
>> error.  I understand it is in your code.
>> 
>> User specifying "no script" is obviously fine then.
>> 
>> Left: defaults.  The doc comment doesn't tell what they are.  That's a
>> defect in need of a fix.  Peeking at the code...  Looks like @script and
>> @downscript default to qemu-ifup and qemu-ifdown, respectively, both in
>> CONFIG_SYSCONFDIR.  Correct?
>> 
>> If yes, two options:
>> 
>> (1) Require the user to specify "no scripts", overriding the defaults.
>> Simple semantics.  Might be mildly annoying for human users.  Management
>> applications won't care.  I understand this is what your code does.
>> 
>> (2) Make the defaults depend on @incoming-fds: none if on, qemu-ifup and
>> qemu-ifdown if off.  Acceptable if documented.
>
> This seems inconsistent. If we are not going to deprecate current defaults,
> no reason to create different ones.
>
>> 
>> I think I prefer (1).
>
> That's what I do in the series
>
>> 
>> Please consider working some of this into your commit message.
>
> Ok. I think, actually adding a preparing patch, documenting current behavior
> will make things a lot more clear.

That would be lovely!

>>>>> Note disabling read polling on source stop for TAP migration:
>>>>
>>>> I don't understand this sentence.
>>>
>>> That's a realization detail. I've added it, because it was a fix, appeared
>>> several version ago. It may be dropped from commit message.
>>>
>>> The sentence is about tap_vm_state_change() function, which disables
>>> polling the TAP device.
>> 
>> Should it be a separate patch?
>
> Agree, that seems a good idea. Will try to split.
>
>> 
>>>>> otherwise, source process may steal packages from TAP fd even
>>>>> after source vm STOP.
>>>>>
>>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
>>>>
>>>> [...]
>>>>
>>>>> diff --git a/qapi/net.json b/qapi/net.json
>>>>> index 1a6382825c5..c5d87ba308b 100644
>>>>> --- a/qapi/net.json
>>>>> +++ b/qapi/net.json
>>>>> @@ -425,6 +425,22 @@
>>>>>  ##
>>>>>  # @NetdevTapOptions:
>>>>>  #
>>>>>  # Used to configure a host TAP network interface backend.
>>>>>  #
>>>>>  # @ifname: interface name
>>>>>  #
>>>>>  # @fd: file descriptor of an already opened tap
>>>>>  #
>>>>>  # @fds: multiple file descriptors of already opened multiqueue capable
>>>>>  #     tap
>>>>>  #
>>>>>  # @script: script to initialize the interface
>>>>>  #
>>>>>  # @downscript: script to shut down the interface
>>>>>  #
>>>>>  # @br: bridge name (since 2.8)
>>>>>  #
>>>>>  # @helper: command to execute to configure bridge
>>>>>  #
>>>>>  # @sndbuf: send buffer limit.  Understands [TGMKkb] suffixes.
>>>>>  #
>>>>>  # @vnet_hdr: enable the IFF_VNET_HDR flag on the tap interface
>>>>>  #
>>>>>  # @vhost: enable vhost-net network accelerator
>>>>>  #
>>>>>  # @vhostfd: file descriptor of an already opened vhost net device
>>>>>  #
>>>>>  # @vhostfds: file descriptors of multiple already opened vhost net
>>>>>  #     devices
>>>>>  #
>>>>>  # @vhostforce: vhost on for non-MSIX virtio guests
>>>>>  #
>>>>>  # @queues: number of queues to be created for multiqueue capable tap
>>>>>  #
>>>>>  # @poll-us: maximum number of microseconds that could be spent on busy
>>>>>  #     polling for tap (since 2.7)
>>>>>  #
>>>>> +# @incoming-fds: do not open or create any TAP devices.  Prepare for
>>>>> +#     getting TAP file descriptors from incoming migration stream.
>>>>> +#     The option is incompatible with any of @fd, @fds, @helper, @br,
>>>>> +#     @ifname, @sndbuf and @vnet_hdr options, and requires @script and
>>>>> +#     @downscript be explicitly set to nothing (empty string or "no"),
>>>>
>>>> WAT?!?
>>>>
>>>> Special value "no" is not documented in the QAPI schema, see the
>>>> descriptions of @script and @downscript above.
>>>>
>>>> It is documented for -netdev tap in qemu-options.hx:
>>>>
>>>>       ``-netdev tap,id=id[,fd=h][,ifname=name][,script=file][,downscript=dfile][,br=bridge][,helper=helper]``
>>>>           Configure a host TAP network backend with ID id.
>>>>
>>>>           Use the network script file to configure it and the network script
>>>>           dfile to deconfigure it. If name is not provided, the OS
>>>>           automatically provides one. The default network configure script is
>>>>           ``/etc/qemu-ifup`` and the default network deconfigure script is
>>>>           ``/etc/qemu-ifdown``. Use ``script=no`` or ``downscript=no`` to
>>>>           disable script execution.
>>>>
>>>> Special value "" is okay: you can't name have a script named "".
>>>>
>>>> Special value "no" isn't: you can have a script named "no", but if you
>>>> try to use it, it's silently ignored.  Yes, it's a silly name, but it's
>>>> also a silly interface.
>>>>
>>>> I think we should document "no" properly, and also deprecate it.
>>>
>>> I can make a patch, but that's actually not about this series, "no" is
>>> preexisting.
>> 
>> Yes, it is.  Keeping the deprecation patch separate is fine.
>> 
>>> Hmm, may be also deprecate using default scripts, when script options are
>>> not set by user?
>>>
>>> This way I can drop script=no & downscript=no requirements. And make
>>> absent script option mean "no scripts" for "incoming-fds" from the start.
>>> (or, I can do it even without deprecation, but that creates an inconsistency
>>> in the common interface)
>> 
>> Changing defaults is often awkward.
>> 
>> Changing the meaning of "@script absent" from qemu-ifup to no script is
>> a compatibility break.
>> 
>> We can deprecate "@script absent".  This pushes users to specify
>> @script, which is probably a good idea for management applications
>> anyway.  It may be annoying for humans.
>> 
>> After the deprecation grace period, we can change the default and
>> undeprecate.  Trap for management applications that somehow missed it
>> during the grace period (skipped too many QEMU versions?).  Not sure
>> that's how our deprecation process wants to be used.
>
> I'm afraid, skipping too many QEMU versions is existing practice
> for some downstream vendors :(

We want to be nice to our downstreams.  Even when they do things we
advise against like skipping a bunch of upstream versions without
closely examining how external interfaces evolved.  But at some point
"nice" can become too expensive for us.  Judgment call.

>> We could make @script mandatory instead.  Avoids the trap.
>> 
>> Same for @downscript.
>> 
>> Thoughts?
>
> I don't think that making "unused" options mandatory is much
> better than having unobvious defaults. So, we'll get yet
> another "not ideal" interface, and additional headache for
> those who used this default.
>
>
> I think, I'd keep things as is, just add documentation. And probably
> deprecate "no" in favor of "".

Works for me.

As I said, changing defaults is awkward.

>>>>> +#     and requires also @local-migration-supported to be true, "local"
>>>>> +#     migration parameter be set as well, and QEMU being in incoming
>>>>> +#     migration state.  (Since 11.1)
>>>>
>>>> This sentence is rather long and hard to parse.  Here's my attempt:
>>>>
>>>>   #     The option is incompatible with any of @fd, @fds, @helper, @br,
>>>>   #     @ifname, @sndbuf and @vnet_hdr options.  @script and @downscript
>>>>   #     must be explicitly disabled (empty string or "no"), and
>>>>   #     @local-migration-supported must be true.  Additionally,
>>>>   #     migration parameter @local must be set, and QEMU mist be in
>>>>   #     incoming migration state.  (Since 11.1)
>>>
>>> Sounds good, thanks!
>>>
>>>>
>>>> Ideally, "migration parameter @local" would link to its description, but
>>>> I can't tell you offhand whether we can do that and how.  John?
>>>>
>>>>> +#
>>>>> +# @local-migration-supported: enable local migration for this TAP
>>>>> +#     backend.  When set, local migration is enabled/disabled by
>>>>> +#     "local" migration parameter for this TAP backend.  When unset,
>>>>
>>>> migration parameter @local
>>>>
>>>>> +#     "local" migration parameter is ignored for this TAP backend.
>>>>> +#     (Since 11.1.  Defaults to true for MT >= 11.1, and to false for
>>>>> +#     MT < 11.1)
>>>>
>>>> What's "MT"?
>>>
>>> Machine Type
>> 
>> Got it.  Please don't abbreviate it here.
>> 
>>>>> +#
>>>>>  # Since: 1.2
>>>>>  ##
>>>>>  { 'struct': 'NetdevTapOptions',
>>>>> @@ -443,7 +459,9 @@
>>>>>      '*vhostfds':   'str',
>>>>>      '*vhostforce': 'bool',
>>>>>      '*queues':     'uint32',
>>>>> -    '*poll-us':    'uint32'} }
>>>>> +    '*poll-us':    'uint32',
>>>>> +    '*incoming-fds': 'bool',
>>>>> +    '*local-migration-supported': 'bool' } }
>>>>>  
>>>>>  ##
>>>>>  # @NetdevSocketOptions:
>>>>
>>>> Two bools mean four cases.  @incoming-fd's description excludes the case
>>>> "incoming-fd": true, "local-migration-supported": false.  Awkward.  Does
>>>> case ""incoming-fd": false, "local-migration-supported": true make sense
>>>> and why?
>>>>
>>>
>>> Yes, as local-migration-supported enables the whole feature, and it will
>>> be set by default starting from 11.1 machine type (read, starting from
>>> 11.1 QEMU, if not use older machine type).
>> 
>> What are the use cases for the three valid combinations?
>> 
>> * "incoming-fd": false, "local-migration-supported": false
>
> Old Machine Type, the feature is disabled.
>
>> 
>> * "incoming-fd": false, "local-migration-supported": true
>
> New Machine type, the feature is enabled generally. But for current incoming
> migration it's disabled, for example because it's a remote migration (so, we can't
> migrate FDs through UNIX socket, and we don't set "local" migration parameter
> of course).
>
> Or, it's not an incoming migration, but a "first cold start" of the VM,
> of course "incoming-fd" is false, to open real files/sockets, but we
> are prepared for future local migrations (live-updates) with new feature
> enabled.
>
>> 
>> * "incoming-fd": true, "local-migration-supported": true
>
> New Machine type, the feature is enabled generally. And it is enabled for
> current incoming migration. "local" migration parameter should be set too, and
> UNIX socket should be used for migration channel.

Could this be worked into the docs somehow?

Would be easy if we had an enum of three values instead of two bools...

>>> "local-migration-supported" makes sense both for source and target,
>>> "incoming-fds" only for target.
>>>
>>> I describe, whey we can't live with only one boolean here:
>>>
>>>      https://lore.kernel.org/qemu-devel/a572dadb-6ea6-48f2-a77c-3a4531dbad49@yandex-team.ru/
>>>
>>> and it's also a start of discussion for alternative interface (which makes possible to
>>> realy on "local" migration parameter instead of having extra "incoming-fds").
>>>
>>> And here further RFC from Peter: https://lore.kernel.org/qemu-devel/20260528212947.368132-1-peterx@redhat.com/
>>>
>>> Finally, that's all why "incoming-fds" is unstable (see squash-in in parallel reply)
>> 
>> Should @local-migration-supported also be unstable?
>> 
>
> "incoming-fds" in unstable, as it may be removed in favor of local-migration-suppoerted && local,
> if "local" becomes available earlier as suggested by Peter's RFC.
>
> local-migration-supported will stay as is, even if RFC applied.
>
> Still, I agree, if part of new (quite complicated) interface is unstable, the whole
> interface is risky. No problem to keep all new options "unstable" for a while.

Let's do that, nothing to lose.


