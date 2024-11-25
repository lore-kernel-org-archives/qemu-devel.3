Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F77D59D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 21:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFgFW-0001Id-1v; Mon, 25 Nov 2024 16:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFgFU-0001I9-1m
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:04:00 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tFgFO-0007Ew-Th
 for qemu-devel@nongnu.org; Mon, 25 Nov 2024 16:03:59 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 230F61F453;
 Mon, 25 Nov 2024 21:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732568633; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99YyRbcZFK+XXplbNn1xPEpuHo1FTFBI7KkO6zID9N0=;
 b=Sdyi1awLvXO4ykGkI+7s+Iwd3f6pL2kJ1Fb09fGNcSTbRhUI7cQfOfNujRrZK6BMi2UMjq
 iO+vGlDotA5+IHeZlFuxU06qGwbskjMLTJltMcrK/7DC99RPL/QEta2g0STFdJi+REnKpT
 Wkx2oWyzlKPxz4TQjymhvyvbxb9IE9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732568633;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99YyRbcZFK+XXplbNn1xPEpuHo1FTFBI7KkO6zID9N0=;
 b=sIB6EJAV1hwgNQ6TSgPYMPceOsZMgQXwCu29uv3WELc7Pvlej0U5e16we/jXt8NXQHasuy
 KEp9hgs0adswgBAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732568632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99YyRbcZFK+XXplbNn1xPEpuHo1FTFBI7KkO6zID9N0=;
 b=xWdjRtn411YywlbDEHaMUvbro0VPTs1fGLy00WXfGUZLIck/HDEhfBP2Q7VjH3mMtUNO86
 OsiWxvR5l6eZf4Jh5IBG9FzBSSPCHzcaV5fdBY9vtc/yWRrK4Euh8AQ3dUJ6gzXWtC7vIS
 M1Quikr0T6Wlws5mRAWi02ohCRWaeQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732568632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=99YyRbcZFK+XXplbNn1xPEpuHo1FTFBI7KkO6zID9N0=;
 b=YCT/WRx/B3hVS1iqRQsWNECsDj1XMB8oBNBc0Vzc/XrOWMeu4IscIiCZRbLfeMsHZiz8L9
 sUx3KYrOafuIVKBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 995AB137D4;
 Mon, 25 Nov 2024 21:03:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X5tnFzfmRGcEQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 25 Nov 2024 21:03:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 02/22] tests/qtest/migration: Standardize hook names
In-Reply-To: <Z0TjRertI__KnVoZ@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-3-farosas@suse.de> <Z0TjRertI__KnVoZ@x1n>
Date: Mon, 25 Nov 2024 18:03:48 -0300
Message-ID: <877c8rnhzf.fsf@suse.de>
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
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
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

> On Wed, Nov 13, 2024 at 04:46:10PM -0300, Fabiano Rosas wrote:
>>  static void *
>> -test_migration_precopy_tcp_multifd_start_no_zero_page(QTestState *from,
>> +test_migration_precopy_tcp_multifd_no_zero_page_start(QTestState *from,
>
> Looks like this one is leftover to do s/test_migration/migrate_hook/ (and
> below when referenced)?

Good catch! Thanks

>
> Other than that:
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
>>                                                        QTestState *to)
>>  {
>> -    test_migrate_precopy_tcp_multifd_start_common(from, to, "none");
>> +    migrate_hook_start_precopy_tcp_multifd_common(from, to, "none");
>>      migrate_set_parameter_str(from, "zero-page-detection", "none");
>>      return NULL;
>>  }

