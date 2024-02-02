Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B3DC4828E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Feb 2024 19:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVz0T-0005xH-Nr; Fri, 02 Feb 2024 14:15:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVz0R-0005wf-6L
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:15:19 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rVz0H-0002RE-Bo
 for qemu-devel@nongnu.org; Fri, 02 Feb 2024 14:15:18 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F0B40221D0;
 Fri,  2 Feb 2024 19:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N75eoEnTRmF//dJPydXmE18zktSZO/AXzr+jWG3TFP8=;
 b=hYepnJGYMZmig2XX0OvCAqmKG+uObvt0L3Qzt1//XaThPlpZq+Ko0CYsg+JmyhL3QdD2zE
 B2YlU+KKq24krd8kHFitV2mS0R9ZOtkR0PiB7Y+575JkvFrevTvzdqVvsQn9QrRagfPQhz
 ALrBd34kxwm2nW+WvF9RTO/E/IXtiK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901308;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N75eoEnTRmF//dJPydXmE18zktSZO/AXzr+jWG3TFP8=;
 b=1yGJiSOcle6daMDW3GdvM1ZtkTJTsvmPsHbVqONoub3T7VHIGJY0KHlsoV5Y9lDZWsh49R
 QxEcNdLOoAW8ydCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706901307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N75eoEnTRmF//dJPydXmE18zktSZO/AXzr+jWG3TFP8=;
 b=XGGttzv3nGWU9S0VETHOvv5aTBaAidQVJsjcpBnCZ4764TioyDYNVUGyFP7+NmGtD223Uw
 zD616Vo2afRCKCu001o+HfzwIngv+Xa9jJutyakTEMxnyE61+NXmAxI6RuiroivOo6xsO9
 4WNUPlYmL26M+rfnSnVAs0JDnk3EkKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706901307;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N75eoEnTRmF//dJPydXmE18zktSZO/AXzr+jWG3TFP8=;
 b=3vOWbxc2l6QQ1XmX3bSWTZgpa8t3Ty6wLoauQrBY5kPmJx+4aWRZBntW/FwR9bDoXLe1Lt
 LbSU/6SxqMsogOAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 79502139AB;
 Fri,  2 Feb 2024 19:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +kMgEDs/vWVuZQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 02 Feb 2024 19:15:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Hao Xiang <hao.xiang@bytedance.com>, Bryan Zhang
 <bryan.zhang@bytedance.com>, peterx@redhat.com, Avihai Horon
 <avihaih@nvidia.com>, Yuan Liu <yuan1.liu@intel.com>, Prasad Pandit
 <ppandit@redhat.com>
Subject: Re: [PATCH v2 03/23] migration/multifd: Drop
 MultiFDSendParams.quit, cleanup error paths
In-Reply-To: <20240202102857.110210-4-peterx@redhat.com>
References: <20240202102857.110210-1-peterx@redhat.com>
 <20240202102857.110210-4-peterx@redhat.com>
Date: Fri, 02 Feb 2024 16:15:04 -0300
Message-ID: <87wmrmhe4n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XGGttzv3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3vOWbxc2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.14 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-0.63)[82.32%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: F0B40221D0
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> Multifd send side has two fields to indicate error quits:
>
>   - MultiFDSendParams.quit
>   - &multifd_send_state->exiting
>
> Merge them into the global one.  The replacement is done by changing all
> p->quit checks into the global var check.  The global check doesn't need
> any lock.
>
> A few more things done on top of this altogether:
>
>   - multifd_send_terminate_threads()
>
>     Moving the xchg() of &multifd_send_state->exiting upper, so as to cover
>     the tracepoint, migrate_set_error() and migrate_set_state().
>
>   - multifd_send_sync_main()
>
>     In the 2nd loop, add one more check over the global var to make sure we
>     don't keep the looping if QEMU already decided to quit.
>
>   - multifd_tls_outgoing_handshake()
>
>     Use multifd_send_terminate_threads() to set the error state.  That has
>     a benefit of updating MigrationState.error to that error too, so we can
>     persist that 1st error we hit in that specific channel.
>
>   - multifd_new_send_channel_async()
>
>     Take similar approach like above, drop the migrate_set_error() because
>     multifd_send_terminate_threads() already covers that.  Unwrap the helper
>     multifd_new_send_channel_cleanup() along the way; not really needed.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

