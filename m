Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B374C6FD1F
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 09:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq8bW-0001gn-NK; Fri, 29 Mar 2024 05:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rq8bU-0001fR-57; Fri, 29 Mar 2024 05:32:52 -0400
Received: from forwardcorp1c.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rq8bQ-0001Af-Gu; Fri, 29 Mar 2024 05:32:51 -0400
Received: from mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net
 [IPv6:2a02:6b8:c12:5428:0:640:7351:0])
 by forwardcorp1c.mail.yandex.net (Yandex) with ESMTPS id A37D760C61;
 Fri, 29 Mar 2024 12:32:41 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:6509::1:4] (unknown
 [2a02:6b8:b081:6509::1:4])
 by mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id cWKUJ24Ifa60-jcavf3yU; Fri, 29 Mar 2024 12:32:41 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1711704761;
 bh=TN9HzSIkkQz7APZOHcikhI5RzYc+R2szHrbpkRHkeGs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=aZqjarI2IkxQhPyVFfpHWOoarymfyQDZcA5Yi19q57p+gCUrNLqabIJTbfzS8DAYP
 DEXCw4KNuSCh+cPAXZ3MgHMlnDM6V1m+MNUL75AlD8GHoLXTDK7mf1kHbibHMPlJ44
 kPKXPk+Z9IFZTXJweVSLrz2lv3lrLW2jIW7iW3qg=
Authentication-Results: mail-nwsmtp-smtp-corp-main-26.myt.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <9bae5618-2ebc-453a-8b10-32474422c66f@yandex-team.ru>
Date: Fri, 29 Mar 2024 12:32:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 v5 07/14] migration: Add Error** argument to
 .save_setup() handler
Content-Language: en-US
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 qemu-devel@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>
Cc: Avihai Horon <avihaih@nvidia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Prasad Pandit
 <pjp@fedoraproject.org>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-block@nongnu.org
References: <20240320064911.545001-1-clg@redhat.com>
 <20240320064911.545001-8-clg@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240320064911.545001-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1c.mail.yandex.net
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

On 20.03.24 09:49, Cédric Le Goater wrote:
> diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
> index 2708abf3d762de774ed294d3fdb8e56690d2974c..542a8c297b329abc30d1b3a205d29340fa59a961 100644
> --- a/migration/block-dirty-bitmap.c
> +++ b/migration/block-dirty-bitmap.c
> @@ -1213,12 +1213,14 @@ fail:
>       return ret;
>   }
>   
> -static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque)
> +static int dirty_bitmap_save_setup(QEMUFile *f, void *opaque, Error **errp)
>   {
>       DBMSaveState *s = &((DBMState *)opaque)->save;
>       SaveBitmapState *dbms = NULL;
>   
>       if (init_dirty_bitmap_migration(s) < 0) {
> +        error_setg(errp,
> +                   "Failed to initialize dirty tracking bitmap for blocks");

No, that's not about initializing a bitmap. This all is about migration of block-dirty-bitmaps themselves.

So correct would be say "Failed to initialize migration of block dirty bitmaps".

with this, for block dirty bitmap migration:
Acked-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>


Still, a lot better is add errp to init_dirty_bitmap_migration() and to add_bitmaps_to_list() too: look,

init_dirty_bitmap_migration() fails only if add_bitmaps_to_list() fails

in turn,

add_bitmaps_to_list() have several clear failure points, where it always does error_report (or error_report_err), which would be better to pass-through to the user.

>           return -1;
>       }
>   
> diff --git a/migrat

-- 
Best regards,
Vladimir


