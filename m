Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2F4DC48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 21:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfoJk-0006ie-Na; Thu, 29 Feb 2024 16:51:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfoJi-0006iU-Qr
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:51:50 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfoJf-0000DU-Fv
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 16:51:50 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1639321AAE;
 Thu, 29 Feb 2024 21:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709243504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNX2iAfu4zAJntAwuAl0NAMieT4OTWwmQ21REjTx9jU=;
 b=0GTZB/9ZWnEvjbnJLzAxgrZgY1ACD5ElYoI6pjh5VobkMEjXdihkdXGFqhCzJxs6libSuC
 J4VILFpjHE0nwAPx4CnR32qGORjiNCLxyi7kds/PXQitCpOiYYzZWgdbatJ+KwqO1ppq0+
 rp1wdJqhfT8XwZWrxrjVt1F1f0nVfiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709243504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNX2iAfu4zAJntAwuAl0NAMieT4OTWwmQ21REjTx9jU=;
 b=Bs1KPER9XJvMUGxCuDMfA2SFVxXM7b9bjVElcymtDdMbiJDd7/Jy3aMP9GX2cX+8/n9aOW
 1+ork8jY1djE2HBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709243504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNX2iAfu4zAJntAwuAl0NAMieT4OTWwmQ21REjTx9jU=;
 b=0GTZB/9ZWnEvjbnJLzAxgrZgY1ACD5ElYoI6pjh5VobkMEjXdihkdXGFqhCzJxs6libSuC
 J4VILFpjHE0nwAPx4CnR32qGORjiNCLxyi7kds/PXQitCpOiYYzZWgdbatJ+KwqO1ppq0+
 rp1wdJqhfT8XwZWrxrjVt1F1f0nVfiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709243504;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNX2iAfu4zAJntAwuAl0NAMieT4OTWwmQ21REjTx9jU=;
 b=Bs1KPER9XJvMUGxCuDMfA2SFVxXM7b9bjVElcymtDdMbiJDd7/Jy3aMP9GX2cX+8/n9aOW
 1+ork8jY1djE2HBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 915DB13503;
 Thu, 29 Feb 2024 21:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rM+QFW/84GXkCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 21:51:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
In-Reply-To: <87o7c0rruo.fsf@suse.de>
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com> <87zfvr7xdn.fsf@suse.de>
 <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com>
 <87bk83bcqj.fsf@suse.de>
 <32687fa3-78dc-457b-ae50-854d2c72c922@nutanix.com>
 <894b5da4-0af1-4ca0-b8a7-da288bb20774@nutanix.com>
 <87o7c0rruo.fsf@suse.de>
Date: Thu, 29 Feb 2024 18:51:41 -0300
Message-ID: <87cysfym4y.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.09)[-0.425]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Fabiano Rosas <farosas@suse.de> writes:

