Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E290CCD185
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 18:47:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8NZ6-0006T0-66; Mon, 13 Oct 2025 14:46:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8NYw-0006SK-OZ
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 14:46:30 -0400
Received: from mail-il1-x133.google.com ([2607:f8b0:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v8NYu-0006l6-JR
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 14:46:26 -0400
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-42d8a0f09f6so17736125ab.3
 for <qemu-devel@nongnu.org>; Mon, 13 Oct 2025 11:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760381182; x=1760985982; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sXqKlCfUgG7DLebj5gwXdttUXlbk5oYHrV+b+6qdXKs=;
 b=dx26nq8mcdS7LDlnRobQUsUIheA8kY7F3joJXB6SC62MGFgpzRYKM8Y/vB247qBHp/
 Y86Y4t73hhle789qwk6a5kx9HbPF/hiP+3BmSv5l/AlUUxRPmOM/i0+aZPDYu9u9vrJl
 sDjQlfJURGncZBjhpe2SiSjRB8CDC3y1Q9aAt7QCno+jixuc1zS9MzOVRaZWbQhMbHbe
 214/KqJxHrkgVwjPGNQURiXPgMRzIWzhFkEvEzOH9elPwEYzQCj7QZ2ffnJzARsb+MEU
 Dk0Y/mbHVdFO2OoE9sGCKqa7cz8hhAYCRQy3wmsrCAaITLzHRN8EdLHW+1lpRfRYzS/e
 iM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760381182; x=1760985982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sXqKlCfUgG7DLebj5gwXdttUXlbk5oYHrV+b+6qdXKs=;
 b=UB0EMjWJ+4kdtJ9O2Sos5YSbRPFZY1r8dvONNGms7P9arMs2imdUrP+dLrM/74cxYa
 Y2v04bKktV4xQ0YbAw07lKWw2MiRagkWQ03pmxVG49/XivHwzHm8ZTaTAoeUnSolNx8/
 qvl0LaD6uYdk9FMibIE9rqNVFQUlF+7vadptEMlJi8ImYcWl/v2HNyUH+Q9kwZQVo+y5
 SXypZGJLP8Q1jkNFlhuGV2N1dQ0u7hNDaXFjgADliZ7ajTZh1c5UyP05aqp7iaRJuV9Q
 8+dk3sikSPPLQmqrZdxrYFN4wFhNUlb9I2ElJ7xPVxUKj4kK/rvkwj+wgpZ4UBaDW/jR
 TIQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz65UY04eyc/7jM8eXWy1saZaT/KocUXJUBeM2be5yKiT6FlmxXTT4svrxY9PewbNwqQRiihA9xeLJ@nongnu.org
X-Gm-Message-State: AOJu0Yxsg1d7oZu6BCS1yOX4aQvC+cSfU4uOPQSu6R0SAecwjNkH2LHu
 Kb9tYEe1iuZ1bvwHfJ5sjkyRa73ti5qA6xKWccPGYnL+z3lQjf+rq/YQnLt8hma8EQC5UeAjJu1
 DsfQjU43SvEgJgI3i+iCh9JIm2Potq4w=
X-Gm-Gg: ASbGncu1yWwUkQX8EfWolYmRh1RINnjJk7AYGcbk0YV+D8infusBNJuKBLwQVlPsGn6
 NCs+fOM6L3/ZCH+iGb5wEjHfGdR4m+YxY1VnXkFo4bJ7NeB7PiiqGtkytT6cfulbb5Z1dpoC6Nb
 PPxVizZRrrQF2/bNZG/od8wZRNZ7TNFQlmDLemW6nEu/8bHcoDOABvfLCdcQzaa3xrHzUb+jg77
 D60jI8R53JTayFEcomZ0JILkPmfUdu26Yzw
X-Google-Smtp-Source: AGHT+IFXgyiiDRx0012mk/Bxho+5IupoMrdX0pqkF5axTyRbXdAFgn3V26Z1yQyZFZDBvMPQHt37TXvCxgKBtSOcV/c=
X-Received: by 2002:a05:6e02:3082:b0:430:a0f7:a5b1 with SMTP id
 e9e14a558f8ab-430a0f7b7b0mr1458035ab.24.1760381182107; Mon, 13 Oct 2025
 11:46:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251011232404.561024-1-vsementsov@yandex-team.ru>
 <20251011232404.561024-4-vsementsov@yandex-team.ru>
In-Reply-To: <20251011232404.561024-4-vsementsov@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 13 Oct 2025 14:46:11 -0400
X-Gm-Features: AS18NWB0lJGgiteCX9xa2PpaxofGJ2zsKlYZIEgx0ih0oQypDqiIhJfm0GUO-kQ
Message-ID: <CAFubqFuX=56zLK5yctP1pcdjzqL05+YJdBMt3-wurhFnWZAPTQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/23] vhost-user: introduce
 vhost_user_has_protocol_feature() helper
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net, 
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::133;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reviewed-by: Raphael Norwitz <raphael.s.norwitz@gmail.com>

On Sat, Oct 11, 2025 at 7:24=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> Make all protocol feature checks in the same way.
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  hw/virtio/vhost-user.c | 120 +++++++++++++++++++++--------------------
>  1 file changed, 62 insertions(+), 58 deletions(-)
>
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index b80174f489..b8231dcbcf 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -272,6 +272,12 @@ struct scrub_regions {
>      int fd_idx;
>  };
>
> +static bool vhost_user_has_protocol_feature(struct vhost_dev *dev,
> +                                            uint64_t feature)
> +{
> +    return virtio_has_feature(dev->protocol_features, feature);
> +}
> +
>  static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *m=
sg)
>  {
>      struct vhost_user *u =3D dev->opaque;
> @@ -435,8 +441,8 @@ static int vhost_user_set_log_base(struct vhost_dev *=
dev, uint64_t base,
>  {
>      int fds[VHOST_USER_MAX_RAM_SLOTS];
>      size_t fd_num =3D 0;
> -    bool shmfd =3D virtio_has_feature(dev->protocol_features,
> -                                    VHOST_USER_PROTOCOL_F_LOG_SHMFD);
> +    bool shmfd =3D
> +        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_LOG_S=
HMFD);
>      int ret;
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_SET_LOG_BASE,
> @@ -1006,11 +1012,11 @@ static int vhost_user_set_mem_table(struct vhost_=
dev *dev,
>      int fds[VHOST_MEMORY_BASELINE_NREGIONS];
>      size_t fd_num =3D 0;
>      bool do_postcopy =3D u->postcopy_listen && u->postcopy_fd.handler;
> -    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +    bool reply_supported =3D
> +        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY=
_ACK);
>      bool config_mem_slots =3D
> -        virtio_has_feature(dev->protocol_features,
> -                           VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
> +        vhost_user_has_protocol_feature(
> +            dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS);
>      int ret;
>
>      if (do_postcopy) {
> @@ -1058,8 +1064,9 @@ static int vhost_user_set_mem_table(struct vhost_de=
v *dev,
>  static int vhost_user_set_vring_endian(struct vhost_dev *dev,
>                                         struct vhost_vring_state *ring)
>  {
> -    bool cross_endian =3D virtio_has_feature(dev->protocol_features,
> -                                           VHOST_USER_PROTOCOL_F_CROSS_E=
NDIAN);
> +    bool cross_endian =3D
> +        vhost_user_has_protocol_feature(
> +            dev, VHOST_USER_PROTOCOL_F_CROSS_ENDIAN);
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_SET_VRING_ENDIAN,
>          .hdr.flags =3D VHOST_USER_VERSION,
> @@ -1129,8 +1136,9 @@ static int vhost_user_write_sync(struct vhost_dev *=
dev, VhostUserMsg *msg,
>      int ret;
>
>      if (wait_for_reply) {
> -        bool reply_supported =3D virtio_has_feature(dev->protocol_featur=
es,
> -                                          VHOST_USER_PROTOCOL_F_REPLY_AC=
K);
> +        bool reply_supported =3D
> +            vhost_user_has_protocol_feature(
> +                dev, VHOST_USER_PROTOCOL_F_REPLY_ACK);
>          if (reply_supported) {
>              msg->hdr.flags |=3D VHOST_USER_NEED_REPLY_MASK;
>          }
> @@ -1458,8 +1466,7 @@ static int vhost_user_set_features(struct vhost_dev=
 *dev,
>      ret =3D vhost_user_set_u64(dev, VHOST_USER_SET_FEATURES, features,
>                               log_enabled);
>
> -    if (virtio_has_feature(dev->protocol_features,
> -                           VHOST_USER_PROTOCOL_F_STATUS)) {
> +    if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STATU=
S)) {
>          if (!ret) {
>              return vhost_user_add_status(dev, VIRTIO_CONFIG_S_FEATURES_O=
K);
>          }
> @@ -1513,8 +1520,8 @@ static int vhost_user_reset_device(struct vhost_dev=
 *dev)
>       * Historically, reset was not implemented so only reset devices
>       * that are expecting it.
>       */
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
> +    if (!vhost_user_has_protocol_feature(
> +            dev, VHOST_USER_PROTOCOL_F_RESET_DEVICE)) {
>          return -ENOSYS;
>      }
>
> @@ -1571,8 +1578,8 @@ static int vhost_user_backend_handle_vring_host_not=
ifier(struct vhost_dev *dev,
>      void *addr;
>      char *name;
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
> +    if (!vhost_user_has_protocol_feature(
> +            dev, VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) ||
>          vdev =3D=3D NULL || queue_idx >=3D virtio_get_num_queues(vdev)) =
{
>          return -EINVAL;
>      }
> @@ -1884,13 +1891,13 @@ static int vhost_setup_backend_channel(struct vho=
st_dev *dev)
>      };
>      struct vhost_user *u =3D dev->opaque;
>      int sv[2], ret =3D 0;
> -    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +    bool reply_supported =3D
> +        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY=
_ACK);
>      Error *local_err =3D NULL;
>      QIOChannel *ioc;
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
> +    if (!vhost_user_has_protocol_feature(
> +            dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ)) {
>          return 0;
>      }
>
> @@ -2138,8 +2145,8 @@ static int vhost_user_postcopy_notifier(NotifierWit=
hReturn *notifier,
>
>      switch (pnd->reason) {
>      case POSTCOPY_NOTIFY_PROBE:
> -        if (!virtio_has_feature(dev->protocol_features,
> -                                VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
> +        if (!vhost_user_has_protocol_feature(
> +                dev, VHOST_USER_PROTOCOL_F_PAGEFAULT)) {
>              /* TODO: Get the device name into this error somehow */
>              error_setg(errp,
>                         "vhost-user backend not capable of postcopy");
> @@ -2230,7 +2237,7 @@ static int vhost_user_backend_init(struct vhost_dev=
 *dev, void *opaque,
>          }
>
>          /* query the max queues we support if backend supports Multiple =
Queue */
> -        if (dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_MQ))=
 {
> +        if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_M=
Q)) {
>              err =3D vhost_user_get_u64(dev, VHOST_USER_GET_QUEUE_NUM,
>                                       &dev->max_queues);
>              if (err < 0) {
> @@ -2248,18 +2255,18 @@ static int vhost_user_backend_init(struct vhost_d=
ev *dev, void *opaque,
>          }
>
>          if (virtio_has_feature(features, VIRTIO_F_IOMMU_PLATFORM) &&
> -                !(virtio_has_feature(dev->protocol_features,
> -                    VHOST_USER_PROTOCOL_F_BACKEND_REQ) &&
> -                 virtio_has_feature(dev->protocol_features,
> -                    VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
> +            !(vhost_user_has_protocol_feature(
> +                dev, VHOST_USER_PROTOCOL_F_BACKEND_REQ) &&
> +            vhost_user_has_protocol_feature(
> +                dev, VHOST_USER_PROTOCOL_F_REPLY_ACK))) {
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
> +        if (!vhost_user_has_protocol_feature(
> +                dev, VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS)) {
>              u->user->memory_slots =3D VHOST_MEMORY_BASELINE_NREGIONS;
>          } else {
>              err =3D vhost_user_get_max_memslots(dev, &ram_slots);
> @@ -2281,8 +2288,8 @@ static int vhost_user_backend_init(struct vhost_dev=
 *dev, void *opaque,
>      }
>
>      if (dev->migration_blocker =3D=3D NULL &&
> -        !virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
> +        !vhost_user_has_protocol_feature(
> +            dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD)) {
>          error_setg(&dev->migration_blocker,
>                     "Migration disabled: vhost-user backend lacks "
>                     "VHOST_USER_PROTOCOL_F_LOG_SHMFD feature.");
> @@ -2351,8 +2358,8 @@ static bool vhost_user_requires_shm_log(struct vhos=
t_dev *dev)
>  {
>      assert(dev->vhost_ops->backend_type =3D=3D VHOST_BACKEND_TYPE_USER);
>
> -    return virtio_has_feature(dev->protocol_features,
> -                              VHOST_USER_PROTOCOL_F_LOG_SHMFD);
> +    return vhost_user_has_protocol_feature(
> +        dev, VHOST_USER_PROTOCOL_F_LOG_SHMFD);
>  }
>
>  static int vhost_user_migration_done(struct vhost_dev *dev, char* mac_ad=
dr)
> @@ -2367,8 +2374,7 @@ static int vhost_user_migration_done(struct vhost_d=
ev *dev, char* mac_addr)
>      }
>
>      /* if backend supports VHOST_USER_PROTOCOL_F_RARP ask it to send the=
 RARP */
> -    if (virtio_has_feature(dev->protocol_features,
> -                           VHOST_USER_PROTOCOL_F_RARP)) {
> +    if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_RARP)=
) {
>          msg.hdr.request =3D VHOST_USER_SEND_RARP;
>          msg.hdr.flags =3D VHOST_USER_VERSION;
>          memcpy((char *)&msg.payload.u64, mac_addr, 6);
> @@ -2382,11 +2388,11 @@ static int vhost_user_migration_done(struct vhost=
_dev *dev, char* mac_addr)
>  static int vhost_user_net_set_mtu(struct vhost_dev *dev, uint16_t mtu)
>  {
>      VhostUserMsg msg;
> -    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +    bool reply_supported =3D
> +        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY=
_ACK);
>      int ret;
>
> -    if (!(dev->protocol_features & (1ULL << VHOST_USER_PROTOCOL_F_NET_MT=
U))) {
> +    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_NET_=
MTU)) {
>          return 0;
>      }
>
> @@ -2446,8 +2452,7 @@ static int vhost_user_get_config(struct vhost_dev *=
dev, uint8_t *config,
>          .hdr.size =3D VHOST_USER_CONFIG_HDR_SIZE + config_len,
>      };
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                VHOST_USER_PROTOCOL_F_CONFIG)) {
> +    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_CONF=
IG)) {
>          error_setg(errp, "VHOST_USER_PROTOCOL_F_CONFIG not supported");
>          return -EINVAL;
>      }
> @@ -2490,8 +2495,8 @@ static int vhost_user_set_config(struct vhost_dev *=
dev, const uint8_t *data,
>  {
>      int ret;
>      uint8_t *p;
> -    bool reply_supported =3D virtio_has_feature(dev->protocol_features,
> -                                              VHOST_USER_PROTOCOL_F_REPL=
Y_ACK);
> +    bool reply_supported =3D
> +        vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_REPLY=
_ACK);
>
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_SET_CONFIG,
> @@ -2499,8 +2504,7 @@ static int vhost_user_set_config(struct vhost_dev *=
dev, const uint8_t *data,
>          .hdr.size =3D VHOST_USER_CONFIG_HDR_SIZE + size,
>      };
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                VHOST_USER_PROTOCOL_F_CONFIG)) {
> +    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_CONF=
IG)) {
>          return -ENOTSUP;
>      }
>
> @@ -2535,8 +2539,9 @@ static int vhost_user_crypto_create_session(struct =
vhost_dev *dev,
>                                              uint64_t *session_id)
>  {
>      int ret;
> -    bool crypto_session =3D virtio_has_feature(dev->protocol_features,
> -                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESS=
ION);
> +    bool crypto_session =3D
> +        vhost_user_has_protocol_feature(
> +            dev, VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
>      CryptoDevBackendSessionInfo *backend_info =3D session_info;
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_CREATE_CRYPTO_SESSION,
> @@ -2637,8 +2642,9 @@ static int
>  vhost_user_crypto_close_session(struct vhost_dev *dev, uint64_t session_=
id)
>  {
>      int ret;
> -    bool crypto_session =3D virtio_has_feature(dev->protocol_features,
> -                                       VHOST_USER_PROTOCOL_F_CRYPTO_SESS=
ION);
> +    bool crypto_session =3D
> +        vhost_user_has_protocol_feature(
> +            dev, VHOST_USER_PROTOCOL_F_CRYPTO_SESSION);
>      VhostUserMsg msg =3D {
>          .hdr.request =3D VHOST_USER_CLOSE_CRYPTO_SESSION,
>          .hdr.flags =3D VHOST_USER_VERSION,
> @@ -2683,8 +2689,8 @@ static int vhost_user_get_inflight_fd(struct vhost_=
dev *dev,
>          .hdr.size =3D sizeof(msg.payload.inflight),
>      };
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +    if (!vhost_user_has_protocol_feature(
> +            dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
>          return 0;
>      }
>
> @@ -2751,8 +2757,8 @@ static int vhost_user_set_inflight_fd(struct vhost_=
dev *dev,
>          .hdr.size =3D sizeof(msg.payload.inflight),
>      };
>
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
> +    if (!vhost_user_has_protocol_feature(
> +            dev, VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD)) {
>          return 0;
>      }
>
> @@ -2851,8 +2857,7 @@ void vhost_user_async_close(DeviceState *d,
>
>  static int vhost_user_dev_start(struct vhost_dev *dev, bool started)
>  {
> -    if (!virtio_has_feature(dev->protocol_features,
> -                            VHOST_USER_PROTOCOL_F_STATUS)) {
> +    if (!vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STAT=
US)) {
>          return 0;
>      }
>
> @@ -2877,16 +2882,15 @@ static void vhost_user_reset_status(struct vhost_=
dev *dev)
>          return;
>      }
>
> -    if (virtio_has_feature(dev->protocol_features,
> -                           VHOST_USER_PROTOCOL_F_STATUS)) {
> +    if (vhost_user_has_protocol_feature(dev, VHOST_USER_PROTOCOL_F_STATU=
S)) {
>          vhost_user_set_status(dev, 0);
>      }
>  }
>
>  static bool vhost_user_supports_device_state(struct vhost_dev *dev)
>  {
> -    return virtio_has_feature(dev->protocol_features,
> -                              VHOST_USER_PROTOCOL_F_DEVICE_STATE);
> +    return vhost_user_has_protocol_feature(
> +        dev, VHOST_USER_PROTOCOL_F_DEVICE_STATE);
>  }
>
>  static int vhost_user_set_device_state_fd(struct vhost_dev *dev,
> --
> 2.48.1
>

