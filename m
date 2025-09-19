Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84BEFCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 17:14:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzefk-0001E8-Eg; Fri, 19 Sep 2025 13:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzefj-0001DT-6R
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:13:23 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uzefb-0000gb-Vt
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 13:13:22 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A8FC23368C;
 Fri, 19 Sep 2025 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758301988; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HIUUnSgAHvzol6DzbY+PAeVfxImF2ZHEhdQq6INCa0k=;
 b=TzESEctq8hcFqM+WJoO0fbKvV31O/Q1SDH5lJ9+7KQ1Wq3zifdMh5ZOfAHeW1zuZ4YfBAx
 9J5cSigh1mhzh6aMq4qbhqzhTA39zrd/ASr6/SY8YkJaOrnIAs9T+XXrP0w13tj2GUtgHk
 c8/JShQysJ89tbbk9m6ddc2mUfdOqFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758301988;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HIUUnSgAHvzol6DzbY+PAeVfxImF2ZHEhdQq6INCa0k=;
 b=el86pNcBOwa03eyZyrowRK0n4hEky/Es2T1n6A5XO+YIxv0qX3/GenV+S21EJhAo3KHo6R
 0II9qp/lfm5nU6DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=JNhuoSQl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rdXJBpTc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758301987; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HIUUnSgAHvzol6DzbY+PAeVfxImF2ZHEhdQq6INCa0k=;
 b=JNhuoSQlZBD8BT9oQWnblnIIWjsdYZOzNC8HBdoWVjye+Mm0It3N7e5BlPAqeqy+nHu9AR
 YfejSN5gFTnejZyte81aMLGHLIVVA70kqBm+T90orlEuokbpw2QhRlGFNJ4zQYLyVpi33J
 +6vLZLSV1j+C1AiY+Dx/YxX6FAE47Nw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758301987;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HIUUnSgAHvzol6DzbY+PAeVfxImF2ZHEhdQq6INCa0k=;
 b=rdXJBpTcRVFdFWNo8NBrBPGr4DXyx6ChjRkhXrU0ak8Jv7rqmX2FrD34pUHKPDq9Y5je/Q
 JsyBb3CiZPcX3eDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CE3E13A78;
 Fri, 19 Sep 2025 17:13:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /J62MyKPzWjrXgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Sep 2025 17:13:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, mst@redhat.com
Cc: qemu-devel@nongnu.org, philmd@linaro.org, thuth@redhat.com,
 eblake@redhat.com, michael.roth@amd.com, armbru@redhat.com,
 peterx@redhat.com, berrange@redhat.com, jasowang@redhat.com,
 steven.sistare@oracle.com, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru
Subject: Re: [PATCH v5 16/19] qapi: add interface for local TAP migration
In-Reply-To: <82642da2-eff7-4eb6-b007-fd239fa0ef64@yandex-team.ru>
References: <20250919095545.1912042-1-vsementsov@yandex-team.ru>
 <20250919095545.1912042-17-vsementsov@yandex-team.ru>
 <87y0qatqoa.fsf@suse.de>
 <82642da2-eff7-4eb6-b007-fd239fa0ef64@yandex-team.ru>
