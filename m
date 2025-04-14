Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD96C3601E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 07:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4DqL-0006qT-Mf; Mon, 14 Apr 2025 03:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4Dq5-0006q1-Gt; Mon, 14 Apr 2025 03:02:41 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u4Dq1-0005GT-Us; Mon, 14 Apr 2025 03:02:41 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:471f:0:640:4191:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 8C3F160AC5;
 Mon, 14 Apr 2025 10:02:30 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b4ae::1:27] (unknown
 [2a02:6b8:b081:b4ae::1:27])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id T2Apg56FbCg0-lztRIasS; Mon, 14 Apr 2025 10:02:29 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744614149;
 bh=sn/b7/evmzcYPY5TJkMoa6sA1Ov+pseQUwd0sdgfp54=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=BXax2ipTtX1GjKHlQ0EYxkVMDy7xmQ3ZbDa/xmvpSlHtgFc3oAQeamPPbqajsOjRu
 3vLvBUwXHIIp2RndYSJv9GAaGBrt+C0KNfemFP8DTBx2D+CKRQ8doXxXOsBCiNjPzd
 h6R1l+JDYBvYSZivneOsKlepeFoHRNg0oIGHu5Z0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <5e9f5824-984b-4a6f-b26b-614be0460c2a@yandex-team.ru>
Date: Mon, 14 Apr 2025 10:02:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] blockdev-backup: Add error handling option for
 copy-before-write jobs
To: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Markus Armbruster
 <armbru@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20250304091703.462342-1-Raman.Dzehtsiar@gmail.com>
 <3806d9f0-c689-47fa-a0cb-37b9c33685b2@yandex-team.ru>
 <CA+uc5a0wB54KixsKqF10njhfcZd9xkwWiPQoofZFjQ8+LsDBLA@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CA+uc5a0wB54KixsKqF10njhfcZd9xkwWiPQoofZFjQ8+LsDBLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 14.04.25 04:30, Raman Dzehtsiar wrote:
> Hi Vladimir,
> Thank you for your review.
> 
>> The patch looks good to me. Still, could you also provide a test for a new option?
>> Probably the simplest would be add a test-case to `tests/qemu-iotests/tests/copy-before-write`, where existing on-cbw-error option is tested. Or you can make a separate test.
> 
> I've added test cases to the `copy-before-write` test to cover the new
> option. The changes are included in v3 of the patch.
> Would appreciate it if you could take another look.

Will do

> Still hoping it
> can make it into v10.
> 

10.0 - unfortunately, impossible. It's frozen (for new features) since March 11, and should be released tomorrow or a week later. See planning here: https://wiki.qemu.org/Planning/10.0
10.1 is a target for the series.

-- 
Best regards,
Vladimir


