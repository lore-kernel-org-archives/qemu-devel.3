Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3779EC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 10:11:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzAbV-0003be-MF; Wed, 26 Aug 2026 06:11:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wzAbU-0003XT-6T; Wed, 26 Aug 2026 06:11:32 -0400
Received: from apollo.dupie.be ([2001:bc8:3f2a:101::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-louis@dupond.be>)
 id 1wzAbR-0006V3-Pe; Wed, 26 Aug 2026 06:11:31 -0400
Received: from [IPV6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1] (unknown
 [IPv6:2a02:a03f:fafb:301:46c3:62e6:fe62:23a1])
 by apollo.dupie.be (Postfix) with ESMTPSA id 707F01520CCD;
 Wed, 26 Aug 2026 12:11:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
 t=1787739087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b2/M5zI/Fn2odn1pbBrpI9W+spPFuAX5kIi3lkyFgkA=;
 b=bykrc/MwFQu0+AOeCffTTJgXj2QWTPUnQ+sA8MxRk7Vnzp/MUYrMOAzkPjJSChBy/nd+2b
 /3eQzNbyvncBPNuf8SoZJ90D0xHKfRSQ4wu5P9hZgteW+YIJvBliPzhUp41LWVvrnRqWs7
 YKdwjYH3Fbb0UKcvc4p6CMOJ2MXdasKKIBfCKRvMsnmAyyj8JFJpkRFHolqMEBbRMUcYFs
 BkY0fDN2brLb9XR0NCRAD2hxEQ1LDYaha05b8UvJRrknLx0lGpnWJWdk2Z8B3yIJ4aPhg1
 cfe+KMzehq+YCP/9M2WymWK/jGJ2zRgnLRSqB0ANL4Yp2rcS01S2UUSc6FlrIA==
Message-ID: <6c1c2b3f-20f2-4327-b45d-f7c8102ff70c@dupond.be>
Date: Wed, 26 Aug 2026 12:11:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] qcow2: add functionality to repair bitmaps
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20260713081304.84812-1-jean-louis@dupond.be>
 <20260713081304.84812-2-jean-louis@dupond.be>
 <34805728-b3a6-4efb-a52d-ca444c9e816a@dupond.be>
 <3090fe4a-2545-4292-a43a-fb450ae3f9e8@yandex-team.ru>
Content-Language: en-US, en-GB, nl-BE
From: Jean-Louis Dupond <jean-louis@dupond.be>
In-Reply-To: <3090fe4a-2545-4292-a43a-fb450ae3f9e8@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:bc8:3f2a:101::1;
 envelope-from=jean-louis@dupond.be; helo=apollo.dupie.be
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


On 26/08/2026 11:49, Vladimir Sementsov-Ogievskiy wrote:
> On 25.08.26 12:43, Jean-Louis Dupond wrote:
>> Ping for the v6 version of the patch.
>>
>> Every previous comment was addressed.
>
> Hi!
>
> Hmm. But I don't see any difference with v5.
Seems like I was not awake when posting it :)
Forgot to amend the changes ...

Send a v7 with the changes.
>
> Comparison here 
> https://patchew.org/QEMU/20260522224335.1286291-1-jean-louis@dupond.be/diff/20260713081304.84812-1-jean-louis@dupond.be/ 
> is empty.
>

Thanks!


