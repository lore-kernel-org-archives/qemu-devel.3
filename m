Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FC07CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 14:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3EpR-0005bs-G6; Mon, 29 Sep 2025 10:26:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3EpG-0005ZC-TT
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:26:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1v3Eoz-0004hS-Hm
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 10:26:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 585122CB31;
 Mon, 29 Sep 2025 14:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759155925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WAUMwNE6qFQeP30EMx8HQdFNRd7Nc9eQrVCaCdOfD4=;
 b=ycsn0vv6J4fhYMt5JSCZv/119MsoEx3lrCiYk8YKohBVnHPllZJ/UeeWaBOnN0mlEIC30+
 BR58txw9cK538nPRJIFqBaysOidIdSe8EsigHbx5a5gihC7exoeFpkEPPvjxA0dhM09QQb
 jaZX7ecdOdB3KFhT9M5k4LdybGPGrlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759155925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WAUMwNE6qFQeP30EMx8HQdFNRd7Nc9eQrVCaCdOfD4=;
 b=O9SW8S9eTDXQQwSg+TnmvHukk/nc2Xpc9FIPPeSfkltrn2gBos2d6wyGF+8d9HAsE9+JFE
 TkSDwyGPBR3oylDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1759155925; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WAUMwNE6qFQeP30EMx8HQdFNRd7Nc9eQrVCaCdOfD4=;
 b=ycsn0vv6J4fhYMt5JSCZv/119MsoEx3lrCiYk8YKohBVnHPllZJ/UeeWaBOnN0mlEIC30+
 BR58txw9cK538nPRJIFqBaysOidIdSe8EsigHbx5a5gihC7exoeFpkEPPvjxA0dhM09QQb
 jaZX7ecdOdB3KFhT9M5k4LdybGPGrlY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1759155925;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WAUMwNE6qFQeP30EMx8HQdFNRd7Nc9eQrVCaCdOfD4=;
 b=O9SW8S9eTDXQQwSg+TnmvHukk/nc2Xpc9FIPPeSfkltrn2gBos2d6wyGF+8d9HAsE9+JFE
 TkSDwyGPBR3oylDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4ACA13A21;
 Mon, 29 Sep 2025 14:25:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RC1xINSW2miVLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Sep 2025 14:25:24 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Bin Guo <guobin@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com
Subject: Re: [PATCH] migration: HMP: Adjust the order of output fields
In-Reply-To: <20250929021213.28369-1-guobin@linux.alibaba.com>
References: <20250929021213.28369-1-guobin@linux.alibaba.com>
Date: Mon, 29 Sep 2025 11:25:22 -0300
Message-ID: <87cy79wd2l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.28 / 50.00]; BAYES_HAM(-2.98)[99.93%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Bin Guo <guobin@linux.alibaba.com> writes:

> Adjust the positions of 'tls-authz' and 'max-postcopy-bandwidth' in
> the fields output by the 'info migrate_parameters' command so that
> related fields are next to each other.
>
> For clarity only, no functional changes.
>
> Sample output after this commit:
> (qemu) info migrate_parameters
> ...
> max-cpu-throttle: 99
> tls-creds: ''
> tls-hostname: ''
> tls-authz: ''
> max-bandwidth: 134217728 bytes/second
> avail-switchover-bandwidth: 0 bytes/second
> max-postcopy-bandwidth: 0 bytes/second
> downtime-limit: 300 ms
> ...
>
> Signed-off-by: Bin Guo <guobin@linux.alibaba.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

