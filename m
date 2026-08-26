Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF72C61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:03:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzF9E-0007ot-VV; Wed, 26 Aug 2026 11:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzF9D-0007ok-V9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 11:02:39 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wzF9C-0001kT-6u
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 11:02:39 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 177CB2197E;
 Wed, 26 Aug 2026 15:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787756552; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dsn7P9QqMtZuMlTDORkSQybUZgbxcKUSrUx3DrOiu6E=;
 b=cFqhQDpQ5KOLBp1vn5sfHTGTHSs9j22wzSRRw/Lkf2fuiEKMCrjzeatBh5XV2/vLe8cEdE
 SASHA1z1odeExLohkGQyTuO7eBmQs8dYbFGXrEcp24rzbTRZeEqAgt6tG2AS6xpU96LV/5
 8OBfuCDxmaMQL2t/78xL7WDMtHcLyrc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787756552;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dsn7P9QqMtZuMlTDORkSQybUZgbxcKUSrUx3DrOiu6E=;
 b=mfsMzXtQTp39+O8rFTRc+JHjst2/DKPGBXkuETvEaLmNSqth+21LbzSDBDcKkd61DobgmP
 OCqbZIouBFZaRLBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787756548; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dsn7P9QqMtZuMlTDORkSQybUZgbxcKUSrUx3DrOiu6E=;
 b=yjMPbMyUEwSeTKuayUWdpIcKIg/qZ7qOYR/HEMYWu4omOlQdb/G52HoO88hs0Z/O/E38XJ
 /PzIy7o8ANThGfRpGF0Uhy+MbaeWyGpsryYVvm40wcm4ekYt/oYAa8R4HsHu4/F8SidL/b
 zr8t9aC4j5JlHPKEeyWcvRwbSXataJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787756548;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dsn7P9QqMtZuMlTDORkSQybUZgbxcKUSrUx3DrOiu6E=;
 b=kka91jKQkzMKYrpdFhSs2R5yodKKjyWl3wneSBk/nIxD7yClLBhWfPhlevaAEzZqPWxNLs
 BpaM6gM87PHXywCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACE341361C;
 Wed, 26 Aug 2026 15:02:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h51WHwMAj2raRQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 26 Aug 2026 15:02:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, peterx@redhat.com,
 andrey.drobyshev@virtuozzo.com
Subject: Re: [PATCH 0/9] scripts/qemugdb: some fixes for 'qemu bt' / 'qemu
 coroutine' commands
In-Reply-To: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
References: <20260804151743.937694-1-andrey.drobyshev@virtuozzo.com>
Date: Wed, 26 Aug 2026 12:02:21 -0300
Message-ID: <8733w1hqma.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.28 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.18)[-0.913]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

Andrey Drobyshev <andrey.drobyshev@virtuozzo.com> writes:

> A bunch of fixes for functional bugs, cosmetic improvements and fixes
> for annoying failures and corner cases which I encounter when using this
> script in gdb sessions.  Most of them are basically fixups for my previous
> commit 42f3c143c3a0 ("scripts/qemugdb: coroutine: Add option for obtaining
> detailed trace in coredump").  Still I did split them up cause it'd be a
> mess putting them all together.
>
> Andrey Drobyshev (9):
>   scripts/qemugdb: coroutine: Fix selected frame leak on error path
>   scripts/qemugdb: coroutine: Get rid of fallback pattern when dumping
>     backtrace
>   scripts/qemugdb: coroutine: Only attempt to restore regs in coredump
>   scripts/qemugdb: coroutine: Don't unwind past the outermost frame
>   scripts/qemugdb: coroutine: Fix patching pt_regs in the coredump
>   scripts/qemugdb: coroutine: Fix '--detailed' description
>   scripts/qemugdb: coroutine: Handle target absence gracefully
>   scripts/qemugdb: coroutine: Speed up coroutine lookup in a coredump
>   scripts/qemugdb: coroutine: Don't touch the coredump for a plain
>     backtrace
>
>  scripts/qemugdb/coroutine.py | 135 ++++++++++++++++++++++-------------
>  1 file changed, 86 insertions(+), 49 deletions(-)

I used this series for debugging both a live process and a coredump. It
didn't show any regressions. I can confirm that the exception fixed by
patch 4 no longer happens.

Tested-by: Fabiano Rosas <farosas@suse.de>

