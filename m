Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC65C54E49
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 11:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riCDY-0003fj-Ij; Thu, 07 Mar 2024 06:47:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1riCDW-0003ed-V4
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:47:18 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1riCDV-0007qL-4x
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 06:47:18 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A17EC4988;
 Thu,  7 Mar 2024 11:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709810666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eI8zwx0I/o3RkUEC8LW+WGeZz7baexBy3D709xDCkMA=;
 b=jQ+LDca36DK1CU68zz7HKarCWs6DIDupZhuU55z9rD3UuKzVrD/PvfgGtkj6ycEiHhEVpw
 QDZW7OHmdw1DZACjXd5PyPKWFmg/bJFBzEAtpNzE3HRgjJUnmVy+pJt9wNAcHnbl/7cG6R
 BXw4ZNCuUX8hcHATNJbUy/Vf7+7PQHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709810666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eI8zwx0I/o3RkUEC8LW+WGeZz7baexBy3D709xDCkMA=;
 b=zbUTkrdzs7Sn5LTPpIKCD6QLyudZsYNZt971BiOHTtBEOxVL/rIjl4nYKVItg4oA8sT+Li
 pZIU3AfdpDHLedDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709810666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eI8zwx0I/o3RkUEC8LW+WGeZz7baexBy3D709xDCkMA=;
 b=jQ+LDca36DK1CU68zz7HKarCWs6DIDupZhuU55z9rD3UuKzVrD/PvfgGtkj6ycEiHhEVpw
 QDZW7OHmdw1DZACjXd5PyPKWFmg/bJFBzEAtpNzE3HRgjJUnmVy+pJt9wNAcHnbl/7cG6R
 BXw4ZNCuUX8hcHATNJbUy/Vf7+7PQHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709810666;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eI8zwx0I/o3RkUEC8LW+WGeZz7baexBy3D709xDCkMA=;
 b=zbUTkrdzs7Sn5LTPpIKCD6QLyudZsYNZt971BiOHTtBEOxVL/rIjl4nYKVItg4oA8sT+Li
 pZIU3AfdpDHLedDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2C03712FC5;
 Thu,  7 Mar 2024 11:24:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KhcHOemj6WXpNgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 07 Mar 2024 11:24:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, berrange@redhat.com
Subject: Re: [PATCH v2] migration/multifd: Don't fsync when closing
 QIOChannelFile
In-Reply-To: <ZekG-fTq51VRJFz1@x1n>
References: <20240305195629.9922-1-farosas@suse.de> <ZekG-fTq51VRJFz1@x1n>
Date: Thu, 07 Mar 2024 08:24:23 -0300
Message-ID: <87wmqeqo7s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

> On Tue, Mar 05, 2024 at 04:56:29PM -0300, Fabiano Rosas wrote:
>> Commit bc38feddeb ("io: fsync before closing a file channel") added a
>> fsync/fdatasync at the closing point of the QIOChannelFile to ensure
>> integrity of the migration stream in case of QEMU crash.
>>=20
>> The decision to do the sync at qio_channel_close() was not the best
>> since that function runs in the main thread and the fsync can cause
>> QEMU to hang for several minutes, depending on the migration size and
>> disk speed.
>>=20
>> To fix the hang, remove the fsync from qio_channel_file_close().
>>=20
>> At this moment, the migration code is the only user of the fsync and
>> we're taking the tradeoff of not having a sync at all, leaving the
>> responsibility to the upper layers.
>>=20
>> Fixes: bc38feddeb ("io: fsync before closing a file channel")
>> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> Since 9.0 is reaching and it's important we avoid such hang, I queued this
> version.
>
> However to make sure we can still remember why we do this after a few
> years, I added a rich comment and will squash into this patch:
>
> =3D=3D=3D=3D=3D=3D=3D
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 0a8fef046b..bf9d483f7a 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -714,6 +714,22 @@ static bool multifd_send_cleanup_channel(MultiFDSend=
Params *p, Error **errp)
>           * released because finalize() of the iochannel is only
>           * triggered on the last reference and it's not guaranteed
>           * that we always hold the last refcount when reaching here.
> +         *
> +         * Closing the fd explicitly has the benefit that if there is any
> +         * registered I/O handler callbacks on such fd, that will get a
> +         * POLLNVAL event and will further trigger the cleanup to finally
> +         * release the IOC.
> +         *
> +         * FIXME: It should logically be guaranteed that all multifd
> +         * channels have no I/O handler callback registered when reaching
> +         * here, because migration thread will wait for all multifd chan=
nel
> +         * establishments to complete during setup.  Since
> +         * migrate_fd_cleanup() will be scheduled in main thread too, all
> +         * previous callbacks should guarantee to be completed when
> +         * reaching here.  See multifd_send_state.channels_created and i=
ts
> +         * usage.  In the future, we could replace this with an assert
> +         * making sure we're the last reference, or simply drop it if ab=
ove
> +         * is more clear to be justified.
>           */
>          qio_channel_close(p->c, &error_abort);
>          object_unref(OBJECT(p->c));
>
> =3D=3D=3D=3D=3D=3D=3D=3D

Ack. Thanks Peter!