> Het Gala <het.gala@nutanix.com> writes:
>
>> On 27/02/24 1:04 am, Het Gala wrote:
>>>
>>>
>>> On 26/02/24 6:31 pm, Fabiano Rosas wrote:
>>>> Het Gala<het.gala@nutanix.com>  writes:
>>>>
>>>>> On 24/02/24 1:42 am, Fabiano Rosas wrote:
>>>>> this was the same first approach that I attempted. It won't work because
>>>>>
>>>>> The final 'migrate' QAPI with channels string would look like
>>>>>
>>>>> { "execute": "migrate", "arguments": { "channels": "[ { "channel-type":
>>>>> "main", "addr": { "transport": "socket", "type": "inet", "host":
>>>>> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ]" } }
>>>>>
>>>>> instead of
>>>>>
>>>>> { "execute": "migrate", "arguments": { "channels": [ { "channel-type":
>>>>> "main", "addr": { "transport": "socket", "type": "inet", "host":
>>>>> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ] } }
>>>>>
>>>>> It would complain, that channels should be an *array* and not a string.
>>>>>
>>>>> So, that's the reason parsing was required in qtest too.
>>>>>
>>>>> I would be glad to hear if there are any ideas to convert /string ->
>>>>> json object -> add it inside qdict along with uri/ ?
>>>>>
>>>> Isn't this what the various qobject_from_json do? How does it work with
>>>> the existing tests?
>>>>
>>>>      qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
>>>>                               "  'arguments': { "
>>>>                               "      'channels': [ { 'channel-type': 'main',"
>>>>                               "      'addr': { 'transport': 'socket',"
>>>>                               "                'type': 'inet',"
>>>>                               "                'host': '127.0.0.1',"
>>>>                               "                'port': '0' } } ] } }");
>>>>
>>>> We can pass this^ string successfully to QMP somehow...
>>>
>>> I think, here in qtest_qmp_assert_success, we actually can pass the 
>>> whole QMP command, and it just asserts that return key is present in 
>>> the response, though I am not very much familiar with qtest codebase 
>>> to verify how swiftly we can convert string into an actual QObject.
>>>
>>> [...]
>>>
>> I tried with qobject_from_json type of utility functions and the error I 
>> got was this :
>>
>> migration-test: /rpmbuild/SOURCES/qemu/include/qapi/qmp/qobject.h:126: 
>> qobject_type: Assertion `QTYPE_NONE < obj->base.type && obj->base.type < 
>> QTYPE__MAX' failed.
>>
>> And I suppose this was the case because, there are only limited types of 
>> QTYPE available
>>
>> typedefenumQType{
>> QTYPE_NONE,
>> QTYPE_QNULL,
>> QTYPE_QNUM,
>> QTYPE_QSTRING,
>> QTYPE_QDICT,
>> QTYPE_QLIST,
>> QTYPE_QBOOL,
>> QTYPE__MAX,
>> } QType;
>>
>> And 'channels' is a mixture of QDICT and QLIST and hence it is not able 
>> to easily convert from string to json.
>>
>> Thoughts on this ?
>
> I'm not sure what you tried. This works:
>
>     g_assert(!qdict_haskey(args, "channels"));
>     if (channels) {
>         channels_obj = qobject_from_json(channels, errp);
>         qdict_put_obj(args, "channels", channels_obj);
>     }
>
> And in the test:
>
>         .connect_channels = "[ { 'channel-type': 'main',"
>                             "    'addr': { 'transport': 'socket',"
>                             "              'type': 'inet',"
>                             "              'host': '127.0.0.1',"
>                             "              'port': '0' } } ]",
>         .listen_uri = "tcp:127.0.0.1:0",
>         .result = MIG_TEST_QMP_ERROR
>
> However, the real issue is how to inject the port for the source
> migration. The example above only works for the tests that are expected
> to fail. For a test that should pass, 0 as a port does not work.
>
> I'm thinking it might be better to alter migrate_qmp like this:
>
>   void migrate_qmp(QTestState *from, QTestState *to, const char *channels,
>                    const char *fmt, ...)
>
> Invocations would be:
>
>   migrate_qmp(from, to, NULL, "{uri: %s}", connect_uri);
>   migrate_qmp(from, to, args->channels, "{}");
>
> In this last case, if the test provided a port, we use it, otherwise we
> resolve it from the 'to' instance and put it in the QDict directly.
>
> I'll play with this a bit more tomorrow, let me know what you think.

Ok, so here's what I think we should do:

1) Add the 'to' object into migrate_qmp(), so we can use
migrate_get_socket_address() to get the port. Leave the other
migrate_qmp* alone because they don't need the port;

2) Move the calls to migrate_get_socket_address() into migrate_qmp() and
get rid of that connect_uri, use args->connect_uri instead everywhere;

3) Add a new function SocketAddress_to_qdict() that does the same as
SocketAddress_to_str(), but fills in a QDict instead;

4) Add args->connect_channels and pass it to migrate_qmp() and
migrate_qmp_fail(). Convert the string to a dict;

    if (channels) {
        channels_obj = qobject_from_json(channels, &error_abort);
        qdict_put_obj(args, "channels", channels_obj);
    }

5) Add a migrate_set_ports() function that uses 3) and fills in the port
in case it was 0 in the test. Handle a list of channels so we can add a
negative test that passes two channels;

  addr = migrate_get_socket_address(to);
  for each channel:
      if channel["port"] && channel["port"] == "0":
          channel["port"] = SocketAddress_to_qdict(addr->value)["port"]

(optionally iterate over addr to be prepared for when we add more
channels)

6) Alter migrate_qmp_fail() to allow both uri and channels
independently. No dealing with migrate_get_socket_address() because we
will fail before starting the migration anyway;

    if (uri) {
        qdict_put_str(args, "uri", uri);
    }

    if (channels) {
        channels_obj = qobject_from_json(channels, &error_abort);
        qdict_put_obj(args, "channels", channels_obj);
    }

7) Alter migrate_qmp() to only fill the uri if there are no
channels. Here we don't want to allow the wrong cases of having both or
none;

    if (uri) {
        qdict_put_str(args, "uri", uri);
    } else if (!channels) {
        qdict_put_str(args, "uri", migrate_get_socket_address(to));
    }

    if (channels) {
        channels_obj = qobject_from_json(channels, &error_abort);
        migrate_set_ports(to, qobject_to(QList, channels_obj));            
        qdict_put_obj(args, "channels", channels_obj);
    }

8) Write the tests to pass the list of channels;

    .connect_channels = "[ { 'channel-type': 'main',"
                        "    'addr': { 'transport': 'socket',"
                        "              'type': 'inet',"
                        "              'host': '127.0.0.1',"
                        "              'port': '0' } } ]",

With this we can test multiple channels, test other types of channel,
add more channel types in the future, etc and not need to change the
test infra.

