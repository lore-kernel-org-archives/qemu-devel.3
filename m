Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F00CCD1BE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 06:59:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBSoC-0004oK-99; Wed, 22 Oct 2025 02:58:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBSo9-0004br-Fd
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:53 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vBSo7-0008Hv-Jx
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 02:58:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8E90B80B64;
 Wed, 22 Oct 2025 09:58:49 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a4a::1:14] (unknown
 [2a02:6bf:8080:a4a::1:14])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id mwQGCC0IrmI0-TxtjvlX2; Wed, 22 Oct 2025 09:58:49 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761116329;
 bh=tXdtXALq4rJWjxwWqgYj4nyuzTpmJJp5KmekPfHP4Oo=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=QTPBPkOH6186p/bBkFmMC/Yj2HfLXRtyH/1XVOo17V9UTi5Ml9//Jtqn2nLgY6xau
 BBMklewUOjc2Xp04MdTgCmJM4WEg6GqO5bLPMNtoJTNSp8S/qz3b6I9W+u3WVgz7Xm
 glA6mAwxw19G2dJjLs7cVuDeX7oKVhog/sV3qvaw=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <28002e94-fd28-426a-bee8-b67631a5270a@yandex-team.ru>
Date: Wed, 22 Oct 2025 09:58:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] migration: vmsd errp handlers: return bool
To: Markus Armbruster <armbru@redhat.com>
Cc: peterx@redhat.com, stefanb@linux.vnet.ibm.com, farosas@suse.de,
 qemu-devel@nongnu.org, berrange@redhat.com
References: <20251020160344.2401137-1-vsementsov@yandex-team.ru>
 <20251020160344.2401137-3-vsementsov@yandex-team.ru>
 <9064223d-6f35-4023-b5b6-99b8d766f506@yandex-team.ru>
 <87ecqviht6.fsf@pond.sub.org>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <87ecqviht6.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 22.10.25 09:14, Markus Armbruster wrote:
> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> writes:
> 
>> On 20.10.25 19:03, Vladimir Sementsov-Ogievskiy wrote:
>>> Recently we moved to returning errp. Why to keep int return value?
>>> Generally it doesn't help: you can't use in a logic of handling
>>> an error, as you are never sure, that in future the logic in
>>> the stack will not change: it may start to return another error
>>> code in the same case, or return same error code in another case.
>>> Actually, we can only rely on concrete errno code when get it
>>> _directly_ from documented library function or syscall. This way we
>>> handle for example EINTR. But later in a stack, we can only add
>>> this errno to the textual error by strerror().
>>> Let this new, recently added API be simpler and clearer, let it
>>> return simple boolean value, so we shouldn't think:
>>>     - should we handle different error codes differently
>>>       (if yes - how exactly, if no - why do we need this information?)
>>>     - should we add it to errp, or it was already added earlier in
>>>       the stack
>>
>>
>> Less aggressive commit message may be:
>>
>> Switch the new API to simple bool-returning interface, as return value
>> is not used otherwise than check is function failed or not. No logic
>> depend on concrete errno values.
> 
> Good, except it isn't quite accurate: callers include the return value
> in error messages.
> 
> They format it as a number, which is inappropriate.
> 
> If they formatted it appropriately, with strerror(), would that be
> helpful?  I *think* the answer is no.  The functions set an Error, and
> their callers prepend to that Error's message.  The original Error
> should suffice to tell what went wrong.  The prepended text's purpose is
> to add context.
> 
> I think the easiest way to make this argument is to split this patch
> into a part changing the error messages, and a part changing the return
> type.
> 

Agreed, will do.

-- 
Best regards,
Vladimir

