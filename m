Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2DBC54E67
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqaJ-0006MD-AF; Thu, 28 Mar 2024 10:18:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rpqaE-0006KA-L1; Thu, 28 Mar 2024 10:18:23 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1rpqa6-0006za-IY; Thu, 28 Mar 2024 10:18:16 -0400
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 92D19209D6;
 Thu, 28 Mar 2024 14:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1711635487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvHuDNFQTPHbtJ7ZXU9uEBnCilxz3vcM1ASGZEhCA0g=;
 b=nhTuJPSvtrJsOo56hv/FnV1quvwPnTTJH9Gut151EXq2o2mNkbhZydtdnzMuwKODJMvWE4
 IXrnRFd4VFCm3TkNRLyz8jVDJRCJ6A4Hks/UgwqcxQBYyejo3ogWDdeiE85z5jJT2yJh9d
 wRJu50rVHGyadftebHYJUXpURF95hm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1711635487;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FvHuDNFQTPHbtJ7ZXU9uEBnCilxz3vcM1ASGZEhCA0g=;
 b=DSpwdYtfO9ed/HBJ0X8e0+VScjkDGLcor5deElUAsOIeiWU7ixaqpID+vaR7rd1jnTTrEf
 7Lgf2FQdJvEzHMCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D59AC13A92;
 Thu, 28 Mar 2024 14:18:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id rn/RMx58BWY1TwAAn2gu4w
 (envelope-from <farosas@suse.de>); Thu, 28 Mar 2024 14:18:06 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>, Kevin Wolf <kwolf@redhat.com>,
 Prasanna Kumar Kalever <prasanna.kalever@redhat.com>, Cornelia Huck
 <cohuck@redhat.com>, Michael Roth <michael.roth@amd.com>, Li Zhijian
 <lizhijian@fujitsu.com>, Prasanna Kumar Kalever <prasanna4324@gmail.com>,
 Peter Xu <peterx@redhat.com>, integration@gluster.org, Paolo Bonzini
 <pbonzini@redhat.com>, qemu-block@nongnu.org, =?utf-8?Q?Daniel_P=2E_Berra?=
 =?utf-8?Q?ng=C3=A9?=
 <berrange@redhat.com>, devel@lists.libvirt.org, Hanna Reitz
 <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Eric Blake <eblake@redhat.com>, Philippe =?utf-8?Q?Ma?=
 =?utf-8?Q?thieu-Daud=C3=A9?=
 <philmd@linaro.org>, Song Gao <gaosong@loongson.cn>, =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Wainer dos Santos
 Moschetta
 <wainersm@redhat.com>, Beraldo Leal <bleal@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>
Subject: Re: [PATCH-for-9.1 v2 2/3] migration: Remove RDMA protocol handling
In-Reply-To: <20240328130255.52257-3-philmd@linaro.org>
References: <20240328130255.52257-1-philmd@linaro.org>
 <20240328130255.52257-3-philmd@linaro.org>
Date: Thu, 28 Mar 2024 11:18:04 -0300
Message-ID: <87frwatp7n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 92D19209D6
X-Spamd-Result: default: False [-1.61 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TAGGED_RCPT(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[27]; MIME_TRACE(0.00)[0:+];
 R_DKIM_NA(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[gmail.com,redhat.com,amd.com,fujitsu.com,gluster.org,nongnu.org,lists.libvirt.org,linaro.org,loongson.cn];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email, imap2.dmz-prg2.suse.org:rdns,
 imap2.dmz-prg2.suse.org:helo, suse.de:email, fujitsu.com:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> The whole RDMA subsystem was deprecated in commit e9a54265f5
> ("hw/rdma: Deprecate the pvrdma device and the rdma subsystem")
> released in v8.2.
>
> Remove:
>  - RDMA handling from migration
>  - dependencies on libibumad, libibverbs and librdmacm
>
> Keep the RAM_SAVE_FLAG_HOOK definition since it might appears
> in old migration streams.
>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Acked-by: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Just to be clear, because people raised the point in the last version,
the first link in the deprecation commit links to a thread comprising
entirely of rdma migration patches. I don't see any ambiguity on whether
the deprecation was intended to include migration. There's even an ack
from Juan.

So on the basis of not reverting the previous maintainer's decision, my
Ack stands here.

We also had pretty obvious bugs ([1], [2]) in the past that would have
been caught if we had any kind of testing for the feature, so I can't
even say this thing works currently.

@Peter Xu, @Li Zhijian, what are your thoughts on this?

1- https://lore.kernel.org/r/20230920090412.726725-1-lizhijian@fujitsu.com
2- https://lore.kernel.org/r/CAHEcVy7HXSwn4Ow_Kog+Q+TN6f_kMeiCHevz1qGM-fbxB=
Pp1hQ@mail.gmail.com


