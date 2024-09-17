Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B51A8CAC594
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 17:47:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqcHw-0007XR-1d; Tue, 17 Sep 2024 13:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqcHs-0007WU-21; Tue, 17 Sep 2024 13:46:52 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1sqcHq-00080V-A8; Tue, 17 Sep 2024 13:46:51 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33B3C223CD;
 Tue, 17 Sep 2024 17:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726595208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VFYI5nc9VTfu1KvEWgwyO0d22V157mWNRel2kEA3B78=;
 b=VOPp89jI39KW96LCcIUsvLNCD/ncHMsg3W1ARVa7yB8iqClwPXlXpSF872r7bkI/WHecYO
 M+APxI8zvyvmwMqcNTDupB0sBDS+I5mBOshi3kDF3b+tosoKhjXCOpME4lRx6nMm0eyDsG
 MZoa0RtCTLrFTgbRh1G802JkzTOypa4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726595208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VFYI5nc9VTfu1KvEWgwyO0d22V157mWNRel2kEA3B78=;
 b=K2C9vAuZG7UrYRKI1W+iINUGkLRuCNzxEU0i+Mb6JYWArLtWU3CIsWZoholcEG3Ad36InH
 DH+JTLaC7QXkgkBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1726595207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VFYI5nc9VTfu1KvEWgwyO0d22V157mWNRel2kEA3B78=;
 b=c/ntYcsACy69AGv4ylCZoTN8S3BZKRI0uCL0bkTpKRj5UkCgi/rIYS991qSLxpaTEKj/vn
 jrPa8X9zcJlgF33nmmhHONy9z7o/I3nQcSyFSZr7vzXC4fSCofA4XsPAcolHxPt1Z+JpVu
 uHrFVUcCAuRMPIn03TXKQTsvqxls4hQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1726595207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VFYI5nc9VTfu1KvEWgwyO0d22V157mWNRel2kEA3B78=;
 b=xYkrx13YLqixvvM440MLngIwO0R7DV8eYVTpz/U/NuXXCqnycI3AeqP8KNf2V6pHmeCCeg
 ahetD87QTO6UIEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B08E213A9B;
 Tue, 17 Sep 2024 17:46:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q8yFHYbA6WYTewAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 17 Sep 2024 17:46:46 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, peterx@redhat.com, Prasad Pandit
 <ppandit@redhat.com>, Julia Suvorova <jusual@redhat.com>, Juraj Marcin
 <jmarcin@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David
 Hildenbrand <david@redhat.com>, qemu-stable <qemu-stable@nongnu.org>,
 Zhiyi Guo <zhguo@redhat.com>
Subject: Re: [PATCH v4 1/4] KVM: Dynamic sized kvm memslots array
In-Reply-To: <20240917163835.194664-2-peterx@redhat.com>
References: <20240917163835.194664-1-peterx@redhat.com>
 <20240917163835.194664-2-peterx@redhat.com>
Date: Tue, 17 Sep 2024 14:46:44 -0300
Message-ID: <87cyl2yxyz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_SEVEN(0.00)[11]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
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

> Zhiyi reported an infinite loop issue in VFIO use case.  The cause of that
> was a separate discussion, however during that I found a regression of
> dirty sync slowness when profiling.
>
> Each KVMMemoryListerner maintains an array of kvm memslots.  Currently it's
> statically allocated to be the max supported by the kernel.  However after
> Linux commit 4fc096a99e ("KVM: Raise the maximum number of user memslots"),
> the max supported memslots reported now grows to some number large enough
> so that it may not be wise to always statically allocate with the max
> reported.
>
> What's worse, QEMU kvm code still walks all the allocated memslots entries
> to do any form of lookups.  It can drastically slow down all memslot
> operations because each of such loop can run over 32K times on the new
> kernels.
>
> Fix this issue by making the memslots to be allocated dynamically.
>
> Here the initial size was set to 16 because it should cover the basic VM
> usages, so that the hope is the majority VM use case may not even need to
> grow at all (e.g. if one starts a VM with ./qemu-system-x86_64 by default
> it'll consume 9 memslots), however not too large to waste memory.
>
> There can also be even better way to address this, but so far this is the
> simplest and should be already better even than before we grow the max
> supported memslots.  For example, in the case of above issue when VFIO was
> attached on a 32GB system, there are only ~10 memslots used.  So it could
> be good enough as of now.
>
> In the above VFIO context, measurement shows that the precopy dirty sync
> shrinked from ~86ms to ~3ms after this patch applied.  It should also apply
> to any KVM enabled VM even without VFIO.
>
> NOTE: we don't have a FIXES tag for this patch because there's no real
> commit that regressed this in QEMU. Such behavior existed for a long time,
> but only start to be a problem when the kernel reports very large
> nr_slots_max value.  However that's pretty common now (the kernel change
> was merged in 2021) so we attached cc:stable because we'll want this change
> to be backported to stable branches.
>
> Cc: qemu-stable <qemu-stable@nongnu.org>
> Reported-by: Zhiyi Guo <zhguo@redhat.com>
> Tested-by: Zhiyi Guo <zhguo@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

