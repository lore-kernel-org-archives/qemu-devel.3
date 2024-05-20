Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DBDC25B77
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 22:23:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9BPP-0001vw-1Z; Mon, 20 May 2024 18:23:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9BPO-0001vj-18; Mon, 20 May 2024 18:23:06 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9BPM-0005iK-4Y; Mon, 20 May 2024 18:23:05 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA7DB340A2;
 Mon, 20 May 2024 22:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716243780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVXIf9YPFSQr8l3xVCtqOa831dNFChAb0ao8RXGV1so=;
 b=vQJOG5U0jugwhETp3mfz+0/xb60+oIdnqZff/53y7PE94AWXoFUARhKKNSdYIhIYuunhV8
 VMZSrn5HakpoR9s4moHqXPzBf47qoqq5BHb+OrPeaV0U5RQPTLV+y6VPa04uMnaFsDegLA
 +qB2rWiExQKEQgHYvxpeLdLitNdfChg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716243780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVXIf9YPFSQr8l3xVCtqOa831dNFChAb0ao8RXGV1so=;
 b=NKF7ZtLNaYcqEq+9z7teViMfR9l5yi59IrUJ8dXUT9779bFgbnq6dhThp5qeey3+ccCMKp
 ny255WL3qu7p9BBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vQJOG5U0;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NKF7ZtLN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716243780; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVXIf9YPFSQr8l3xVCtqOa831dNFChAb0ao8RXGV1so=;
 b=vQJOG5U0jugwhETp3mfz+0/xb60+oIdnqZff/53y7PE94AWXoFUARhKKNSdYIhIYuunhV8
 VMZSrn5HakpoR9s4moHqXPzBf47qoqq5BHb+OrPeaV0U5RQPTLV+y6VPa04uMnaFsDegLA
 +qB2rWiExQKEQgHYvxpeLdLitNdfChg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716243780;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uVXIf9YPFSQr8l3xVCtqOa831dNFChAb0ao8RXGV1so=;
 b=NKF7ZtLNaYcqEq+9z7teViMfR9l5yi59IrUJ8dXUT9779bFgbnq6dhThp5qeey3+ccCMKp
 ny255WL3qu7p9BBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 127D513A21;
 Mon, 20 May 2024 22:22:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TZ8lMUPNS2bUPAAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 20 May 2024 22:22:59 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, jasowang@redhat.com,
 yuri.benditovich@daynix.com, andrew@daynix.com, peterx@redhat.com,
 t.lamprecht@proxmox.com
Subject: Re: [PATCH] hw/core/machine: move compatibility flags for
 VirtIO-net USO to machine 8.1
In-Reply-To: <20240517075336.104091-1-f.ebner@proxmox.com>
References: <20240517075336.104091-1-f.ebner@proxmox.com>
Date: Mon, 20 May 2024 19:22:57 -0300
Message-ID: <87h6esjf7i.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,huawei.com,linaro.org,gmail.com,habkost.net,redhat.com,daynix.com,proxmox.com];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:dkim, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AA7DB340A2
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> Migration from an 8.2 or 9.0 binary to an 8.1 binary with machine
> version 8.1 can fail with:
>
>> kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179bfffe7
>> kvm: Failed to load virtio-net:virtio
>> kvm: error while loading state for instance 0x0 of device '0000:00:12.0/virtio-net'
>> kvm: load of migration failed: Operation not permitted
>
> The series
>
> 53da8b5a99 virtio-net: Add support for USO features
> 9da1684954 virtio-net: Add USO flags to vhost support.
> f03e0cf63b tap: Add check for USO features
> 2ab0ec3121 tap: Add USO support to tap device.
>
> only landed in QEMU 8.2, so the compatibility flags should be part of
> machine version 8.1.
>
> Moving the flags unfortunately breaks forward migration with machine
> version 8.1 from a binary without this patch to a binary with this
> patch.
>
> Fixes: 53da8b5a99 ("virtio-net: Add support for USO features")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

I'll get to it eventually, but is this another one where just having
-device virtio-net in the command line when testing cross-version
migration would already have caught the issue?


