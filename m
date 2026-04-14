Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97334F9D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 15:24:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCfcN-0004oQ-WF; Tue, 14 Apr 2026 11:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCfcK-0004mc-OW
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:23:56 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wCfcI-0006xn-H7
 for qemu-devel@nongnu.org; Tue, 14 Apr 2026 11:23:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0ACB85BDDD;
 Tue, 14 Apr 2026 15:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776180228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T7wtADE6OeE/5YWaYe0Vez8bTXJfEehbwOqY/kRmIrU=;
 b=pJAtMeHwm2qEK4H+eNn5kW1wahiukK+I41d4KLbOPkc+r98/2VQ2u7HDnCCnyzxEsGAlu6
 v3U1EvjO2dp02QNf/Roz6JhprbCKnkBheQ0HHbH4oC6tSr1TTsIYpVCcUgm/h3gvMOmYyF
 bkWn0gZDTEOY/a5Gbkds2l7lIzeuHqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776180228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T7wtADE6OeE/5YWaYe0Vez8bTXJfEehbwOqY/kRmIrU=;
 b=lKhYCgc+EMlipNHLYzEfLqaBjkBsgwZ6VolGQDlHBYW+WclIo1TAji4K62Z3scx3VAx/Jl
 tNvDOCUjEElpI/Cw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776180228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T7wtADE6OeE/5YWaYe0Vez8bTXJfEehbwOqY/kRmIrU=;
 b=pJAtMeHwm2qEK4H+eNn5kW1wahiukK+I41d4KLbOPkc+r98/2VQ2u7HDnCCnyzxEsGAlu6
 v3U1EvjO2dp02QNf/Roz6JhprbCKnkBheQ0HHbH4oC6tSr1TTsIYpVCcUgm/h3gvMOmYyF
 bkWn0gZDTEOY/a5Gbkds2l7lIzeuHqw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776180228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T7wtADE6OeE/5YWaYe0Vez8bTXJfEehbwOqY/kRmIrU=;
 b=lKhYCgc+EMlipNHLYzEfLqaBjkBsgwZ6VolGQDlHBYW+WclIo1TAji4K62Z3scx3VAx/Jl
 tNvDOCUjEElpI/Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EC554B4F2;
 Tue, 14 Apr 2026 15:23:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yj/MGwNc3mnUNAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 14 Apr 2026 15:23:47 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>, Peter Xu
 <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH 00/11] vmstate: Implement VMS_ARRAY_OF_POINTER_AUTO_ALLOC
In-Reply-To: <CAJqdLrr9yyxr29U53NpFhghn7Nycd5LkA8U7eLSb9tjz3Huppw@mail.gmail.com>
References: <20260401202844.673494-1-peterx@redhat.com>
 <CAJqdLrr9yyxr29U53NpFhghn7Nycd5LkA8U7eLSb9tjz3Huppw@mail.gmail.com>
Date: Tue, 14 Apr 2026 12:23:45 -0300
Message-ID: <87jyu9zhtq.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.28 / 50.00]; BAYES_HAM(-2.98)[99.93%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Alexander Mikhalitsyn <alexander@mihalicyn.com> writes:

> Dear friends,
>
> when I can expect this to be landed in master? I would like to prepare
> and send next version of my
> NVMe live migration patchset, that's why I'm asking.
>

I intend to send a pull request as soon as the release happens and the
next development cycle opens.  Probably by the end of this week, unless
we need to have another -rc.


