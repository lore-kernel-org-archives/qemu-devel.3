Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39746C0218A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 11:58:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tckCp-0004DL-95; Tue, 28 Jan 2025 06:56:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tckCk-0004D3-P2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:56:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tckCh-0004Yv-8C
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 06:56:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738065377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f+jIafSimaWfT03uZLX9o67M8QZsBO1VVQUVN5+btvs=;
 b=VVSbP6PQsJjWs35++rRb+O5GM+WAgyx4f9JbN/LKh4Bp65sV61XCBZwjlNDf7SH9r2CimF
 3iY1U+0iRVmHgvZYT5ZStuu+I5iR+sl66gaXJqd95FoXNcL9zTDgyeXVGC/poHZJlzO71Y
 p+tC5bRE8KFNQ/IiSOgdxmH5QJVty7E=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-k_McsTItNEeNAUjg_vZY5g-1; Tue,
 28 Jan 2025 06:56:15 -0500
X-MC-Unique: k_McsTItNEeNAUjg_vZY5g-1
X-Mimecast-MFC-AGG-ID: k_McsTItNEeNAUjg_vZY5g
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6036818009E1; Tue, 28 Jan 2025 11:56:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 993011800361; Tue, 28 Jan 2025 11:56:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8B31721E6A28; Tue, 28 Jan 2025 12:56:11 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V5 15/23] migration: cpr-transfer mode
In-Reply-To: <3c5ef58e-8f2d-401f-9cbf-42598ab6287d@oracle.com> (Steven
 Sistare's message of "Mon, 27 Jan 2025 11:35:49 -0500")
References: <1735057028-308595-1-git-send-email-steven.sistare@oracle.com>
 <1735057028-308595-16-git-send-email-steven.sistare@oracle.com>
 <87ed1eakxr.fsf@pond.sub.org>
 <2ae6c272-837c-4d88-bcfa-fc7719cc447d@oracle.com>
 <87bjw5tv08.fsf@pond.sub.org>
 <3c5ef58e-8f2d-401f-9cbf-42598ab6287d@oracle.com>
Date: Tue, 28 Jan 2025 12:56:11 +0100
Message-ID: <878qqvgnj8.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 1/17/2025 8:44 AM, Markus Armbruster wrote:
>> Steven Sistare <steven.sistare@oracle.com> writes:
>> 
>>> On 1/7/2025 7:05 AM, Markus Armbruster wrote:
>>>> Steve Sistare <steven.sistare@oracle.com> writes:
>>>>
>>>>> Add the cpr-transfer migration mode, which allows the user to transfer
>>>>> a guest to a new QEMU instance on the same host with minimal guest pause
>>>>> time, by preserving guest RAM in place, albeit with new virtual addresses
>>>>> in new QEMU, and by preserving device file descriptors.  Pages that were
>>>>> locked in memory for DMA in old QEMU remain locked in new QEMU, because the
>>>>> descriptor of the device that locked them remains open.
>>>>>
>>>>> cpr-transfer preserves memory and devices descriptors by sending them to
>>>>> new QEMU over a unix domain socket using SCM_RIGHTS.  Such CPR state cannot
>>>>> be sent over the normal migration channel, because devices and backends
>>>>> are created prior to reading the channel,
>>>>
>>>> Is that an artifact of the way QEMU starts up, or is it fundamental?
>>>
>>> Hi Markus, welcome back and Happy New Year!
>> 
>> Thank you!  A late happy new year for you, too!
>
> Sorry for the delay, I have been heads down preparing a new series.

No sweat :)

