Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2911AC369AB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Apr 2025 06:16:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u6kRa-0008Ta-Cq; Mon, 21 Apr 2025 02:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u6kRY-0008R4-0L; Mon, 21 Apr 2025 02:15:48 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u6kRU-0004zF-Ns; Mon, 21 Apr 2025 02:15:47 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:cca4:0:640:432b:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 3461060B85;
 Mon, 21 Apr 2025 09:15:34 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:166::1:b] (unknown [2a02:6bf:8080:166::1:b])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id XFGQ810FcSw0-EEZ5fgY3; Mon, 21 Apr 2025 09:15:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1745216133;
 bh=VLLi3vWWCoKIsotxldAp4w14xFvlYW7xAtuLpF3W6do=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=dVXoeHvmWQ7LdAQW2H/pympMgeGmKwFOejUomRfjKCkV0Cw3SydeZzq4n0MdCDjk8
 rVdxQJQsjLF4DyUS4AssfPcUkJFXoFNdkZvq386qmEVxEVBtK1dvLMPAvnX4a518v7
 Hxb1YPlakmVDdqSmkbHiz1K3W0u2+/jmHf4iVvgE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <d6bbeeed-2733-4211-a3a8-3e467289b4f7@yandex-team.ru>
Date: Mon, 21 Apr 2025 09:15:33 +0300
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
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <k2owyvfkfsj6kkbd2bkgk5jjepxf2gexllc7pfednxrzezlgc6@lh4ebgd7kl3a>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On 17.04.25 00:51, Eric Blake wrote:
> (a write zeroes that fails AND causes the disk to no longer read as
> zero should not happen)

I don't know, is there such a contract? write-zeroes may fallback to write(), which only state that:

        An error return value while performing write() using direct I/O
        does not mean the entire write has failed.  Partial data may be
        written and the data at the file offset on which the write() was
        attempted should be considered inconsistent.

So, I used to think that on failed write nothing is guaranteed.

What do we lose if we just unset the bitmap before write-zeroes, and set it again in case of success?

-- 
Best regards,
Vladimir


