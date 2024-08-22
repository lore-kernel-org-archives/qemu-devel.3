Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CDA3C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 14:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh8ZO-0000hp-Ho; Thu, 22 Aug 2024 10:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh8ZL-0000h5-Gh
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:13:44 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh8ZJ-0005lX-T6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:13:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8BF33224EA;
 Thu, 22 Aug 2024 14:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724336019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EX6kwZrdehSDdbgo+cmLIAYAkADpQrV6RnSsMfiZyHE=;
 b=eNnXqZ8LB642bnvldU3x+cWMe3zS9zaFmy7Uwoqns5sWYHAKT92Bz6VQ0pjeZpXQGusMgN
 qiTMtYur2nhIcRsEJrvHN2CUfLaDRPcHQOmlesuwPgQBNNf2g7EAhgBaTodTJQ4ijVrG+q
 M/fhsXIX/AjWI4ms1VRe8No2EYEEsYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724336019;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EX6kwZrdehSDdbgo+cmLIAYAkADpQrV6RnSsMfiZyHE=;
 b=KFUOAi9L2Q8rJRe8VpYwv4ExiD8Jr5RADZ9/3f+1nJ6j8Mxn4kaUyoXJDhCjEuYCN34aQ9
 /w5cnXxoPfr7HGCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=eNnXqZ8L;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KFUOAi9L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724336019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EX6kwZrdehSDdbgo+cmLIAYAkADpQrV6RnSsMfiZyHE=;
 b=eNnXqZ8LB642bnvldU3x+cWMe3zS9zaFmy7Uwoqns5sWYHAKT92Bz6VQ0pjeZpXQGusMgN
 qiTMtYur2nhIcRsEJrvHN2CUfLaDRPcHQOmlesuwPgQBNNf2g7EAhgBaTodTJQ4ijVrG+q
 M/fhsXIX/AjWI4ms1VRe8No2EYEEsYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724336019;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EX6kwZrdehSDdbgo+cmLIAYAkADpQrV6RnSsMfiZyHE=;
 b=KFUOAi9L2Q8rJRe8VpYwv4ExiD8Jr5RADZ9/3f+1nJ6j8Mxn4kaUyoXJDhCjEuYCN34aQ9
 /w5cnXxoPfr7HGCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D776D139D3;
 Thu, 22 Aug 2024 14:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uidKJpJHx2ZMXAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 14:13:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 09/14] migration/multifd: Isolate ram pages packet data
In-Reply-To: <ZsZeUpuZuhbD60YZ@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-10-farosas@suse.de> <ZsZeUpuZuhbD60YZ@x1n>
Date: Thu, 22 Aug 2024 11:13:36 -0300
Message-ID: <87zfp4y7an.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 8BF33224EA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.47 / 50.00]; BAYES_HAM(-1.96)[94.79%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Thu, Aug 01, 2024 at 09:35:11AM -0300, Fabiano Rosas wrote:
>> @@ -1554,7 +1577,6 @@ static void *multifd_recv_thread(void *opaque)
>>                  qemu_sem_wait(&p->sem_sync);
>>              }
>>          } else {
>> -            p->total_normal_pages += p->data->size / qemu_target_page_size();
>
> Is this line dropped by accident?
>

No, this was just used in the tracepoint below. I stopped including this
information there.

>>              p->data->size = 0;
>>              /*
>>               * Order data->size update before clearing

