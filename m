Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538BED0E6D0
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 12:33:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNsDf-0004P8-2v; Tue, 25 Nov 2025 07:32:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1vNsDS-0004Ni-Uc
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:32:20 -0500
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <d-tatianin@yandex-team.ru>)
 id 1vNsDQ-0000e8-30
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 07:32:18 -0500
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id 181E682DEB;
 Tue, 25 Nov 2025 15:32:05 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:c7c::1:20] (unknown
 [2a02:6bf:8080:c7c::1:20])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 3WbdaJ1FreA0-us4D0wtc; Tue, 25 Nov 2025 15:32:04 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1764073924;
 bh=klcn0RSgaz5YRuz+3PHdPv/P3b/9qw94nWsC7vXSxQs=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=USmL6VcUfQ/GCmWU34VuqbWEleIAl2DUbzpwRnkg4cjpY2Y2sOPFMZVDXx7/tFa0M
 ReHN7JzRPo/IZ8T0F9pOSLHQst2tRR7FVFD6MNdA1kbhEw9jse3rMXDa/P4BqAp3kv
 4piPBhZVNJfT4suWmxMw5cj/0LGy5VhEGnplznLI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <88bf67fc-1a5d-464c-8e17-49cc4d988044@yandex-team.ru>
Date: Tue, 25 Nov 2025 15:32:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio/vhost: don't consider non-MAP_SHARED regions public
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, qemu-devel@nongnu.org
References: <20251113085842.323745-1-d-tatianin@yandex-team.ru>
Content-Language: en-US
From: Daniil Tatianin <d-tatianin@yandex-team.ru>
In-Reply-To: <20251113085842.323745-1-d-tatianin@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=d-tatianin@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Ping :)

On 11/13/25 11:58 AM, Daniil Tatianin wrote:
> Just having a file descriptor is not enough to consider a memory region
> public. If QEMU didn't map it as MAP_SHARED (in case of share=off), guest
> writes to this region won't be visible to the vhost-user backend, thus
> causing it to read all zeroes or garbage. Make sure we don't pass such
> regions and include that to our definition of what a private region is.
>
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>   hw/virtio/vhost.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 266a11514a..eb098a25c5 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -591,11 +591,13 @@ static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
>           /*
>            * Some backends (like vhost-user) can only handle memory regions
>            * that have an fd (can be mapped into a different process). Filter
> -         * the ones without an fd out, if requested.
> -         *
> -         * TODO: we might have to limit to MAP_SHARED as well.
> +         * the ones without an fd out, if requested. Also make sure that
> +         * this region is mapped as shared so that the vhost backend can
> +         * observe modifications to this region, otherwise we consider it
> +         * private.
>            */
> -        if (memory_region_get_fd(section->mr) < 0 &&
> +        if ((memory_region_get_fd(section->mr) < 0 ||
> +            !qemu_ram_is_shared(section->mr->ram_block)) &&
>               dev->vhost_ops->vhost_backend_no_private_memslots &&
>               dev->vhost_ops->vhost_backend_no_private_memslots(dev)) {
>               trace_vhost_reject_section(mr->name, 2);

