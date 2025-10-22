Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E130CCD1AB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:25:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXti-0007KG-KX; Wed, 22 Oct 2025 08:24:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBXta-0007Jq-7a
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:24:50 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vBXtX-0007hr-U7
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:24:50 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C293D21175;
 Wed, 22 Oct 2025 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761135879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNpdOVujGAffqiatc878eEyWlf4e7SmQn9cGWssgujk=;
 b=hEWapDR+aAfK/6bkDdKODcBqG4siW63/wGKJel8nILCIDhDBdlBtsPFrguOUTPf8SE8Yti
 HAhC80MUZkTUqlEXesd4yBkmGUVvodu3Z8QnC8tZiM9RSu28JBRHRaUep2J/0CxV1Jw3uR
 x4B1TwwDJn1zz+niwHJrf/HdECL4Lyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761135879;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNpdOVujGAffqiatc878eEyWlf4e7SmQn9cGWssgujk=;
 b=j+aE7leECSDmfDIwjg9ig3SZ3qq30vxpK3iUy2OpYij71gHzKZqvnUM5Ryd4B2ieH/szJt
 WT0fLiBtBCQejXCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761135875; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNpdOVujGAffqiatc878eEyWlf4e7SmQn9cGWssgujk=;
 b=1s1gCHINWvAfALihpwluCbwrh8KGlncoKGPBTJvHODxpTKoJ7tzrBjQs11hMmXpq8LQSk1
 KAwMK1uw5GTX/0rEF4mPfiNvnz6BvS6hwo+3tm8LikFVTJ+nAlN348p8741bkup7CCcZ7l
 /HmDTVa/KQF/iZ8Q4HsJ5IbdDOjtkR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761135875;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HNpdOVujGAffqiatc878eEyWlf4e7SmQn9cGWssgujk=;
 b=g/cR2qr6z2/z/1cPMrObWuoXDLCOE4Dic3mvkTvIa7X/Xt36SZsD8k9eAl3EJZv5H7oC3k
 FTTsstN5mTsb4XCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 42C2113A29;
 Wed, 22 Oct 2025 12:24:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UO8RAAPN+GhSKgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 Oct 2025 12:24:35 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Arun Menon <armenon@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 2/3] migration/cpr: Fix coverity report in
 cpr_exec_persist_state()
In-Reply-To: <aPf7R-F0uv1RSqXh@x1.local>
References: <20251021184132.2635958-1-peterx@redhat.com>
 <20251021184132.2635958-3-peterx@redhat.com> <87o6q0t1z0.fsf@suse.de>
 <aPf7R-F0uv1RSqXh@x1.local>
Date: Wed, 22 Oct 2025 09:24:25 -0300
Message-ID: <87frbbt98m.fsf@suse.de>
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
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Oct 21, 2025 at 05:49:07PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > Per reported and analyzed by Peter:
>> >
>> > https://lore.kernel.org/r/CAFEAcA_mUQ2NeoguR5efrhw7XYGofnriWEA=+Dg+Ocvyam1wAw@mail.gmail.com
>> >
>> > mfd leak is a false positive, try to use a coverity annotation (which I
>> > didn't find manual myself, but still give it a shot).
>> >
>> > Fix the other one by dumping an error message if setenv() failed.
>> >
>> > Resolves: Coverity CID 1641391
>> > Resolves: Coverity CID 1641392
>> > Fixes: efc6587313 ("migration: cpr-exec save and load")
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> > ---
>> >  migration/cpr-exec.c | 5 ++++-
>> >  1 file changed, 4 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/migration/cpr-exec.c b/migration/cpr-exec.c
>> > index d57714bc5d..3cf44634a9 100644
>> > --- a/migration/cpr-exec.c
>> > +++ b/migration/cpr-exec.c
>> > @@ -43,13 +43,16 @@ static QEMUFile *qemu_file_new_fd_output(int fd, const char *name)
>> >  void cpr_exec_persist_state(QEMUFile *f)
>> >  {
>> >      QIOChannelFile *fioc = QIO_CHANNEL_FILE(qemu_file_get_ioc(f));
>> > +    /* coverity[leaked_storage] - mfd intentionally kept open across exec() */
>> >      int mfd = dup(fioc->fd);
>> >      char val[16];
>> >  
>> >      /* Remember mfd in environment for post-exec load */
>> >      qemu_clear_cloexec(mfd);
>> >      snprintf(val, sizeof(val), "%d", mfd);
>> > -    g_setenv(CPR_EXEC_STATE_NAME, val, 1);
>> > +    if (!g_setenv(CPR_EXEC_STATE_NAME, val, 1)) {
>> > +        error_report("Setting env %s = %s failed", CPR_EXEC_STATE_NAME, val);
>> > +    }
>> 
>> Best to abort no? We don't want the rest of the code reading whatever
>> may be at that env variable and running with it.
>
> I didn't want to abort, because it's the same as QMP migrate failure at the
> beginning.
>
> If we want to do better, we can allow this function to return a failure
> instead.
>
> And.. when I was trying cpr-exec with no argv it already can crash QEMU.  I
> think that's also a bug.
>
> Let me prepare something better than this..  I'll likely add a new patch to
> fix that too.
>

Remember to copy Oracle folks.

>> 
>> >  }
>> >  
>> >  static int cpr_exec_find_state(void)
>> 