>>> This is a deeply ingrained artifact.  Changing it would require radically
>>> refactoring the information passed on the command line vs the information
>>> passed via monitor.
>> 
>> More on this below.
>> 
>>>>>                                              so this mode sends CPR state
>>>>> over a second "cpr" migration channel.  New QEMU reads the cpr channel
>>>>> prior to creating devices or backends.  The user specifies the cpr channel
>>>>> in the channel arguments on the outgoing side, and in a second -incoming
>>>>> command-line parameter on the incoming side.
>>>>>
>>>>> The user must start old QEMU with the the '-machine aux-ram-share=on' option,
>>>>> which allows anonymous memory to be transferred in place to the new process
>>>>> by transferring a memory descriptor for each ram block.  Memory-backend
>>>>> objects must have the share=on attribute, but memory-backend-epc is not
>>>>> supported.
>>>>>
>>>>> The user starts new QEMU on the same host as old QEMU, with command-line
>>>>> arguments to create the same machine, plus the -incoming option for the
>>>>> main migration channel, like normal live migration.  In addition, the user
>>>>> adds a second -incoming option with channel type "cpr".  The CPR channel
>>>>> address must be a type, such as unix socket, that supports SCM_RIGHTS.
>>>>>
>>>>> To initiate CPR, the user issues a migrate command to old QEMU, adding
>>>>> a second migration channel of type "cpr" in the channels argument.
>>>>> Old QEMU stops the VM, saves state to the migration channels, and enters
>>>>> the postmigrate state.  New QEMU mmap's memory descriptors, and execution
>>>>> resumes.
>>>>>
>>>>> The implementation splits qmp_migrate into start and finish functions.
>>>>> Start sends CPR state to new QEMU, which responds by closing the CPR
>>>>> channel.  Old QEMU detects the HUP then calls finish, which connects the
>>>>> main migration channel.
>>>>>
>>>>> In summary, the usage is:
>>>>>
>>>>>     qemu-system-$arch -machine aux-ram-share=on ...
>>>>>
>>>>>     start new QEMU with "-incoming <main-uri> -incoming <cpr-channel>"
>>>>>
>>>>>     Issue commands to old QEMU:
>>>>>       migrate_set_parameter mode cpr-transfer
>>>>>
>>>>>       {"execute": "migrate", ...
>>>>>           {"channel-type": "main"...}, {"channel-type": "cpr"...} ... }
>>>>>
>>>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>>> [...]
>>>>
>>>>> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
>>>>> index f31deb3..2210f0c 100644
>>>>> --- a/migration/vmstate-types.c
>>>>> +++ b/migration/vmstate-types.c
>>>>> @@ -15,6 +15,7 @@
>>>>>    #include "qemu-file.h"
>>>>>    #include "migration.h"
>>>>>    #include "migration/vmstate.h"
>>>>> +#include "migration/client-options.h"
>>>>>    #include "qemu/error-report.h"
>>>>>    #include "qemu/queue.h"
>>>>>    #include "trace.h"
>>>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>>>> index a605dc2..35309dc 100644
>>>>> --- a/qapi/migration.json
>>>>> +++ b/qapi/migration.json
>>>>> @@ -614,9 +614,47 @@
>>>>>    #     or COLO.
>>>>>    #
>>>>>    #     (since 8.2)
>>>>> +#
>>>>> +# @cpr-transfer: This mode allows the user to transfer a guest to a
>>>>> +#     new QEMU instance on the same host with minimal guest pause
>>>>> +#     time, by preserving guest RAM in place, albeit with new virtual
>>>>> +#     addresses in new QEMU.  Devices and their pinned pages will also
>>>>> +#     be preserved in a future QEMU release.
>>>>
>>>> Maybe "@cpr-transfer: Checkpoint and restart migration mode minimizes
>>>> guest pause time by transferring guest RAM without copying it."
>>>
>>> "Checkpoint and restart migration mode" is ambiguous.  It would be
>>> "Checkpoint and restart transfer migration mode".  That's a mouthful!
>>> "This mode" is unambiguous, and matches the concise style of describing
>>> options in this file.  Few if any of the options in this file repeat the
>>> name of the option in the description.
>> 
>> True.  But will readers understand what "CPR" stands for?  Do they need
>> to understand?
>
> No, IMO they do not need to know the full spelling of the acronym to use the
> functionality.  It is spelled out in a few places now.  It could be spelled
> out in more places in the future.

Alright.

>>>> If you want to mention the guest RAM mapping differs between old and new
>>>> QEMU, that's fine, but it's also detail, so I'd do it further down.
>>>
>>> I'll strike it.  I agree the user does not need to know.
>>>
>>>>> +#
>>>>> +#     The user starts new QEMU on the same host as old QEMU, with
>>>>> +#     command-line arguments to create the same machine, plus the
>>>>> +#     -incoming option for the main migration channel, like normal
>>>>> +#     live migration.  In addition, the user adds a second -incoming
>>>>> +#     option with channel type "cpr".  The CPR channel address must
>>>>> +#     be a type, such as unix socket, that supports SCM_RIGHTS.
>>>>
>>>> Permit me to indulge in a bit of pedantry...  A channel address doesn't
>>>> support SCM_RIGHTS, only a channel may.  A channel supports it when it
>>>> is backed by a UNIX domain socket.  The channel's socket's transport
>>>> type need not be 'unix' for that, it could also be 'fd'.
>>>>
>>>> Suggest something like "This CPR channel must be a UNIX domain socket."
>>>>
>>>> If you want to say why, that's fine: "This CPR channel must support file
>>>> descriptor transfer, i.e. it must be a UNIX domain socket."
>>>>
>>>> If you want to mention SCM_RIGHTS, that's fine, too: "This CPR channel
>>>> must support file descriptor transfer with SCM_RIGHTS, i.e. it must be a
>>>> UNIX domain socket."
>>>
>>> OK.
>>>
>>>>> +#
>>>>> +#     To initiate CPR, the user issues a migrate command to old QEMU,
>>>>> +#     adding a second migration channel of type "cpr" in the channels
>>>>
>>>> in the channel's
>>>>
>>>>> +#     argument.  Old QEMU stops the VM, saves state to the migration
>>>>> +#     channels, and enters the postmigrate state.  Execution resumes
>>>>> +#     in new QEMU.
>>>>> +#
>>>>> +#     New QEMU reads the CPR channel before opening a monitor, hence
>>>>> +#     the CPR channel cannot be specified in the list of channels for
>>>>> +#     a migrate-incoming command.  It may only be specified on the
>>>>> +#     command line.
>>>>
>>>> This is a restriction that could conceivably be lifted in the future,
>>>> right?
>>>
>>> Yes, but lifting it requires the big command-line vs monitor restructuring
>>> I mentioned earlier.  IMO that is far enough in the future (and possibly never)
>>> that adding a "Currently" disclaimer would be deceptive.
>> 
>> Now I'm confused.
>> 
>> Earlier, you explained why we can't simply send CPR state via the normal
>> migration channel: we create devices and backends much earlier long
>> before we receive from the migration channel.  Correct?
>
> Correct.
>
>> Here, you're documenting that the CPR channel can only be specified on
>> the command line, not with migrate-incoming.  Isn't that a different
>> problem?
>
> They are entangled problems.
>
> * cpr state must loaded before backends are created

