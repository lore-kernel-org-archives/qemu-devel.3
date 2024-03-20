Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B55C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 13:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmvrB-0003F6-6Y; Wed, 20 Mar 2024 09:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmvr9-0003Ex-U6
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:19:47 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rmvr8-0001IW-Ai
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 09:19:47 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 43D6D344CA;
 Wed, 20 Mar 2024 13:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710940783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y//0OfnLStZaQgSjOzFf0O8OvpL3fFR3XYHqpm21uiY=;
 b=QogwSOdd2x1qdPd9Pnzf/Q62G1lTvMlpdu6dyqHB+AYLv/Ilw2Yn5z3zyVCxawcaNje37e
 7JYfFArTUOUXPbq7wwwlEdSjQUekCrSzCkhD3oiZYCRH0MRCQ5MjX2VupeybePOpBD/st1
 foVUOEeL6AAP6eJXG8ImhoQU5fiz8ew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710940783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y//0OfnLStZaQgSjOzFf0O8OvpL3fFR3XYHqpm21uiY=;
 b=yiNl0Um0zaD/9xSbW4/dmcC/gpuvmeUs88dR7XD3mei8qzaQ6UT3pL9PqOi2r6M/tXX6vb
 p0cOptomLhZvnsCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710940781; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y//0OfnLStZaQgSjOzFf0O8OvpL3fFR3XYHqpm21uiY=;
 b=0GseZRTFEERM7AVrznoYdH3ZhOorqHUA61Isc6dMEOwq46DB3KhDVx2l/NMPvGsfULlfMn
 WcDHgU9Pf3dQBh2WdxmH1nJ+I9KYQ4M3RdZrR147KcMI2p6Clqx++CraSbgHYOmUE9dyOQ
 u0n9SK3UvIMg9y42Lae73TMrkmXNL1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710940781;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y//0OfnLStZaQgSjOzFf0O8OvpL3fFR3XYHqpm21uiY=;
 b=K0iArTtslSQx0jy5hjBEVgeRRLUEYFFVeyGt625ER+mFmiUZVF2OMkonhHEaVLxwLJUNCp
 qNaAHafymFLxwADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4CCD136CD;
 Wed, 20 Mar 2024 13:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AqH4Imzi+mXpJgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 20 Mar 2024 13:19:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, thuth@redhat.com,
 lvivier@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH 1/2] tests/qtest/migration: Ignore if socket-address is
 missing to avoid crash below
In-Reply-To: <56ed1452-87ed-4cfb-912f-b15bc74609c1@nutanix.com>
References: <20240319204840.211632-1-het.gala@nutanix.com>
 <ZfoKSgJ9LN1Q7R1V@x1n> <56ed1452-87ed-4cfb-912f-b15bc74609c1@nutanix.com>
Date: Wed, 20 Mar 2024 10:19:38 -0300
Message-ID: <87sf0lm45x.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0GseZRTF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=K0iArTts
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[nutanix.com:email,suse.de:dkim,suse.de:email]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: 43D6D344CA
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

Het Gala <het.gala@nutanix.com> writes:

> On 20/03/24 3:27 am, Peter Xu wrote:
>> On Tue, Mar 19, 2024 at 08:48:39PM +0000, Het Gala wrote:
>>> 'object' can return NULL if there is no socket-address, such as with a
>>> file migration. Then the visitor code below fails and the test crashes.
>>>
>>> Ignore and return NULL when socket-address is missing in the reply so
>>> we don't break future tests that use a non-socket type.
>> Hmm, this patch isn't as clear to me.  Even if this can return NULL now,
>> it'll soon crash at some later point, no?
> It won't crash IMO, the next function SocketAddress_to_str for a non-socket
> type would return an proper error ?
>> IMHO such patch is more suitable to be included in the same patch where
>> such new tests will be introduced, then we're addressing some real test
>> code changes that will work, rather than worrying on what will happen in
>> the future (and as I mentioned, i don't think it fully resolved that either..)
>>
>> Thanks,
> Maybe, Fabiano can pick this patch, and add along file migration qtests 
> patch ?

Yep.

>>> Suggested-by: Fabiano Rosas<farosas@suse.de>
>>> Signed-off-by: Het Gala<het.gala@nutanix.com>
>>> ---
>>>   tests/qtest/migration-helpers.c | 4 ++++
>>>   1 file changed, 4 insertions(+)
>>>
>>> diff --git a/tests/qtest/migration-helpers.c b/tests/qtest/migration-helpers.c
>>> index b2a90469fb..fb7156f09a 100644
>>> --- a/tests/qtest/migration-helpers.c
>>> +++ b/tests/qtest/migration-helpers.c
>>> @@ -90,6 +90,10 @@ static SocketAddress *migrate_get_socket_address(QTestState *who)
>>>       QObject *object;
>>>   
>>>       rsp = migrate_query(who);
>>> +
>>> +    if (!qdict_haskey(rsp, "socket-address")) {
>>> +        return NULL;
>>> +    }
>>>       object = qdict_get(rsp, "socket-address");
>>>   
>>>       iv = qobject_input_visitor_new(object);
>>> -- 
>>> 2.22.3
>>>
> Regards,
> Het Gala

