Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EB7C54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 14:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpqnH-0001WU-Qm; Thu, 28 Mar 2024 10:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rpqnF-0001Vl-Ji
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rpqnE-0001Kb-33
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 10:31:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711636307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTVgm7w83hgG3NRSU1IWf51bCGkbjUxC9kBuTJUymhc=;
 b=Ad2bFxD4Pb8Xi1eJXxUnRNT/0Z83IjkT0Ivz15Ii1meU7xh3QlTtzNuVzFBrv2Qd343ZO6
 aRr+ATtGawKFx+90UnCZc0IcW1q0uYFZ78B6dm0juqKEpXwkiNd3VYXDMedPXOg2Wf5I6F
 CvOFkhAMWXWhUipRAXrfwXEZyhSeW98=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-P2DQL1mEOrGv7e5DCocK7w-1; Thu, 28 Mar 2024 10:31:44 -0400
X-MC-Unique: P2DQL1mEOrGv7e5DCocK7w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D2C18F8A81;
 Thu, 28 Mar 2024 14:31:42 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 776CB17AA3;
 Thu, 28 Mar 2024 14:31:37 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:31:31 -0500
From: Eric Blake <eblake@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Hyman Huang <yong.huang@smartx.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 John Snow <jsnow@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Fam Zheng <fam@euphon.net>, 
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Bin Meng <bin.meng@windriver.com>, 
 Hanna Reitz <hreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Jesper Devantier <foss@defmacro.it>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 Keith Busch <kbusch@kernel.org>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alexandre Iooss <erdnaxe@crans.org>, Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 00/19] -Werror=maybe-uninitialized fixes
Message-ID: <wgx42mk3lvrycgzfrasjqlrkad5rrrbqslby2iswoqczi2ba76@vkfgdvenbvzv>
References: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240328102052.3499331-1-marcandre.lureau@redhat.com>
User-Agent: NeoMutt/20240201
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.08,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Mar 28, 2024 at 02:20:33PM +0400, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Hi,
> 
> Depending on -Doptimization=<value>, GCC (13.2.1 here) produces different
> maybe-uninitialized warnings:
> - g: produces -Werror=maybe-uninitialized errors
> - 0: clean build
> - 1: produces -Werror=maybe-uninitialized errors
> - 2: clean build
> - 3: produces few -Werror=maybe-uninitialized errors
> - s: produces -Werror=maybe-uninitialized errors
> 
> Most are false-positive, because prior LOCK_GUARD should guarantee an
> initialization path. Few of them are a bit trickier. Finally, I found
> a potential related memory leak.
> 
> thanks

Couple of subject lines are inconsistent; I suggest:

> 
> Marc-André Lureau (19):
>   util/coroutine: fix -Werror=maybe-uninitialized false-positive
>   util/timer: with -Werror=maybe-uninitialized false-positive

s/with/fix/

>   hw/qxl: fix -Werror=maybe-uninitialized false-positives
>   nbd: with -Werror=maybe-uninitialized false-positive

s/with/fix/

>   block/mirror: fix -Werror=maybe-uninitialized false-positive
>   block/stream: fix -Werror=maybe-uninitialized false-positives
>   hw/ahci: fix -Werror=maybe-uninitialized false-positive
>   hw/vhost-scsi: fix -Werror=maybe-uninitialized
>   hw/sdhci: fix -Werror=maybe-uninitialized false-positive
>   hw/rdma: fix -Werror=maybe-uninitialized false-positive
>   migration/block: fix -Werror=maybe-uninitialized false-positive
>   migration: fix -Werror=maybe-uninitialized false-positives
>   hw/virtio-blk: fix -Werror=maybe-uninitialized false-positive
>   plugins: fix -Werror=maybe-uninitialized false-positive
>   migration: fix -Werror=maybe-uninitialized false-positive
>   tests: fix -Werror=maybe-uninitialized
>   hw/nvme: fix -Werror=maybe-uninitialized
>   hw/virtio: fix -Werror=maybe-uninitialized
>   RFC: hw/virtio: a potential leak fix
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


