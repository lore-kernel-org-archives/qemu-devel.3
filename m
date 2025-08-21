Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181C8CA0EEB
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Aug 2025 17:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1up8xs-0007ZR-7n; Thu, 21 Aug 2025 13:20:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1up8xp-0007Ym-NT
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 13:20:38 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1up8xm-0001Ga-6k
 for qemu-devel@nongnu.org; Thu, 21 Aug 2025 13:20:36 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B52A6211F4;
 Thu, 21 Aug 2025 17:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755796831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYy25271PRr19uuE7/womDHn3Kzo+174tzrfPiwp/3M=;
 b=bGCXgzRvqt4Y8j3eaN0pjqeaZpltE35SjuJAaOwJtZSo/czfVFI/viaK1FoK0Nl7zhCu37
 z1sFTOzdRpVWxXN12uNpZ9VknEw4OAHvq1XTy3vfGmPCNIMo3b0KQyNQ73bSRVCLad25I5
 /5As1MXWTmSN+jM8MpSHPQJou9vVpKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755796831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYy25271PRr19uuE7/womDHn3Kzo+174tzrfPiwp/3M=;
 b=lEwF98D//+9dexo7//s2ArSqWgJv648c9hVmzVN9OtIBMt4sM/yfi7ocoCir2FZFkX5j9h
 yg7AIWFehzZ73SAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=VOmwqS2f;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=BL5SFfyo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1755796830; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYy25271PRr19uuE7/womDHn3Kzo+174tzrfPiwp/3M=;
 b=VOmwqS2fUyjkUaxLrQ9hF7OA8YkDvVpw/kJEhXneHbCbnNM9Gxc1gWH0YpaRZaR3KBEDdu
 JrNJZSbL9jBsufgOZWqSL+H+QaiQaxxl1Sj4ElfY2g8po1Eel62+N0Laz86Pnksj/Jftqb
 SjcrvkegW0uHAckDavrSnaZV0X+09TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1755796830;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vYy25271PRr19uuE7/womDHn3Kzo+174tzrfPiwp/3M=;
 b=BL5SFfyozvODyr8HDzH7nFebjhXanJ69sR3BDKHD6UJezUXjD/u+zsmKTe8qRQOZIItOgD
 F1JQFwnQAcgYiECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 341F6139A8;
 Thu, 21 Aug 2025 17:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VP2ZOV1Vp2g5MgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 21 Aug 2025 17:20:29 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 21/24] tests/qtest/migration: Take reference when
 passing %p to qtest_qmp
In-Reply-To: <aJ0QHowWNp90OnzO@x1.local>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-22-farosas@suse.de> <aJ0QHowWNp90OnzO@x1.local>
Date: Thu, 21 Aug 2025 14:20:27 -0300
Message-ID: <87a53sd21w.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: B52A6211F4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Jun 30, 2025 at 04:59:10PM -0300, Fabiano Rosas wrote:
>> The documentation of qobject_from_jsonv() states that it takes
>> ownership of any %p arguments passed in.
>> 
>> Next patches will add config-passing to the tests, so take an extra
>> reference in the migrate_qmp* functions to ensure the config is not
>> freed from under us.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>  tests/qtest/migration/migration-qmp.c | 8 +++++---
>>  1 file changed, 5 insertions(+), 3 deletions(-)
>> 
>> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
>> index fb59741b2c..d82ac8c750 100644
>> --- a/tests/qtest/migration/migration-qmp.c
>> +++ b/tests/qtest/migration/migration-qmp.c
>> @@ -97,7 +97,8 @@ void migrate_qmp_fail(QTestState *who, const char *uri,
>>      }
>>  
>>      err = qtest_qmp_assert_failure_ref(
>> -        who, "{ 'execute': 'migrate', 'arguments': %p}", args);
>> +        who, "{ 'execute': 'migrate', 'arguments': %p}",
>> +        qdict_clone_shallow(args));
>>  
>>      g_assert(qdict_haskey(err, "desc"));
>>  
>> @@ -136,7 +137,8 @@ void migrate_qmp(QTestState *who, QTestState *to, const char *uri,
>>      }
>>  
>>      qtest_qmp_assert_success(who,
>> -                             "{ 'execute': 'migrate', 'arguments': %p}", args);
>> +                             "{ 'execute': 'migrate', 'arguments': %p}",
>> +                             qdict_clone_shallow(args));
>>  }
>>  
>>  void migrate_set_capability(QTestState *who, const char *capability,
>> @@ -174,7 +176,7 @@ void migrate_incoming_qmp(QTestState *to, const char *uri, QObject *channels,
>>      migrate_set_capability(to, "events", true);
>>  
>>      rsp = qtest_qmp(to, "{ 'execute': 'migrate-incoming', 'arguments': %p}",
>> -                    args);
>> +                    qdict_clone_shallow(args));
>
> Isn't it intentional to pass over the ownership in the three places here?
> I don't see otherwise where args got freed.
>

Hmm, I think I remember the issue being that qobject_from_jsonv() freed
before the object it reached QMP, so indeed this needs to be freed
before the migrate_qmp functions return.

I don't really understand why ASAN didn't spot it though. I'll fix, thanks!

> OTOH, I saw there're yet another three similar usages of %p in framework.c:
>
> x1:migration [migration-params-caps-no-config]$ git grep -A1 %p framework.c
> framework.c:        migrate_qmp_fail(from, args->connect_uri, NULL, "{ 'config': %p }",
> framework.c-                         args->start.config);
> --
> framework.c:    migrate_qmp(from, to, args->connect_uri, NULL, "{ 'config': %p }",
> framework.c-                args->start.config);
> --
> framework.c:    migrate_incoming_qmp(to, args->connect_uri, NULL, "{ 'config': %p }",
> framework.c-                         args->start.config);
>
> They seem to be suspecious instead, as they seem to have lost ownership of
> args->start.config, so args->start.config can start to point to garbage?
>



>>  
>>      if (!qdict_haskey(rsp, "return")) {
>>          g_autoptr(GString) s = qobject_to_json_pretty(QOBJECT(rsp), true);
>> -- 
>> 2.35.3
>> 

