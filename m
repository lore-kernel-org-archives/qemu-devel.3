Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D104CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 17:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEWaE-000262-Aw; Thu, 30 Oct 2025 13:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWaC-00025p-Kc
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:37:08 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEWZx-0003uR-V4
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 13:37:08 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:7888:0:640:a8fd:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id E689280928;
 Thu, 30 Oct 2025 20:36:38 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:861::1:2b] (unknown
 [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id aajZ9N0GqCg0-xjtNbcHp; Thu, 30 Oct 2025 20:36:38 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761845798;
 bh=ZFvmyumDTonWef7FF7L4UhOqzXSfecDzFKGEtqBHGB4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=jvQr7/gFAcZrkZMvBC3LS8u5LeByOaajfQ0Fi5nsKGlJaMkY2bv90AtSd/4tYmITb
 kYDq4tGiLnPnyXrtqWZe1JtoCVzV64sBEm1VL+gPHzhvWtiCbaySBinqYFF/8vgDEj
 lQeyGFiI5fqQKq60VEbNE+tf1rVY7lj3VOErmTBE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0ded12d3-c7b6-4fec-98e7-ea9fda425d36@yandex-team.ru>
Date: Thu, 30 Oct 2025 20:36:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 00/22] migration: convert vmstate_load/save_state
To: Peter Xu <peterx@redhat.com>
Cc: armbru@redhat.com, qemu-devel@nongnu.org, Fabiano Rosas
 <farosas@suse.de>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20251028231347.194844-1-vsementsov@yandex-team.ru>
 <aQOc7ogTLqs8iML0@x1.local> <aQOeHqILFfBdlhJb@x1.local>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <aQOeHqILFfBdlhJb@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

On 30.10.25 20:19, Peter Xu wrote:
> On Thu, Oct 30, 2025 at 01:14:22PM -0400, Peter Xu wrote:
>> On Wed, Oct 29, 2025 at 02:13:24AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>>> Hi all!
>>>
>>> That's a proof-of-concept for converting vmstate_load/save_state
>>> to have boolean error value, to fixup this analysis
>>>    https://lore.kernel.org/qemu-devel/aQDdRn8t0B8oE3gf@x1.local/
>>> in code.
>>>
>>> As many of .get / .set handlers call vmstate_load/save_state,
>>> let's convert them too, it not too much.
>>>
>>> And finally, while touching each file, let's also use
>>> new pre/post _errp() APIs.
>>>
>>> So, this series propagate a lot of errors through errp, which
>>> were simply printed out before.
>>>
>>> Why it is an RFC:
>>> 1. I didn't yet double check the accuracy of all patches
>>> 2. Maybe, commit messages need to be more detailed, maybe they
>>> need more arguments about correctness of the change
>>> 3. Maybe, it's better first merge new generic interfaces, and
>>> than send per-maintainer small series, to avoid this huge
>>> series, depending on many maintainers.
>>>
>>> So, I don't include in CC many maintainers now, to get a first
>>> look from Markus and Peter.
>>
>> It's still good to collect more opinions on especially rfc series, even if
>> the list doesn't need to include maintainers for each device. I added
>> Fabiano and Dan too.
>>
>>>
>>> What do you think?
>>
>> In general.. I liked it. :) Thanks for trying it.
> 
> Oh wait, so this is still not the full list of what needs to be done?
> After I applied your patchset, I still see:
> 
> $ git grep -E "\.get | \.set " | wc -l
> 214
> 
> Some of them are outliers but most of them look not.. :(
> 

I think, they are qdev properties, not VMStateInfo. In this series I do
remove old .get / .set interfaces, and compilation still works for me..

Maybe some modules are not included into my build config? Unfortunately yes:

> git grep -A 5 'VMStateInfo .* = {' | grep '\.get' | awk '{print $1}' | sort | uniq
hw/usb/redirect.c-
target/alpha/machine.c-
target/arm/machine.c-
target/avr/machine.c-
target/hppa/machine.c-
target/microblaze/machine.c-
target/mips/system/machine.c-
target/openrisc/machine.c-
target/ppc/machine.c-
target/sparc/machine.c-


That's 10 more commits. And the whole series would be 32, involving many people..

I think, I'll resend only migration/* commits as "part I", except for 20/22 (to save
old interfaces too), and then other parts in separate smaller series.


-- 
Best regards,
Vladimir

