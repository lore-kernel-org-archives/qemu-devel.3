Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13E4FC47422
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 12:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUQyC-0007Eh-0o; Mon, 29 Jan 2024 07:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUQyA-0007EH-1h
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:42:34 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rUQy6-0002OJ-Ja
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 07:42:33 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC28222037;
 Mon, 29 Jan 2024 12:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706532147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbswseE10oqpvkR5U48dAkyoGQXkKZGwchA96CnOx0U=;
 b=ktllmi0L4ABUkpuGI6Fc1nAyiJ+vmOd1ZR6wviaQq/E47y1DJfR/ZcZ1NAoDzLpQhE1V7d
 76VuUjJi+psZSLT1inbZVVCv1WZXy1VY92dk+Kk6p/ASvkZ52aWPjX78/F/dNf9mbLruzx
 kDJaCJr1Mnr9KdVAMeA2dpmb8/zSY+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706532147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbswseE10oqpvkR5U48dAkyoGQXkKZGwchA96CnOx0U=;
 b=a6GbjhijhtUcWVuBjyb2iQAzLkORzWiMIEwY4UJJuXthfO6EUZx1Ljc1Y/YbJsI1NWlNFu
 gH79QbAQIDGmkZCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706532147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbswseE10oqpvkR5U48dAkyoGQXkKZGwchA96CnOx0U=;
 b=ktllmi0L4ABUkpuGI6Fc1nAyiJ+vmOd1ZR6wviaQq/E47y1DJfR/ZcZ1NAoDzLpQhE1V7d
 76VuUjJi+psZSLT1inbZVVCv1WZXy1VY92dk+Kk6p/ASvkZ52aWPjX78/F/dNf9mbLruzx
 kDJaCJr1Mnr9KdVAMeA2dpmb8/zSY+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706532147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lbswseE10oqpvkR5U48dAkyoGQXkKZGwchA96CnOx0U=;
 b=a6GbjhijhtUcWVuBjyb2iQAzLkORzWiMIEwY4UJJuXthfO6EUZx1Ljc1Y/YbJsI1NWlNFu
 gH79QbAQIDGmkZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3E05F12FF7;
 Mon, 29 Jan 2024 12:42:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Tcb5ATOdt2UnHQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 29 Jan 2024 12:42:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Hao Xiang <hao.xiang@bytedance.com>, Yuan Liu
 <yuan1.liu@intel.com>, Bryan Zhang <bryan.zhang@bytedance.com>, Avihai
 Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 1/5] migration/multifd: Separate compression ops from
 non-compression
In-Reply-To: <ZbdFzFxysMg274Rw@x1n>
References: <20240126221943.26628-1-farosas@suse.de>
 <20240126221943.26628-2-farosas@suse.de> <ZbdFzFxysMg274Rw@x1n>
Date: Mon, 29 Jan 2024 09:42:24 -0300
Message-ID: <87mssoe2fj.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ktllmi0L;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=a6Gbjhij
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Queue-Id: BC28222037
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jan 26, 2024 at 07:19:39PM -0300, Fabiano Rosas wrote:
>> +static MultiFDMethods multifd_socket_ops = {
>> +    .send_setup = multifd_socket_send_setup,
>> +    .send_cleanup = multifd_socket_send_cleanup,
>> +    .send_prepare = multifd_socket_send_prepare,
>
> Here it's named with "socket", however not all socket-based multifd
> migrations will go into this route, e.g., when zstd compression enabled it
> will not go via this route, even if zstd also uses sockets as transport.
> From that pov, this may be slightly confusing.  Maybe it suites more to be
> called "socket_plain" / "socket_no_comp"?
>
> One step back, I had a feeling that the current proposal tried to provide a
> single ->ops to cover a model where we may need more than one layer of
> abstraction.
>
> Since it might be helpful to allow multifd send arbitrary data (e.g. for
> VFIO?  Avihai might have an answer there..), I'll try to even consider that
> into the picture.
>
> Let's consider the ultimate goal of multifd, where the simplest model could
> look like this in my mind (I'm only discussing sender side, but it'll be
> similar on recv side):
>
>                prepare()           send()
>   Input   ----------------> IOVs ------------> iochannels
>
> [I used prepare/send, but please think them as generic terms, not 100%
>  aligned with what we have with existing multifd_ops, or what you proposed
>  later]
>
> Here what are sure, IMHO, is:
>
>   - We always can have some input data to dump; I didn't use "guest pages"
>     just to say we may allow arbitrary data.  For any multifd user that
>     would like to dump arbitrary data, they can already provide IOVs, so
>     here input can be either "MultiFDPages_t" or "IOVs".

Or anything else, since the client code also has control over send(),
no? So it could give multifd a pointer to some memory and then use
send() to do whatever it wants with it. Multifd is just providing worker
threads and "scheduling".

Also note that multifd clients currently _do not_ provide IOVs. They
merely provide data to multifd (p->pages) and then convert that data
into IOVs at prepare(). This is different, because multifd currently
holds that p->pages (and turns that into p->normal), which means the
client code does not need to store the data across iterations (in the
case of RAM which is iterative).

>
>   - We may always want to have IOVs to represent the buffers at some point,
>     no matter what the input it
>
>   - We always flush the IOVs to iochannels; basically I want to say we can
>     always assume the last layer is connecting to QIOChannel APIs, while I
>     don't think there's outliers here so far, even if the send() may differ.
>
> Then _maybe_ it's clearer that we can have two layers of OPs?
>
>   - prepare(): it tells how the "input" will be converted into a scatter
>     gatter list of buffers.  All compression methods fall into this afaiu.
>     This has _nothing_ to do on how the buffers will be sent.  For
>     arbitrary-typed input, this can already be a no-op since the IOVs
>     provided can already be passed over to send().
>
>   - send(): how to dump the IOVs to the iochannels.  AFAIU this is motly
>     only useful for fixed-ram migrations.
>
> Would this be clearer, rather than keep using a single multifd_ops?

Sorry, I don't see how what you describe is any different than what we
have. And I don't see how any of this would mean more than one
multifd_ops. We already have multifd_ops->prepare() and
multifd_ops->send(). What am I missing?

