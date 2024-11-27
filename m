Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F99ED6ACC0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 12:09:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGGqg-0002FV-4h; Wed, 27 Nov 2024 07:08:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGGqc-0002FC-JF
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:08:46 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tGGqa-00054d-Si
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 07:08:46 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 819002117A;
 Wed, 27 Nov 2024 12:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732709322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GrHWaFHkeMOJPJFlXxSRaMFMT2FTOfM8N/nN/jj3KmY=;
 b=dV/yFrGu6uvgO/YdiXgNGDwOLr+YZvBQRLNZDITArpd2cA/S+twzxg229/jE9M3RR4w4YC
 O6Dm4Ww5PmPWhUoIaN99xT2wcsiR7iLsIfPdlT8LlUq7SNigpFav6cOL5mPRLYcjw9SiXJ
 owPKEo+9EEYTUgNZBdCHMlOgNjukZ6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732709322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GrHWaFHkeMOJPJFlXxSRaMFMT2FTOfM8N/nN/jj3KmY=;
 b=akPKSX/Pwp4EJkEO6fYTmKD21zOyNhaI3GK7s6woAI54FbVqlBsgDTxYhzZG0oSQGDX21x
 dl9XVLQKTeW9T8CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732709322; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GrHWaFHkeMOJPJFlXxSRaMFMT2FTOfM8N/nN/jj3KmY=;
 b=dV/yFrGu6uvgO/YdiXgNGDwOLr+YZvBQRLNZDITArpd2cA/S+twzxg229/jE9M3RR4w4YC
 O6Dm4Ww5PmPWhUoIaN99xT2wcsiR7iLsIfPdlT8LlUq7SNigpFav6cOL5mPRLYcjw9SiXJ
 owPKEo+9EEYTUgNZBdCHMlOgNjukZ6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732709322;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GrHWaFHkeMOJPJFlXxSRaMFMT2FTOfM8N/nN/jj3KmY=;
 b=akPKSX/Pwp4EJkEO6fYTmKD21zOyNhaI3GK7s6woAI54FbVqlBsgDTxYhzZG0oSQGDX21x
 dl9XVLQKTeW9T8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06961139AA;
 Wed, 27 Nov 2024 12:08:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0/ESL8kLR2fWawAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 27 Nov 2024 12:08:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Prasad Pandit <ppandit@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, yong.huang@smartx.com,
 chen.zhang@intel.com, Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH] migration: correct multifd receive thread name
In-Reply-To: <20241127111528.167330-1-ppandit@redhat.com>
References: <20241127111528.167330-1-ppandit@redhat.com>
Date: Wed, 27 Nov 2024 09:08:39 -0300
Message-ID: <87bjy0nak8.fsf@suse.de>
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
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Prasad Pandit <ppandit@redhat.com> writes:

> From: Prasad Pandit <pjp@fedoraproject.org>
>
> Multifd receive threads run on the destination side.
> Correct the thread name marco to indicate the same.
>
> Fixes: e620b1e4770b ("migration: Put thread names together with macros")
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/migration.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/migration/migration.h b/migration/migration.h
> index 0956e9274b..3857905c0e 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -37,7 +37,7 @@
>  #define  MIGRATION_THREAD_SRC_TLS           "mig/src/tls"
>  
>  #define  MIGRATION_THREAD_DST_COLO          "mig/dst/colo"
> -#define  MIGRATION_THREAD_DST_MULTIFD       "mig/src/recv_%d"
> +#define  MIGRATION_THREAD_DST_MULTIFD       "mig/dst/recv_%d"
>  #define  MIGRATION_THREAD_DST_FAULT         "mig/dst/fault"
>  #define  MIGRATION_THREAD_DST_LISTEN        "mig/dst/listen"
>  #define  MIGRATION_THREAD_DST_PREEMPT       "mig/dst/preempt"

Reviewed-by: Fabiano Rosas <farosas@suse.de>

