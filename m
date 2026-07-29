Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C6FAC54F51
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jul 2026 08:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wozyf-0005ei-GL; Wed, 29 Jul 2026 04:49:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wozyd-0005dc-Io
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:49:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wozyb-0000vx-N6
 for qemu-devel@nongnu.org; Wed, 29 Jul 2026 04:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785314960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yh3BIB+H9/koe2qpEOET1hY0QQoEPObrHfwGhNalzE=;
 b=OqVUd6G5z/reje4tSu8KFSE1reDtMIqtsxwEG/OADFN4S1juCH4qZiKwKGCVJaGNWLGhpq
 zA/6ywQuwk0bf8lC6CYnfTmv4W2W/8YyZUb5/rKVlJ9n2YQfm/KTKmHk8lUN8pLPECqT0t
 4RHFWoYEgsDutkvZcm8hr7XqOs+SGpw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-MRIsR1oRMhGHOLWN237Ocg-1; Wed, 29 Jul 2026 04:49:18 -0400
X-MC-Unique: MRIsR1oRMhGHOLWN237Ocg-1
X-Mimecast-MFC-AGG-ID: MRIsR1oRMhGHOLWN237Ocg_1785314957
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a767b782so5216255e9.2
 for <qemu-devel@nongnu.org>; Wed, 29 Jul 2026 01:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785314957; x=1785919757; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2yh3BIB+H9/koe2qpEOET1hY0QQoEPObrHfwGhNalzE=;
 b=Q/BhA6LKLJEOIqocklhprBrKMt7jxzeESkLwKjYSWjoh65rum4V0iydjpkgrpoRYdC
 7YKWKzci7cXfPhFkG0Tnw/ijpgRzKlk5fwWzKYXEcwdY2TT1uCy7lgYYfCDnFLDE/1N8
 NCSaknh0JCdT09KneB3dtDi9qeWiyfvWh91a8ZG4XMjTttavusvkERLRgAQLoMNWqi3I
 5M+rUGk33UoHVedZGWxEacASgtYUEG7fiuCZI8g7c5ou8EQLNnDpMZNvK5nmbx6fT11a
 2yruEPM6hKbIuJXFCBDKMiabIjBBYKx/5h3D8GsOd0W4LWJGnUfqY6luE8pHU5cYCi63
 mzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785314957; x=1785919757;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2yh3BIB+H9/koe2qpEOET1hY0QQoEPObrHfwGhNalzE=;
 b=Xyiwf8tzLmvHUMXLXxlQzkjHVd6rs9Xztxaq8jOFddenY7NMUO3FkZqk5E3ol6eLQs
 iq52nI/8fAFFn8K7ng1uLsR1XPtSTAF3WKqkIwvmc05WSKBRnt/FCp5UuCMBrbvUPdjX
 0gm0+qEYzjhJghKZ3ioPHCNYObepxq0zFKLZTUd4E0Xy49l/PGYV25TQbNoGWJPsiNbR
 sL8SmlwPEUsnZxhg7lZM3OZD0SA3YPT/+cplrMZy/6ncZj3TE9FJcDXJj1msVSOtBx0P
 d7GHnvoCuYzFmtNW+k9b/eOtQ4Wx8kcmxws7v0LWh2obPD3Mc+4oVABTqwhH3KSLZNUN
 AZRQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoNXhEnSUR2Mkq/PMjsEFHjbPw2lfLI9MagL19DhxBUweYKU7H+8VM8D9fWzj3YuqDV42xCiAq5uqkk@nongnu.org
X-Gm-Message-State: AOJu0YyVNnbiClmsZOV4iDhxRv8ZwXBBlUlPtFsn151OzHmsBVFcZ/iP
 /GGv45ICJamTfc3DwrQnrBrZtxCIi+HiwvMsnUyWbNAIraHehOoyrHg4R8fr9WrqkYZJrRNClIR
 VfKaVqUbWP19yNStrZ0CPlsTdOKMS6iziJPKnNPR4AcB8bnd1DLL9wTWe
