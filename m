Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 608BDD1CDC6
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Dec 2025 00:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vSPSb-0005CY-BP; Sun, 07 Dec 2025 19:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vSPSK-0005AS-9H
 for qemu-devel@nongnu.org; Sun, 07 Dec 2025 19:50:27 -0500
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1vSPSC-0006C9-OM
 for qemu-devel@nongnu.org; Sun, 07 Dec 2025 19:50:19 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1765155004; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=MMLlevUJ/J1kQi/iTc5IVLtwxwZ79fiFWHWPXGrXu8+HtjJx4hUakvTKdjiEV+AgLfIxSc/3V+KwnG5Ee1BJmbPWrZKutxFKx+mVTJa+vIyi/hSpFjV966MtiPeQGYKpgfMt1wNhCdDs0BqK4TLn9G8V/xKwx5MI3aiY8nYJS8c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1765155004;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=4A8YOQ0Bn0D6wTuDDsRczkj7UhvJcFt+TM597FmFDPs=; 
 b=UPiASRxbwHwi9YAU4ZTfC7XcailoMgbKjIqYY6vopVJ8fUWp6IeE+W8BegY25Jw005ruiHtad3ff8CBZbVJVypqOG2/RxLvWVNpePtD4o8ZJaX7Yrg+oAnEera0BbXBUPepCE0ntdf8qRBK4BVwm3S0ogegm7TtjoWYTibJnYzk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1765155004; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=4A8YOQ0Bn0D6wTuDDsRczkj7UhvJcFt+TM597FmFDPs=;
 b=gr4tn5Y6YSx7nT5xIpznIGzTnKlOonaCFkM9yHLyQdxHqrzAs8px/YhjKblzratw
 XW0RA6Kv0skd8uYJLzG7n4tdu9Cs/lVv1n4XU80eCqMgh4c9uEHZv3HnCTYweh8O1tw
 RwttsTMlEles6q/7sd7ow0sdeK5NEsCh+x24agmA=
Received: by mx.zohomail.com with SMTPS id 1765155002477909.451946777439;
 Sun, 7 Dec 2025 16:50:02 -0800 (PST)
Message-ID: <06bd2abd-e554-4ec8-8ffb-256d33af95c0@collabora.com>
Date: Mon, 8 Dec 2025 03:49:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] virtio-gpu: create drm fd based on specified render node
 path
To: Luqmaan Irshad <luirshad@amd.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, alex.bennee@linaro.org, odaki@rsg.ci.i.u-tokyo.ac.jp,
 pierre-eric.pelloux-prayer@amd.com, luckmaan21@gmail.com
References: <20251205184906.110927-1-luirshad@amd.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20251205184906.110927-1-luirshad@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Hi,

On 12/5/25 21:49, Luqmaan Irshad wrote:
> Added a special callback function called virtio_get_drm_fd to create
> a render node based on the path specified by the user via QEMU command
> line.  This function is called during the virglrenderer callback sequence
> where we specify the get_drm_fd function pointer to call back our
> new function, allowing us to pass the fd of our created render node.
> 
> Based-on: 20251116125641.2255794-1-dmitry.osipenko@collabora.com
> 
> Signed-off-by: Luqmaan Irshad <luirshad@amd.com>
> ---
>  hw/display/virtio-gpu-gl.c     |  4 ++++
>  hw/display/virtio-gpu-virgl.c  | 17 ++++++++++++++++-
>  include/hw/virtio/virtio-gpu.h |  1 +
>  3 files changed, 21 insertions(+), 1 deletion(-)

Do you think it could be possible and worthwhile to make QEMU's EGL
display to use same GPU as virgl automatically? I.e. we tell QEMU/EGL
which GPU to use and then virgl will use same DRM device that backs EGL.

-- 
Best regards,
Dmitry

