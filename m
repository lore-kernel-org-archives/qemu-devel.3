Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B60C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 09:09:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u79cV-0004rK-BA; Tue, 22 Apr 2025 05:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u79cP-0004qg-58; Tue, 22 Apr 2025 05:08:41 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u79cK-0006Th-7d; Tue, 22 Apr 2025 05:08:40 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c15:2b89:0:640:9815:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 1F3856125F;
 Tue, 22 Apr 2025 12:08:27 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:1204::1:33] (unknown
 [2a02:6b8:b081:1204::1:33])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id Q8KZJ20FUa60-Q6YujX9G; Tue, 22 Apr 2025 12:08:26 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745312906;
 bh=AIs8HIq2DzcnTzye7dff1vrbPH9QCiMn6PjpZ0Ik7jE=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=uKSWuqHk7xk3U4xu02y+Qgriph+Eu3sMHW6P1lEjIyG42bm0At5ssW1q4ddxURU8l
 MDZuCJJ05bpTlp8HvTkS6sQZ6hTXDUqMyMXS0dc5d8bp5dc9DMj3EmXPTp4bOCoXwc
 kO94CMCy2RWA7hZha4kUkQTr8ukHyTqtHnFadQGQ=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <1620ee03-cebd-4b69-8dda-7397bcd4109f@yandex-team.ru>
Date: Tue, 22 Apr 2025 12:08:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] mirror: Skip writing zeroes when target is already
 zero
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "open list:Block Jobs" <qemu-block@nongnu.org>
References: <20250411010732.358817-8-eblake@redhat.com>
 <20250411010732.358817-11-eblake@redhat.com>
 <c3044546-b921-4cbc-959d-4f23e0e3c49e@yandex-team.ru>
 <k2owyvfkfsj6kkbd2bkgk5jjepxf2gexllc7pfednxrzezlgc6@lh4ebgd7kl3a>
 <d6bbeeed-2733-4211-a3a8-3e467289b4f7@yandex-team.ru>
 <mbwvegjh4hywvewvbxwnhrgnafeh4my3jrozuslyupikaznr6u@7n2k4tke35pp>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <mbwvegjh4hywvewvbxwnhrgnafeh4my3jrozuslyupikaznr6u@7n2k4tke35pp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 21.04.25 17:41, Eric Blake wrote:
> On Mon, Apr 21, 2025 at 09:15:33AM +0300, Vladimir Sementsov-Ogievskiy wrote:
>> On 17.04.25 00:51, Eric Blake wrote:
>>> (a write zeroes that fails AND causes the disk to no longer read as
>>> zero should not happen)
>>
>> I don't know, is there such a contract? write-zeroes may fallback to write(), which only state that:
>>
>>         An error return value while performing write() using direct I/O
>>         does not mean the entire write has failed.  Partial data may be
>>         written and the data at the file offset on which the write() was
>>         attempted should be considered inconsistent.
>>
>> So, I used to think that on failed write nothing is guaranteed.
>>
>> What do we lose if we just unset the bitmap before write-zeroes, and set it again in case of success?
>>
> 
> I still don't see the point.  Either the cluster was already non-zero
> before the failed write-zero (so there's no bit to pre-clear);

[..]

> cluster was already zero before the failed write-zero, and any failure
> that corrupts the disk by actually turning zeroes into non-zero

Yes, I mean this case

> is not
> worth worrying about

And I don't follow why we should not care.

Usually we have no assumptions about data at offset, if write(offset, ..) failed. We just retry write.

Here we do this assumption "if there were zeroes, they will not be broken by writing zeroes even on failure scenarios", for any kind of block-driver and underlying file system.

You say "corrupts the disk". Of course, if disk is corrupted - everything is broken, and we should not care. The result of the mirror would be incorrect anyway. But we don't consider any EIO as disk corruption. We do retry the write and continue mirror operation.

Moreover, if EIO is returned due to some broken sector, we may hope that retrying the write will fix it, probably some other sector will be allocated by FS (I hope I'm not talking nonsense). But relying on the data still read as zero without rewriting would be wrong.

>, so pre-clearing the bit is not going to make
> things any better.
> 

-- 
Best regards,
Vladimir