X-Gm-Gg: AR+sD11/8Z3+bXsmI9Ho5JbQ/Ui4V2V5Jc3STn64rGUiCSqbniGklt2jf0VXtf5ylKC
 lncRJC4nYdkWsZnZ6FmgiPKbAxwuiRLV1a7tVU5ThHqtq8gbGTcy/xG/GqCr+PCN8TPVDz3YVFD
 Mwh7eID6pupda4d9YaSMKgRRk4ijtakkdcSIseJXRn405evfb/FJ74rBGYYB6RCGijG3LnN0UKt
 pfMx6cifb/e7iJpX4A35IyQ8+hOelKndLCnRAXLetcsOuxuAFWQSkPm6Pk2VcK9NTeUhxde3Rta
 +x/cD/Y29Bu2B8HRlUT0syRSN9VyEF0W/ebRAJxBIGEbSuJiDubaxZIoH9H7DIiV9ejj1rGPrU0
 jCfmeVQACQY4Gkq8iFQBiZD4=
X-Received: by 2002:a05:600c:630d:b0:495:5365:c0d2 with SMTP id
 5b1f17b1804b1-496c6558b53mr72676355e9.14.1785314957113; 
 Wed, 29 Jul 2026 01:49:17 -0700 (PDT)
X-Received: by 2002:a05:600c:630d:b0:495:5365:c0d2 with SMTP id
 5b1f17b1804b1-496c6558b53mr72675905e9.14.1785314956547; 
 Wed, 29 Jul 2026 01:49:16 -0700 (PDT)
Received: from redhat.com (ppp-94-66-118-61.home.otenet.gr. [94.66.118.61])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44afaecsm156645945e9.2.2026.07.29.01.49.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 01:49:15 -0700 (PDT)
Date: Wed, 29 Jul 2026 04:49:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Stefano Garzarella <sgarzare@redhat.com>,
 =?utf-8?B?6rmA7Iq57KSR?= <seungjung0711@gmail.com>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
Message-ID: <20260729041953-mutt-send-email-mst@kernel.org>
References: <20260728153942.1891677-1-peterx@redhat.com>
 <77c2f243-498f-4f2f-9dfd-1ccb2c9aa94b@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77c2f243-498f-4f2f-9dfd-1ccb2c9aa94b@yandex-team.ru>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Jul 29, 2026 at 12:25:05PM +0500, Alexandr Moshkov wrote:
> 
> On 7/28/26 20:39, Peter Xu wrote:
> > It was overlooked that VMSTATE_VBUFFER_UINT64() won't really work with an
> > uint64_t, as vmstate core only treats the size as 32bits, and maximum
> > INT32_MAX (see vmstate_size()).
> > 
> > Considering that we do not need real 64bits for the size, stick with the 2G
> > limit, converting the size field into 32bits.
> > 
> > Since we can't touch the wire protocol on migration from an old QEMU, we
> > can't directly modify the type of size to uint32_t.  Instead, we need to
> > introduce a temporary variable for this extremely rare issue __size_32bits
> > to be used only for VMSTATE_VBUFFER_UINT32().  Document it and name it
> > weird enough so people won't get confused on having two size variables.
> > 
> > Remove VMSTATE_VBUFFER_UINT64() altogether, because it was never going to
> > be used right.  It means QEMU will only support 2G max for VMS_VBUFFER.
> > 
> > Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3675
> > Reported-by: 김승중 <seungjung0711@gmail.com>
> > Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> > Cc: Michael S. Tsirkin <mst@redhat.com>
> > Cc: Fabiano Rosas <farosas@suse.de>
> > Fixes: 3a80ff0721 ("vhost: add vmstate for inflight region with inner buffer")
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> > 
> > PS1: I only did smoke test as I'm not fluent with vhost inflight feature.
> > Please kindly try it out if possible. In general, migrations from older
> > QEMU should work even after applied.  One can also treat this as partly-RFC
> > from that.
> 
> It looks like inflight migration is broken:
> 
> qemu-system-x86_64: Missing section footer for
> 0000:00:02.0:00.0:00.0/vhost-user-blk
> migrate_error error=load of migration failed: Invalid argument: Section
> footer error, section_id: 53
> qemu-system-x86_64: load of migration failed: Invalid argument: Section
> footer error, section_id: 53
> 
> As far as I understand this happen because __size_32bits not initialized on
> source - it's never set. So vmstate_size() reads 0, and zero-lenght buffer
> is written into migration stream.
> The destination then allocates the correct buffer but reads 0 bytes from the
> stream, leaving unconsumed data and causing the section footer check to
> fail.
> 
> It can be fixed with adding pre_save (or pre_save_errp) to
> vmstate_vhost_inflight_region_buffer that initialize __size_32bits from
> size:
> 
> static int vhost_inflight_buffer_pre_save(void *opaque)
> {
>     struct vhost_inflight *inflight = opaque;
>     /* Only used in VMSTATE_VBUFFER_UINT32() */
>     inflight->__size_32bits = inflight->size;
>     return 0;
> }

