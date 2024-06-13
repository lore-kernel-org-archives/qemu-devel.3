Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05E87C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 14:55:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHlr0-0004Y0-GC; Thu, 13 Jun 2024 10:55:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHlqy-0004XY-Pp
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:55:04 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sHlqx-00028c-4E
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 10:55:04 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C81E372D0;
 Thu, 13 Jun 2024 14:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718290501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+7V6bmBhY7mW/1T6gfzdWZ0edUIHaEhd7sKG0vpZA8=;
 b=cjcz3STXGVfenG2HqhTk12AN87Fo90eIFoq4Shek1m9C8IvLpjRm4kU+8iOibHU1ggiCKo
 YI398HREbeToSeklm9BY1/0iHxcuVQXpbYubiy+ALVTU3SKaXxbAEhy4CAupFCr1tKrFS8
 vSVEDL5scd3yQVUGpAu4ThwDbW2/cYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718290501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+7V6bmBhY7mW/1T6gfzdWZ0edUIHaEhd7sKG0vpZA8=;
 b=S+564JTQXdmihCYDfEOGpgsOkHL6jXiY/aNbwCIcnRkZQ2hQuI1t2JcCQVrHiOUJweGp55
 TcLqCSruOCUO7yAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1718290501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+7V6bmBhY7mW/1T6gfzdWZ0edUIHaEhd7sKG0vpZA8=;
 b=cjcz3STXGVfenG2HqhTk12AN87Fo90eIFoq4Shek1m9C8IvLpjRm4kU+8iOibHU1ggiCKo
 YI398HREbeToSeklm9BY1/0iHxcuVQXpbYubiy+ALVTU3SKaXxbAEhy4CAupFCr1tKrFS8
 vSVEDL5scd3yQVUGpAu4ThwDbW2/cYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1718290501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J+7V6bmBhY7mW/1T6gfzdWZ0edUIHaEhd7sKG0vpZA8=;
 b=S+564JTQXdmihCYDfEOGpgsOkHL6jXiY/aNbwCIcnRkZQ2hQuI1t2JcCQVrHiOUJweGp55
 TcLqCSruOCUO7yAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0725113A7F;
 Thu, 13 Jun 2024 14:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id G73ZL0QIa2b3VwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 13 Jun 2024 14:55:00 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Jiri Denemark <jdenemar@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Bandan Das <bdas@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH 1/4] migration/multifd: Avoid the final FLUSH in complete()
In-Reply-To: <875xudc5pv.fsf@suse.de>
References: <20240612144228.1179240-1-peterx@redhat.com>
 <20240612144228.1179240-2-peterx@redhat.com> <875xudc5pv.fsf@suse.de>
Date: Thu, 13 Jun 2024 11:54:58 -0300
Message-ID: <87zfroc2pp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.20 / 50.00]; BAYES_HAM(-2.90)[99.56%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Fabiano Rosas <farosas@suse.de> writes:

> Peter Xu <peterx@redhat.com> writes:
>
>> We always do the flush when finishing one round of scan, and during
>> complete() phase we should scan one more round making sure no dirty page
>> existed.  In that case we shouldn't need one explicit FLUSH at the end of
>> complete(), as when reaching there all pages should have been flushed.
>>
>> Signed-off-by: Peter Xu <peterx@redhat.com>
>
> Reviewed-by: Fabiano Rosas <farosas@suse.de>

Actually, let's be more clear and make this a:

Tested-by: Fabiano Rosas <farosas@suse.de>

That way I'll remember this went through the same tests as the other
multifd sync changes we made.

