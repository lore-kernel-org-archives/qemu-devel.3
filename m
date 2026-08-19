Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDB1FC5DF86
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwfhd-0005yg-T8; Wed, 19 Aug 2026 08:47:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwfhb-0005y1-KX; Wed, 19 Aug 2026 08:47:31 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1wwfhZ-0006oR-Kg; Wed, 19 Aug 2026 08:47:31 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (postfix) with ESMTPS id ED377C015C;
 Wed, 19 Aug 2026 15:47:24 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c60::1:5] (unknown [2a02:6bf:8080:c60::1:5])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id OlVhXODWR4Y0-adMHKH4c; Wed, 19 Aug 2026 15:47:24 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1787143644;
 bh=mvicUxd39TqrIAxnBjCD5MSvP7pkYDclxJqMyt4jWW4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=R/ql843Y5RFrLjXeB9mXelNALrFkL4Y0E39as2yzdUgNVaFrlM0emjFitvgZNJOL6
 P/YBttxb/x3LsMdVZCPZirehK/MAvXGhsd8R5SyDpsmLdgvK3nwzM/xu4KQtFMUcmi
 uJIXvWp78/TOQMMM78RBqVyoPWBZeATLWW7Gsdhs=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e122fce0-d6fa-4ffb-acf7-5ec24cebeaf7@yandex-team.ru>
Date: Wed, 19 Aug 2026 15:47:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/6] block: jobs and dirty-bitmaps
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, den@openvz.org, QEMU Stable <qemu-stable@nongnu.org>
References: <20260817192948.1743452-1-vsementsov@yandex-team.ru>
 <e617c1d0-b028-449d-b8b1-bb96a47e64c6@tls.msk.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <e617c1d0-b028-449d-b8b1-bb96a47e64c6@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 18.08.26 09:42, Michael Tokarev wrote:
> On 8/17/26 22:29, Vladimir Sementsov-Ogievskiy wrote:
> 
>> block-jobs and dirty-bitmaps patches
>>
>> Denis V. Lunev (6):
>>        job: keep job paused across overlapping pause requests
>>        tests/unit/test-blockjob: cover keeping a job paused while a pause is pending
>>        block/monitor: reject persistent bitmap add on a read-only node
>>        migration/block-dirty-bitmap: reject bitmap load onto ro node
>>        block/monitor: allow dropping a bitmap never stored on disk
>>        dirty-bitmap: fix integer overflow in serialization coverage
> 
> This seems to be another pull request which should be picked up for
> active qemu stable series.  Is it not?
> 
> Thanks,
> 
I'm not sure. All these bugs are not degradations, we live with them for a very long time.
And most of the changes are a bit risky, so IMHO, they are better to go through
more careful testing at vendor level (like when moving to a new QEMU version, not to
next stable subversion).

01,02 - bug fix in core job engine, which was not touched for a long time, may have
unexpected effects.

03-05 - not actually a bug fix, but prohibiting the user from doing strange things,
which lead to problems in future. Small risk to break some (considered incorrect)
user experience.

06 - simple bug fix, obviously safe

So, my suggestion is to take only 06 into stable branch (and even that not necessary, as
not a degradation and triggers in a very specific scenario).

-- 
Best regards,
Vladimir

