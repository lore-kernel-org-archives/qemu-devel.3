Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F4E2C531FA
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 15:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnHkJ-0003Xu-SQ; Fri, 24 Jul 2026 11:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnHk4-0003Sy-SM; Fri, 24 Jul 2026 11:23:17 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wnHk1-0008JZ-Ng; Fri, 24 Jul 2026 11:23:16 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 66OFMNiB025117
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sat, 25 Jul 2026 00:22:24 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=JE6nwoBnuIB4oWlTX9bpmIpvGlRAzyit7mewtK4+Yec=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1784906544; v=1;
 b=EJAFR0+aq9Ea/nijyPcpfRPwe004E2nIzesoXnWABFNG5k6Dq8zJcwN5w5V5ST08
 SygPzj44ygxomvCfUlc6aoE9XfIOIi2IjG00ozU1eW/tIUzFN0Shxc+PdNKkleed
 rB4RdTwPxQoweM5U36yfZ5NY4bCoFoHzyJT6mKrjkNx3FmTGxD4+KRHrtjHaN2DZ
 mGD6k+wqnXOjX/4kNbNjM89oJDC47rCubuf1s8IVQ8p7kPXIR4ZOVXyErWSJAp+m
 dt8Wc9QhRo1bA81YwujAs2VxBEuAEggRP0EW6RUS9HOWyLK5lG0bGKxPSMxEkOb0
 2LSELc8rrGM0G8A+6X27vg==
Message-ID: <1257210f-15f9-47ab-b5e9-05a3ee4ef8ba@rsg.ci.i.u-tokyo.ac.jp>
Date: Sat, 25 Jul 2026 00:22:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 15/15] hw/virtio/vhost-user: shadow vq cleanup
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
 <20260723-vhost-user-isolated-memory-v1-15-6b97c439eb28@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <20260723-vhost-user-isolated-memory-v1-15-6b97c439eb28@gmail.com>
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
> Implements functionality to cleanup svqs on cleanup of isolation
> regions.
> 
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>   hw/virtio/vhost-user.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index e65f877f9a..bb4de78b95 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1140,6 +1140,15 @@ static int vhost_user_set_mem_table_postcopy(struct vhost_dev *dev,
>       return 0;
>   }
>   
> +static void vhost_user_svq_cleanup(struct vhost_user *u)
> +{
> +    for (int i = 0; i < u->shadow_vqs->len; i++) {
> +        vhost_svq_stop(g_ptr_array_index(u->shadow_vqs, i));
> +    }
> +
> +    g_ptr_array_free(u->shadow_vqs, true);
> +}
> +
>   /* TODO: Is there any notifier cleanup required here?*/
>   static void cleanup_isolation_regions(struct vhost_dev *dev)
>   {
> @@ -1147,6 +1156,7 @@ static void cleanup_isolation_regions(struct vhost_dev *dev)
>       if (u->iso_memory.base_addr) {
>           vhost_iova_tree_delete(u->iso_iova_tree);
>           u->iso_iova_tree = NULL;
> +        vhost_user_svq_cleanup(u);

Memory-table refresh frees live SVQs permanently. 
init_isolation_regions() uses cleanup for refreshes, but cleanup frees 
shadow_vqs; they are created only once during backend initialization.

Regards,
Akihiko Odaki

>           memset(&u->iso_memory, 0, sizeof(IsolationRegion));
>           qemu_memfd_free((gpointer) u->iso_memory.base_addr, u->iso_memory.size,
>                            u->iso_memory.iso_fd);
> 