At which point I ask whether open coding all this mess
is so much better.


Way I look at it, vmstate machinery had an API of storing size in u64
that it failed to implement correctly. Why not fix it?



> > 
> > PS2: Michael, we have just discussed what we should define as CVE for
> > migration, and this one shouldn't fall into CVE category, please refer to:
> > 
> > https://lore.kernel.org/r/20260721131457.3062767-1-farosas@suse.de
> > 
> > So I didn't yet attach CVE tag.  Please correct if I'm wrong, thanks.
> > ---
> >   include/hw/virtio/vhost.h   |  5 +++++
> >   include/migration/vmstate.h | 10 ----------
> >   hw/virtio/vhost.c           | 19 ++++++++++++++-----
> >   3 files changed, 19 insertions(+), 15 deletions(-)
> > 
> > diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
> > index 684bafcaad..1d1cc24c04 100644
> > --- a/include/hw/virtio/vhost.h
> > +++ b/include/hw/virtio/vhost.h
> > @@ -17,6 +17,11 @@ struct vhost_inflight {
> >       int fd;
> >       void *addr;
> >       uint64_t size;
> > +    /*
> > +     * This is a temporary variable only used during migration loading to
> > +     * satisfy VMSTATE_VBUFFER_UINT32() typing. Please use @size otherwise.
> > +     */
> > +    uint32_t __size_32bits;
> >       uint64_t offset;
> >       uint16_t queue_size;
> >   };
> > diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
> > index 1b7f295417..a349b2d84a 100644
> > --- a/include/migration/vmstate.h
> > +++ b/include/migration/vmstate.h
> > @@ -782,16 +782,6 @@ extern const VMStateInfo vmstate_info_g_byte_array;
> >       .offset       = offsetof(_state, _field),                        \
> >   }
> > -#define VMSTATE_VBUFFER_UINT64(_field, _state, _version, _test, _field_size) { \
> > -    .name         = (stringify(_field)),                             \
> > -    .version_id   = (_version),                                      \
> > -    .field_exists = (_test),                                         \
> > -    .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
> > -    .info         = &vmstate_info_buffer,                            \
> > -    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
> > -    .offset       = offsetof(_state, _field),                        \
> > -}
> > -
> >   #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
> >                                        _test, _field_size) {           \
> >       .name         = (stringify(_field)),                             \
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index af41841b52..e7c570d0f5 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -2022,15 +2022,24 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
> >   static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
> >   {
> >       struct vhost_inflight *inflight = opaque;
> > -
> >       int fd = -1;
> > -    void *addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> > -                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > -                                  &fd, errp);
> > +    void *addr;
> > +
> > +    if (inflight->size > INT32_MAX) {
> > +        error_setg(errp, "inflight size '%"PRIu64"' exceeds "
> > +                   "migration limit '%"PRIu32"'", inflight->size, INT32_MAX);
> > +        return false;
> > +    }
> > +
> > +    addr = qemu_memfd_alloc("vhost-inflight", inflight->size,
> > +                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> > +                            &fd, errp);
> >       if (!addr) {
> >           return false;
> >       }
> > +    /* Only used in VMSTATE_VBUFFER_UINT32() */
> > +    inflight->__size_32bits = inflight->size;
> >       inflight->offset = 0;
> >       inflight->addr = addr;
> >       inflight->fd = fd;
> > @@ -2042,7 +2051,7 @@ const VMStateDescription vmstate_vhost_inflight_region_buffer = {
> >       .name = "vhost-inflight-region/buffer",
> >       .pre_load_errp = vhost_inflight_buffer_pre_load,
> >       .fields = (const VMStateField[]) {
> > -        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, size),
> > +        VMSTATE_VBUFFER_UINT32(addr, struct vhost_inflight, 0, NULL, __size_32bits),
> >           VMSTATE_END_OF_LIST()
> >       }
> >   };


