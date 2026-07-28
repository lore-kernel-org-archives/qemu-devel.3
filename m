Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330F4C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 23:18:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wor3d-0002QN-NB; Tue, 28 Jul 2026 19:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wor3b-0002Q6-OA
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 19:17:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wor3Z-0001SD-Lz
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 19:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785280671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wZVYexeVWPiWFVsCL38V8Yluw2YQeSka992C0CvuA44=;
 b=ME1dbcOMB7oawOydJ0q3BeE7cXKOgpwg/dAi4Ef4BXww60PXLBkKqUwB5aCSziUuesbloF
 whm2sCMYPvSxNwivQhriTpq2CDplCblj7OWbkb9a8nEX3oQMBTSbZYFJlMU1Qk5xdul6v2
 DDdXInwUbb7rr8RMSifxmWav8Atogpg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-qABJ2tH9Nae6TZ1B2CDVIA-1; Tue, 28 Jul 2026 19:17:50 -0400
X-MC-Unique: qABJ2tH9Nae6TZ1B2CDVIA-1
X-Mimecast-MFC-AGG-ID: qABJ2tH9Nae6TZ1B2CDVIA_1785280669
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-47f6d70223dso253135f8f.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 16:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785280669; x=1785885469; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wZVYexeVWPiWFVsCL38V8Yluw2YQeSka992C0CvuA44=;
 b=CxScTOQH/vx62TnIqmPVBQJGioRNrkzm7SvXddBv1NY7w1NYme+tsVKAMN2cvF88to
 FZS4l6C7Gn/dRjx1uMyFdgNSLnx9z76RarjqYwi64LVHJ8Y35ozn3myI+Pklq7kTPdYs
 HnMR6MjWlc5WpOCyygp2dD3tDya0FiCYsrgywc3W6swJ6jLVhNysdpksGgXB6LSoy016
 wr09KqTAn+okQMPX7DID8/9F29lUJYCUjMDUgxQ0iMB/mUyf5PIh7QsY/oncB+zaSBrZ
 BY7ZTDJHsDYoB5crKza1N/fFmVGhhy475tGfpXFxeYXcQmRWo0fCORZzQnRlRs2uPRAt
 a56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785280669; x=1785885469;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=wZVYexeVWPiWFVsCL38V8Yluw2YQeSka992C0CvuA44=;
 b=OnROGzecuteP6RKzjmMMjgmJ37u3ocVqHgdf4FudF3lAiKl3G88oA6zHg4v7Ghw4T/
 AhLtIckzo2e7HFdA/0N0U3vjbC1l5FFrG4D2A4wuVSw5a2o48nI9NIjcez2eYg43SiJi
 XBFwSMgLR1RmJYVlGMoky1ahqq8r8XeysC+PsydS6NSrh9b8AmStPWeXFvU9NEP53GvF
 V/zn+fI+dsncoX5i+c56Wu1LKn/HeMCuTbPwmAs2/kFquWLhhzVo2aBIInPHQVEbYGdD
 xsr5UD4VGo9vL3IyBDwd2FNbnmS0ZOixEY5qyO/9SSfTTC4FoGQeSNbJtRE1/ouyDWNr
 LXRw==
X-Gm-Message-State: AOJu0Yytg2weJuwLNlY7eMm/eao2Lfk1fPz3Vsd5CzRzKa1M3wXCseCp
 Jb29nllXcSjGZjaxlsgBYtLSjj8OP8Z4SZMiUePAsF7kLzjU9Tqjaazv6mRVDhzXk4SZGi6BPra
 MUuubHo5nIDxIPthVVV9T/m4p+fMuFrPy+pTd91arD7B5WzC50FQTNDH6
