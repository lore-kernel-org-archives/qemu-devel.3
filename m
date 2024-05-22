Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD215C25B7A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 13:07:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9lgG-0001Mg-46; Wed, 22 May 2024 09:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9lgE-0001MH-H5; Wed, 22 May 2024 09:06:54 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9lg9-0004sj-31; Wed, 22 May 2024 09:06:53 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5189134D3F;
 Wed, 22 May 2024 13:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716383201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pT0F6m5SKzZGAG/o/+8IPDTbtu2dgZqK2wCjsdg1spc=;
 b=mMtJPHpaT8FPfy8drgjxXBG0/w61zRdNKvsFD3TwxlWeTn9Bt1E4KXEkd+wkub4e/YlXxt
 gc6BqbTdnJJcBRinQF5alu1chkZJfeboPBUWbV2qDSCIWZzFHGSQmHtAveKRamRufsV5IH
 ADIEEKySssOAOIZfhFDFjEUXWzTYDj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716383201;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pT0F6m5SKzZGAG/o/+8IPDTbtu2dgZqK2wCjsdg1spc=;
 b=+5hp1cLi46muS9026iRO2ZG84JwpzQv+1fPj3GBmojAfltwrLvYOKbaPNWsa5pTktMS3GR
 jyrixdyrIyf/j/Bg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mMtJPHpa;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+5hp1cLi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716383201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pT0F6m5SKzZGAG/o/+8IPDTbtu2dgZqK2wCjsdg1spc=;
 b=mMtJPHpaT8FPfy8drgjxXBG0/w61zRdNKvsFD3TwxlWeTn9Bt1E4KXEkd+wkub4e/YlXxt
 gc6BqbTdnJJcBRinQF5alu1chkZJfeboPBUWbV2qDSCIWZzFHGSQmHtAveKRamRufsV5IH
 ADIEEKySssOAOIZfhFDFjEUXWzTYDj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716383201;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pT0F6m5SKzZGAG/o/+8IPDTbtu2dgZqK2wCjsdg1spc=;
 b=+5hp1cLi46muS9026iRO2ZG84JwpzQv+1fPj3GBmojAfltwrLvYOKbaPNWsa5pTktMS3GR
 jyrixdyrIyf/j/Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0A8813A1E;
 Wed, 22 May 2024 13:06:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0c2nJeDtTWbdUQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 22 May 2024 13:06:40 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Thomas Huth <thuth@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH] tests/qtest/migration-test: Run some basic tests on
 s390x and ppc64 with TCG, too
In-Reply-To: <20240522091255.417263-1-thuth@redhat.com>
References: <20240522091255.417263-1-thuth@redhat.com>
Date: Wed, 22 May 2024 10:06:38 -0300
Message-ID: <87zfsigfmp.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.45 / 50.00]; BAYES_HAM(-2.94)[99.73%];
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
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5189134D3F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Thomas Huth <thuth@redhat.com> writes:

> On s390x, we recently had a regression that broke migration / savevm
> (see commit bebe9603fc ("hw/intc/s390_flic: Fix crash that occurs when
> saving the machine state"). The problem was merged without being noticed
> since we currently do not run any migration / savevm related tests on
> x86 hosts.
> While we currently cannot run all migration tests for the s390x target
> on x86 hosts yet (due to some unresolved issues with TCG), we can at
> least run some of the non-live tests to avoid such problems in the future.
> Thus enable the "analyze-script" and the "bad_dest" tests before checking
> for KVM on s390x or ppc64 (this also fixes the problem that the
> "analyze-script" test was not run on s390x at all anymore since it got
> disabled again by accident in a previous refactoring of the code).
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

And thanks for fixing my mistake.


