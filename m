Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68E4F9D0D6
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:55:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCg77-0007FT-QF; Tue, 14 Apr 2026 11:55:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCg75-00076l-V5
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:55:44 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCg74-0000bd-8d
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:55:43 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F1ABE5BE05;
 Tue, 14 Apr 2026 15:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776182141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/F7uWvi3bthbbBDE9JWB6OLCf7YS/XHKddRZk2HtiA=;
 b=AnC7GNjNw1qPJMIfj9zuTI6QMZLZoGtmJcClZlzWAimbTTBlKi3pB+MsLp07CDPjN6i0kY
 qtW6lKc5NKZt2HYpVo2P9s7QHGZk+upktHl3Nlk6JAn3MX45dyA/Ro33VMT/nyDNiirQxN
 9xPxuUdLCKkMA/HPw3KwAKxbbKZQiOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776182141;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/F7uWvi3bthbbBDE9JWB6OLCf7YS/XHKddRZk2HtiA=;
 b=SKVBCgyzZ6PWWL/GOdZ553bdMFYRgONlXwfNjTj9vqRKPDMQT4uZLkkPLOlq9agre7QC3D
 oFCHddIwFE/CIQBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776182140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/F7uWvi3bthbbBDE9JWB6OLCf7YS/XHKddRZk2HtiA=;
 b=geiy6f9D/PoOC4lLQ2jrP39gVAyDgCO6kSPEH8VvVp4Mhlvmc4bBmlIa7ldqphUkC1K9wo
 SyrbFvJzz5M3vufmP7x6jBKOHeZExYDnsge8vBt8SkXafy3vNruWDcEnNJdCS3/N1lk/IB
 TOZishWEkSRH5B4cP1itKTYui2AO36w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776182140;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q/F7uWvi3bthbbBDE9JWB6OLCf7YS/XHKddRZk2HtiA=;
 b=3cDhn4tEQquMBiGPRXLB2iMLGSwZpQx5tQBrZfQp1HabBzTWoCrdu4xKLnfuUfbTKSyp6/
 4Zz+BPcmxpj3EdCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 911694B510;
 Tue, 14 Apr 2026 15:55:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OIZeGHxj3mkZVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Apr 2026 15:55:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, peterx@redhat.com, junjie.cao@intel.com
Subject: Re: [PATCH v3 3/4] migration/file: fix type mismatch and NULL deref
 in multifd_file_recv_data
In-Reply-To: <20260413214549.926435-4-junjie.cao@intel.com>
References: <20260413214549.926435-1-junjie.cao@intel.com>
 <20260413214549.926435-4-junjie.cao@intel.com>
Date: Tue, 14 Apr 2026 12:55:38 -0300
Message-ID: <87bjflzgcl.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email, imap1.dmz-prg2.suse.org:helo,
 suse.de:mid, suse.de:email]
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

Junjie Cao <junjie.cao@intel.com> writes:

> multifd_file_recv_data() stores the return value of qio_channel_pread()
> (ssize_t) in a size_t variable.  On I/O error the -1 return value wraps
> to SIZE_MAX, producing a nonsensical read size in the error message.
>
> More critically, a short read (0 <=3D ret < data->size) is possible when
> the migration file is truncated.  In that case qio_channel_pread()
> returns a non-negative value without setting *errp.  The function then
> calls error_prepend(errp, ...) which dereferences *errp -- a NULL
> pointer -- crashing QEMU.
>
> Fix both issues by switching to qio_channel_pread_all() introduced in
> a previous patch, which retries on short reads and treats end-of-file
> as an error, so the caller no longer needs to check the byte count
> manually.  Add ERRP_GUARD() so that error_prepend() works correctly
> even when errp is &error_fatal or NULL.
>
> Fixes: a49d15a38d3d ("migration/multifd: Support incoming mapped-ram stre=
am format")
> Suggested-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>  migration/file.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/migration/file.c b/migration/file.c
> index 5618aced49..0853188601 100644
> --- a/migration/file.c
> +++ b/migration/file.c
> @@ -254,15 +254,16 @@ int file_write_ramblock_iov(QIOChannel *ioc, const =
struct iovec *iov,
>=20=20
>  int multifd_file_recv_data(MultiFDRecvParams *p, Error **errp)
>  {
> +    ERRP_GUARD();
>      MultiFDRecvData *data =3D p->data;
> -    size_t ret;
> +    int ret;
>=20=20
> -    ret =3D qio_channel_pread(p->c, (char *) data->opaque,
> -                            data->size, data->file_offset, errp);
> -    if (ret !=3D data->size) {
> +    ret =3D qio_channel_pread_all(p->c, (char *) data->opaque,
> +                                data->size, data->file_offset, errp);
> +    if (ret !=3D 0) {
>          error_prepend(errp,
> -                      "multifd recv (%u): read 0x%zx, expected 0x%zx",
> -                      p->id, ret, data->size);
> +                      "multifd recv (%u): ",
> +                      p->id);
>          return -1;
>      }

Reviewed-by: Fabiano Rosas <farosas@suse.de>

