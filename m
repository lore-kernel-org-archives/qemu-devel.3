Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49EB5C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 14:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnGxC-0002zS-MD; Fri, 24 Jul 2026 10:32:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnGx5-0002yW-QB; Fri, 24 Jul 2026 10:32:39 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnGx3-0000My-13; Fri, 24 Jul 2026 10:32:39 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66OCVJE2072314
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 24 Jul 2026 21:31:20 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=eH7TayLpe7he7hVkx6BzQNlGA6oPajPQamzf56Qx8eE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784896280; v=1;
 b=J+pSdIuZj6p2hWpzEih21O3uxsaQXryDZtLE8vLs1jjHt6RzT9Wm7jo6O0Bj8EiU
 hMGzSDV+/mXOC2ra1Kds42u1GdJVkWfEZIo55BwaMWMKsoqs6+r2G48rMqO/lH9z
 8hvUDLDDHC+x8hr1HeusVk6o2bp5l1jojFyfXfNQe3yWmQ7HW7iG9F3rFAcNW74G
 erw9+q+G3VT8nzNwRqHiOMf8MLdoeDQLvminSW0KJ/v7ASBq62Xno6gKWUlbj0gs
 oanzBjjXzkkycX6o0n3t+VQdcoQEEcI/p58uvH8alxU4PDlNRvp+IkCikxDVIyMR
 iZzAimaHis2VPzAT9J514Q==
Message-ID: <2af0a465-2f27-4e0f-b1dd-16bb8d3c5538@rsg.ci.i.u-tokyo.ac.jp>
Date: Fri, 24 Jul 2026 21:31:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 10/15] hw/virtio/vhost-shadow-virtqueue: range
 boundary in translation
To: Connor Kite <connorkite@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Haixu Cui <quic_haixcui@quicinc.com>,
 Raphael Norwitz <rnorwitz@nvidia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefanha@redhat.com>, Milan Zamazal <mzamazal@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, qemu-block@nongnu.org,
 virtio-fs@lists.linux.dev, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Alyssa Ross <hi@alyssa.is>, Demi Marie Obenour <demiobenour@gmail.com>
References: <20260723-vhost-user-isolated-memory-v1-0-6b97c439eb28@gmail.com>
 <20260723-vhost-user-isolated-memory-v1-10-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-10-6b97c439eb28@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
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

On 2026/07/24 7:30, Connor Kite wrote:
> iova-tree expects inclusive range sizing when maps are allocated or searched.
> Currently, svqs use exclusive sizing when searching their
> vhost-iova-tree for a match to the region to be translated.  This could
> lead to errors if the region to be translated is at the edge of an iova
> region.
> 
> Fix this by reducing `needle.size` by 1 in
> vhost_svq_translate_addr to bring then it line with DMAMap and iova-tree
> convention.

I think this patch is better to be extracted from this series since this 
series is complex and this patch is worth being landed earlier. You can 
chain this series to the patch with the Based-on: described in:
docs/devel/submitting-a-patch.rst

Regards,
Akihiko Odaki

> 
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-shadow-virtqueue.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
> index 9e3c359f50..20e5c7d2f1 100644
> --- a/hw/virtio/vhost-shadow-virtqueue.c
> +++ b/hw/virtio/vhost-shadow-virtqueue.c
> @@ -104,14 +104,14 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
>               /* Search the GPA->IOVA tree */
>               needle = (DMAMap) {
>                   .translated_addr = gpas[i],
> -                .size = iovec[i].iov_len,
> +                .size = iovec[i].iov_len - 1,  /* Inclusive */
>               };
>               map = vhost_iova_tree_find_gpa(svq->iova_tree, &needle);
>           } else {
>               /* Search the IOVA->HVA tree */
>               needle = (DMAMap) {
>                   .translated_addr = (hwaddr)(uintptr_t)iovec[i].iov_base,
> -                .size = iovec[i].iov_len,
> +                .size = iovec[i].iov_len - 1, /* Inclusive */
>               };
>               map = vhost_iova_tree_find_iova(svq->iova_tree, &needle);
>           }
> 


