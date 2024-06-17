Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B7AC27C79
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 19:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJIKi-0006rV-2h; Mon, 17 Jun 2024 15:48:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJIKg-0006rG-Rq
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:48:02 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sJIKf-0005Kc-56
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 15:48:02 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DA5671F385;
 Mon, 17 Jun 2024 19:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718653679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VW8yAyXTGiKHGRAraMLg6IfiWIENOQZxPU7gEuzHbQg=;
 b=OQAgUws80d2a7fsX2JUl75fjDnIMPH7/9Cd8fw2HgsZ3qOsucCGfdJizmHb5hVK7+gLQq7
 G3mNeVmby5DC/kqXTAu2Zb2UOnT1DE1cQSPBa20H26/TWivuFP+e0ff0Ozwq/+qTHo8APC
 OG9chyBtK9G3+IsFXWOGSKMvdmx9CQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718653679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VW8yAyXTGiKHGRAraMLg6IfiWIENOQZxPU7gEuzHbQg=;
 b=hPX1F6o9YnfDNgA06mMHBqgQ/B8Gn0K9SFcG3Kg5CV5tvwOr+0/uEcd9sFx+uBgJ8M1Hai
 8CE1yM6pZEW5C3Dg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718653679; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VW8yAyXTGiKHGRAraMLg6IfiWIENOQZxPU7gEuzHbQg=;
 b=OQAgUws80d2a7fsX2JUl75fjDnIMPH7/9Cd8fw2HgsZ3qOsucCGfdJizmHb5hVK7+gLQq7
 G3mNeVmby5DC/kqXTAu2Zb2UOnT1DE1cQSPBa20H26/TWivuFP+e0ff0Ozwq/+qTHo8APC
 OG9chyBtK9G3+IsFXWOGSKMvdmx9CQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718653679;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VW8yAyXTGiKHGRAraMLg6IfiWIENOQZxPU7gEuzHbQg=;
 b=hPX1F6o9YnfDNgA06mMHBqgQ/B8Gn0K9SFcG3Kg5CV5tvwOr+0/uEcd9sFx+uBgJ8M1Hai
 8CE1yM6pZEW5C3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6101F13AAA;
 Mon, 17 Jun 2024 19:47:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id C6x4Cu+ScGbKNQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 17 Jun 2024 19:47:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Eric Blake <eblake@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com, Jiri Denemark
 <jdenemar@redhat.com>, Bandan Das <bdas@redhat.com>
Subject: Re: [PATCH v2 06/10] migration/docs: Update postcopy recover
 session for SETUP phase
In-Reply-To: <20240617181534.1425179-7-peterx@redhat.com>
References: <20240617181534.1425179-1-peterx@redhat.com>
 <20240617181534.1425179-7-peterx@redhat.com>
Date: Mon, 17 Jun 2024 16:47:56 -0300
Message-ID: <87frtbbbbn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Peter Xu <peterx@redhat.com> writes:

> Firstly, the "Paused" state was added in the wrong place before. The state
> machine section was describing PostcopyState, rather than MigrationStatus.
> Drop the Paused state descriptions.
>
> Then in the postcopy recover session, add more information on the state
> machine for MigrationStatus in the lines.  Add the new RECOVER_SETUP phase.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

> ---
>  docs/devel/migration/postcopy.rst | 31 ++++++++++++++++---------------
>  1 file changed, 16 insertions(+), 15 deletions(-)
>
> diff --git a/docs/devel/migration/postcopy.rst b/docs/devel/migration/postcopy.rst
> index 6c51e96d79..a15594e11f 100644
> --- a/docs/devel/migration/postcopy.rst
> +++ b/docs/devel/migration/postcopy.rst
> @@ -99,17 +99,6 @@ ADVISE->DISCARD->LISTEN->RUNNING->END
>      (although it can't do the cleanup it would do as it
>      finishes a normal migration).
>  
> - - Paused
> -
> -    Postcopy can run into a paused state (normally on both sides when
> -    happens), where all threads will be temporarily halted mostly due to
> -    network errors.  When reaching paused state, migration will make sure
> -    the qemu binary on both sides maintain the data without corrupting
> -    the VM.  To continue the migration, the admin needs to fix the
> -    migration channel using the QMP command 'migrate-recover' on the
> -    destination node, then resume the migration using QMP command 'migrate'
> -    again on source node, with resume=true flag set.
> -
>   - End
>  
>      The listen thread can now quit, and perform the cleanup of migration
> @@ -221,7 +210,8 @@ paused postcopy migration.
>  
>  The recovery phase normally contains a few steps:
>  
> -  - When network issue occurs, both QEMU will go into PAUSED state
> +  - When network issue occurs, both QEMU will go into **POSTCOPY_PAUSED**
> +    migration state.
>  
>    - When the network is recovered (or a new network is provided), the admin
>      can setup the new channel for migration using QMP command
> @@ -229,9 +219,20 @@ The recovery phase normally contains a few steps:
>  
>    - On source host, the admin can continue the interrupted postcopy
>      migration using QMP command 'migrate' with resume=true flag set.
> -
> -  - After the connection is re-established, QEMU will continue the postcopy
> -    migration on both sides.
> +    Source QEMU will go into **POSTCOPY_RECOVER_SETUP** state trying to
> +    re-establish the channels.
> +
> +  - When both sides of QEMU successfully reconnects using a new or fixed up

s/reconnects/reconnect

I can touch it up when queueing

> +    channel, they will go into **POSTCOPY_RECOVER** state, some handshake
> +    procedure will be needed to properly synchronize the VM states between
> +    the two QEMUs to continue the postcopy migration.  For example, there
> +    can be pages sent right during the window when the network is
> +    interrupted, then the handshake will guarantee pages lost in-flight
> +    will be resent again.
> +
> +  - After a proper handshake synchronization, QEMU will continue the
> +    postcopy migration on both sides and go back to **POSTCOPY_ACTIVE**
> +    state.  Postcopy migration will continue.
>  
>  During a paused postcopy migration, the VM can logically still continue
>  running, and it will not be impacted from any page access to pages that

