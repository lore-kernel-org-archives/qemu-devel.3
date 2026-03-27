Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD14F10ED65C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 12:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w66BN-0006Gs-0k; Fri, 27 Mar 2026 08:20:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w66BL-0006Fc-Vk
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:20:56 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1w66BK-0001ft-HE
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 08:20:55 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B34555BDD3;
 Fri, 27 Mar 2026 12:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774614052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eo6Bm2uLJ9FVcFEMxqK3J6XQK4I43U+XcGTdv15r3iw=;
 b=srq+bKd6kNktIGiatqnv7OYhhtfw4uv8D0ZjYLabKH/Wd2N44GYzBhsSRk8X/6D3Wd6Far
 yAzOaqUL1wtCcJmPeQkK+paxeqgBA9juyJdVcgg0j5CzNfZYTYkJCls6fzR5tOlfshkOAf
 KrkwaEwfS8Rt0M3kUMjceegRDAxrUQI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774614052;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eo6Bm2uLJ9FVcFEMxqK3J6XQK4I43U+XcGTdv15r3iw=;
 b=o8Uw/SYzb1jcKlGEZs1SPdBqKoG1SLx6484rmSSriMCoBWxxntxhnqsE9eXlu/PDESbVRg
 Sss12TQirZ0qF6BA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774614051; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eo6Bm2uLJ9FVcFEMxqK3J6XQK4I43U+XcGTdv15r3iw=;
 b=YIJIO/YQaYXCKDwFK5avNTYsrc0JYlJrCWQx/RMl6VPwtMnvaHuICBa6RMmlFJOctkHsnN
 r302Z2xp7/UxHxvye9JkEgss+eTbyJAdO6P+MwxuuEpj36l31yLotJSydQxoC4q6wM3FV9
 2PqgCnw04NarwZmxxMDcpTmRHjQnarY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774614051;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Eo6Bm2uLJ9FVcFEMxqK3J6XQK4I43U+XcGTdv15r3iw=;
 b=tg1pDk4YJpJL/NA5hTaggdAMjo5fKXI6CsFBdb7BPZeVpB1L6fRmsg3KDqL7JliN6NT0Q+
 m8nXC+nT+WDjJpCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FF344A0A2;
 Fri, 27 Mar 2026 12:20:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yF4MCCN2xmkWTgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 27 Mar 2026 12:20:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, peterx@redhat.com,
 Juraj Marcin <jmarcin@redhat.com>, Alexander Mikhalitsyn
 <aleksandr.mikhalitsyn@futurfusion.io>
Subject: Re: [PATCH RFC v2 03/11] vmstate: Do not set size for
 VMS_ARRAY_OF_POINTER
In-Reply-To: <20260326210532.379027-4-peterx@redhat.com>
References: <20260326210532.379027-1-peterx@redhat.com>
 <20260326210532.379027-4-peterx@redhat.com>
Date: Fri, 27 Mar 2026 09:20:49 -0300
Message-ID: <87se9lihum.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 futurfusion.io:email, suse.de:mid, suse.de:email]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> When VMS_ARRAY_OF_POINTER is specified, it means the vmstate field is an
> array of pointers.
>
> The size of the element is not relevant to whatever it is stored inside: it
> is always the host pointer size.
>
> Let's reserve the "size" field in this case for future use, update
> vmstate_size() so as to make it still work for array of pointers properly.
>
> When at this, provide rich documentation on how size / size_offset works in
> vmstate.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

