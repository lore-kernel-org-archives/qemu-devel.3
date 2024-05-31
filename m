Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A84C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 15:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD4WQ-0006Lw-Ei; Fri, 31 May 2024 11:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD4WP-0006Lm-9C
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:50:25 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sD4WN-0003RX-IL
 for qemu-devel@nongnu.org; Fri, 31 May 2024 11:50:25 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C8D5E1FB8D;
 Fri, 31 May 2024 15:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717170622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zbbDBWA/gSfoHlgR1rFvmlbtkn8ppbcrxxKuVbwp/L8=;
 b=y55I6v5uVoflagHlfiLjLaiHXtOVjZQUTAYwSJK9UCXmHTC+PP66WGayak8YdVFzTbjkCR
 Jw1EaMQ/TkWGSxxjG7amYz52VbTr9/3WLwRzkoTT8Bv6GzkwcAwFS/pZDsniw+JK6iUsEh
 4IjhJNi/zVbSZHxvvRRQl30423gpR6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717170622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zbbDBWA/gSfoHlgR1rFvmlbtkn8ppbcrxxKuVbwp/L8=;
 b=NTnOwQqWNq0ahvCuTpSD8edGKrP/dJpImTWUvVe1b67GMGFCCDQIWWVl6DWNqG+2wufGQ1
 BMmHCUZw6I8fTIDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ffoI4Yjm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=27fUM62y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1717170620; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zbbDBWA/gSfoHlgR1rFvmlbtkn8ppbcrxxKuVbwp/L8=;
 b=ffoI4YjmYUgJjQZhEZ7vWCUkdkO/EzTsxRLr7umpU4C7XULx0r8VYTP3U0v+3tASFVlU8V
 tlfDC+ZUfe/fspnTknwQmRbw+k/TS7V2WJTRPKcu0fKjSLKsyc+myKUcSLtIiok3J+MYRD
 QLHo7kuJQeO/bgVMLA1bJ1tEbN9Zp/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1717170620;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zbbDBWA/gSfoHlgR1rFvmlbtkn8ppbcrxxKuVbwp/L8=;
 b=27fUM62ytaJb+S8LRx8y5G1HZygfPQF+xejm1AORdqgp3tuuE+0XReVT/w98iTGmM0XDlx
 Dhbz1+TsaQnMDYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D6E5132C2;
 Fri, 31 May 2024 15:50:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pgS3BLzxWWZeEQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 31 May 2024 15:50:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 2/4] tests/qtest/migration-test: Enable test_mode_reboot
In-Reply-To: <20240530095408.31608-3-npiggin@gmail.com>
References: <20240530095408.31608-1-npiggin@gmail.com>
 <20240530095408.31608-3-npiggin@gmail.com>
Date: Fri, 31 May 2024 12:50:17 -0300
Message-ID: <87ed9ikmkm.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C8D5E1FB8D
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.43 / 50.00]; BAYES_HAM(-2.92)[99.65%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,nongnu.org];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
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

Nicholas Piggin <npiggin@gmail.com> writes:

> Fabiano pointed out this test probably is not flaky, just that it could
> not run under Gitlab CI due to very small shm filesystem size in that
> environment.
>
> Now that it has moved to use /tmp instead of /dev/shm files, enable it.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

