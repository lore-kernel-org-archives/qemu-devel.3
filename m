Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1328BCAC598
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Sep 2025 18:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uywvF-0001hy-Sl; Wed, 17 Sep 2025 14:30:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uywvD-0001hU-UJ
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:30:27 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uywvB-0005A5-JW
 for qemu-devel@nongnu.org; Wed, 17 Sep 2025 14:30:27 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B80DD22988;
 Wed, 17 Sep 2025 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758133822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EpFcAs9Zgj5GEjUMNOkWwag0QA8fOehiaVLlDB+VcyQ=;
 b=kI5tMONmKZBCiEBTCZghqGiWuTctxFOAZbC/vcM9ny1DYJtI2YLI2v7h12Nm7qgPrc775v
 Ke2t2BUvKLOhO8Cur4mCkf2I0WYmUE3igm4FFNVjTfC4Xy+WN+xqJXVtrCwBGUoOoCNUm8
 XSLSS4cIROAY5w9EGQBO71hDyr+tEUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758133822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EpFcAs9Zgj5GEjUMNOkWwag0QA8fOehiaVLlDB+VcyQ=;
 b=+no5LsgJHnvFw9OunJuXp0xcAa9bcYjPMqkPDcEb/bECfsNmhHgok2gGrDq5WED/iDZmdW
 RLFBjPPiqYuXbZCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758133822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EpFcAs9Zgj5GEjUMNOkWwag0QA8fOehiaVLlDB+VcyQ=;
 b=kI5tMONmKZBCiEBTCZghqGiWuTctxFOAZbC/vcM9ny1DYJtI2YLI2v7h12Nm7qgPrc775v
 Ke2t2BUvKLOhO8Cur4mCkf2I0WYmUE3igm4FFNVjTfC4Xy+WN+xqJXVtrCwBGUoOoCNUm8
 XSLSS4cIROAY5w9EGQBO71hDyr+tEUc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758133822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EpFcAs9Zgj5GEjUMNOkWwag0QA8fOehiaVLlDB+VcyQ=;
 b=+no5LsgJHnvFw9OunJuXp0xcAa9bcYjPMqkPDcEb/bECfsNmhHgok2gGrDq5WED/iDZmdW
 RLFBjPPiqYuXbZCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25C681368D;
 Wed, 17 Sep 2025 18:30:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2w/jND3+ymjfVAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Sep 2025 18:30:21 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>, peterx@redhat.com, Kevin
 Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?D?=
 =?utf-8?Q?aniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, Hailiang Zhang
 <zhanghailiang@xfusion.com>, Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Prasad Pandit
 <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 7/9] migration/postcopy: Remove workaround on wait
 preempt channel
In-Reply-To: <20250827205949.364606-8-peterx@redhat.com>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-8-peterx@redhat.com>
Date: Wed, 17 Sep 2025 15:30:19 -0300
Message-ID: <87cy7pvsn8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[14]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[treblig.org,redhat.com,xfusion.com,yandex-team.ru,gmail.com,fujitsu.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:mid,
 suse.de:email]
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

> This reverts commit 7afbdada7effbc2b97281bfbce0c6df351a3cf88.
>
> Now after switching to a thread in loadvm process, the main thread should
> be able to accept() even if loading the package could cause a page fault in
> userfaultfd path.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/savevm.c | 21 ---------------------
>  1 file changed, 21 deletions(-)
>
> diff --git a/migration/savevm.c b/migration/savevm.c
> index ad606c5425..8018f7ad31 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2425,27 +2425,6 @@ static int loadvm_handle_cmd_packaged(MigrationIncomingState *mis,
>  
>      QEMUFile *packf = qemu_file_new_input(QIO_CHANNEL(bioc));
>  
> -    /*
> -     * Before loading the guest states, ensure that the preempt channel has
> -     * been ready to use, as some of the states (e.g. via virtio_load) might
> -     * trigger page faults that will be handled through the preempt channel.
> -     * So yield to the main thread in the case that the channel create event
> -     * hasn't been dispatched.
> -     *
> -     * TODO: if we can move migration loadvm out of main thread, then we
> -     * won't block main thread from polling the accept() fds.  We can drop
> -     * this as a whole when that is done.
> -     */
> -    do {
> -        if (!migrate_postcopy_preempt() || !qemu_in_coroutine() ||
> -            mis->postcopy_qemufile_dst) {
> -            break;
> -        }
> -
> -        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
> -        qemu_coroutine_yield();
> -    } while (1);
> -
>      ret = qemu_loadvm_state_main(packf, mis, bql_held);
>      trace_loadvm_handle_cmd_packaged_main(ret);
>      qemu_fclose(packf);

Reviewed-by: Fabiano Rosas <farosas@suse.de>

