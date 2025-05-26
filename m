Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C94DC54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 15:41:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJZxT-0001jz-FR; Mon, 26 May 2025 11:41:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uJZxD-0001aD-RI
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:41:39 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uJZx9-0000oz-GS
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:41:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF9601F793;
 Mon, 26 May 2025 15:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748274085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54DQ8GLRLwDJCoTzR7hP5UC5ovQvIMqSOdT+v7wuRYk=;
 b=NmhegAKpfjBXWJZa/qI1NQ1+ltOvPwzRngGUuO2j3L6++uoYcAVD3o4f6gvqkwJm1jpVAg
 QT6sJQ9M7ISNGO/vEtKCkVSwTQ1YMgHhLpix4Q+I3nJiAPdZxSrWTv17+3zK0EExJd4CzX
 ZQ3UQe7PFuAQQppVY6J0vGLGDM4CsfE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748274085;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54DQ8GLRLwDJCoTzR7hP5UC5ovQvIMqSOdT+v7wuRYk=;
 b=IkWZCOIIYNZQaHz8vMT/b0spxx79w9YCtr4ta+/Wa+icEFzmG/qfMMK9//XYCiRRorTeJK
 qgNVElZB8TEy1sCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1748274084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54DQ8GLRLwDJCoTzR7hP5UC5ovQvIMqSOdT+v7wuRYk=;
 b=bmXgKlar6lJHvAxNl7jSrlRPX2cHBG4/027AK2tRTTDgkWqXUAe9rcPf+aykij/+xhhc+S
 exnJeE3VKoomDujCg58cgQ6L4ln0O/RJvo9S8P1o7E4czVr1QYK1XwG1BfF9x+P+RlzNk8
 RPh2zhnO2wWH4tlXMd8tF/gi5gPkcgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1748274084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=54DQ8GLRLwDJCoTzR7hP5UC5ovQvIMqSOdT+v7wuRYk=;
 b=C4OsWGUa80zfn2ZcqrAXhQiOWHW2PQowUQ2dMzdyFHe5rYmzXRFKC84dmwcxu5w8UJr5tw
 PycoycRaWouTRlBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47B861397F;
 Mon, 26 May 2025 15:41:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UNnFAaSLNGhNZgAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 26 May 2025 15:41:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 04/13] migration: Fix parameter validation
In-Reply-To: <aDRoFH-oXq_AiJCP@x1.local>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-5-farosas@suse.de> <aCZVolkNMBZb5KvC@x1.local>
 <87r00g61n5.fsf@suse.de> <87o6vk5yu3.fsf@suse.de>
 <aDRoFH-oXq_AiJCP@x1.local>
Date: Mon, 26 May 2025 12:41:21 -0300
Message-ID: <87bjrfv0pq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> On Thu, May 22, 2025 at 02:39:48PM -0300, Fabiano Rosas wrote:
>> Actually, this doesn't work...
>> 
>> The migrate-set-* commands have optional fields, so we need some form of
>> checking has_* to know which fields the user is setting. Otherwise
>> MigrationSetParameters will have zeros all over that will trip the
>> check.
>> 
>> Then, we need some form of checking has_* to be able to enventually get
>> the values into s->config (former s->parameters/capabilities), otherwise
>> we'll overwrite the already-set values with the potentially empty ones
>> coming from QAPI.
>> 
>> Then there's also the issue of knowing whether a value is 0 because the
>> user set it 0 or because it was never set.
>> 
>> We also can't apply an invalid value to s->config and validate it after
>> because some parameters are allowed to be changed during migration.
>
> What I meant was we only conditionally ignore the has_* fields in below:
>
>   (1) migrate_params_check(), so that QEMU always checks all parameters in
>       the MigrationParameters* specified when invoking the function.
>

Yes, I realised later that's what you meant. I'm looking into
it. Hitting some issues with the block_bitmap_mapping option, which
seems to be able to become NULL even if has_block_bitmap_mapping is
true. According to commit 3cba22c9ad ("migration: Fix
block_bitmap_mapping migration").

>   (2) MigrationState.parameters, so that as long as the parameters are
>       applied (it should only happen after sanity check all pass..) then we
>       ignore these has_* fields (until MigrationState.parameters can have a
>       better struct to not include these has_* fields).
>
> We can keep the has_* checks in migrate_params_test_apply() and
> migrate_params_apply(), so that we won't touch the ones the user didn't
> specify in the QMP commands as you said.
>
> The benefits of having above 1/2 ignoring has_* is some code removal where
> we assume has_* always are TRUEs.
>
> This can be still a bit confusing, but at least we don't need to init has_*
> fields in migrate_params_init() anymore as they'll be all ignored, then
> there's no chance we forget set TRUEs to any new params either.


