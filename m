Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E472DC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 13:02:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9P7B-0002Pw-Al; Tue, 21 May 2024 09:01:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9P6S-0002L0-F7; Tue, 21 May 2024 09:00:31 -0400
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1s9P6J-0006mr-18; Tue, 21 May 2024 09:00:27 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E700B34762;
 Tue, 21 May 2024 13:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716296417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=giCSHm+b73IoQWQ+luB7Xl4FPtRknTjOqP2Nt1GdhCc=;
 b=0IVhe7/7fGbVZlwEby5kdfzvGeeBV8ggUerKE/mRNHC/EcQZyx/URQj4TJ5yNuR7nuyG1r
 PxXPQrH3IUG/Coo2XSZLRMCHAsdT0zVKfr8wXTFgwmvWxHItpZmUxnspP40pCnaLbIrQIM
 hftxWyj/5GiUwiLpRo6gRWrK4BrYZNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716296417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=giCSHm+b73IoQWQ+luB7Xl4FPtRknTjOqP2Nt1GdhCc=;
 b=d2a6qFRU7C94UOzm57zc+LmPg2eRf0P7HTozA22IwrEvXFFSgrzwwBQn3c8YEaR/rnQxkS
 OgdK2Wh7M7ZgVQDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1716296416; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=giCSHm+b73IoQWQ+luB7Xl4FPtRknTjOqP2Nt1GdhCc=;
 b=osoGc/dU/FkC1hzhYNruyMwmBiss3GLfGpCchCBdwyUJX/yUZefnBk+mmdKtKTKjEzFx6M
 CJrQRkP31w+GglDm7paKDhUkovv1g8gCEU1O/YnH3k1KFgf1h9a08zZbTI2yFbgcLCgCy4
 W66wfTuHG6xW30ULfC9Tdd7LHBijWa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1716296416;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=giCSHm+b73IoQWQ+luB7Xl4FPtRknTjOqP2Nt1GdhCc=;
 b=PrXGZLBWXGOHDenrMhtZhHcadJEICq1FqIh6N/io2HAjlphxFZOkvXQc3WUPQDAVrzPfIi
 ye6mf2IQHLxSFZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C7D613A1E;
 Tue, 21 May 2024 13:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vj/QB+CaTGaQFwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 21 May 2024 13:00:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, jasowang@redhat.com,
 yuri.benditovich@daynix.com, andrew@daynix.com, peterx@redhat.com,
 t.lamprecht@proxmox.com
Subject: Re: [PATCH] hw/core/machine: move compatibility flags for
 VirtIO-net USO to machine 8.1
In-Reply-To: <a9739f06-7620-4e27-b1c8-0e75256ef11b@proxmox.com>
References: <20240517075336.104091-1-f.ebner@proxmox.com>
 <87h6esjf7i.fsf@suse.de>
 <a9739f06-7620-4e27-b1c8-0e75256ef11b@proxmox.com>
Date: Tue, 21 May 2024 10:00:13 -0300
Message-ID: <878r03jp5u.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TAGGED_RCPT(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[nongnu.org,huawei.com,linaro.org,gmail.com,habkost.net,redhat.com,daynix.com,proxmox.com];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Fiona Ebner <f.ebner@proxmox.com> writes:

> Am 21.05.24 um 00:22 schrieb Fabiano Rosas:
>> Fiona Ebner <f.ebner@proxmox.com> writes:
>> 
>>> Migration from an 8.2 or 9.0 binary to an 8.1 binary with machine
>>> version 8.1 can fail with:
>>>
>>>> kvm: Features 0x1c0010130afffa7 unsupported. Allowed features: 0x10179bfffe7
>>>> kvm: Failed to load virtio-net:virtio
>>>> kvm: error while loading state for instance 0x0 of device '0000:00:12.0/virtio-net'
>>>> kvm: load of migration failed: Operation not permitted
>>>
>>> The series
>>>
>>> 53da8b5a99 virtio-net: Add support for USO features
>>> 9da1684954 virtio-net: Add USO flags to vhost support.
>>> f03e0cf63b tap: Add check for USO features
>>> 2ab0ec3121 tap: Add USO support to tap device.
>>>
>>> only landed in QEMU 8.2, so the compatibility flags should be part of
>>> machine version 8.1.
>>>
>>> Moving the flags unfortunately breaks forward migration with machine
>>> version 8.1 from a binary without this patch to a binary with this
>>> patch.
>>>
>>> Fixes: 53da8b5a99 ("virtio-net: Add support for USO features")
>>> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
>> 
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>> 
>> I'll get to it eventually, but is this another one where just having
>> -device virtio-net in the command line when testing cross-version
>> migration would already have caught the issue?
>> 
> AFAIU, the guest kernel needs to be recent enough to support the feature
> too. I don't seem to run into the issue with a Debian 11 (kernel 5.10)
> guest, but I do run into the issue with an Ubuntu 23.10 (kernel 6.5)
> guest. Seems like it got added in kernel 6.2 with 418044e1de30
> ("drivers/net/virtio_net.c: Added USO support.")

Ah ok, so this is more complex, the tests wouldn't have caught it even
with the device options addition. A test for this will have to come at a
second moment once we figure out how to deal with guest-code dependent
issues.

