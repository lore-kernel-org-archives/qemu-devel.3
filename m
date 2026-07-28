Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BF0C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:00:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woou4-0002pN-1P; Tue, 28 Jul 2026 16:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1woou2-0002oW-5e
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:59:54 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1woou0-00032t-PA
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:59:53 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 55EBF3E2E;
 Tue, 28 Jul 2026 20:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785272385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4MK/XHRm2MRAUvlkvCWYdy23gEW13DSOzqAcSI3iQc=;
 b=l7XASOUghRkGzMI5oFz0fFP8OWpL+6M9nXXbrq/1eABBWolYPKque/zuOnqHDuWInBh8i9
 gdAwuAuEzVho52qWF5/RzCRIFug9v02er9i9a/moGYj2u91c9YnL5f1LG4PabrkPGHFnww
 Z9nu8D50DtK9rAcpQ9G5ud9nWw7f6yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785272385;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4MK/XHRm2MRAUvlkvCWYdy23gEW13DSOzqAcSI3iQc=;
 b=nJam+KaWZkk39f1KiHjkp+APInqjIgx+OjntqmnVwLGy2tkqSoNgzNhFK2q/hX+WWlqMxd
 eiZNiw1tjX9KrrCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785272381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4MK/XHRm2MRAUvlkvCWYdy23gEW13DSOzqAcSI3iQc=;
 b=Omm/0KW6JG0OKiG08PehNotKP8yUHcP2iGwRl647tKuIKkYAWfHvEGL+tSJY+KtMcxuDc0
 vjn1aRdR2YZ4hwbBFhS8qAJX1r9C1AyPLrQbvBT46Z+Remy8ay+DqE1Xwh6iwLansjzqbz
 3uXW8VafTCSZDduJttv2VW2m6Bp0SJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785272381;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R4MK/XHRm2MRAUvlkvCWYdy23gEW13DSOzqAcSI3iQc=;
 b=cKKOd7p2w4MDA/xrB2zaRpTFSeoKm3im784FFetsT3cyuWFSFaaU+SAFwky2iFx0UTIf5w
 nQJu15fY2vRD7QBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB9CB779B1;
 Tue, 28 Jul 2026 20:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gfKvLjwYaWrZCQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jul 2026 20:59:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>, qemu-stable
 <qemu-stable@nongnu.org>, Yuan Liu <yuan1.liu@intel.com>, Yichen Wang
 <yichen.wang@bytedance.com>
Subject: Re: [PATCH 3/5] migration/multifd: Replace assert() with
 error_setg() in recv paths
In-Reply-To: <amkQ0JzADdKbhsOJ@x1.local>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-4-peterx@redhat.com> <87tspiopuc.fsf@suse.de>
 <amkQ0JzADdKbhsOJ@x1.local>
Date: Tue, 28 Jul 2026 17:59:30 -0300
Message-ID: <87h5liomod.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email, suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, intel.com:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

> On Tue, Jul 28, 2026 at 04:51:07PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > QPL and UADK multifd backends use assert() to validate wire-controlled
>> > fields like per-page compressed lengths and packet size consistency.  These
>> > asserts will stop working with released version of binaries, so may stop
>> > working.
>> 
>> This is not true, asserts are always on. Same for the similar comment in
>> the previous patch commit message.
>
> Shall I perhaps replace this to "when compiled with -DNDEBUG"?
>

It's not allowed as per osdep.h:

#ifdef NDEBUG
#error building with NDEBUG is not supported
#endif

>> 
>> >
>> > Replace all assert() calls in the receive path with proper error_setg() so
>> > validation failures are reported gracefully rather than crashing or
>> > silently ignored.
>> >
>> > While at it, touch up an assert() in qatzip recv path too.
>> >
>> > Cc: qemu-stable <qemu-stable@nongnu.org>
>> > Cc: Fabiano Rosas <farosas@suse.de>
>> > Cc: Yuan Liu <yuan1.liu@intel.com>
>> > Cc: Yichen Wang <yichen.wang@bytedance.com>
>> > Signed-off-by: Peter Xu <peterx@redhat.com>
>> 
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>
> Thanks,

