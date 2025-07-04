Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B1DEC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 13:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXgGW-0004gY-B4; Fri, 04 Jul 2025 09:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uXgGM-0004cU-Mg
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:15:35 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uXgGE-0008SL-K0
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 09:15:28 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8F76D211A3;
 Fri,  4 Jul 2025 13:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751634924; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DC272G/WYtTmxxNvMcMR6RnRzFLcQaoyTQqH67jvUQ=;
 b=cegGvlva1OvBI9amUmv/m3+pexI04rdD7wJXqHwNBedA6GkTpnkUvDNR6Er/B+h5j1vDEo
 0J8N56DNUD+qt4xPTyqxY+ifhRB9i1xdzQcwD5Qtm1DapAfa6Ahu97uKsyql7ui5ka9jSn
 AK6l6qtHmsHFSOyltLbME3ZVL7SvHv0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751634924;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DC272G/WYtTmxxNvMcMR6RnRzFLcQaoyTQqH67jvUQ=;
 b=zGJVP3RGh9QSvYzrtuk2E9yq2ti828YbOoVg1wAb05Vn/xEVE4b3cHNtH28l+MgRv8FgcB
 BRI3Lfwitiv8lUAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pn68AOoo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=xBLr74BK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1751634922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DC272G/WYtTmxxNvMcMR6RnRzFLcQaoyTQqH67jvUQ=;
 b=pn68AOooMaCIduYFAIbydxHZVRZjhyCM4UteIgQSRDhSL1TfeBn3/BwQsaOCHWozP5Bm40
 VPjLj+aEdJYZfX+LpGSWIEGGq/7CuHWHLIPEVfnrs7740FB5R7ujFH11WqqFwuTstNOxOx
 KkOrvTgwNRmTKcavYz1NH/ZTBapRADs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1751634922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2DC272G/WYtTmxxNvMcMR6RnRzFLcQaoyTQqH67jvUQ=;
 b=xBLr74BK18D3/1H6y9HMpodzsirNvVzGyK0tTPTesyL9kj9Xz81aLHpI7ve0mOs4telRoj
 9qqK3f+vo1INmhAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C19D13757;
 Fri,  4 Jul 2025 13:15:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nB6cNenTZ2jYYQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 04 Jul 2025 13:15:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, Peter Xu
 <peterx@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2 16/24] migration: Add capabilities into
 MigrationParameters
In-Reply-To: <87jz4sz5b6.fsf@pond.sub.org>
References: <20250630195913.28033-1-farosas@suse.de>
 <20250630195913.28033-17-farosas@suse.de> <87jz4sz5b6.fsf@pond.sub.org>
Date: Fri, 04 Jul 2025 10:15:15 -0300
Message-ID: <87h5zs3xng.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 8F76D211A3
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
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

Markus Armbruster <armbru@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> writes:
>
>> Add capabilities to MigrationParameters. This structure will hold all
>> migration options. Capabilities will go away in the next patch.
>>
>> Also add capabilities to MigrationParameter as the enum needs to be
>> kept in sync with MigrationParameters. This affects the parsing of
>> migration HMP commands so make the necessary additions there too.
>>
>> From this point on, both QMP and HMP versions of
>> migrate-set-parameters and query-migrate-parameters gain the ability
>> to work with capabilities.
>>
>> With MigrationParameters now having members for each capability, the
>> migration capabilities commands (query-migrate-capabilities,
>> migrate-set-capabilities) will soon be deprecated. Add a set of
>> helpers to convert between the old MigrationCapability representation
>> and the new representation as members of MigrationParameters.
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> [...]
>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 40e00fb86e..3d3f5624c5 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -763,7 +763,14 @@
>>             'vcpu-dirty-limit',
>>             'mode',
>>             'zero-page-detection',
>> -           'direct-io'] }
>> +           'direct-io', 'xbzrle', 'rdma-pin-all', 'auto-converge',
>> +           'zero-blocks', 'events', 'postcopy-ram', 'x-colo',
>> +           'release-ram', 'return-path', 'pause-before-switchover',
>> +           'multifd', 'dirty-bitmaps', 'postcopy-blocktime',
>> +           'late-block-activate', 'x-ignore-shared',
>> +           'validate-uuid', 'background-snapshot',
>> +           'zero-copy-send', 'postcopy-preempt',
>> +           'switchover-ack', 'dirty-limit', 'mapped-ram' ] }
>
> This is MigrateParameter.  Different order than in MigrationParameters.
> Intentional?
>

I think you mean the pre-existing difference in the order of the
compression options multifd-*-level? I'll fix that.

If it's something else, it eludes my gaze.


