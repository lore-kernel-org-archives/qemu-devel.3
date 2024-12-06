Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5BDE77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 14:19:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJZBL-0007Dm-R0; Fri, 06 Dec 2024 09:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJZBK-0007Ce-Gx
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:19:46 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tJZBJ-0007Kk-4T
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 09:19:46 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D36C2115D;
 Fri,  6 Dec 2024 14:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733494783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TPsCAjMJxN4MLxSM8E2wL6dpCwsP2ZJKlSWlZriEW0E=;
 b=YZc/hOQggcR1CoyrWJpdD4j8gxrOgE0l9l0iiEHR3S+INOwXBXkrUQIj1ZgTqDWMHib1Pp
 rsG20p/12MHTBm88dXOTZ5BKLVL81kotJ5CF79MC2xcSzGCbgMP5J6acXzJGCFwvTqSlCx
 jyYHAXGUqvLOUXqp13Wne+Ckiet1aV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733494783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TPsCAjMJxN4MLxSM8E2wL6dpCwsP2ZJKlSWlZriEW0E=;
 b=MkCc8uqpSo/l2tmH3D+TlKMaEM3uXLDQuz7Tzjn49ug1J3tJdp6gIkW4I9VjFmj2QN5kzJ
 rBelQ2eQSJp1TGCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733494783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TPsCAjMJxN4MLxSM8E2wL6dpCwsP2ZJKlSWlZriEW0E=;
 b=YZc/hOQggcR1CoyrWJpdD4j8gxrOgE0l9l0iiEHR3S+INOwXBXkrUQIj1ZgTqDWMHib1Pp
 rsG20p/12MHTBm88dXOTZ5BKLVL81kotJ5CF79MC2xcSzGCbgMP5J6acXzJGCFwvTqSlCx
 jyYHAXGUqvLOUXqp13Wne+Ckiet1aV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733494783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TPsCAjMJxN4MLxSM8E2wL6dpCwsP2ZJKlSWlZriEW0E=;
 b=MkCc8uqpSo/l2tmH3D+TlKMaEM3uXLDQuz7Tzjn49ug1J3tJdp6gIkW4I9VjFmj2QN5kzJ
 rBelQ2eQSJp1TGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E5AB5138A7;
 Fri,  6 Dec 2024 14:19:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tqKlKf4HU2c4ZwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 06 Dec 2024 14:19:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>, peterx@redhat.com,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, Avihai Horon
 <avihaih@nvidia.com>, Alex
 Williamson <alex.williamson@redhat.com>, Prasad Pandit <ppandit@redhat.com>
Subject: Re: [PATCH v2 5/7] migration/multifd: Remove sync processing on
 postcopy
In-Reply-To: <20241206005834.1050905-6-peterx@redhat.com>
References: <20241206005834.1050905-1-peterx@redhat.com>
 <20241206005834.1050905-6-peterx@redhat.com>
Date: Fri, 06 Dec 2024 11:19:40 -0300
Message-ID: <87ttbgc2rn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.98%];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> Multifd never worked with postcopy, at least yet so far.
>
> Remove the sync processing there, because it's confusing, and they should
> never appear.  Now if RAM_SAVE_FLAG_MULTIFD_FLUSH is observed, we fail hard
> instead of trying to invoke multifd code.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

