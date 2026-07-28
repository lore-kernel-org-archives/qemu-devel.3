Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFD21C54F51
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 20:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woosT-0001fr-OR; Tue, 28 Jul 2026 16:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1woosS-0001eG-BP
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:58:16 -0400
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1woosQ-0002wk-2m
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 16:58:16 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B76293E08;
 Tue, 28 Jul 2026 20:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785272287; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1A0ooj8JtfKgp7UEpDBJbA229SMu6Fyl2utYV/uW8M=;
 b=ObRz8gIYnTZjv+CHNwaHUYftePzJAEj1cEFZKdAxxplmjd3I3D2dLNJHxy/DjMTnNUMNzj
 AqlAONzpafRDO5jzIilY/5BAgfBw0T8k+mSUSCHcvK9+aKUdILGpnyN29/7bcVxoDJD0g1
 xKhP4PP3Ln+cAPEUgFdjyswRqcoXuKM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785272287;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1A0ooj8JtfKgp7UEpDBJbA229SMu6Fyl2utYV/uW8M=;
 b=9zoMpYOf5XtoYjxs3wPmiRdERENf/w7TQlSDa+4y4VwJoACRKeyUMlzXch4FepoiFEAaZx
 XrraaOmUrxl8gSDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=a0o+5Dly;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yYZIEH5Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785272283; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1A0ooj8JtfKgp7UEpDBJbA229SMu6Fyl2utYV/uW8M=;
 b=a0o+5Dlyso41rJdt8kWzGKVs4QO1qMj+IjrJalb7Bg+Nz4Cjg61PGKnh9aqI4L/qUnq8Td
 bmYruHHuRzeh0j3NkNj1SajaUb6k0AR/Uunze4VM9eSjUVtq6f0eKng/TCpnq7fVwR7WDR
 2Faslt5GubZWnl/jKWzCK3dY63VGfpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785272283;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e1A0ooj8JtfKgp7UEpDBJbA229SMu6Fyl2utYV/uW8M=;
 b=yYZIEH5Ymr/kKp3U9jpAMXpExdWKnPCh3ptvGLa0iBj3S/qDxEiVqzBP52p/VaaiX51Qm1
 NVRY4HkIdufr9+Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4CC93779B1;
 Tue, 28 Jul 2026 20:58:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3jFLB9sXaWrsCAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 28 Jul 2026 20:58:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Stefano
 Garzarella <sgarzare@redhat.com>, =?utf-8?B?6rmA7Iq57KSR?=
 <seungjung0711@gmail.com>, Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Subject: Re: [PATCH] vhost/migration: Fix incorrect size used in
 inflight->addr in VMSD
In-Reply-To: <20260728153942.1891677-1-peterx@redhat.com>
References: <20260728153942.1891677-1-peterx@redhat.com>
Date: Tue, 28 Jul 2026 17:57:56 -0300
Message-ID: <87jyqeomqz.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 MID_RHS_MATCH_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,gmail.com,yandex-team.ru];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,gitlab.com:url];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B76293E08
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

Peter Xu <peterx@redhat.com> writes:

> It was overlooked that VMSTATE_VBUFFER_UINT64() won't really work with an
> uint64_t, as vmstate core only treats the size as 32bits, and maximum
> INT32_MAX (see vmstate_size()).
>
> Considering that we do not need real 64bits for the size, stick with the =
2G
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
> Reported-by: =EA=B9=80=EC=8A=B9=EC=A4=91 <seungjung0711@gmail.com>
> Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Fixes: 3a80ff0721 ("vhost: add vmstate for inflight region with inner buf=
fer")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>
> PS1: I only did smoke test as I'm not fluent with vhost inflight feature.
> Please kindly try it out if possible. In general, migrations from older
> QEMU should work even after applied.  One can also treat this as partly-R=
FC
> from that.
>
> PS2: Michael, we have just discussed what we should define as CVE for
> migration, and this one shouldn't fall into CVE category, please refer to:
>
> https://lore.kernel.org/r/20260721131457.3062767-1-farosas@suse.de
>
> So I didn't yet attach CVE tag.  Please correct if I'm wrong, thanks.
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
> +     * satisfy VMSTATE_VBUFFER_UINT32() typing. Please use @size otherwi=
se.
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
>      .offset       =3D offsetof(_state, _field),                        \
>  }
>=20=20
> -#define VMSTATE_VBUFFER_UINT64(_field, _state, _version, _test, _field_s=
ize) { \
> -    .name         =3D (stringify(_field)),                             \
> -    .version_id   =3D (_version),                                      \
> -    .field_exists =3D (_test),                                         \
> -    .size_offset  =3D vmstate_offset_value(_state, _field_size, uint64_t=
),\
> -    .info         =3D &vmstate_info_buffer,                            \
> -    .flags        =3D VMS_VBUFFER | VMS_POINTER,                       \
> -    .offset       =3D offsetof(_state, _field),                        \
> -}

Why don't you just leave this macro around, put a "do not use" comment
above it and remove the type check for this one instance? You're already
checking against INT32_MAX during pre_load.

We could even lift that check up into vmstate_pre_load and reject
there globally, don't even touch the virtio code.


/rant
... what's even the point of having per-type variants of VMSTATE macros
that exist just to type-check the extra offsets (.num_offset,
.size_offset as opposed to .offset)?

For instance, look at vmstate_n_elems casting opaque data to 32 and
sub-32bit size and assigning to an int! What do we gain from that? It's
circular reasoning that does nothing aside from bothering the person
writing the vmstate.

Right? Maybe I'm missing something, it's the end of the day already.

> -
>  #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
>                                       _test, _field_size) {           \
>      .name         =3D (stringify(_field)),                             \
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index af41841b52..e7c570d0f5 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -2022,15 +2022,24 @@ void vhost_get_features_ex(struct vhost_dev *hdev,
>  static bool vhost_inflight_buffer_pre_load(void *opaque, Error **errp)
>  {
>      struct vhost_inflight *inflight =3D opaque;
> -
>      int fd =3D -1;
> -    void *addr =3D qemu_memfd_alloc("vhost-inflight", inflight->size,
> -                                  F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_S=
EAL,
> -                                  &fd, errp);
> +    void *addr;
> +
> +    if (inflight->size > INT32_MAX) {
> +        error_setg(errp, "inflight size '%"PRIu64"' exceeds "
> +                   "migration limit '%"PRIu32"'", inflight->size, INT32_=
MAX);
> +        return false;
> +    }
> +
> +    addr =3D qemu_memfd_alloc("vhost-inflight", inflight->size,
> +                            F_SEAL_GROW | F_SEAL_SHRINK | F_SEAL_SEAL,
> +                            &fd, errp);
>      if (!addr) {
>          return false;
>      }
>=20=20
> +    /* Only used in VMSTATE_VBUFFER_UINT32() */
> +    inflight->__size_32bits =3D inflight->size;
>      inflight->offset =3D 0;
>      inflight->addr =3D addr;
>      inflight->fd =3D fd;
> @@ -2042,7 +2051,7 @@ const VMStateDescription vmstate_vhost_inflight_reg=
ion_buffer =3D {
>      .name =3D "vhost-inflight-region/buffer",
>      .pre_load_errp =3D vhost_inflight_buffer_pre_load,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_VBUFFER_UINT64(addr, struct vhost_inflight, 0, NULL, siz=
e),
> +        VMSTATE_VBUFFER_UINT32(addr, struct vhost_inflight, 0, NULL, __s=
ize_32bits),
>          VMSTATE_END_OF_LIST()
>      }
>  };

