Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C610BECE58B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 22:32:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so9PP-0001nJ-Vp; Tue, 10 Sep 2024 18:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1so9PO-0001id-MW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:32:26 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1so9PN-0000aW-4B
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 18:32:26 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 17E821F839;
 Tue, 10 Sep 2024 22:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726007543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejQ2IUJ0c58fqxssCiVrJHkiKKngioSdPddXmDWFBQc=;
 b=u/eqvxRNNwO8VjMcgwIDtIbzsFgAMe7BgHZCz6CUtMDo3G8qStY/acxlQjDerRd4xeHlO7
 WGuITfvt8kNWaGXKhlOn6+c6g+oNwY1lRCS/oEah6fkLxHgiab4AmLx2OjDA4V95Zm/rwK
 fkPR01nZoSDn/uCTn1WW696DrfrFIlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726007543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejQ2IUJ0c58fqxssCiVrJHkiKKngioSdPddXmDWFBQc=;
 b=cP6kmE2H6KRaVmy2v2B6A8UGw/g/i9NnMpkPGORU8RL1xsYENKRbbvX1BVLulFsWAbAAnR
 +FsYLew8wL4vuGDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="u/eqvxRN";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cP6kmE2H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726007543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejQ2IUJ0c58fqxssCiVrJHkiKKngioSdPddXmDWFBQc=;
 b=u/eqvxRNNwO8VjMcgwIDtIbzsFgAMe7BgHZCz6CUtMDo3G8qStY/acxlQjDerRd4xeHlO7
 WGuITfvt8kNWaGXKhlOn6+c6g+oNwY1lRCS/oEah6fkLxHgiab4AmLx2OjDA4V95Zm/rwK
 fkPR01nZoSDn/uCTn1WW696DrfrFIlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726007543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejQ2IUJ0c58fqxssCiVrJHkiKKngioSdPddXmDWFBQc=;
 b=cP6kmE2H6KRaVmy2v2B6A8UGw/g/i9NnMpkPGORU8RL1xsYENKRbbvX1BVLulFsWAbAAnR
 +FsYLew8wL4vuGDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C9A6132CB;
 Tue, 10 Sep 2024 22:32:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DVeLDvbI4GYKPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 10 Sep 2024 22:32:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Prasad Pandit <ppandit@redhat.com>, Yichen Wang
 <yichen.wang@bytedance.com>, Bryan Zhang <bryan.zhang@bytedance.com>, Hao
 Xiang <hao.xiang@linux.dev>, Yuan Liu <yuan1.liu@intel.com>
Subject: Re: [PATCH] migration/multifd: Fix build for qatzip
In-Reply-To: <ZuDBUSC2hVaWv6dE@x1n>
References: <20240910210450.3835123-1-peterx@redhat.com>
 <87v7z3qjih.fsf@suse.de> <ZuDBUSC2hVaWv6dE@x1n>
Date: Tue, 10 Sep 2024 19:32:19 -0300
Message-ID: <87jzfjqgwc.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 17E821F839
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Sep 10, 2024 at 06:35:50PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> 
>> > The qatzip series was based on an older commit, it applied cleanly even
>> > though it has conflicts.  Neither CI nor myself found the build will break
>> > as it's skipped by default when qatzip library was missing.
>> 
>> It took longer than I expected.
>
> What took longer?

For a change that breaks the build to be committed in one of these parts
of the code that are disabled by default. You might remember I told you
in one of our meetings that I was concerned about that.

>
>> 
>> Do you think it would work if we wrapped all calls to external functions
>> in a header and stubbed them out when there's no accelerator support?
>
> I didn't catch the major benefit v.s. multifd_register_ops().  Any further
> elaborations?

I'm trying to find a way of having more code compiled by default and
only a minimal amount of code put under the CONFIG_FOO options. So if
some multifd code depends on a library call, say deflateInit, we make
that a multifd_deflate_init and add a stub for when !ZLIB (just an
example). I'm not sure it's feasible though, I'm just bouncing the idea
off of you.

