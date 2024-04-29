Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FE2C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 14:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1SNC-0000EJ-Fm; Mon, 29 Apr 2024 10:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1SN3-00008x-Sm; Mon, 29 Apr 2024 10:52:45 -0400
Received: from forwardcorp1c.mail.yandex.net
 ([2a02:6b8:c03:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1s1SN1-0007s6-1I; Mon, 29 Apr 2024 10:52:45 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:290f:0:640:2b99:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 9E15C60B7D;
 Mon, 29 Apr 2024 17:52:36 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b739::1:30] (unknown
 [2a02:6b8:b081:b739::1:30])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ZqRkda1IYa60-lWvxGRgd; Mon, 29 Apr 2024 17:52:36 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1714402356;
 bh=jP1AwgraG/qNw7CSc11Q5FYlvHI/uXmTN52mORVCPRw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=boRX9mGcPWSLvrvynNnlzDH4MPbu019mXQ6I7kgeyhXkM5yugM74iYd8XgQ6gut63
 KnYrY84mPuGhiQb3Ed6CpnWkGnq4YpLGSYCQGx8oqHrpB34oyru6hNLO0GBG95+4mv
 bq3nWX2TxXvXB7Zl8s+9BQBo6EpwFPF+CJT0yhA8=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <ad3b28cb-e7d2-4428-8540-414eb7ec623c@yandex-team.ru>
Date: Mon, 29 Apr 2024 17:52:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/copy-before-write: use uint64_t for timeout in
 nanoseconds
To: Fiona Ebner <f.ebner@proxmox.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, qemu-stable@nongnu.org, hreitz@redhat.com,
 kwolf@redhat.com, jsnow@redhat.com, f.weber@proxmox.com
References: <20240429141934.442154-1-f.ebner@proxmox.com>
 <befd2718-526e-4407-8620-476dfa290c48@linaro.org>
 <95aa152a-9858-4d71-aea9-8973e8d03f44@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <95aa152a-9858-4d71-aea9-8973e8d03f44@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c03:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 29.04.24 17:46, Fiona Ebner wrote:
> Am 29.04.24 um 16:36 schrieb Philippe Mathieu-Daudé:
>> Hi Fiona,
>>
>> On 29/4/24 16:19, Fiona Ebner wrote:
>>
>> Not everybody uses an email client that shows the patch content just
>> after the subject (your first lines wasn't making sense at first).
>>
>> Simply duplicating the subject helps to understand:
>>
>>    Use uint64_t for timeout in nanoseconds ...
>>
> 
> Oh, sorry. I'll try to remember that for the future. Should I re-send as
> a v2?
> 

Not necessary, I can touch up the message when applying to my block branch.

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


