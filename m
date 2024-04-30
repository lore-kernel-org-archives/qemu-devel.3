Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79FC1C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 12:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1mcw-0001ch-Bo; Tue, 30 Apr 2024 08:30:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s1mct-0001Kc-Dr
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:30:27 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1s1mcq-0001vP-6j
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 08:30:27 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 5D851480F2;
 Tue, 30 Apr 2024 14:30:21 +0200 (CEST)
Message-ID: <b3215169-005d-4766-ad19-3b649ff0e4c9@proxmox.com>
Date: Tue, 30 Apr 2024 14:30:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 5/5] virtio-gpu: fix scanout migration post-load
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20240312140216.313618-1-marcandre.lureau@redhat.com>
 <20240312140216.313618-6-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20240312140216.313618-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

Am 12.03.24 um 15:02 schrieb marcandre.lureau@redhat.com:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> The current post-loading code for scanout has a FIXME: it doesn't take
> the resource region/rect into account. But there is more, when adding
> blob migration support in commit f66767f75c9, I didn't realize that blob
> resources could be used for scanouts. This situationn leads to a crash
> during post-load, as they don't have an associated res->image.
> 
> virtio_gpu_do_set_scanout() handle all cases, but requires the
> associated virtio_gpu_framebuffer, which is currently not saved during
> migration.
> 
> Add a v2 of "virtio-gpu-one-scanout" with the framebuffer fields, so we
> can restore blob scanouts, as well as fixing the existing FIXME.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Sebastian Ott <sebott@redhat.com>

Hi,
unfortunately, this broke migration from pre-9.0 to 9.0:

> vmstate_load_state_field virtio-gpu:virtio-gpu
> vmstate_load_state_field virtio-gpu-scanouts:parent_obj.enable
> vmstate_load_state_field virtio-gpu-scanouts:parent_obj.conf.max_outputs
> vmstate_load_state_field virtio-gpu-scanouts:parent_obj.scanout
> vmstate_load_state_field virtio-gpu-one-scanout:resource_id
> vmstate_load_state_field virtio-gpu-one-scanout:width
> vmstate_load_state_field virtio-gpu-one-scanout:height
> vmstate_load_state_field virtio-gpu-one-scanout:x
> vmstate_load_state_field virtio-gpu-one-scanout:y
> vmstate_load_state_field virtio-gpu-one-scanout:cursor.resource_id
> vmstate_load_state_field virtio-gpu-one-scanout:cursor.hot_x
> vmstate_load_state_field virtio-gpu-one-scanout:cursor.hot_y
> vmstate_load_state_field virtio-gpu-one-scanout:cursor.pos.x
> vmstate_load_state_field virtio-gpu-one-scanout:cursor.pos.y
> vmstate_load_state_field virtio-gpu-one-scanout:fb.format
> vmstate_load_state_field virtio-gpu-one-scanout:fb.bytes_pp
> vmstate_load_state_field virtio-gpu-one-scanout:fb.width
> vmstate_load_state_field virtio-gpu-one-scanout:fb.height
> vmstate_load_state_field virtio-gpu-one-scanout:fb.stride
> vmstate_load_state_field virtio-gpu-one-scanout:fb.offset
> qemu-system-x86_64: Missing section footer for 0000:00:02.0/virtio-gpu
> qemu-system-x86_64: Error -22 while loading VM state

It wrongly tries to load the fb fields even though they should be
guarded by version 2.

Looking at it with GDB, in vmstate_load_state(), when we come to
field->name == parent_obj.scanout, the

>                 } else if (field->flags & VMS_STRUCT) {
>                     ret = vmstate_load_state(f, field->vmsd, curr_elem,
>                                              field->vmsd->version_id);

branch will be taken and suddenly we'll have a call to
vmstate_load_state() for vmsd==vmstate_virtio_gpu_scanout with
version_id==2 rather than version_id==1, because that is
field->vmsd->version_id (i.e. the .version_id in VMStateDescription
vmstate_virtio_gpu_scanout).

Would it have been necessary to version the VMStateDescription
vmstate_virtio_gpu_scanouts too using VMS_VSTRUCT (or am I
misinterpreting the use case for that)?

Best Regards,
Fiona


