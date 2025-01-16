Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BBB1C02183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 20:03:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYW50-0007on-6c; Thu, 16 Jan 2025 15:03:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYW4x-0007oL-6r
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 15:02:59 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tYW4v-00075o-G2
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 15:02:58 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6EF7621182;
 Thu, 16 Jan 2025 20:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737057773; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHMZqfH0squsviWtBQBf0W4bd9qcaUEbbyz4djp73IE=;
 b=Gnh5YATwcLYhR1rQSLbRDb+slwS6DepW9ho2xd58hNXLBCcirWjRnAuKnWfU1c21mceESG
 O4Xtho30T3Gp1DGWtz80lRBBhJP0uNzan95U0Xg05z556U5F0olwbXbLZ+1WzQa7PzNoVw
 ruV9xjR8b2ziOseHAqiDcU4mSAoDQ7g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737057773;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHMZqfH0squsviWtBQBf0W4bd9qcaUEbbyz4djp73IE=;
 b=9/Si494dhsxKzIQsTw/w2fF/EJx9vhhng9pTwKR4oeExyjjgcDF9ViF7nKNwRu0zj7VDmr
 8xUIrMQXPKNzJ+CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1737057772; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHMZqfH0squsviWtBQBf0W4bd9qcaUEbbyz4djp73IE=;
 b=Pgdd85+jEWKotTs+zS/05umzjejh49GgL7D29sgQ+biBs8j+lWySsH2SnTjYNNjd4QWSFo
 qlEu0onb4OzOHldrJj82rCNBXe75+YKbw6K7vg7umOXGsBcxmc9d/cooUgcTNZquDfCRtU
 +EBa+PgyaOjkXDYDUXH2Gu7/WOuwBwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1737057772;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHMZqfH0squsviWtBQBf0W4bd9qcaUEbbyz4djp73IE=;
 b=f3Sy9HYw6mIjYqG8Y6TB+bLCnwiW9bWdBo8mizNBGZI7GQMmR+NSdYf3zsCxjnLQw0zX1y
 yn+jPVlrdgRhXIBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D066B13332;
 Thu, 16 Jan 2025 20:02:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +joaI+tliWdTegAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 16 Jan 2025 20:02:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steven Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V7 23/24] migration-test: cpr-transfer
In-Reply-To: <fe25b4b6-fd39-4c2a-a104-343b59b405b6@oracle.com>
References: <1736967650-129648-1-git-send-email-steven.sistare@oracle.com>
 <1736967650-129648-24-git-send-email-steven.sistare@oracle.com>
 <8734hifujq.fsf@suse.de> <fe25b4b6-fd39-4c2a-a104-343b59b405b6@oracle.com>
Date: Thu, 16 Jan 2025 17:02:49 -0300
Message-ID: <87zfjqedcm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TAGGED_RCPT(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 1/16/2025 2:06 PM, Fabiano Rosas wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
> [...]
>>> +    /*
>>> +     * The cpr channel must be included in outgoing channels, but not in
>>> +     * migrate-incoming channels.
>>> +     */
>>>       if (args->connect_channels) {
>>> +        in_channels = qobject_from_json(args->connect_channels, &error_abort);
>>>           out_channels = qobject_from_json(args->connect_channels, &error_abort);
>>> +
>>> +        if (args->cpr_channel) {
>>> +            QList *channels_list = qobject_to(QList, out_channels);
>>> +            QObject *obj = migrate_str_to_channel(args->cpr_channel);
>>> +
>>> +            qlist_append(channels_list, obj);
>>> +        }
>>>       }
>>>   
>>>       if (args->result == MIG_TEST_QMP_ERROR) {
>>> @@ -735,6 +751,9 @@ void test_precopy_common(MigrateCommon *args)
>>>       if (args->start.defer_target_connect) {
>>>           qtest_connect(to);
>>>           qtest_qmp_handshake(to);
>>> +        if (!strcmp(args->listen_uri, "defer")) {
>>> +            migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
>>> +        }
>> 
>> Paths that don't call migrate_incoming_qmp() never free
>> in_channels. We'll need something like this, let me know if I can squash
>> it in or you want to do it differently:
>> 
>> -- >8 --
>>  From 62d60c39b3e5d38cac20241e63b9d023bd296d2f Mon Sep 17 00:00:00 2001
>> From: Fabiano Rosas <farosas@suse.de>
>> Date: Thu, 16 Jan 2025 15:40:22 -0300
>> Subject: [PATCH] fixup! migration-test: cpr-transfer
>> 
>> ---
>>   tests/qtest/migration/framework.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>> 
>> diff --git a/tests/qtest/migration/framework.c b/tests/qtest/migration/framework.c
>> index 699bedae69..1d5918d922 100644
>> --- a/tests/qtest/migration/framework.c
>> +++ b/tests/qtest/migration/framework.c
>> @@ -753,9 +753,14 @@ void test_precopy_common(MigrateCommon *args)
>>           qtest_qmp_handshake(to);
>>           if (!strcmp(args->listen_uri, "defer")) {
>>               migrate_incoming_qmp(to, args->connect_uri, in_channels, "{}");
>> +            in_channels = NULL;
>>           }
>>       }
>>   
>> +    if (in_channels) {
>> +        qobject_unref(in_channels);
>> +    }
>> +
>>       if (args->result != MIG_TEST_SUCCEED) {
>>           bool allow_active = args->result == MIG_TEST_FAIL;
>>           wait_for_migration_fail(from, allow_active);
>
> Thank-you, though it would be more direct to avoid creating in_channels when
> not needed:
>
>      if (args->connect_channels) {
>          if (args->start.defer_target_connect) {
>              in_channels = qobject_from_json(args->connect_channels,
>                                              &error_abort);
>          }
>          out_channels = qobject_from_json(args->connect_channels, &error_abort);

That's better, but still needs one unref for the listen_uri != defer path.

>
> - Steve

