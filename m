Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB85D29FFE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:35:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg058-00086t-1P; Wed, 14 Jan 2026 07:34:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg050-0007su-VY
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:34:34 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vg04x-0004CD-9M
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:34:29 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D3765C598;
 Wed, 14 Jan 2026 12:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768394064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mYdlHsoaQNYvlb2I58sGhuKpi3VpIdAEDysjlhwsAU=;
 b=Wz/5/XqnY8xQEiptfgQwBpln0irCz3bSkX/+sNPRnsdWPUFLzfdrWBYjcmkEiRaxooWqLw
 sSUjMLZ75R10FX5P/TaDDRu+yKvsrtOaG7VBSfh3v/1oMKu2EgjgaTPqiFHVlRfhbxCwOp
 8o7fQT0e6nFa7XZ0RNx4P8jiniKplLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768394064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mYdlHsoaQNYvlb2I58sGhuKpi3VpIdAEDysjlhwsAU=;
 b=ViuMqXVlFOHKuduZFPQ0qg9cJjL/A31E35w1rcfRCbWG/4gVi3mAZS8RMhBjuzXHSIU7Nl
 BdunkKTYERM5faAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1768394064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mYdlHsoaQNYvlb2I58sGhuKpi3VpIdAEDysjlhwsAU=;
 b=Wz/5/XqnY8xQEiptfgQwBpln0irCz3bSkX/+sNPRnsdWPUFLzfdrWBYjcmkEiRaxooWqLw
 sSUjMLZ75R10FX5P/TaDDRu+yKvsrtOaG7VBSfh3v/1oMKu2EgjgaTPqiFHVlRfhbxCwOp
 8o7fQT0e6nFa7XZ0RNx4P8jiniKplLE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1768394064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6mYdlHsoaQNYvlb2I58sGhuKpi3VpIdAEDysjlhwsAU=;
 b=ViuMqXVlFOHKuduZFPQ0qg9cJjL/A31E35w1rcfRCbWG/4gVi3mAZS8RMhBjuzXHSIU7Nl
 BdunkKTYERM5faAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAA493EA63;
 Wed, 14 Jan 2026 12:34:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lNN7Hk+NZ2lSUgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 14 Jan 2026 12:34:23 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, peterx@redhat.com
Cc: qemu-devel@nongnu.org, dtalexundeer@yandex-team.ru,
 vsementsov@yandex-team.ru, yc-core@yandex-team.ru,
 d-tatianin@yandex-team.ru
Subject: Re: [PATCH 5/5] qemu-file: qemu_file_get_fd(): improve interface
In-Reply-To: <20260114064710.176268-6-vsementsov@yandex-team.ru>
References: <20260114064710.176268-1-vsementsov@yandex-team.ru>
 <20260114064710.176268-6-vsementsov@yandex-team.ru>
Date: Wed, 14 Jan 2026 09:34:21 -0300
Message-ID: <87ms2gnzjm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
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

Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:

> Make it symmetrical with qemu_file_put_fd() and simplify callers.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  migration/qemu-file.c     |  9 ++++-----
>  migration/qemu-file.h     |  2 +-
>  migration/vmstate-types.c | 10 +---------
>  3 files changed, 6 insertions(+), 15 deletions(-)
>
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index da701d40e4..f8394cbbb5 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -385,9 +385,8 @@ int qemu_file_put_fd(QEMUFile *f, int fd)
>      return ret;
>  }
>  
> -int qemu_file_get_fd(QEMUFile *f)
> +int qemu_file_get_fd(QEMUFile *f, int *fd)
>  {
> -    int fd = -1;
>      FdEntry *fde;
>      Error *err = NULL;
>      int service_byte;
> @@ -410,12 +409,12 @@ int qemu_file_get_fd(QEMUFile *f)
>          goto fail;
>      }
>  
> -    fd = fde->fd;
> +    *fd = fde->fd;
>      QTAILQ_REMOVE(&f->fds, fde, entry);
>      g_free(fde);
>  
> -    trace_qemu_file_get_fd(f->ioc->name, fd);
> -    return fd;
> +    trace_qemu_file_get_fd(f->ioc->name, *fd);
> +    return 0;
>  
>  fail:
>      error_report_err(error_copy(err));
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index c13c967167..a8e9bb2ccb 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -82,6 +82,6 @@ size_t qemu_get_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
>  
>  QIOChannel *qemu_file_get_ioc(QEMUFile *file);
>  int qemu_file_put_fd(QEMUFile *f, int fd);
> -int qemu_file_get_fd(QEMUFile *f);
> +int qemu_file_get_fd(QEMUFile *f, int *fd);
>  
>  #endif
> diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
> index e34bf4486e..89cb211472 100644
> --- a/migration/vmstate-types.c
> +++ b/migration/vmstate-types.c
> @@ -321,7 +321,6 @@ const VMStateInfo vmstate_info_uint64 = {
>  static int get_fd(QEMUFile *f, void *pv, size_t size,
>                    const VMStateField *field)
>  {
> -    int fd;
>      int32_t *v = pv;
>  
>      if (migrate_mode() == MIG_MODE_CPR_EXEC) {
> @@ -329,14 +328,7 @@ static int get_fd(QEMUFile *f, void *pv, size_t size,
>          return 0;
>      }
>  
> -    fd = qemu_file_get_fd(f);
> -    if (fd < 0) {
> -        return -1;
> -    }
> -
> -    *v = fd;
> -
> -    return 0;
> +    return qemu_file_get_fd(f, v);
>  }
>  
>  static int put_fd(QEMUFile *f, void *pv, size_t size,

Reviewed-by: Fabiano Rosas <farosas@suse.de>

