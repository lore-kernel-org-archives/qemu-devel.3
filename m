Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CC3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpc1-0001rh-H0; Thu, 09 Jul 2026 10:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1whpbx-0001r0-UA; Thu, 09 Jul 2026 10:20:22 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1whpbw-0006rC-8g; Thu, 09 Jul 2026 10:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=2S9whw1suARG63ySAZoGC1u72keWNj5DITqgWtc/hT0=; b=ZqwSYsSroS0hlnDTHq7gbBlSaq
 JppYkdjC9XsN0E/gCQq9sdP/CN6IHxk9wg4BgetbydIKC1S57MoHmHjPfHWvFT5/6SAT1u7331rfW
 Q9E9P5oXvjjpp6ZMBSeKTXxWJPTkWLkcNcJ0a5qkUR/i7Sn5lTRe+5xVrVJfTyp5s/uQ7Zxb4hnJk
 +leejZa9AKkhDncIvc5y8sEt5mQRqngbiD2CmpjgcnSekdD/UqOJFX+4FKmOySk5rJtuwVh0u/oeL
 SrahPGnDn2osBRyFjjXchCUD4YXl4XDK4n/93wDiP/y3Uu9A+VCF+xkDYWVGI+Auyz3idSElv8lxN
 1K1RRumCuztVD0H9F0/m7PA8iQ7wNAcAOsquF14DZnrQfnY3s7f7SqneIPW47+qqMfEyWAH/mKTD1
 4Ih48RsP5Ejr0EW8vDXpDtuPypjFJdTQN1QeZ2Z9iiZHetnYodn8YJ8J2Bs2+osHHjO3IPpw7aSx6
 H+5AtyiYM33lu34bNaAvcbDlDpDXJhh2ABFhSDZD6ypi/jHcU9cQMZE5oCEdlMDHbKnlrDS3a69de
 pVYARqvdxEjNpwbbHRY9LxLNDjNWMk5vbO5Kf7x4yTSdd6gzSkKnJoRUw2onwbLNpl/IgXpmcN94a
 e44mWPcV74J/1JjV+M8MN/tqhiGHmpPgfDVoJ63W0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: Jia Jia <physicalmtea@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH 1/3] hw/9pfs/virtio: drain in-flight PDUs before virtio-9p
 unrealize
Date: Thu, 09 Jul 2026 16:20:15 +0200
Message-ID: <3051985.e9J7NaK4W3@weasel>
In-Reply-To: <a25a3dbb8581c265d5eed2298738c6bfedf9cc38.1783604079.git.qemu_oss@crudebyte.com>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
 <a25a3dbb8581c265d5eed2298738c6bfedf9cc38.1783604079.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

On Thursday, 9 July 2026 15:50:36 CEST Christian Schoenebeck wrote:
> A guest can trigger a heap-use-after-free in the virtio transport
> unrealize path by submitting a Treaddir request and immediately
> ejecting the device via ACPI PCI hotplug. The unrealize path frees
> struct LocalData while a worker thread still holds a reference
> on it, causing a UAF in local_open_nofollow().
> 
> Fix this by draining all in-flight 9p PDUs by calling v9fs_reset()
> before final server cleanup. This ensures all coroutines completed,
> all FIDs are closed, and no worker thread still holds references
> on 9p server state when it is freed.
> 
> Reported-by: Jia Jia <physicalmtea@gmail.com>
> Suggested-by: Jia Jia <physicalmtea@gmail.com>
> Fixes: 6cecf09373 ("virtio-9p-device: add minimal unrealize handler")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3937
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---

Jia, if desired, I can make you the official author of this patch. If that's 
what you want, then please reply-to-all to this message with the same email 
address that you used for your report already, and acknowledge that you would 
be fine that I add a:

Signed-off-by: Jia Jia <physicalmtea@gmail.com>

tag on behalf of you, for the reason described here:

https://www.qemu.org/docs/master/devel/submitting-a-patch.html

>  hw/9pfs/virtio-9p-device.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 50dc93091d..1ec48fc9e0 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -243,6 +243,7 @@ static void virtio_9p_device_unrealize(DeviceState *dev)
> V9fsVirtioState *v = VIRTIO_9P(dev);
>      V9fsState *s = &v->state;
> 
> +    v9fs_reset(s);
>      virtio_delete_queue(v->vq);
>      virtio_cleanup(vdev);
>      v9fs_device_unrealize_common(s);



