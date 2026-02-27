Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF55FD530C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 08:14:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvszf-0002iM-Cl; Fri, 27 Feb 2026 03:14:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vvszd-0002i0-Bn
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:14:37 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1vvszb-0003iY-34
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 03:14:37 -0500
Received: from mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c37:8aa5:0:640:e6ae:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 0821F80775;
 Fri, 27 Feb 2026 11:14:28 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:458::1:5] (unknown [2a02:6bf:8080:458::1:5])
 by mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id QEeYZ78AmKo0-vO35GJy8; Fri, 27 Feb 2026 11:14:27 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1772180067;
 bh=30M6I7sMpUhZxu4NazAWg7ggH/5pwlBCRUZtTtxbGaw=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=OOcRpULQcEmcfvHCDQ3g+8gBwFmAW9x8Z3aBTrcyjg3ptufLjP7CqzCvVTU1US3PT
 EXeMPzHLAFb+JsiwiSnV/u9VBQAAISWHkuPmui3Z6Yj/gcQLNDIGfwrnfXYa+WEzes
 VbrvXmK6hiRnZHu1kR6lvK29//bG/MtW/nvKJz+k=
Authentication-Results: mail-nwsmtp-smtp-corp-canary-81.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <8614c317-8643-4243-abe4-9653e40149a2@yandex-team.ru>
Date: Fri, 27 Feb 2026 13:14:28 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vmstate: fix subsection load name check
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>
References: <20260220102628.459681-1-dtalexundeer@yandex-team.ru>
 <aZyjaw8Pz-xvZ3AZ@x1.local>
 <f4e728fc-40a7-4c25-8681-ca64eb1657f2@yandex-team.ru>
 <aZ3OQLHuYy0zEK76@x1.local>
 <819b9493-327b-4765-bbd9-c592cd3cfcdd@yandex-team.ru>
 <aZ8wGsxhkD76LRBD@x1.local>
 <ee35b828-c8e9-4850-be64-72d0842b2dde@yandex-team.ru>
 <aaBkwvYFNKqGjrrX@x1.local>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <aaBkwvYFNKqGjrrX@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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


On 2/26/26 20:20, Peter Xu wrote:
> On Thu, Feb 26, 2026 at 12:47:55PM +0500, Alexandr Moshkov wrote:
>> Yes, looks like it happens because migration stream for "virtio-blk" looks
>> like this:
>>
>> [virtio-blk header] [virtio-blk fields] [virtio-blk subsections]
>>
>> "virtio-blk" contains "virtio" field, so migration stream is:
>>
>> [virtio-blk header] [virtio header] [virtio fields] [virtio subsections]
>> [virtio-blk subsections]
>>
>> And when we load the subsections of the "virtio" device,
>> vmstate_subsection_load() uses qemu_peek_byte() to try to figure out if this
>> is his subsection. This is where we encounter an error.
>>
>> Thus, the error occurs due to the fact that vmsd does not know how many
>> subsections it has when loading (this does not appear anywhere in the
>> migration stream), so it tries to load all the appropriate ones by names.
> OK I see, thanks for the details.
>
> I think I missed one important thing, that we don't treat
> trace_vmstate_subsection_load_bad("(prefix)") as errors.. instead we
> fallback to the upper layer by returning zero.
>
> Could you put most of above reply into the commit message?  I think it may
> help people understand the commit.
>
> We could also add one comment right above the extra "/" check in code, to
> make sure nobody will accidentally remove it.
>
> Thanks,
>
Okay, I'll do that. Thanks!