X-Gm-Gg: AR+sD10/Y/MyrhR4W+sf6Pa1lX05TslSPjQAmsCuq4aF6gJC3z9Q5dcFEkicomToFFH
 S3HJL8eZpg0FudiQ79WmaiLJt8GsxqeSgmNFekN1WVtJKIzolWDYcRP2m0kos+0ZODo1RCeawjM
 /Zicfa1hvYH39FcTlhsBdcB0cWoAYxRKKDSLRjdOz3cssgCS97vpDB2O047keR0wtK4h6f9SxsR
 W+6Bs1nUXf5SL3K76klJC+zfl9iUFAFFZaCoL6bZ8dKmZyn4jpZelXXGLKve4Chi2CH2BN4WM0A
 k7bca0gKzwBG8TSMDYExDf+jpZOS7mSHfnCtUgNVwNAqMsLcgN+zdfGNts7SaE3ys0N2Pbxvg6i
 ivc4ORQQBSrZnn8JR2ySp5ao=
X-Received: by 2002:a5d:5f47:0:b0:47f:9de0:c27f with SMTP id
 ffacd0b85a97d-47fb1ecc547mr5368298f8f.1.1785280669145; 
 Tue, 28 Jul 2026 16:17:49 -0700 (PDT)
X-Received: by 2002:a5d:5f47:0:b0:47f:9de0:c27f with SMTP id
 ffacd0b85a97d-47fb1ecc547mr5368251f8f.1.1785280668606; 
 Tue, 28 Jul 2026 16:17:48 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm3408491f8f.27.2026.07.28.16.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 16:17:48 -0700 (PDT)
Date: Tue, 28 Jul 2026 19:17:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <20260728190856-mutt-send-email-mst@kernel.org>
References: <20260728153942.1891677-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728153942.1891677-1-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Tue, Jul 28, 2026 at 11:39:42AM -0400, Peter Xu wrote:
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
> 
> PS2: Michael, we have just discussed what we should define as CVE for
> migration, and this one shouldn't fall into CVE category, please refer to:
> 
> https://lore.kernel.org/r/20260721131457.3062767-1-farosas@suse.de
> 
> So I didn't yet attach CVE tag.  Please correct if I'm wrong, thanks.


I agree.

> ---
>  include/hw/virtio/vhost.h   |  5 +++++
>  include/migration/vmstate.h | 10 ----------
>  hw/virtio/vhost.c           | 19 ++++++++++++++-----
>  3 files changed, 19 insertions(+), 15 deletions(-)
> 
> diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> index 684bafcaad..1d1cc24c04 100644
> --- a/include/hw/virtio/vhost.h
> +++ b/include/hw/virtio/vhost.h
> @@ -17,6 +17,11 @@ struct vhost_inflight {
>      int fd;
>      void *addr;
>      uint64_t size;
> +    /*
> +     * This is a temporary variable only used during migration loading to
> +     * satisfy VMSTATE_VBUFFER_UINT32() typing. Please use @size otherwise.
> +     */
> +    uint32_t __size_32bits;
>      uint64_t offset;
>      uint16_t queue_size;
>  };
> diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> index 1b7f295417..a349b2d84a 100644
> --- a/include/migration/vmstate.h
> +++ b/include/migration/vmstate.h
> @@ -782,16 +782,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
>      .offset       = offsetof(_state, _field),                        \
>  }
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
>  #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
>                                       _test, _field_size) {           \
>      .name         = (stringify(_field)),                             \
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index af41841b52..e7c570d0f5 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2022,15 +2022,24 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
>  static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
>  {
>      struct vhost_inflight *inflight = opaque;
> -
>      int fd = -1;
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
>      if (!addr) {
>          return false;
>      }
>  
> +    /* Only used in VMSTATE_VBUFFER_UINT32() */
> +    inflight->__size_32bits = inflight->size;
>      inflight->offset = 0;
>      inflight->addr = addr;
>      inflight->fd = fd;
> @@ -2042,7 +2051,7 @@ const VMStateDescription vmstate_vhost_inflight_region_buffer = {
>      .name = "vhost-inflight-region/buffer",
>      .pre_load_errp = vhost_inflight_buffer_pre_load,
>      .fields = (const VMStateField[]) {
> -        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
> +        VMSTATE_VBUFFER_UINT32(addr, struct vhost_inflight, 0, NULL, __size_32bits),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> -- 
> 2.54.0