Date: Fri, 19 Sep 2025 14:13:04 -0300
Message-ID: <87ms6qtlgf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[15];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, yandex-team.ru:email, suse.de:mid, suse.de:dkim]
X-Rspamd-Queue-Id: A8FC23368C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> On 19.09.25 18:20, Fabiano Rosas wrote:
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
>> 
>> Hi Vladimir, as usual with "qapi:" patches, some comments about
>> language:
>> 
>>> To migrate virtio-net TAP device backend (including open fds) locally,
>>> user should simply set migration parameter
>>>
>>>     fds = [virtio-net]
>>>
>>> Why not simple boolean? To simplify migration to further versions,
>>> when more devices will support fds migration.
>>>
>>> Alternatively, we may add per-device option to disable fds-migration,
>>> but still:
>>>
>>> 1. It's more comfortable to set same capabilities/parameters on both
>>> source and target QEMU, than care about each device.
>>>
>>> 2. To not break the design, that machine-type + device options +
>>> migration capabilites and parameters are fully define the resulting
>>> migration stream. We'll break this if add in future more fds-passing
>>> support in devices under same fds=true parameter.
>>>
>> 
>> These arguments look convincing to me.
>> 
>
> [..]
>
>>>       return true;
>>>   }
>>>   
>>> @@ -1297,6 +1315,11 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
>>>       if (params->has_direct_io) {
>>>           dest->direct_io = params->direct_io;
>>>       }
>>> +
>>> +    if (params->has_fds) {
>>> +        dest->has_fds = true;
>> 
>> I think what you want is to set this in
>> migrate_params_init(). block_bitmap_mapping is a bit of an outlier in
>> that it takes an empty *input* as valid.
>
> Hmm I made it behave like block_bitmap_mapping because it also a list.
>
> As I understand, for list we have to treat empty list not like absent parameter: we should have a way
> to clear previously set list by subsequent migrate-set-parameters call.
>

Sorry, I explained myself poorly. Yes, the empty list is valid and it
clears a previously set value. But that's just:

migrate_params_init(MigrationParameters *params):
    ...
    params->has_fds = true;

migrate_params_test_apply(MigrateSetParameters *params,
                          MigrationParameters *dest):
    ...
    /* means user provided it */                          
    if (params->has_fds) {
        dest->fds = params->fds;
    }

migrate_params_check(MigrationParameters *params):
    ...
    if (params->has_fds) {
       /* empty list ok */
    }

migrate_params_apply(MigrateSetParameters *params):
    ...
    if (params->has_fds) {
        qapi_free_...(s->parameters.fds);
        /* clones the full list or the empty list, no difference */
        s->parameters.fds = QAPI_CLONE(..., params->fds);
    }

The block_bitmap_mapping does the has_ part a bit differently because it
wants to carry that flag over to the rest of the code. See 3cba22c9ad
("migration: Fix block_bitmap_mapping migration"). In that case, even if
the list is empty, it needs to know when it was made empty on purpose to
carry on with the removal of the mappings. In your case, it doesn't
matter, empty is empty, whether forcefully, or because it was never
set. Right?

(this migrate_params code is tricky, FYI I'm reworking that in:
https://lore.kernel.org/r/20250603013810.4772-1-farosas@suse.de)

>> 
>>> +        dest->fds = params->fds;
>>> +    }
>>>   }
>>>   
>>>   static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>>> @@ -1429,6 +1452,13 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
>>>       if (params->has_direct_io) {
>>>           s->parameters.direct_io = params->direct_io;
>>>       }
>>> +
>>> +    if (params->has_fds) {
>>> +        qapi_free_FdsTargetList(s->parameters.fds);
>>> +
>>> +        s->parameters.has_fds = true;
>>> +        s->parameters.fds = QAPI_CLONE(FdsTargetList, params->fds);
>> 
>> Same here, has_fds should always be true in s->parameters.
>> 
>>> +    }
>>>   }
>>>   
>>>   void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
>>> diff --git a/migration/options.h b/migration/options.h
>>> index 82d839709e..a79472a235 100644
>>> --- a/migration/options.h
>>> +++ b/migration/options.h
>>> @@ -87,6 +87,8 @@ const char *migrate_tls_hostname(void);
>>>   uint64_t migrate_xbzrle_cache_size(void);
>>>   ZeroPageDetection migrate_zero_page_detection(void);
>>>   
>>> +bool migrate_fds_virtio_net(void);
>>> +
>>>   /* parameters helpers */
>>>   
>>>   bool migrate_params_check(MigrationParameters *params, Error **errp);
>>> diff --git a/qapi/migration.json b/qapi/migration.json
>>> index 2387c21e9c..6ef9629c6d 100644
>>> --- a/qapi/migration.json
>>> +++ b/qapi/migration.json
>>> @@ -747,6 +747,19 @@
>>>         '*transform': 'BitmapMigrationBitmapAliasTransform'
>>>     } }
>>>   
>>> +##
>>> +# @FdsTarget:
>>> +#
>>> +# @virtio-net: Enable live backend migration for virtio-net.
>> 
>> So you're assuming normal migration is "non-live backend migration"
>> because the backend is stopped and started again on the destination. I
>> think it makes sense.
>> 
>>> +#     The only supported backend is TAP device. When enabled, TAP fds
>>> +#     and all related state is passed to target QEMU through migration
>>> +#     channel (which should be unix socket).
>>> +#
>>> +# Since: 10.2
>>> +##
>>> +{ 'enum': 'FdsTarget',
>>> +  'data': [ 'virtio-net' ] }
>>> +
>>>   ##
>>>   # @BitmapMigrationNodeAlias:
>>>   #
>>> @@ -924,10 +937,14 @@
>>>   #     only has effect if the @mapped-ram capability is enabled.
>>>   #     (Since 9.1)
>>>   #
>>> +# @fds: List of targets to enable live-backend migration for. This
>>> +#     requires migration channel to be a unix socket (to pass fds
>>> +#     through). (Since 10.2)
>> 
>> I think I prefer live-backend as written here rather than the non
>> hyphenated version above. This clears up the ambiguity and can be used
>> in variable names, as a name for the feature and ... _thinks really
>> hard_ ... as the parameter name! (maybe)
>> 
>> On that note, fds is just too broad, I'm sure you know that, but to be
>> specific, we already have fd migration, multifd, fdset (as argument of
>> file: migration), etc. Talking just about the user interface here, of
>> course.
>> 
>> Also: "@fds: List of targets..." is super confusing.
>> 
>> And although "to pass fds through" is helping clarify the meaning of
>> @fds, it exposes implementation details on the QAPI, I don't think it's
>> relevant in the parameter description.
>
> Agree. I see all this mess, each time I come with some new name:
> live-tap, live-backend, fds-passing, fds migration, local tap migration, fds...
> Finally, only one should be chosen for all names and in documentation.
>

Yeah, not to mention the similarities with CPR. I thought of borrowing
the "transfer" term to underline that's a common concept between the two
approaches, but I'm not sure it's worth the trouble.

[live-]backend-transfer

> With your comments, "live-backend" really looks the best one.
>
> Still, we can't say live-backends: [virtio-net], as virtio-net is not
> a backed.
>
> Maybe
>     
>     live-backends: [virtio-net-tap]
>
> to show that it's about virtio-net+TAP pair.
>

Works for me.

>> 
>>> +#
>>>   # Features:
>>>   #
>>> -# @unstable: Members @x-checkpoint-delay and
>>> -#     @x-vcpu-dirty-limit-period are experimental.
>
>
> Thanks!

