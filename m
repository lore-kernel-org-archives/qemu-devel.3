Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2875EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 06:27:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2mNy-00011a-Oc; Fri, 03 May 2024 02:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2mNn-0000q9-S7
 for qemu-devel@nongnu.org; Fri, 03 May 2024 02:27:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s2mNl-00006P-Nw
 for qemu-devel@nongnu.org; Fri, 03 May 2024 02:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714717616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L4yeHJnU90bSgY+/jD+OGhA5qru9R2VGlCYNNqk/rao=;
 b=JgP4wcgaUt0mZEiFMPfpykVmKBd0+984H+KbilG4gy+vAWOdpN3Y1sB7+A8BkvFCvHCULn
 Af5A8vQhe1PphRMUboXwIz6pIaE6r5n8KKJzcRepjAwpfoftJ8loKU18KU5FnbpGWqdr3E
 k/hbtcpV/sTndxDUmL4WdFqF+uUMOpY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-KqvxLVFFMniiH2CZsqIW3w-1; Fri, 03 May 2024 02:26:52 -0400
X-MC-Unique: KqvxLVFFMniiH2CZsqIW3w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C5BE80017B;
 Fri,  3 May 2024 06:26:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C7EB640C6CC1;
 Fri,  3 May 2024 06:26:51 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D1A1221E6682; Fri,  3 May 2024 08:26:50 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Philippe Mathieu-Daude
 <philmd@linaro.org>,  Paolo Bonzini <pbonzini@redhat.com>,  "Daniel P.
 Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V1 20/26] migration: cpr-exec mode
