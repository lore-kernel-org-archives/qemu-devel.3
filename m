Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E17C982E6
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 17:58:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8iGy-0007I9-EL; Mon, 21 Sep 2026 13:57:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1x8iGu-0007Hs-Ev
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 13:57:45 -0400
Received: from v512.v5f06b487.use4.send.mailgun.net ([143.55.232.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1)
 (envelope-from <bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev>)
 id 1x8iGs-0007tj-EP
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 13:57:44 -0400
X-Mailgun-Sid: WyI4ZDFlNiIsInFlbXUtZGV2ZWxAbm9uZ251Lm9yZyIsIjk3NjA3ZSJd
Received: from mail.yodel.dev (mail.yodel.dev [35.209.39.246]) by
 576437c8db99982fa33e0f716f56e938e93dad40c75ff03fc9dccb9a14de1d6f with SMTP id
 6ab1700c2d4e6169ed506cdc; Mon, 21 Sep 2026 17:57:32 GMT
X-Mailgun-Sending-Ip: 143.55.232.12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yodel.dev;
 s=rsa2048; t=1790013451;
 bh=g9SadYw/hJglduQ8ENe08mpJGhxM+FU6nfzWVFK8rcQ=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 X-Mailgun-Dkim:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:From:Reply-to:Subject:Date:Message-id:To:
 Cc:Mime-version:Content-type:Content-transfer-encoding:In-reply-to:
 References;
 b=JXQn1AN+ZtrAQEEs4oz0qtK0UBRlHgKnv1H2ms5K6KJ/m5BZxNgoHcJNDkWRqyP7a
 dWczd642uAgy93aGUszqv0Dp1G1KA8dDMAnYlZZU6vCJEz+YBSgqY0+KYWO3a54iCa
 zGWM/qIPF9aDAYjjvskv13I1rJOv4CbkJ8GXElqacoGfmkBMB1PmHGHhbZAynCSlt0
 6N/YBDYu0xOC0fLIOgwYGwy4vh3WsIqD4tHei3NAhb076A9pzjfBl4KPisNju+Qm4Y
 Xg46W4AvAIXu/xTlglS600YAj4HiqTjeTksjzuUNXdCCguQF3wFe1/dHD3mZclchNG
 tGoI2MYqKLp9Q==
Message-ID: <42c74a3c-5ac7-4af6-b06e-e3d8669f82ee@yodel.dev>
Date: Mon, 21 Sep 2026 12:57:30 -0500
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] vhost-user-bridge: Fix stdbuf and ASAN interaction
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
References: <20260914165250.88382-1-yodel.eldar@yodel.dev>
Content-Language: en-US
X-Mailgun-Dkim: no
X-Mailgun-Dkim: no
From: Yodel Eldar <yodel.eldar@yodel.dev>
Autocrypt: addr=yodel.eldar@yodel.dev; keydata=
 xjMEZxqXdhYJKwYBBAHaRw8BAQdAkletQdG3CLyANZyuf2t7Z9PK4b6HiT+DdSPUB2mHzmPN
 I1lvZGVsIEVsZGFyIDx5b2RlbC5lbGRhckB5b2RlbC5kZXY+wpkEExYKAEECGwMFCQOcG00F
 CwkIBwIGFQoJCAsCBBYCAwECHgECF4AWIQTTzRjNQG27imap+N+V7k+3NmVNrAUCaNWASwIZ
 AQAKCRCV7k+3NmVNrNnSAPoDjQXa6v7ZzdQSaLdRfAQy/5SsUucv+zp3WAP4pXdgJQEAzMMC
 Ctx4l6b13Fs2hZdRXEnF/4BZ9t1K68nwzZOV3QnOOARnGpd2EgorBgEEAZdVAQUBAQdAKPIy
 3W/DKFsm1e+31zoqmOY0pqz8vjIM846wM6lEY2QDAQgHwn4EGBYIACYCGwwWIQTTzRjNQG27
 imap+N+V7k+3NmVNrAUCaNWG7QUJA5wi9wAKCRCV7k+3NmVNrPusAQCQDQwETy7VT6UhHPho
 TkrQnsNqQfFU3tXqCTiViToktQD7B/U2/to97hQIJCWbK6yd3T+KPZJPMcHMg2XRyedUvgA=
In-Reply-To: <20260914165250.88382-1-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=143.55.232.12;
 envelope-from=bounce+0e9322.97607e-qemu-devel=nongnu.org@yodel.dev;
 helo=v512.v5f06b487.use4.send.mailgun.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HELO_STATIC_HOST=-0.001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

Hi,

On 14/09/2026 11:52, Yodel Eldar wrote:
> From: Yodel Eldar <yodel.eldar@yodel.dev>
> 
> Hi,
> 
> As reported by Marc-André in (1), the functional test of
> vhost-user-bridge (vubr) encounters a runtime error when
> vubr is built with ASAN, because the "ASan runtime does
> not come first in initial library list."
> 
> Upon Michael's suggestion, this series converts the DPRINT
> debug output macro in vubr to use stderr instead of stdout
> for output. With that change, the functional test no longer
> needs to invoke stdbuf, so it is removed.
> 
> Thanks,
> Yodel
> 
> (1) https://lore.kernel.org/qemu-devel/20260906-nohmp-next-v1-2-2b21e63974f3@redhat.com/
> 
> Yodel Eldar (2):
>    contrib/vhost-user-bridge: Use stderr for debug output
>    tests/functional/x86_64/test_vhost_user_bridge: Eliminate stdbuf usage
> 
>   contrib/vhost-user-bridge/vhost-user-bridge.c     | 2 +-
>   tests/functional/x86_64/test_vhost_user_bridge.py | 6 ------
>   2 files changed, 1 insertion(+), 7 deletions(-)
> 

Ping?

Note: Series is fully reviewed (thanks Marc-André).

Link:
https://lore.kernel.org/qemu-devel/20260914165250.88382-1-yodel.eldar@yodel.dev/

Thanks,
Yodel

