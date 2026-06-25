Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D80F9CDE00B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 15:01:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclYt-00029p-4z; Thu, 25 Jun 2026 11:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclYq-00025b-VR
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wclYp-0004HO-BF
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 11:00:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782399610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3s54OI1UjMMzJsCRnUshDQ868reiAt/dC9rQYu5l3F8=;
 b=B2+xnZ6ZIoff8NkbDG9zv8cSV+vIVFS8au3oESv0hekIzEC0O7xD1zy3zpLFeTMT5L+bLg
 hapqMd4lgcvris6jZIbRb3iNMuQB2dHHsEGbpJihXZyHzWzA0JJLGdahWaR8VLw68llmmo
 TS6z1AJmpoPFS3EzaD5n1sa9KmmX+L0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-ObPqKoulNTqEeAE1ZdxEGw-1; Thu,
 25 Jun 2026 11:00:07 -0400
X-MC-Unique: ObPqKoulNTqEeAE1ZdxEGw-1
X-Mimecast-MFC-AGG-ID: ObPqKoulNTqEeAE1ZdxEGw_1782399606
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEC0B1873112; Thu, 25 Jun 2026 15:00:05 +0000 (UTC)
Received: from localhost (unknown [10.44.24.16])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A7BE30003B6; Thu, 25 Jun 2026 15:00:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 4/9] hw/audio/virtio-sound: split out
 virtio_snd_pcm_start_stop()
From: marcandre.lureau@redhat.com
To: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?utf-8?q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
In-Reply-To: <20260625095250.65073-5-alexander@mihalicyn.com>
References: <20260625095250.65073-1-alexander@mihalicyn.com>
 <20260625095250.65073-5-alexander@mihalicyn.com>
Date: Thu, 25 Jun 2026 18:59:34 +0400
Message-Id: <178239957438.405566.18000078298745754945.b4-review@b4>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1551;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=upoE876k/okFOPiKh8DXXxi9BF5g7clBqekMNJIqB/Y=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqPUJayejcNePbZHfGJXuFrzhr/U4JdDms6fRcI
 ATsCdP1DkOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaj1CWgAKCRDa6OEJdZac
 5TVhD/44k8l34hPsHkN0mYbBE8bTt5jW0TvoxX/SY5/ePRk4cBByD5uDXa+ae9MYATBbHpsbWe3
 JIWdRtWvjmNCK1791l0f+lgh9t9l7Qy+RBulsaZ4WQiEHPkYP2Xk2/6m3TqqIN8XhqZGFuZzfDy
 3+sLKT7y69hi4EI6/4Vm7xObQ8KyzLD7iz84Cx4e+p8MCNUbrF3H7sIpvMv9A8yvipL/ke89EoQ
 xwpm7tLMdIVgApTnECLdNtzLTdXZj2gallTZo77rkkrhGmZXEYMuAjgrumaKB7RlgZHiwPqoxKB
 NTjTtSqcndCtaA/oylcXiCxbrwF1hGWj2Iz6lq6/dK0oUi6Px5SDVpioBijvFpfCN9cv84m8En4
 AtOIe6I8wVRTL3c/YV16NdvZyIN1Id0yYXkfL/2iYzP7/6aEs5RRtr4puj1Oj7iub4rEc68bOD9
 ADpnFhNQp70LmLUDwhEDq88MaAQXDnEaLgxLzNsRt2bio0I1YbK+Fr5M31qgryOH+jNm8MXJv8u
 x0/xJxLFc9DcNYl3HBLw3Ph7NIZ7rSAU0mGicU6nqyhz4FS6eXod/rWLBxJJHiXUau7nnzO/9Aa
 dHxF/UOrabut8offCHFmiVQfP7mi0O7BL4nyDMiqEVoUF0wYHqNcRqd81latXuueOAL9t1e1hlz
 QmIZ19jHSl4c5qA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Split out virtio_snd_pcm_start_stop(). This is a preparation
> for the next patch so that it doesn't become too big.
> 
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> [AM: there were too many conflicts, I did `git checkout --ours -- <.>`
>      and then reimplemented the patch idea
> /AM]
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> Message-ID: <20260625095250.65073-5-alexander@mihalicyn.com>
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index 7687261192d..80dc13318af 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -521,7 +521,42 @@ static void virtio_snd_handle_pcm_prepare(VirtIOSound *s,
>  }
>  
>  /*
> - * Handles VIRTIO_SND_R_PCM_START.
> + * Starts/Stops a VirtIOSound card stream.
> + * Returns the response status code. (VIRTIO_SND_S_*).
> + *
> + * @s: VirtIOSound device
> + * @stream_id: stream id
> + * @start: whether to start or stop the stream
> + */
> +static uint32_t virtio_snd_pcm_start_stop(VirtIOSound *s,
> +                                          uint32_t stream_id,
> +                                          bool start)
> +{
> +    VirtIOSoundPCMStream *stream;
> +
> +    stream = virtio_snd_pcm_get_stream(s, stream_id);
> +    if (!stream) {

I think we should keep the error report here. Or rather make it a
qemu_log_mask(LOG_GUEST_ERROR, ..)

other than that:
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>

-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


