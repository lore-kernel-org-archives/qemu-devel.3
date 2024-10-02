Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E95CF31AE
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svwC9-0004VY-Lp; Wed, 02 Oct 2024 06:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svwC6-0004Uk-K7; Wed, 02 Oct 2024 06:02:55 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1svwC3-0006Lc-Jz; Wed, 02 Oct 2024 06:02:53 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:2e8b:0:640:9795:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id BFE4F60AA8;
 Wed,  2 Oct 2024 13:02:46 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:8026::1:2f] (unknown
 [2a02:6b8:b081:8026::1:2f])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id i2YN801IXGk0-5Iax8LYE; Wed, 02 Oct 2024 13:02:45 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1727863365;
 bh=/4sF+W7qjwLICHbD2V0te1FTlaxtlEqSN1kEajrJfAc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=gBw6WEO/kGk2ps6Weae/it5NTl4mlZJLRPrDQ+75hjkGkoJLgKAMDY/Xl3HCfc5V5
 NIALb6cSEKi/c1yjGm5kNxwfpdccN93SmzY9aRZTV4g3H6E1iba3z/31wdXMZHhwiK
 GNTcH0fea6yfuIpzP5K3O5VvGKMmIbpkLjv+kL+s=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <a707bfb3-5180-433f-bf35-018575e1bd7e@yandex-team.ru>
Date: Wed, 2 Oct 2024 13:02:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] block: add test non-active commit with zeroed data
To: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
References: <20240901142405.3183874-1-libvirt-e6954efa@volkihar.be>
 <20240901142405.3183874-6-libvirt-e6954efa@volkihar.be>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240901142405.3183874-6-libvirt-e6954efa@volkihar.be>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Yandex-Filter: 1
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

On 01.09.24 17:24, Vincent Vanlaer wrote:
> Signed-off-by: Vincent Vanlaer <libvirt-e6954efa@volkihar.be>
> ---
>   tests/qemu-iotests/315     | 95 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/315.out | 54 ++++++++++++++++++++++

Please place new tests in tests/qemu-iotests/tests, with human readable name, something like commit-zeroes or what you want.

>   2 files changed, 149 insertions(+)
>   create mode 100755 tests/qemu-iotests/315
>   create mode 100644 tests/qemu-iotests/315.out
> 
> diff --git a/tests/qemu-iotests/315 b/tests/qemu-iotests/315
> new file mode 100755
> index 0000000000..84865f8001
> --- /dev/null
> +++ b/tests/qemu-iotests/315
> @@ -0,0 +1,95 @@
> +#!/usr/bin/env bash
> +# group: rw quick
> +#
> +# Test for commit of discarded blocks
> +#
> +# This tests committing a live snapshot where some of the blocks that
> +# are present in the base image are discarded in the intermediate image.
> +# This intends to check that these blocks are also discarded in the base
> +# image after the commit.
> +#
> +# Copyright (C) 2024 Vincent Vanlaer.
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License as published by
> +# the Free Software Foundation; either version 2 of the License, or
> +# (at your option) any later version.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program.  If not, see <http://www.gnu.org/licenses/>.
> +#
> +# creator
> +owner=libvirt-e6954efa@volkihar.be
> +
> +seq=`basename $0`
> +echo "QA output created by $seq"
> +
> +status=1	# failure is the default!
> +
> +_cleanup()
> +{
> +    _cleanup_qemu
> +    _rm_test_img "${TEST_IMG}.base"
> +    _rm_test_img "${TEST_IMG}.mid"
> +    _cleanup_test_img
> +}
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +# get standard environment, filters and checks

Example of bash test in tests is tests/qemu-iotests/tests/qemu-img-bitmaps, so you'll need "cd .." here, before ". ./common.rc"

I know, this all looks not optimal, but still, human-readable names are much better than numbers.

With that:

Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

> +. ./common.rc
> +. ./common.filter
> +. ./common.qemu
> +


-- 
Best regards,
Vladimir


