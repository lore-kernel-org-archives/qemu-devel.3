Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F5CCC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 14:56:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh9Dd-0001XZ-Vc; Thu, 22 Aug 2024 10:55:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh9Db-0001WA-QE
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:55:19 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1sh9DZ-0003CN-GS
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 10:55:19 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 77C6C201EC;
 Thu, 22 Aug 2024 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724338513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OJOh/4dghr0gImj9K/hm/gaHOfn+O+LODKml2dgUlbI=;
 b=p31wSw7EZazpv4BBlzcZhb87kmMdAQkG5e7ZvSVVeFFVSfHhIL0Un+7hG+CTNJwiaEe0PP
 2b00LJw3UBk1CIzNdNCIYm95qB3xZ9doK4J+hbqP6M0erQpNw9sC5qk24IIAU7ENU3Df/q
 gbhylET6zc8clt5ub5ekh1VYhsGoLOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724338513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OJOh/4dghr0gImj9K/hm/gaHOfn+O+LODKml2dgUlbI=;
 b=pKBXHksiazkW8dm043rZMeHuwyuu5ytkDun7S1RkOCTblMbNwFLZwOQ329S15aEtykdYDS
 F7o3i5pj0NGJOpDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p31wSw7E;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=pKBXHksi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724338513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OJOh/4dghr0gImj9K/hm/gaHOfn+O+LODKml2dgUlbI=;
 b=p31wSw7EZazpv4BBlzcZhb87kmMdAQkG5e7ZvSVVeFFVSfHhIL0Un+7hG+CTNJwiaEe0PP
 2b00LJw3UBk1CIzNdNCIYm95qB3xZ9doK4J+hbqP6M0erQpNw9sC5qk24IIAU7ENU3Df/q
 gbhylET6zc8clt5ub5ekh1VYhsGoLOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724338513;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OJOh/4dghr0gImj9K/hm/gaHOfn+O+LODKml2dgUlbI=;
 b=pKBXHksiazkW8dm043rZMeHuwyuu5ytkDun7S1RkOCTblMbNwFLZwOQ329S15aEtykdYDS
 F7o3i5pj0NGJOpDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F0006139D3;
 Thu, 22 Aug 2024 14:55:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ey03LVBRx2bFaQAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 14:55:12 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 09/14] migration/multifd: Isolate ram pages packet data
In-Reply-To: <ZsdLkYeoWO1p6YNy@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-10-farosas@suse.de> <ZsZeUpuZuhbD60YZ@x1n>
 <87zfp4y7an.fsf@suse.de> <ZsdLkYeoWO1p6YNy@x1n>
Date: Thu, 22 Aug 2024 11:55:10 -0300
Message-ID: <87wmk8y5dd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 77C6C201EC
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00]; BAYES_HAM(-2.99)[99.94%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MID_RHS_MATCH_FROM(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim];
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

> On Thu, Aug 22, 2024 at 11:13:36AM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > On Thu, Aug 01, 2024 at 09:35:11AM -0300, Fabiano Rosas wrote:
>> >> @@ -1554,7 +1577,6 @@ static void *multifd_recv_thread(void *opaque)
>> >>                  qemu_sem_wait(&p->sem_sync);
>> >>              }
>> >>          } else {
>> >> -            p->total_normal_pages += p->data->size / qemu_target_page_size();
>> >
>> > Is this line dropped by accident?
>> >
>> 
>> No, this was just used in the tracepoint below. I stopped including this
>> information there.
>
> But this will cause socket / file paths not doing the same thing, since
> this counter should still be increamented in socket path (and this is the
> file path).
>
> Either we keep it the same as before, or.. if we want to drop it, shouldn't
> we remove all instead (along with the two variables "total_normal_pages /
> total_zero_pages")?

I'll just remove them. There's not much point in these anyway since
they are per-channel.

