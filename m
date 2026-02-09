Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0442FE81BB2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Feb 2026 12:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vpQiO-0000ao-8C; Mon, 09 Feb 2026 07:50:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hare@suse.de>) id 1vpQiL-0000aD-OD
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 07:50:06 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hare@suse.de>) id 1vpQiK-0005MY-0C
 for qemu-devel@nongnu.org; Mon, 09 Feb 2026 07:50:05 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46E513E70A;
 Mon,  9 Feb 2026 12:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770641401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+vIyxQU9/xTtn38tvf0jm+bxj8/P29PP5fLpxpw3Jo=;
 b=YgnSHOuOqHyBXWA2B0D9Nvwd7fyIZOogMGsssfeqsPI0Dvo3qVPTowNlYYkkh47ytcqw6k
 3ntykcnu2+zZK3QIoNr3Qn+ZoMSjxlNRPIEWbSiGR3WZP4zkX86O0ey9SBPSeODXLdKKtt
 FgW3jkouuDcBQZgrPmDMBa6Zufzn5rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770641401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+vIyxQU9/xTtn38tvf0jm+bxj8/P29PP5fLpxpw3Jo=;
 b=o6FGofW/A8XikRxw7t5kgz7BPcshoVLwD10oqFLy3Qeapym58Z7VoscVkALU6ZR1tk9S4H
 KbmqkUDxiMKqgWBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770641401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+vIyxQU9/xTtn38tvf0jm+bxj8/P29PP5fLpxpw3Jo=;
 b=YgnSHOuOqHyBXWA2B0D9Nvwd7fyIZOogMGsssfeqsPI0Dvo3qVPTowNlYYkkh47ytcqw6k
 3ntykcnu2+zZK3QIoNr3Qn+ZoMSjxlNRPIEWbSiGR3WZP4zkX86O0ey9SBPSeODXLdKKtt
 FgW3jkouuDcBQZgrPmDMBa6Zufzn5rc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770641401;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L+vIyxQU9/xTtn38tvf0jm+bxj8/P29PP5fLpxpw3Jo=;
 b=o6FGofW/A8XikRxw7t5kgz7BPcshoVLwD10oqFLy3Qeapym58Z7VoscVkALU6ZR1tk9S4H
 KbmqkUDxiMKqgWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 063623EA63;
 Mon,  9 Feb 2026 12:50:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gLPcAPnXiWm/cgAAD6G6ig
 (envelope-from <hare@suse.de>); Mon, 09 Feb 2026 12:50:01 +0000
Message-ID: <ba99c16a-f621-49a7-bab4-c262a4f2a2e8@suse.de>
Date: Mon, 9 Feb 2026 13:50:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, afaria@redhat.com, qemu-devel@nongnu.org,
 Mikulas Patocka <mpatocka@redhat.com>
References: <aXkou8f97EvxK2K8@redhat.com> <20260203150939.GB445116@fedora>
 <aYI2CAjmHGklh3mi@redhat.com> <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
 <aYSGia2Zy_g5iop5@redhat.com> <20260205133930.GA36872@fedora>
 <d78fade2-484a-4866-8b5c-065ba3d28b16@suse.de>
 <20260206140809.GA68769@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260206140809.GA68769@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[10];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=hare@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 2/6/26 15:08, Stefan Hajnoczi wrote:
> On Fri, Feb 06, 2026 at 01:03:18AM +0100, Hannes Reinecke wrote:
>> On 2/5/26 14:39, Stefan Hajnoczi wrote:
[ .. ]
>> That would make sense, but unfortunately READ KEYS (and READ
>> RESERVATIONS) requires the same privileges than the other
>> blkpr functions. Might be an idea to change that, though.
> 
> Making sure I understand:
> 
> blkdev_pr_read_keys() and blkdev_pr_read_reservation() in Linux
> block/ioctl.c should be adjusted to allow not just BLK_OPEN_WRITE but
> also BLK_OPEN_READ?
> 
Yes.

> I think it's okay from a security perspective: if the application can
> already read the entire disk, then it's okay for it to read the keys and
> reservation information. But I'm not 100% sure...
> 
> In any case, I think this idea is orthogonal to the discussion about
> DM-Multipath <linux/pr.h> support. In terms of permission requirements,
> <linux/pr.h> already requires fewer permissions (just opening the block
> device for write) today than libmpathpersist or ioctl(SG_IO). Or do you
> see a scenario where the application wants to open the block device as
> root (or CAP_SYS_RAWIO) but read-only, so requiring opening the device
> with write permissions is a blocker?
> 

My concern with opening the block device with BLK_OPEN_WRITE is that
this will trigger udev to 'synthesize' (ie regenerate) an 'add' event
on close, causing 'interesting' effects as this will cascade down
through the udev rule chain, triggering blkid, partition scan, you
name it.
Horrible, horrible, horrible.
Don't do it.

Especially not as you are only interested in reading information,
and not changing the disk state in any way.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

