Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617CCC53219
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 07:25:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woyfH-0004LA-22; Wed, 29 Jul 2026 03:25:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1woyfE-0004Fm-5C
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 03:25:16 -0400
Received: from forwardcorp1d.mail.yandex.net ([178.154.239.200])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dtalexundeer@yandex-team.ru>)
 id 1woyfB-0005Ul-BP
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 03:25:15 -0400
Received: from mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:65a0:0:640:e1de:0])
 by forwardcorp1d.mail.yandex.net (postfix) with ESMTPS id DABBE8075C;
 Wed, 29 Jul 2026 10:25:08 +0300 (MSK)
Received: from [IPV6:2a02:6bf:8080:a47::1:34] (unknown
 [2a02:6bf:8080:a47::1:34])
 by mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net (smtpcorp) with ESMTPSA
 id 5PY0SG46WSw0-cQ2I21Ad; Wed, 29 Jul 2026 10:25:08 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1785309908;
 bh=chOi6qLypBK2mXnh1c/V/Fy6xxjQGkRoFk7HWI5t6ZA=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=lX12RKXX2Hhn1Pi0uoHjHqDmC1rannU19g4BwSwrFQmKMvTIDVcx4p58byN2s0Kz+
 h8OhVCIKsk20zGF81EjjRd7FETB5x570lDKtxzjTLyTch4T0kD6SLvYTQZBTGLWxWr
 UewMcbV7bwAEqmthZh8TEzHHqLDlO+8U9/XtoAcI=
Authentication-Results: mail-nwsmtp-smtp-corp-main-56.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <77c2f243-498f-4f2f-9dfd-1ccb2c9aa94b@yandex-team.ru>
Date: Wed, 29 Jul 2026 12:25:05 +0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>, =?UTF-8?B?6rmA7Iq57KSR?=
 <seungjung0711@gmail.com>
References: <20260728153942.1891677-1-peterx@redhat.com>
Content-Language: en-US
From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
In-Reply-To: <20260728153942.1891677-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.200;
 envelope-from=dtalexundeer@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
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


On 7/28/26 20:39, Peter Xu wrote:
> It was overlooked that VMSTATE_VBUFFER_UINT64() won't really work with an
> uint64_t, as vmstate core only treats the size as 32bits, and maximum
> INT32_MAX (see vmstate_size()).
>
> Considering that we do not need real 64bits for the size, stick with the 2G
> limit, converting the size field into 32bits.
>
> Since we can't touch the wire protocol on migration from an old QEMU, we
> can't directly modify the type of size to uint32_t.  Instead, we need to
> introduce a temporary variable for this extremely rare issue __size_32bits
> to be used only for VMSTATE_VBUFFER_UINT32().  Document it and name it
> weird enough so people won't get confused on having two size variables.
>
> Remove VMSTATE_VBUFFER_UINT64() altogether, because it was never going to
> be used right.  It means QEMU will only support 2G max for VMS_VBUFFER.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
> Reported-by: 김승중 <seungjung0711@gmail.com>
> Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Fixes: 3a80ff0721 ("vhost: add vmstate for inflight region with inner buffer")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> PS1: I only did smoke test as I'm not fluent with vhost inflight feature.
> Please kindly try it out if possible. In general, migrations from older
> QEMU should work even after applied.  One can also treat this as partly-RFC
> from that.

It looks like inflight migration is broken:

qemu-system-x86_64: Missing section footer for 
0000:00:02.0:00.0:00.0/vhost-user-blk
migrate_error error=load of migration failed: Invalid argument: Section 
footer error, section_id: 53
qemu-system-x86_64: load of migration failed: Invalid argument: Section 
footer error, section_id: 53

As far as I understand this happen because __size_32bits not initialized 
on source - it's never set. So vmstate_size() reads 0, and zero-lenght 
buffer is written into migration stream.
The destination then allocates the correct buffer but reads 0 bytes from 
the stream, leaving unconsumed data and causing the section footer check 
to fail.

It can be fixed with adding pre_save (or pre_save_errp) to 
vmstate_vhost_inflight_region_buffer that initialize __size_32bits from 
size:

static int vhost_inflight_buffer_pre_save(void *opaque)
{
     struct vhost_inflight *inflight = opaque;
     /* Only used in VMSTATE_VBUFFER_UINT32() */
     inflight->__size_32bits = inflight->size;
     return 0;
}

>
> PS2: Michael, we have just discussed what we should define as CVE for
> migration, and this one shouldn't fall into CVE category, please refer to:
>
> https://lore.kernel.org/r/20260721131457.3062767-1-farosas@suse.de
>
> So I didn't yet attach CVE tag.  Please correct if I'm wrong, thanks.
> ---
>   include/hw/virtio/vhost.h   |  5 +++++
>   include/migration/vmstate.h | 10 ----------
>   hw/virtio/vhost.c           | 19 ++++++++++++++-----
>   3 files changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 684bafcaad..1d1cc24c04 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -17,6 +17,11 @@ struct vhost_inflight {
>       int fd;
>       void *addr;
>       uint64_t size;
> +    /*
> +     * This is a temporary variable only used during migration loading to
> +     * satisfy VMSTATE_VBUFFER_UINT32() typing. Please use @size otherwise.
> +     */
> +    uint32_t __size_32bits;
>       uint64_t offset;
>       uint16_t queue_size;
>   };
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1b7f295417..a349b2d84a 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -782,16 +782,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>       .offset       = offsetof(_state, _field),                        \
>   }
>   
> -#define VMSTATE_VBUFFER_UINT64(_field, _state, _version, _test, _field_size) { \
> -    .name         = (stringify(_field)),                             \
> -    .version_id   = (_version),                                      \
> -    .field_exists = (_test),                                         \
> -    .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
> -    .info         = &vmstate_info_buffer,                            \
> -    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
> -    .offset       = offsetof(_state, _field),                        \
> -}
> -
>   #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
>                                        _test, _field_size) {           \
>       .name         = (stringify(_field)),                             \
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index af41841b52..e7c570d0f5 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2022,15 +2022,24 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
>   static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
>   {
>       struct vhost_inflight *inflight = opaque;
> -
>       int fd = -1;
> -    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> -                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> -                                  &fd, errp);
> +    void *addr;
> +
> +    if (inflight->size > INT32_MAX) {
> +        error_setg(errp, "inflight size '%"PRIu64"' exceeds "
> +                   "migration limit '%"PRIu32"'", inflight->size, INT32_MAX);
> +        return false;
> +    }
> +
> +    addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> +                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> +                            &fd, errp);
>       if (!addr) {
>           return false;
>       }
>   
> +    /* Only used in VMSTATE_VBUFFER_UINT32() */
> +    inflight->__size_32bits = inflight->size;
>       inflight->offset = 0;
>       inflight->addr = addr;
>       inflight->fd = fd;
> @@ -2042,7 +2051,7 @@ const VMStateDescription vmstate_vhost_inflight_region_buffer = {
>       .name = "vhost-inflight-region/buffer",
>       .pre_load_errp = vhost_inflight_buffer_pre_load,
>       .fields = (const VMStateField[]) {
> -        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
> +        VMSTATE_VBUFFER_UINT32(addr, struct vhost_inflight, 0, NULL, __size_32bits),
>           VMSTATE_END_OF_LIST()
>       }
>   };

