Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37C2CD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:35:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIFZ-0006jG-6m; Thu, 05 Sep 2024 15:34:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1smIFX-0006im-Ee
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:34:35 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1smIFV-0002ZO-Pn
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:34:35 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 826851F836;
 Thu,  5 Sep 2024 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725564871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfSDCf0wh96LxYxvU9I3eiwNaDqsFr7cMfdXkrOFdoA=;
 b=KnPIgY+xKgVN7BD3LQ6CIIuH+W9+uE1Q69p+7Fe04OkQCrDaHyJyWyYxEN48XhFV9SJMuO
 l1/bczCHtSfZlI1CYtJwyVuoKY3tzXBORlarM6SNvjVWVN++5lqvBSQ66oVZDeHpsP4wvU
 OfTbgv2KljQ4ujPlZ/yKYWCIg2LZiJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725564871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfSDCf0wh96LxYxvU9I3eiwNaDqsFr7cMfdXkrOFdoA=;
 b=1vXMOKgCl/kaaCItyYUMdDpfcoJPB8P84z0M0K4mNoFsEatsqqkjJj3PEICopTSchWqZjS
 Red149PgakaXkjCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725564871; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfSDCf0wh96LxYxvU9I3eiwNaDqsFr7cMfdXkrOFdoA=;
 b=KnPIgY+xKgVN7BD3LQ6CIIuH+W9+uE1Q69p+7Fe04OkQCrDaHyJyWyYxEN48XhFV9SJMuO
 l1/bczCHtSfZlI1CYtJwyVuoKY3tzXBORlarM6SNvjVWVN++5lqvBSQ66oVZDeHpsP4wvU
 OfTbgv2KljQ4ujPlZ/yKYWCIg2LZiJ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725564871;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XfSDCf0wh96LxYxvU9I3eiwNaDqsFr7cMfdXkrOFdoA=;
 b=1vXMOKgCl/kaaCItyYUMdDpfcoJPB8P84z0M0K4mNoFsEatsqqkjJj3PEICopTSchWqZjS
 Red149PgakaXkjCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01B3713419;
 Thu,  5 Sep 2024 19:34:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TDVtLsYH2mZMbwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 05 Sep 2024 19:34:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [PATCH] ci: migration: Don't run python tests in the compat job
In-Reply-To: <ZtoEvvdDO_3PsfDz@x1n>
References: <20240905185445.8179-1-farosas@suse.de> <ZtoEvvdDO_3PsfDz@x1n>
Date: Thu, 05 Sep 2024 16:34:28 -0300
Message-ID: <87ttetlwsb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Sep 05, 2024 at 03:54:45PM -0300, Fabiano Rosas wrote:
>> The vmstate-checker-script test has a bug that makes it flaky. It was
>> also committed by mistake and will be removed.
>> 
>> Since the migration-compat job takes the tests from the build-previous
>> job instead of the current HEAD, neither a fix or a removal of the
>> test will take effect for this release.
>> 
>> Disable the faulty/undesirable test by taking advantage that it only
>> runs if the PYTHON environment variable is set. This also disables the
>> analyze-migration-script test, but this is fine because that test
>> doesn't have migration compatibility implications.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> We should still merge your previous pull, right?  Looks like that's the
> easiest indeed.

As I mentioned there, that pull is not to blame for this situation, so
my recommendation is to merge. However, there is still the suppression
of the deprecation messages that Peter asked about. I'll send a series
for that in a moment, but it requires qtest changes and probably a lot
of discussion.

>
> But still, just to double check with both you and Peter on the merge plan.
> If that's the case, I can send the 1st 9.2 pull earlier so we can have this
> in.
>
> Thanks,