I understand this is fundamental, i.e. CPR state is *required* to create
backends.  Correct?

> * monitor must be created after backends are created
>    (because the chardevs that define a monitor are backends).

This is an artifact of the way we configure monitors (use of a character
backend) and create character backends (all at once at a certain point
in startup).

Some management applications would prefer to use the command line just
for setting up QMP, and do everything else in QMP.  Understandable!
They need to use QMP anyway, and mostly eliminating the command line
would simplify things.  Moreover, only QMP provides introspection.

To enable this, we need to provide a way to start a QMP monitor early
enough to set up everything else.  If we pull this off, "monitor must be
created after backends are created" is no longer true.

Aside: in my view, QMP and command line are transports wrapping around
an abstract interface.  I'd like to have them wrap around the *same*
abstract interface.

> * migrate-incoming must come after the monitor is created

Fundamental.

> ==> migrate-incoming cannot specify the cpr-state channel
>
> This restriction is unlikely to change any time soon, if ever.

I wouldn't bet my own money on this :)

> I have documented it as is, without speculating about future state.
> If users do not like it they can request changes.

I'm not objecting to your doc text.  I asked to better understand your
thinking, because I needed that for a competent review.

>>>> What happens if a user tries to specify it with migrate-incoming?  Fails
>>>> cleanly?  What's the error message?
>>>
>>> It fails cleanly with a pre-existing error message that could be more
>>> descriptive, so I will improve it, thanks.
>>>
>>>> Maybe simply:
>>>>
>>>>            Currently, the CPR channel can only be specified on the command
>>>>            line, not with the migrate-incoming command.
>>>>
>>>> with a big, fat comment explaining the restriction next to the spot
>>>> that reports the error.
>>>>
>>>>> +#
>>>>> +#     The main channel address cannot be a file type, and for the tcp
>>>>> +#     type, the port cannot be 0 (meaning dynamically choose a port).
>>>>
>>>> What's "the tcp type"?  URI "tcp:..." / channel
>>>> addr.transport=socket,addr.type=inet?
>>>
>>> I will clarify.
>>>
>>>>> +#
>>>>> +#     Memory-backend objects must have the share=on attribute, but
>>>>> +#     memory-backend-epc is not supported.  The VM must be started
>>>>> +#     with the '-machine aux-ram-share=on' option.
>>>>> +#
>>>>> +#     When using -incoming defer, you must issue the migrate command
>>>>> +#     to old QEMU before issuing any monitor commands to new QEMU.
>>>>> +#     However, new QEMU does not open and read the migration stream
>>>>> +#     until you issue the migrate incoming command.
>>>>
>>>> I think some (all?) instances of "old QEMU" and "new QEMU" would read
>>>> better as "the old QEMU" and "the new QEMU".
>>>
>>> Maybe slightly,
>> 
>> A second opinion from a native speaker would be nice.
>
> I have appreciated all your feedback and made many changes, and it has made
> the code and documentation better.  Thanks for that. But right now, the V9
> patches are queued, pass CI, and are ready to roll. I would hope at this point
> that no one would consider "old QEMU" vs "the old QEMU" to be a showstopper
> that requires new patches to be posted.

Certainly not a blocker.  If we decide it's an improvement we want, we
can easily do it on top.

I routinely point out lots of little things that aren't blockers.  I try
to be clear what is a blocker and what isn't, but I'm far from perfect
there.  Thanks for your patience!

[...]