In-Reply-To: <39b6e4b1-1910-4411-a3f0-d96214bcd6d6@oracle.com> (Steven
 Sistare's message of "Thu, 2 May 2024 12:00:23 -0400")
References: <1714406135-451286-1-git-send-email-steven.sistare@oracle.com>
 <1714406135-451286-21-git-send-email-steven.sistare@oracle.com>
 <87bk5o7679.fsf@pond.sub.org>
 <39b6e4b1-1910-4411-a3f0-d96214bcd6d6@oracle.com>
Date: Fri, 03 May 2024 08:26:50 +0200
Message-ID: <87edaj2yxh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 5/2/2024 8:23 AM, Markus Armbruster wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Add the cpr-exec migration mode.  Usage:
>>>    qemu-system-$arch -machine memfd-alloc=on ...
>>>    migrate_set_parameter mode cpr-exec
>>>    migrate_set_parameter cpr-exec-args \
>>>      <arg1> <arg2> ... -incoming <uri>
>>>    migrate -d <uri>
>>>
>>> The migrate command stops the VM, saves state to the URI,
>>> directly exec's a new version of QEMU on the same host,
>>> replacing the original process while retaining its PID, and
>>> loads state from the URI.  Guest RAM is preserved in place,
>>> albeit with new virtual addresses.
>>>
>>> Arguments for the new QEMU process are taken from the
>>> @cpr-exec-args parameter.  The first argument should be the
>>> path of a new QEMU binary, or a prefix command that exec's the
>>> new QEMU binary.
>>>
>>> Because old QEMU terminates when new QEMU starts, one cannot
>>> stream data between the two, so the URI must be a type, such as
>>> a file, that reads all data before old QEMU exits.
>>>
>>> Memory backend objects must have the share=on attribute, and
>>> must be mmap'able in the new QEMU process.  For example,
>>> memory-backend-file is acceptable, but memory-backend-ram is
>>> not.
>>>
>>> The VM must be started with the '-machine memfd-alloc=on'
>>> option.  This causes implicit ram blocks (those not explicitly
>>> described by a memory-backend object) to be allocated by
>>> mmap'ing a memfd.  Examples include VGA, ROM, and even guest
>>> RAM when it is specified without a memory-backend object.
>>>
>>> The implementation saves precreate vmstate at the end of normal
>>> migration in migrate_fd_cleanup, and tells the main loop to call
>>> cpr_exec.  Incoming qemu loads preceate state early, before objects
>>> are created.  The memfds are kept open across exec by clearing the
>>> close-on-exec flag, their values are saved in precreate vmstate,
>>> and they are mmap'd in new qemu.
>>>
>>> Note that the memfd-alloc option is not related to memory-backend-memfd.
>>> Later patches add support for memory-backend-memfd, and for additional
>>> devices, including vfio, chardev, and more.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> 
>> [...]
>> 
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 49710e7..7c5f45f 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -665,9 +665,37 @@
>>>  #     or COLO.
>>>  #
>>>  #     (since 8.2)
>>> +#
>>> +# @cpr-exec: The migrate command stops the VM, saves state to the URI,

What URI?  I know you mean the migration URI, but will readers know?
Elsewhere, we use "migration URI".

Hmm.  That's no good, either: we may not *have* a migration URI since
commit 074dbce5fcce (migration: New migrate and migrate-incoming
argument 'channels') and its fixup commit 57fd4b4e1075 made command
migrate argument @uri optional and mutually exclusive with @channels.

I think we better use more generic terminology here.  Let's have a look
at migrate's documentation for inspiration:

    ##
    # @migrate:
    #
    # Migrates the current running guest to another Virtual Machine.
    #
    # @uri: the Uniform Resource Identifier of the destination VM
    #
    # @channels: list of migration stream channels with each stream in the
    #     list connected to a destination interface endpoint.
    #
    [...]
    # Notes:
    [...]
    #     4. The uri argument should have the Uniform Resource Identifier
    #        of default destination VM. This connection will be bound to
    #        default network.
    #
    #     5. For now, number of migration streams is restricted to one,
    #        i.e. number of items in 'channels' list is just 1.
    #
    #     6. The 'uri' and 'channels' arguments are mutually exclusive;
    #        exactly one of the two should be present.

Perhaps "saves the state to the migration destination"?

>>> +#     directly exec's a new version of QEMU on the same host,
>>> +#     replacing the original process while retaining its PID, and
>>> +#     loads state from the URI.  Guest RAM is preserved in place,

"loads the state from the migration destination"?

We should also fix up existing uses of "migration URI": @mapped-ram,
@cpr-reboot, @tls-hostname.  Not this series' job.  I'll report it
separately.

>>> +#     albeit with new virtual addresses.
>> 
>> Do you mean the virtual addresses of guest RAM may differ betwen old and
>> new QEMU process?
>
> The VA at which a guest RAM segment is mapped in the QEMU process
> changes.  The end user would not notice or care, so I'll drop that
> detail here.
>
>>> +#
>>> +#     Arguments for the new QEMU process are taken from the
>>> +#     @cpr-exec-args parameter.  The first argument should be the
>>> +#     path of a new QEMU binary, or a prefix command that exec's the
>>> +#     new QEMU binary.
>> 
>> What's a "prefix command"?  A wrapper script, perhaps?
>
> A prefix command is any command of the form:
>    command1 command1-args command2 command2-args
> where command1 performs some set up before exec'ing command2.
> However, I will drop the word "prefix", it adds no meaning here.

Maybe "the command to start the new QEMU process"?

Hmm.  @cpr-exec-args is documented like this:

    # @cpr-exec-args: Arguments passed to new QEMU for @cpr-exec mode.
    #    See @cpr-exec for details.  (Since 9.1)

Is it a good idea to keep the details with @cpr-exec?  Let me try not
to.  Replace the "Arguments for the new QEMU process..." paragraph by

    #     The new QEMU process is started according to migration parameter
    #     @cpr-exec-args.

Then document cpr-exec-args like

    # @cpr-exec-args: Command to start the new QEMU process for MigMode
    # @cpr-exec.  The first list element is the program's filename, the
    # remainder its arguments.

What do you think?

Naming the thing "-args" feels questionable.  It's program and
arguments.

For what it's worth, QGA command guest-exec has them separate:

    # @path: path or executable name to execute
    #
    # @arg: argument list to pass to executable

The name @path is poorly chosen.

qmp_guest_exec() then prepends @path to @arg to make the argv[] for the
execve() wrapper it uses.

I figure you'd rather not have them separate, to keep migration
parameters simpler.  Name it @cpr-exec-command?

>>> +#
>>> +#     Because old QEMU terminates when new QEMU starts, one cannot
>>> +#     stream data between the two, so the URI must be a type, such as
>>> +#     a file, that reads all data before old QEMU exits.
>> 
>> What happens when you specify a URI that doesn't?
>
> Old QEMU will quietly block indefinitely writing to the URI.

Worth spelling that out in the doc comment?

>>> +#
>>> +#     Memory backend objects must have the share=on attribute, and
>>> +#     must be mmap'able in the new QEMU process.  For example,
>>> +#     memory-backend-file is acceptable, but memory-backend-ram is
>>> +#     not.
>>> +#
>>> +#     The VM must be started with the '-machine memfd-alloc=on'
>> 
>> What happens when you don't?
>
> If '-only-migratable-modes cpr-exec' is specified, then QEMU will fail
> to start, and print a clear error message.
>
> Otherwise, a blocker is registered and any attempt to cpr-exec will fail
> with a clear error message.

With clear errors, no further documentation is needed.  Good :)

> - Steve
>
>>> +#     option.  This causes implicit ram blocks -- those not explicitly
>>> +#     described by a memory-backend object -- to be allocated by
>>> +#     mmap'ing a memfd.  Examples include VGA, ROM, and even guest
>>> +#     RAM when it is specified without a memory-backend object.
>>> +#
>>> +#     (since 9.1)
>>>   ##
>>>   { 'enum': 'MigMode',
>>> -  'data': [ 'normal', 'cpr-reboot' ] }
>>> +  'data': [ 'normal', 'cpr-reboot', 'cpr-exec' ] }
>>>   
>>>   ##
>>>   # @ZeroPageDetection:
>> 
>> [...]
>> 


