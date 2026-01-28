Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D1ED3F07F
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:23:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7No-0007Zz-RA; Wed, 28 Jan 2026 10:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7Nn-0007R6-47
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:23:03 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vl7Nl-0003PR-BA
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:23:02 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 23DCC5BCCA;
 Wed, 28 Jan 2026 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LZO2BUFtU1ranibaAfqxGpOq127KatRCfJj2cFBk9y0=;
 b=FZQeZx4868GxwkPSq8xVM7P+fH+EsPfRSjvJgQlo89KdcuwSDh8b0TOBTSq1AhbnAdfz2c
 RRVW7oymVVvsMDvUaywmYcqfHKUQRcXxXFZU+8DNRF26W1V1RruBF4Zsf/lHAwB4d+MvqT
 ZGwOz26B3LZWrAFpSMbVdvrszGth8xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LZO2BUFtU1ranibaAfqxGpOq127KatRCfJj2cFBk9y0=;
 b=SjN4oVqa+yyBP4slIlGs0LmdYWpBDVzJdrn9Q1zbVLiKTHot76pUnsh1CyKgsIcHDmnOVT
 T3eU1DsYs/ZITTAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769613780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LZO2BUFtU1ranibaAfqxGpOq127KatRCfJj2cFBk9y0=;
 b=FZQeZx4868GxwkPSq8xVM7P+fH+EsPfRSjvJgQlo89KdcuwSDh8b0TOBTSq1AhbnAdfz2c
 RRVW7oymVVvsMDvUaywmYcqfHKUQRcXxXFZU+8DNRF26W1V1RruBF4Zsf/lHAwB4d+MvqT
 ZGwOz26B3LZWrAFpSMbVdvrszGth8xk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769613780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LZO2BUFtU1ranibaAfqxGpOq127KatRCfJj2cFBk9y0=;
 b=SjN4oVqa+yyBP4slIlGs0LmdYWpBDVzJdrn9Q1zbVLiKTHot76pUnsh1CyKgsIcHDmnOVT
 T3eU1DsYs/ZITTAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FCD73EA61;
 Wed, 28 Jan 2026 15:22:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oKNzFNMpemkVNwAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 28 Jan 2026 15:22:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH v2 17/24] migration:
 qemu_savevm_state_complete_precopy() take MigrationState*
In-Reply-To: <20260127185254.3954634-18-peterx@redhat.com>
References: <20260127185254.3954634-1-peterx@redhat.com>
 <20260127185254.3954634-18-peterx@redhat.com>
Date: Wed, 28 Jan 2026 12:22:56 -0300
Message-ID: <87343pg3sf.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[web.de]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FREEMAIL_CC(0.00)[redhat.com,web.de];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> Make it pass in MigrationState* instead of s->to_dst_file, so as to drop
> the internal migrate_get_current().
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.h    | 2 +-
>  migration/migration.c | 2 +-
>  migration/savevm.c    | 7 ++++---
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/migration/savevm.h b/migration/savevm.h
> index 57b96133d5..bded5e2a6c 100644
> --- a/migration/savevm.h
> +++ b/migration/savevm.h
> @@ -42,7 +42,7 @@ void qemu_savevm_state_header(QEMUFile *f);
>  int qemu_savevm_state_iterate(QEMUFile *f, bool postcopy);
>  void qemu_savevm_state_cleanup(void);
>  void qemu_savevm_state_complete_postcopy(QEMUFile *f);
> -int qemu_savevm_state_complete_precopy(QEMUFile *f);
> +int qemu_savevm_state_complete_precopy(MigrationState *s);
>  void qemu_savevm_state_pending_exact(uint64_t *must_precopy,
>                                       uint64_t *can_postcopy);
>  void qemu_savevm_state_pending_estimate(uint64_t *must_precopy,
> diff --git a/migration/migration.c b/migration/migration.c
> index c6e54d2a3f..b8c85496f8 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2752,7 +2752,7 @@ static int migration_completion_precopy(MigrationState *s)
>          goto out_unlock;
>      }
>  
> -    ret = qemu_savevm_state_complete_precopy(s->to_dst_file);
> +    ret = qemu_savevm_state_complete_precopy(s);
>  out_unlock:
>      bql_unlock();
>      return ret;
> diff --git a/migration/savevm.c b/migration/savevm.c
> index e1918d4f38..830d8e5988 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1728,8 +1728,9 @@ int qemu_savevm_state_non_iterable(QEMUFile *f)
>      return 0;
>  }
>  
> -int qemu_savevm_state_complete_precopy(QEMUFile *f)
> +int qemu_savevm_state_complete_precopy(MigrationState *s)
>  {
> +    QEMUFile *f = s->to_dst_file;
>      int ret;
>  
>      ret = qemu_savevm_state_complete_precopy_iterable(f, false);
> @@ -1742,7 +1743,7 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f)
>          return ret;
>      }
>  
> -    qemu_savevm_state_end_precopy(migrate_get_current(), f);
> +    qemu_savevm_state_end_precopy(s, f);
>  
>      return qemu_fflush(f);
>  }
> @@ -1841,7 +1842,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>  
>      ret = qemu_file_get_error(f);
>      if (ret == 0) {
> -        qemu_savevm_state_complete_precopy(f);
> +        qemu_savevm_state_complete_precopy(ms);
>          ret = qemu_file_get_error(f);
>      }
>      if (ret != 0) {

Reviewed-by: Fabiano Rosas <farosas@suse.de>

