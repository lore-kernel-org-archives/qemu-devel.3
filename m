Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69502C3DA60
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 18:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU9Yp-0002vf-K3; Wed, 17 Jul 2024 14:39:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU9Yn-0002uy-Co
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:39:29 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sU9Yl-0003AU-PC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 14:39:29 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 32F081FB91;
 Wed, 17 Jul 2024 18:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721241566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bB6QxC3PkHXulcyjM6E2zRQqRnUHICTpemh2xIsKLtk=;
 b=lp0SvOrlbX1kIkZJeCOmmJIB/m33KWhoHYMqopAoBnFOwpLp01tYAcN+wT1L9OQQOLFgqs
 P9XKnXWURAdM//GVOiSbyy7wGR0kYKSNahsmS3UzCRW4BqA3u+ow8Ui6pFiHD2RquCPFxh
 uumPvrHW4NdvJsxo/W3pwQ5OIjQARKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721241566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bB6QxC3PkHXulcyjM6E2zRQqRnUHICTpemh2xIsKLtk=;
 b=NOOSFG3jLOGKM+PKuxDLIRoFPypUVbvkjdkgklu+etESOix8d5j/sLspRkYd7PA6ktInSw
 t100MiVKXMW+LZCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1721241566; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bB6QxC3PkHXulcyjM6E2zRQqRnUHICTpemh2xIsKLtk=;
 b=lp0SvOrlbX1kIkZJeCOmmJIB/m33KWhoHYMqopAoBnFOwpLp01tYAcN+wT1L9OQQOLFgqs
 P9XKnXWURAdM//GVOiSbyy7wGR0kYKSNahsmS3UzCRW4BqA3u+ow8Ui6pFiHD2RquCPFxh
 uumPvrHW4NdvJsxo/W3pwQ5OIjQARKE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1721241566;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bB6QxC3PkHXulcyjM6E2zRQqRnUHICTpemh2xIsKLtk=;
 b=NOOSFG3jLOGKM+PKuxDLIRoFPypUVbvkjdkgklu+etESOix8d5j/sLspRkYd7PA6ktInSw
 t100MiVKXMW+LZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AD6531368F;
 Wed, 17 Jul 2024 18:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bby9HN0PmGbJTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jul 2024 18:39:25 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost
 <eduardo@habkost.net>, Philippe Mathieu-Daude <philmd@linaro.org>, Paolo
 Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Steve Sistare
 <steven.sistare@oracle.com>
Subject: Re: [PATCH V2 02/11] migration: cpr-state
In-Reply-To: <1719776434-435013-3-git-send-email-steven.sistare@oracle.com>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-3-git-send-email-steven.sistare@oracle.com>
Date: Wed, 17 Jul 2024 15:39:23 -0300
Message-ID: <87wmlj278k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-1.98 / 50.00]; BAYES_HAM(-2.18)[96.10%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,habkost.net,linaro.org,oracle.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; MISSING_XM_UA(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Steve Sistare <steven.sistare@oracle.com> writes:

> CPR must save state that is needed after QEMU is restarted, when devices
> are realized.  Thus the extra state cannot be saved in the migration stream,
> as objects must already exist before that stream can be loaded.  Instead,
> define auxilliary state structures and vmstate descriptions, not associated
> with any registered object, and serialize the aux state to a cpr-specific
> stream in cpr_state_save.  Deserialize in cpr_state_load after QEMU
> restarts, before devices are realized.
>
> Provide accessors for clients to register file descriptors for saving.
> The mechanism for passing the fd's to the new process will be specific
> to each migration mode, and added in subsequent patches.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

