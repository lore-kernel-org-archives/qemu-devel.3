Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91B9CC54E4A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 16:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhtiR-0001e1-MU; Wed, 06 Mar 2024 11:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhtiO-0001dq-0T
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:01:56 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rhtiL-0002bP-Oz
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 11:01:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BDE414450;
 Wed,  6 Mar 2024 16:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709740907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aZS51YjvW5OUDBzYuz9gJ0kFIprccEPBnTm8veCxu9s=;
 b=CL+Gdtpk/do1rdvtn5bzd09I03ta7tIdkl2GC4lRJk8VMLGmRrlOzCs6ULRH4RiJwNNmI6
 FaOY20rf42iNqnQa4792tPNTgDkU1Zvas7ANeVh/JcrOveDhBCzVhUC6Lqu0xup/3jRLm4
 A5iTWr6IPY66Z1Scnd35AIRnbdkL+34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709740907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aZS51YjvW5OUDBzYuz9gJ0kFIprccEPBnTm8veCxu9s=;
 b=UZyk+I6PaQacDXL9vhQhjEXkZJGtmRoNl9m7zi/+e+eeuQqc9Zw19V73XEBwox/zUrl8I/
 hsiq9IKn+fyhs1AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709740907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aZS51YjvW5OUDBzYuz9gJ0kFIprccEPBnTm8veCxu9s=;
 b=CL+Gdtpk/do1rdvtn5bzd09I03ta7tIdkl2GC4lRJk8VMLGmRrlOzCs6ULRH4RiJwNNmI6
 FaOY20rf42iNqnQa4792tPNTgDkU1Zvas7ANeVh/JcrOveDhBCzVhUC6Lqu0xup/3jRLm4
 A5iTWr6IPY66Z1Scnd35AIRnbdkL+34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709740907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aZS51YjvW5OUDBzYuz9gJ0kFIprccEPBnTm8veCxu9s=;
 b=UZyk+I6PaQacDXL9vhQhjEXkZJGtmRoNl9m7zi/+e+eeuQqc9Zw19V73XEBwox/zUrl8I/
 hsiq9IKn+fyhs1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B53013A65;
 Wed,  6 Mar 2024 16:01:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1D8gAGuT6GWBYAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 06 Mar 2024 16:01:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v3 4/7] Add migrate_set_ports into migrate_qmp to change
 migration port number
In-Reply-To: <0238e330-cb9f-4d72-9ca8-ca7a1b51dddf@nutanix.com>
References: <20240306104958.39857-1-het.gala@nutanix.com>
 <20240306104958.39857-5-het.gala@nutanix.com> <87sf13s9yz.fsf@suse.de>
 <0238e330-cb9f-4d72-9ca8-ca7a1b51dddf@nutanix.com>
Date: Wed, 06 Mar 2024 13:01:44 -0300
Message-ID: <878r2vs61j.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CL+Gdtpk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UZyk+I6P
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: BDE414450
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

