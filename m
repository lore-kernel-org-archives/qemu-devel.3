Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86929C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 14:03:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH15T-0003TZ-65; Mon, 19 May 2025 10:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uH15O-0003Rl-V7
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:03:25 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1uH15J-0001vg-3W
 for qemu-devel@nongnu.org; Mon, 19 May 2025 10:03:18 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4EE26203CC;
 Mon, 19 May 2025 14:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747663395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dHu1e6ToqGFR1VKH35bRuT9Vz0Veib08Tsw98JTKDBM=;
 b=WH/JMilh1CjjJQVyM2+nknlSaVFMr+cFQ+Vv7dFXZYfB2k9Nb5f4ypo8reTRwjLB+L/WmH
 BczByBejodGnFMfiLn603IhsBxqQMHWYHJf99/QrBaYfh9tkxJGQ5b3+tsjs24ICyXSszT
 DrF+wnliq+0NpmY1dA9SgEtVbZc5LaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747663395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dHu1e6ToqGFR1VKH35bRuT9Vz0Veib08Tsw98JTKDBM=;
 b=5AekD3BMCYikF183kJMpMFVDksb9eveG/WpDXGHgfAqDxDfCGXb05BWluvdWdDjGjNs4I4
 H3HLoYo45Vgac5Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1747663395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dHu1e6ToqGFR1VKH35bRuT9Vz0Veib08Tsw98JTKDBM=;
 b=WH/JMilh1CjjJQVyM2+nknlSaVFMr+cFQ+Vv7dFXZYfB2k9Nb5f4ypo8reTRwjLB+L/WmH
 BczByBejodGnFMfiLn603IhsBxqQMHWYHJf99/QrBaYfh9tkxJGQ5b3+tsjs24ICyXSszT
 DrF+wnliq+0NpmY1dA9SgEtVbZc5LaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1747663395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dHu1e6ToqGFR1VKH35bRuT9Vz0Veib08Tsw98JTKDBM=;
 b=5AekD3BMCYikF183kJMpMFVDksb9eveG/WpDXGHgfAqDxDfCGXb05BWluvdWdDjGjNs4I4
 H3HLoYo45Vgac5Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC7A813A30;
 Mon, 19 May 2025 14:03:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n+wNGiI6K2jfMQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 19 May 2025 14:03:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org, Kevin Wolf
 <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Bernhard Beschow <shentey@gmail.com>, Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 04/22] tests/qtest/xhci: Add controller and device
 setup and ring tests
In-Reply-To: <20250502033047.102465-5-npiggin@gmail.com>
References: <20250502033047.102465-1-npiggin@gmail.com>
 <20250502033047.102465-5-npiggin@gmail.com>
Date: Mon, 19 May 2025 11:03:11 -0300
Message-ID: <87zff87l5s.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [0.20 / 50.00]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[12]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,redhat.com];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,nongnu.org,redhat.com,philjordan.eu,linaro.org];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

Nicholas Piggin <npiggin@gmail.com> writes:

> Add tests which init the host controller registers to the point where
> command and event rings, irqs are operational. Enumerate ports and set
> up an attached device context that enables device transfer ring to be
> set up and tested.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

