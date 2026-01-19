Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67EA4D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 15:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhrBG-0003ty-IR; Mon, 19 Jan 2026 10:28:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhrB8-0003pu-Fy; Mon, 19 Jan 2026 10:28:30 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhrB5-0007Z9-KK; Mon, 19 Jan 2026 10:28:30 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 0E86EC000F;
 Mon, 19 Jan 2026 18:28:23 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:934::1:38] (unknown
 [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id LSbnDW0C5mI0-FUh2Jys2; Mon, 19 Jan 2026 18:28:22 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768836502;
 bh=3G8+QHHhwUk7AsWOthTtTOJlbFCTw3+4fGkpVybIDx4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=Lj+vpFheXfFbsH0n3WCQGrLLw8rkjzuwYjRqcJDMgGPsSYoJLl+/eUZHjuiT6sXCU
 5nWKkdyOMUagkH13BUAwi0GU2wmNcCpQYlHvJKuDrhdsa3SjUxIFlMEp0H/k3YsEoO
 V1uJ58tIdZJ+sXQbXgNUf0zbF9tFJkxCwviRta+o=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <0e2a9f8d-c6f4-43dd-936d-4d977d427b96@yandex-team.ru>
Date: Mon, 19 Jan 2026 18:28:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block/mirror: check range when setting zero bitmap for
 sync write
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com, qemu-stable@nongnu.org,
 eblake@redhat.com
References: <20260112152544.261923-1-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20260112152544.261923-1-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

On 12.01.26 18:23, Fiona Ebner wrote:
> Some Proxmox users reported an occasional assertion failure [0][1] in
> busy VMs when using drive mirror with active mode. In particular, the
> failure may occur for zero writes shorter than the job granularity:
> 
>> #0  0x00007b421154b507 in abort ()
>> #1  0x00007b421154b420 in ?? ()
>> #2  0x0000641c582e061f in bitmap_set (map=0x7b4204014e00, start=14, nr=-1)
>> #3  0x0000641c58062824 in do_sync_target_write (job=0x641c7e73d1e0,
>>        method=MIRROR_METHOD_ZERO, offset=852480, bytes=4096, qiov=0x0, flags=0)
>> #4  0x0000641c58062250 in bdrv_mirror_top_do_write (bs=0x641c7e62e1f0,
>          method=MIRROR_METHOD_ZERO, copy_to_target=true, offset=852480,
>          bytes=4096, qiov=0x0, flags=0)
>> #5  0x0000641c58061f31 in bdrv_mirror_top_pwrite_zeroes (bs=0x641c7e62e1f0,
>          offset=852480, bytes=4096, flags=0)
> 
> The range for the dirty bitmap described by dirty_bitmap_offset and
> dirty_bitmap_end is narrower than the original range and in fact,
> dirty_bitmap_end might be smaller than dirty_bitmap_offset. There
> already is a check for 'dirty_bitmap_offset < dirty_bitmap_end' before
> resetting the dirty bitmap. Add such a check for setting the zero
> bitmap too, which uses the same narrower range.
> 
> [0]: https://forum.proxmox.com/threads/177981/
> [1]: https://bugzilla.proxmox.com/show_bug.cgi?id=7222
> 
> Cc: qemu-stable@nongnu.org
> Fixes: 7e277545b9 ("mirror: Skip writing zeroes when target is already zero")
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks for fixing! Adding a test would be great still.

Would be good if someone take it into larger PULL request, but if not I'll do.
Queued in my block branch.

-- 
Best regards,
Vladimir

