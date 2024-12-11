Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08029E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 20:25:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLTGp-0003F0-NR; Wed, 11 Dec 2024 15:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLTGo-0003Eb-2m
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:25:18 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tLTGm-00058V-Gh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 15:25:17 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DB581F38E;
 Wed, 11 Dec 2024 20:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733948713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dg0N0E4nAhfFtioca73H+2DJZD2wGY9tMFsCxVJIc2E=;
 b=L03dn5kY49BnEgXKbMIwEH4dofJ7Yk1f5zqKGp4mN6Ycxzd+Nq/hpJNk2N8+SFiFJtkXLQ
 IpuFwD93Uxfs9FqalNLqfZiURVyu4jgEcy6kiNWisTI8C/2BBu14+m5Zm0W8q4mVtCFu41
 kEPebomWLfpQm9m+j7MQWSnbg67GqsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733948713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dg0N0E4nAhfFtioca73H+2DJZD2wGY9tMFsCxVJIc2E=;
 b=onxZNoro1U7hBXwVEje/X89LkQZ7TcxH5ywYA783XyYcYDVGTpXQjI6sQiM/L3k3g6xqJl
 Bb1Pp/ghgIScOqAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733948713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dg0N0E4nAhfFtioca73H+2DJZD2wGY9tMFsCxVJIc2E=;
 b=L03dn5kY49BnEgXKbMIwEH4dofJ7Yk1f5zqKGp4mN6Ycxzd+Nq/hpJNk2N8+SFiFJtkXLQ
 IpuFwD93Uxfs9FqalNLqfZiURVyu4jgEcy6kiNWisTI8C/2BBu14+m5Zm0W8q4mVtCFu41
 kEPebomWLfpQm9m+j7MQWSnbg67GqsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733948713;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dg0N0E4nAhfFtioca73H+2DJZD2wGY9tMFsCxVJIc2E=;
 b=onxZNoro1U7hBXwVEje/X89LkQZ7TcxH5ywYA783XyYcYDVGTpXQjI6sQiM/L3k3g6xqJl
 Bb1Pp/ghgIScOqAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8FF4013927;
 Wed, 11 Dec 2024 20:25:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dM6JFSj1WWdPHQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 11 Dec 2024 20:25:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, peterx@redhat.com, Paolo Bonzini
 <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH 0/3] scripts/qemu-gdb: Make coroutine dumps to work with
 coredumps
In-Reply-To: <20241211201739.1380222-1-peterx@redhat.com>
References: <20241211201739.1380222-1-peterx@redhat.com>
Date: Wed, 11 Dec 2024 17:25:10 -0300
Message-ID: <87pllyezmh.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.87 / 50.00]; BAYES_HAM(-1.57)[92.21%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[8]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
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

Peter Xu <peterx@redhat.com> writes:

> Coroutines are used in many cases in block layers. It's also used in live
> migration when on destination side, and it'll be handy to diagnose crashes
> within a coroutine when we want to also know what other coroutines are
> doing.

Not sure if you've seen this message on the list:

https://lore.kernel.org/r/f0ebccca-7a17-4da8-ac4a-71cf6d69abc3@mtasv.net


