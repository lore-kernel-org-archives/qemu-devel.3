Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF7FE77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 17:24:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL3xa-0006rB-Lm; Tue, 10 Dec 2024 12:23:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tL3xW-0006qk-8z
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:23:42 -0500
Received: from forwardcorp1b.mail.yandex.net ([178.154.239.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1tL3xT-0002dZ-Nd
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 12:23:42 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:292a:0:640:622b:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 768D160C0A;
 Tue, 10 Dec 2024 20:23:30 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b658::1:1d] (unknown
 [2a02:6b8:b081:b658::1:1d])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id TNqVvc2IYuQ0-jt57MSLZ; Tue, 10 Dec 2024 20:23:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1733851409;
 bh=PtflgArgtOa+vR1RZyPNysDO22xtm1FeHOp2MBbVwYM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dU5NsYA+k+eBWX4qi3D0yOKq7TYqLzWSRcHyZNlqJJ/Jk7MsHiuQIstVnyfN9Fp2K
 bpM5gVdvmQ46s/bB2Z9VVWJaGu4hNzLgm4PmeFg6Eg8pzIKzbO1dBgqqRmrqk+cukm
 IpIYZ9zDr637EfW1L/a6yt15L1kCABU+M1S2A38g=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ea4505a9-c5dd-40c0-8ea6-0a254a9b2fa9@yandex-team.ru>
Date: Tue, 10 Dec 2024 20:23:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] overcommit: introduce mem-lock-onfault
To: Peter Xu <peterx@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
References: <20241205231909.1161950-1-d-tatianin@yandex-team.ru>
 <Z1JOpadES2iV_i0v@x1n> <779a4733-888b-4591-af5e-381572c84c20@yandex-team.ru>
 <Z1hw7dvTe4jMgXeq@x1n> <ddd20bd5-2596-4966-a77f-fb44b651dc6a@yandex-team.ru>
 <Z1h4XaKCwfidJLfw@x1n>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <Z1h4XaKCwfidJLfw@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.136;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 12/10/24 8:20 PM, Peter Xu wrote:
> On Tue, Dec 10, 2024 at 08:01:08PM +0300, Daniil Tatianin wrote:
>> I mentioned my use case in the cover letter. Basically we want to protect
>> QEMU's pages from being migrated and compacted by kcompactd, which it
>> accomplishes by modifying live page tables and spamming the process with TLB
>> invalidate IPIs while it does that, which kills guest performance for the
>> duration of the compaction operation.
> Ah right, I read it initially but just now when I scanned the cover letter
> I missed that.  My fault.

No worries!

>> Memory locking allows to protect a process from kcompactd page compaction
>> and more importantly, migration (that is taking a PTE and replacing it with
>> one, which is closer in memory to reduce fragmentation). (As long as
>> /proc/sys/vm/compact_unevictable_allowed is 0)
>>
>> For this use case we don't mind page faults as they take more or less
>> constant time, which we can also avoid if we wanted by preallocating guest
>> memory. We do, however, want PTEs to be untouched by kcompactd, which
>> MCL_ONFAULT accomplishes just fine without the extra memory overhead that
>> comes from various anonymous mappings getting write-faulted with the
>> currently available mem-lock=on option.
>>
>> In our case we use KVM of course, TCG was just an experiment where I noticed
>> anonymous memory
>> jump way too much.
>>
>> I don't think it's feasible in our case to look for the origin of every
>> anonymous mapping that grew compared to the no mem-lock case (which there's
>> about ~30 with default Q35 + KVM, without any extra devices), and try to
>> optimize it to map anonymous memory less eagerly.
> Would it be better then to use mem-lock=on|off|onfault?  So turns it into a
> string to avoid the "exclusiveness" needed (meanwhile having two separate
> knobs for relevant things looks odd too).

How did I not think of that.. Sounds much better IMO.

Thank you!

> Thanks,
>

