Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FB9CC6B2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 22:38:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH7as-0005hu-8G; Wed, 14 Oct 2026 18:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH7aq-0005hg-8u
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 18:37:04 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1xH7ao-0000Zy-KN
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 18:37:04 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 671471F397;
 Wed, 14 Oct 2026 22:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792017420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSSIQXpd0JgzGVlLmwk8XNS+4VDCOpotWHon7ZM0hsg=;
 b=nDN8XZAwT0et83F+z8rS8kOBNQbWIuJ9/TVvPeNst+GAOyep9dKcYxTW4eBgNzwbWDxICo
 ZFT41gWR2Efb1BLgi/Hjuez+kvZBfZhLKKVzw0NJ31W8XgpY24YEuIGq+28KpMIEzNg23j
 NKdrgr1Gz9pItfoW7R0qBW5QhppbnWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792017420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSSIQXpd0JgzGVlLmwk8XNS+4VDCOpotWHon7ZM0hsg=;
 b=7i6DAAtJTwodsYlVdiw+U3FRBqQNWf8vMkU7JJElSDEXZXdSjRC/TodogT+E2UmLKsZCCD
 kUPzthYTPbHWk9CA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=nDN8XZAw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7i6DAAtJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792017420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSSIQXpd0JgzGVlLmwk8XNS+4VDCOpotWHon7ZM0hsg=;
 b=nDN8XZAwT0et83F+z8rS8kOBNQbWIuJ9/TVvPeNst+GAOyep9dKcYxTW4eBgNzwbWDxICo
 ZFT41gWR2Efb1BLgi/Hjuez+kvZBfZhLKKVzw0NJ31W8XgpY24YEuIGq+28KpMIEzNg23j
 NKdrgr1Gz9pItfoW7R0qBW5QhppbnWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792017420;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSSIQXpd0JgzGVlLmwk8XNS+4VDCOpotWHon7ZM0hsg=;
 b=7i6DAAtJTwodsYlVdiw+U3FRBqQNWf8vMkU7JJElSDEXZXdSjRC/TodogT+E2UmLKsZCCD
 kUPzthYTPbHWk9CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D631133F1;
 Wed, 14 Oct 2026 22:36:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hCnoBwsE0GrqEgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Oct 2026 22:36:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org
Cc: den@openvz.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Zhao Liu <zhao1.liu@intel.com>, Stefan Weil
 <sw@weilnetz.de>
Subject: Re: [PATCH 01/10] util/qemu-thread: track bql_locked across the
 timed condvar wait
In-Reply-To: <20260915203455.580999-2-den@openvz.org>
References: <20260915203455.580999-1-den@openvz.org>
 <20260915203455.580999-2-den@openvz.org>
Date: Wed, 14 Oct 2026 19:36:57 -0300
Message-ID: <878q3znc3a.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 671471F397
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

"Denis V. Lunev" <den@openvz.org> writes:

> From: Denis V. Lunev <den@openvz.org>
>
> qemu_cond_timedwait_ts() releases and retakes the mutex around
> pthread_cond_timedwait(), but calls the two trace points by hand
> instead of going through the mutex hooks, so it never reaches
> bql_update_status(). A thread waiting there still reports bql_locked
> true while the mutex is released, which is the confusion the hooks were
> given that job to end. migration/cpu-throttle.c reaches this through
> qemu_cond_timedwait_bql(). The Windows qemu_cond_timedwait_impl() has
> the same two trace calls, next to a qemu_cond_wait_impl() that already
> uses the hooks.
>
> Call the hooks, which emit the same two trace points.
>
> Fixes: c89d1c879a ("bql: Fix bql_locked status with condvar APIs")
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> Cc: Zhao Liu <zhao1.liu@intel.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> ---
>  util/qemu-thread-posix.c | 4 ++--
>  util/qemu-thread-win32.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/util/qemu-thread-posix.c b/util/qemu-thread-posix.c
> index 089606c93f..580cdf8079 100644
> --- a/util/qemu-thread-posix.c
> +++ b/util/qemu-thread-posix.c
> @@ -250,9 +250,9 @@ qemu_cond_timedwait_ts(QemuCond *cond, QemuMutex *mut=
ex, struct timespec *ts,
>      int err;
>=20=20
>      assert(cond->initialized);
> -    trace_qemu_mutex_unlock(mutex, file, line);
> +    qemu_mutex_pre_unlock(mutex, file, line);
>      err =3D pthread_cond_timedwait(&cond->cond, &mutex->lock, ts);
> -    trace_qemu_mutex_locked(mutex, file, line);
> +    qemu_mutex_post_lock(mutex, file, line);
>      if (err && err !=3D ETIMEDOUT) {
>          error_exit(err, __func__);
>      }
> diff --git a/util/qemu-thread-win32.c b/util/qemu-thread-win32.c
> index 3037732a6f..afdacdb5f2 100644
> --- a/util/qemu-thread-win32.c
> +++ b/util/qemu-thread-win32.c
> @@ -177,11 +177,11 @@ bool qemu_cond_timedwait_impl(QemuCond *cond, QemuM=
utex *mutex, int ms,
>      int rc =3D 0;
>=20=20
>      assert(cond->initialized);
> -    trace_qemu_mutex_unlock(mutex, file, line);
> +    qemu_mutex_pre_unlock(mutex, file, line);
>      if (!SleepConditionVariableSRW(&cond->var, &mutex->lock, ms, 0)) {
>          rc =3D GetLastError();
>      }
> -    trace_qemu_mutex_locked(mutex, file, line);
> +    qemu_mutex_post_lock(mutex, file, line);
>      if (rc && rc !=3D ERROR_TIMEOUT) {
>          error_exit(rc, __func__);
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

