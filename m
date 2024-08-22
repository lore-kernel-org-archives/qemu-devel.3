Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9393CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 17:21:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shBV0-0001fk-Ma; Thu, 22 Aug 2024 13:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shBUy-0001V2-Sr
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:21:24 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1shBUx-0007kX-7d
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 13:21:24 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9480D2020D;
 Thu, 22 Aug 2024 17:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724347281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gt6XC6a2QPbYFsQEs8ViJtzyIQd0pLYzKo0uKZyDeNY=;
 b=Vo340hprS+aUZYoeJsWobGYKgI7RwqnosKgRP+QP6TETkL8i+M56ll+XweerrwWrRrshnr
 2IQwDML+2tifgicZG5VSvH75oOiS12hv+ekcOou1HCmeH67w4RUYm34VAE6R8CqqCLzTGm
 euGX1mb5iqm4V1Klf4ujIuzQMJ/Xkpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724347281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gt6XC6a2QPbYFsQEs8ViJtzyIQd0pLYzKo0uKZyDeNY=;
 b=CvfW92y8kuZSlk3a2xzKnfPSsU7vezke/edEXW9EfUnoWkzpe4SjRHQu5PujKGUvEg5Q7F
 zVPBWYf1/dqFsiDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1724347281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gt6XC6a2QPbYFsQEs8ViJtzyIQd0pLYzKo0uKZyDeNY=;
 b=Vo340hprS+aUZYoeJsWobGYKgI7RwqnosKgRP+QP6TETkL8i+M56ll+XweerrwWrRrshnr
 2IQwDML+2tifgicZG5VSvH75oOiS12hv+ekcOou1HCmeH67w4RUYm34VAE6R8CqqCLzTGm
 euGX1mb5iqm4V1Klf4ujIuzQMJ/Xkpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1724347281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gt6XC6a2QPbYFsQEs8ViJtzyIQd0pLYzKo0uKZyDeNY=;
 b=CvfW92y8kuZSlk3a2xzKnfPSsU7vezke/edEXW9EfUnoWkzpe4SjRHQu5PujKGUvEg5Q7F
 zVPBWYf1/dqFsiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20A9413297;
 Thu, 22 Aug 2024 17:21:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YBghNpBzx2bTFgAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 22 Aug 2024 17:21:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [PATCH v3 14/14] migration/multifd: Move ram code into
 multifd-ram.c
In-Reply-To: <ZsdmddpcYuhyCO0I@x1n>
References: <20240801123516.4498-1-farosas@suse.de>
 <20240801123516.4498-15-farosas@suse.de> <ZsdmddpcYuhyCO0I@x1n>
Date: Thu, 22 Aug 2024 14:21:18 -0300
Message-ID: <87o75kxylt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.17 / 50.00]; BAYES_HAM(-2.87)[99.43%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.de:email,
 suse.de:mid]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Thu, Aug 01, 2024 at 09:35:16AM -0300, Fabiano Rosas wrote:
>> In preparation for adding new payload types to multifd, move most of
>> the ram-related code into multifd-ram.c. Let's try to keep a semblance
>> of layering by not mixing general multifd control flow with the
>> details of transmitting pages of ram.
>> 
>> There are still some pieces leftover, namely the p->normal, p->zero,
>> etc variables that we use for zero page tracking and the packet
>> allocation which is heavily dependent on the ram code.
>> 
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> The movement makes sense to me in general, but let's discuss whether nocomp
> may need a better name.  It could mean that we may want two new files:
> multifd-ram.c to keep generic RAM stuff (which apply to nocomp/zlib/...)
> then multifd-plain.c which contains no-comp case, perhaps.

I think 2 files would be too much. We'd just be jumping from one to
another while reading code. The nocomp code is intimately related to the
multifd-ram code. Should we just put it in a multifd-nocomp.c and that's
it?

