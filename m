Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9986CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Aug 2025 21:53:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur1b1-0000a1-Jh; Tue, 26 Aug 2025 17:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ur1ax-0000Z9-PW
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 17:52:47 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1ur1au-0004k4-I3
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 17:52:46 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 11D0721266;
 Tue, 26 Aug 2025 21:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756245159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CwPIdL0NWwvEkieq0eu1e0ds0YFIVTFLsbJMqK780Ng=;
 b=uJKPSDrcA4IpOPO6Ld2XI9Mxix8kvFzFQRTRYi/4XmHx9B16ESRTn1pg6VoqGIrOvXC4XQ
 kzshuly9d3VDORcYXc5H+NcnnxOgp/k9Wuoa/AcuFyv0Sr26g4MmWgxeB0tSZrj7xHJCDM
 gBeD3DEER357n+JF3N9+RWyVo5f/AFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756245159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CwPIdL0NWwvEkieq0eu1e0ds0YFIVTFLsbJMqK780Ng=;
 b=Dq++VEeIcmuFW+cKKklYQBOGhNaysWQSt8cjWX7Oogj4W4BHTP/U+GYYPyFlFuVZ/R8HcT
 8iY7NxC+7YPoc0BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=uJKPSDrc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Dq++VEeI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1756245159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CwPIdL0NWwvEkieq0eu1e0ds0YFIVTFLsbJMqK780Ng=;
 b=uJKPSDrcA4IpOPO6Ld2XI9Mxix8kvFzFQRTRYi/4XmHx9B16ESRTn1pg6VoqGIrOvXC4XQ
 kzshuly9d3VDORcYXc5H+NcnnxOgp/k9Wuoa/AcuFyv0Sr26g4MmWgxeB0tSZrj7xHJCDM
 gBeD3DEER357n+JF3N9+RWyVo5f/AFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1756245159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CwPIdL0NWwvEkieq0eu1e0ds0YFIVTFLsbJMqK780Ng=;
 b=Dq++VEeIcmuFW+cKKklYQBOGhNaysWQSt8cjWX7Oogj4W4BHTP/U+GYYPyFlFuVZ/R8HcT
 8iY7NxC+7YPoc0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80EF813479;
 Tue, 26 Aug 2025 21:52:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N1hwEKYsrmjNTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 26 Aug 2025 21:52:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Marco.Cavenati@eurecom.fr, mjt@tls.msk.ru, peterx@redhat.com,
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: Re: [PATCH] migration: fix SEEK_CUR offset calculation in
 qio_channel_block_seek
In-Reply-To: <dc23eaca-15f5-40be-89d0-2247cfe1f716@tls.msk.ru>
References: <871pudmlmj.fsf@suse.de>
 <dc23eaca-15f5-40be-89d0-2247cfe1f716@tls.msk.ru>
Date: Tue, 26 Aug 2025 18:52:35 -0300
Message-ID: <87plchkaxo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 11D0721266
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
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

Michael Tokarev <mjt@tls.msk.ru> writes:

+CC Akihiko

> Hi!
>
> This is
>
> commit c0b32426ce56182c1ce2a12904f3a702c2ecc460
> Author: Marco Cavenati <Marco.Cavenati@eurecom.fr>
> Date:   Wed Mar 26 17:22:30 2025 +0100
>
>      migration: fix SEEK_CUR offset calculation in qio_channel_block_seek
>
> which went to 10.0.0-rc2, and has been cherry-picked to
> 7.2 and 9.2 stable series.
>
> Reportedly it breaks migration in 7.2.18 and up.  Which is
> kinda strange, as it shouldn't do any harm?
>

Yeah, this is not it. Unless you're using colo or mapped-ram.

> https://bugs.debian.org/1112044
>
> any guess what's going on?
>

The virtio changes are probably the issue. One of them touches
mhdr.num_buffers, under mergeable_rx_bufs, which is migrated state. The
flag in turn depends on VIRTIO_NET_F_MRG_RXBUF, which is set on the
cmdline with -device virtio-net-pci,mrg_rxbuf= but also reset by
virtio_set_features_nocheck, if I'm reading this right.

Let's ask Akihiko.

> Thanks,
>
> /mjt

