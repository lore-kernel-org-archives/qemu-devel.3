Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0FBAE7717D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 12:13:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKcd2-0006WP-V2; Mon, 09 Dec 2024 07:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tKcd0-0006Ui-6l
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:12:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tKccx-0003FV-Sh
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 07:12:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733746356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lJEEsaURfVoDvb8dB2uQwjfnC42uQGL+gF42sMAsGow=;
 b=MvCo8AbWU9uDCp49REQUfhhcpXODzFLx3wnCCWHmmQLvGfLHNa5ZgD/JO8RRbl8uu5tGWx
 C5JYLeNjaMemYG955onFEh7EizX8DH8iEuWTWlRjWBK0lUKD7j/JXhrzRwf0jDy65U3Pcm
 yAFCBoHqKD0n3Spf40veK/4iJdCYB1M=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-qevOGh03OxOnwmHFCdvy8g-1; Mon,
 09 Dec 2024 07:12:30 -0500
X-MC-Unique: qevOGh03OxOnwmHFCdvy8g-1
X-Mimecast-MFC-AGG-ID: qevOGh03OxOnwmHFCdvy8g
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B78B19560A2; Mon,  9 Dec 2024 12:12:29 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.194.102])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55348195608A; Mon,  9 Dec 2024 12:12:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 01F5C21EC35A; Mon,  9 Dec 2024 13:12:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  David Hildenbrand <david@redhat.com>,  Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Philippe Mathieu-Daude <philmd@linaro.org>,  Paolo
 Bonzini <pbonzini@redhat.com>,  "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V4 09/19] migration: incoming channel
