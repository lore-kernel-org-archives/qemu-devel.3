Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D69D5CF31B8
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 12:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svyfV-00038m-5V; Wed, 02 Oct 2024 08:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svyfQ-00038B-4v; Wed, 02 Oct 2024 08:41:20 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svyfK-0002Ck-MR; Wed, 02 Oct 2024 08:41:19 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2e8b:0:640:9795:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id C77456098C;
 Wed,  2 Oct 2024 15:41:07 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8026::1:2f] (unknown
 [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 6fap521IjmI0-QHBud8UZ; Wed, 02 Oct 2024 15:41:07 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727872867;
 bh=+LJLpKhHLYuMVrxQ9ct6Ys2XcVMojDWDwmumZiZCVh0=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=AXRwO3G//92RSXcF/vuHFGctZIhUG+f2FW6kTKOGCc8ko3TY02g/iKNhImQK+1g7o
 kJVjWHgL10dqf8zumCrtwRKamLk4ym4CddW4rPqoSGdqcq7hsENGOEySFp/6/Y4u4B
 AarzluQmy/ZWFAbD8U7GZ200kV6xCZw+rakiK/7E=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <2181b230-dd40-4198-a125-f7fb6e008dbb@yandex-team.ru>
Date: Wed, 2 Oct 2024 15:41:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] qemu-nbd: Allow users to adjust handshake limit
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com,
 qemu-block@nongnu.org, den@virtuozzo.com, andrey.drobyshev@virtuozzo.com,
 alexander.ivanov@virtuozzo.com
References: <20240809161828.1342831-4-eblake@redhat.com>
 <20240809161828.1342831-5-eblake@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240809161828.1342831-5-eblake@redhat.com>
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

On 09.08.24 19:14, Eric Blake wrote:
> Although defaulting the handshake limit to 10 seconds was a nice QoI
> change to weed out intentionally slow clients, it can interfere with
> integration testing done with manual NBD_OPT commands over 'nbdsh
> --opt-mode'.  Expose a command line option to allow the user to alter
> the timeout away from the default.  This option is unlikely to be used
> in enough scenarios to warrant a short option letter.
> 
> The option --handshake-limit intentionally differs from the name of
> the constant added in commit fb1c2aaa98 (limit instead of max_secs)
> and the QMP name to be added in the next commit; this is because
> typing a longer command-line name is undesirable and there is
> sufficient --help text to document the units.
> 
> Signed-off-by: Eric Blake<eblake@redhat.com>



Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir


