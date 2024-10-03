Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EA48CF855D
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 06:40:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swFVB-00043o-0P; Thu, 03 Oct 2024 02:39:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1swFV0-00042x-4u; Thu, 03 Oct 2024 02:39:42 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1swFUx-0005Eu-KF; Thu, 03 Oct 2024 02:39:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:3f48:0:640:7695:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 746B660A9D;
 Thu,  3 Oct 2024 09:39:33 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8026::1:2f] (unknown
 [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id WdVEet13U8c0-yVolwZzs; Thu, 03 Oct 2024 09:39:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727937573;
 bh=lHaXoZvDI6jKCedFFYmjg/XpcLD+HADE3BQdafxL3BM=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=af0j9SWarTVUDH+R7znk3Wu20Q4L5HvfxGyDLWGOkA4XsIrDCINNckhFIxhJGvCU4
 9Vmb3kk/L49083XRLG02kz3qW0knbHVffjih4No5qchnM4GYWuximr0e9i8HbbzAMZ
 tgaOSQr4UM8k2+adLXXvj8xxwT6NVC8YPLLNRF/U=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <db0eca3d-c90f-474e-ab17-e8f8552c1d96@yandex-team.ru>
Date: Thu, 3 Oct 2024 09:39:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fix backup-discard-source test for XFS
To: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
References: <20240620144402.65896-1-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240620144402.65896-1-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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

Hi Kevin!

Now I revisit my old series, and looking here I see that I forget add you into CC.

Does it still make sense?

On 20.06.24 17:44, Vladimir Sementsov-Ogievskiy wrote:
> Hi all!
> 
> As Kevin reported, the test doesn't work on XFS, as it rely on disk
> usage.
> 
> Fix it, switching to dirty bitmap for guest write tracking.
> 
> Vladimir Sementsov-Ogievskiy (2):
>    iotests/backup-discard-source: convert size variable to be int
>    iotests/backup-discard-source: don't use actual-size
> 
>   .../qemu-iotests/tests/backup-discard-source  | 39 ++++++++++++-------
>   1 file changed, 25 insertions(+), 14 deletions(-)
> 

-- 
Best regards,
Vladimir