In-Reply-To: <a7eaff5d-0030-445c-a31c-ce645666ecf3@oracle.com> (Steven
 Sistare's message of "Thu, 5 Dec 2024 15:45:17 -0500")
References: <1733145611-62315-1-git-send-email-steven.sistare@oracle.com>
 <1733145611-62315-10-git-send-email-steven.sistare@oracle.com>
 <87ser2cfw6.fsf@pond.sub.org>
 <a7eaff5d-0030-445c-a31c-ce645666ecf3@oracle.com>
Date: Mon, 09 Dec 2024 13:12:25 +0100
Message-ID: <87seqxf42e.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 12/5/2024 10:23 AM, Markus Armbruster wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Extend the -incoming option to allow an @MigrationChannel to be specified.
>>> This allows channels other than 'main' to be described on the command
>>> line, which will be needed for CPR.
>>>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> [...]
>> 
>>> diff --git a/qemu-options.hx b/qemu-options.hx
>>> index 02b9118..fab50ce 100644
>>> --- a/qemu-options.hx
>>> +++ b/qemu-options.hx
>>> @@ -4937,10 +4937,17 @@ DEF("incoming", HAS_ARG, QEMU_OPTION_incoming, \
>>>      "-incoming exec:cmdline\n" \
>>>      "                accept incoming migration on given file descriptor\n" \
>>>      "                or from given external command\n" \
>>> +    "-incoming @MigrationChannel\n" \
>>> +    "                accept incoming migration on the channel\n" \
>>>      "-incoming defer\n" \
>>>      "                wait for the URI to be specified via migrate_incoming\n",
>>>      QEMU_ARCH_ALL)
>>>  SRST
>>> +The -incoming option specifies the migration channel for an incoming
>>> +migration.  It may be used multiple times to specify multiple
>>> +migration channel types.
>>
>> Really?  If I understand the code below correctly, the last -incoming
>> wins, and any previous ones are silently ignored.
>
> See patch "cpr-channel", where the cpr channel is saved separately.
> Last wins, per channel type.
> I did this to preserve the current behavior of -incoming in which last wins.

Documentation needs to be clarified then.

> qemu_start_incoming_migration will need modification if more types are added.
>
>>>                             The channel type is specified in @MigrationChannel,
>>> +and is 'main' for all other forms of -incoming.
>>> +
>>>  ``-incoming tcp:[host]:port[,to=maxport][,ipv4=on|off][,ipv6=on|off]``
>>>    \
>>>  ``-incoming rdma:host:port[,ipv4=on|off][,ipv6=on|off]``
>>> @@ -4960,6 +4967,16 @@ SRST
>>>     Accept incoming migration as an output from specified external
>>>     command.
>>> +``-incoming @MigrationChannel``
>>> +    Accept incoming migration on the channel.  See the QAPI documentation
>>> +    for the syntax of the @MigrationChannel data element.  For example:
>>> +    ::
>>
>> I get what you're trying to express, but there's no precedence for
>> referring to QAPI types like @TypeName in option documentation.  But
>> let's ignore this until after we nailed down the actual interface, on
>> which I have questions below.
>
> Ack.
>
>>> +
>>> +        -incoming '{"channel-type": "main",
>>> +                    "addr": { "transport": "socket",
>>> +                              "type": "unix",
>>> +                              "path": "my.sock" }}'
>>> +
>>>  ``-incoming defer``
>>>      Wait for the URI to be specified via migrate\_incoming. The monitor
>>>      can be used to change settings (such as migration parameters) prior
>>> diff --git a/system/vl.c b/system/vl.c
>>> index 4151a79..2c24c60 100644
>>> --- a/system/vl.c
>>> +++ b/system/vl.c
>>> @@ -123,6 +123,7 @@
>>>  #include "qapi/qapi-visit-block-core.h"
>>>  #include "qapi/qapi-visit-compat.h"
>>>  #include "qapi/qapi-visit-machine.h"
>>> +#include "qapi/qapi-visit-migration.h"
>>>  #include "qapi/qapi-visit-ui.h"
>>>  #include "qapi/qapi-commands-block-core.h"
>>>  #include "qapi/qapi-commands-migration.h"
>>> @@ -159,6 +160,7 @@ typedef struct DeviceOption {
>>>  static const char *cpu_option;
>>>  static const char *mem_path;
>>>  static const char *incoming;
>>> +static MigrationChannelList *incoming_channels;
>>>  static const char *loadvm;
>>>  static const char *accelerators;
>>>  static bool have_custom_ram_size;
>>> @@ -1821,6 +1823,35 @@ static void object_option_add_visitor(Visitor *v)
>>>     QTAILQ_INSERT_TAIL(&object_opts, opt, next);
>>> }
>>> +static void incoming_option_parse(const char *str)
>>> +{
>>> +    MigrationChannel *channel;
>>> +
>>> +    if (str[0] == '{') {
>>> +        QObject *obj = qobject_from_json(str, &error_fatal);
>>> +        Visitor *v = qobject_input_visitor_new(obj);
>>> +
>>> +        qobject_unref(obj);
>>> +        visit_type_MigrationChannel(v, "channel", &channel, &error_fatal);
>>> +        visit_free(v);
>>> +    } else if (!strcmp(str, "defer")) {
>>> +        channel = NULL;
>>> +    } else {
>>> +        migrate_uri_parse(str, &channel, &error_fatal);
>>> +    }
>>> +
>>> +    /* New incoming spec replaces the previous */
>>> +
>>> +    if (incoming_channels) {
>>> +        qapi_free_MigrationChannelList(incoming_channels);
>>> +    }
>>> +    if (channel) {
>>> +        incoming_channels = g_new0(MigrationChannelList, 1);
>>> +        incoming_channels->value = channel;
>>> +    }
>>> +    incoming = str;
>>> +}
>>
>> @incoming is set to @optarg.
>>
>> @incoming_channels is set to a MigrationChannelList of exactly one
>> element, parsed from @incoming.  Except when @incoming is "defer", then
>> @incoming_channels is set to null.
>>
>> @incoming is only ever used as a flag.  Turn it into a bool?
>
> The remembered incoming specifier is also used in an error message in
> qmp_x_exit_preconfig:
>     error_reportf_err(local_err, "-incoming %s: ", incoming);
>
>> Oh, wait...  see my comment on the next hunk.
>>
>> Option -incoming resembles QMP command migrate-incoming.  Differences:
>>
>> * migrate-incoming keeps legacy URI and modern argument separate: there
>>   are two named arguments, and exactly one of them must be passed.
>>   -incoming overloads them: if @optarg starts with '{', it's modern,
>>   else legacy URI.
>>
>>   Because of that, -incoming *only* supports JSON syntax for modern, not
>>   dotted keys.  Other JSON-capable arguments support both.
>
> Not sure I follow.
> Could you give me a dotted key example for a JSON-capable argument?
> Do we care about dotted key for incoming, given the user can specify
> a simple legacy URI?

A quick grep for the usual parser qobject_input_visitor_new() finds
-audiodev, -blockdev, -compat, -display, and -netdev.  Beware, the
latter two come with backward compatibility gunk.  There's also -device
and -object, also with backward compatibility gunk.

