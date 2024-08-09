Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD15CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2024 12:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1scP4r-0004Gk-Ad; Fri, 09 Aug 2024 08:50:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1scP4p-00049g-8P
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:50:39 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1scP4n-0004Z3-55
 for qemu-devel@nongnu.org; Fri, 09 Aug 2024 08:50:39 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 03E0321F36;
 Fri,  9 Aug 2024 12:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723207832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pZduv5KFyDJS2a2XZrJaJrK/BEaGvHOv3zdfF9qclM=;
 b=KdIZYIe9znmPFd/TcfLRzTGd1uER1piZCYh23ftkRcEYXq8sTwPngB6pVQ+FLMlvvKGIQ9
 O6EAW0Wz6B4d2DcbYi9Pg6/TC79akVN6d/K/Zm00jDQ7WQW29UUsa5grvlWDPWeEaz6Kit
 A5Z4OPdCI/SB/v0My1sfBYt8ajt+CM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723207832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pZduv5KFyDJS2a2XZrJaJrK/BEaGvHOv3zdfF9qclM=;
 b=Q/c7uXcqeU3p6+Zb4aMdcrH2kzeM4z9mBMZE4V4kWlAtacuD9KB4YJqcyep2V7LQA3Womj
 qx7RKpCeuXKsWFCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=KdIZYIe9;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Q/c7uXcq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1723207832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pZduv5KFyDJS2a2XZrJaJrK/BEaGvHOv3zdfF9qclM=;
 b=KdIZYIe9znmPFd/TcfLRzTGd1uER1piZCYh23ftkRcEYXq8sTwPngB6pVQ+FLMlvvKGIQ9
 O6EAW0Wz6B4d2DcbYi9Pg6/TC79akVN6d/K/Zm00jDQ7WQW29UUsa5grvlWDPWeEaz6Kit
 A5Z4OPdCI/SB/v0My1sfBYt8ajt+CM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1723207832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pZduv5KFyDJS2a2XZrJaJrK/BEaGvHOv3zdfF9qclM=;
 b=Q/c7uXcqeU3p6+Zb4aMdcrH2kzeM4z9mBMZE4V4kWlAtacuD9KB4YJqcyep2V7LQA3Womj
 qx7RKpCeuXKsWFCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 776041379A;
 Fri,  9 Aug 2024 12:50:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pR/tD5cQtmZddAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 09 Aug 2024 12:50:31 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, =?utf-8?Q?Daniel_P=2E_Berran?=
 =?utf-8?Q?g=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Yuri Benditovich
 <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 dmitry.fleytman@gmail.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
In-Reply-To: <ZrTjaZPyjDuJZK36@x1n>
References: <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org> <ZrTTCIpXLmW8c5Kv@x1n>
 <20240808104559-mutt-send-email-mst@kernel.org> <ZrTjaZPyjDuJZK36@x1n>
Date: Fri, 09 Aug 2024 09:50:28 -0300
Message-ID: <8734ndhncb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[17]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[daynix.com,redhat.com,habkost.net,gmail.com,linaro.org,huawei.com,est.tech,weilnetz.de,nongnu.org,lists.libvirt.org];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]; TAGGED_RCPT(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 03E0321F36
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

> On Thu, Aug 08, 2024 at 10:47:28AM -0400, Michael S. Tsirkin wrote:
>> On Thu, Aug 08, 2024 at 10:15:36AM -0400, Peter Xu wrote:
>> > On Thu, Aug 08, 2024 at 07:12:14AM -0400, Michael S. Tsirkin wrote:
>> > > This is too big of a hammer. People already use what you call "cross
>> > > migrate" and have for years. We are not going to stop developing
>> > > features just because someone suddenly became aware of some such bit.
>> > > If you care, you will have to work to solve the problem properly -
>> > > nacking half baked hacks is the only tool maintainers have to make
>> > > people work on hard problems.
>> > 
>> > IMHO this is totally different thing.  It's not about proposing a new
>> > feature yet so far, it's about how we should fix a breakage first.
>> > 
>> > And that's why I think we should fix it even in the simple way first, then
>> > we consider anything more benefitial from perf side without breaking
>> > anything, which should be on top of that.
>> > 
>> > Thanks,
>> 
>> As I said, once the quick hack is merged people stop caring.
>
> IMHO it's not a hack. It's a proper fix to me to disable it by default for
> now.
>
> OTOH, having it ON always even knowing it can break migration is a hack to
> me, when we don't have anything else to guard the migration.
>
>> Mixing different kernel versions in migration is esoteric enough for
>> this not to matter to most people. There's no rush I think, address
>> it properly.
>
> Exactly mixing kernel versions will be tricky to users to identify, but
> that's, AFAICT, exactly happening everywhere.  We can't urge user to always
> use the exact same kernels when we're talking about a VM cluster.  That's
> why I think allowing migration to work across those kernels matter.

I also worry a bit about the scenario where the cluster changes slightly
and now all VMs are already restricted by some option that requires the
exact same kernel. Specifically, kernel changes in a cloud environment
also happen due to factors completely unrelated to migration. I'm not
sure the people managing the infra (who care about migration) will be
gating kernel changes just because QEMU has been configured in a
specific manner.

