Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D4DD30011
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 14:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1oJk-0002if-R4; Fri, 18 Oct 2024 10:51:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1oJh-0002hZ-OV
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:51:02 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t1oJg-0003J5-9p
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 10:51:01 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5C6A211BB;
 Fri, 18 Oct 2024 14:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729263058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M3sNzrTkYFKAo83lV0vdD+mOe0/7Nh861cceNM/7tQ8=;
 b=k+6hJaYgExW3KgM5kCPXLWx2lOAGfvF9Dt5aCgG0td7gbOcjzyniY28ekEnChZYkPqAgGC
 Lfdmf9zgtrskKGewT5Bx+aY/bq1tP+u8q4APEiib4rGunmQPN5JJGCKjTO9kgzp3ksGTk4
 TQurxQk5hXmu3t9yAue4gc3jXahiG4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729263058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M3sNzrTkYFKAo83lV0vdD+mOe0/7Nh861cceNM/7tQ8=;
 b=IGSZ7aUjVzNyOrHZHMrMcdGyRkwcFwzG33PwHlT2THhSNoPKVnYSlR08+CpWMioq9pVVEh
 u2Xz4LB7N97zyXAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1729263058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M3sNzrTkYFKAo83lV0vdD+mOe0/7Nh861cceNM/7tQ8=;
 b=k+6hJaYgExW3KgM5kCPXLWx2lOAGfvF9Dt5aCgG0td7gbOcjzyniY28ekEnChZYkPqAgGC
 Lfdmf9zgtrskKGewT5Bx+aY/bq1tP+u8q4APEiib4rGunmQPN5JJGCKjTO9kgzp3ksGTk4
 TQurxQk5hXmu3t9yAue4gc3jXahiG4g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1729263058;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=M3sNzrTkYFKAo83lV0vdD+mOe0/7Nh861cceNM/7tQ8=;
 b=IGSZ7aUjVzNyOrHZHMrMcdGyRkwcFwzG33PwHlT2THhSNoPKVnYSlR08+CpWMioq9pVVEh
 u2Xz4LB7N97zyXAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6109213433;
 Fri, 18 Oct 2024 14:50:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 81pHCtJ1EmdTPgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 18 Oct 2024 14:50:58 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH] Migration: Add trace points for vmstate handler
 insertion/removal
In-Reply-To: <20241018144426.826802-1-peterx@redhat.com>
References: <20241018144426.826802-1-peterx@redhat.com>
Date: Fri, 18 Oct 2024 11:50:55 -0300
Message-ID: <87o73h1n3k.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.25 / 50.00]; BAYES_HAM(-2.95)[99.78%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; MISSING_XM_UA(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
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

Peter Xu <peterx@redhat.com> writes:

> SaveStateEntry has lots of magics internally, on alias_id, get_id() being
> able to overwrite the original idstr, compat fields, ID_ANY, and so on.  It
> may not be always clear that what all these fields are being registered for
> some device we care.
>
> Add trace points for SaveStateEntry insertions/removals, so that we know
> what was being registered.  For insertions, we dump everything that might
> be useful.  For removal, only section_id is needed because that's the
> unique identifier for an SeveStateEntry.
>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

