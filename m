Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F0C1CA1009
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 09:47:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utk5f-0004CV-Oc; Wed, 03 Sep 2025 05:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk5a-0003jS-TA; Wed, 03 Sep 2025 05:47:39 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1utk5Z-0000qr-4x; Wed, 03 Sep 2025 05:47:38 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:3a87:0:640:845c:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id EAA67C0180;
 Wed, 03 Sep 2025 12:47:33 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:b8f::1:11] (unknown
 [2a02:6bf:8080:b8f::1:11])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id WlcWL33GoGk0-oz510RzG; Wed, 03 Sep 2025 12:47:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1756892853;
 bh=unSy2Jcj4yh4HKDZTFie71NLaYGwVxH5ztbGAC5rdW4=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=RNjfARPeGSgs+s9YOAklOE38VthDT0thPfHUElnKsRhWO6jffmYIA7L84GtYFkFwz
 cg6Iu62H3OEW+50DTdHl2WuERcvlofus3211rhd6/2Y6kXe85guYRyXnk22hMLMYdk
 4qIxzxxVNUCDOF0B6Q89TKWipa3H6gzmFFxIR6aE=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <dd1a4f06-7215-4deb-88e5-46c22be4f808@yandex-team.ru>
Date: Wed, 3 Sep 2025 12:47:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] migration/qemu-file: don't make incoming fds
 blocking again
To: berrange@redhat.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>, Steve Sistare <steven.sistare@oracle.com>
References: <20250903094411.1029449-1-vsementsov@yandex-team.ru>
 <20250903094411.1029449-11-vsementsov@yandex-team.ru>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20250903094411.1029449-11-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

CC Steve

On 03.09.25 12:44, Vladimir Sementsov-Ogievskiy wrote:
> In migration we want to pass fd "as is", not changing its
> blocking status.
> 
> The only current user of these fds is CPR state (through VMSTATE_FD),
> which of-course doesn't want to modify fds on target when source is
> still running and use these fds.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   migration/qemu-file.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/migration/qemu-file.c b/migration/qemu-file.c
> index b1d042e298..b6ac190034 100644
> --- a/migration/qemu-file.c
> +++ b/migration/qemu-file.c
> @@ -361,12 +361,6 @@ static ssize_t coroutine_mixed_fn qemu_fill_buffer(QEMUFile *f)
>           qemu_file_set_error_obj(f, len, local_error);
>       }
>   
> -    /*
> -     * NOTE: don't worry about error_abort, it will be removed
> -     * in the next commit
> -     */
> -    qemu_fds_set_blockinging(fds, nfd, true, &error_abort);
> -
>       for (int i = 0; i < nfd; i++) {
>           FdEntry *fde = g_new0(FdEntry, 1);
>           fde->fd = fds[i];


-- 
Best regards,
Vladimir

