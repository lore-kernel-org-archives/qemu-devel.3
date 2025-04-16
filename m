Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05F6C369BD
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 11:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u51Lg-0000fv-Vj; Wed, 16 Apr 2025 07:54:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u51LZ-0000cg-UW; Wed, 16 Apr 2025 07:54:33 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1u51LS-0006fV-Gb; Wed, 16 Apr 2025 07:54:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:471f:0:640:4191:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 4C26A618C6;
 Wed, 16 Apr 2025 14:54:12 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:166::1:b] (unknown [2a02:6bf:8080:166::1:b])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 8sG0vq2FZmI0-B3wDagWx; Wed, 16 Apr 2025 14:54:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1744804450;
 bh=rtGyvQmhxSBm1WpvgkrqycH4hh00Gv7RUUcxloDxE50=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=F+qQVkj8j2OA2VoLPGJQqi4JZuoMgacyUChdaIyrT3cFjF7iB6qjbf/2C29K0lRR+
 qxdvmdG/N+XEh9hUDKfAnzee1ZhJBGBXJLJEcHMTPp3/4+zHO+d5+Sm+nMlSTFoKw/
 o21VIWBSfnOLIdfUWmohocHsfYB8bNLYOwjsFnoM=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <e24c0993-8b09-41fb-b2d4-17a9e8e0043d@yandex-team.ru>
Date: Wed, 16 Apr 2025 14:54:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] blockdev-backup: Add error handling option for
 copy-before-write jobs
To: Raman Dzehtsiar <raman.dzehtsiar@gmail.com>, qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 John Snow <jsnow@redhat.com>, Xie Changlong <xiechanglong.d@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, Markus Armbruster <armbru@redhat.com>
References: <20250414090025.828660-1-Raman.Dzehtsiar@gmail.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250414090025.828660-1-Raman.Dzehtsiar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 14.04.25 12:00, Raman Dzehtsiar wrote:
> This patch extends the blockdev-backup QMP command to allow users to specify
> how to behave when IO errors occur during copy-before-write operations.
> Previously, the behavior was fixed and could not be controlled by the user.
> 
> The new 'on-cbw-error' option can be set to one of two values:
> - 'break-guest-write': Forwards the IO error to the guest and triggers
>    the on-source-error policy. This preserves snapshot integrity at the
>    expense of guest IO operations.
> - 'break-snapshot': Allows the guest OS to continue running normally,
>    but invalidates the snapshot and aborts related jobs. This prioritizes
>    guest operation over backup consistency.
> 
> This enhancement provides more flexibility for backup operations in different
> environments where requirements for guest availability versus backup
> consistency may vary.
> 
> The default behavior remains unchanged to maintain backward compatibility.
> 
> Signed-off-by: Raman Dzehtsiar<Raman.Dzehtsiar@gmail.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Tested-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Thanks, applied to my block branch.

Note for the future: better, add test in a separate commit, no reason to merge it into feature-commit.

-- 
Best regards,
Vladimir


