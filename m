Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5A8C54F52
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonjI-0000s2-Gr; Tue, 28 Jul 2026 15:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wonjE-0000rX-9k
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:44:40 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wonjC-0005jo-Na
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:44:40 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 791333E08;
 Tue, 28 Jul 2026 19:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785267872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWFEqYBzV6vSmyx5QuCiJrafX/4t8frvImO28PzBlEk=;
 b=fnekiyhtxfTx0h7gig4w8Fl/9enNJUItdz7xLGOOhiFiA6NcHksXm8n4nsxIhbxZwY9IC7
 SYxywdq9uCUnSGYjMpxZSLk6o9z8ElbcpDn8BiSZzwW4b381fNsHo6lgWljMi+wKVuH2Uo
 pjAcwiKKATGvV0+Cpk5CEN0G/ay6sHI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785267872;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWFEqYBzV6vSmyx5QuCiJrafX/4t8frvImO28PzBlEk=;
 b=udh5p59oVlxYE+cPW+olFrQl6/V0Ya57/5ePsisNBdGEjxfdly1NRZRr2wM+Fd1Ogp5TXX
 /kLM3tmH9xljC6CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="dnzO9F6/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RiBPDGJF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785267868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWFEqYBzV6vSmyx5QuCiJrafX/4t8frvImO28PzBlEk=;
 b=dnzO9F6/OP5GFb6aQR5l7+OVbwA4diddTZrUP0wjdGKaC9VmKWAhZmI7f8ncKMw+jf9l8k
 BP9ovjwzA0/lL2soLk/D8J9csgvBHrnGoWiLIF0P4Q8R41HvyE9AnXm1O6jE1fhBVf5rgh
 n4yuUPGeTfuY0UQNG/JYi3XRrXwiIB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785267868;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yWFEqYBzV6vSmyx5QuCiJrafX/4t8frvImO28PzBlEk=;
 b=RiBPDGJFtePTm5g3p54ftyHDrJvk3KBfS0MELUGFMPOuM4BOQrvE6viJ4ORlT6mf59JtL9
 JWKhLJIMU24D5LCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11758779B1;
 Tue, 28 Jul 2026 19:44:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qWG5NJsGaWqDQwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jul 2026 19:44:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juraj Marcin <jmarcin@redhat.com>, xlabai
 <xlabai@tencent.com>, Jules Denardou <jules.denardou@datadoghq.com>,
 Tristan Madani <tristan@talencesecurity.com>, qemu-stable
 <qemu-stable@nongnu.org>
Subject: Re: [PATCH 2/5] migration/multifd: Validate next_packet_size in
 zlib/zstd recv
In-Reply-To: <20260728155247.1894355-3-peterx@redhat.com>
References: <20260728155247.1894355-1-peterx@redhat.com>
 <20260728155247.1894355-3-peterx@redhat.com>
Date: Tue, 28 Jul 2026 16:44:21 -0300
Message-ID: <87wlueoq5m.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 791333E08
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nongnu.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:email,suse.de:dkim,gitlab.com:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Peter Xu <peterx@redhat.com> writes:

> The zlib and zstd multifd compression backends read next_packet_size from
> the incoming migration stream and use it directly as the read length into a
> fixed-size buffer (MULTIFD_PACKET_SIZE * 2 = 1MB).  A malicious migration
> source can set next_packet_size bigger than allocated, causing a heap
> buffer overflow write on the destination.
>
> Add a check against zbuff_len before reading, matching what the qatzip
> backend already does.  Also replace the assert(in_size == 0) for empty
> packets with proper error reporting, since the value is wire-controlled,
> meanwhile assert() stops working with release builds.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3737
> Reported-by: xlabai <xlabai@tencent.com>
> Reported-by: Jules Denardou <jules.denardou@datadoghq.com>
> Reported-by: Tristan Madani <tristan@talencesecurity.com>
> Reported-by: david korczynski (@david1766)
> Reported-by: huntr bubble (@bubblehuntr)
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Cc: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

