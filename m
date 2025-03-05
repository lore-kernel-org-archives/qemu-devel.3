Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B272C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 12:43:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpo6D-0006rf-3R; Wed, 05 Mar 2025 07:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tpo5x-0006ml-6Z
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:43:30 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tpo5v-0004Ou-G3
 for qemu-devel@nongnu.org; Wed, 05 Mar 2025 07:43:28 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9711A1F770;
 Wed,  5 Mar 2025 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741178601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9cqipSbXcYXiASJq+Ys6cxD+oQ95xdLKywezshOfXQ=;
 b=Q5I9ZFKWP6SiRkLAPVG5SMU2415dM6cCMF/9DSWWOaiGnkhiXom2rhrP00TFqQmnEth/03
 5WcOl3LoTqxAyC7kS7RqxDNuC0lakv8sHf/WF8Ff1dvZ2nxGudbVbw6P+yzIPFZDYITzwl
 JjwsThQoR9u9X7EWVxyWQIh/t5l4FNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741178601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9cqipSbXcYXiASJq+Ys6cxD+oQ95xdLKywezshOfXQ=;
 b=F3N8GU1dgW16LlU7vJqFBnok6W57wnLgjhwsmxZP/mZNkDaNRQaLkHL6ii5lE2OqAeRkiu
 acgcqmGUlf/gtUDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1741178601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9cqipSbXcYXiASJq+Ys6cxD+oQ95xdLKywezshOfXQ=;
 b=Q5I9ZFKWP6SiRkLAPVG5SMU2415dM6cCMF/9DSWWOaiGnkhiXom2rhrP00TFqQmnEth/03
 5WcOl3LoTqxAyC7kS7RqxDNuC0lakv8sHf/WF8Ff1dvZ2nxGudbVbw6P+yzIPFZDYITzwl
 JjwsThQoR9u9X7EWVxyWQIh/t5l4FNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1741178601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n9cqipSbXcYXiASJq+Ys6cxD+oQ95xdLKywezshOfXQ=;
 b=F3N8GU1dgW16LlU7vJqFBnok6W57wnLgjhwsmxZP/mZNkDaNRQaLkHL6ii5lE2OqAeRkiu
 acgcqmGUlf/gtUDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1157213939;
 Wed,  5 Mar 2025 12:43:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8cq1MOhGyGedLQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 05 Mar 2025 12:43:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>, Peter Xu
 <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le
 Goater <clg@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Avihai
 Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 15/36] migration/multifd: Make MultiFDSendData a struct
In-Reply-To: <7b02baba8e6ddb23ef7c349d312b9b631db09d7e.1741124640.git.maciej.szmigiero@oracle.com>
References: <cover.1741124640.git.maciej.szmigiero@oracle.com>
 <7b02baba8e6ddb23ef7c349d312b9b631db09d7e.1741124640.git.maciej.szmigiero@oracle.com>
Date: Wed, 05 Mar 2025 09:43:18 -0300
Message-ID: <87bjufveah.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

"Maciej S. Szmigiero" <mail@maciej.szmigiero.name> writes:

> From: Peter Xu <peterx@redhat.com>
>
> The newly introduced device state buffer can be used for either storing
> VFIO's read() raw data, but already also possible to store generic device
> states.  After noticing that device states may not easily provide a max
> buffer size (also the fact that RAM MultiFDPages_t after all also want to
> have flexibility on managing offset[] array), it may not be a good idea to
> stick with union on MultiFDSendData.. as it won't play well with such
> flexibility.
>
> Switch MultiFDSendData to a struct.
>
> It won't consume a lot more space in reality, after all the real buffers
> were already dynamically allocated, so it's so far only about the two
> structs (pages, device_state) that will be duplicated, but they're small.
>
> With this, we can remove the pretty hard to understand alloc size logic.
> Because now we can allocate offset[] together with the SendData, and
> properly free it when the SendData is freed.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> [MSS: Make sure to clear possible device state payload before freeing
> MultiFDSendData, remove placeholders for other patches not included]
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

Acked-by: Fabiano Rosas <farosas@suse.de>

