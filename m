Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A09F8ECD9B0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 00:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo9Js-0004WH-Gp; Thu, 05 Feb 2026 19:03:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hare@suse.de>) id 1vo9Jq-0004VZ-C9
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:03:30 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hare@suse.de>) id 1vo9Jn-0001zm-Hc
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 19:03:30 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4901534F08;
 Fri,  6 Feb 2026 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770336204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTZEjUUg4ztT7xlJEa8mYCJZKYnawOdr7QANtmvswgo=;
 b=dIalf12lNWf50HBLb7av1UFZkObg7ZyS0QC/4cTuaXdQo/ETqUGHVoHPqKMdMzgojRMIhw
 kTWdPqWcOZJqUFK7J8bIc1IqCmT7VxZXAMaAouOe/qoxXYgXlyFWlm0JzAGElwECQVRKpl
 fWhpgk0um2Mf46sM0G4vuZxyMA8KcYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770336204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTZEjUUg4ztT7xlJEa8mYCJZKYnawOdr7QANtmvswgo=;
 b=zs+lMzpKzcevuLBPMVTYNN2MHm5yVCEzLxFNhAQmLddBNqLtB2Sn0gQOKuga6i8vV1HBmP
 CnZut4Z4rhYMPLDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770336204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTZEjUUg4ztT7xlJEa8mYCJZKYnawOdr7QANtmvswgo=;
 b=dIalf12lNWf50HBLb7av1UFZkObg7ZyS0QC/4cTuaXdQo/ETqUGHVoHPqKMdMzgojRMIhw
 kTWdPqWcOZJqUFK7J8bIc1IqCmT7VxZXAMaAouOe/qoxXYgXlyFWlm0JzAGElwECQVRKpl
 fWhpgk0um2Mf46sM0G4vuZxyMA8KcYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770336204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GTZEjUUg4ztT7xlJEa8mYCJZKYnawOdr7QANtmvswgo=;
 b=zs+lMzpKzcevuLBPMVTYNN2MHm5yVCEzLxFNhAQmLddBNqLtB2Sn0gQOKuga6i8vV1HBmP
 CnZut4Z4rhYMPLDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD2BE3EA63;
 Fri,  6 Feb 2026 00:03:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3YGiHsgvhWmlbwAAD6G6ig
 (envelope-from <hare@suse.de>); Fri, 06 Feb 2026 00:03:20 +0000
Message-ID: <d78fade2-484a-4866-8b5c-065ba3d28b16@suse.de>
Date: Fri, 6 Feb 2026 01:03:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Moving from qemu-pr-helper and libmpathpersist to <linux/pr.h>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Martin Wilck <mwilck@suse.com>, Benjamin Marzinski <bmarzins@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, afaria@redhat.com, qemu-devel@nongnu.org,
 Mikulas Patocka <mpatocka@redhat.com>
References: <20260127184743.GA77765@fedora> <aXkou8f97EvxK2K8@redhat.com>
 <20260203150939.GB445116@fedora> <aYI2CAjmHGklh3mi@redhat.com>
 <20260203180437.GA527989@fedora>
 <f81a053d4507e220cc787bfda152171506949858.camel@suse.com>
 <20260204183201.GB610283@fedora>
 <d6cfd9a22c397e3811eaa73409f4ab1499e3e63f.camel@suse.com>
 <aYSGia2Zy_g5iop5@redhat.com> <20260205133930.GA36872@fedora>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260205133930.GA36872@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[10]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=hare@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2/5/26 14:39, Stefan Hajnoczi wrote:
> On Thu, Feb 05, 2026 at 12:01:13PM +0000, Daniel P. Berrangé wrote:
>> On Thu, Feb 05, 2026 at 12:52:33PM +0100, Martin Wilck wrote:
>>> On Wed, 2026-02-04 at 13:32 -0500, Stefan Hajnoczi wrote:
>>>> On Wed, Feb 04, 2026 at 02:19:48PM +0100, Martin Wilck wrote:
>>>>> Hi Stefan,
>>>>>
>>>>> So the ioctls will pass through qemu into the kernel, to be
>>>>> intercepted
>>>>> by the dm-mpath driver, which will use an upcall to have them
>>>>> handled
>>>>> by mpathpersistd (for the actual command) and multipathd (for the
>>>>> path
>>>>> registrations).
>>>>>
>>>>> I don't fully understand the advantage, security and complexity-
>>>>> wise,
>>>>> of this concept, compared to intercepting them qemu and using a
>>>>> socket
>>>>> to talk to mpathpersistd directly. If we did this, we could even
>>>>> support both generic and SCSI PR commands.
>>>>
>>>> Hi Martin,
>>>> The simplification and security benefits are on the application side,
>>>> not on the DM-Multipath side, so I can see what you're getting at.
>>>> From
>>>> the DM-Multipath perspective things get a little more complex.
>>>>
>>>>  From an application perspective, a single API that works across block
>>>> device types (SCSI, NVMe, DM-Multipath) and requires no privileges or
>>>> sockets (they are a pain in container environments) is the most
>>>> convenient. The <linux/pr.h> ioctl API offers exactly this.
>>>
>>> I may be missing something, but AFAICS the PR ioctls require having a
>>> block device open for writing, which does either require root
>>> privileges, or some file descriptor previously opened with privileges
>>> and forwarded to another, less privileged process. No?
>>
>> While QEMU is run unprivileged, libvirt will grant QEMU access any block
>> devices that have been configured for the guest in question. On Linux,
>> libvirt will create a new /dev tmpfs populated with the allow-list of
>> device nodes the guest is permitted to access, with suitable file
>> permissions, ownership & SELinux labels set.
> 
> Ultimately something does require privileges to give an unprivileged
> application access to a block device. That could be udev rules, it could
> be libvirt, etc.
> 
> I would say the real distinction is between the privileges needed so the
> application can access the block device vs the privileges needed to
> perform PR operations. If udev or libvirt has set up block device nodes,
> an unprivileged application can open them for read/write access. But it
> would require CAP_SYS_RAWIO for SG_IO PR operations on top of that
> whereas <linux/pr.h> ioctls do not require that.
> 
That would make sense, but unfortunately READ KEYS (and READ
RESERVATIONS) requires the same privileges than the other
blkpr functions. Might be an idea to change that, though.

> Therefore there is a real advantages regarding privileges when using
> <linux/pr.h> ioctls vs libmpathpersist.
> 
There actually is a large argument here, namely that blkpr is
device independent. So when using it it doesn't matter whether
you are accessing a SCSI device or a NVME device, blkpr will
work in both cases.
And as such it's a far better choice for generic frameworks
like qemu.

For multipath less so, I agree, as that is pretty much SCSI-only.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