> On 06/03/24 8:06 pm, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> Add a migrate_set_ports() function that from each QDict, fills in
>>> the port in case it was 0 in the test.
>>> Handle a list of channels so we can add a negative test that
>>> passes more than one channel.
>>>
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>> ---
>>>   tests/qtest/migration-helpers.c | 26 ++++++++++++++++++++++++++
>>>   1 file changed, 26 insertions(+)
>>>
>>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>>> index 478c1f259b..df4978bf17 100644
>>> --- a/tests/qtest/migration-helpers.c
>>> +++ b/tests/qtest/migration-helpers.c
>>> @@ -17,6 +17,8 @@
>>>   #include "qapi/qapi-visit-sockets.h"
>>>   #include "qapi/qobject-input-visitor.h"
>>>   #include "qapi/error.h"
>>> +#include "qapi/qmp/qlist.h"
>>> +
>> Extra line here. This is unwanted because it sometimes trips git into
>> thinking there's a conflict here when another patch changes the
>> surrounding lines.
> Ack, that makes sense
>>>   
>>>   #include "migration-helpers.h"
>>>   
>>> @@ -73,6 +75,29 @@ migrate_get_socket_address(QTestState *who, const char *parameter)
>>>       return result;
>>>   }
>>>   
>>> +static void migrate_set_ports(QTestState *to, QList *channelList)
>>> +{
>>> +    g_autofree char *addr = NULL;
>>> +    g_autofree char *addr_port = NULL;
>>> +    QListEntry *entry;
>>> +
>>> +    addr = migrate_get_socket_address(to, "socket-address");
>>> +    addr_port = g_strsplit(addr, ":", 3)[2];
>> Will this always do the right thing when the src/dst use different types
>> of channels? If there is some kind of mismatch (say one side uses vsock
>> and the other inet), it's better that this function doesn't touch the
>> channels dict instead of putting garbage in the port field.
>
> Yes you are right. This will fail if there is a mismatch in type of 
> channels.
>
> Better idea would be to check if 'port' key is present in both, i.e. in 
> 'addr'
> as well as 'addrdict' and only then change the port ?
>

Yep, either parse the type from string or add a version of
migrate_get_socket_address that returns a dict. Then check if type
matches and port exists.

>> Also what happens if the dst is using unix: or fd:?
> yes in that case - how should the migration behaviour be ? src and dst 
> should be of the same type right

Remember this is test code. If the test was written incorrectly either
by developer mistake or on purpose to test some condition, then it's not
this function's reponsibility to fix that.

Replace the port only if the transport type allows for a port, there is
a port in both addr and addrdict and port is 0. Anything else, leave the
channelList untouched and let QEMU deal with the bad input.

>>> +
>>> +    QLIST_FOREACH_ENTRY(channelList, entry) {
>>> +        QDict *channel = qobject_to(QDict, qlist_entry_obj(entry));
>>> +        QObject *addr_obj = qdict_get(channel, "addr");
>>> +
>>> +        if (qobject_type(addr_obj) == QTYPE_QDICT) {
>>> +            QDict *addrdict = qobject_to(QDict, addr_obj);
>> You might not need these two lines if at the start you use:
>>
>> QDict *addr = qdict_get_dict(channel, "addr");
>
> If you are commenting regarding this two lines:
>
> +        if (qobject_type(addr_obj) == QTYPE_QDICT) {
> +            QDict *addrdict = qobject_to(QDict, addr_obj);
>
> then, I am not sure, because addrdict and addr is different right? Also addrdict can also
> be a QList, like in the case of exec migration, it can be a list instead of dict
> ex:
> # -> { "execute": "migrate",
> #      "arguments": {
> #          "channels": [ { "channel-type": "main",
> #                          "addr": { "transport": "exec",
> #                                    "args": [ "/bin/nc", "-p", "6000",
> #                                              "/some/sock" ] } } ] } }

"addr" is always a dict, no? Even in the example you just gave.

>
>>
>>> +            if (qdict_haskey(addrdict, "port") &&
>>> +            (strcmp(qdict_get_str(addrdict, "port"), "0") == 0)) {
>>> +                qdict_put_str(addrdict, "port", addr_port);
>>> +            }
>>> +        }
>>> +    }
>>> +}
>>> +
>>>   bool migrate_watch_for_events(QTestState *who, const char *name,
>>>                                 QDict *event, void *opaque)
>>>   {
>>> @@ -143,6 +168,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>>       if (!uri) {
>>>           connect_uri = migrate_get_socket_address(to, "socket-address");
>>>       }
>>> +    migrate_set_ports(to, NULL);
>> migrate_set_ports is not prepared to take NULL. This breaks the tests in
>> this commit. All individual commits should work, otherwise it will break
>> bisecting.
> Okay, so in that case, is it better to merge this with the next patch ? 
> because if I just
> define the migrate_set_ports function and not use it anywhere, it gives 
> a warning/error
> (depending upon what compiler is used)

You can return early at migrate_set_ports if channelList is NULL.

Also, I just noticed: s/channelList/channel_list/

>>>       qdict_put_str(args, "uri", uri ? uri : connect_uri);
>>>   
>>>       qtest_qmp_assert_success(who,
>
> Regards,
>
> Het Gala

