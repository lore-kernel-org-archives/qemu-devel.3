Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65FFD74ED9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 13:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjHY4-0000e9-AZ; Fri, 23 Jan 2026 08:50:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHXY-0000W5-74
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:49:33 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1vjHXU-0006r3-J5
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 08:49:29 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 373B45BCD4;
 Fri, 23 Jan 2026 13:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769176159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0r4urskwgU6ZULrRWh2a1kwo4IgLlfRVUh0cFr6iRqc=;
 b=ke++E27m+lTJCDDxDuj3nSN6S9KB+6w2qbOqiHqNxwl3bKKxAYObSEvgynEj5oFWh1rqxo
 ps9YHor6mdBvX4R6Qvs43H2esUxC2h/4ZLHPxk/p/5kl8hgbKiTOmsE9kZEcp4q6qpCyC1
 2lUY3bAmDaAM+q2MhvjHP+Uk4Dhb2/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769176159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0r4urskwgU6ZULrRWh2a1kwo4IgLlfRVUh0cFr6iRqc=;
 b=uO6zqziUqEf3tuckPyxKPbEwMpxn8Y9b7685nYoRcVJiq5Z/ejeUOyqA0Sb3ksW/IGYoXz
 ZogG0QHH+/cfHoDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769176159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0r4urskwgU6ZULrRWh2a1kwo4IgLlfRVUh0cFr6iRqc=;
 b=ke++E27m+lTJCDDxDuj3nSN6S9KB+6w2qbOqiHqNxwl3bKKxAYObSEvgynEj5oFWh1rqxo
 ps9YHor6mdBvX4R6Qvs43H2esUxC2h/4ZLHPxk/p/5kl8hgbKiTOmsE9kZEcp4q6qpCyC1
 2lUY3bAmDaAM+q2MhvjHP+Uk4Dhb2/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769176159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0r4urskwgU6ZULrRWh2a1kwo4IgLlfRVUh0cFr6iRqc=;
 b=uO6zqziUqEf3tuckPyxKPbEwMpxn8Y9b7685nYoRcVJiq5Z/ejeUOyqA0Sb3ksW/IGYoXz
 ZogG0QHH+/cfHoDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D66A1395E;
 Fri, 23 Jan 2026 13:49:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rkpjF158c2mxfwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 23 Jan 2026 13:49:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, Lukas Straub <lukasstraub2@web.de>,
 Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH 06/10] migration/colo: Remove call to send switchover
 start event
In-Reply-To: <20260121223336.3381912-7-peterx@redhat.com>
References: <20260121223336.3381912-1-peterx@redhat.com>
 <20260121223336.3381912-7-peterx@redhat.com>
Date: Fri, 23 Jan 2026 10:49:15 -0300
Message-ID: <87a4y4igmc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_ENVRCPT(0.00)[web.de]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> COLO (in case of periodically checkpointing) already have switchover
> happened before hand.  This switchover_start feature never applies to COLO.
> Remove it.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/colo.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/migration/colo.c b/migration/colo.c
> index e05736ecf0..c344943173 100644
> --- a/migration/colo.c
> +++ b/migration/colo.c
> @@ -453,8 +453,6 @@ static int colo_do_checkpoint_transaction(MigrationState *s,
>          goto out;
>      }
>  
> -    qemu_savevm_maybe_send_switchover_start(s->to_dst_file);
> -
>      /* Note: device state is saved into buffer */
>      ret = qemu_save_device_state(fb);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

