Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5202ECCF9EB
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 20:57:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDUFj-00060l-GH; Mon, 27 Oct 2025 16:55:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDUFf-000605-4i; Mon, 27 Oct 2025 16:55:39 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vDUFV-0001yw-GE; Mon, 27 Oct 2025 16:55:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2d:7394:0:640:5a8a:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 41E1AC05B8;
 Mon, 27 Oct 2025 23:55:19 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c5c::1:11] (unknown
 [2a02:6bf:8080:c5c::1:11])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id ItjTFc1L2mI0-Rv3YXlot; Mon, 27 Oct 2025 23:55:18 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761598518;
 bh=uB3Tx0IskXOo1yZQih2MPrhBcfUYjNlRl6VKYPEQWfc=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=y4HmTaOVzzl5NS/Kn8WwkSkiRjPz8+hLd4qEJg+WWj5zfGmy1FeAjj3pN94wk2oTL
 XeTxJmBwOnjpHw0mtcqXwXpA4bg4GBw2baKeYJ8ybNRNxgzoEaQ4639cfzloA8TqnW
 IYcWLA55GjGMRDK/E3nQT2hroyXFx4WQqEjrMwFU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <64465d5a-7588-4a7e-a751-28259f1d6748@yandex-team.ru>
Date: Mon, 27 Oct 2025 23:55:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: Add missing null checks during
 query-named-block-nodes
To: Wesley Hershberger <wesley.hershberger@canonical.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20251024-second-fix-3149-v1-1-d997fa3d5ce2@canonical.com>
 <aP9BhBEUSuM0ougc@redhat.com>
 <CADzzt1B4ZwRwv+ZCWyGwyZwqScHAfKkbL2UEaujd3BJNSkMbXg@mail.gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CADzzt1B4ZwRwv+ZCWyGwyZwqScHAfKkbL2UEaujd3BJNSkMbXg@mail.gmail.com>
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

On 27.10.25 19:04, Wesley Hershberger wrote:
> (I've run make check-block with it and saw no failures).

When changing internals of block-layer, it's better to run all iotests, at least for qcow2, raw and nbd. check-block runs only subset.

Like

cd build
./tests/qemu-iotests/check -qcow2
./tests/qemu-iotests/check -raw
./tests/qemu-iotests/check -nbd


At least,

    ./tests/qemu-iotests/check -qcow2 257

fails with your diff.

-- 
Best regards,
Vladimir

