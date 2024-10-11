Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFCED24470
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 17:30:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szJQL-0004II-83; Fri, 11 Oct 2024 13:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1szJQ3-00046V-K2
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:27:19 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1szJQ1-0005oK-Ea
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 13:27:15 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CFF321EE9;
 Fri, 11 Oct 2024 17:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728667631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5SXTbwaUJzr5s1EDKf8BOrrNBNBs0i8zXFRGz5HZuYw=;
 b=Y0KgeXOq60ulIvYl75tg2YeeBbiSNycqM8CWxIO68udK/5PupX7XLmTvMIeFAeHJZEFBAg
 I/6SLtb/yDkajeJC7FukWnr85kF+uiZqVPwnYDFzAAN93Mytj3oqObARB0D/mEcYgRXP7i
 Npb2BivR+TjmAlYrXzPT18ITX24akkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728667631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5SXTbwaUJzr5s1EDKf8BOrrNBNBs0i8zXFRGz5HZuYw=;
 b=bw37ew4x7S6R/AqGNeeAO24CmmgfjAqNBv5AjEchr1eEB6Luverb9FI0ngXaY0v2E7hQU7
 H+apZAcCiucc/zAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1728667631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5SXTbwaUJzr5s1EDKf8BOrrNBNBs0i8zXFRGz5HZuYw=;
 b=Y0KgeXOq60ulIvYl75tg2YeeBbiSNycqM8CWxIO68udK/5PupX7XLmTvMIeFAeHJZEFBAg
 I/6SLtb/yDkajeJC7FukWnr85kF+uiZqVPwnYDFzAAN93Mytj3oqObARB0D/mEcYgRXP7i
 Npb2BivR+TjmAlYrXzPT18ITX24akkg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1728667631;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5SXTbwaUJzr5s1EDKf8BOrrNBNBs0i8zXFRGz5HZuYw=;
 b=bw37ew4x7S6R/AqGNeeAO24CmmgfjAqNBv5AjEchr1eEB6Luverb9FI0ngXaY0v2E7hQU7
 H+apZAcCiucc/zAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA7F31370C;
 Fri, 11 Oct 2024 17:27:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id j9YZJO5fCWdYSwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 11 Oct 2024 17:27:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com, Markus Armbruster
 <armbru@redhat.com>, Prasad Pandit <ppandit@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, "Dr . David Alan
 Gilbert"
 <dave@treblig.org>, Julia Suvorova <jusual@redhat.com>, Jiang Jiacheng
 <jiangjiacheng@huawei.com>
Subject: Re: [PATCH] migration: Remove interface query-migrationthreads
In-Reply-To: <20241011153417.516715-1-peterx@redhat.com>
References: <20241011153417.516715-1-peterx@redhat.com>
Date: Fri, 11 Oct 2024 14:27:08 -0300
Message-ID: <87y12ur1n7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
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

> This reverts two commits:
>
> 671326201dac8fe91222ba0045709f04a8ec3af4
> 1b1f4ab69c41279a45ccd0d3178e83471e6e4ec1
>
> Meanwhile it adds an entry to removed-features.rst for the
> query-migrationthreads QMP command.
>
> This patch originates from another patchset [1] that wanted to cleanup the
> interface and add corresponding HMP command, as lots of things are missing
> in the query report; so far it only reports the main thread and multifd
> sender threads; all the rest migration threads are not reported, including
> multifd recv threads.
>
> As pointed out by Dan in the follow up discussions [1], the API is designed
> in an awkward way where CPU pinning may not cover the whole lifecycle of
> even the thread being reported.  When asked, we also didn't get chance to
> hear from the developer who introduced this feature to explain how this API
> can be properly used.
>
> OTOH, this feature from debugging POV isn't very helpful either, as all
> these information can be easily obtained by GDB.  Esepcially, if with
> "-name $VM,debug-threads=on" we do already have names for each migration
> threads (which covers more than multifd sender threads).
>
> So it looks like the API isn't helpful in any form as of now, besides it
> only adds maintenance burden to migration code, even if not much.
>
> Considering that so far there's totally no justification on how to use this
> interface correctly, let's remove this interface instead of cleaning it up.
>
> In this special case, we even go beyond normal deprecation procedure,
> because a deprecation process would only make sense when there are existing
> users. In this specific case, we expect zero serious users with this API.
>
> [1] https://lore.kernel.org/qemu-devel/20240930195837.825728-1-peterx@redhat.com/
>
> Cc: Jiang Jiacheng <jiangjiacheng@huawei.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

