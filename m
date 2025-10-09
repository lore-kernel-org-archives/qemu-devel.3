Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4590CCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 18:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6vpm-0006Jh-0a; Thu, 09 Oct 2025 14:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vpk-0006Gm-EC
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:57:48 -0400
Received: from mail-il1-x12e.google.com ([2607:f8b0:4864:20::12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v6vpd-0005zM-Ix
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 14:57:48 -0400
Received: by mail-il1-x12e.google.com with SMTP id
 e9e14a558f8ab-42f68a0a89aso9907185ab.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 11:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760036260; x=1760641060; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTweRhImyrIR+/+/TVAtXojU+X5/HEJc6k5zg/F+wW4=;
 b=H0zLuNsEArN1ELHmBP1OdxK+srfrhNUxLRlCzu7yjgmeyk5IfiZN5VaREiuntxEkd0
 /5/MY67XEJzlYtqO3jxyiWl89SQi3T/9ppg9YjEicvFf8EYDOFuos55j935n9iCYF+Yd
 YzU+hrtz5kGbeoFaKBu+DqJO/eivWTbooMnssI7muBngPOMyMvkvxfyGRbN/EDf6xIda
 XlC8GGp932UbR6HL+NaJfvgv9NIWOtO7FzVc7qPHvh2nHjl4C5w3BVV7tlKNFVIn4lWS
 4VFBqrPk+WTA3aareyIu53d4gWYmjukuUvfPqw5lry9KPaWnsOxACD6Np8ADQTSfFwzU
 ULmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760036260; x=1760641060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PTweRhImyrIR+/+/TVAtXojU+X5/HEJc6k5zg/F+wW4=;
 b=ek8gGZNv+789VB5SzCwBdgOM3gHgOoMDl8RTZd+SDbMuPmOKBZ50LJyV8GZM2CMF2z
 5KhvbSnLysxvZkyQbj8MAfdGKF2NcaY5yYe766FxNn0lrl1rghT3j4F97TG/wtuxfHPR
 ybWAwUg2/L+QLeXAcdiVR1MFh+ecKFLi1WnmiYlNYrtZPPxS9bjKF0XroRPgIUVw2RoG
 Efjh19TYZt52yvIF7xKv6iKCmmbwsEwDJjy/gcVy2wbD9VAKTDIKsjstScnFJyaO4cwX
 zoKUID2e9gUCxL+rwMZ0inw1nqeBpqN2ffidtGUjOKgEVou+tgQnVDTZjHazlKIjQqQq
 UOTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVZHQzGeV06HgfOw732S9VpnObNxBIbumzFBHH/Y0yINOIpHhmhpcH8wGYuLeQjlugm5l/Mj1/ngTgT@nongnu.org
X-Gm-Message-State: AOJu0YzmZpnWSjsiaRhDnoLJ5yNdHoMBO/xwr60IHX18h2JcuZd5vCIr
 1jADxl0iJqoctvUrzd8kAb/tLuq31PYwjNnKmfczOVBxkhM13iZJwB49N3M7GGWHkCBcCVy3yhC
 8WINlkXu2gW/6KN4u+ZsicszsJwlV90E=
X-Gm-Gg: ASbGncudZceQzX/VqXNkTnE2XPh031pcgDQxyeBsdUHSV+9DEtjNM4ezEonXI8kFjhz
 ylbhRF7pd8dmu8+ANHManTnsRfLuaDsFtdvtTWnBWUCztJdCP82cPq/Pv8g6E6QUkYEtfWfOpVA
 CsaORqVjRGgo50f+o5iM3wj+/ASfUPwkpz1HRCMX4dvYi3b9NFNdPWOYiR6WSMGCaK2kQ5q4k0G
 Zz0J3/JQOjFwwfB1QPuuuC10HypCrG+1/3lmtki6Q==
X-Google-Smtp-Source: AGHT+IFPhiEboGSrf1J0XvkR8rjPWnPKLr4E7eR2ZH1+9IeLD3qsKHkafiLwUzqNNcs54hwzB2uwGefybrtpwQTqbYw=
X-Received: by 2002:a05:6e02:194d:b0:42d:e85a:29e with SMTP id
 e9e14a558f8ab-42f7c3523f6mr149355905ab.6.1760036259494; Thu, 09 Oct 2025
 11:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <20250813164856.950363-4-vsementsov@yandex-team.ru>
In-Reply-To: <20250813164856.950363-4-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 14:57:27 -0400
X-Gm-Features: AS18NWCoiIXIJXo8r0BkyIZLclXTXCe4LFlmJnyqvojXP884xsiuduG0YsC-X1g
Message-ID: <CAFubqFsuZLOhsDiq7HRO+FEsMp6ZKhn4BNKHU6iuuomngJ4+Xw@mail.gmail.com>
Subject: Re: [PATCH 03/33] vhost-user: introduce vhost_user_has_prot() helper
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::12e;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Wed, Aug 13, 2025 at 12:59=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Make all protocol feature checks in the same way.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost-user.c | 102 ++++++++++++++++++-----------------------
>  1 file changed, 44 insertions(+), 58 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index cf6f53801d..6fa5b8a8bd 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -272,6 +272,11 @@ struct scrub_regions {
>      int fd_idx;
>  };
>
> +static bool vhost_user_has_prot(struct vhost_dev *dev, uint64_t feature)
> +{
> +    return virtio_has_feature(dev->protocol_features, feature);
> +}
> +
>  static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *m=
sg)
>  {
>      struct vhost_user *u =3D dev->opaque;
> @@ -435,8 +440,7 @@ static int vhost_user_set_log_base(struct vhost_dev *=
dev, uint64_t base,
>  {
>      int fds[VHOST_USER_MAX_RAM_SLOTS];
>      size_t fd_num =3D 0;
> -    bool shmfd =3D virtio_has_feature(dev->protocol_features,
> -                                    VHOST_USER_PROTOCOL_F_LOG_SHMFD);
> +    bool shmfd =3D vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_LOG_SH=
MFD);
>      int ret;
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_SET_LOG_BASE,
> @@ -1006,11 +1010,10 @@ static int vhost_user_set_mem_table(struct vhost_=
dev *dev,
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>      size_t fd_num =3D 0;
>      bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
> -    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +    bool reply_supported =3D
> +        vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
>      bool config_mem_slots =3D
> -        virtio_has_feature(dev->protocol_features,
> -                           VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
> +        vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLO=
TS);
>      int ret;
>
>      if (do_postcopy) {
> @@ -1058,8 +1061,8 @@ static int vhost_user_set_mem_table(struct vhost_de=
v *dev,
>  static int vhost_user_set_vring_endian(struct vhost_dev *dev,
>                                         struct vhost_vring_state *ring)
>  {
> -    bool cross_endian =3D virtio_has_feature(dev->protocol_features,
> -                                           VHOST_USER_PROTOCOL_F_CROSS_E=
NDIAN);
> +    bool cross_endian =3D
> +        vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_CROSS_ENDIAN);
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_SET_VRING_ENDIAN,
>          .hdr.flags =3D VHOST_USER_VERSION,
> @@ -1129,8 +1132,8 @@ static int vhost_user_write_sync(struct vhost_dev *=
dev, VhostUserMsg *msg,
>      int ret;
>
>      if (wait_for_reply) {
> -        bool reply_supported =3D virtio_has_feature(dev->protocol_featur=
es,
> -                                          VHOST_USER_PROTOCOL_F_REPLY_AC=
K);
> +        bool reply_supported =3D
> +            vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
>          if (reply_supported) {
>              msg->hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>          }
> @@ -1459,8 +1462,7 @@ static int vhost_user_set_features(struct vhost_dev=
 *dev,
>      ret =3D vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES, features,
>                               log_enabled);
>
> -    if (virtio_has_feature(dev->protocol_features,
> -                           VHOST_USER_PROTOCOL_F_STATUS)) {
> +    if (vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
>          if (!ret) {
>              return vhost_user_add_status(dev, VIRTIO_CONFIG_S_FEATURES_O=
K);
>          }
> @@ -1514,8 +1516,7 @@ static int vhost_user_reset_device(struct vhost_dev=
 *dev)
>       * Historically, reset was not implemented so only reset devices
>       * that are expecting it.
>       */
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
> +    if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
>          return -ENOSYS;
>      }
>
> @@ -1572,8 +1573,7 @@ static int vhost_user_backend_handle_vring_host_not=
ifier(struct vhost_dev *dev,
>      void *addr;
>      char *name;
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
> +    if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) |=
|
>          vdev =3D=3D NULL || queue_idx >=3D virtio_get_num_queues(vdev)) =
{
>          return -EINVAL;
>      }
> @@ -1885,13 +1885,12 @@ static int vhost_setup_backend_channel(struct vho=
st_dev *dev)
>      };
>      struct vhost_user *u =3D dev->opaque;
>      int sv[2], ret =3D 0;
> -    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +    bool reply_supported =3D
> +        vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
>      Error *local_err =3D NULL;
>      QIOChannel *ioc;
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
> +    if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
>          return 0;
>      }
>
> @@ -2136,8 +2135,7 @@ static int vhost_user_postcopy_notifier(NotifierWit=
hReturn *notifier,
>
>      switch (pnd->reason) {
>      case POSTCOPY_NOTIFY_PROBE:
> -        if (!virtio_has_feature(dev->protocol_features,
> -                                VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
> +        if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_PAGEFAULT)) =
{
>              /* TODO: Get the device name into this error somehow */
>              error_setg(errp,
>                         "vhost-user backend not capable of postcopy");
> @@ -2228,7 +2226,7 @@ static int vhost_user_backend_init(struct vhost_dev=
 *dev, void *opaque,
>          }
>
>          /* query the max queues we support if backend supports Multiple =
Queue */
> -        if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MQ))=
 {
> +        if (vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_MQ)) {
>              err =3D vhost_user_get_u64(dev, VHOST_USER_GET_QUEUE_NUM,
>                                       &dev->max_queues);
>              if (err < 0) {
> @@ -2246,18 +2244,16 @@ static int vhost_user_backend_init(struct vhost_d=
ev *dev, void *opaque,
>          }
>
>          if (virtio_has_feature(features, VIRTIO_F_IOMMU_PLATFORM) &&
> -                !(virtio_has_feature(dev->protocol_features,
> -                    VHOST_USER_PROTOCOL_F_BACKEND_REQ) &&
> -                 virtio_has_feature(dev->protocol_features,
> -                    VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
> +                !(vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_BACKEND=
_REQ) &&
> +                 vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_REPLY_AC=
K))) {
>              error_setg(errp, "IOMMU support requires reply-ack and "
>                         "backend-req protocol features.");
>              return -EINVAL;
>          }
>
>          /* get max memory regions if backend supports configurable RAM s=
lots */
> -        if (!virtio_has_feature(dev->protocol_features,
> -                                VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOT=
S)) {
> +        if (!vhost_user_has_prot(dev,
> +                                 VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLO=
TS)) {
>              u->user->memory_slots =3D VHOST_MEMORY_BASELINE_NREGIONS;
>          } else {
>              err =3D vhost_user_get_max_memslots(dev, &ram_slots);
> @@ -2279,8 +2275,7 @@ static int vhost_user_backend_init(struct vhost_dev=
 *dev, void *opaque,
>      }
>
>      if (dev->migration_blocker =3D=3D NULL &&
> -        !virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
> +        !vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
>          error_setg(&dev->migration_blocker,
>                     "Migration disabled: vhost-user backend lacks "
>                     "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
> @@ -2349,8 +2344,7 @@ static bool vhost_user_requires_shm_log(struct vhos=
t_dev *dev)
>  {
>      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
>
> -    return virtio_has_feature(dev->protocol_features,
> -                              VHOST_USER_PROTOCOL_F_LOG_SHMFD);
> +    return vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD);
>  }
>
>  static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_ad=
dr)
> @@ -2365,8 +2359,7 @@ static int vhost_user_migration_done(struct vhost_d=
ev *dev, char* mac_addr)
>      }
>
>      /* if backend supports VHOST_USER_PROTOCOL_F_RARP ask it to send the=
 RARP */
> -    if (virtio_has_feature(dev->protocol_features,
> -                           VHOST_USER_PROTOCOL_F_RARP)) {
> +    if (vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_RARP)) {
>          msg.hdr.request =3D VHOST_USER_SEND_RARP;
>          msg.hdr.flags =3D VHOST_USER_VERSION;
>          memcpy((char *)&msg.payload.u64, mac_addr, 6);
> @@ -2380,11 +2373,11 @@ static int vhost_user_migration_done(struct vhost=
_dev *dev, char* mac_addr)
>  static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
>  {
>      VhostUserMsg msg;
> -    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +    bool reply_supported =3D
> +        vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
>      int ret;
>
> -    if (!(dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_NET_MT=
U))) {
> +    if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_NET_MTU)) {
>          return 0;
>      }
>
> @@ -2444,8 +2437,7 @@ static int vhost_user_get_config(struct vhost_dev *=
dev, uint8_t *config,
>          .hdr.size =3D VHOST_USER_CONFIG_HDR_SIZE + config_len,
>      };
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                VHOST_USER_PROTOCOL_F_CONFIG)) {
> +    if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_CONFIG)) {
>          error_setg(errp, "VHOST_USER_PROTOCOL_F_CONFIG not supported");
>          return -EINVAL;
>      }
> @@ -2488,8 +2480,8 @@ static int vhost_user_set_config(struct vhost_dev *=
dev, const uint8_t *data,
>  {
>      int ret;
>      uint8_t *p;
> -    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +    bool reply_supported =3D
> +        vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
>
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_SET_CONFIG,
> @@ -2497,8 +2489,7 @@ static int vhost_user_set_config(struct vhost_dev *=
dev, const uint8_t *data,
>          .hdr.size =3D VHOST_USER_CONFIG_HDR_SIZE + size,
>      };
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                VHOST_USER_PROTOCOL_F_CONFIG)) {
> +    if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_CONFIG)) {
>          return -ENOTSUP;
>      }
>
> @@ -2533,8 +2524,8 @@ static int vhost_user_crypto_create_session(struct =
vhost_dev *dev,
>                                              uint64_t *session_id)
>  {
>      int ret;
> -    bool crypto_session =3D virtio_has_feature(dev->protocol_features,
> -                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESS=
ION);
> +    bool crypto_session =3D
> +        vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
>      CryptoDevBackendSessionInfo *backend_info =3D session_info;
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_CREATE_CRYPTO_SESSION,
> @@ -2635,8 +2626,8 @@ static int
>  vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_=
id)
>  {
>      int ret;
> -    bool crypto_session =3D virtio_has_feature(dev->protocol_features,
> -                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESS=
ION);
> +    bool crypto_session =3D
> +        vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_CLOSE_CRYPTO_SESSION,
>          .hdr.flags =3D VHOST_USER_VERSION,
> @@ -2681,8 +2672,7 @@ static int vhost_user_get_inflight_fd(struct vhost_=
dev *dev,
>          .hdr.size =3D sizeof(msg.payload.inflight),
>      };
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +    if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD))=
 {
>          return 0;
>      }
>
> @@ -2749,8 +2739,7 @@ static int vhost_user_set_inflight_fd(struct vhost_=
dev *dev,
>          .hdr.size =3D sizeof(msg.payload.inflight),
>      };
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +    if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD))=
 {
>          return 0;
>      }
>
> @@ -2849,8 +2838,7 @@ void vhost_user_async_close(DeviceState *d,
>
>  static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
>  {
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_STATUS)) {
> +    if (!vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
>          return 0;
>      }
>
> @@ -2875,16 +2863,14 @@ static void vhost_user_reset_status(struct vhost_=
dev *dev)
>          return;
>      }
>
> -    if (virtio_has_feature(dev->protocol_features,
> -                           VHOST_USER_PROTOCOL_F_STATUS)) {
> +    if (vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_STATUS)) {
>          vhost_user_set_status(dev, 0);
>      }
>  }
>
>  static bool vhost_user_supports_device_state(struct vhost_dev *dev)
>  {
> -    return virtio_has_feature(dev->protocol_features,
> -                              VHOST_USER_PROTOCOL_F_DEVICE_STATE);
> +    return vhost_user_has_prot(dev, VHOST_USER_PROTOCOL_F_DEVICE_STATE);
>  }
>
>  static int vhost_user_set_device_state_fd(struct vhost_dev *dev,
> --
> 2.48.1
>
>

