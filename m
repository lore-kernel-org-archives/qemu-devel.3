Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26233EA794A
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 23:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnmkp-0007GX-Rf; Wed, 04 Feb 2026 18:57:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hare@suse.de>) id 1vnmkn-0007FX-Gj
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 18:57:49 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hare@suse.de>) id 1vnmkl-0006lF-Tb
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 18:57:49 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 675125BCF7;
 Wed,  4 Feb 2026 23:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770249463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cI8WYS82FiAn6Gj1OfXe7QzY+ixqYj4g9DsAelpTAKU=;
 b=Nn580HQoAKALFDBQWtY6lK8yhNYcjKCLsekSZI4HKacPWIQx9ayex6Xr5mwr0GgTbyuxGA
 Y+uQ/Lch+Tw8EtWl8JW5qvqvTTFh7WueLcYtAHdH0lPO6DxlaUHqGJPh09yXbRMrPGPTqy
 vopcbse6TDV3gKaI3wlzsRKaonquczM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770249463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cI8WYS82FiAn6Gj1OfXe7QzY+ixqYj4g9DsAelpTAKU=;
 b=Ksw5i60kVzRkh8Wv0cEpGXvf8wOhIe6JC4PFoyQfQofEk0dYJOtAx8XcZRUf9nNh8z4Kq2
 Fdx98lrMTyc7y5AA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Nn580HQo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ksw5i60k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770249463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cI8WYS82FiAn6Gj1OfXe7QzY+ixqYj4g9DsAelpTAKU=;
 b=Nn580HQoAKALFDBQWtY6lK8yhNYcjKCLsekSZI4HKacPWIQx9ayex6Xr5mwr0GgTbyuxGA
 Y+uQ/Lch+Tw8EtWl8JW5qvqvTTFh7WueLcYtAHdH0lPO6DxlaUHqGJPh09yXbRMrPGPTqy
 vopcbse6TDV3gKaI3wlzsRKaonquczM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770249463;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cI8WYS82FiAn6Gj1OfXe7QzY+ixqYj4g9DsAelpTAKU=;
 b=Ksw5i60kVzRkh8Wv0cEpGXvf8wOhIe6JC4PFoyQfQofEk0dYJOtAx8XcZRUf9nNh8z4Kq2
 Fdx98lrMTyc7y5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CBBB93EA63;
 Wed,  4 Feb 2026 23:57:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id An3DIvTcg2mbXgAAD6G6ig
 (envelope-from <hare@suse.de>); Wed, 04 Feb 2026 23:57:40 +0000
Message-ID: <ff71f35e-06b5-4a82-98ec-8e0419f5ec62@suse.de>
Date: Thu, 5 Feb 2026 00:57:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
To: Stefan Hajnoczi <stefanha@redhat.com>, Martin Wilck <mwilck@suse.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, afaria@redhat.com, qemu-devel@nongnu.org,
 Mikulas Patocka <mpatocka@redhat.com>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
 <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260204183201.GB610283@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_SEVEN(0.00)[9]; MID_RHS_MATCH_FROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 675125BCF7
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=hare@suse.de; helo=smtp-out2.suse.de
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 2/4/26 19:32, Stefan Hajnoczi wrote:
> On Wed, Feb 04, 2026 at 02:19:48PM +0100, Martin Wilck wrote:
>> Hi Stefan,
>>
>> On Tue, 2026-02-03 at 13:04 -0500, Stefan Hajnoczi wrote:
[ .. ]>>>
>>> It can be generic. The messages will contain the block device
>>> major:minor as well as information to describe <linux/pr.h> requests.
>>
>> So the ioctls will pass through qemu into the kernel, to be intercepted
>> by the dm-mpath driver, which will use an upcall to have them handled
>> by mpathpersistd (for the actual command) and multipathd (for the path
>> registrations).
>>
>> I don't fully understand the advantage, security and complexity-wise,
>> of this concept, compared to intercepting them qemu and using a socket
>> to talk to mpathpersistd directly. If we did this, we could even
>> support both generic and SCSI PR commands.
> 
> Hi Martin,
> The simplification and security benefits are on the application side,
> not on the DM-Multipath side, so I can see what you're getting at. From
> the DM-Multipath perspective things get a little more complex.
> 
>  From an application perspective, a single API that works across block
> device types (SCSI, NVMe, DM-Multipath) and requires no privileges or
> sockets (they are a pain in container environments) is the most
> convenient. The <linux/pr.h> ioctl API offers exactly this.
> 
> Unfortunately, DM-Multipath currently does not fully support
> <linux/pr.h>. It sends PR operations down each path, but that is only a
> subset of libmpathpersist's logic and multipathd is not kept in sync.
> 
> My impression is that libmpathpersist and multipathd logic cannot be
> easily moved into the kernel. This is where the upcall idea comes from.
> Let's notify multipath-tools from DM-Multipath so it can do its work in
> userspace.
> 
It _might_ be possible by extending the current path-switching
code in the kernel to keep track of PRs. The we could move the
registration upon path switching, and (ideally) could do away
with upcalls.
Not sure, though, how targets react when having to deal with a
flood of PR commands ...
But maybe worth a try.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