Simple example:

    JSON        -compat '{"deprecated-input": "reject", "deprecated-output": "hide"}
    dotted keys -compat deprecated-input=reject,deprecated-output=hide

Slightly more interesting:

    JSON        -audiodev '{"id": "audiodev0", "driver": "wav", "in": {"voices": 4}}'
    dotted keys -audiodev id=audiodev0,driver=wav,in.voices=4

>>   How can a management application detect that -incoming supports
>>   modern?
>
> How does mgmt detect when other arguments support JSON?

Easy when an option supports it from the start: -audiodev, -blockdev,
-compat.  Awkward when we extend an existing option to support it:
-display, -netdev, -device, -object.

As far as I can tell at a glance, libvirt

* Remains unaware of -display JSON arguments

* Assumes -netdev accepts JSON when QMP netdev-add supports backend type
  "dgram", see commit 697e26fac66 (qemu: capabilities: Detect support
  for JSON args for -netdev) v8.10.0

* Assumes -device accepts JSON when QMP device_add has feature
  json-cli-hotplug, see commit 1a691fe1c84 (qemu: capabilities:
  Re-enable JSON syntax for -device) v8.1.0

* Assumes -object accepts JSON when object-add supports object type
  "secret", see commit f763b6e4390 (qemu: capabilities: Enable detection
  of QEMU_CAPS_OBJECT_QAPIFIED) v7.2.0

In theory, such indirect probing can fall apart when somebody backports
JSON syntax *without* the thing libvirt probes for.  They then get to
adjust libvirt's detection logic, too.  Hasn't been an issue in practice
as far as I know.

> The presence of cpr-transfer mode implies -incoming JSON support, though
> that is indirect.

Might be good enough.

> We could add a feature to the migrate-incoming command, like json-cli
> for device_add.  Seems like overkill though.  'feature' is little used,
> except for unstable and deprecated.

'feature' is best used sparingly.  But when it's needed, using it is
*fine*.

>>   Sure overloading -incoming this way is a good idea?
>>
>> * migrate-incoming takes a list of channels, currently restricted to a
>>   single channel.  -incoming takes a channel.  If we lift the
>>   restriction, -incoming syntax will become even messier: we'll have to
>>   additionally overload list of channel.
>>
>>   Should -incoming take a list from the start, like migrate-incoming
>>   does?
>
> That was my first try.  However, to support the equivalent of '-incoming deferred',
> we need to add an 'defer' key to the channel, and when defer is true, the other
> keys that are currently mandatory must be omitted.  The tweaks to the implementation
> and specification seemed not worth worth it.
>
> If we want -incoming to also support a channel list in the future, we can simply
> check for an initial '[' token.

Yes, but it'll then have to support single channels both as list of one
channel object, and channel object, unlike migrate-incoming.

Syntactical differences between CLI and QMP for things that are
semantically identical add unnecessary complexity, don't you think?

>>> +
>>>   static void object_option_parse(const char *str)
>>>   {
>>>       QemuOpts *opts;
>>> @@ -2730,7 +2761,7 @@ void qmp_x_exit_preconfig(Error **errp)
>>>       if (incoming) {
>>>           Error *local_err = NULL;
>>>           if (strcmp(incoming, "defer") != 0) {
>>> -            qmp_migrate_incoming(incoming, false, NULL, true, true,
>>> +            qmp_migrate_incoming(NULL, true, incoming_channels, true, true,
>>>                                    &local_err);
>>
>> You move the parsing of legacy URI from within qmp_migrate_incoming()
>> into incoming_option_parse().
>>
>> The alternative is not to parse it in incoming_option_parse(), but pass
>> it to qmp_migrate_incoming() like this:
>>
>>                 qmp_migrate_incoming(incoming, !incoming, incoming_channels,
>>                                      true, true, &local_err);
>
> Sure, I can tweak that, but I need to define an additional incoming_uri variable:
>     qmp_migrate_incoming(incoming_uri, !!incoming_channels, incoming_channels, ...
>
> Only one of incoming_uri and incoming_channels can be non-NULL (checked in
> qemu_start_incoming_migration).
>
> Would you prefer I continue down this path, or revert to the previous -cpr-uri
> option?  I made this change to make the incoming interface look more like the
> V4 outgoing interface, in which the user adds a cpr channel to the migrate command
> channels.

I'm not sure.  Peter, what do you think?


