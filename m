Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443D8C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 09:54:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riAS3-0002mm-JD; Thu, 07 Mar 2024 04:54:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1riARz-0002mP-7I
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:54:07 -0500
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1riARw-0006pB-Go
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 04:54:06 -0500
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:22a5:0:640:715a:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id 17A0560F3C;
 Thu,  7 Mar 2024 12:54:00 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7204::1:28] (unknown
 [2a02:6b8:b081:7204::1:28])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id wrdkuf1i9Sw0-HA5d6axl; Thu, 07 Mar 2024 12:53:59 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1709805239;
 bh=DV7KQxyHy5knrNNfIch445qSOE86sdAe5zAqxd7nn+c=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=qrVh5y31tpkxKoWU28HXJ5K2kx7avFbHOeKKZNiC8/06nQRGt30/1NKOu1TaN5sCV
 mBXC5ND9DYrS14QWVqjeDU5GS4Ls2y0Wq3pXOKkdWrd/iyUyfU5VWoZEpGVvwfFJKC
 kcV1Kg4uM+akTU7WB5Z50ebGy3zryDgf7YcoWeMk=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <669aaa46-0ed8-46c8-9684-fc4ccc485d4d@yandex-team.ru>
Date: Thu, 7 Mar 2024 12:53:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/25] migration: Add Error** argument to .save_setup()
 handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Markus Armbruster <armbru@redhat.com>,
 Prasad Pandit <pjp@fedoraproject.org>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
References: <20240306133441.2351700-1-clg@redhat.com>
 <20240306133441.2351700-12-clg@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240306133441.2351700-12-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 06.03.24 16:34, Cédric Le Goater wrote:
> The purpose is to record a potential error in the migration stream if
> qemu_savevm_state_setup() fails. Most of the current .save_setup()
> handlers can be modified to use the Error argument instead of managing
> their own and calling locally error_report().
> 
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Cc: Halil Pasic <pasic@linux.ibm.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> Cc: John Snow <jsnow@redhat.com>
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Still, if you resend, please add error_prepend in the case below:

> diff --git a/migration/savevm.c b/migration/savevm.c
> index 63fdbb5ad7d4dbfaef1d2094350bf302cc677602..52d35b2a72c6238bfe5dcb4d81c1af8d2bf73013 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1342,11 +1342,9 @@ int qemu_savevm_state_setup(QEMUFile *f, Error **errp)
>           }
>           save_section_header(f, se, QEMU_VM_SECTION_START);
>   
> -        ret = se->ops->save_setup(f, se->opaque);
> +        ret = se->ops->save_setup(f, se->opaque, errp);
>           save_section_footer(f, se);
>           if (ret < 0) {
> -            error_setg(errp, "failed to setup SaveStateEntry with id(name): "
> -                       "%d(%s): %d", se->section_id, se->idstr, ret);

You drop a good bit of information, let's use error_prepend to save it.

>               qemu_file_set_error(f, ret);
>               break;

Not about this patch:

Better do explicit "return ret" instead of this "break" (and one more break above in that loop):

1. making a jump to do just do "return ret" seems overkill. It would make sense if we had some more "cleanup" code than just a "return ret", and if so, more classic and readable thing is "goto fail;".
2. "break" make me think, that there may be more logic after it, which will probably fail, and I should be careful, as errp is already set (and second attempt to set it will crash). Again, "goto fail;" is better, as I don't expect more failures when see it.

-- 
Best regards,
Vladimir


