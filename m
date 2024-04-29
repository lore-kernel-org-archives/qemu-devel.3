Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625D7C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 17:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1Ueo-0003C9-75; Mon, 29 Apr 2024 13:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1Uef-0003AE-Qf
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 13:19:05 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1s1Uee-0008Nc-1H
 for qemu-devel@nongnu.org; Mon, 29 Apr 2024 13:19:05 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CA0B222A5;
 Mon, 29 Apr 2024 17:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714411141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+v98PA8nDUJi9h4FrO+0iM4soIkAhq04v01zqGumDoA=;
 b=YaD3q1gxbC1viDi50gBy0qqMCJpky5wLju+G5JHrFxsdPv6c7cZC6k4T2cYpNrtxHC/cLl
 xZAtEo+9JJTdr1xLPHWZqc0oeOOgo64XGRVXTy7mdDm2YnEjSQSL8g26a1AQ/ZZB4yfrIw
 m2JCrzcen9zUKMHxvUpWSNW/nUA2qaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714411141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+v98PA8nDUJi9h4FrO+0iM4soIkAhq04v01zqGumDoA=;
 b=VIaiDrqeKnymETi6KpEoZLTzgh8Q8rYfTTvR3e0NZ+ro44J3PTInblEXM7FapJuf3UcFtr
 45FDS3lmBaCYs6Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1714411140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+v98PA8nDUJi9h4FrO+0iM4soIkAhq04v01zqGumDoA=;
 b=0paOnTXwl7X3Gj6ahPrcFUUWRnnqQdVMgqg3i5LaGg7LVeHPvQ9MYlJOgUiwJv2I9oj7cA
 CUxjN4SnUyQDHsp7vacPDwlmt0kMpix1WHmyLa19YfVCW+MSwKjbvWUpPHFnZmhzwY1cdX
 b7W42O+TN0EAXOeT/N3q3NE0cGeAT08=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1714411140;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+v98PA8nDUJi9h4FrO+0iM4soIkAhq04v01zqGumDoA=;
 b=J10NlOYOLic1bTho/QGZWWLGt9bgKf7YR1i1mlC26/Wdswfu7muTFbeInBFCt1ExfWAh/M
 cPR6UmwsVGq+8bDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E359F138A7;
 Mon, 29 Apr 2024 17:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CKT4KYPWL2agQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Apr 2024 17:18:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 devel@lists.libvirt.org, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer
 dos Santos Moschetta <wainersm@redhat.com>, Beraldo Leal
 <bleal@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>
Subject: Re: [PATCH v2 3/6] migration: Remove 'blk/-b' option from migrate
 commands
In-Reply-To: <Zi_CNIYAi6UbxJ0j@x1n>
References: <20240426131408.25410-1-farosas@suse.de>
 <20240426131408.25410-4-farosas@suse.de> <Zi_CNIYAi6UbxJ0j@x1n>
Date: Mon, 29 Apr 2024 14:18:57 -0300
Message-ID: <875xw0f5oe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.22 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.12)[-0.599]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[13]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

> On Fri, Apr 26, 2024 at 10:14:05AM -0300, Fabiano Rosas wrote:
>> @@ -2003,21 +1997,7 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool resume,
>>          }
>>      }
>>  
>> -    if (blk) {
>> -        if (migrate_colo()) {
>> -            error_setg(errp, "No disk migration is required in COLO mode");
>> -            return false;
>> -        }
>> -        if (migrate_block()) {
>> -            error_setg(errp, "Command options are incompatible with "
>> -                       "current migration capabilities");
>> -            return false;
>> -        }
>> -        if (!migrate_cap_set(MIGRATION_CAPABILITY_BLOCK, true, errp)) {
>> -            return false;
>> -        }
>> -        s->must_remove_block_options = true;
>> -    }
>> +    s->must_remove_block_options = true;
>
> Can we drop this var too?  Perhaps with block_cleanup_parameters()?

Yes, Markus mentioned it in v1 already. Take a look there. There's
several other declarations I missed. v3 is coming soon.

