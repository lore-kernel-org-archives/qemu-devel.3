Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB50C5475B
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 01:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfV3j-00022V-BQ; Wed, 28 Feb 2024 20:18:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfV3h-00022D-Bw
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 20:18:01 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rfV3d-0006uw-Jp
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 20:18:00 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C6EAE1F7D9;
 Thu, 29 Feb 2024 01:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709169475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6qJQHd3uNlu1YYA5MnKm1WozaDUBai4D4+wdBBZfjKY=;
 b=zFtYJOn1CDvy4LzRMd2zfzfMayW/UhbIJ0pJQAa6nv4VjfH/CJEL6cHr5z1wp30j5iFaKh
 r394Cm3qEzkiwR41PnpR+AxD2MjiJ+zJ+UdWWpzIMSFaJTdTvUoL6ZSNFxczafiNIEhedD
 M1ZeuvULM9tAPJG6DHWVAt5y+7jgyXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709169475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6qJQHd3uNlu1YYA5MnKm1WozaDUBai4D4+wdBBZfjKY=;
 b=22VI0eQaGmxennYPyfenH/LQR+NV8C/wTgiu3BEobr93Jva4tLk9BrEIbCKaZKdHnq/fo8
 uXlrHQ0CsBw9ExDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709169474; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6qJQHd3uNlu1YYA5MnKm1WozaDUBai4D4+wdBBZfjKY=;
 b=a+2EfmqnSLL9rwCCF/FMH19Fa/apBshjg+08VkbJcopmap+TIgRrfb7sahnzhc1jR8czTW
 1fW3YZ7LurnPXeVyWjuGudmdIIrvAz7YovwvX2fmMxnow7HCQBbBMBq+8pOArg1dIWm550
 U1R1m5l2V23jnWG6PCH95+SLv3KJ0Uw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709169474;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6qJQHd3uNlu1YYA5MnKm1WozaDUBai4D4+wdBBZfjKY=;
 b=vp6rRf+9kqUy9v7UPyjoE9G0DX8wmPxsZYFysHYiWHoLsomgYv3JNx+/PhUPyBXV9WxMdF
 m0BGK6Z33HXxP0DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 487D41364F;
 Thu, 29 Feb 2024 01:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RgAcBELb32WLfAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 29 Feb 2024 01:17:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
In-Reply-To: <894b5da4-0af1-4ca0-b8a7-da288bb20774@nutanix.com>
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com> <87zfvr7xdn.fsf@suse.de>
 <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com>
 <87bk83bcqj.fsf@suse.de>
 <32687fa3-78dc-457b-ae50-854d2c72c922@nutanix.com>
 <894b5da4-0af1-4ca0-b8a7-da288bb20774@nutanix.com>
Date: Wed, 28 Feb 2024 22:17:51 -0300
Message-ID: <87o7c0rruo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a+2Efmqn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vp6rRf+9
X-Spamd-Result: default: False [-5.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain];
 DWL_DNSWL_MED(-2.00)[suse.de:dkim]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C6EAE1F7D9
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Het Gala <het.gala@nutanix.com> writes:

> On 27/02/24 1:04 am, Het Gala wrote:
>>
>>
>> On 26/02/24 6:31 pm, Fabiano Rosas wrote:
>>> Het Gala<het.gala@nutanix.com>  writes:
>>>
>>>> On 24/02/24 1:42 am, Fabiano Rosas wrote:
>>>> this was the same first approach that I attempted. It won't work because
>>>>
>>>> The final 'migrate' QAPI with channels string would look like
>>>>
>>>> { "execute": "migrate", "arguments": { "channels": "[ { "channel-type":
>>>> "main", "addr": { "transport": "socket", "type": "inet", "host":
>>>> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ]" } }
>>>>
>>>> instead of
>>>>
>>>> { "execute": "migrate", "arguments": { "channels": [ { "channel-type":
>>>> "main", "addr": { "transport": "socket", "type": "inet", "host":
>>>> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ] } }
>>>>
>>>> It would complain, that channels should be an *array* and not a string.
>>>>
>>>> So, that's the reason parsing was required in qtest too.
>>>>
>>>> I would be glad to hear if there are any ideas to convert /string ->
>>>> json object -> add it inside qdict along with uri/ ?
>>>>
>>> Isn't this what the various qobject_from_json do? How does it work with
>>> the existing tests?
>>>
>>>      qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
>>>                               "  'arguments': { "
>>>                               "      'channels': [ { 'channel-type': 'main',"
>>>                               "      'addr': { 'transport': 'socket',"
>>>                               "                'type': 'inet',"
>>>                               "                'host': '127.0.0.1',"
>>>                               "                'port': '0' } } ] } }");
>>>
>>> We can pass this^ string successfully to QMP somehow...
>>
>> I think, here in qtest_qmp_assert_success, we actually can pass the 
>> whole QMP command, and it just asserts that return key is present in 
>> the response, though I am not very much familiar with qtest codebase 
>> to verify how swiftly we can convert string into an actual QObject.
>>
>> [...]
>>
> I tried with qobject_from_json type of utility functions and the error I 
> got was this :
>
> migration-test: /rpmbuild/SOURCES/qemu/include/qapi/qmp/qobject.h:126: 
> qobject_type: Assertion `QTYPE_NONE < obj->base.type && obj->base.type < 
> QTYPE__MAX' failed.
>
> And I suppose this was the case because, there are only limited types of 
> QTYPE available
>
> typedefenumQType{
> QTYPE_NONE,
> QTYPE_QNULL,
> QTYPE_QNUM,
> QTYPE_QSTRING,
> QTYPE_QDICT,
> QTYPE_QLIST,
> QTYPE_QBOOL,
> QTYPE__MAX,
> } QType;
>
> And 'channels' is a mixture of QDICT and QLIST and hence it is not able 
> to easily convert from string to json.
>
> Thoughts on this ?

I'm not sure what you tried. This works:

    g_assert(!qdict_haskey(args, "channels"));
    if (channels) {
        channels_obj = qobject_from_json(channels, errp);
        qdict_put_obj(args, "channels", channels_obj);
    }

And in the test:

        .connect_channels = "[ { 'channel-type': 'main',"
                            "    'addr': { 'transport': 'socket',"
                            "              'type': 'inet',"
                            "              'host': '127.0.0.1',"
                            "              'port': '0' } } ]",
        .listen_uri = "tcp:127.0.0.1:0",
        .result = MIG_TEST_QMP_ERROR

However, the real issue is how to inject the port for the source
migration. The example above only works for the tests that are expected
to fail. For a test that should pass, 0 as a port does not work.

I'm thinking it might be better to alter migrate_qmp like this:

  void migrate_qmp(QTestState *from, QTestState *to, const char *channels,
                   const char *fmt, ...)

Invocations would be:

  migrate_qmp(from, to, NULL, "{uri: %s}", connect_uri);
  migrate_qmp(from, to, args->channels, "{}");

In this last case, if the test provided a port, we use it, otherwise we
resolve it from the 'to' instance and put it in the QDict directly.

I'll play with this a bit more tomorrow, let me know what you think.

