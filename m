Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC178E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 11:57:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV8Ck-0006Uh-Jh; Tue, 07 Jan 2025 06:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tV8Ci-0006UJ-0K
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:57:00 -0500
Received: from fly.ash.relay.mailchannels.net ([23.83.222.61])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rob@landley.net>) id 1tV8Cg-0005aP-8X
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 06:56:59 -0500
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id C43902308E;
 Tue,  7 Jan 2025 11:56:53 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com
 (trex-0.trex.outbound.svc.cluster.local [100.109.200.96])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 5FAAA221B2;
 Tue,  7 Jan 2025 11:56:53 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1736251013; a=rsa-sha256;
 cv=none;
 b=TXX1ymFTJIYIu447Py4TQN/9feshXZqzfXBdphXy/bxj3KEbPuY24yP3mCibTtPEQxUpge
 LxzVGtyA7M6vlQhV/SmuGXkQIudhgeWx9f7sYPfscDPD92MPvJ2bibeIoNC5yGCpzJVcQa
 Iibprfyas99NYa0AcQUkRqHRbFx6MdM4mUVV/9GEqAIJcunmy/tErk+6Dnj3kyJQqEvmGh
 4DUFlNFy200+s4l52fBspC2BbOWpHUrKqcdJk7edTlt/4nbHFrUYgimjt9/eijbODdAGji
 LuYQS2p8RQRb+YB6GfXm5fcoTbWKMo0lxx8k0Ixsy/u1XZtnuJbUvlPC/mKa4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1736251013;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=duMUvX3UNp0veUQogtJaVfQVHfwtVm56e34BJZWojcM=;
 b=DWuz7T2XVGd8aOr8C93LqlmCY7jnjocivdTSVLG+4W1UaDjN4n8C70xdhOb1DSeirll/tO
 GQWbqzOIeIGIiXU3DLYPUZFfyRmqxB9MuntlO5M1wWpWweAvbJNBt9Gj3xq4cnYvUOfkR9
 KrDzUgl4DLDZMJXZSEtpYXbZ2n7dQTPNt55kKXnA92T5DLKL9R1GO9NYOOkOJ7RFHtEcxs
 QxyGwdwwOhPu6QFoH6xKspz+LG+Adh4CYilyGKB+BydIgKbK2GUmxZ9G5aRSVl8xdDZq94
 BZ7zR9T9+B+uJaw7PnM0HAH3i0BbyXwa227zhOL77ChgjuOrbcrHUU1rD+1YHA==
ARC-Authentication-Results: i=1; rspamd-78747dd9f8-lwggx;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=rob@landley.net
X-Sender-Id: dreamhost|x-authsender|rob@landley.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|rob@landley.net
X-MailChannels-Auth-Id: dreamhost
X-Obese-Duck: 076470374949171f_1736251013622_767715808
X-MC-Loop-Signature: 1736251013622:4167575820
X-MC-Ingress-Time: 1736251013622
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.109.200.96 (trex/7.0.2); Tue, 07 Jan 2025 11:56:53 +0000
Received: from [172.16.32.88] (unknown [198.232.126.202])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: rob@landley.net)
 by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4YS8fX5WyzzFZ; 
 Tue,  7 Jan 2025 03:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=landley.net;
 s=dreamhost; t=1736251013;
 bh=hAa+Wut4rNka3epnxinp2FbGd5RGhLNRtZ/OEEaCMnU=;
 h=Date:Subject:From:To:Cc:Content-Type:Content-Transfer-Encoding;
 b=pv1cd20MmKIjnTgcMXaB9gfkfL/s2OyhyPupHdObPC/nDIZS3+HMElLv5fws8womu
 Z9UTn7GLrT9P/r/BFlGgWwMvj5+eWHMUNge6pPmMcO8bSTLG8cLsOWmBWemmepkQbf
 3Ab6cq8F0azBjl8280S2M8gX68pLtoeC79T7NxZva25v0Xsr6iWV8Sa2tExOGKdwx8
 RxFfGTs06JVhDfXAGiy/gh2ZaidJzv4RhrNHoiVblGj3GfF3Qoy0s8oFsexe98woUH
 aADI+iwjpgFkX9vMvfdR0YzcdB754xguTQM0sbnpRaguR6Es8wSyUqMZ6A3o/bqhC+
 FWywujou0z+Ow==
Message-ID: <39511711-b86a-4ac6-8bd6-8dab824b693e@landley.net>
Date: Tue, 7 Jan 2025 05:56:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: or1k -M virt -hda and net.
From: Rob Landley <rob@landley.net>
To: Stafford Horne <shorne@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Linux OpenRISC <linux-openrisc@vger.kernel.org>
References: <afac091f-08cb-0f6d-4c01-bfa4421e7a47@landley.net>
 <Zufcf4iAqosZ7VBf@antec> <9b2761aa-8ee0-4399-b237-31e70e3ed165@landley.net>
 <Z0Cyx3i3z7Zl7XPm@antec> <31fa6255-8e0c-4d05-bad9-dd843c676244@landley.net>
 <Z0GSETLeT5w8B2DX@antec> <87a6b910-5af6-47ad-ad8d-b79f11a7cbf2@landley.net>
 <Z0LMqEqcdjkAxnN-@antec> <57c5207c-3aca-47cd-bfd3-3d7eb7be3c0f@landley.net>
 <Z2lgL31ZeSkO59MZ@antec> <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
Content-Language: en-US
In-Reply-To: <8807078a-0673-4b27-8d58-4a2a3ce4987d@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=23.83.222.61; envelope-from=rob@landley.net;
 helo=fly.ash.relay.mailchannels.net
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL_A=0.1 autolearn=ham autolearn_force=no
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

On 12/31/24 19:19, Rob Landley wrote:
> On 12/23/24 07:05, Stafford Horne wrote:
>>> The kernel config looks like it should have virt block device 
>>> support, but
...
>>    -device virtio-blk-device,drive=d0 -drive 
>> file=${DISK},id=d0,if=none,format=qcow2
> 
> -drive file=file.img,format=raw,id=hd0 -device virtio-blk-device,drive=hd0
> 
> My -device looks similar but -drive is file=file.img,format=raw,id=hd0
> 
> No idea what if= does? I haven't seemed to need it...
...
> Thanks, I think this target is good for release. Now to figure out why 
> sh2eb network isn't working after the restore (it used to!). Nor is 
> microblaze's network...

My test harness appends -hda filename.img to the qemu command line, 
which works for all the other targets, and is awkward to turn into
-device lots-of-stuff,file-filename.img,more-stuff inside a shell 
script. (At best it's a special case parsing and rewriting qemu command 
line plumbing to turn "generic" into an architecture-specific workaround.)

In THEORY I should be able to do something like:

root/or1k/run-qemu.sh -netdev user,id=net0 -device 
virtio-net-device,netdev=net0 -device virtio-blk-device,drive=sd0 -hda 
README

And just have extra arch setup that then accepts the generic appended to 
it. But in practice that says:

qemu-system-or1k: -device virtio-blk-device,drive=sd0: Device needs 
media, but drive is empty

Putting the -hda before the -device doesn't help. (And even if it did, 
the result would barf if run _without_ -hda, which should also work.)

Having -hda by itself is accepted by qemu, but I don't know what 
bus/driver gets added as a result (or1k kernel does not find it).

Rob

