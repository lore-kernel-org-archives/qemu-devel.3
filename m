Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A437C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 20:14:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLq3h-0002vX-Kx; Mon, 24 Jun 2024 16:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sLq3e-0002un-K4; Mon, 24 Jun 2024 16:12:59 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sLq3a-0002dl-WC; Mon, 24 Jun 2024 16:12:58 -0400
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:958d:0:640:7be4:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 3BF1960F1B;
 Mon, 24 Jun 2024 23:12:48 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:b5b5::1:35] (unknown
 [2a02:6b8:b081:b5b5::1:35])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id jCVOJ50IdmI0-GszqFrVR; Mon, 24 Jun 2024 23:12:47 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719259967;
 bh=iJ7IfyyC2uIRFTBBGGb2HC5sAa8/wVcg8N1/5cPb2G8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=vUkhAeCHb3lt8Ds2XNVszT38OmO7igjpNtuPkqCTm2l/NJvOwf6tgoEhPrb8clBgO
 q0PYK+Nn7fNhQjw8Lv3pxcG/Jl7qZqJgI3yl1g5sDkAlcXNJJAVnODE6Yzn1jTS2sC
 JZbO/Zx82HyzC/F5I8fENKpQ+O3cxRI00u5glKqU=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <69abd393-3a0e-47a2-a32f-412608716924@yandex-team.ru>
Date: Mon, 24 Jun 2024 23:12:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] mirror: allow specifying working bitmap
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 hreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 f.gruenbichler@proxmox.com, t.lamprecht@proxmox.com,
 mahaocong@didichuxing.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com
References: <20240521122014.333221-1-f.ebner@proxmox.com>
 <20240521122014.333221-4-f.ebner@proxmox.com>
Content-Language: en-US
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <20240521122014.333221-4-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

On 21.05.24 15:20, Fiona Ebner wrote:
> From: John Snow <jsnow@redhat.com>
> 
> for the mirror job. The bitmap's granularity is used as the job's
> granularity.
> 
> The new @bitmap parameter is marked unstable in the QAPI and can
> currently only be used for @sync=full mode.
> 
> Clusters initially dirty in the bitmap as well as new writes are
> copied to the target.
> 
> Using block-dirty-bitmap-clear and block-dirty-bitmap-merge API,
> callers can simulate the three kinds of @BitmapSyncMode (which is used

[..]

>       /*
>        * The dirty bitmap is set by bdrv_mirror_top_do_write() when not in active
> -     * mode.
> +     * mode. For external/caller-provided bitmap, need to wait until
> +     * bdrv_mirror_top_do_write() can actually access it before disabling.

hmm, isn't that true at least for non-mode? for other modes we rely on mirror_dirty_init(), but with none mode we risk to miss some writes.. That's preexisting, but probably it's better to move disabling the bitmap to the moment where we sure that we do dirty it by hand on any not-immediatelly-synced write. And than have _disable_() call in same place for all scenarios.

>        */
> -    bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> +    if (s->dirty_bitmap_is_local) {
> +        bdrv_disable_dirty_bitmap(s->dirty_bitmap);
> +    }
>   



-- 
Best regards,
Vladimir


