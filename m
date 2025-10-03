Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16338CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 07:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4aeo-0001mC-DB; Fri, 03 Oct 2025 03:56:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v4aen-0001lC-4h; Fri, 03 Oct 2025 03:56:49 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1v4aed-0002tP-Km; Fri, 03 Oct 2025 03:56:46 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:8982:0:640:5cf4:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 60F67804EC;
 Fri, 03 Oct 2025 10:56:29 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:589::1:33] (unknown
 [2a02:6bf:8080:589::1:33])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id SubIqL2Gv0U0-wP8mOEFQ; Fri, 03 Oct 2025 10:56:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1759478188;
 bh=D7DqFhp7634hu7hAl+sPoqs4WOJ2cS1JYequwsEoSgU=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=FrgD/H8kD+Pats/EIFl1YeGteWFM+mQBMTmEiyBhF2WKjVSxdnY/I5+rZoaOsRn50
 1S+8Pf8gaidCse2r/45LUqcYbirrVhXu3WusptmGK+6WpTMW+sv7KFJlVrfy4CdVTf
 Zx122EPZq980PDI/zwiYkQjS8Mv3GuHyuLrVRioU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <306a4001-3756-434a-ae3a-5e817d3d405f@yandex-team.ru>
Date: Fri, 3 Oct 2025 10:56:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: use pwrite_zeroes_alignment when writing first
 sector
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Jean-Louis Dupond <jean-louis@dupond.be>, Hanna Reitz <hreitz@redhat.com>
References: <20251002184000.410486-1-stefanha@redhat.com>
 <20251002184000.410486-3-stefanha@redhat.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20251002184000.410486-3-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

On 02.10.25 21:39, Stefan Hajnoczi wrote:
> Since commit 5634622bcb33 ("file-posix: allow BLKZEROOUT with -t
> writeback"), qemu-img create errors out on a Linux loop block device
> with a 4 KB sector size:
> 
>    # dd if=/dev/zero of=blockfile bs=1M count=1024
>    # losetup --sector-size 4096 /dev/loop0 blockfile
>    # qemu-img create -f raw /dev/loop0 1G
>    Formatting '/dev/loop0', fmt=raw size=1073741824
>    qemu-img: /dev/loop0: Failed to clear the new image's first sector: Invalid argument
> 
> Use the pwrite_zeroes_alignment block limit to avoid misaligned
> fallocate(2) or ioctl(BLKZEROOUT) in the block/file-posix.c block
> driver.
> 
> Fixes: 5634622bcb33 ("file-posix: allow BLKZEROOUT with -t writeback")
> Reported-by: Jean-Louis Dupond<jean-louis@dupond.be>
> Buglink:https://gitlab.com/qemu-project/qemu/-/issues/3127
> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>


Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

-- 
Best regards,
Vladimir

