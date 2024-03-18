Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5E4C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 14:17:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmDn0-0007Ru-7S; Mon, 18 Mar 2024 10:16:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmDmr-0007QC-VF
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:16:30 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmDmm-0007lF-Jc
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 10:16:23 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 82BFB5C5EA;
 Mon, 18 Mar 2024 14:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710771377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBGAO0DBMcjFbhDCyiGsKZPdnS8c2wL9ynmKGk7JUbk=;
 b=Wrd2slXcQE9uZlK2MDWXKY6OdJHpT3R9dV9F5SbVHaOWe1tSRaaMgjSsQZ8C+Yzu6vQptw
 iKS6qHKi0bbDpEGYFX0/fEjaLQCXN6jfmJHiehRtb1neZClxzIOYHJvq/rq1NrYIXZy1n7
 mUIaMQW4xtum2TZJrXVqqVOeAOb+KAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710771377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBGAO0DBMcjFbhDCyiGsKZPdnS8c2wL9ynmKGk7JUbk=;
 b=50p26qRXohYslpnVjUEXx7DVyfYIexF+xFFTyiHmhEDQvIUQiJQ2W1+YZ0qrl1gv6p1xN/
 45+7vVFB2u+xKJAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710771377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBGAO0DBMcjFbhDCyiGsKZPdnS8c2wL9ynmKGk7JUbk=;
 b=Wrd2slXcQE9uZlK2MDWXKY6OdJHpT3R9dV9F5SbVHaOWe1tSRaaMgjSsQZ8C+Yzu6vQptw
 iKS6qHKi0bbDpEGYFX0/fEjaLQCXN6jfmJHiehRtb1neZClxzIOYHJvq/rq1NrYIXZy1n7
 mUIaMQW4xtum2TZJrXVqqVOeAOb+KAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710771377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CBGAO0DBMcjFbhDCyiGsKZPdnS8c2wL9ynmKGk7JUbk=;
 b=50p26qRXohYslpnVjUEXx7DVyfYIexF+xFFTyiHmhEDQvIUQiJQ2W1+YZ0qrl1gv6p1xN/
 45+7vVFB2u+xKJAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D7581349D;
 Mon, 18 Mar 2024 14:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TvuBMbBM+GULNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 18 Mar 2024 14:16:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v7 3/8] tests/qtest/migration: Replace
 migrate_get_connect_uri inplace of migrate_get_socket_address
In-Reply-To: <c25c8cf7-ea28-4c5f-962a-1fe5abc51870@nutanix.com>
References: <20240312202634.63349-1-het.gala@nutanix.com>
 <20240312202634.63349-4-het.gala@nutanix.com> <871q8b8xeg.fsf@suse.de>
 <c25c8cf7-ea28-4c5f-962a-1fe5abc51870@nutanix.com>
Date: Mon, 18 Mar 2024 11:16:14 -0300
Message-ID: <87bk7baamp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.29 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-0.99)[-0.994];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
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

> On 15/03/24 6:28 pm, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> Refactor migrate_get_socket_address to internally utilize 'socket-address'
>>> parameter, reducing redundancy in the function definition.
>>>
>>> migrate_get_socket_address implicitly converts SocketAddress into str.
>>> Move migrate_get_socket_address inside migrate_get_connect_uri which
>>> should return the uri string instead.
>>>
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>> Reviewed-by: Fabiano Rosas<farosas@suse.de>
>>> ---
>>>   tests/qtest/migration-helpers.c | 29 +++++++++++++++++++----------
>>>   1 file changed, 19 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>>> index 3e8c19c4de..8806dc841e 100644
>>> --- a/tests/qtest/migration-helpers.c
>>> +++ b/tests/qtest/migration-helpers.c
>>> @@ -48,28 +48,37 @@ static char *SocketAddress_to_str(SocketAddress *addr)
>>>       }
>>>   }
>>>   
>>> -static char *
>>> -migrate_get_socket_address(QTestState *who, const char *parameter)
>>> +static SocketAddress *migrate_get_socket_address(QTestState *who)
>>>   {
>>>       QDict *rsp;
>>> -    char *result;
>>>       SocketAddressList *addrs;
>>> +    SocketAddress *addr;
>>>       Visitor *iv = NULL;
>>>       QObject *object;
>>>   
>>>       rsp = migrate_query(who);
>>> -    object = qdict_get(rsp, parameter);
>>> +    object = qdict_get(rsp, "socket-address");
>> Just a heads up, none of what I'm about to say applies to current
>> master.
>>
>> This can return NULL if there is no socket-address, such as with a file
>> migration. Then the visitor code below just barfs. It would be nice if
>> we touched this up eventually.
>
> Yes. I agree this is not full proof solution and covers for all the cases.
> It would only for 'socket-address'. Could you elaborate on what other than
> socket-address the QObject can have ?

I can just not have the socket-address, AFAICS. We'd just need to not
crash if that's the case.

>
>> I only noticed this because I was fiddling with the file migration API
>> and this series helped me a lot to test my changes. So thanks for that,
>> Het.
>>
>> Another point is: we really need to encourage people to write tests
>> using the new channels API. I added the FileMigrationArgs with the
>> 'offset' as a required parameter, not even knowing optional parameters
>> were a thing. So it's obviously not enough to write support for the new
>> API if no tests ever touch it.
> Yes, definitely we need more tests with the new channels API to test other
> than just tcp connection. I could give a try for vsock and unix with the
> new QAPI syntax, and add some tests.
>
> I also wanted to bring in attention that, this solution I what i feel is 
> also
> not complete. If we are using new channel syntax for migrate_qmp, then the
> same syntax should also be used for migrate_qmp_incoming. But we haven't
> touch that, and it still prints the old syntax. We might need a lot changes
> in design maybe to incorporate that too in new tests totally with the new
> syntax.

Adding migrate_qmp_incoming support should be relatively simple. You had
patches for that in another version, no?

>
> Another thing that you also noted down while discussing on the patches that
> we should have a standard pattern on how to define the migration tests. Even
> that would be helpful for the users, on how to add new tests, where to add
> new tests in the file, and which test is needed to run if a specific change
> needs to be tested.
>
>>>   
>>>       iv = qobject_input_visitor_new(object);
>>>       visit_type_SocketAddressList(iv, NULL, &addrs, &error_abort);
>>> +    addr = addrs->value;
>>>       visit_free(iv);
>>>   
>>> -    /* we are only using a single address */
>>> -    result = SocketAddress_to_str(addrs->value);
>>> -
>>> -    qapi_free_SocketAddressList(addrs);
>>>       qobject_unref(rsp);
>>> -    return result;
>>> +    return addr;
>>> +}
>>> +
>>> +static char *
>>> +migrate_get_connect_uri(QTestState *who)
>>> +{
>>> +    SocketAddress *addrs;
>>> +    char *connect_uri;
>>> +
>>> +    addrs = migrate_get_socket_address(who);
>>> +    connect_uri = SocketAddress_to_str(addrs);
>>> +
>>> +    qapi_free_SocketAddress(addrs);
>>> +    return connect_uri;
>>>   }
>>>   
>>>   bool migrate_watch_for_events(QTestState *who, const char *name,
>>> @@ -129,7 +138,7 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>>   
>>>       g_assert(!qdict_haskey(args, "uri"));
>>>       if (!uri) {
>>> -        connect_uri = migrate_get_socket_address(to, "socket-address");
>>> +        connect_uri = migrate_get_connect_uri(to);
>>>       }
>>>       qdict_put_str(args, "uri", uri ? uri : connect_uri);
>
> Regards,
> Het Gala

