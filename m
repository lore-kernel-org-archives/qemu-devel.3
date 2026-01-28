Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B692FD3F07A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 15:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vl7Vv-0007rk-5p; Wed, 28 Jan 2026 10:31:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hare@suse.de>) id 1vl7Vr-0007on-PX
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:31:24 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hare@suse.de>) id 1vl7Vj-0004mj-91
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 10:31:23 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5D49533BEF;
 Wed, 28 Jan 2026 15:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769614265; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ijC2JTfCBS8LAecg73Gf8ZgJ8Eml0FsrzaES4crnKU=;
 b=TgG/tU/kyHzao201HKOpn3pyExO89j2JRL7vd7BmbAde6DMeHbPHhAgRBIsa68qE6srvKn
 T5u8FvzS/hlY8Ywrgr4zpakp1v6mTGjl8Q+FoFfo389yLVw+GL/Dz1MZwjcWnERl+gOihS
 TV188Rt/eajIgmD1rEdFjqF4Mh9txiY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769614265;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ijC2JTfCBS8LAecg73Gf8ZgJ8Eml0FsrzaES4crnKU=;
 b=hmPfOoR2L1V7N1hlDHtRp9KLFXpq6hHs4hYxH3noVB+bbMRDpUhHvWuqj9RiWlR8UHEfxt
 0lPVFPDTPQUQDgCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=umu1zhbk;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qsml0X6K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1769614257; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ijC2JTfCBS8LAecg73Gf8ZgJ8Eml0FsrzaES4crnKU=;
 b=umu1zhbklBdIFRg0MPB9N3mvEaRtzGOVzndtcEuTzYBReFmIPjYt0j7BYjKIIV2rYqNsji
 4X2s0amwzMu/nhffYhG32SMAMTZp24KrTS6ZnGQanJagcD1opCyZGYbfPWPlKiSN+P8DvX
 YP5znBmYEmamxmcUp7rtZjvHcSQ2qkc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1769614257;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7ijC2JTfCBS8LAecg73Gf8ZgJ8Eml0FsrzaES4crnKU=;
 b=qsml0X6KdtcFvCs34U7AeX+jvskW3bjpkdWdrKo7haf5g9caDGi5MVFpC8Z0D+Jwnmhy6L
 vZPcXxlnKkOHlVCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2CE7A3EA61;
 Wed, 28 Jan 2026 15:30:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sAHfCKwremkiPwAAD6G6ig
 (envelope-from <hare@suse.de>); Wed, 28 Jan 2026 15:30:52 +0000
Message-ID: <2fff54ca-00c4-4483-ac1d-2c47b0f8c683@suse.de>
Date: Wed, 28 Jan 2026 16:30:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
To: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Benjamin Marzinski <bmarzins@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>, Alberto Faria <afaria@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
References: <20260127184743.GA77765@fedora>
 <CABgObfZetG0O5oX+pHCAaPXwaPreWn2NSXuWpJUBdaqdL=a4-w@mail.gmail.com>
 <20260128141838.GA111862@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260128141838.GA111862@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[7];
 RSPAMD_EMAILBL_FAIL(0.00)[hare.suse.de:query timed out];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid, suse.de:dkim, suse.de:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 5D49533BEF
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=hare@suse.de; helo=smtp-out1.suse.de
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

On 1/28/26 15:18, Stefan Hajnoczi wrote:
> On Tue, Jan 27, 2026 at 08:45:39PM +0100, Paolo Bonzini wrote:
>> Il mar 27 gen 2026, 19:47 Stefan Hajnoczi <stefanha@redhat.com> ha scritto:
>>
>>> Several of us have pondered a different approach that I will summarize
>>> here. The <linux/pr.h> ioctl interface provides an alternative to
>>> ioctl(SG_IO) without the CAP_SYS_RAWIO requirement. It supports both
>>> SCSI and NVMe. Since privileges are not required, there would be no need
>>> for the qemu-pr-helper daemon anymore.
>>>
>>
>> Yes, no problem with that. It's easy to extend QEMU with a new pr-manager
>> subclass that converts SCSI commands to PR ioctls.
> 
> Yes. It will be possible to go further than that in the future:
> 
> Alberto has been working on QEMU block layer API support for persistent
> reservations. When that becomes available, SCSI command parsing can
> happen entirely within hw/scsi/scsi-disk.c for scsi-block and scsi-disk.
> file-posix.c will then implement the new BlockDriver PR APIs via
> <linux/pr.h> ioctls and other block drivers can implement them in
> protocol-specific ways (e.g. iSCSI).
> 
>> My suggestion is to implement <linux/pr.h> via upcalls from DM-Multipath
>>> to multipathd. That way applications like QEMU can consistently use
>>> <linux/pr.h> across block device types and no longer have to go through
>>> the privileged libmpathpersist interface.
>>>
>>
>> What do you have in mind for the upcall protocol? Does it need to be done
>> with multipathd or can it be a separate daemon for privilege separation? I
>> am not sure if there is any channel between dm-mpath and multipathd that
>> can be extended (I think it only uses uevent?); maybe it would make sense
>> to reuse qemu-pr-helper's protocol even.
> 
> I don't have a strong opinion on the protocol. My thought was to do a
> traditional upcall with call_usermodehelper() with an execve argv/envp
> protocol. That way there is no need to register a file descriptor. The
> downside is that this approach is less efficient and more likely to fail
> when the host is under memory pressure, but PR operations are not that
> frequent.
> 
gnaa. call_usermodehelper() is _evil_. It might be executed with any 
arbitrary fs context, and you better hope the executable is present
there ...

Maybe look at the handshake daemon. That's solving a very similar issue
which we had for TLS.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

