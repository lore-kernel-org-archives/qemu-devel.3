Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8BFC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reacQ-0007Jp-Pz; Mon, 26 Feb 2024 08:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1reacO-0007Hv-A5
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:02:04 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1reacM-0005So-6v
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:02:04 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54F3022514;
 Mon, 26 Feb 2024 13:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708952519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6m7Fd/UTfb75LGBYIxqas0FTZMYEzeGq9U2F2ucSRxw=;
 b=x2sM+hKUFCtZEt4Klfzx5TXoEMvwVzHZLh8/4lUk/paoysDoT1HC+YqR5Yxby4RANsmRVb
 7P6apUmoFsa5BCUDwr3Sei10cXNN5df33jdv/83PALqsPWyNGvWrP5miZ59CZ9LwoOd6om
 DP6zwxW1kaJYflYhSv9xtNw6P3GkNr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708952519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6m7Fd/UTfb75LGBYIxqas0FTZMYEzeGq9U2F2ucSRxw=;
 b=gt1xaaDRTC4rSgOtoVLw063tLhQd9Ex5r8MnNFxpvcuqI94meTzeMsDqB+BQVkUQGz8YNp
 MZzvlS+vjdn8g8CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1708952519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6m7Fd/UTfb75LGBYIxqas0FTZMYEzeGq9U2F2ucSRxw=;
 b=x2sM+hKUFCtZEt4Klfzx5TXoEMvwVzHZLh8/4lUk/paoysDoT1HC+YqR5Yxby4RANsmRVb
 7P6apUmoFsa5BCUDwr3Sei10cXNN5df33jdv/83PALqsPWyNGvWrP5miZ59CZ9LwoOd6om
 DP6zwxW1kaJYflYhSv9xtNw6P3GkNr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1708952519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6m7Fd/UTfb75LGBYIxqas0FTZMYEzeGq9U2F2ucSRxw=;
 b=gt1xaaDRTC4rSgOtoVLw063tLhQd9Ex5r8MnNFxpvcuqI94meTzeMsDqB+BQVkUQGz8YNp
 MZzvlS+vjdn8g8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3C9D13A58;
 Mon, 26 Feb 2024 13:01:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nCA5JsaL3GVXVwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 Feb 2024 13:01:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Het Gala <het.gala@nutanix.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, peterx@redhat.com
Subject: Re: [PATCH v2 1/3] qtest: migration: Enhance qtest migration
 functions to support 'channels' argument
In-Reply-To: <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com>
References: <20240223152517.7834-1-het.gala@nutanix.com>
 <20240223152517.7834-2-het.gala@nutanix.com> <87zfvr7xdn.fsf@suse.de>
 <1988bb0f-6ebe-4335-b761-d11313c772fd@nutanix.com>
Date: Mon, 26 Feb 2024 10:01:56 -0300
Message-ID: <87bk83bcqj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x2sM+hKU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=gt1xaaDR
X-Spamd-Result: default: False [-3.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 54F3022514
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On 24/02/24 1:42 am, Fabiano Rosas wrote:
>> Het Gala<het.gala@nutanix.com>  writes:
>>
>>> Introduce support for adding a 'channels' argument to migrate_qmp_fail,
>>> migrate_incoming_qmp and migrate_qmp functions within the migration qtest
>>> framework, enabling enhanced control over migration scenarios.
>> Can't we just pass a channels string like you did in the original series
>> with migrate_postcopy_prepare?
>>
>> We'd change migrate_* functions like this:
>>
>>    void migrate_qmp(QTestState *who, const char *uri, const char *channels,
>>                     const char *fmt, ...)
>>    {
>>    ...
>>        g_assert(!qdict_haskey(args, "uri"));
>>        if (uri) {
>>            qdict_put_str(args, "uri", uri);
>>        }
>>    
>>        g_assert(!qdict_haskey(args, "channels"));
>>        if (channels) {
>>            qdict_put_str(args, "channels", channels);
>>        }
>>    }
>>
>> Write the test like this:
>>
>>    static void test_multifd_tcp_none_channels(void)
>>    {
>>        MigrateCommon args = {
>>            .listen_uri = "defer",
>>            .start_hook = test_migrate_precopy_tcp_multifd_start,
>>            .live = true,
>>            .connect_channels = "'channels': [ { 'channel-type': 'main',"
>>                                "      'addr': { 'transport': 'socket',"
>>                                "                'type': 'inet',"
>>                                "                'host': '127.0.0.1',"
>>                                "                'port': '0' } } ]",
>>            .connect_uri = NULL;
>>                                 
>>        };
>>        test_precopy_common(&args);
>>    }
>
> this was the same first approach that I attempted. It won't work because
>
> The final 'migrate' QAPI with channels string would look like
>
> { "execute": "migrate", "arguments": { "channels": "[ { "channel-type": 
> "main", "addr": { "transport": "socket", "type": "inet", "host": 
> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ]" } }
>
> instead of
>
> { "execute": "migrate", "arguments": { "channels": [ { "channel-type": 
> "main", "addr": { "transport": "socket", "type": "inet", "host": 
> "10.117.29.84", "port": "4000" }, "multifd-channels": 2 } ] } }
>
> It would complain, that channels should be an *array* and not a string.
>
> So, that's the reason parsing was required in qtest too.
>
> I would be glad to hear if there are any ideas to convert /string -> 
> json object -> add it inside qdict along with uri/ ?
>

Isn't this what the various qobject_from_json do? How does it work with
the existing tests?

    qtest_qmp_assert_success(to, "{ 'execute': 'migrate-incoming',"
                             "  'arguments': { "
                             "      'channels': [ { 'channel-type': 'main',"
                             "      'addr': { 'transport': 'socket',"
                             "                'type': 'inet',"
                             "                'host': '127.0.0.1',"
                             "                'port': '0' } } ] } }");

We can pass this^ string successfully to QMP somehow...

>>    static void do_test_validate_uri_channel(MigrateCommon *args)
>>    {
>>        QTestState *from, *to;
>>        g_autofree char *connect_uri = NULL;
>>    
>>        if (test_migrate_start(&from, &to, args->listen_uri, &args->start)) {
>>            return;
>>        }
>>    
>>        wait_for_serial("src_serial");
>>    
>>        if (args->result == MIG_TEST_QMP_ERROR) {
>>            migrate_qmp_fail(from, args->connect_uri, args->connect_channels, "{}");
>>        } else {
>>            migrate_qmp(from, args->connect_uri, args->connect_channels, "{}");
>>        }
>>    
>>        test_migrate_end(from, to, false);
>>    }
>>
>> It's better to require test writers to pass in their own uri and channel
>> strings. Otherwise any new transport added will require people to modify
>> these conversion helpers.
> I agree with your point here. I was thinking to have a general but a 
> hacky version of migrate_uri_parse() but that too seemed like a 
> overkill. I don't have a better solution to this right now
>> Also, using the same string as the user would use in QMP helps with
>> development in general. One could refer to the tests to see how to
>> invoke the migration or experiment with the string in the tests during
>> development.
>
> For examples, I think - enough examples with 'channel' argument are 
> provided where 'migrate' QAPI is defined. users can directly copy the 
> qmp command from there itself.
>
>
> Regards,
>
> Het Gala

